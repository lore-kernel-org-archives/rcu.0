Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2115DBB2
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832307; cv=none; b=oUzzSds+a9jAo93PUj9i5ViZsgl3koWfyUQOz261I0tcu4erZBPvI4aThLk68VTQS5pp+EXj5wshBlNs+f4Jwk7oBkOrj3c4h1XiLjEJG0jS5E2p3zpsnPAolDLkNb/VbDmd8GHbo0mDv3qgUtEaspjzhyo6IQ6xfBRaNdDgwC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832307; c=relaxed/simple;
	bh=c1ArKju6w89e5M0m4Sva/iBEMixSFtBUz7EhGSWGwBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEDLN3JIbc6Ynv24MjqUcgR+uC4CSm3GBqo7jg1ZwRl/qZG+ZLckBdcVmXZN7JOk8lHIKmiWXAxPTVgwhn2/IvUEeRs0Y/s9x94bqHNtbmtX5A9LbpEOalQ7Qak0QEOPS+K7UQncZHLmHCFEb2S0K+AdM0LMUN17RjwNB8yzbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVALelDO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVALelDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ImDgbATyctNtQU7+CQmnVybQI51a+VLnARccHlwptwk=;
	b=TVALelDONxOVL/WG8M6kzCuEemt2tmW514xsCNJ7Azc4JpsoX2P0wVyRS8U6Gvx/XcbHeG
	MF92+9D4ibT6SBQShI0yXJebyMznuPtydRmyybQ8HsivrzPoo1f6qdJSffW6UlOaNk13uZ
	EnzOTosCgXVYAFAGVO74Tw01nWx4WrQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-WUja1sK2PJGimMz5NVmEOw-1; Wed,
 24 Jul 2024 10:45:00 -0400
X-MC-Unique: WUja1sK2PJGimMz5NVmEOw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 368A81955D4B;
	Wed, 24 Jul 2024 14:44:58 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA2761955F40;
	Wed, 24 Jul 2024 14:44:53 +0000 (UTC)
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
Subject: [PATCH v3 05/25] context_tracking, rcu: Rename ct_dynticks_cpu_acquire() into ct_rcu_watching_cpu_acquire()
Date: Wed, 24 Jul 2024 16:43:05 +0200
Message-ID: <20240724144325.3307148-6-vschneid@redhat.com>
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
---
 .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   | 2 +-
 include/linux/context_tracking_state.h                        | 2 +-
 kernel/rcu/tree.c                                             | 4 ++--
 kernel/rcu/tree_exp.h                                         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 728b1e690c646..2d7036ad74761 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -149,7 +149,7 @@ This case is handled by calls to the strongly ordered
 ``atomic_add_return()`` read-modify-write atomic operation that
 is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
 time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
-The grace-period kthread invokes first ``ct_dynticks_cpu_acquire()``
+The grace-period kthread invokes first ``ct_rcu_watching_cpu_acquire()``
 (preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_since()``
 (both of which rely on acquire semantics) to detect idle CPUs.
 
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index ad5a06a42b4a0..ad6570ffeff3c 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -68,7 +68,7 @@ static __always_inline int ct_rcu_watching_cpu(int cpu)
 	return atomic_read(&ct->state) & CT_RCU_WATCHING_MASK;
 }
 
-static __always_inline int ct_dynticks_cpu_acquire(int cpu)
+static __always_inline int ct_rcu_watching_cpu_acquire(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e60f878444704..273d223bd8efc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -315,7 +315,7 @@ static bool rcu_dynticks_in_eqs(int snap)
  */
 static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 {
-	return snap != ct_dynticks_cpu_acquire(rdp->cpu);
+	return snap != ct_rcu_watching_cpu_acquire(rdp->cpu);
 }
 
 /*
@@ -768,7 +768,7 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 	 * current GP sequence number is enforced by current rnp locking
 	 * with chained smp_mb__after_unlock_lock().
 	 */
-	rdp->dynticks_snap = ct_dynticks_cpu_acquire(rdp->cpu);
+	rdp->dynticks_snap = ct_rcu_watching_cpu_acquire(rdp->cpu);
 	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 721cb93b1fece..89cbadb15a4e7 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -368,7 +368,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 			 * by current rnp locking with chained
 			 * smp_mb__after_unlock_lock().
 			 */
-			snap = ct_dynticks_cpu_acquire(cpu);
+			snap = ct_rcu_watching_cpu_acquire(cpu);
 			if (rcu_dynticks_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
-- 
2.43.0

