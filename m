Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B66C433EF
	for <rcu@archiver.kernel.org>; Tue, 23 Nov 2021 00:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhKWAk6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232246AbhKWAkh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Nov 2021 19:40:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 253D061004;
        Tue, 23 Nov 2021 00:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637627850;
        bh=mprxUPw1okFhCPvyzxUdk3HOfO4zy+Y+8hUvrOqq7Nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnjltHdlSI5h2X15zjWt+RBusX3u9j3vEGACZSLwa/JMd6gnxd2acgEI/kmmBBRq2
         HAB+RKYxkX1omloi/3Vcr/MqinbT182uUe+czvSaHpiUxQ4qeEIM/J/G584RQuvD8w
         50Njuur+oIXSHHoX3Dpt45rjyddK8scXR5eHaA77BEh+DODHoHlefvPdrxVU3DQC99
         U80WF/pVTVzokr4Bz31BDa1qWDFfrzCLGPJcJi4viEKVoHqAJmuIAF0qjMehaSMtT1
         PqgsifgDJiTn+DvNouOilppoUuIj9J3h8RKht28s+v7GF7fpSlJEYliULoMq1FHw4J
         YObBcOLn0w+Ew==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 6/6] rcu/nocb: Merge rcu_spawn_cpu_nocb_kthread() and rcu_spawn_one_nocb_kthread()
Date:   Tue, 23 Nov 2021 01:37:08 +0100
Message-Id: <20211123003708.468409-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211123003708.468409-1-frederic@kernel.org>
References: <20211123003708.468409-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcu_spawn_one_nocb_kthread() is only called by
rcu_spawn_cpu_nocb_kthread(). Don't bother with two separate functions
and merge them.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index d915780d40c8..7e8da346127a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1225,12 +1225,15 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
  * rcuo CB kthread, spawn it.  Additionally, if the rcuo GP kthread
  * for this CPU's group has not yet been created, spawn it as well.
  */
-static void rcu_spawn_one_nocb_kthread(int cpu)
+static void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_data *rdp_gp;
 	struct task_struct *t;
 
+	if (!rcu_scheduler_fully_active || !rcu_nocb_is_setup)
+		return;
+
 	/* If it already has an rcuo kthread, then nothing to do. */
 	if (rdp->nocb_cb_kthread)
 		return;
@@ -1254,16 +1257,6 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 }
 
-/*
- * If the specified CPU is a no-CBs CPU that does not already have its
- * rcuo kthread, spawn it.
- */
-static void rcu_spawn_cpu_nocb_kthread(int cpu)
-{
-	if (rcu_scheduler_fully_active && rcu_nocb_is_setup)
-		rcu_spawn_one_nocb_kthread(cpu);
-}
-
 /*
  * Once the scheduler is running, spawn rcuo kthreads for all online
  * no-CBs CPUs.  This assumes that the early_initcall()s happen before
-- 
2.25.1

