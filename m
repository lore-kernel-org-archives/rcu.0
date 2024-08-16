Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F278C6D;
	Fri, 16 Aug 2024 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781128; cv=none; b=Qs7/bp2M7B9OtbLobojhC0HJem3hh/EdqsQd+ajnw+hPokRCNxNpAmQv5jATfW7EZ6JIwLwyLHfHkMcLEQa2FTbkOjapqlbW52O7ThdLlDc4DHRAT6wWsepb8F+oCJSVIJhjxQ0P6ZhjpEfbJB8mTBTdD7y3De4O+oQ+MOmdRaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781128; c=relaxed/simple;
	bh=pdYpSdwEaOBgNhubrdJXez5sTv6oyOsjgknZPbrT68k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqyBym9w+fwlJeHMdIa5YH+kDb0x/nxZTp25NLpeasAXMERJH8m5UhTi6MQRcnIrXxW9GuyDDMOjEadP3wwxJLoO+WH4jHtsmNVcb15Po9EAmZR7V2HeOEVKZtgGtAqPHzYLzxDfLkXghJtoIDW5TntdqZfnDLckRDtbzSmtQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIzXlMhb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIzXlMhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D550C32782;
	Fri, 16 Aug 2024 04:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781127;
	bh=pdYpSdwEaOBgNhubrdJXez5sTv6oyOsjgknZPbrT68k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIzXlMhb0J2GP9xF6ZNzMRBHdvVHGmQGpSsYVbuD/attf0hAGX0Jd1fYUVeXnJx+S
	 Bm0Das7XGiuXpKBIgVjHoIWmQXyXic+cR5dxrl/v7rcecxuh2iffjTY6+NqnA854mW
	 cEBMkbviS/t3irDril6AiOZV4m9/5ShgpkiOLlBRhCrNKjEQbtwBClzBI0qnfm5Zv6
	 Eqfc0wtvb6u7U4IsvV6KaIQ15mKDxu58iqgb4IiVir1KWjmm9yZ4x/qnpIq60Iu47W
	 NYQReYSdFEtcL/sjc1q8qc8Vg5YWhjdObvVIV8RZhlxESfxcxEzB3IQD8jdNCcDGoj
	 iwnf3ykCc5X4Q==
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
	frederic@kernel.org,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 15/26] rcu: Rename rcu_dynticks_eqs_online() into rcu_watching_online()
Date: Fri, 16 Aug 2024 09:32:30 +0530
Message-Id: <20240816040241.17776-15-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816040030.GA16986@neeraj.linux>
References: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, reflect that change in the related helpers.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 68eca7d3fdd1..47ec9f2daaed 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -283,16 +283,16 @@ void rcu_softirq_qs(void)
 }
 
 /*
- * Reset the current CPU's ->dynticks counter to indicate that the
+ * Reset the current CPU's RCU_WATCHING counter to indicate that the
  * newly onlined CPU is no longer in an extended quiescent state.
  * This will either leave the counter unchanged, or increment it
  * to the next non-quiescent value.
  *
  * The non-atomic test/increment sequence works because the upper bits
- * of the ->dynticks counter are manipulated only by the corresponding CPU,
+ * of the ->state variable are manipulated only by the corresponding CPU,
  * or when the corresponding CPU is offline.
  */
-static void rcu_dynticks_eqs_online(void)
+static void rcu_watching_online(void)
 {
 	if (ct_rcu_watching() & CT_RCU_WATCHING)
 		return;
@@ -5058,7 +5058,7 @@ void rcutree_report_cpu_starting(unsigned int cpu)
 	rnp = rdp->mynode;
 	mask = rdp->grpmask;
 	arch_spin_lock(&rcu_state.ofl_lock);
-	rcu_dynticks_eqs_online();
+	rcu_watching_online();
 	raw_spin_lock(&rcu_state.barrier_lock);
 	raw_spin_lock_rcu_node(rnp);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
-- 
2.40.1

