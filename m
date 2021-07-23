Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFDBC4338F
	for <rcu@archiver.kernel.org>; Fri, 23 Jul 2021 19:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B8060200
	for <rcu@archiver.kernel.org>; Fri, 23 Jul 2021 19:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhGWSZo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhGWSZl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 23 Jul 2021 14:25:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43F2B60200;
        Fri, 23 Jul 2021 19:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627067174;
        bh=ZKlkvUuhRCN4OB5kxnUKclEDFAY0+mXED6J9+T5IWKI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bXPC1IbUYML887w//bLEwUrpPc2m4Cewqw666xbmFSjtbscBAS1gezvMhTq93dpD1
         elOnPbeIj/q7/lIRjOnhF8k76GK0GL/eN32fjkIdaQyhGRMT+qmgYR6zaH/UHkMX8N
         kpVynME+u0NWbM7iIs8tCNNZbsZFoY6zHwSYtTPUiQPdCPa4wMtP7/o42fq1nWkhgg
         HnF9Q99/+EXJExnWga8yrVneKxcOpsjxfmxMvOuGeKUXOLT/H4x0HcVSKcwPs/jlXH
         NzKVLaD7vOJDmT+6bdIKzvhSiG4cmyOJAsluV6/i0ykpObg41/RNqD+UI2+Iv/Nd09
         e5YB5wi7RnPMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0DAAB5C068F; Fri, 23 Jul 2021 12:06:14 -0700 (PDT)
Date:   Fri, 23 Jul 2021 12:06:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     donghai qiao <donghai.w.qiao@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org
Subject: Re: RCU: rcu stall issues and an approach to the fix
Message-ID: <20210723190614.GJ4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAOzhvcPb=NMCHCqyDiyWiX9DjR=RXgdQRfJDkJOdazugHe7+Zw@mail.gmail.com>
 <YPoNgcLgJY/POS4u@boqun-archlinux>
 <20210723034928.GE4397@paulmck-ThinkPad-P17-Gen-1>
 <CAOzhvcOLFzFGZAptOTrP9Xne1-LiO8jka1sPF6+0=WiLh-cQUA@mail.gmail.com>
 <20210723172512.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <CAOzhvcMaTsJTS3y1FVtSOpXfG8EecYp8bKOQ0KOjCOKYJ-UerA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzhvcMaTsJTS3y1FVtSOpXfG8EecYp8bKOQ0KOjCOKYJ-UerA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 23, 2021 at 02:41:20PM -0400, donghai qiao wrote:
> On Fri, Jul 23, 2021 at 1:25 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Jul 23, 2021 at 12:20:41PM -0400, donghai qiao wrote:
> > > On Thu, Jul 22, 2021 at 11:49 PM Paul E. McKenney <paulmck@kernel.org>
> > > wrote:
> > >
> > > > On Fri, Jul 23, 2021 at 08:29:53AM +0800, Boqun Feng wrote:
> > > > > On Thu, Jul 22, 2021 at 04:08:06PM -0400, donghai qiao wrote:
> > > > > > RCU experts,
> > > > > >
> > > > > > When you reply, please also keep me CC'ed.
> > > > > >
> > > > > > The problem of RCU stall might be an old problem and it can happen
> > > > quite often.
> > > > > > As I have observed, when the problem occurs,  at least one CPU in the
> > > > system
> > > > > > on which its rdp->gp_seq falls behind others by 4 (qs).
> > > > > >
> > > > > > e.g.  On CPU 0, rdp->gp_seq = 0x13889d, but on other CPUs, their
> > > > > > rdp->gp_seq = 0x1388a1.
> > > > > >
> > > > > > Because RCU stall issues can last a long period of time, the number of
> > > > callbacks
> > > > > > in the list rdp->cblist of all CPUs can accumulate to thousands. In
> > > > > > the worst case,
> > > > > > it triggers panic.
> > > > > >
> > > > > > When looking into the problem further, I'd think the problem is
> > > > related to the
> > > > > > Linux scheduler. When the RCU core detects the stall on a CPU,
> > > > rcu_gp_kthread
> > > > > > would send a rescheduling request via send_IPI to that CPU to try to
> > > > force a
> > > > > > context switch to make some progress. However, at least one situation
> > > > can fail
> > > > > > this effort, which is when the CPU is running a user thread and it is
> > > > the only
> > > > > > user thread in the rq, then this attempted context switching will not
> > > > happen
> > > > > > immediately. In particular if the system is also configured with
> > > > NOHZ_FULL for
> > > > >
> > > > > Correct me if I'm wrong, if a CPU is solely running a user thread, how
> > > > > can that CPU stall RCU? Because you need to be in a RCU read-side
> > > > > critical section to stall RCU. Or the problem you're talking here is
> > > > > about *recovering* from RCU stall?
> > >
> > > In response to Boqun's question, the crashdumps I analyzed were configured
> > > with this :
> > >
> > > CONFIG_PREEMPT_RCU=n
> > > CONFIG_PREEMPT_COUNT=n
> > > CONFIG_PROVE_RCU=n
> > >
> > > Because these configurations were not enabled, the compiler generated empty
> > > binary code for functions rcu_read_lock() and rcu_read_unlock() which
> > > delimit rcu read-side critical sections. And the crashdump showed both
> > > functions have no binary code in the kernel module and I am pretty sure.
> >
> > Agreed, that is expected behavior.
> >
> > > In the first place I thought this kernel might be built the wrong way,
> > > but later I found other sources that said this was ok.  That's why when
> > > CPUs enter or leave rcu critical section, the rcu core
> > > is not informed.
> >
> > If RCU core was informed every time that a CPU entered or left an RCU
> > read-side critical section, performance and scalability would be
> > abysmal.  So yes, this interaction is very arms-length.
> 
> Thanks for confirming that.
> 
> > > When the current grace period is closed, rcu_gp_kthread will open a new
> > > period for all. This will be reflected from every
> > > CPU's rdp->gp_seq. Every CPU is responsible to update its own gp when a
> > > progress is made. So when a cpu is running
> > > a user thread whilst a new period is open, it can not update its rcu unless
> > > a context switch occurs or upon a sched tick.
> > > But if a CPU is configured as NOHZ, this will be a problem to RCU, so rcu
> > > stall will happen.
> >
> > Except that if a CPU is running in nohz_full mode, each transition from
> > kernel to user execution must invoke rcu_user_enter() and each transition
> > back must invoke rcu_user_exit().  These update RCU's per-CPU state, which
> > allows RCU's grace-period kthread ("rcu_sched" in this configuration)
> > to detect even momentary nohz_full usermode execution.
> 
> Yes, agreed.
> 
> > You can check this in your crash dump by looking at the offending CPU's
> > rcu_data structure's ->dynticks field and comparing to the activities
> > of rcu_user_enter().
> 
> On the rcu stalled CPU, its rdp->dynticks is far behind others. In the crashdump
> I examined, stall happened on CPU 0,  its dynticks is 0x6eab02, but dynticks on
> other CPUs are 0x82c192, 0x72a3b6, 0x880516 etc..

That is expected behavior for a CPU running nohz_full user code for an
extended time period.  RCU is supposed to leave that CPU strictly alone,
after all.  ;-)

> > > When RCU detects that qs is stalled on a CPU, it tries to force a context
> > > switch to make progress on that CPU. This is
> > > done through a resched IPI. But this can not always succeed depending on
> > > the scheduler.   A while ago, this code
> > > process the resched IPI:
> > >
> > > void scheduler_ipi(void)
> > > {
> > >         ...
> > >         if (llist_empty(&this_rq()->wake_list) && !got_nohz_idle_kick())
> > >                 return;
> > >         ...
> > >         irq_enter();
> > >         sched_ttwu_pending();
> > >         ...
> > >         if (unlikely(got_nohz_idle_kick())) {
> > >                 this_rq()->idle_balance = 1;
> > >                 raise_softirq_irqoff(SCHED_SOFTIRQ);
> > >         }
> > >         irq_exit();
> > > }
> > >
> > > As you can see the function returns from the first "if statement" before it
> > > can issue a SCHED_SOFTIRQ. Later this
> > > code has been changed, but similar check/optimization remains in many
> > > places in the scheduler. The things I try to
> > > fix are those that resched_cpu fails to do.
> >
> > ???  Current mainline has this instead:
> >
> > static __always_inline void scheduler_ipi(void)
> > {
> >         /*
> >          * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
> >          * TIF_NEED_RESCHED remotely (for the first time) will also send
> >          * this IPI.
> >          */
> >         preempt_fold_need_resched();
> > }
> 
> This function was changed a year ago in the upstream kernel. But this
> is not the only
> code that fails the request of resched from rcu.  The scheduler is
> optimized to avoid
> context switching which it thinks is unnecessary over the years.

But RCU shouldn't get to the point where it would invoke resched_cpu().
Instead, it should see that CPU's rdp->dynticks value and report a
quiescent state on that CPU's behalf.  See the rcu_implicit_dynticks_qs()
function and its callers.

> > Combined with the activities of resched_curr(), which is invoked
> > from resched_cpu(), this should force a call to the scheduler on
> > the return path from this IPI.
> >
> > So what kernel version are you using?
> 
> The crashdumps I have examined were generated from 4.18.0-269 which is rhel-8.4.
> But this problem is reproducible on fedora 34 and the latest upstream kernel,
> however, I don't have a crashdump of that kind right now.

Interesting.  Are those systems doing anything unusual?  Long-running
interrupts, CPU-hotplug operations, ... ?

> > Recent kernels have logic to enable the tick on nohz_full CPUs that are
> > slow to supply RCU with a quiescent state, but this should happen only
> > when such CPUs are spinning in kernel mode.  Again, usermode execution
> > is dealt with by rcu_user_enter().
> 
> That also reflected why the CPU was running a user thread when the RCU stall
> was detected.  So I guess something should be done for this case.

You lost me on this one.  Did the rdp->dynticks value show that the
CPU was in an extended quiescent state?

							Thanx, Paul

> > > Hope this explains it.
> > > Donghai
> > >
> > >
> > > > Excellent point, Boqun!
> > > >
> > > > Donghai, have you tried reproducing this using a kernel built with
> > > > CONFIG_RCU_EQS_DEBUG=y?
> > > >
> > >
> > > I can give this configuration a try. Will let you know the results.
> >
> > This should help detect any missing rcu_user_enter() or rcu_user_exit()
> > calls.
> 
> Got it.
> 
> Thanks
> Donghai
> 
> >
> >                                                         Thanx, Paul
> >
> > > Thanks.
> > > Donghai
> > >
> > >
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > > Regards,
> > > > > Boqun
> > > > >
> > > > > > the CPU and as long as the user thread is running, the forced context
> > > > > > switch will
> > > > > > never happen unless the user thread volunteers to yield the CPU. I
> > > > think this
> > > > > > should be one of the major root causes of these RCU stall issues. Even
> > > > if
> > > > > > NOHZ_FULL is not configured, there will be at least 1 tick delay which
> > > > can
> > > > > > affect the realtime kernel, by the way.
> > > > > >
> > > > > > But it seems not a good idea to craft a fix from the scheduler side
> > > > because
> > > > > > this has to invalidate some existing scheduling optimizations. The
> > > > current
> > > > > > scheduler is deliberately optimized to avoid such context switching.
> > > > So my
> > > > > > question is why the RCU core cannot effectively update qs for the
> > > > stalled CPU
> > > > > > when it detects that the stalled CPU is running a user thread?  The
> > > > reason
> > > > > > is pretty obvious because when a CPU is running a user thread, it must
> > > > not
> > > > > > be in any kernel read-side critical sections. So it should be safe to
> > > > close
> > > > > > its current RCU grace period on this CPU. Also, with this approach we
> > > > can make
> > > > > > RCU work more efficiently than the approach of context switch which
> > > > needs to
> > > > > > go through an IPI interrupt and the destination CPU needs to wake up
> > > > its
> > > > > > ksoftirqd or wait for the next scheduling cycle.
> > > > > >
> > > > > > If my suggested approach makes sense, I can go ahead to fix it that
> > > > way.
> > > > > >
> > > > > > Thanks
> > > > > > Donghai
> > > >
