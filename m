Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1F28CF69;
	Wed,  9 Jul 2025 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057713; cv=none; b=Vi1CZXPPPU4k7uuKW2cmcsxZjdoiMbOfQTMgrk6+tpoKQ32QXdeCIyjS1ERHXBPHoVbIeKR0jDZPnhWWlUNrE0MLpeeRqq2BoK60H0HaZSqKqpfmDnZ9holhGi6b5cK4WGZ2rquCgRChG9FGc8b2YsCeap/nUZTF0MkKhy+ilkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057713; c=relaxed/simple;
	bh=+chBf2HZW9HmfqseG0+docrixkoKxthSGBjXdaZlYxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQLMiC2sIo8vsF2L82HIFdvnNv97eJItv4x1HJlN1Xcst7TqAKKPXuDUL0HSCpaG/hTRdzgY4y0oIMgudb6ICn/wbQlz422PnGItZba6RGciMZk+xSj99qYYivop0Xp+Cgk5zGqFMWUF5MHJDDv3xeYl5rvH6yUnbQxiVnzEI3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqpY0B+e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqpY0B+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9776CC4CEEF;
	Wed,  9 Jul 2025 10:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057713;
	bh=+chBf2HZW9HmfqseG0+docrixkoKxthSGBjXdaZlYxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tqpY0B+eIQSVZouH73Jb8rFfJNGoUoYOok4YDK6fCIcLvD2RjoYm/43wJjKkietqj
	 v0nHcL1WVVRLMc1Q7DWmxjKG6s3vdEUmW1pM9aR1OK3d2omE+i4Wyjn5rbO24Si+LJ
	 PoIz2aYe/MlD0ZKxr/PmKv258SQPxIVlX8mpJAuuASQYehM15B6OQZdYtCJ6EKd2/y
	 H/8XzynMhHsaYhF038hoj2RGJWxTgMLxP9uwRBa2GnymrVLv6aTG4cXJnNAkDSxqYM
	 NP/lkMPyhTPtV/Qo1BFI4dgam+UdMZQXrImFrQNzmIZzJgipOBB/AgyU6T74fVgSi1
	 DjmuKGfmssM9Q==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 3/5] rcu: Enable rcu_normal_wake_from_gp on small systems
Date: Wed,  9 Jul 2025 16:11:16 +0530
Message-Id: <20250709104118.15532-4-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
References: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Automatically enable the rcu_normal_wake_from_gp parameter on
systems with a small number of CPUs. The activation threshold
is set to 16 CPUs.

This helps to reduce a latency of normal synchronize_rcu() API
by waking up GP-waiters earlier and decoupling synchronize_rcu()
callers from regular callback handling.

A benchmark running 64 parallel jobs(system with 64 CPUs) invoking
synchronize_rcu() demonstrates a notable latency reduction with the
setting enabled.

Latency distribution (microseconds):

<default>
 0      - 9999   : 1
 10000  - 19999  : 4
 20000  - 29999  : 399
 30000  - 39999  : 3197
 40000  - 49999  : 10428
 50000  - 59999  : 17363
 60000  - 69999  : 15529
 70000  - 79999  : 9287
 80000  - 89999  : 4249
 90000  - 99999  : 1915
 100000 - 109999 : 922
 110000 - 119999 : 390
 120000 - 129999 : 187
 ...
<default>

<rcu_normal_wake_from_gp>
 0      - 9999  : 1
 10000  - 19999 : 234
 20000  - 29999 : 6678
 30000  - 39999 : 33463
 40000  - 49999 : 20669
 50000  - 59999 : 2766
 60000  - 69999 : 183
 ...
<rcu_normal_wake_from_gp>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f83bbb408895..8c22db759978 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1632,8 +1632,10 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
 	atomic_set_release(&sr_wn->inuse, 0);
 }
 
-/* Disabled by default. */
-static int rcu_normal_wake_from_gp;
+/* Enable rcu_normal_wake_from_gp automatically on small systems. */
+#define WAKE_FROM_GP_CPU_THRESHOLD 16
+
+static int rcu_normal_wake_from_gp = -1;
 module_param(rcu_normal_wake_from_gp, int, 0644);
 static struct workqueue_struct *sync_wq;
 
@@ -3250,7 +3252,7 @@ static void synchronize_rcu_normal(void)
 
 	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
 
-	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
+	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
 		wait_rcu_gp(call_rcu_hurry);
 		goto trace_complete_out;
 	}
@@ -4854,6 +4856,12 @@ void __init rcu_init(void)
 	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!sync_wq);
 
+	/* Respect if explicitly disabled via a boot parameter. */
+	if (rcu_normal_wake_from_gp < 0) {
+		if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
+			rcu_normal_wake_from_gp = 1;
+	}
+
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
 	if (qovld < 0)
-- 
2.40.1

