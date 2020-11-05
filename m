Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B273BC388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A76A20A8B
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617525;
	bh=2BmXTko68ZDsIesT0vZJ3kqsugp9QBTU7Q1/k551dHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nsG0CJV4oJPM1G+uZyJ3xZB63wyxdasIw3a/hQsxJ/HJE5a2gTUQRHEuon6UwsKf2
	 mseNks/NxO+jDbbHclLr4+59TCAlFnyFMC4Duz9IsjZwt3CoKSJkRhQs3WPqnQEaxS
	 53EYj9H+FYcs8QL8vA8b/6qU9JMwdv/1pquzaGN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgKEXFO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732396AbgKEXFO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:05:14 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034A421556;
        Thu,  5 Nov 2020 23:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617513;
        bh=2BmXTko68ZDsIesT0vZJ3kqsugp9QBTU7Q1/k551dHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SETiUM3273kWF4T3HdHKAwxQtb+dcBQLUyUzjktwgOL/GAN7PxzjIHPTjXYKYCtPO
         kO/8fsmWkKLmUe7mM9koh5XS2s1WzEFXvfuxI0xyB9LR574NwgMQRRoTPmIOei9EVa
         iASdJBgSENitLKB9ghzFB8NPLpv3dA1u+S56+rps=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/4] docs: Update RCU's hotplug requirements with a bit about design
Date:   Thu,  5 Nov 2020 15:05:08 -0800
Message-Id: <20201105230510.18660-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230444.GA18574@paulmck-ThinkPad-P72>
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The rcu_barrier() section of the "Hotplug CPU" section discusses
deadlocks, however the description of deadlocks other than those involving
rcu_barrier() is rather incomplete.

This commit therefore continues the section by describing how RCU's
design handles CPU hotplug in a deadlock-free way.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst       | 49 +++++++++++++++++-----
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 1ae79a1..98557fe 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1929,16 +1929,45 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
 to allow the various kernel subsystems (including RCU) to respond
 appropriately to a given CPU-hotplug operation. Most RCU operations may
 be invoked from CPU-hotplug notifiers, including even synchronous
-grace-period operations such as ``synchronize_rcu()`` and
-``synchronize_rcu_expedited()``.
-
-However, all-callback-wait operations such as ``rcu_barrier()`` are also
-not supported, due to the fact that there are phases of CPU-hotplug
-operations where the outgoing CPU's callbacks will not be invoked until
-after the CPU-hotplug operation ends, which could also result in
-deadlock. Furthermore, ``rcu_barrier()`` blocks CPU-hotplug operations
-during its execution, which results in another type of deadlock when
-invoked from a CPU-hotplug notifier.
+grace-period operations such as (``synchronize_rcu()`` and
+``synchronize_rcu_expedited()``).  However, these synchronous operations
+do block and therefore cannot be invoked from notifiers that execute via
+``stop_machine()``, specifically those between the ``CPUHP_AP_OFFLINE``
+and ``CPUHP_AP_ONLINE`` states.
+
+In addition, all-callback-wait operations such as ``rcu_barrier()`` may
+not be invoked from any CPU-hotplug notifier.  This restriction is due
+to the fact that there are phases of CPU-hotplug operations where the
+outgoing CPU's callbacks will not be invoked until after the CPU-hotplug
+operation ends, which could also result in deadlock. Furthermore,
+``rcu_barrier()`` blocks CPU-hotplug operations during its execution,
+which results in another type of deadlock when invoked from a CPU-hotplug
+notifier.
+
+Finally, RCU must avoid deadlocks due to interaction between hotplug,
+timers and grace period processing. It does so by maintaining its own set
+of books that duplicate the centrally maintained ``cpu_online_mask``,
+and also by reporting quiescent states explictly when a CPU goes
+offline.  This explicit reporting of quiescent states avoids any need
+for the force-quiescent-state loop (FQS) to report quiescent states for
+offline CPUs.  However, as a debugging measure, the FQS loop does splat
+if offline CPUs block an RCU grace period for too long.
+
+An offline CPU's quiescent state will be reported either:
+1.  As the CPU goes offline using RCU's hotplug notifier (``rcu_report_dead()``).
+2.  When grace period initialization (``rcu_gp_init()``) detects a
+    race either with CPU offlining or with a task unblocking on a leaf
+    ``rcu_node`` structure whose CPUs are all offline.
+
+The CPU-online path (``rcu_cpu_starting()``) should never need to report
+a quiescent state for an offline CPU.  However, as a debugging measure,
+it does emit a warning if a quiescent state was not already reported
+for that CPU.
+
+During the checking/modification of RCU's hotplug bookkeeping, the
+corresponding CPU's leaf node lock is held. This avoids race conditions
+between RCU's hotplug notifier hooks, the grace period initialization
+code, and the FQS loop, all of which refer to or modify this bookkeeping.
 
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
-- 
2.9.5

