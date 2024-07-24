Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443D215B98D
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832303; cv=none; b=bhbv/EALpicJSTPvv4HmKtOLERlThs64nzQDz++91R5FR8gwRW5zKu6PwKAwbZRml6lVakcCxiLZssx8qWA4rJbqcT2Vtf1JiCxs3xfgO1XcwEMqgd+fnJ2Ut9gnNpy6xp+aMDo8Anv3SGZv2+pyDlyWVKxbQOq3c/eVNBWdAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832303; c=relaxed/simple;
	bh=TJWptc0pL1KVZYFiuggKXWowL4MlMuuXNZ4mVddMSDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsxKIpqQFWM9+IncCY5EEg4ssl3hQRaWCxD7An+tXOYMiVkhia6UjO4/p2T5+Lsk2ZDqqNcGWkQsqMguBabA5i6QCS3XG37LoHdko10sTHURZsNi3h53ASM59QfCZ6beH3wt11ddfsFdJ8QBFzmtf79F8XgLTvO4aR39+vH7Y58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYfrK8OV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYfrK8OV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y11WttRX2yX1xLGDlFOHW4F2B1B+t2UgCNCAegISHys=;
	b=DYfrK8OVpVnPNTONvAjd011SMEcquCKHIIJVEdvGocfYz8GYCb3ZI4avTEF8zOAT/a6spm
	ztD642M8j8tCjsBsTGaRZFyGIDJICRCdcZipJUNLIPJav3ybJ96LXO717lhSt7pYJUYus6
	2G+Bx900RjculpOwpPGESfTDCTlzUjU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-tK-2-dYEPCGrg1l1AMIkLA-1; Wed,
 24 Jul 2024 10:44:56 -0400
X-MC-Unique: tK-2-dYEPCGrg1l1AMIkLA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C41E1955D55;
	Wed, 24 Jul 2024 14:44:53 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0D771955E7B;
	Wed, 24 Jul 2024 14:44:49 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v3 04/25] context_tracking, rcu: Rename ct_dynticks_cpu() into ct_rcu_watching_cpu()
Date: Wed, 24 Jul 2024 16:43:04 +0200
Message-ID: <20240724144325.3307148-5-vschneid@redhat.com>
In-Reply-To: <20240724144325.3307148-1-vschneid@redhat.com>
References: <20240724144325.3307148-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, reflect that change in the related helpers.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/context_tracking_state.h |  2 +-
 kernel/rcu/tree.c                      | 10 +++++-----
 kernel/rcu/tree_stall.h                |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index cb90d8c178104..ad5a06a42b4a0 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -61,7 +61,7 @@ static __always_inline int ct_rcu_watching(void)
 	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHING_MASK;
 }
 
-static __always_inline int ct_dynticks_cpu(int cpu)
+static __always_inline int ct_rcu_watching_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ae478e13fc837..e60f878444704 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -327,14 +327,14 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	int snap;
 
 	// If not quiescent, force back to earlier extended quiescent state.
-	snap = ct_dynticks_cpu(cpu) & ~CT_RCU_WATCHING;
-	smp_rmb(); // Order ->dynticks and *vp reads.
+	snap = ct_rcu_watching_cpu(cpu) & ~CT_RCU_WATCHING;
+	smp_rmb(); // Order CT state and *vp reads.
 	if (READ_ONCE(*vp))
 		return false;  // Non-zero, so report failure;
-	smp_rmb(); // Order *vp read and ->dynticks re-read.
+	smp_rmb(); // Order *vp read and CT state re-read.
 
 	// If still in the same extended quiescent state, we are good!
-	return snap == ct_dynticks_cpu(cpu);
+	return snap == ct_rcu_watching_cpu(cpu);
 }
 
 /*
@@ -4793,7 +4793,7 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(ct->dynticks_nesting != 1);
-	WARN_ON_ONCE(rcu_dynticks_in_eqs(ct_dynticks_cpu(cpu)));
+	WARN_ON_ONCE(rcu_dynticks_in_eqs(ct_rcu_watching_cpu(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_state = RCU_GP_CLEANED;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4b0e9d7c4c68e..d65974448e813 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -501,7 +501,7 @@ static void print_cpu_stall_info(int cpu)
 	}
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
-			rcu_dynticks_in_eqs(ct_dynticks_cpu(cpu));
+			rcu_dynticks_in_eqs(ct_rcu_watching_cpu(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
 		// Print signed value, as negative values indicate a probable bug.
@@ -515,7 +515,7 @@ static void print_cpu_stall_info(int cpu)
 			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
 				"!."[!delta],
 	       ticks_value, ticks_title,
-	       ct_dynticks_cpu(cpu) & 0xffff,
+	       ct_rcu_watching_cpu(cpu) & 0xffff,
 	       ct_dynticks_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-- 
2.43.0

