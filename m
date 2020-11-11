Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B62C388F9
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 18:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982772076E
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 18:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rj5UMYIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgKKSej (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Nov 2020 13:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgKKSej (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Nov 2020 13:34:39 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1FBC0613D1
        for <rcu@vger.kernel.org>; Wed, 11 Nov 2020 10:34:38 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b8so3524742wrn.0
        for <rcu@vger.kernel.org>; Wed, 11 Nov 2020 10:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vxcKoesuuR8pDNQg4uNFcBd05UOqaWNnyX6PLwZNx7M=;
        b=rj5UMYIWUSkhEOaybF1PrNXWjQVlaSUwIRZWpvkT//Yql+E+l2e378LKwiCgoMilhz
         ui6Sbz90vex6GhJue1CJJuXmUU3Z3wOyc8UnpTffCFDimDqAObRbhJCuY3ebFnKmWWiD
         BqC1MdCCgirqSIROARGsiTlyfEsFhdc3NQG20LkvyCcEP/+g2J+K8UkOuXZv0mb4qCrg
         oQJPWhOKSRVojI+d0i43fsU2R/sUG4iboZroHgUh5QIZFjvARUKutSM8ZiomlcG+Px1z
         5FLBBSq7ApC0Khv6zihcqZPqwM1/ESAbJY84sAKfoaICD88fyCy8WUieRUxBd7tvZ01X
         we2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vxcKoesuuR8pDNQg4uNFcBd05UOqaWNnyX6PLwZNx7M=;
        b=IxPQmQtj1JZF82miq3/xRW0eNqHLgmBlZm2HqymgnqhkPwylkBoQOr/mnLcsg8bTIa
         jWO7J5EKjv4wvSQhyjVpHTprLWxOWJGO7er30YmsXBt2/bBfw1elgMbghdURw2juGJef
         i0+yutjq1fn6mAkit0HIesNC7GOJA3lHIZbfHpN+fu039fLMbPpR6DnANk4UtGvzkZgP
         kI3VrrICZlZ6iNrLUacGO1+3ke/P27PPkQqu/P1dzwYVr1P10iqvO60icHZgcImHwItV
         ztLCNI3Hv6RhOB4Xf77wEcyutAGvoQXjIEw9329mXn3HflLLAPUqSqK64eR4Eyd+tZQq
         haTQ==
X-Gm-Message-State: AOAM533+5n9rmZvxu/RVIIUMch8gP81AwN+KC9uV0yn8Y/b5UbYuopHs
        Nw4iyBESzf/wozfaAEkx6sJQeA==
X-Google-Smtp-Source: ABdhPJzjPpLin6mqrWWcFSUVTgfo+0I8en0LDPhRTvl5dcVR/kOVbfIt4METM/WZj7bE+/fcVopAoA==
X-Received: by 2002:adf:92e7:: with SMTP id 94mr33490175wrn.271.1605119677378;
        Wed, 11 Nov 2020 10:34:37 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id f19sm3364561wml.21.2020.11.11.10.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:34:36 -0800 (PST)
Date:   Wed, 11 Nov 2020 19:34:30 +0100
From:   Marco Elver <elver@google.com>
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
        peterz@infradead.org
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without
 allocations
Message-ID: <20201111183430.GN517454@elver.google.com>
References: <20201110135320.3309507-1-elver@google.com>
 <CADYN=9+=-ApMi_eEdAeHU6TyuQ7ZJSTQ8F-FCSD33kZH8HR+xg@mail.gmail.com>
 <CANpmjNM8MZphvkTSo=KgCBXQ6fNY4qo6NZD5SBHjNse_L9i5FQ@mail.gmail.com>
 <20201111133813.GA81547@elver.google.com>
 <20201111130543.27d29462@gandalf.local.home>
 <20201111182333.GA3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111182333.GA3249@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 11, 2020 at 10:23AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 11, 2020 at 01:05:43PM -0500, Steven Rostedt wrote:
> > On Wed, 11 Nov 2020 14:38:13 +0100
> > Marco Elver <elver@google.com> wrote:
> > 
> > > [+Cc folks who can maybe help figure out what's going on, since I get
> > >   warnings even without KFENCE on next-20201110.]
> > > 
> > > On Wed, Nov 11, 2020 at 09:29AM +0100, Marco Elver wrote:
> > > > On Wed, 11 Nov 2020 at 00:23, Anders Roxell <anders.roxell@linaro.org> wrote:
> > > > [...]
> > > > > I gave them a spin on next-20201105 [1] and on next-20201110 [2].
> > > > >
> > > > > I eventually got to a prompt on next-20201105.
> > > > > However, I got to this kernel panic on the next-20201110:
> > > > >
> > > > > [...]
> > > > > [ 1514.089966][    T1] Testing event system initcall: OK
> > > > > [ 1514.806232][    T1] Running tests on all trace events:
> > > > > [ 1514.857835][    T1] Testing all events:
> > > > > [ 1525.503262][    C0] hrtimer: interrupt took 10902600 ns
> > > > > [ 1623.861452][    C0] BUG: workqueue lockup - pool cpus=0 node=0
> > > > > flags=0x0 nice=0 stuck for 65s!
> > > > > [...]
> > 
> > OK, so this blows up when you enable all events?
> > 
> > Note, it could just be adding overhead (which is exasperated with other
> > debug options enabled), which could open up a race window.
> >  
> > 
> > > > > [ 7823.104349][   T28]       Tainted: G        W
> > > > > 5.10.0-rc3-next-20201110-00008-g8dc06700529d #3
> > > > > [ 7833.206491][   T28] "echo 0 >
> > > > > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > > [ 7840.750700][   T28] task:kworker/0:1     state:D stack:26640 pid:
> > > > > 1872 ppid:     2 flags:0x00000428
> > > > > [ 7875.642531][   T28] Workqueue: events toggle_allocation_gate
> > > > > [ 7889.178334][   T28] Call trace:
> > > > > [ 7897.066649][   T28]  __switch_to+0x1cc/0x1e0
> > > > > [ 7905.326856][   T28]  0xffff00000f7077b0
> > > > > [ 7928.354644][   T28] INFO: lockdep is turned off.
> > > > > [ 7934.022572][   T28] Kernel panic - not syncing: hung_task: blocked tasks
> > > > > [ 7934.032039][   T28] CPU: 0 PID: 28 Comm: khungtaskd Tainted: G
> > > > >   W         5.10.0-rc3-next-20201110-00008-g8dc06700529d #3
> > > > > [ 7934.045586][   T28] Hardware name: linux,dummy-virt (DT)
> > > > > [ 7934.053677][   T28] Call trace:
> > > > > [ 7934.060276][   T28]  dump_backtrace+0x0/0x420
> > > > > [ 7934.067635][   T28]  show_stack+0x38/0xa0
> > > > > [ 7934.091277][   T28]  dump_stack+0x1d4/0x278
> > > > > [ 7934.098878][   T28]  panic+0x304/0x5d8
> > > > > [ 7934.114923][   T28]  check_hung_uninterruptible_tasks+0x5e4/0x640
> > > > > [ 7934.123823][   T28]  watchdog+0x138/0x160
> > > > > [ 7934.131561][   T28]  kthread+0x23c/0x260
> > > > > [ 7934.138590][   T28]  ret_from_fork+0x10/0x18
> > > > > [ 7934.146631][   T28] Kernel Offset: disabled
> > > > > [ 7934.153749][   T28] CPU features: 0x0240002,20002004
> > > > > [ 7934.161476][   T28] Memory Limit: none
> > > > > [ 7934.171272][   T28] ---[ end Kernel panic - not syncing: hung_task:
> > > > > blocked tasks ]---
> > > > >
> > > > > Cheers,
> > > > > Anders
> > > > > [1] https://people.linaro.org/~anders.roxell/output-next-20201105-test.log
> > > > > [2] https://people.linaro.org/~anders.roxell/output-next-20201110-test.log
> > > > 
> > > > Thanks for testing. The fact that it passes on next-20201105 but not
> > > > on 20201110 is strange. If you boot with KFENCE disabled (boot param
> > > > kfence.sample_interval=0), does it boot?
> > > [...]
> > > 
> > > Right, so I think this is no longer KFENCE's fault. This looks like
> > > something scheduler/RCU/ftrace related?! I notice that there have been
> > > scheduler changes between next-20201105 and next-20201110.
> > 
> > I'm not sure any of that would cause this.
> > 
> > > 
> > > I get this with KFENCE disabled:
> > > 
> > > | Running tests on all trace events:
> > > | Testing all events: 
> > > | BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 32s!
> > > | Showing busy workqueues and worker pools:
> > > | workqueue events: flags=0x0
> > > |   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> > > |     pending: vmstat_shepherd
> > > | workqueue events_power_efficient: flags=0x82
> > > |   pwq 2: cpus=0 flags=0x5 nice=0 active=2/256 refcnt=4
> > > |     in-flight: 107:neigh_periodic_work
> > > |     pending: do_cache_clean
> > > | pool 2: cpus=0 flags=0x5 nice=0 hung=3s workers=2 manager: 7
> > > | rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > | 	(detected by 0, t=6502 jiffies, g=2885, q=4)
> > > | rcu: All QSes seen, last rcu_preempt kthread activity 5174 (4295523265-4295518091), jiffies_till_next_fqs=1, root ->qsmask 0x0
> > > | rcu: rcu_preempt kthread starved for 5174 jiffies! g2885 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> > > | rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> > > | rcu: RCU grace-period kthread stack dump:
> > > | task:rcu_preempt     state:R  running task     stack:    0 pid:   10 ppid:     2 flags:0x00000428
> > > | Call trace:
> > > |  __switch_to+0x100/0x1e0
> > > |  __schedule+0x2d0/0x890
> > > |  preempt_schedule_notrace+0x70/0x1c0
> > > |  ftrace_ops_no_ops+0x174/0x250
> > > |  ftrace_graph_call+0x0/0xc
> > 
> > Note, just because ftrace is called here, the blocked task was preempted
> > when the ftrace code called preempt_enable_notrace().
> > 
> > 
> > > |  preempt_count_add+0x1c/0x180
> > > |  schedule+0x44/0x108
> > > |  schedule_timeout+0x394/0x530
> > > |  rcu_gp_kthread+0x76c/0x19a8
> > > |  kthread+0x174/0x188
> > > |  ret_from_fork+0x10/0x18
> > > | 
> > > | ================================
> > > | WARNING: inconsistent lock state
> > > | 5.10.0-rc3-next-20201110-00001-gc07b306d7fa5-dirty #18 Not tainted
> > > | --------------------------------
> > > | inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> > > | kcompactd0/26 [HC0[0]:SC0[0]:HE0:SE1] takes:
> > > | ffffae32e6bd4358 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x4a0/0xd18
> > > | {IN-HARDIRQ-W} state was registered at:
> > 
> > I did some digging here and it looks like the rcu_node lock could be taken
> > without interrupts enabled when it does a stall print. That probably should
> > be fixed, but it's a symptom of the underlining bug and not the cause.
> 
> Does this patch (in -next) help?
> 
> 							Thanx, Paul
 
>     rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled

Sadly, no, next-20201110 already included that one, and that's what I
tested and got me all those warnings above.

Thanks,
-- Marco
