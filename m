Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94716C388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370C820786
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617827;
	bh=EBKXRZA+WNZ0UpWX3ui1bG5r7mNNDBe5p8zeNiIflb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aP1+8ihC9iHFCnxpnAtEwnWoeUmVQScGrrch6gwyCK0FLM4eZifmvgtfWf7UBvwc1
	 A7U/cNOb0Hpnb6kE071LrZ2pSqt+6kBtXqzsuQNEC6LsIq6NKlWVUJvfBiDkMrDf4x
	 pTIBNRKLn7vyNq0GR/98ZRGiDNlzcTVJypBg15b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgKEXJZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732046AbgKEXJZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A46E2083B;
        Thu,  5 Nov 2020 23:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617764;
        bh=EBKXRZA+WNZ0UpWX3ui1bG5r7mNNDBe5p8zeNiIflb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8Ua1NiRJ8Rbdv1uV/ra8fr0Vd0Yrwn7KZlEshvKSauOBekyA5sUlNmT+fV+ZgqZg
         IDpMn9qQhFzQufq8URe7JHfY1T1GlkyQIruMCN+qmIbGOhajNnCZYH+g0iitKAsggT
         Q4tY1vVPi3q3AJo8yoW/BrQ9YNitd+kjrlRJlUgw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/16] x86/smpboot:  Move rcu_cpu_starting() earlier
Date:   Thu,  5 Nov 2020 15:09:07 -0800
Message-Id: <20201105230921.19017-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The call to rcu_cpu_starting() in mtrr_ap_init() is not early enough
in the CPU-hotplug onlining process, which results in lockdep splats
as follows:

=============================
WARNING: suspicious RCU usage
5.9.0+ #268 Not tainted
-----------------------------
kernel/kprobes.c:300 RCU-list traversed in non-reader section!!

other info that might help us debug this:

RCU used illegally from offline CPU!
rcu_scheduler_active = 1, debug_locks = 1
no locks held by swapper/1/0.

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0+ #268
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 dump_stack+0x77/0x97
 __is_insn_slot_addr+0x15d/0x170
 kernel_text_address+0xba/0xe0
 ? get_stack_info+0x22/0xa0
 __kernel_text_address+0x9/0x30
 show_trace_log_lvl+0x17d/0x380
 ? dump_stack+0x77/0x97
 dump_stack+0x77/0x97
 __lock_acquire+0xdf7/0x1bf0
 lock_acquire+0x258/0x3d0
 ? vprintk_emit+0x6d/0x2c0
 _raw_spin_lock+0x27/0x40
 ? vprintk_emit+0x6d/0x2c0
 vprintk_emit+0x6d/0x2c0
 printk+0x4d/0x69
 start_secondary+0x1c/0x100
 secondary_startup_64_no_verify+0xb8/0xbb

This is avoided by moving the call to rcu_cpu_starting up near
the beginning of the start_secondary() function.  Note that the
raw_smp_processor_id() is required in order to avoid calling into lockdep
before RCU has declared the CPU to be watched for readers.

Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
Reported-by: Qian Cai <cai@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 2 --
 arch/x86/kernel/smpboot.c       | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 6a80f36..5f436cb 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -794,8 +794,6 @@ void mtrr_ap_init(void)
 	if (!use_intel() || mtrr_aps_delayed_init)
 		return;
 
-	rcu_cpu_starting(smp_processor_id());
-
 	/*
 	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
 	 * changed, but this routine will be called in cpu boot time,
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index de776b2..99bdceb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -229,6 +229,7 @@ static void notrace start_secondary(void *unused)
 #endif
 	cpu_init_exception_handling();
 	cpu_init();
+	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
 	preempt_disable();
 	smp_callin();
-- 
2.9.5

