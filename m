Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402A02D7817;
	Fri, 31 Jul 2026 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459458; cv=none; b=qV8pIe/sS9zADTpWDyEa01h8QYlTNpJHkhcLgz7RkblprA5Td/3DOh0xnuP6aKJDp9CTs3uXSqT81pZgpNoENCJhXa3hE4yBkzmhgvr44C90tc5/aXR5e8V4nU/W1R8P+/dMDkLBML5D+94q1Q5nsAld4AV6jweEdyZ7G2tOOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459458; c=relaxed/simple;
	bh=v8/+hqiPKMDqWUbd4tDVJNnxOHp02U7XOuBn12bxUnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cc06YFWeT7PidPjOeUbs+hjWme/udncnBTl0Kd8I9LZmtHz76PDbn5yITexmPBlHMPL/RI3M6avZGG+Fm3GZ9WKAPFvoC92MtOepEL1l9yAZluuRZgjyB95jOlw5FY+ciaodSZ1bJWErm5Lkrpz64cCtriGQzPvuK30nJMDGzdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB8mqWRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB8mqWRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8EF1F00ADF;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459454;
	bh=L6na/LztV7maKkvWN4ciwPRoE9wOyhE3u3+HfV02Gzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lB8mqWRxRWUx67qdukm44tKK64r8pzT6zv4HWd5yhxN/Qmki1lb4HU1IOa0idS4uA
	 ALaZ171NF+lg180irhqhZHY7EYi58C4XT4boeDlzONX/ivZhy2END3qamiV21+wThG
	 dvnoUcWXem6m9PSCbXHHPQd770zneRDb/KdexrrVYEz0aD/M+EtBhN2nfGQ4SZF27w
	 QUgBc5oCj/b2bezgz5bWpuj7wY/0Ugdo5SXvFEjpN5L6apDMvoWIVhr/Qml5bvfnVr
	 yc9mPZBKBU6chRn857UnGWKB4K+ABTyobPs5k2ci0WIPlKxLvIkFGkPWqeSQUh4u5p
	 C119pj0h6Qv5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 410B2CE1018; Thu, 30 Jul 2026 17:57:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH RFC 06/12] rcu: Add RCU_GET_STATE_NOT_TRACKED for subsystems without expedited GPs
Date: Thu, 30 Jul 2026 17:57:26 -0700
Message-Id: <20260731005732.3530999-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <58bcd561-0520-43ff-95b0-1ed10e1e3bff@paulmck-laptop>
References: <58bcd561-0520-43ff-95b0-1ed10e1e3bff@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h  | 13 +++++++++++--
 kernel/rcu/tree.c |  3 ++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index fa6d30ce73d1fd..0507bb7dac1218 100644
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
index 9ca811e534b5bf..640ebe055a2460 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3629,7 +3629,8 @@ bool poll_state_synchronize_rcu_full(struct rcu_gp_seq *gsp)
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
2.40.1

