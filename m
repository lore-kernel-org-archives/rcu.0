Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B73B7B8E;
	Wed, 24 Jun 2026 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307478; cv=none; b=gZQ7eTX6llJZJ5KnekBe7S6n64G3G9FCC/pOEO8eSGlATJKCIJYFFV3zopQMj81OMbzkLEISEcqaPoqDjPnCikkn8OKk97oxkiRTQlhmehMp2wdKePKFiXWud0oeguoFPlJI6GE2kHfV3HxbPFAEkKkExRxWDcCOG6wZoVX1zso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307478; c=relaxed/simple;
	bh=MyJ7hPQ4dg9mmfoeU4hyp7L1sf1xoLQZhZDatOacz1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEr5JqhXCfm2hWICCQ0WQp27Oz4nr6njK0Qq/0QNqOgKjGm9Nt1/6qeQcpb22mJ7tXdtjhyLl0eU0dl8jHFsM+fXrWRurldyxRI9DE0ajr6hwdOg7nExDUiOG/rO/FF1PlPKO/aflh331GMWEu9JtJ2cDoBtjWtXy1clWtaeP1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPS3lD+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPS3lD+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BEE1F000E9;
	Wed, 24 Jun 2026 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307477;
	bh=y3VoNlvYEo6yMcnDrba0V7TZjHEwjtIHBXp9Xbfaajs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QPS3lD+B3SU42u/D6uWIBLx4oYcZQbTOR3H3oshLAr2khoVdpwET5lbOUjPdwNiUO
	 5zZNpjs6TpQue+R9nlNFUuSGePOYc9sDa+5fzGGurl2EkL+0o4pmGoVHDNUVhVvpXx
	 oqNXN0QOMKm3RTCB+St9YIjR8NdEHsGwxjqdSbH1LwZly+7/2MCT9WkeBOBqc5pEwN
	 1siJCUPIP7oSGE8AxWESzSFC9rRyp/+tZstlBJkR4kZ2C/sojoJMjH3WGJXTAUr4dl
	 iQpDHjn8raRUIKl4LSxGx7mKbzNoRr3j3mooo6C0e8ENzFJ2flX3xbqO4pOqH280l7
	 A5BxHNlP7nN1A==
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
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v1 05/11] rcu: Add RCU_GET_STATE_NOT_TRACKED for subsystems without expedited GPs
Date: Wed, 24 Jun 2026 06:23:47 -0700
Message-ID: <20260624132356.516959-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624132356.516959-1-puranjay@kernel.org>
References: <20260624132356.516959-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SRCU and Tasks RCU do not track expedited grace periods. When their
callback state is checked via poll_state_synchronize_rcu_full(), the
uninitialized or zeroed exp field could cause false-positive
completion detection.

This commit adds an RCU_GET_STATE_NOT_TRACKED sentinel value (0x2) that
these subsystems can place into exp to indicate that expedited GP
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
index 14faa11ef23cd..39a9f6fa9a7b2 100644
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
+ *					gp_seq entries are checked via
+ *					poll_state_synchronize_rcu_full().
  */
 
-/* Low-order bit definition for polled grace-period APIs. */
+/* Low-order bit definitions for polled grace-period APIs. */
 #define RCU_GET_STATE_COMPLETED	0x1
+#define RCU_GET_STATE_NOT_TRACKED	0x2
 
 /* A complete grace period count */
 #define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1d65505460bc7..095a023b19f1f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3635,7 +3635,8 @@ bool poll_state_synchronize_rcu_full(struct rcu_gp_seq *gsp)
 	if (gsp->norm == RCU_GET_STATE_COMPLETED ||
 	    rcu_seq_done_exact(&rnp->gp_seq, gsp->norm) ||
 	    gsp->exp == RCU_GET_STATE_COMPLETED ||
-	    rcu_seq_done_exact(&rcu_state.expedited_sequence, gsp->exp)) {
+	    (gsp->exp != RCU_GET_STATE_NOT_TRACKED &&
+	     rcu_seq_done_exact(&rcu_state.expedited_sequence, gsp->exp))) {
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 		return true;
 	}
-- 
2.53.0-Meta

