Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D128E610;
	Wed,  9 Jul 2025 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057944; cv=none; b=Juik+44wQFmDobWGgQlbHNuU+4IDVJxBKaKtOPkaomQisx9ddTOjt2BmEZ1jwkvwwVyCyTjOLgFAvPMcI/94sV3IxerRmkOHvLPD3ivbGYfSFRkYKeqqNBe7U6R5xcmndHziyEzrDJATVxvV96TYX+r8qjlUuUUx0VgLf9t4E8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057944; c=relaxed/simple;
	bh=jxOuxwTz2hUC8ZdEi1xl+DpWQ20Qh84KJl4y5qRS0vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9YLWZDgx2aNjAgKRpCJKoR4NAWI9fwq2fA6qdClAVSTSosHSCZa0jCxmXkfOkI7pHKOtDRUIUIMpKxbKwL6borbDH5l2E9FznHP5pUeB+TEeMji7TDL+4u15Yxx72SxSUm9efy72bgh+3Gmg+hsel9s9MyQqMG/doi3dJs79Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVWXnu1o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVWXnu1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8BBC4CEEF;
	Wed,  9 Jul 2025 10:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057944;
	bh=jxOuxwTz2hUC8ZdEi1xl+DpWQ20Qh84KJl4y5qRS0vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVWXnu1o/gU7dHKY1zMoUkIjRMWWYhbrClryx7fuMlKtDo2pPmbMOJQRuqKVG3Slq
	 4sMQ3TP0NCN4+iP1tj4s6ZGgCBb+hJV0tRijZ9eTsSYGIx2f/Fkk66c9WgLi9ENwXX
	 IhQn3AUkhBFLWHVxMZPj8/vX8c63SfcesgePyMVa8wkUDjJrEjlnBD3rQy3ai9LbwA
	 4t4DpgbzD8yFw79rmWwc6SDLaPuM90jT2OnSrTwj1f99qmNJxNTvLcglhaQ+lzGm+I
	 QkSaH155qcQMxOuiOTgc04MVQOjtMRjp0Xs72JrfYa+/czG78gdbQ4t/ojmXEJG0Sv
	 XdeurXWO/zsfg==
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
Subject: [PATCH rcu 13/13] torture: Remove support for SRCU-lite
Date: Wed,  9 Jul 2025 16:14:14 +0530
Message-Id: <20250709104414.15618-14-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
References: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Because SRCU-lite is being replaced by SRCU-fast, this commit removes
support for SRCU-lite from refscale.c.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/refscale.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index f11a7c2af778..f4b2cea1cce5 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -246,36 +246,6 @@ static const struct ref_scale_ops srcu_fast_ops = {
 	.name		= "srcu-fast"
 };
 
-static void srcu_lite_ref_scale_read_section(const int nloops)
-{
-	int i;
-	int idx;
-
-	for (i = nloops; i >= 0; i--) {
-		idx = srcu_read_lock_lite(srcu_ctlp);
-		srcu_read_unlock_lite(srcu_ctlp, idx);
-	}
-}
-
-static void srcu_lite_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
-{
-	int i;
-	int idx;
-
-	for (i = nloops; i >= 0; i--) {
-		idx = srcu_read_lock_lite(srcu_ctlp);
-		un_delay(udl, ndl);
-		srcu_read_unlock_lite(srcu_ctlp, idx);
-	}
-}
-
-static const struct ref_scale_ops srcu_lite_ops = {
-	.init		= rcu_sync_scale_init,
-	.readsection	= srcu_lite_ref_scale_read_section,
-	.delaysection	= srcu_lite_ref_scale_delay_section,
-	.name		= "srcu-lite"
-};
-
 #ifdef CONFIG_TASKS_RCU
 
 // Definitions for RCU Tasks ref scale testing: Empty read markers.
@@ -1193,7 +1163,7 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcu_fast_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
+		&rcu_ops, &srcu_ops, &srcu_fast_ops, RCU_TRACE_OPS RCU_TASKS_OPS
 		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
 		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
-- 
2.40.1

