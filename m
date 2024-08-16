Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910B126F2A;
	Fri, 16 Aug 2024 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791875; cv=none; b=cy5/EPrBOUY13qrnsdJUREEas8Kj9UZZbR5x4XcdIrV0INa+9bGhDXspGCRN28mBSdbdfaMGEl0Bq0JoFJKVvOWbtq71CBcQljCrsZF+vLxPkbdNYCOzUUgE7NTKHyPpkHexzI7DQhNJMH694NVfj8ZIbnG9f7+suZDgNIJc9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791875; c=relaxed/simple;
	bh=rGx98LRQ4fzsdM/wfrRs6MgCPfxa8nno7GmWNehrPtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1+6R5Ev8rRjn9cPcH8Xo493/R8aBy/r6CsbE1Ey040x1/ZQepct8t4qZ1IN/q9ny2KqJPAC3p/SZM/7PLto1zE+srSXW6UlbxISAW42iyCTb2MkKIrGvqtSKYN3qg3Et9nM6MwTM22Ifv0K3OjsahxBqrwdyTCshC16vpy6RSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn4ggiKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn4ggiKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78C6C4AF09;
	Fri, 16 Aug 2024 07:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791874;
	bh=rGx98LRQ4fzsdM/wfrRs6MgCPfxa8nno7GmWNehrPtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kn4ggiKeNAh9c04GZchvKGjegP3P12bDm4ZTGfiOoAPkOjtgqXAmKrirLmdDij/M4
	 lcpQe/SIz2dGLmK4CACHOMYKszNuhSKOA5yDekXA1R/PxFjGkiQEUy9B4molU4Ph/B
	 k9Zf4so2ro69ApbuLFxN9Qwrhttil8SIX8LXS8g3cJTFYObinuiwGgM4HYeiNh/BWd
	 mGAam9Hr0sgWWSumW9EgWzEj57ZvZpyBLjOmsXNT4bqYtKXX3bRBAbW8QaBUAC78gp
	 Fjun2YP0u52AckriwQ+D2DEE3/BWocU8r9ElvTGsXoE1WYKtQRwKe8b4gxXlnhihng
	 f9etaXIDM/xJw==
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
Subject: [PATCH rcu 07/14] rcuscale: Print detailed grace-period and barrier diagnostics
Date: Fri, 16 Aug 2024 12:32:49 +0530
Message-Id: <20240816070256.60993-7-neeraj.upadhyay@kernel.org>
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

This commit uses the new  rcu_tasks_torture_stats_print(),
rcu_tasks_trace_torture_stats_print(), and
rcu_tasks_rude_torture_stats_print() functions in order to provide
detailed diagnostics on grace-period, callback, and barrier state when
rcu_scale_writer() hangs.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcuscale.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 1b9a43653d7e..c507750e94d8 100644
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

