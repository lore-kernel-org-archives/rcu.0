Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3164C433F5
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EE16323F
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 15:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbhKQP7v (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:59:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238830AbhKQP7u (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 10:59:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DEA661BF9;
        Wed, 17 Nov 2021 15:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637164611;
        bh=akrvdSgILv+AtjvLA7XHSvOukiLsF3vOWVjd2eHeZR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nR1Qd92rpG+oWrwZ0M8UKZMLvxBvnDo1IS2ffecnwar17DTdUSj5mj83aUHYJD/ik
         mzcxqd0pQhQVhc5SXRWQ8vKEUIL4zCuQ1KRfpjSeFLb20E/nIsodASfwzPjbOerqX+
         P9v/MYpzZZTmwZcJau98S8F08gABKJK0IgjkLpjJ+2NvBD+Lv8HZUQG0K6VnhptCt6
         Qzz98m1hXIoeZV3PS8sIfWqjDZs2gtqcjUop/yZGyI7/TTw2fZjafSQncWpXQqk8Wy
         TlACkBUGuFcOOThF+kfdbeQ/xSCEBqSDzYok0S2MH93TRyWZRKtQy+0z8MGcyar6XF
         AR5IWN9C0ixNA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 3/6] rcu/nocb: Optimize kthreads and rdp initialization
Date:   Wed, 17 Nov 2021 16:56:34 +0100
Message-Id: <20211117155637.363706-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117155637.363706-1-frederic@kernel.org>
References: <20211117155637.363706-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently cpumask_available() is used to prevent from unwanted
NOCB initialization. However if "rcu_nocbs=" isn't passed but
CONFIG_CPUMASK_OFFSTACK=n, the initialization path is still taken,
running through all sorts of needless operations and iterations on an
empty cpumask.

Fix this with relying on a real initialization state instead. This
also optimize kthreads creation, sparing iteration over all online CPUs
when nocb isn't initialized.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0543d5e913bb..9fe4be10fde7 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -60,6 +60,9 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
  * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
  * If the list is invalid, a warning is emitted and all CPUs are offloaded.
  */
+
+static bool rcu_nocb_is_setup;
+
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
@@ -67,6 +70,7 @@ static int __init rcu_nocb_setup(char *str)
 		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
 		cpumask_setall(rcu_nocb_mask);
 	}
+	rcu_nocb_is_setup = true;
 	return 1;
 }
 __setup("rcu_nocbs=", rcu_nocb_setup);
@@ -1151,13 +1155,17 @@ void __init rcu_init_nohz(void)
 		need_rcu_nocb_mask = true;
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
-	if (!cpumask_available(rcu_nocb_mask) && need_rcu_nocb_mask) {
-		if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
-			pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
-			return;
+	if (need_rcu_nocb_mask) {
+		if (!cpumask_available(rcu_nocb_mask)) {
+			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
+				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
+				return;
+			}
 		}
+		rcu_nocb_is_setup = true;
 	}
-	if (!cpumask_available(rcu_nocb_mask))
+
+	if (!rcu_nocb_is_setup)
 		return;
 
 #if defined(CONFIG_NO_HZ_FULL)
@@ -1259,8 +1267,10 @@ static void __init rcu_spawn_nocb_kthreads(void)
 {
 	int cpu;
 
-	for_each_online_cpu(cpu)
-		rcu_spawn_cpu_nocb_kthread(cpu);
+	if (rcu_nocb_is_setup) {
+		for_each_online_cpu(cpu)
+			rcu_spawn_cpu_nocb_kthread(cpu);
+	}
 }
 
 /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
-- 
2.25.1

