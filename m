Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7D15CD60
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832366; cv=none; b=LyE6BWhYKp2hK/VN755MhqwYL5GtT/2ZbsWHwa6oSHWIN3Ck5VtzsLHhfYt5GHe5WJhS9suymnUPTTpPw9A0Xlz7RmrJ6hqOOD/PVnezeH54mQfpnj16WZ+6NsQW0AKKWYS2dDYOZTsnQ9sqk9xfPRo72BSW0rTcbeTY+hzIJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832366; c=relaxed/simple;
	bh=+J0wB86qpfyvRMt66KLg/gt6uWTnso5KmEGC5grWpXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BybEx7LZpzVVdX+gkOsf6c5zr2avPOuRpjRfrOKS1OpVd3H5YdSYbsYElAMm6/ioUaKo/5YpmNM859HlVXuyCJ7s5RC0gZfiXRxD6sLkBoDK7+ileG8RLhJgA6R8GjHOC9y8L3e+7P9deoWsR2QJQ7yLj9y1KyV8jd58INiHTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVWCj7Np; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVWCj7Np"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7z60zM+SQRXxDqKuJZoRzq0oy53ItT6FQQA50hZ8Rc0=;
	b=dVWCj7NpLVkxpOReSwpsXlmCDbJaYFzF6q3ruAwE3AqFCp0rM7QJPqVtNZOQvAMKB9Ew/m
	KbX0eA18cb1RZ7Qk6SffUhyFBRRlV1eb7V6/awBUHCxGfGjE3ecq4eu123gWnnQYgoN5dO
	GqAU0a3KmhtgZuzK+pQ7wHDCCxoBrE8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-VPmkoAC6OIKfO7IfmZ0NEw-1; Wed,
 24 Jul 2024 10:46:00 -0400
X-MC-Unique: VPmkoAC6OIKfO7IfmZ0NEw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D0011955F77;
	Wed, 24 Jul 2024 14:45:58 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D9731955F3B;
	Wed, 24 Jul 2024 14:45:53 +0000 (UTC)
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
Subject: [PATCH v3 18/25] rcu: Rename rcu_dynticks_zero_in_eqs() into rcu_watching_zero_in_eqs()
Date: Wed, 24 Jul 2024 16:43:18 +0200
Message-ID: <20240724144325.3307148-19-vschneid@redhat.com>
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
 kernel/rcu/rcu.h   | 4 ++--
 kernel/rcu/tasks.h | 2 +-
 kernel/rcu/tree.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 38238e595a61a..5564402af4cbd 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -606,7 +606,7 @@ void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 #endif
 
 #ifdef CONFIG_TINY_RCU
-static inline bool rcu_dynticks_zero_in_eqs(int cpu, int *vp) { return false; }
+static inline bool rcu_watching_zero_in_eqs(int cpu, int *vp) { return false; }
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline unsigned long
@@ -619,7 +619,7 @@ static inline void rcu_fwd_progress_check(unsigned long j) { }
 static inline void rcu_gp_slow_register(atomic_t *rgssp) { }
 static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
 #else /* #ifdef CONFIG_TINY_RCU */
-bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
+bool rcu_watching_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ba3440a45b6dd..2484c1a8e051a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1613,7 +1613,7 @@ static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
 		// However, we cannot safely change its state.
 		n_heavy_reader_attempts++;
 		// Check for "running" idle tasks on offline CPUs.
-		if (!rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
+		if (!rcu_watching_zero_in_eqs(cpu, &t->trc_reader_nesting))
 			return -EINVAL; // No quiescent state, do it the hard way.
 		n_heavy_reader_updates++;
 		nesting = 0;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3fd9f0fc4d558..d05bd65fbfdc2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -333,7 +333,7 @@ static bool rcu_watching_snap_stopped_since(struct rcu_data *rdp, int snap)
  * Return true if the referenced integer is zero while the specified
  * CPU remains within a single extended quiescent state.
  */
-bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
+bool rcu_watching_zero_in_eqs(int cpu, int *vp)
 {
 	int snap;
 
-- 
2.43.0

