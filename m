Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFDFC433F5
	for <rcu@archiver.kernel.org>; Tue, 23 Nov 2021 00:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhKWAk5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232053AbhKWAke (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Nov 2021 19:40:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C703D60698;
        Tue, 23 Nov 2021 00:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637627847;
        bh=icI5/M2hLsyGCbhSphBc5coM9+SCPQ4/0Gx+CvfZzhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBUK5rdkpegzgDD2OFNfoLYh6rHYgUdMWN019V51TelYBY3xJFtlgcWgX9S63/fPh
         /ezq2HRjyKYiwRHYopGYphRH5mEKIwVKRAqTbezGmcxT56GeJqXAObR19hAjJ+TXJs
         18ba02urR+7wtGfEUT5q01ZyKmdW3tlS7V7VX73ZolbXoekGhPSZkrxrD7Zapzahcq
         q3im0kTGKNAZmtnYBGVWWXeT7nwgkULAS0KGy2XseoYnH2B7xQ6fLYqqSOVSv3VRm/
         mR8AOHgYbhWZzuu3SllyQqmuRN2rYsDL3x8nmW7Em7mhtN4jV/d25XRmZcntI/cz6j
         rnTF6xPOh8nRQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 5/6] rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
Date:   Tue, 23 Nov 2021 01:37:07 +0100
Message-Id: <20211123003708.468409-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211123003708.468409-1-frederic@kernel.org>
References: <20211123003708.468409-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If a user wants to boot without any CPU in offloaded mode initially but
with the possibility to offload them later using cpusets, provide a way
to simply pass an empty "rcu_nocbs" kernel parameter which will enforce
the creation of dormant nocb kthreads.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 .../admin-guide/kernel-parameters.txt         | 26 ++++++++++++-------
 kernel/rcu/tree_nocb.h                        | 10 ++++---
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cd860dc7c60b..6ff1a5f06383 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4351,20 +4351,28 @@
 				Disable the Correctable Errors Collector,
 				see CONFIG_RAS_CEC help text.
 
-	rcu_nocbs=	[KNL]
-			The argument is a cpu list, as described above.
+	rcu_nocbs[=cpu-list]
+			[KNL] The optional argument is a cpu list,
+			as described above.
 
-			In kernels built with CONFIG_RCU_NOCB_CPU=y, set
-			the specified list of CPUs to be no-callback CPUs.
-			Invocation of these CPUs' RCU callbacks will be
-			offloaded to "rcuox/N" kthreads created for that
-			purpose, where "x" is "p" for RCU-preempt, and
-			"s" for RCU-sched, and "N" is the CPU number.
-			This reduces OS jitter on the offloaded CPUs,
+			In kernels built with CONFIG_RCU_NOCB_CPU=y, enable the
+			no-callback CPU mode. Invocation of such CPUs' RCU
+			callbacks will be offloaded to "rcuox/N" kthreads
+			created	for that purpose, where "x" is "p" for
+			RCU-preempt, and "s" for RCU-sched, and "N" is the CPU
+			number.	This reduces OS jitter on the offloaded CPUs,
 			which can be useful for HPC and real-time
 			workloads.  It can also improve energy efficiency
 			for asymmetric multiprocessors.
 
+			If a cpulist is passed as an argument, the specified
+			list of	CPUs is set to no-callback mode from boot.
+
+			If otherwise the '=' sign and the cpulist arguments are
+			omitted, no CPU will be set to no-callback mode from
+			boot but cpuset will allow for toggling that mode at
+			runtime.
+
 	rcu_nocb_poll	[KNL]
 			Rather than requiring that offloaded CPUs
 			(specified by rcu_nocbs= above) explicitly
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 9d37916278d4..d915780d40c8 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -66,14 +66,16 @@ static bool rcu_nocb_is_setup;
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (cpulist_parse(str, rcu_nocb_mask)) {
-		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
-		cpumask_setall(rcu_nocb_mask);
+	if (*str == '=') {
+		if (cpulist_parse(++str, rcu_nocb_mask)) {
+			pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
+			cpumask_setall(rcu_nocb_mask);
+		}
 	}
 	rcu_nocb_is_setup = true;
 	return 1;
 }
-__setup("rcu_nocbs=", rcu_nocb_setup);
+__setup("rcu_nocbs", rcu_nocb_setup);
 
 static int __init parse_rcu_nocb_poll(char *arg)
 {
-- 
2.25.1

