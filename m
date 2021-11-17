Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1733C433EF
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 21:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0239613AD
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 21:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhKQVux (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 16:50:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232181AbhKQVuw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 16:50:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82108613AD;
        Wed, 17 Nov 2021 21:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637185673;
        bh=kLkfTlvrqGRbU1w5w7zblh6Veq0WsVN2OZY57ZzU2J4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/eGn/xvkYoJL/5Luj/WNDm6MuQK257DXIwzeOIgK/d3qAl3ly8X5xNjxWTRUnAfn
         p6swCcspIlg2z3G6u52irgxRp/MGU8oiPj4qzN9YE7APkKPaUA4quJpVHcP0RlZUvf
         dmfFjHu5Eny5kwV0yebjWXdldWW7KzWQqW5AuE5WAiFtlZQPZ/b+hCJIdfkrIrtMUm
         HoO6WFbnYk8dOqOFxez9NStIdxdTzpXKn/fkNkNJxsIVSpXaEFIqV2LiaBByQfKQ6U
         QImMIZELdyy+4AeLJf9EN8PSHebfN4pxj8VV/95RpPHd59Ro+WveKaNQb9djQsf+0T
         Uvv1JFBhglqmQ==
Date:   Wed, 17 Nov 2021 22:47:50 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 1/6] rcu/nocb: Remove rdp from nocb list when de-offloaded
Message-ID: <20211117214750.GA365507@lothringen>
References: <20211117155637.363706-1-frederic@kernel.org>
 <20211117155637.363706-2-frederic@kernel.org>
 <20211117185341.GJ641268@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117185341.GJ641268@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 17, 2021 at 10:53:41AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 17, 2021 at 04:56:32PM +0100, Frederic Weisbecker wrote:
> >  	pr_info("Offloading %d\n", rdp->cpu);
> > +
> > +	/*
> > +	 * Iterate this CPU on nocb_gp_wait(). We do it before locking nocb_gp_lock,
> > +	 * resetting nocb_gp_sleep and waking up the related "rcuog". Since nocb_gp_wait()
> > +	 * in turn locks nocb_gp_lock before setting nocb_gp_sleep again, we are guaranteed
> > +	 * to iterate this new rdp before "rcuog" goes to sleep again.
> 
> Just to make sure that I understand...
> 
> The ->nocb_entry_rdp list is RCU-protected, with an odd flavor of RCU.
> The list_add_tail_rcu() handles list insertion.  For list deletion,
> on the one hand, the rcu_data structures are never freed, so their
> lifetime never ends.  But one could be removed during an de-offloading
> operation, then re-added by a later offloading operation.  It would be
> bad if a reader came along for that ride because that reader would end
> up skipping all the rcu_data structures that were in the list after the
> initial position of the one that was removed and added back.

How did I miss that :-(

> 
> The trick seems to be that the de-offloading process cannot complete
> until the relevant rcuog kthread has acknowledged the de-offloading,
> which it cannot do until it has completed the list_for_each_entry_rcu()
> loop.  And the rcuog kthread is the only thing that traverses the list,
> except for the show_rcu_nocb_state() function, more on which later.
> 
> Therefore, it is not possible for the rcuog kthread to come along for
> that ride.

Actually it's worse than that: the node is removed _after_ the kthread
acknowledges deoffloading and added _before_ the kthread acknowledges
offloading. So a single rcuog loop can well run through a deletion/re-add
pair altogether.

Now since we force another loop with the new add guaranteed visible, the new
loop should handle the missed rdp's that went shortcut by the race.

Let's hope I'm not missing something else... And yes that definetly needs
a fat comment.

> 
> On to show_rcu_nocb_state()...
> 
> This does not actually traverse the list, but instead looks at the ->cpu
> field of the next structure.  Because the ->next pointer is never NULLed,
> the worst that can happen is that a confusing ->cpu field is printed,
> for example, the one that was in effect prior to the de-offloading
> operation.  But that number would have been printed anyway had the
> show_rcu_nocb_state() function not been delayed across the de-offloading
> and offloading.
> 
> So no harm done.

Exactly, that part is racy by nature.

> 
> Did I get it right?  If so, the comment might need help.  If not,
> what am I missing?

You got it right!

Thanks!
