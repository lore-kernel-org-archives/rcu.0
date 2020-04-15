Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D54C2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FF620784
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974825;
	bh=Rk2CxUrPJzLDOVHfjzdHQBbJbX/efNGj6HmojnwnvTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JyQb0ijcf3srj2u6tEutrkULjfgymkopwbLjXACLp26kRO/CPhsniuY1TzR86jTem
	 f6kVaIYGuDiEzreWSnLdAHYixe2yCvcZZTBdeUcHvDbHd3W9CISPvw0OWau71U5o34
	 MHP2OewcJPhwAUnte++ZK/LOw2z1YgfAYujwCZQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441422AbgDOSUX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441399AbgDOST4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 477B021D90;
        Wed, 15 Apr 2020 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974795;
        bh=Rk2CxUrPJzLDOVHfjzdHQBbJbX/efNGj6HmojnwnvTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6KnPy0zvKxzEFV1O9gO15U0bi2LaHh/E1cCq8ngDsV70l6UeiRj0dPhJq1evqCZx
         UQz2McGoYMp9iSIBijGPerJXHCwShaIyevhMwVTFR3mt1UGnTgoU5DHBDpiNPU6ua3
         bD7ffTwVmTIyiqqZLj2rUsEqY0X+QMjOsT2E0HZ0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 34/38] rcutorture: Add TRACE02 scenario enabling RCU Tasks Trace IPIs
Date:   Wed, 15 Apr 2020 11:19:37 -0700
Message-Id: <20200415181941.11653-34-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a TRACE02 scenario which enables preemption and RCU
Tasks Trace IPIs, more specifically, disabling heavyweight readers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST       |  1 +
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01      |  1 +
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02      | 11 +++++++++++
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot |  1 +
 4 files changed, 14 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE02
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index dfb1817..f2b20db 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -16,3 +16,4 @@ TASKS02
 TASKS03
 RUDE01
 TRACE01
+TRACE02
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
index 078e2c1..12e7661 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -7,4 +7,5 @@ CONFIG_PREEMPT=n
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 #CHECK#CONFIG_PROVE_RCU=y
+CONFIG_TASKS_TRACE_RCU_READ_MB=y
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
new file mode 100644
index 0000000..b69ed66
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
@@ -0,0 +1,11 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+CONFIG_HOTPLUG_CPU=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+#CHECK#CONFIG_PROVE_RCU=n
+CONFIG_TASKS_TRACE_RCU_READ_MB=n
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
new file mode 100644
index 0000000..9675ad6
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
@@ -0,0 +1 @@
+rcutorture.torture_type=tasks-tracing
-- 
2.9.5

