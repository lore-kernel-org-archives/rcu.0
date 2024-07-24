Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8416B741
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832363; cv=none; b=NFJjWWZTsMWZ/2EGgqaNWZ4uIQ1p14dW2i6Ph8gDmyMglF6V6MxoIHWBTiqh06MiM6OZCxk/0vi1/eBGV6PNVy6wyK3497EeE3bi09U2+4w/ZME3pCtNejHxB1bl5nqmsGhut8oIoys6JlxKHnfS5qTHE4YI87VOsj7Y19+03eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832363; c=relaxed/simple;
	bh=G6W7zxZMX50j4lR5CP6JVM2TcGtez5SUNVMY8fgUsoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE3vflEvf9mGPk4FEd5M6o05l6ux8HBtI/j55lhm9O87SQ8enMG1u60KhjM6dVXkk/UvCdedfxCXI5i+tOLNrfD9NepaJr41gmAbbC0SEt8JYdxQwawdq0IpmcZtMc2VuEbrVIGUZQ3FG3M2snXhe5pdpjKICQSsIP4vxws54TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Azimd3c0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Azimd3c0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6d1ttNJKWEtipZQeydl5HRpR5f9z9U43G8kdlcs2uE=;
	b=Azimd3c09kvSdeKtKY7WrMGaEEBf0asgDPI7xH9RCtmkxQJalFcoEs0saJmd4XVayjzvnj
	vbAoN11oh4CYXPpluzTii7y57HV1wANMaTin1TQKlb92HUUy3k9cs/hFCvmSnQV/g6ye8I
	iXFHaAscPyoPe/vv/mSwxXdBwzloTqo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-FDd3lJNoMTKBIY5qq5NfzA-1; Wed,
 24 Jul 2024 10:45:57 -0400
X-MC-Unique: FDd3lJNoMTKBIY5qq5NfzA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B33911955D59;
	Wed, 24 Jul 2024 14:45:53 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DCD11955E7B;
	Wed, 24 Jul 2024 14:45:49 +0000 (UTC)
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
Subject: [PATCH v3 17/25] rcu: Rename rcu_dynticks_in_eqs_since() into rcu_watching_snap_stopped_since()
Date: Wed, 24 Jul 2024 16:43:17 +0200
Message-ID: <20240724144325.3307148-18-vschneid@redhat.com>
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
RCU_WATCHING, the dynticks prefix can go.

While at it, this helper is only meant to be called after failing an
earlier call to rcu_watching_snap_in_eqs(), document this in the comments
and add a WARN_ON_ONCE() for good measure.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 .../Tree-RCU-Memory-Ordering.rst              |  2 +-
 kernel/rcu/tree.c                             | 23 ++++++++++++++-----
 kernel/rcu/tree_exp.h                         |  2 +-
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 2d7036ad74761..7163d0def34e6 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -150,7 +150,7 @@ This case is handled by calls to the strongly ordered
 is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
 time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
 The grace-period kthread invokes first ``ct_rcu_watching_cpu_acquire()``
-(preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_since()``
+(preceded by a full memory barrier) and ``rcu_watching_snap_stopped_since()``
 (both of which rely on acquire semantics) to detect idle CPUs.
 
 +-----------------------------------------------------------------------+
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7c2bd7e511579..3fd9f0fc4d558 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -308,13 +308,24 @@ static bool rcu_watching_snap_in_eqs(int snap)
 	return !(snap & CT_RCU_WATCHING);
 }
 
-/*
- * Return true if the CPU corresponding to the specified rcu_data
- * structure has spent some time in an extended quiescent state since
- * rcu_dynticks_snap() returned the specified snapshot.
+/**
+ * rcu_watching_snap_stopped_since() - Has RCU stopped watching a given CPU
+ * since the specified @snap?
+ *
+ * @rdp: The rcu_data corresponding to the CPU for which to check EQS.
+ * @snap: rcu_watching snapshot taken when the CPU wasn't in an EQS.
+ *
+ * Returns true if the CPU corresponding to @rdp has spent some time in an
+ * extended quiescent state since @snap. Note that this doesn't check if it
+ * /still/ is in an EQS, just that it went through one since @snap.
+ *
+ * This is meant to be used in a loop waiting for a CPU to go through an EQS.
  */
-static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
+static bool rcu_watching_snap_stopped_since(struct rcu_data *rdp, int snap)
 {
+	if (WARN_ON_ONCE(rcu_watching_snap_in_eqs(snap)))
+		return true;
+
 	return snap != ct_rcu_watching_cpu_acquire(rdp->cpu);
 }
 
@@ -801,7 +812,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * read-side critical section that started before the beginning
 	 * of the current RCU grace period.
 	 */
-	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap)) {
+	if (rcu_watching_snap_stopped_since(rdp, rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8453da73a7df2..29f94bcf34033 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -392,7 +392,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		unsigned long mask = rdp->grpmask;
 
 retry_ipi:
-		if (rcu_dynticks_in_eqs_since(rdp, rdp->exp_dynticks_snap)) {
+		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_dynticks_snap)) {
 			mask_ofl_test |= mask;
 			continue;
 		}
-- 
2.43.0

