Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC47C2BA83
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 11:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5352072D
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 11:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581764473;
	bh=CYHUYC9znSkDx9AkdYAavRlIybR7HFtSAc8E03/YggI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=VCOnDektyLhTkU01TqbBe3ySXw2PvJTt1dYFx11fa6G6mljM2XbMh5K/Hkeh61+c8
	 1VkGr3E7jsVaMakU2bI/R/HIjswCQiU5QXBX7UlLH+iFaXLs7qg5r09x4S7y0hfh3W
	 rEPy6fvadQzkfZyh498GhHi2MgVFIs18A3vj/Dgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgBOLBN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 15 Feb 2020 06:01:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgBOLBN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 15 Feb 2020 06:01:13 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3E4F20726;
        Sat, 15 Feb 2020 11:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581764472;
        bh=CYHUYC9znSkDx9AkdYAavRlIybR7HFtSAc8E03/YggI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=efF9z0IfIssJiuUVvKlrkQzEwy4dAyiMXX1G28JjgXimyXKX72f6fexxhIQjfoTeY
         N1BPd//PD+FxMPX1kA6fdfEJ54JvCKMx10KcYdCMCMiCmyejFN3Mt23wEkjkUA2CHG
         FHeS6BXCPu4Px88vmCs97pfGZxQm3WojXqd3Cdco=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 112943520CAA; Sat, 15 Feb 2020 03:01:11 -0800 (PST)
Date:   Sat, 15 Feb 2020 03:01:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH tip/core/rcu 22/30] rcu: Don't flag non-starting GPs
 before GP kthread is running
Message-ID: <20200215110111.GZ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
 <20200214235607.13749-22-paulmck@kernel.org>
 <20200214225305.48550d6a@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214225305.48550d6a@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 14, 2020 at 10:53:05PM -0500, Steven Rostedt wrote:
> On Fri, 14 Feb 2020 15:55:59 -0800
> paulmck@kernel.org wrote:
> 
> > @@ -1252,10 +1252,10 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
> >   */
> >  static void rcu_gp_kthread_wake(void)
> >  {
> > -	if ((current == rcu_state.gp_kthread &&
> > +	if ((current == READ_ONCE(rcu_state.gp_kthread) &&
> >  	     !in_irq() && !in_serving_softirq()) ||
> >  	    !READ_ONCE(rcu_state.gp_flags) ||
> > -	    !rcu_state.gp_kthread)
> > +	    !READ_ONCE(rcu_state.gp_kthread))
> >  		return;
> 
> This looks buggy. You have two instances of
> READ_ONCE(rcu_state.gp_thread), which means they can be different. Is
> that intentional?

It might well be a bug, but let's see...

The rcu_state.gp_kthread field is initially NULL and transitions only once
to the non-NULL pointer to the RCU grace-period kthread's task_struct
structure.  So yes, this does work, courtesy of the compiler not being
allowed to change the order of READ_ONCE() instances and conherence-order
rules for READ_ONCE() and WRITE_ONCE().

But it would clearly be way better to do just one READ_ONCE() into a
local variable and test that local variable twice.

I will make this change, and thank you for calling my attention to it!

						Thanx, Paul
