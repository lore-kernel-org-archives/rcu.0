Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803AAC433FE
	for <rcu@archiver.kernel.org>; Tue, 19 Apr 2022 00:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiDSADC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbiDSAC7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCA713D2C;
        Mon, 18 Apr 2022 17:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71E3FB81135;
        Tue, 19 Apr 2022 00:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AC7C385A9;
        Tue, 19 Apr 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326416;
        bh=5RvY22qrA5+M1MxIQaC3zBsZAloMmunOEBx8nCIFweI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MzqPKgqdxdkO0t+B3BkeVP9Ie/wGz4j1e26YZJQVOnVOKWEqliHkqd/ffgpIbPmfE
         EXAnNnN8CRzvryxThjfMqy6fInMwUs6ikD8ZC37BUUv56dLRM79CUgplirDakvkON0
         80boKDfCaJz/pTLjIChEpdTMSR10NElvwslgPPAoPHex+LxGhaNs0hQRNEZTqD/tJR
         971UOCCs6JxZYHOnpdLr/WCmJSXsNhTr9cvO3aa25qaYUsk4F+OnBR/P2QaAcw2O0E
         3/T0UPPCGMwh0nlzBa5M3AmVytdnaqiivCxkFxzeHTGWJ5fRPtvbACVNXTk3Z8NSMs
         82VEroYcpbozw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DD4E85C0A0D; Mon, 18 Apr 2022 17:00:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Neil Spring <ntspring@fb.com>
Subject: [PATCH rcu 4/9] rcu-tasks: Make Tasks RCU account for userspace execution
Date:   Mon, 18 Apr 2022 17:00:09 -0700
Message-Id: <20220419000014.3948512-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The main Tasks RCU quiescent state is voluntary context switch.  However,
userspace execution is also a valid quiescent state, and is a valuable one
for userspace applications that spin repeatedly executing light-weight
non-sleeping system calls.  Currently, such an application can delay a
Tasks RCU grace period for many tens of seconds.

This commit therefore enlists the aid of the scheduler-clock interrupt to
provide a Tasks RCU quiescent state when it interrupted a task executing
in userspace.

[ paulmck: Apply feedback from kernel test robot. ]

Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Neil Spring <ntspring@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 1 +
 kernel/rcu/tree.c        | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index e7c39c200e2b..1a32036c918c 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -196,6 +196,7 @@ void synchronize_rcu_tasks_rude(void);
 void exit_tasks_rcu_start(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
+#define rcu_tasks_classic_qs(t, preempt) do { } while (0)
 #define rcu_tasks_qs(t, preempt) do { } while (0)
 #define rcu_note_voluntary_context_switch(t) do { } while (0)
 #define call_rcu_tasks call_rcu
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4b8189455d5..8dbfb63f0391 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2624,6 +2624,8 @@ void rcu_sched_clock_irq(int user)
 	rcu_flavor_sched_clock_irq(user);
 	if (rcu_pending(user))
 		invoke_rcu_core();
+	if (user)
+		rcu_tasks_classic_qs(current, false);
 	lockdep_assert_irqs_disabled();
 
 	trace_rcu_utilization(TPS("End scheduler-tick"));
-- 
2.31.1.189.g2e36527f23

