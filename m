Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FF316C862
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832372; cv=none; b=a+NXMk+TahydMRP75cef1ul7RozS5Mo/qHKU+WDZc+nNe1F7VdCaAM9fw9pgEv6uEVpS3ZXpz9C2n/u1DGjSjvYLVEtSD8z2H072KfYQJAoGyOF/cEQqPCpl74siMprK0bGoKwHfpYNIqeSBViddU00i7QBChXazL2Ee1J/4Tx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832372; c=relaxed/simple;
	bh=d2L9oDHD5Z0MMv+pVgQXP1E/RyXGUrWr6q1Ra8zkCxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATHXL8UQuObpJqr2XTk2QLYqni/MiPs0SBDMWAb5Fm0FKXLG1E2/eJvz0gHq7E2hvXkqrd+lBAlRt3eJiqM5XAiwk68EIhOzHVR2I855KOpFkTwvGiR4y1S6i7Lb0Skj8SgEmlrlA2kJH09Q9RoKgWiY3Qv2mF6D6EARNc2tJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdsRfX+C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdsRfX+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRPGycSO0yCZrjZ2+qa9LF3O4ClFZynQ1c1TmcMnrog=;
	b=KdsRfX+CBsEhi1IXzKpFw+BkEZYCDw1CLUdaHKFkRhSMOGgYzNaRge1yppHOUdgJu5RxNB
	jEjvUSbd34zAtVqu6GzdgcZYkTwIFZM+9DFiKLizfv/nGjGrnjEB+z6MRFO40Cc5zwzozf
	VAe+LnHo5vlAjOJIN5wIK5yoJ7ZAC0U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-QPvFDPz6MvWOGoEodMfzow-1; Wed,
 24 Jul 2024 10:46:05 -0400
X-MC-Unique: QPvFDPz6MvWOGoEodMfzow-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 287051955D57;
	Wed, 24 Jul 2024 14:46:03 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BD401955E80;
	Wed, 24 Jul 2024 14:45:58 +0000 (UTC)
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
Subject: [PATCH v3 19/25] rcu: Rename struct rcu_data .dynticks_snap into .watching_snap
Date: Wed, 24 Jul 2024 16:43:19 +0200
Message-ID: <20240724144325.3307148-20-vschneid@redhat.com>
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
RCU_WATCHING, and the snapshot helpers are now prefix by
"rcu_watching". Reflect that change into the storage variables for these
snapshots.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 .../RCU/Design/Data-Structures/Data-Structures.rst          | 4 ++--
 kernel/rcu/tree.c                                           | 6 +++---
 kernel/rcu/tree.h                                           | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index 5389cc49bea13..de76c624fe93e 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -921,10 +921,10 @@ This portion of the ``rcu_data`` structure is declared as follows:
 
 ::
 
-     1   int dynticks_snap;
+     1   int watching_snap;
      2   unsigned long dynticks_fqs;
 
-The ``->dynticks_snap`` field is used to take a snapshot of the
+The ``->watching_snap`` field is used to take a snapshot of the
 corresponding CPU's dyntick-idle state when forcing quiescent states,
 and is therefore accessed from other CPUs. Finally, the
 ``->dynticks_fqs`` field is used to count the number of times this CPU
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d05bd65fbfdc2..e1dd424f8a4c0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -779,8 +779,8 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 	 * current GP sequence number is enforced by current rnp locking
 	 * with chained smp_mb__after_unlock_lock().
 	 */
-	rdp->dynticks_snap = ct_rcu_watching_cpu_acquire(rdp->cpu);
-	if (rcu_watching_snap_in_eqs(rdp->dynticks_snap)) {
+	rdp->watching_snap = ct_rcu_watching_cpu_acquire(rdp->cpu);
+	if (rcu_watching_snap_in_eqs(rdp->watching_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
 		return 1;
@@ -812,7 +812,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * read-side critical section that started before the beginning
 	 * of the current RCU grace period.
 	 */
-	if (rcu_watching_snap_stopped_since(rdp, rdp->dynticks_snap)) {
+	if (rcu_watching_snap_stopped_since(rdp, rdp->watching_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index fcf2b4aa34417..f5361a7d7269c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -206,7 +206,7 @@ struct rcu_data {
 	long		blimit;		/* Upper limit on a processed batch */
 
 	/* 3) dynticks interface. */
-	int dynticks_snap;		/* Per-GP tracking for dynticks. */
+	int  watching_snap;		/* Per-GP tracking for dynticks. */
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 	bool rcu_forced_tick;		/* Forced tick to provide QS. */
-- 
2.43.0

