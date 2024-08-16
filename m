Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79513B58E;
	Fri, 16 Aug 2024 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791862; cv=none; b=JsHUcuXHjeEhNhBFhrnQKVhio0ZTucEaYj6Pe4s0fqV1sd31bmQRmClo2lbjP31w71LBpUCXYh2AARpTUnCnTX4jIXytmh4xd5Mgt03dkYxkjKEASpgPtUW4d2Q7ejfCO8kYJxOT+x5gS3VtJocq/yAMNAr0hN/Cb26PSvKJtaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791862; c=relaxed/simple;
	bh=K5JsMoDhxJRgPGCUcAXtKOF5CRFQ1NO+CwBhPjeO2Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOJ4K2oTnw5fz8jLYQ7WMQCBn8ff5k5CwGfMSgTpFr5UGM7SQ945X2Uzc+EZk+MGAvrMzPb6QwR8dzadIDPFvesoGkCiYf0kaXCOJ0uTXpZEsDkLcbSSnM0j81l8d/vdmIqBlWLgsht8QGLA995OqJoXsWCcvyJRra3bsOJ566o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGYON0pT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGYON0pT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EFCC4AF0E;
	Fri, 16 Aug 2024 07:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791862;
	bh=K5JsMoDhxJRgPGCUcAXtKOF5CRFQ1NO+CwBhPjeO2Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGYON0pTvlUIk1eXtfmjBNkEf2mTpveSnkH87A0K2U8x0eak5xJcfTCtf0or260ej
	 vMy3Lrdbl6Ru62aR0sxLNoYOfqEUQyg+gGPTwBpe3sSxseYIYXdXssCpTPW3rmXYjx
	 O+sQUTrua61Pe7Gl/ePVnzaySXx5i5qd/7bLnHbjJsewrt7ALgF8dBM8EpoQvk+zB4
	 aOWhptKTFFRhhMQQ6KVLCtTBSd37garo7f2+yGM22uFR5XBpOCO1X3N8ccC5YEVJLd
	 BVIN+/CuzQvm6nQpTOuBk2qhlY9MTqaRI1nGAbf/Gn6bsGeHAoAuVlxapQw9BuNbs0
	 Ffaj2vTwzu3pw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 05/14] rcuscale: Dump grace-period statistics when rcu_scale_writer() stalls
Date: Fri, 16 Aug 2024 12:32:47 +0530
Message-Id: <20240816070256.60993-5-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816070209.GA60666@neeraj.linux>
References: <20240816070209.GA60666@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a .stats function pointer to the rcu_scale_ops structure,
and if this is non-NULL, it is invoked after stack traces are dumped in
response to a rcu_scale_writer() stall.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcuscale.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 5087ca7062d9..1b9a43653d7e 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -145,6 +145,7 @@ struct rcu_scale_ops {
 	void (*sync)(void);
 	void (*exp_sync)(void);
 	struct task_struct *(*rso_gp_kthread)(void);
+	void (*stats)(void);
 	const char *name;
 };
 
@@ -226,6 +227,11 @@ static void srcu_scale_synchronize(void)
 	synchronize_srcu(srcu_ctlp);
 }
 
+static void srcu_scale_stats(void)
+{
+	srcu_torture_stats_print(srcu_ctlp, scale_type, SCALE_FLAG);
+}
+
 static void srcu_scale_synchronize_expedited(void)
 {
 	synchronize_srcu_expedited(srcu_ctlp);
@@ -243,6 +249,7 @@ static struct rcu_scale_ops srcu_ops = {
 	.gp_barrier	= srcu_rcu_barrier,
 	.sync		= srcu_scale_synchronize,
 	.exp_sync	= srcu_scale_synchronize_expedited,
+	.stats		= srcu_scale_stats,
 	.name		= "srcu"
 };
 
@@ -272,6 +279,7 @@ static struct rcu_scale_ops srcud_ops = {
 	.gp_barrier	= srcu_rcu_barrier,
 	.sync		= srcu_scale_synchronize,
 	.exp_sync	= srcu_scale_synchronize_expedited,
+	.stats		= srcu_scale_stats,
 	.name		= "srcud"
 };
 
@@ -563,6 +571,8 @@ rcu_scale_writer(void *arg)
 					pr_info("%s: Task %ld flags writer %d:\n", __func__, me, i);
 					sched_show_task(writer_tasks[i]);
 				}
+				if (cur_ops->stats)
+					cur_ops->stats();
 			}
 		}
 		if (started && !alldone && i < MAX_MEAS - 1)
-- 
2.40.1

