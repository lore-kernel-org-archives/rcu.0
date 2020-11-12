Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69E0C56202
	for <rcu@archiver.kernel.org>; Thu, 12 Nov 2020 12:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65728216C4
	for <rcu@archiver.kernel.org>; Thu, 12 Nov 2020 12:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtSbpKCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgKLMtR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Nov 2020 07:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbgKLMtP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Nov 2020 07:49:15 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0789C0613D4
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2020 04:49:14 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id l10so1273554oom.6
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2020 04:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zzVT0v3gmep680s+NflLICQeHQjw0uUukpoJ+hjBrc=;
        b=DtSbpKCyJJlwdxbWSfe0mwiJTWQ79UKf/WmXV7b9uNhKBwdsDZRrmG2xoCpBl6Kp3j
         8ae0sk0MxeZLjTdjiiYAnhQGr7R2W8Rb7kFoGg5DxQzY/+cFfHgkDgFnfw6QTy9pT/8i
         oPXDHPDZrPUwPm0U3tGNw2qdt/0v28MsVQB33rsNyEeqJA3MqHlsXecSAk32RXAhCXbM
         uwZUt2VpW8p4LghTLwYSWxtKXma6FJvJ+Z5aeqZal8qb7/fNSJzZybJI8yKuckhmtqN7
         yUiS+W+bOhnxGSbX48a2akomtCU9Qtu0ld0YS6p4FhSusuBPKldZxmdKciDBgX8gA497
         LxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zzVT0v3gmep680s+NflLICQeHQjw0uUukpoJ+hjBrc=;
        b=a2SOwUHLY/OHIwu8JUTqQk7eScqaRwxpm3x0UDBSeiP1ikuy1IuwJutZCn77+1Slye
         pwK0rlB3hAQPE+tPHiIownix75btVvHIbSxgzH5fp8EvVp7KwNJ06HubcOoBTB+X8Vv8
         TCevfFkP4AvEjFfOjMG+unMKK5SF1fbmdBlRhi/Z9NstEXHXQRrU+Y7gZNPN1xdYJhpX
         FmnSnuhgKPWSHNSZnJ9CYUtYh9KflYGSH4rTnPSPt7Kb7Tp+9kc/ruD+gdpfO4AYV8al
         8mI4r4mZrttK/o0tjS4OMzTTpdanqipd3JUFRoshnvuyQ0GBFTnRmEV3vFvpbmYtEfAC
         aRNw==
X-Gm-Message-State: AOAM530CueldaIwydqQGwNL5+W+cNuA+LLG/aaGx3DPB2U0k0+Ts/0wJ
        tcFjfck2U+Mf6mvIvh7TI/MG3nV4jpf+3S7hz6lISQ==
X-Google-Smtp-Source: ABdhPJy4T/4JR0HsAHFI4mQwdqG3dv1YlLSLp/cBeR6FlVgRLJAq1qC/K03YTVySQnpytt2zTK43iORmhePWvN2Qx4Y=
X-Received: by 2002:a4a:d886:: with SMTP id b6mr1622933oov.14.1605185352811;
 Thu, 12 Nov 2020 04:49:12 -0800 (PST)
MIME-Version: 1.0
References: <20201110135320.3309507-1-elver@google.com> <CADYN=9+=-ApMi_eEdAeHU6TyuQ7ZJSTQ8F-FCSD33kZH8HR+xg@mail.gmail.com>
 <CANpmjNM8MZphvkTSo=KgCBXQ6fNY4qo6NZD5SBHjNse_L9i5FQ@mail.gmail.com>
 <20201111133813.GA81547@elver.google.com> <20201111130543.27d29462@gandalf.local.home>
 <20201111182333.GA3249@paulmck-ThinkPad-P72> <20201111183430.GN517454@elver.google.com>
 <20201111192123.GB3249@paulmck-ThinkPad-P72> <20201111202153.GT517454@elver.google.com>
 <20201112001129.GD3249@paulmck-ThinkPad-P72>
In-Reply-To: <20201112001129.GD3249@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Nov 2020 13:49:00 +0100
Message-ID: <CANpmjNNyZs6NrHPmomC4=9MPEvCy1bFA5R2pRsMhG7=c3LhL_Q@mail.gmail.com>
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without allocations
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 12 Nov 2020 at 01:11, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Nov 11, 2020 at 09:21:53PM +0100, Marco Elver wrote:
> > On Wed, Nov 11, 2020 at 11:21AM -0800, Paul E. McKenney wrote:
> > [...]
> > > > >     rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled
> > > >
> > > > Sadly, no, next-20201110 already included that one, and that's what I
> > > > tested and got me all those warnings above.
> > >
> > > Hey, I had to ask!  The only uncertainty I seee is the acquisition of
> > > the lock in rcu_iw_handler(), for which I add a lockdep check in the
> > > (untested) patch below.  The other thing I could do is sprinkle such
> > > checks through the stall-warning code on the assumption that something
> > > RCU is calling is enabling interrupts.
> > >
> > > Other thoughts?
> > >
> > >                                                     Thanx, Paul
> > >
> > > ------------------------------------------------------------------------
> > >
> > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > index 70d48c5..3d67650 100644
> > > --- a/kernel/rcu/tree_stall.h
> > > +++ b/kernel/rcu/tree_stall.h
> > > @@ -189,6 +189,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
> > >
> > >     rdp = container_of(iwp, struct rcu_data, rcu_iw);
> > >     rnp = rdp->mynode;
> > > +   lockdep_assert_irqs_disabled();
> > >     raw_spin_lock_rcu_node(rnp);
> > >     if (!WARN_ON_ONCE(!rdp->rcu_iw_pending)) {
> > >             rdp->rcu_iw_gp_seq = rnp->gp_seq;
> >
> > This assert didn't fire yet, I just get more of the below. I'll keep
> > rerunning, but am not too hopeful...
>
> Is bisection a possibility?

I've been running a bisection for past ~12h, and am making slow
progress. It might be another 12h, but I think it'll get there.

> Failing that, please see the updated patch below.  This adds a few more
> calls to lockdep_assert_irqs_disabled(), but perhaps more helpfully dumps
> the current stack of the CPU that the RCU grace-period kthread wants to
> run on in the case where this kthread has been starved of CPU.

Thanks, I will apply that after the bisection runs.

>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 70d48c5..d203ea0 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -189,6 +189,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
>
>         rdp = container_of(iwp, struct rcu_data, rcu_iw);
>         rnp = rdp->mynode;
> +       lockdep_assert_irqs_disabled();
>         raw_spin_lock_rcu_node(rnp);
>         if (!WARN_ON_ONCE(!rdp->rcu_iw_pending)) {
>                 rdp->rcu_iw_gp_seq = rnp->gp_seq;
> @@ -449,21 +450,32 @@ static void print_cpu_stall_info(int cpu)
>  /* Complain about starvation of grace-period kthread.  */
>  static void rcu_check_gp_kthread_starvation(void)
>  {
> +       int cpu;
>         struct task_struct *gpk = rcu_state.gp_kthread;
>         unsigned long j;
>
>         if (rcu_is_gp_kthread_starving(&j)) {
> +               cpu = gpk ? task_cpu(gpk) : -1;
>                 pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
>                        rcu_state.name, j,
>                        (long)rcu_seq_current(&rcu_state.gp_seq),
>                        data_race(rcu_state.gp_flags),
>                        gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
> -                      gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
> +                      gpk ? gpk->state : ~0, cpu);
>                 if (gpk) {
>                         pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
>                         pr_err("RCU grace-period kthread stack dump:\n");
> +                       lockdep_assert_irqs_disabled();
>                         sched_show_task(gpk);
> +                       lockdep_assert_irqs_disabled();
> +                       if (cpu >= 0) {
> +                               pr_err("Stack dump where RCU grace-period kthread last ran:\n");
> +                               if (!trigger_single_cpu_backtrace(cpu))
> +                                       dump_cpu_task(cpu);
> +                       }
> +                       lockdep_assert_irqs_disabled();
>                         wake_up_process(gpk);
> +                       lockdep_assert_irqs_disabled();
>                 }
>         }
>  }
