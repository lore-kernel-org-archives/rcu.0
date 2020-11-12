Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804B7C4742C
	for <rcu@archiver.kernel.org>; Thu, 12 Nov 2020 01:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E85206F1
	for <rcu@archiver.kernel.org>; Thu, 12 Nov 2020 01:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yuHOwueL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgKLBdv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbgKLALb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Nov 2020 19:11:31 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61F942072C;
        Thu, 12 Nov 2020 00:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605139890;
        bh=UUizPUi+5E2gGhUXhujEXQx6cSOfSopZTLC533nokJc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yuHOwueLPRh7XYhg7N1PKfNbkkla0wA87gc4bZSptoORGlluEdo8F9NTTrSZWIzMo
         fHJ3yLY04gmvNPf6eJmTpLkx2nSegrutBXIErzzSaaC/0mcw/APa0Ex+jXitD37e7N
         IaCO7rVaSLzEPVRe268SIRGIEi5tJ14Tj4E2Nfuw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F0BFF352287B; Wed, 11 Nov 2020 16:11:29 -0800 (PST)
Date:   Wed, 11 Nov 2020 16:11:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without
 allocations
Message-ID: <20201112001129.GD3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201110135320.3309507-1-elver@google.com>
 <CADYN=9+=-ApMi_eEdAeHU6TyuQ7ZJSTQ8F-FCSD33kZH8HR+xg@mail.gmail.com>
 <CANpmjNM8MZphvkTSo=KgCBXQ6fNY4qo6NZD5SBHjNse_L9i5FQ@mail.gmail.com>
 <20201111133813.GA81547@elver.google.com>
 <20201111130543.27d29462@gandalf.local.home>
 <20201111182333.GA3249@paulmck-ThinkPad-P72>
 <20201111183430.GN517454@elver.google.com>
 <20201111192123.GB3249@paulmck-ThinkPad-P72>
 <20201111202153.GT517454@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111202153.GT517454@elver.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 11, 2020 at 09:21:53PM +0100, Marco Elver wrote:
> On Wed, Nov 11, 2020 at 11:21AM -0800, Paul E. McKenney wrote:
> [...]
> > > >     rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled
> > > 
> > > Sadly, no, next-20201110 already included that one, and that's what I
> > > tested and got me all those warnings above.
> > 
> > Hey, I had to ask!  The only uncertainty I seee is the acquisition of
> > the lock in rcu_iw_handler(), for which I add a lockdep check in the
> > (untested) patch below.  The other thing I could do is sprinkle such
> > checks through the stall-warning code on the assumption that something
> > RCU is calling is enabling interrupts.
> > 
> > Other thoughts?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 70d48c5..3d67650 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -189,6 +189,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
> >  
> >  	rdp = container_of(iwp, struct rcu_data, rcu_iw);
> >  	rnp = rdp->mynode;
> > +	lockdep_assert_irqs_disabled();
> >  	raw_spin_lock_rcu_node(rnp);
> >  	if (!WARN_ON_ONCE(!rdp->rcu_iw_pending)) {
> >  		rdp->rcu_iw_gp_seq = rnp->gp_seq;
> 
> This assert didn't fire yet, I just get more of the below. I'll keep
> rerunning, but am not too hopeful...

Is bisection a possibility?

Failing that, please see the updated patch below.  This adds a few more
calls to lockdep_assert_irqs_disabled(), but perhaps more helpfully dumps
the current stack of the CPU that the RCU grace-period kthread wants to
run on in the case where this kthread has been starved of CPU.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 70d48c5..d203ea0 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -189,6 +189,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
 
 	rdp = container_of(iwp, struct rcu_data, rcu_iw);
 	rnp = rdp->mynode;
+	lockdep_assert_irqs_disabled();
 	raw_spin_lock_rcu_node(rnp);
 	if (!WARN_ON_ONCE(!rdp->rcu_iw_pending)) {
 		rdp->rcu_iw_gp_seq = rnp->gp_seq;
@@ -449,21 +450,32 @@ static void print_cpu_stall_info(int cpu)
 /* Complain about starvation of grace-period kthread.  */
 static void rcu_check_gp_kthread_starvation(void)
 {
+	int cpu;
 	struct task_struct *gpk = rcu_state.gp_kthread;
 	unsigned long j;
 
 	if (rcu_is_gp_kthread_starving(&j)) {
+		cpu = gpk ? task_cpu(gpk) : -1;
 		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
 		       data_race(rcu_state.gp_flags),
 		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
-		       gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
+		       gpk ? gpk->state : ~0, cpu);
 		if (gpk) {
 			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
+			lockdep_assert_irqs_disabled();
 			sched_show_task(gpk);
+			lockdep_assert_irqs_disabled();
+			if (cpu >= 0) {
+				pr_err("Stack dump where RCU grace-period kthread last ran:\n");
+				if (!trigger_single_cpu_backtrace(cpu))
+					dump_cpu_task(cpu);
+			}
+			lockdep_assert_irqs_disabled();
 			wake_up_process(gpk);
+			lockdep_assert_irqs_disabled();
 		}
 	}
 }
