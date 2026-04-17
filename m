Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9B237EFEA;
	Fri, 17 Apr 2026 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467567; cv=none; b=QZnGqLdXiUwGWZ8H1HoiSdFYcpMXcPIthvikdPgVXRzjc6AMSiBXVvACettoV7oVJ0dsYRd9saqBMB/Tr3Er/dvFxpHAMJRQ1C+N/2+KWX2xb9erz/r2S1dzCJ1DZ/UZvxit1oTOlBN6B6rlixFDM2i7BHHvWRu99dccGp5DBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467567; c=relaxed/simple;
	bh=Ftd1vYROmALL3JJSnu4TT5XrtwuAYt1VEaQ42HbUrhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpSc5ayFrOU9fJyZEfgG8nh8ZrcPmbtBw9DMlJMToiJop7aG6Yxc3oRCdWuR8uBKN1MLgiAvBmS1TKAs89VJlGa6p0mQhYzwZEOfY37gMEqephFmBHbjm4tHtudYvogWq0WcKWhtBrOXmpc5ePfB+h11AVrPK7My8nifi6N9134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAqrK5wz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAqrK5wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75581C2BCB3;
	Fri, 17 Apr 2026 23:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467567;
	bh=Ftd1vYROmALL3JJSnu4TT5XrtwuAYt1VEaQ42HbUrhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WAqrK5wz1UBmCEZW3dW1ErU00e1zwKwh45Jl3luGF1yoJ95UxP5OzIkusjSLhgkS8
	 Ue/kGTM8x+d86T+BX17YDydSy4GQVDF2x7FroUHmupTs0qrsvTgSvZlPSUZ/UCNwLK
	 kfw/dPLHdqszA+oeAKtYTQCpRL34vCCnnp0GgBuTk3jPxcto3qpdWdfCgslCT4uRk9
	 VmTii2f+73j7Q6eVJLIq/MY2D8sUokCWBxiFaWZgIb9u4inbOQFa/Qz79J5lKrx8+m
	 ZavM8HrFREo2K8mumkz8DhAuICy3LZT2RVycBuMSMTzLrgJRnc7c3YLzPWKd7BVE4a
	 qdScaD9ZSgyRA==
From: Puranjay Mohan <puranjay@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [RFC PATCH 04/10] rcu: Add RCU_GET_STATE_NOT_TRACKED for subsystems without expedited GPs
Date: Fri, 17 Apr 2026 16:11:52 -0700
Message-ID: <20260417231203.785172-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417231203.785172-1-puranjay@kernel.org>
References: <20260417231203.785172-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SRCU and Tasks RCU do not track expedited grace periods. When their
callback state is checked via poll_state_synchronize_rcu_full(), the
uninitialized or zeroed rgos_exp field could cause false-positive
completion detection.

This commit adds an RCU_GET_STATE_NOT_TRACKED sentinel value (0x2) that
these subsystems can place into rgos_exp to indicate that expedited GP
tracking is not applicable. The expedited sequence check in
poll_state_synchronize_rcu_full() is guarded to skip entries marked with
this sentinel.

This is needed to allow rcu_segcblist_advance() and rcu_accelerate_cbs()
to work with both normal and expedited grace periods via
get_state_synchronize_rcu_full() and poll_state_synchronize_rcu_full().

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/rcu.h  | 13 +++++++++++--
 kernel/rcu/tree.c |  3 ++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index fa6d30ce73d1..b450febac823 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -46,16 +46,25 @@
  *					the number of pending readers that will use
  *					this inactive index is bounded).
  *
- * RCU polled GP special control value:
+ * RCU polled GP special control values:
  *
  *	RCU_GET_STATE_COMPLETED :	State value indicating an already-completed
  *					polled GP has completed.  This value covers
  *					both the state and the counter of the
  *					grace-period sequence number.
+ *
+ *	RCU_GET_STATE_NOT_TRACKED :	State value indicating that a GP component
+ *					is not tracked by this subsystem and should
+ *					not be checked.  Used by SRCU and RCU Tasks
+ *					which do not track expedited GPs, to prevent
+ *					false-positive completion when their
+ *					gp_seq_full entries are checked via
+ *					poll_state_synchronize_rcu_full().
  */
 
-/* Low-order bit definition for polled grace-period APIs. */
+/* Low-order bit definitions for polled grace-period APIs. */
 #define RCU_GET_STATE_COMPLETED	0x1
+#define RCU_GET_STATE_NOT_TRACKED	0x2
 
 /* A complete grace period count */
 #define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cbc170dc3f72..607fc5715cd1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3603,7 +3603,8 @@ bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 	if (rgosp->rgos_norm == RCU_GET_STATE_COMPLETED ||
 	    rcu_seq_done_exact(&rnp->gp_seq, rgosp->rgos_norm) ||
 	    rgosp->rgos_exp == RCU_GET_STATE_COMPLETED ||
-	    rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp->rgos_exp)) {
+	    (rgosp->rgos_exp != RCU_GET_STATE_NOT_TRACKED &&
+	     rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp->rgos_exp))) {
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 		return true;
 	}
-- 
2.52.0

