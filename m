Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3D17547;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559391; cv=none; b=GSjobiXWEW/KSVqjALm0iy56bCwiiUpYFMPYYVXsfIjdMelJqU/0nKZwMJmkV0qkJMb2MPGBKhIlzryZ1hS1pLbgQP2nxuGZtuLQd53JYoSenVpGTgVGmloGtN6vMHXnky1ZEbU9nW1IOiT9QWlbekle3UBIyUcZ5BYA/FM3EUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559391; c=relaxed/simple;
	bh=YyIr4NQsi1NoigTr7BSqbvmIgl5FYqqqdCsPh4aHIdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZAMKqqnlu0ueHLJsMA03QRSi3ZSQhKb6NzW5A4Ylp38hEYlpjQFSsT70MpTgMR+CEqk1UAzmCLrnmcfRBrV8MhSX5i69HbXm8ln8TEdBmiyGqA0Clx+G2sjHtndCa7VIgxhHrgloW+ZV2304AONpg60VqDIjaLWu4RaRnON0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXJx/+bK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXJx/+bK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6C2C4AF0F;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559391;
	bh=YyIr4NQsi1NoigTr7BSqbvmIgl5FYqqqdCsPh4aHIdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXJx/+bKPMGudXqBCHmmQnyn4qjw/tsJw1EhJadZ9La7z5vZraNExkFghbpjaRJEI
	 7YGxr4fSz1ZzrK9GAg60x9+YNp11O5gXy8fZcvV7wnfwbqV7Ju1DkO9xZUqWPFRnlu
	 C9+i2ez+dnD6f6insr2AcYuULd6yM0un4uv2pCLx4xcF+vGy5swIzMDNz4Jtozaiin
	 Zv/i0W1IM5ycDC3+k0IFobaGMwk6J2IKvkkUuLX6zb+GjatKxiu42lFaecvk6GvHcU
	 pjiMM11I3T/Z3FKXaLeWeU1a+UCtnVU6sAW8n0J4gf6AIiYS/G2JADQkjiZpH5q6/z
	 3rqE0N+VtS+jA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C8A89CE0F69; Thu,  1 Aug 2024 17:43:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/11] rcuscale: Print detailed grace-period and barrier diagnostics
Date: Thu,  1 Aug 2024 17:43:02 -0700
Message-Id: <20240802004308.4134731-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
References: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit uses the new  rcu_tasks_torture_stats_print(),
rcu_tasks_trace_torture_stats_print(), and
rcu_tasks_rude_torture_stats_print() functions in order to provide
detailed diagnostics on grace-period, callback, and barrier state when
rcu_scale_writer() hangs.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index ddfb96e5a4e1e..933014b381ec0 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -298,6 +298,11 @@ static void tasks_scale_read_unlock(int idx)
 {
 }
 
+static void rcu_tasks_scale_stats(void)
+{
+	rcu_tasks_torture_stats_print(scale_type, SCALE_FLAG);
+}
+
 static struct rcu_scale_ops tasks_ops = {
 	.ptype		= RCU_TASKS_FLAVOR,
 	.init		= rcu_sync_scale_init,
@@ -310,6 +315,7 @@ static struct rcu_scale_ops tasks_ops = {
 	.sync		= synchronize_rcu_tasks,
 	.exp_sync	= synchronize_rcu_tasks,
 	.rso_gp_kthread	= get_rcu_tasks_gp_kthread,
+	.stats		= IS_ENABLED(CONFIG_TINY_RCU) ? NULL : rcu_tasks_scale_stats,
 	.name		= "tasks"
 };
 
@@ -336,6 +342,11 @@ static void tasks_rude_scale_read_unlock(int idx)
 {
 }
 
+static void rcu_tasks_rude_scale_stats(void)
+{
+	rcu_tasks_rude_torture_stats_print(scale_type, SCALE_FLAG);
+}
+
 static struct rcu_scale_ops tasks_rude_ops = {
 	.ptype		= RCU_TASKS_RUDE_FLAVOR,
 	.init		= rcu_sync_scale_init,
@@ -346,6 +357,7 @@ static struct rcu_scale_ops tasks_rude_ops = {
 	.sync		= synchronize_rcu_tasks_rude,
 	.exp_sync	= synchronize_rcu_tasks_rude,
 	.rso_gp_kthread	= get_rcu_tasks_rude_gp_kthread,
+	.stats		= IS_ENABLED(CONFIG_TINY_RCU) ? NULL : rcu_tasks_rude_scale_stats,
 	.name		= "tasks-rude"
 };
 
@@ -374,6 +386,11 @@ static void tasks_trace_scale_read_unlock(int idx)
 	rcu_read_unlock_trace();
 }
 
+static void rcu_tasks_trace_scale_stats(void)
+{
+	rcu_tasks_trace_torture_stats_print(scale_type, SCALE_FLAG);
+}
+
 static struct rcu_scale_ops tasks_tracing_ops = {
 	.ptype		= RCU_TASKS_FLAVOR,
 	.init		= rcu_sync_scale_init,
@@ -386,6 +403,7 @@ static struct rcu_scale_ops tasks_tracing_ops = {
 	.sync		= synchronize_rcu_tasks_trace,
 	.exp_sync	= synchronize_rcu_tasks_trace,
 	.rso_gp_kthread	= get_rcu_tasks_trace_gp_kthread,
+	.stats		= IS_ENABLED(CONFIG_TINY_RCU) ? NULL : rcu_tasks_trace_scale_stats,
 	.name		= "tasks-tracing"
 };
 
-- 
2.40.1

