Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.12.242.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085366;
	b=Dqji3xU180L4E/GLzFQ9WMO8t5nXtixBb1oU6EONL5Oo1DomLZJclFpQEN9BUI8dk08h
	 eHpYbdxgyUfjVlg7GXUAdzJa7xk33jp8sFirP5wBS2UF4YMxVWyqgd81+c0m16SGHQbEZ
	 k8b7ujmtHJarJnOMBFKYzOQe77iYXVYUdDUqylHWPtupTToFixvMPVC4yB80hPus7Azu+
	 Q0SmqI/ugRk65ApC3wvN17VQvqd3/X6PxkrJ89zSMtOQlIH8HYxgTUDl5OENWb2iyhn3K
	 aCgCziYuEpO0gwwGK4ZZm8t76y+fOBma+m4Rq9RIwzy3bVgA2cYRtQl1UBhpCx0/6nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085366;
	h=DMARC-Filter:Received:DKIM-Signature:X-ME-Helo:X-ME-Auth:X-ME-Date:
	 X-ME-IP:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ytzh+f2hWVC3qMgjXHHlQffaGWO1lgegsrFwsZaSV94=;
	b=SxvR20Q0nPWxZmzGX8qYIiB33IikFaG3Gz7EDp8sR5SmOrF1uiVcGyIWppJ1dpwQJPnd
	 4WknnAbKBmLVMiPcxomWUuQBtU4WRpsJLs1rhi0jygN9JNcvQiRUWv9//DCWKuvaeTzUE
	 LXFcPSdihPzndfYUUfQi0bTdOnR0Nf8sNymWJwsQzUUUoUd5dOg5MHMlkS4a6tbUbHa86
	 AoL+eIWzgVK4UPqs6AMqShlKHnfFEfOPPPqZx5BbOqEIbkLvUAxqR0xSNd3E1x2Qwq4L0
	 zXzm9L5RujTXBSp7f+3KUBtUzNqLfihpa0u+2eYN/RjJ1PcfcTYslui98Ww/MsvcsNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wanadoo.fr;
	spf=pass smtp.mailfrom=wanadoo.fr;
	dkim=pass header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=Uz0WNsLx;
	arc=none smtp.remote-ip=80.12.242.24
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0A2606A326;
	Sat,  7 Nov 2026 21:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B0A2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=Uz0WNsLx
Received: from 2a01cb1007850b0026fbaefb6cd2db0e.ipv6.abo.wanadoo.fr
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id PnYUxiovuisBxPnYUx0XoL; Sat, 07 Nov 2026 22:02:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1794085355;
	bh=ytzh+f2hWVC3qMgjXHHlQffaGWO1lgegsrFwsZaSV94=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Uz0WNsLxEF16vdVPY+YbsDFnNImuZ3W6BU6PRAfGxsIc5DyH2moF7RfbwvpZ+g/7d
	 Lpb0ZIUIFYrsQb78mi9qayr1IUjJjHcHVcnyrY2bAMuIfuB41eQ/A9zruKj7/uJJNi
	 E4+gR2fKa1L8k7XK7C5DVcCSAJuZAOkXfraINc8Pc3KqB5sPEpEjt2YlvdVu4TiBZH
	 H5Ptc1wpnnV04zL8NWXKdvPu8TtixBBQuUEbyjFNzwgTwllwH0qwceDyDUYHpWWiwo
	 dxzzzlfNZqEUsvCtQZkjOql/estwyHt5BwbSriD8KklBs8fOY7eFc3fPs6gGpY+CuA
	 oUcwEmjEjL/SA==
X-ME-Helo: 2a01cb1007850b0026fbaefb6cd2db0e.ipv6.abo.wanadoo.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Nov 2026 22:02:35 +0100
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	rcu@vger.kernel.org
Subject: [PATCH] rcuscale: Constify struct rcu_scale_ops
Date: Sat,  7 Nov 2026 22:02:25 +0100
Message-ID: <3f546f8e102ef271e7d5ac6d8b6a1f44d0fb20cb.1794085327.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct rcu_scale_ops' is not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  45585	  24946	   2816	  73347	  11e83	kernel/rcu/rcuscale.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  46545	  23986	   2816	  73347	  11e83	kernel/rcu/rcuscale.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 kernel/rcu/rcuscale.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 1097ec15879c..522f7bc2e693 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -159,7 +159,7 @@ struct rcu_scale_ops {
 	const char *name;
 };
 
-static struct rcu_scale_ops *cur_ops;
+static const struct rcu_scale_ops *cur_ops;
 
 /*
  * Definitions for rcu scalability testing.
@@ -185,7 +185,7 @@ static void rcu_sync_scale_init(void)
 {
 }
 
-static struct rcu_scale_ops rcu_ops = {
+static const struct rcu_scale_ops rcu_ops = {
 	.ptype		= RCU_FLAVOR,
 	.init		= rcu_sync_scale_init,
 	.readlock	= rcu_scale_read_lock,
@@ -247,7 +247,7 @@ static void srcu_scale_synchronize_expedited(void)
 	synchronize_srcu_expedited(srcu_ctlp);
 }
 
-static struct rcu_scale_ops srcu_ops = {
+static const struct rcu_scale_ops srcu_ops = {
 	.ptype		= SRCU_FLAVOR,
 	.init		= rcu_sync_scale_init,
 	.readlock	= srcu_scale_read_lock,
@@ -276,7 +276,7 @@ static void srcu_sync_scale_cleanup(void)
 	cleanup_srcu_struct(srcu_ctlp);
 }
 
-static struct rcu_scale_ops srcud_ops = {
+static const struct rcu_scale_ops srcud_ops = {
 	.ptype		= SRCU_FLAVOR,
 	.init		= srcu_sync_scale_init,
 	.cleanup	= srcu_sync_scale_cleanup,
@@ -313,7 +313,7 @@ static void rcu_tasks_scale_stats(void)
 	rcu_tasks_torture_stats_print(scale_type, SCALE_FLAG);
 }
 
-static struct rcu_scale_ops tasks_ops = {
+static const struct rcu_scale_ops tasks_ops = {
 	.ptype		= RCU_TASKS_FLAVOR,
 	.init		= rcu_sync_scale_init,
 	.readlock	= tasks_scale_read_lock,
@@ -357,7 +357,7 @@ static void rcu_tasks_rude_scale_stats(void)
 	rcu_tasks_rude_torture_stats_print(scale_type, SCALE_FLAG);
 }
 
-static struct rcu_scale_ops tasks_rude_ops = {
+static const struct rcu_scale_ops tasks_rude_ops = {
 	.ptype		= RCU_TASKS_RUDE_FLAVOR,
 	.init		= rcu_sync_scale_init,
 	.readlock	= tasks_rude_scale_read_lock,
@@ -396,7 +396,7 @@ static void tasks_trace_scale_read_unlock(int idx)
 	rcu_read_unlock_trace();
 }
 
-static struct rcu_scale_ops tasks_tracing_ops = {
+static const struct rcu_scale_ops tasks_tracing_ops = {
 	.ptype		= RCU_TASKS_FLAVOR,
 	.init		= rcu_sync_scale_init,
 	.readlock	= tasks_trace_scale_read_lock,
@@ -693,7 +693,7 @@ rcu_scale_writer(void *arg)
 }
 
 static void
-rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
+rcu_scale_print_module_parms(const struct rcu_scale_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" SCALE_FLAG
 		 "--- %s: gp_async=%d gp_async_max=%d gp_exp=%d holdoff=%d minruntime=%d nreaders=%d nwriters=%d nexp=%d exp_interval=%d writer_holdoff=%d writer_holdoff_jiffies=%d verbose=%d shutdown_secs=%d\n",
@@ -1109,7 +1109,7 @@ rcu_scale_init(void)
 	int firsterr = 0;
 	long i;
 	long j;
-	static struct rcu_scale_ops *scale_ops[] = {
+	static const struct rcu_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
 	};
 
-- 
2.56.0

