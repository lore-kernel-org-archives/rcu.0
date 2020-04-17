Return-Path: <SRS0=YclE=6B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DE8C2BB55
	for <rcu@archiver.kernel.org>; Fri, 17 Apr 2020 07:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CF52087E
	for <rcu@archiver.kernel.org>; Fri, 17 Apr 2020 07:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4oZg5oI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgDQHPy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgDQHPy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Apr 2020 03:15:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0035AC061A10
        for <rcu@vger.kernel.org>; Fri, 17 Apr 2020 00:15:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d1so669813pfh.1
        for <rcu@vger.kernel.org>; Fri, 17 Apr 2020 00:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C4mI78dLw0Rtm/TcXWKy1hdvRlFkTdHdo9og+eKYqX0=;
        b=S4oZg5oIsply9V+Eb8yj4dqwMLnmfwolMvW6pJ2jiOXtgcdGbank10pmV6THXp2SFx
         vxHKWxNZOtkUp1pSEMphx5Vce9BXRoqi/tev7WJiH41zQM2N/rwaXxDqcKSguvJfTMK7
         w8AFa/JVEZp5gRg4iCgfSD2w/0ymWpnmJLJlN/KhXIytPDrUfQlFNl+S3OH3WU2CpNJG
         ZZE1ChnHkmXAJ5hQKwdbaW+aWuW5Yu9y34qqq3eQhhkqb6t1ocnCIw5yzJju+QVy2bSk
         Xm9Ozf8V2z3yk0LI67wsrYjxFfC9dPchuVXYy2NwnkyQZuaUXC+7OdJ3Dm+3LvieBl0R
         /zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C4mI78dLw0Rtm/TcXWKy1hdvRlFkTdHdo9og+eKYqX0=;
        b=j2QnYP07VdBtG/c/+Y4mUISd/i/lbJ46306gkcu36wRKSh5sispFdRtb68kgRiE/5Q
         SINV/tDhrNih6CossdepIOUU0o37yuz0682MpdcJfhH31qSY7DiF+hY4/cwK4jPopJi+
         OSOVTdvvWwhxRsDgmZ8G4w+YFH3yrwUsP5Wkd6YpmivCQH8WfpxqoqqSkd1R+epNsxsn
         xs6kLqVXUtsBG7tJVQW4X6HaqCOljVZMVuh+MZwOl5qBv1wUNntSkHJYDv/5w1f9H4/Y
         NU68FUVXXOzV0bTQeoV1JKNRrWtYrlVxR18m7aowZf2eBShz6dt0e8dvruNE+LpLxH7C
         4rJg==
X-Gm-Message-State: AGi0PuaRneODJ6zAmab572mVYe5gPUyaRtqpjS1HxSMUT8Meu+AeFrun
        cSKLnX+aFVTyrgQo4ohLK9DnWA==
X-Google-Smtp-Source: APiQypKfdNlQdzAVfQ2rKBeqhNHBhNVOMB/lM20eEhEfiv5bBwt1d2dXl4+QxHqBtPN+PBuJs5SYNg==
X-Received: by 2002:a63:721e:: with SMTP id n30mr1576447pgc.94.1587107752287;
        Fri, 17 Apr 2020 00:15:52 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id i190sm16758212pfc.119.2020.04.17.00.15.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 00:15:51 -0700 (PDT)
Date:   Fri, 17 Apr 2020 15:15:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Masami Hiramatsu <masami.hiramatsu@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux- stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        rcu@vger.kernel.org, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>, zanussi@kernel.org,
        svens@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING: events/ipi.h:36 suspicious rcu_dereference_check()
 usage!
Message-ID: <20200417071543.GA7316@leoy-ThinkPad-X240s>
References: <CA+G9fYtYRc_mKPDN-Gryw7fhjPNGBUP=KemTXaXR6UBU94M3hw@mail.gmail.com>
 <CAA93ih2To3YN=L7VSa_RzVRV5OH9DTffd0zdKWB2M4CfE0Gp1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA93ih2To3YN=L7VSa_RzVRV5OH9DTffd0zdKWB2M4CfE0Gp1Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 17, 2020 at 03:53:27PM +0900, Masami Hiramatsu wrote:
> Hello,
> 
> It seems that *arm/arm64 specific* IPI trace event has caused this issue.
> From the stacktrace, __update_max_tr() is invoked from do_idle() context.
> 
> ------
> __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
> {
> [SNIP]
>         /* record this tasks comm */
>         tracing_record_cmdline(tsk);
>         latency_fsnotify(tr);  <<------here
> }
> ------
> And via latency_fsnotify(), it calls irq_work_queue().
> 
> ------
> void latency_fsnotify(struct trace_array *tr)
> {
>         if (!fsnotify_wq)
>                 return;
>         /*
>          * We cannot call queue_work(&tr->fsnotify_work) from here because it's
>          * possible that we are called from __schedule() or do_idle(), which
>          * could cause a deadlock.
>          */
>         irq_work_queue(&tr->fsnotify_irqwork); <<------- here
> }
> ------
> Please NOTE(*) that the above comment said that irq_work_queue()
> should be SAFE from calling in do_idle(), this means it doesn't touch
> any RCU.
> 
> And the irq_work_queue() finally kicks IPI via arch_irq_work_raise()
> which causes an IPI.
> 
> --------<arm64: arch/arm64/kernel/smp.c>--------
> #ifdef CONFIG_IRQ_WORK
> void arch_irq_work_raise(void)
> {
>         if (__smp_cross_call)
>                 smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
> }
> #endif
> 
> static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> {
>         trace_ipi_raise(target, ipi_types[ipinr]);  <<----- This
> causes a warning!
>         __smp_cross_call(target, ipinr);
> }
> -------
> And trace_* macro touch the RCU. See include/linux/tracepoint.h:231
> ------
> #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
>         extern struct tracepoint __tracepoint_##name;                   \
>         static inline void trace_##name(proto)                          \
>         {                                                               \
>                 if (static_key_false(&__tracepoint_##name.key))         \
>                         __DO_TRACE(&__tracepoint_##name,                \
>                                 TP_PROTO(data_proto),                   \
>                                 TP_ARGS(data_args),                     \
>                                 TP_CONDITION(cond), 0);                 \
>                 if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {             \
>                         rcu_read_lock_sched_notrace();                  \
>                         rcu_dereference_sched(__tracepoint_##name.funcs);\
>                         rcu_read_unlock_sched_notrace();                \
>                 }                                                       \
>         }
> ------
> 
> BTW, this ipi_raise trace event is only used in arm/arm64.
> 
> $ git grep trace_ipi_raise
> arch/arm/kernel/smp.c:  trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
> arch/arm64/kernel/smp.c:        trace_ipi_raise(target, ipi_types[ipinr]);
> include/trace/events/ipi.h: * __tracepoint_string, ideally the same as
> used with trace_ipi_raise
> include/trace/events/ipi.h: * __tracepoint_string, ideally the same as
> used with trace_ipi_raise for
> 
> Thus, this only occurs on arm64 platform, but not on x86.
> 
> To fix this, maybe we need to remove this event or mark this is under
> rcu watched (but is it really watched?)

Good analysis, Masami :)

Seems to me, Arm64 should study Arm platform to change using
trace_ipi_raise_rcuidle() to work around the restriction so can allow the
event to work in idle context?

Thanks,
Leo

> 2020年4月8日(水) 18:31 Naresh Kamboju <naresh.kamboju@linaro.org>:
> 
> >
> > On arm64 qemu_arm64, juno-r2 and dragonboard-410c while running kselftest ftrace
> > on stable rc 5.5.1-rc1 to till today 5.5.16-rc2 and 5.6  found this
> > kernel warning.
> >
> > [  386.349099] kselftest: Running tests in ftrace
> > [  393.984018]
> > [  393.984290] =============================
> > [  393.984781] WARNING: suspicious RCU usage
> > [  393.988690] 5.6.3-rc2 #1 Not tainted
> > [  393.992679] -----------------------------
> > [  393.996327] /usr/src/kernel/include/trace/events/ipi.h:36
> > suspicious rcu_dereference_check() usage!
> > [  394.000241]
> > [  394.000241] other info that might help us debug this:
> > [  394.000241]
> > [  394.009094]
> > [  394.009094] RCU used illegally from idle CPU!
> > [  394.009094] rcu_scheduler_active = 2, debug_locks = 1
> > [  394.017084] RCU used illegally from extended quiescent state!
> > [  394.028187] 1 lock held by swapper/3/0:
> > [  394.033826]  #0: ffff80001237b6a8 (max_trace_lock){....}, at:
> > check_critical_timing+0x7c/0x1a8
> > [  394.037480]
> > [  394.037480] stack backtrace:
> > [  394.046158] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.6.3-rc2 #1
> > [  394.050584] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > [  394.056663] Call trace:
> > [  394.063515]  dump_backtrace+0x0/0x1e0
> > [  394.065686]  show_stack+0x24/0x30
> > [  394.069505]  dump_stack+0xe8/0x150
> > [  394.072805]  lockdep_rcu_suspicious+0xcc/0x110
> > [  394.076106]  arch_irq_work_raise+0x208/0x210
> > [  394.080533]  __irq_work_queue_local+0x5c/0x80
> > [  394.084959]  irq_work_queue+0x38/0x78
> > [  394.089212]  __update_max_tr+0x150/0x218
> > [  394.092858]  update_max_tr_single.part.82+0x98/0x100
> > [  394.096851]  update_max_tr_single+0x1c/0x28
> > [  394.101798]  check_critical_timing+0x198/0x1a8
> > [  394.105705]  stop_critical_timings+0x128/0x148
> > [  394.110221]  cpuidle_enter_state+0x74/0x4f8
> > [  394.114645]  cpuidle_enter+0x3c/0x50
> > [  394.118726]  call_cpuidle+0x44/0x80
> > [  394.122542]  do_idle+0x22c/0x2d0
> > [  394.125755]  cpu_startup_entry+0x28/0x48
> > [  394.129229]  secondary_start_kernel+0x1b4/0x210
> >
> >
> > metadata:
> >   git branch: linux-5.5.y and linux-5.6.y
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >   kernel-config:
> > http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/juno/lkft/linux-stable-rc-5.5/65/config
> >
> > Full test log,
> > 5.6 test logs,
> > https://lkft.validation.linaro.org/scheduler/job/1350627#L12612
> > https://lkft.validation.linaro.org/scheduler/job/1350731#L9509
> >
> > 5.5 test logs,
> > https://lkft.validation.linaro.org/scheduler/job/1322704#L9777
> > https://lkft.validation.linaro.org/scheduler/job/1153369#L9745
> > https://lkft.validation.linaro.org/scheduler/job/1351155#L8982
> > https://lkft.validation.linaro.org/scheduler/job/1351065#L12349
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> 
> 
> 
> --
> Masami Hiramatsu
