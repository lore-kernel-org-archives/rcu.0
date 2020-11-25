Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F013EC56201
	for <rcu@archiver.kernel.org>; Wed, 25 Nov 2020 09:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13592083E
	for <rcu@archiver.kernel.org>; Wed, 25 Nov 2020 09:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pv5Y+aB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgKYJpg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Nov 2020 04:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgKYJpg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Nov 2020 04:45:36 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51E4C0613D4
        for <rcu@vger.kernel.org>; Wed, 25 Nov 2020 01:45:25 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m6so1219295wrg.7
        for <rcu@vger.kernel.org>; Wed, 25 Nov 2020 01:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M1It9rnlbHmsIp3XcYjIIsB1X+4p25KeX07z6WVn2RM=;
        b=pv5Y+aB/XP42RklxXlHKkSxcVlYXNGclYkon3abSpCZQzoIVeH3S66r5vWJzlcIWVf
         9fPlaf7knZzBHCh0ygQNkwzWt3NJKhKcoeLmLXhtF66VAnV1tcXO3NjKA5joQkd3XoWV
         bekNoVlarJd5S3jjuyGTB12gramyaFn7xmd68aoPSrExnswQedmJNriM0H+UpNQrgI1B
         oHb7DUnM4M0/j+N4H14jqc5mA3PHvYHSPFMD4jOt/KBHNx/9KWgutu0r9v2SyclDrf3V
         BdtXGAOHzgG+nJQ2SJnivOOlYu6A2KNfiZX7sl7R40lo4f7Wx7ofYfcyPZ4p6TsN1TKv
         mK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M1It9rnlbHmsIp3XcYjIIsB1X+4p25KeX07z6WVn2RM=;
        b=EU3wOo+nBbS+SeHYEBtQx7gY37q8uhrOqL75uHonp+z+86Zfw6JZ/mT3kH/aYZ/KFI
         WVavT6MNkMRKd/mBGV7CCRRcnMjuUsRbziFV47PWrEd0vcaUTecEXVNeD1iyemRg8Awh
         Pdv0DY5U1rTJsseYYouB6zjmfTanzlXpG4Z+0Ud7ThLroStKfhJfcNEiZtVl3mI+CgtU
         WzIKLoeIr3IHtT7AZcwkSgH5prDAfZqiV/oL/mqw8xjMjexF6tdaDOOJGHJc9xG+ndoN
         +Pgm5fHGUE0s2qWu6gLHFypC0XXt4+QFTo6h7lmt1Zksj/VkmznhmsBcuZ+Pr/bMMgVM
         rMlw==
X-Gm-Message-State: AOAM530RSOrW0UdY9bZCGXTVzHexayi/dJNoZZzatf/3VHwwhxtShWMa
        9JvQwM0sXP7OO2iSeO+M27HZyw==
X-Google-Smtp-Source: ABdhPJytlem/QZrvzKXjSGaCb05LdFqsRuVe5lKybAJz4d/L0nKu+HPLwUstTmXmt3C1ZcEkLCBWMA==
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr3131061wrw.42.1606297524335;
        Wed, 25 Nov 2020 01:45:24 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id k16sm3962560wrl.65.2020.11.25.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 01:45:23 -0800 (PST)
Date:   Wed, 25 Nov 2020 10:45:17 +0100
From:   Marco Elver <elver@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-arm-kernel@lists.infradead.org, boqun.feng@gmail.com,
        tglx@linutronix.de
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201125094517.GA1359135@elver.google.com>
References: <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
 <20201119213512.GB1437@paulmck-ThinkPad-P72>
 <20201119225352.GA5251@willie-the-truck>
 <20201120103031.GB2328@C02TD0UTHF1T.local>
 <20201120140332.GA3120165@elver.google.com>
 <20201123193241.GA45639@C02TD0UTHF1T.local>
 <20201124140310.GA811510@elver.google.com>
 <20201124193034.GB8957@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20201124193034.GB8957@C02TD0UTHF1T.local>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2020 at 07:30PM +0000, Mark Rutland wrote:
[...]
> > > I've just updated that branch with a new version which I hope covers
> > > kernel<->kernel transitions too. If you get a chance, would you mind
> > > giving that a spin?
> > > 
> > > The HEAD commit should be:
> > > 
> > >   a51334f033f8ee88 ("HACK: check IRQ tracing has RCU watching")
> > 
> > Thank you! Your series appears to work and fixes the stalls and
> > deadlocks (3 trials)! 
> 
> Thanks for testing! I'm glad that appears to work, as it suggests
> there's not another massive problem lurking in this area.
> 
> While cleaning/splitting that up today, I spotted a couple of new
> problems I introduced, and I'm part-way through sorting that out, but
> it's not quite ready today after all. :/
> 
> Fingers crossed for tomorrow...
> 
> > I noticed there are a bunch of warnings in the log
> > that might be relevant (see attached).
> 
> > [   91.184432] =============================
> > [   91.188301] WARNING: suspicious RCU usage
> > [   91.192316] 5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25 Tainted: G        W        
> > [   91.197536] -----------------------------
> > [   91.201431] kernel/trace/trace_preemptirq.c:78 RCU not watching trace_hardirqs_off()!
> > [   91.206546] 
> > [   91.206546] other info that might help us debug this:
> > [   91.206546] 
> > [   91.211790] 
> > [   91.211790] rcu_scheduler_active = 2, debug_locks = 0
> > [   91.216454] RCU used illegally from extended quiescent state!
> > [   91.220890] no locks held by swapper/0/0.
> > [   91.224712] 
> > [   91.224712] stack backtrace:
> > [   91.228794] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25
> > [   91.234877] Hardware name: linux,dummy-virt (DT)
> > [   91.239032] Call trace:
> > [   91.242587]  dump_backtrace+0x0/0x240
> > [   91.246500]  show_stack+0x34/0x88
> > [   91.250295]  dump_stack+0x140/0x1bc
> > [   91.254159]  lockdep_rcu_suspicious+0xe4/0xf8
> > [   91.258332]  trace_hardirqs_off+0x214/0x330
> > [   91.262462]  trace_graph_return+0x1ac/0x1d8
> > [   91.266564]  ftrace_return_to_handler+0xa4/0x170
> > [   91.270809]  return_to_handler+0x1c/0x38
> > [   91.274826]  default_idle_call+0x94/0x38c
> > [   91.278869]  do_idle+0x240/0x290
> > [   91.282633]  rest_init+0x1e8/0x2dc
> > [   91.286529]  arch_call_rest_init+0x1c/0x28
> > [   91.290585]  start_kernel+0x638/0x670
> 
> Hmm... I suspect that arch_cpu_idle() is being traced here, and I reckon
> we have to mark that and its callees as noinstr, since it doesn't seem
> sane to have ftrace check whether RCU is watching for every function
> call. Maybe Paul or Steve can correct me. ;)

Yes, it's arch_cpu_idle().

> If you still have the binary lying around, can you check whether
> default_idle_call+0x94/0x38c is just after the call to arch_cpu_idle()?
> If you could dump the asm around that, along with whatever faddr2line
> tells you, that'd be a great help. 

I reran to be sure, with similar results. I've attached a
syz-symbolize'd version of the warnings.

Thanks,
-- Marco

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-symbolized

sched: DL replenish lagged too much
PASSED
Testing tracer wakeup_dl: PASSED
Testing tracer function_graph: 
=============================
WARNING: suspicious RCU usage
5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25 Tainted: G        W        
-----------------------------
kernel/trace/trace_preemptirq.c:78 RCU not watching trace_hardirqs_off()!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x240 arch/arm64/kernel/stacktrace.c:100
 show_stack+0x34/0x88 arch/arm64/kernel/stacktrace.c:196
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x140/0x1bc lib/dump_stack.c:120
 lockdep_rcu_suspicious+0xe4/0xf8 kernel/locking/lockdep.c:6353
 trace_hardirqs_off+0x214/0x330 kernel/trace/trace_preemptirq.c:78
 trace_graph_return+0x1ac/0x1d8 kernel/trace/trace_functions_graph.c:253
 ftrace_return_to_handler+0xa4/0x170 kernel/trace/fgraph.c:239
 return_to_handler+0x1c/0x38 arch/arm64/kernel/entry-ftrace.S:333
 default_idle_call+0x94/0x38c kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0x240/0x290 kernel/sched/idle.c:299
 rest_init+0x1e8/0x2dc init/main.c:722
 arch_call_rest_init+0x1c/0x28
 start_kernel+0x638/0x670 init/main.c:1066
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5279 check_flags.part.0+0x1d4/0x1f8 kernel/locking/lockdep.c:5279
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25
Hardware name: linux,dummy-virt (DT)
pstate: 80000085 (Nzcv daIf -PAN -UAO -TCO BTYPE=--)
pc : check_flags.part.0+0x1d4/0x1f8 kernel/locking/lockdep.c:5279
lr : check_flags.part.0+0x1d4/0x1f8 kernel/locking/lockdep.c:5279
sp : ffffa97d6cd73a50
x29: ffffa97d6cd73a50 x28: ffffa97d6cd84000 
x27: ffffa97d6c69cbb8 x26: ffffa97d6a835930 
x25: 0000000000000000 x24: 0000000000000000 
x23: ffffa97d6cdaf360 x22: 0000000000000001 
x21: 0000000000000000 x20: 0000000000000001 
x19: ffffa97d6dbcf000 x18: 00000000d8c875f1 
x17: 00000000bf9a23d2 x16: 0000000000000005 
x15: 0000000000000000 x14: 0000000000000028 
x13: 000000000000067d x12: 0000000000000028 
x11: 0101010101010101 x10: ffffa97d6cd73820 
x9 : ffffa97d6a960ff8 x8 : 4e5241575f534b43 
x7 : 4f4c5f4755424544 x6 : ffff35ce3dbd3667 
x5 : 00000000ffffffc8 x4 : ffff35ce3dbd2c60 
x3 : ffffa97d6a800000 x2 : ffffa97d6bc60000 
x1 : ba5fc2cb163a2c00 x0 : 0000000000000000 
Call trace:
 check_flags.part.0+0x1d4/0x1f8 kernel/locking/lockdep.c:5279
 check_flags kernel/locking/lockdep.c:5275 [inline]
 lock_acquire kernel/locking/lockdep.c:5432 [inline]
 lock_acquire+0x208/0x508 kernel/locking/lockdep.c:5400
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x5c/0x80 kernel/locking/spinlock.c:151
 vprintk_emit+0xb4/0x380 kernel/printk/printk.c:2010
 vprintk_default+0x4c/0x60 kernel/printk/printk.c:2045
 vprintk_func+0x120/0x330 kernel/printk/printk_safe.c:393
 printk+0x78/0x9c kernel/printk/printk.c:2076
 lockdep_rcu_suspicious+0x2c/0xf8 kernel/locking/lockdep.c:6317
 trace_hardirqs_off+0x214/0x330 kernel/trace/trace_preemptirq.c:78
 trace_graph_return+0x1ac/0x1d8 kernel/trace/trace_functions_graph.c:253
 ftrace_return_to_handler+0xa4/0x170 kernel/trace/fgraph.c:239
 return_to_handler+0x1c/0x38 arch/arm64/kernel/entry-ftrace.S:333
 default_idle_call+0x94/0x38c kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0x240/0x290 kernel/sched/idle.c:299
 rest_init+0x1e8/0x2dc init/main.c:722
 arch_call_rest_init+0x1c/0x28
 start_kernel+0x638/0x670 init/main.c:1066
irq event stamp: 1719
hardirqs last  enabled at (1719): [<ffffa97d6bc33094>] exit_el1_irq_or_nmi+0x24/0x50 arch/arm64/kernel/entry-common.c:101
hardirqs last disabled at (1716): [<ffffa97d6bc33060>] enter_el1_irq_or_nmi+0x20/0x30 arch/arm64/kernel/entry-common.c:93
softirqs last  enabled at (1718): [<ffffa97d6a835930>] return_to_handler+0x0/0x38 arch/arm64/kernel/entry-ftrace.S:314
softirqs last disabled at (1717): [<ffffa97d6a8c6880>] irq_enter_rcu+0x88/0xa8 kernel/softirq.c:363
---[ end trace 06e986ee87545489 ]---


=============================
WARNING: suspicious RCU usage
5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25 Not tainted
-----------------------------
include/trace/events/ipi.h:19 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x240 arch/arm64/kernel/stacktrace.c:100
 show_stack+0x34/0x88 arch/arm64/kernel/stacktrace.c:196
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x140/0x1bc lib/dump_stack.c:120
 lockdep_rcu_suspicious+0xe4/0xf8 kernel/locking/lockdep.c:6353
 trace_ipi_raise include/trace/events/ipi.h:19 [inline]
 smp_cross_call+0x220/0x228 arch/arm64/kernel/smp.c:953
 arch_irq_work_raise+0x40/0x50 arch/arm64/kernel/smp.c:840
 __irq_work_queue_local kernel/irq_work.c:59 [inline]
 __irq_work_queue_local+0xb0/0xe8 kernel/irq_work.c:53
 irq_work_queue kernel/irq_work.c:75 [inline]
 irq_work_queue+0x5c/0xb8 kernel/irq_work.c:67
 queue_flush_work kernel/printk/printk_safe.c:56 [inline]
 printk_safe_log_store+0x1a0/0x1d8 kernel/printk/printk_safe.c:107
 vprintk_safe kernel/printk/printk_safe.c:347 [inline]
 vprintk_func+0x23c/0x330 kernel/printk/printk_safe.c:390
 printk+0x78/0x9c kernel/printk/printk.c:2076
 lockdep_rcu_suspicious+0x2c/0xf8 kernel/locking/lockdep.c:6317
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x340/0x508 kernel/locking/lockdep.c:5406
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x5c/0x80 kernel/locking/spinlock.c:151
 vprintk_emit+0xb4/0x380 kernel/printk/printk.c:2010
 vprintk_default+0x4c/0x60 kernel/printk/printk.c:2045
 vprintk_func+0x120/0x330 kernel/printk/printk_safe.c:393
 printk+0x78/0x9c kernel/printk/printk.c:2076
 lockdep_rcu_suspicious+0x2c/0xf8 kernel/locking/lockdep.c:6317
 trace_hardirqs_off+0x214/0x330 kernel/trace/trace_preemptirq.c:78
 trace_graph_return+0x1ac/0x1d8 kernel/trace/trace_functions_graph.c:253
 ftrace_return_to_handler+0xa4/0x170 kernel/trace/fgraph.c:239
 return_to_handler+0x1c/0x38 arch/arm64/kernel/entry-ftrace.S:333
 default_idle_call+0x94/0x38c kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0x240/0x290 kernel/sched/idle.c:299
 rest_init+0x1e8/0x2dc init/main.c:722
 arch_call_rest_init+0x1c/0x28
 start_kernel+0x638/0x670 init/main.c:1066
=============================
WARNING: suspicious RCU usage
5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25 Not tainted
-----------------------------
include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.0-rc4-next-20201119-00002-g51c2bf0ac853 #25
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x240 arch/arm64/kernel/stacktrace.c:100
 show_stack+0x34/0x88 arch/arm64/kernel/stacktrace.c:196
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x140/0x1bc lib/dump_stack.c:120
 lockdep_rcu_suspicious+0xe4/0xf8 kernel/locking/lockdep.c:6353
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x340/0x508 kernel/locking/lockdep.c:5406
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x5c/0x80 kernel/locking/spinlock.c:151
 vprintk_emit+0xb4/0x380 kernel/printk/printk.c:2010
 vprintk_default+0x4c/0x60 kernel/printk/printk.c:2045
 vprintk_func+0x120/0x330 kernel/printk/printk_safe.c:393
 printk+0x78/0x9c kernel/printk/printk.c:2076
 lockdep_rcu_suspicious+0x2c/0xf8 kernel/locking/lockdep.c:6317
 trace_hardirqs_off+0x214/0x330 kernel/trace/trace_preemptirq.c:78
 trace_graph_return+0x1ac/0x1d8 kernel/trace/trace_functions_graph.c:253
 ftrace_return_to_handler+0xa4/0x170 kernel/trace/fgraph.c:239
 return_to_handler+0x1c/0x38 arch/arm64/kernel/entry-ftrace.S:333
 default_idle_call+0x94/0x38c kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0x240/0x290 kernel/sched/idle.c:299
 rest_init+0x1e8/0x2dc init/main.c:722
 arch_call_rest_init+0x1c/0x28
 start_kernel+0x638/0x670 init/main.c:1066
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())possible reason: unannotated irqs-off.
irq event stamp: 1719
hardirqs last  enabled at (1719): [<ffffa97d6bc33094>] exit_el1_irq_or_nmi+0x24/0x50 arch/arm64/kernel/entry-common.c:101
hardirqs last disabled at (1716): [<ffffa97d6bc33060>] enter_el1_irq_or_nmi+0x20/0x30 arch/arm64/kernel/entry-common.c:93
softirqs last  enabled at (1718): [<ffffa97d6a835930>] return_to_handler+0x0/0x38 arch/arm64/kernel/entry-ftrace.S:314
softirqs last disabled at (1717): [<ffffa97d6a8c6880>] irq_enter_rcu+0x88/0xa8 kernel/softirq.c:363
PASSED
pinctrl core: initialized pinctrl subsystem
DMI not present or invalid.
NET: Registered protocol family 16
DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(81.200:1): state=initialized audit_enabled=0 res=1
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'power_allocator'
cpuidle: using governor menu
hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
ASID allocator initialised with 32768 entries
Serial: AMBA PL011 UART driver
9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 47, base_baud = 0) is a PL011 rev1
printk: console [ttyAMA0] enabled
printk: console [ttyAMA0] enabled
printk: bootconsole [pl11] disabled
printk: bootconsole [pl11] disabled
HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
cryptd: max_cpu_qlen set to 1000
ACPI: Interpreter disabled.
iommu: Default domain type: Translated 
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
FPGA manager framework
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource arch_sys_counter
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
pnp: PnP ACPI: disabled
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 1024 (order: 4, 81920 bytes, linear)
TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
TCP bind hash table entries: 16384 (order: 8, 1179648 bytes, linear)
TCP: Hash tables configured (established 16384 bind 16384)
UDP hash table entries: 1024 (order: 5, 163840 bytes, linear)
UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes, linear)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
hw perfevents: enabled with armv8_pmuv3 PMU driver, 5 counters available
kvm [1]: HYP mode not available
Initialise system trusted keyrings
workingset: timestamp_bits=44 max_order=19 bucket_order=0
squashfs: version 4.0 (2009/01/31) Phillip Lougher
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
9p: Installing v9fs 9p2000 file system support
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
io scheduler mq-deadline registered
io scheduler kyber registered
pl061_gpio 9030000.pl061: PL061 GPIO chip registered
pci-host-generic 4010000000.pcie: host bridge /pcie@10000000 ranges:
pci-host-generic 4010000000.pcie:       IO 0x003eff0000..0x003effffff -> 0x0000000000
pci-host-generic 4010000000.pcie:      MEM 0x0010000000..0x003efeffff -> 0x0010000000
pci-host-generic 4010000000.pcie:      MEM 0x8000000000..0xffffffffff -> 0x8000000000
pci-host-generic 4010000000.pcie: ECAM at [mem 0x4010000000-0x401fffffff] for [bus 00-ff]
pci-host-generic 4010000000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff]
pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff]
pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
pci 0000:00:01.0: [1af4:1009] type 00 class 0x000200
pci 0000:00:01.0: reg 0x10: [io  0x0000-0x003f]
pci 0000:00:01.0: reg 0x14: [mem 0x00000000-0x00000fff]
pci 0000:00:01.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
pci 0000:00:02.0: [1af4:1009] type 00 class 0x000200
pci 0000:00:02.0: reg 0x10: [io  0x0000-0x003f]
pci 0000:00:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
pci 0000:00:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
pci 0000:00:03.0: reg 0x10: [io  0x0000-0x001f]
pci 0000:00:03.0: reg 0x14: [mem 0x00000000-0x00000fff]
pci 0000:00:03.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
pci 0000:00:03.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
pci 0000:00:04.0: [1af4:1004] type 00 class 0x010000
pci 0000:00:04.0: reg 0x10: [io  0x0000-0x003f]
pci 0000:00:04.0: reg 0x14: [mem 0x00000000-0x00000fff]
pci 0000:00:04.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
pci 0000:00:03.0: BAR 6: assigned [mem 0x10000000-0x1003ffff pref]
pci 0000:00:01.0: BAR 4: assigned [mem 0x8000000000-0x8000003fff 64bit pref]
pci 0000:00:02.0: BAR 4: assigned [mem 0x8000004000-0x8000007fff 64bit pref]
pci 0000:00:03.0: BAR 4: assigned [mem 0x8000008000-0x800000bfff 64bit pref]
pci 0000:00:04.0: BAR 4: assigned [mem 0x800000c000-0x800000ffff 64bit pref]
pci 0000:00:01.0: BAR 1: assigned [mem 0x10040000-0x10040fff]
pci 0000:00:02.0: BAR 1: assigned [mem 0x10041000-0x10041fff]
pci 0000:00:03.0: BAR 1: assigned [mem 0x10042000-0x10042fff]
pci 0000:00:04.0: BAR 1: assigned [mem 0x10043000-0x10043fff]
pci 0000:00:01.0: BAR 0: assigned [io  0x1000-0x103f]
pci 0000:00:02.0: BAR 0: assigned [io  0x1040-0x107f]
pci 0000:00:04.0: BAR 0: assigned [io  0x1080-0x10bf]
pci 0000:00:03.0: BAR 0: assigned [io  0x10c0-0x10df]
EINJ: ACPI disabled.
virtio-pci 0000:00:01.0: enabling device (0000 -> 0003)
virtio-pci 0000:00:02.0: enabling device (0000 -> 0003)
virtio-pci 0000:00:03.0: enabling device (0000 -> 0003)
virtio-pci 0000:00:04.0: enabling device (0000 -> 0003)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
SuperH (H)SCI(F) driver initialized
msm_serial: driver initialized
cacheinfo: Unable to detect cache hierarchy for CPU 0
loop: module loaded
megasas: 07.714.04.00-rc1
scsi host0: Virtio SCSI HBA
scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
random: fast init done
sd 0:0:0:0: Power-on or device reset occurred
sd 0:0:0:0: [sda] 524288 512-byte logical blocks: (268 MB/256 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 63 00 00 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sda: detected capacity change from 0 to 268435456
physmap-flash 0.flash: physmap platform flash device: [mem 0x00000000-0x03ffffff]
0.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000000 Chip ID 0x000000
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
erase region 0: offset=0x0,size=0x40000,blocks=256
physmap-flash 0.flash: physmap platform flash device: [mem 0x04000000-0x07ffffff]
0.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000000 Chip ID 0x000000
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
erase region 0: offset=0x0,size=0x40000,blocks=256
Concatenating MTD devices:
(0): "0.flash"
(1): "0.flash"
into device "0.flash"
sda: detected capacity change from 0 to 268435456
sd 0:0:0:0: [sda] Attached SCSI disk
libphy: Fixed MDIO Bus: probed
tun: Universal TUN/TAP device driver, 1.6
thunder_xcv, ver 1.0
thunder_bgx, ver 1.0
nicpf, ver 1.0
hclge is initializing
hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
hns3: Copyright (c) 2017 Huawei Corporation.
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
igb: Intel(R) Gigabit Ethernet Network Driver
igb: Copyright (c) 2007-2014 Intel Corporation.
igbvf: Intel(R) Gigabit Virtual Function Network Driver
igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
sky2: driver version 1.30
VFIO - User Level meta-driver version: 0.3
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-platform: EHCI generic platform driver
ehci-orion: EHCI orion driver
ehci-exynos: EHCI Exynos driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-platform: OHCI generic platform driver
ohci-exynos: OHCI Exynos driver
usbcore: registered new interface driver usb-storage
rtc-pl031 9010000.pl031: registered as rtc0
rtc-pl031 9010000.pl031: setting system clock to 2020-11-25T09:39:22 UTC (1606297162)
i2c /dev entries driver
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
Synopsys Designware Multimedia Card Interface Driver
sdhci-pltfm: SDHCI platform and OF driver helper
ledtrig-cpu: registered to indicate activity on CPUs
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
drop_monitor: Initializing network drop monitor service
NET: Registered protocol family 17
9pnet: Installing 9P2000 support
Key type dns_resolver registered
registered taskstats version 1
Running tests on all trace events:
Testing all events: OK
Running tests again, along with the function tracer
Running tests on all trace events:
Testing all events: 
hrtimer: interrupt took 11560624 ns
OK
Testing ftrace filter: OK
Loading compiled-in X.509 certificates
input: gpio-keys as /devices/platform/gpio-keys/input/input0
ALSA device list:
  No soundcards found.
TAP version 14
1..0
uart-pl011 9000000.pl011: no DMA platform data
EXT4-fs (sda): mounting ext3 file system using the ext4 subsystem
EXT4-fs (sda): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext3 filesystem) readonly on device 8:0.
devtmpfs: mounted
Freeing unused kernel memory: 8896K
Run /sbin/init as init process
  with arguments:
    /sbin/init
  with environment:
    HOME=/
    TERM=linux
    earlyprintk=serial
EXT4-fs (sda): re-mounted. Opts: (null)
ext3 filesystem being remounted at / supports timestamps until 2038 (0x7fffffff)
random: crng init done

--CE+1k2dSO48ffgeK--
