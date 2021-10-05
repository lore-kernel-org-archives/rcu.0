Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201BDC433EF
	for <rcu@archiver.kernel.org>; Tue,  5 Oct 2021 20:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B066137C
	for <rcu@archiver.kernel.org>; Tue,  5 Oct 2021 20:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhJEU5D (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhJEU5D (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Oct 2021 16:57:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2D3C6121F;
        Tue,  5 Oct 2021 20:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633467312;
        bh=5DI92K8fU187OIQjppmogTi3if+UJLwQEk5wETuGMUI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=osV4iGT9Q4LGi3G+M3FepkWV80kaG6XR0KANRzwcGqAltSsP7pxfyxrsLK4MDWxo8
         4YK4xmj8F1+cI1nGuM/yvJY5i+FLoLGIF/wWYkVnf9V6pYHCK2wtF1ipAr3665PQct
         JSXlpJC76AuIWJ4vCwRweMqnj4AILxf8CkQq67lrDkOPyUkz7u8EElFvRQ5/r5lkEL
         nj6QUmEqBvvGGpy0Uvm1GZjz1hoVkEwxMAWRnpSuFZgGvURYeQfdeEeSTGeFim7yCn
         nB2C4yCK9MBS6z4Uq1DLMGxgEyXeMDWebbzvVcW+QFjMNg/sLcGjtcpvwV4gnJ5nQp
         y59oBQDEIeq9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BBFD65C0921; Tue,  5 Oct 2021 13:55:11 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:55:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 08/11] rcu/nocb: Limit number of softirq callbacks only
 on softirq
Message-ID: <20211005205511.GY880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210929221012.228270-1-frederic@kernel.org>
 <20210929221012.228270-9-frederic@kernel.org>
 <877dewmy5v.mognet@arm.com>
 <20211004134227.GC273854@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004134227.GC273854@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 04, 2021 at 03:42:27PM +0200, Frederic Weisbecker wrote:
> On Fri, Oct 01, 2021 at 06:51:08PM +0100, Valentin Schneider wrote:
> > On 30/09/21 00:10, Frederic Weisbecker wrote:
> > > The current condition to limit the number of callbacks executed in a
> > > row checks the offloaded state of the rdp. Not only is it volatile
> > > but it is also misleading: the rcu_core() may well be executing
> > > callbacks concurrently with NOCB kthreads, and the offloaded state
> > > would then be verified on both cases. As a result the limit would
> > > spuriously not apply anymore on softirq while in the middle of
> > > (de-)offloading process.
> > >
> > > Another issue with the condition is that rcu_is_callbacks_kthread()
> > > doesn't check if we are actually running callbacks from rcuc itself or
> > > from a softirq interrupting rcuc.
> > >
> > 
> > Doesn't rcutree.use_softirq imply rcuc is never woken, in which case
> > RCU_SOFTIRQ can't interrupt rcuc (e.g. while run atop an IRQ exit)?
> > I suppose during the (de)offload sequence we could have RCU_SOFTIRQ running
> > atop the NOCB CB kthread, but that's not something
> > rcu_is_callbacks_kthread() detects.
> 
> Yes good point, I don't know if rcuc can be ever be interrupted by
> irq_exit() -> do_softirq() -> rcu_core() itself after all.
> 
> Paul can probably confirm your point?

This is supposed to be prohibited by the fact that rcutree.use_softirq
prevents the rcuc kthreads from being spawned in the first place.

That said, I do not recall having thought through the de-offloading
process with the rcuc kthreads in mind.  There could easily be bugs
in this case.  (I -think- that it is OK because each rcuc kthread is
confined to running on the corresponding CPU and because it disables BH.
But it is the system's opinion that counts.)

> > Also, why is rcu_is_callbacks_kthread() hardcoded to false for
> > !CONFIG_RCU_BOOST? Isn't it relevant for do_rcu_batch() ratelimiting
> > regardless (at least before your patches)?
> 
> I believe rcuc is only used on CONFIG_RCU_BOOST?

They are independent, though by default RT arranges for rcuc kthreads and
CONFIG_RCU_BOOST.  Now there are kthreads created for CONFIG_RCU_BOOST,
but these are the rcub kthreads, and they are not per CPU, but rather
per leaf rcu_node structure.

							Thanx, Paul
