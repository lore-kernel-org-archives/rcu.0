Return-Path: <SRS0=L9Fg=CQ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA09C43461
	for <rcu@archiver.kernel.org>; Mon,  7 Sep 2020 02:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C3120C09
	for <rcu@archiver.kernel.org>; Mon,  7 Sep 2020 02:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599446037;
	bh=o7qvPOSfMWTGqMHowfFYfViqaDWC187qZJ6j1AbNTfY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=eBDaWUm4rVEudBnf5QAKcy0cVDK7o2Tsnbv7eP+g6yw5x7fTCaWNEdYk29w02Bquv
	 qU/aMPj8+DcNAlsa+kB7wKW5O5p72vOm4okghLftCNyCEbWe12rR2N8K6tKT4GO5C8
	 JSHLuLr3odrnw+TCktxlPVqhzjpN+RA8jGaKn3IA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgIGCd5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 6 Sep 2020 22:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgIGCdy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 6 Sep 2020 22:33:54 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C153A20796;
        Mon,  7 Sep 2020 02:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599446032;
        bh=o7qvPOSfMWTGqMHowfFYfViqaDWC187qZJ6j1AbNTfY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sxuWTh2MHeSTHL1uB+5HQsgi9/YP+FKoYBSLQp5xmoimKY+XPtGbEt87dAc2QSyg7
         QcAx/Chacb/xEeccjnqDxKe1uqdpr3cXhbp5jxJ0Q3phnBjhWkODhFYaPUuwHQeWIM
         zc/HM3s/LNiFolgo+63zIa6FOU60udkx39+ZDlXI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8865E3522EE5; Sun,  6 Sep 2020 19:33:52 -0700 (PDT)
Date:   Sun, 6 Sep 2020 19:33:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 05/13] rcu: Always set .need_qs from
 __rcu_read_lock() for strict GPs
Message-ID: <20200907023352.GZ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
 <20200831181120.1044-5-paulmck@kernel.org>
 <20200904040534.GD7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200904134142.GB29330@paulmck-ThinkPad-P72>
 <20200907001155.GG7503@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907001155.GG7503@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 07, 2020 at 08:11:55AM +0800, Boqun Feng wrote:
> On Fri, Sep 04, 2020 at 06:41:42AM -0700, Paul E. McKenney wrote:
> > On Fri, Sep 04, 2020 at 12:05:34PM +0800, Boqun Feng wrote:
> > > Hi Paul,
> > > 
> > > On Mon, Aug 31, 2020 at 11:11:12AM -0700, paulmck@kernel.org wrote:
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > 
> > > > The ->rcu_read_unlock_special.b.need_qs field in the task_struct
> > > > structure indicates that the RCU core needs a quiscent state from the
> > > > corresponding task.  The __rcu_read_unlock() function checks this (via
> > > > an eventual call to rcu_preempt_deferred_qs_irqrestore()), and if set
> > > > reports a quiscent state immediately upon exit from the outermost RCU
> > > > read-side critical section.
> > > > 
> > > > Currently, this flag is only set when the scheduling-clock interrupt
> > > > decides that the current RCU grace period is too old, as in about
> > > > one full second too old.  But if the kernel has been built with
> > > > CONFIG_RCU_STRICT_GRACE_PERIOD=y, we clearly do not want to wait that
> > > > long.  This commit therefore sets the .need_qs field immediately at the
> > > > start of the RCU read-side critical section from within __rcu_read_lock()
> > > > in order to unconditionally enlist help from __rcu_read_unlock().
> > > > 
> > > 
> > > So why not make rcu_preempt_deferred_qs_irqrestore() always treat
> > > need_qs is true if CONFIG_RCU_STRICT_GRACE_PERIOD = y? IOW:
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 982fc5be5269..2a9f31545453 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -449,6 +449,8 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> > >  	 * t->rcu_read_unlock_special cannot change.
> > >  	 */
> > >  	special = t->rcu_read_unlock_special;
> > > +	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) && rcu_state.gp_kthread)
> > > +		special.b.need_qs = true;
> > >  	rdp = this_cpu_ptr(&rcu_data);
> > >  	if (!special.s && !rdp->exp_deferred_qs) {
> > >  		local_irq_restore(flags);
> > > 
> > > , and in this way, you can save one store for each rcu_read_lock() ;-)
> > 
> > Because unless I am missing something subtle, if the .need_qs
> > flag is not set, execution is not guaranteed to reach
> > rcu_preempt_deferred_qs_irqrestore().
> 
> Fair enough. Although I think we can also add IS_ENABLED(...) check to
> make the outermost rcu_read_unlock() to call rcu_read_unlock_special()
> unconditionally, but that's too much I think.

You are quite right that there are several ways to make this
work.  So yes, one alternative would be the IS_ENABLED() check in
rcu_read_unlock() in conjunction with your suggested added check in
rcu_preempt_deferred_qs_irqrestore().  But from what I know at the moment,
the current state is favored.  Smaller change and all that.

							Thanx, Paul

> Regards,
> Boqun
> 
> > 							Thanx, Paul
> > 
> > > Regards,
> > > Boqun
> > > 
> > > > But note the additional check for rcu_state.gp_kthread, which prevents
> > > > attempts to awaken RCU's grace-period kthread during early boot before
> > > > there is a scheduler.  Leaving off this check results in early boot hangs.
> > > > So early that there is no console output.  Thus, this additional check
> > > > fails until such time as RCU's grace-period kthread has been created,
> > > > avoiding these empty-console hangs.
> > > > 
> > > > Reported-by Jann Horn <jannh@google.com>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  kernel/rcu/tree_plugin.h | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index 44cf77d..668bbd2 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -376,6 +376,8 @@ void __rcu_read_lock(void)
> > > >  	rcu_preempt_read_enter();
> > > >  	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
> > > >  		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
> > > > +	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) && rcu_state.gp_kthread)
> > > > +		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
> > > >  	barrier();  /* critical section after entry code. */
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(__rcu_read_lock);
> > > > -- 
> > > > 2.9.5
> > > > 
