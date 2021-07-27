Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D5C4338F
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 22:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D15960F90
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 22:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhG0WfK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhG0WfJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jul 2021 18:35:09 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE5C061757
        for <rcu@vger.kernel.org>; Tue, 27 Jul 2021 15:35:08 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so90024otu.8
        for <rcu@vger.kernel.org>; Tue, 27 Jul 2021 15:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xoYEOy7vpjAzDGc5aPW/KpjEZlclaspNNPGW/2fCJs=;
        b=fOayVPoEOJZwisAln16LH1tJMiFBdzBRElk7fBw4ZdenQy72GREN4cXzOdpK9zh5aw
         Dxx776Th6QL5jMB/KOjrO4AzyMfy5tdv5lcZlVfhWns+aDaaoF+CMJfxBUC472N00Jdh
         wn9NgPw2sTiLpIjYMZPBrxaS8ktk8e6SsCYzi8GABUKeuz+nuGQUvSGoViMbdxv9ijwH
         eJOgj+larIKXjdSzCOE/+OW75ZYcnrX9ZVklYASdwXhvRqEnB8EJwhOTC0wyecptDcfP
         8yAjhE80CZSWrjpTJ1Y9CGPv+qe0cXUZvDfAfsiWOH/GhPeMgHkNH3lIZa3np4qWTg82
         iFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xoYEOy7vpjAzDGc5aPW/KpjEZlclaspNNPGW/2fCJs=;
        b=DYiOY6RdrikbnAAN8wzr4O6ZF7cNmtANI26/r5lrtGLFPwETt6AwpHBul1gMnmYLUi
         FWIo67IvPpkChhaL1nUlk8J/fepBp0CXHTCIfRsBLk9uQJZiYyiBRZPcaxIfwbmuJA11
         iWxlINqCT7EcsOvDHF23aIX36dMljZ98ABFMije5N8ZJ+aLTGqmPiNy0dsWJpKmsTwhX
         uP4zjZzzl0r8InDodomUE/ufRCLgiEjQivE6WB5mPJzsO7NLZ4lsOR3ULxhoETHCz5Y4
         0biYdcqz0Rj5SQHPin5QuvkEiihqOLZZ3b7P/fU1YXu99G77PrscpZODMXYW1R0pvbz5
         69Ow==
X-Gm-Message-State: AOAM531JR+O052BxFg9ZMUIkgdpG7qiiVWPfUufR5BMwYcIU1sR/EQGk
        lMriz/irX3Qry2lzfOtLRddjIE5aqMl5DNMBDl0=
X-Google-Smtp-Source: ABdhPJwUkdGe75RHXP5tTc8thksbpohxRt7qoFelCasAl3XETIIdnIUNuQado3Vi31FfyPlO6mxhIk2S1JaCRotBaBo=
X-Received: by 2002:a05:6830:128b:: with SMTP id z11mr17576565otp.124.1627425307673;
 Tue, 27 Jul 2021 15:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOzhvcPb=NMCHCqyDiyWiX9DjR=RXgdQRfJDkJOdazugHe7+Zw@mail.gmail.com>
 <YPoNgcLgJY/POS4u@boqun-archlinux> <20210723034928.GE4397@paulmck-ThinkPad-P17-Gen-1>
 <CAOzhvcOLFzFGZAptOTrP9Xne1-LiO8jka1sPF6+0=WiLh-cQUA@mail.gmail.com>
 <20210723172512.GH4397@paulmck-ThinkPad-P17-Gen-1> <CAOzhvcMaTsJTS3y1FVtSOpXfG8EecYp8bKOQ0KOjCOKYJ-UerA@mail.gmail.com>
 <20210723190614.GJ4397@paulmck-ThinkPad-P17-Gen-1> <CAOzhvcMwTzHSbrkPv9DXVAdUcddHEJazz_6p6tzXiJht43RMYg@mail.gmail.com>
 <20210725004823.GN4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210725004823.GN4397@paulmck-ThinkPad-P17-Gen-1>
From:   donghai qiao <donghai.w.qiao@gmail.com>
Date:   Tue, 27 Jul 2021 18:34:56 -0400
Message-ID: <CAOzhvcMcMY057uJNM9oMsKJubSpQ_yKwHtVEpJkATqumkNebXQ@mail.gmail.com>
Subject: Re: RCU: rcu stall issues and an approach to the fix
To:     paulmck@kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jul 24, 2021 at 8:48 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Jul 23, 2021 at 08:01:34PM -0400, donghai qiao wrote:
> > On Fri, Jul 23, 2021 at 3:06 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Fri, Jul 23, 2021 at 02:41:20PM -0400, donghai qiao wrote:
> > > > On Fri, Jul 23, 2021 at 1:25 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Fri, Jul 23, 2021 at 12:20:41PM -0400, donghai qiao wrote:
> > > > > > On Thu, Jul 22, 2021 at 11:49 PM Paul E. McKenney <paulmck@kernel.org>
> > > > > > wrote:
> > > > > >
> > > > > > > On Fri, Jul 23, 2021 at 08:29:53AM +0800, Boqun Feng wrote:
> > > > > > > > On Thu, Jul 22, 2021 at 04:08:06PM -0400, donghai qiao wrote:
> > > > > > > > > RCU experts,
> > > > > > > > >
> > > > > > > > > When you reply, please also keep me CC'ed.
> > > > > > > > >
> > > > > > > > > The problem of RCU stall might be an old problem and it can happen
> > > > > > > quite often.
> > > > > > > > > As I have observed, when the problem occurs,  at least one CPU in the
> > > > > > > system
> > > > > > > > > on which its rdp->gp_seq falls behind others by 4 (qs).
> > > > > > > > >
> > > > > > > > > e.g.  On CPU 0, rdp->gp_seq = 0x13889d, but on other CPUs, their
> > > > > > > > > rdp->gp_seq = 0x1388a1.
> > > > > > > > >
> > > > > > > > > Because RCU stall issues can last a long period of time, the number of
> > > > > > > callbacks
> > > > > > > > > in the list rdp->cblist of all CPUs can accumulate to thousands. In
> > > > > > > > > the worst case,
> > > > > > > > > it triggers panic.
> > > > > > > > >
> > > > > > > > > When looking into the problem further, I'd think the problem is
> > > > > > > related to the
> > > > > > > > > Linux scheduler. When the RCU core detects the stall on a CPU,
> > > > > > > rcu_gp_kthread
> > > > > > > > > would send a rescheduling request via send_IPI to that CPU to try to
> > > > > > > force a
> > > > > > > > > context switch to make some progress. However, at least one situation
> > > > > > > can fail
> > > > > > > > > this effort, which is when the CPU is running a user thread and it is
> > > > > > > the only
> > > > > > > > > user thread in the rq, then this attempted context switching will not
> > > > > > > happen
> > > > > > > > > immediately. In particular if the system is also configured with
> > > > > > > NOHZ_FULL for
> > > > > > > >
> > > > > > > > Correct me if I'm wrong, if a CPU is solely running a user thread, how
> > > > > > > > can that CPU stall RCU? Because you need to be in a RCU read-side
> > > > > > > > critical section to stall RCU. Or the problem you're talking here is
> > > > > > > > about *recovering* from RCU stall?
> > > > > >
> > > > > > In response to Boqun's question, the crashdumps I analyzed were configured
> > > > > > with this :
> > > > > >
> > > > > > CONFIG_PREEMPT_RCU=n
> > > > > > CONFIG_PREEMPT_COUNT=n
> > > > > > CONFIG_PROVE_RCU=n
> > > > > >
> > > > > > Because these configurations were not enabled, the compiler generated empty
> > > > > > binary code for functions rcu_read_lock() and rcu_read_unlock() which
> > > > > > delimit rcu read-side critical sections. And the crashdump showed both
> > > > > > functions have no binary code in the kernel module and I am pretty sure.
> > > > >
> > > > > Agreed, that is expected behavior.
> > > > >
> > > > > > In the first place I thought this kernel might be built the wrong way,
> > > > > > but later I found other sources that said this was ok.  That's why when
> > > > > > CPUs enter or leave rcu critical section, the rcu core
> > > > > > is not informed.
> > > > >
> > > > > If RCU core was informed every time that a CPU entered or left an RCU
> > > > > read-side critical section, performance and scalability would be
> > > > > abysmal.  So yes, this interaction is very arms-length.
> > > >
> > > > Thanks for confirming that.
> > > >
> > > > > > When the current grace period is closed, rcu_gp_kthread will open a new
> > > > > > period for all. This will be reflected from every
> > > > > > CPU's rdp->gp_seq. Every CPU is responsible to update its own gp when a
> > > > > > progress is made. So when a cpu is running
> > > > > > a user thread whilst a new period is open, it can not update its rcu unless
> > > > > > a context switch occurs or upon a sched tick.
> > > > > > But if a CPU is configured as NOHZ, this will be a problem to RCU, so rcu
> > > > > > stall will happen.
> > > > >
> > > > > Except that if a CPU is running in nohz_full mode, each transition from
> > > > > kernel to user execution must invoke rcu_user_enter() and each transition
> > > > > back must invoke rcu_user_exit().  These update RCU's per-CPU state, which
> > > > > allows RCU's grace-period kthread ("rcu_sched" in this configuration)
> > > > > to detect even momentary nohz_full usermode execution.
> > > >
> > > > Yes, agreed.
> > > >
> > > > > You can check this in your crash dump by looking at the offending CPU's
> > > > > rcu_data structure's ->dynticks field and comparing to the activities
> > > > > of rcu_user_enter().
> > > >
> > > > On the rcu stalled CPU, its rdp->dynticks is far behind others. In the crashdump
> > > > I examined, stall happened on CPU 0,  its dynticks is 0x6eab02, but dynticks on
> > > > other CPUs are 0x82c192, 0x72a3b6, 0x880516 etc..
> > >
> > > That is expected behavior for a CPU running nohz_full user code for an
> > > extended time period.  RCU is supposed to leave that CPU strictly alone,
> > > after all.  ;-)
> >
> > Yeah, this does happen if the CPU is enabled nohz_full. But I believe
> > I ever saw similar
> > situation on a nohz enabled CPU as well.  So shouldn't RCU close off
> > the gp for this CPU
> > rather than waiting ? That's the way I am thinking of fixing it.
>
> Yes, the same thing can happen if a CPU remains idle for a long time.
>
> > > > > > When RCU detects that qs is stalled on a CPU, it tries to force a context
> > > > > > switch to make progress on that CPU. This is
> > > > > > done through a resched IPI. But this can not always succeed depending on
> > > > > > the scheduler.   A while ago, this code
> > > > > > process the resched IPI:
> > > > > >
> > > > > > void scheduler_ipi(void)
> > > > > > {
> > > > > >         ...
> > > > > >         if (llist_empty(&this_rq()->wake_list) && !got_nohz_idle_kick())
> > > > > >                 return;
> > > > > >         ...
> > > > > >         irq_enter();
> > > > > >         sched_ttwu_pending();
> > > > > >         ...
> > > > > >         if (unlikely(got_nohz_idle_kick())) {
> > > > > >                 this_rq()->idle_balance = 1;
> > > > > >                 raise_softirq_irqoff(SCHED_SOFTIRQ);
> > > > > >         }
> > > > > >         irq_exit();
> > > > > > }
> > > > > >
> > > > > > As you can see the function returns from the first "if statement" before it
> > > > > > can issue a SCHED_SOFTIRQ. Later this
> > > > > > code has been changed, but similar check/optimization remains in many
> > > > > > places in the scheduler. The things I try to
> > > > > > fix are those that resched_cpu fails to do.
> > > > >
> > > > > ???  Current mainline has this instead:
> > > > >
> > > > > static __always_inline void scheduler_ipi(void)
> > > > > {
> > > > >         /*
> > > > >          * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
> > > > >          * TIF_NEED_RESCHED remotely (for the first time) will also send
> > > > >          * this IPI.
> > > > >          */
> > > > >         preempt_fold_need_resched();
> > > > > }
> > > >
> > > > This function was changed a year ago in the upstream kernel. But this
> > > > is not the only
> > > > code that fails the request of resched from rcu.  The scheduler is
> > > > optimized to avoid
> > > > context switching which it thinks is unnecessary over the years.
> > >
> > > But RCU shouldn't get to the point where it would invoke resched_cpu().
> > > Instead, it should see that CPU's rdp->dynticks value and report a
> > > quiescent state on that CPU's behalf.  See the rcu_implicit_dynticks_qs()
> > > function and its callers.
> >
> > What I was seeing in these crashdumps was that the rcu gp_kthread
> > invoked rcu_implicit_dynticks_qs() ---> resched_cpu()
> >
> > rcu_implicit_dynticks_qs()
> > {
> >         ......
> >         if (tick_nohz_full_cpu(rdp->cpu) && time_after(......) ) {
> >                   WRITE_ONCE(...);
> >                   resched_cpu(rdp->cpu);
> >                   WRITE_ONCE(...);
> >         }
> >
> >         if (time_after (...) {
> >                    if (time_aftr(...) {
> >                              resched_cpu(rdp->cpu);
> >                              ...
> >                    }
> >                    ...
> >          }
> >          return 0;
> > }
> >
> > The first time, resched_cpu() was invoked from the first "if
> > statement",  later, it was invoked
> > from the second "if statement".  But because the scheduler ignored
> > that resched request from
> > rcu due to optimization, nothing happened.
>
> I agree that this can happen.  However, it should not have happened
> in this case, because...
>
> > > > > Combined with the activities of resched_curr(), which is invoked
> > > > > from resched_cpu(), this should force a call to the scheduler on
> > > > > the return path from this IPI.
> > > > >
> > > > > So what kernel version are you using?
> > > >
> > > > The crashdumps I have examined were generated from 4.18.0-269 which is rhel-8.4.
> > > > But this problem is reproducible on fedora 34 and the latest upstream kernel,
> > > > however, I don't have a crashdump of that kind right now.
> > >
> > > Interesting.  Are those systems doing anything unusual?  Long-running
> > > interrupts, CPU-hotplug operations, ... ?
> >
> > Only some regular test suites. Nothing special was running. I believe no long
> > interrupts,  no CPU-hotplug. But I noticed that the console was outputting
> > some message via printk(), but the message was not too long.
> > >
> > > > > Recent kernels have logic to enable the tick on nohz_full CPUs that are
> > > > > slow to supply RCU with a quiescent state, but this should happen only
> > > > > when such CPUs are spinning in kernel mode.  Again, usermode execution
> > > > > is dealt with by rcu_user_enter().
> > > >
> > > > That also reflected why the CPU was running a user thread when the RCU stall
> > > > was detected.  So I guess something should be done for this case.
> > >
> > > You lost me on this one.  Did the rdp->dynticks value show that the
> > > CPU was in an extended quiescent state?
> >
> > The value of rdp->dynticks on the stalled CPU0  was 0x6eab02,
> > thus    rdp->dynticks & RCU_DYNTICK_CTRL_CTR != 0
> > so it was not in an extended qs (idle).
>
> And, assuming that this CPU was executing in nohz_full usermode, this
> is a bug.  If a CPU is in nohz_full usermode, then its rdp->dynticks
> field should have the RCU_DYNTICK_CTRL_CTR bit set to zero.
>
> The usual cause of this situation is that there is a path to
> or run nohz_full usermode that fails to call rcu_user_enter() or
> rcu_user_exit(), respectively.  Similar problems can arise if there is
> a path between nohz_full userspace and interrupt context that does not
> invoke rcu_irq_enter() (from userspace to interrupt) or rcu_irq_exit()
> (from interrupt back to userspace).
>
Yes, that's true.
Because I am dealing with this issue in multiple kernel versions, sometimes
the configurations in these kernels may different. Initially the
problem I described
originated to rhel-8 on which the problem occurs more often and is a bit easier
to reproduce than others.

Regarding these dynticks* parameters, I collected the data for CPU 0 as below :
   - dynticks = 0x6eab02    which indicated the CPU was not in eqs.
   - dynticks_nesting = 1    which is in its initial state, so it said
it was not in eqs either.
   - dynticks_nmi_nesting = 4000000000000004    which meant that this
CPU had been
     interrupted when it was in the middle of the first interrupt.
And this is true: the first
     interrupt was the sched_timer interrupt, and the second was a NMI
when another
    CPU detected the RCU stall on CPU 0.  So it looks all identical.
If the kernel missed
    a rcu_user_enter or rcu_user_exit, would these items remain
identical ?  But I'll
    investigate that possibility seriously as you pointed out.

> There were some issues of this sort around the v5.8 timeframe.  Might
> there be another patch that needs to be backported?  Or a patch that
> was backported, but should not have been?

Good to know that clue. I'll take a look into the log history.

>
> Is it possible to bisect this?
>
> Or, again, to run with CONFIG_RCU_EQS_DEBUG=y?

I am building the latest 5.14 kernel with this config and give it a try when the
machine is set up, see how much it can help.
>
> Either way, what should happen is that dyntick_save_progress_counter() or
> rcu_implicit_dynticks_qs() should see the rdp->dynticks field indicating
> nohz_full user execution, and then the quiescent state will be supplied
> on behalf of that CPU.

Agreed. But the counter rdp->dynticks of the CPU can only be updated
by rcu_dynticks_eqs_enter() or rcu_dynticks_exit() when rcu_eqs_enter()
or rcu_eqs_exit() is called, which in turn depends on the context switch.
So, when the context switch never happens, the counter rdp->dynticks
never advances. That's the thing I try to fix here.

>
> Now it is possible that you also have a problem where resched_cpu() isn't
> working.  But if so, that is a separate bug that should also be fixed.

agreed.

BTW, I feel like there should be a more reliable and efficient way to
let the RCU core deal with  gp and qs. I guess the existing code around
area can be simplified a lot. But we can start another discussion on that.

Thanks
Donghai
>
>                                                         Thanx, Paul
>
> > Thanks
> > Donghai
> >
> >
> > >
> > >                                                         Thanx, Paul
> > >
> > > > > > Hope this explains it.
> > > > > > Donghai
> > > > > >
> > > > > >
> > > > > > > Excellent point, Boqun!
> > > > > > >
> > > > > > > Donghai, have you tried reproducing this using a kernel built with
> > > > > > > CONFIG_RCU_EQS_DEBUG=y?
> > > > > > >
> > > > > >
> > > > > > I can give this configuration a try. Will let you know the results.
> > > > >
> > > > > This should help detect any missing rcu_user_enter() or rcu_user_exit()
> > > > > calls.
> > > >
> > > > Got it.
> > > >
> > > > Thanks
> > > > Donghai
> > > >
> > > > >
> > > > >                                                         Thanx, Paul
> > > > >
> > > > > > Thanks.
> > > > > > Donghai
> > > > > >
> > > > > >
> > > > > > >
> > > > > > >                                                         Thanx, Paul
> > > > > > >
> > > > > > > > Regards,
> > > > > > > > Boqun
> > > > > > > >
> > > > > > > > > the CPU and as long as the user thread is running, the forced context
> > > > > > > > > switch will
> > > > > > > > > never happen unless the user thread volunteers to yield the CPU. I
> > > > > > > think this
> > > > > > > > > should be one of the major root causes of these RCU stall issues. Even
> > > > > > > if
> > > > > > > > > NOHZ_FULL is not configured, there will be at least 1 tick delay which
> > > > > > > can
> > > > > > > > > affect the realtime kernel, by the way.
> > > > > > > > >
> > > > > > > > > But it seems not a good idea to craft a fix from the scheduler side
> > > > > > > because
> > > > > > > > > this has to invalidate some existing scheduling optimizations. The
> > > > > > > current
> > > > > > > > > scheduler is deliberately optimized to avoid such context switching.
> > > > > > > So my
> > > > > > > > > question is why the RCU core cannot effectively update qs for the
> > > > > > > stalled CPU
> > > > > > > > > when it detects that the stalled CPU is running a user thread?  The
> > > > > > > reason
> > > > > > > > > is pretty obvious because when a CPU is running a user thread, it must
> > > > > > > not
> > > > > > > > > be in any kernel read-side critical sections. So it should be safe to
> > > > > > > close
> > > > > > > > > its current RCU grace period on this CPU. Also, with this approach we
> > > > > > > can make
> > > > > > > > > RCU work more efficiently than the approach of context switch which
> > > > > > > needs to
> > > > > > > > > go through an IPI interrupt and the destination CPU needs to wake up
> > > > > > > its
> > > > > > > > > ksoftirqd or wait for the next scheduling cycle.
> > > > > > > > >
> > > > > > > > > If my suggested approach makes sense, I can go ahead to fix it that
> > > > > > > way.
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > > Donghai
> > > > > > >
