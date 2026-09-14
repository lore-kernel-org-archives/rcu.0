Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126DE423784
	for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378502; cv=none; b=b6KqZaiJEW/3HRm5UbB9NDGJWGJOmNHWv4SzjQv4FWeceWzx6hJRWNCBFROsGFwRlsAwpS9C74v0NL1Do+bkH+lgK8SQoYIhVT1Oho65w6wfDZdsFIKriVaixjmPHAIy/5Qpr5KIW4VfOghpkut+vts8Ixrq8BntQ+I5FpcjqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378502; c=relaxed/simple;
	bh=5Vk7KcRU9V4X/ipHU254D4BIdjqisl9bj3wEmszSWIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZM/zI9fof0fMii9sl7zg2dPw9iVnY4u3cpBRxjKeOglxTNFiLJ+T04Sc5ObAxQhuXNxDabJMB+IIb6BiKQSNoluezl4Hynl9WHSJQElcQsQyy1WTocGmQrQKdVBcCoagkFFAr7CPQSauIQUy9KP7icQQD5aHSNKtPp81qLKspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnQMCKXC; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnQMCKXC"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91c22d27dso8363905ad.1
        for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789378500; x=1789983300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QPEcLs4lXFeouUcd3VfYmQWKBkCZIqO2a7zYwGl971s=;
        b=EnQMCKXColTIR8yjhvIKNne1T7ZsYwSY6+LvLApZgm/tPjbsWM/0jszsOI1eUL/czV
         fpTsWxr+04Sd5YO+te/v44Hq0FSzpVwNKYR7wAJDkIJcsoHJcJ8mLRQMk+q1ftQ/I62k
         qhtRGmjozceFitqDE3UC4tRkq50TSODErnFMcSYLt/3UGNCdBn6DMyQPj2jsdNoWufme
         9E9CY2D/2P79Y46FPVp3Dv9EpB0sn0lMA6Dl7QJekjIVQOYSFKTXaRNHn8Hk59zatfA/
         QzvLU5reG2hEh1w/2wtLPsVC5oBTtVRip954oU2En6cTXTvuZ4a9gG8jtj0WQPK2oEat
         C2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789378500; x=1789983300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QPEcLs4lXFeouUcd3VfYmQWKBkCZIqO2a7zYwGl971s=;
        b=imT3F+dQNUgMrDYmDAwfNinAldIe9MoFV1/eoudrnjWoy6pPe+nF5vAcqTwcBM1n66
         P8aJqyzBlO4akGxpl2BeEv8kwJSIpv8EgK4rZJlR0Qc8ls8aMowgcyYf8Ve+gTM+aJr+
         U5ylN4HpM90LZi/TRpa22fWp+e4eF7jdARfOoTqYPyhA7Ou/Xwck0fNi7jr4+FY01I2Z
         h8mZiiOkCQZbCnU2EADjiRs9VIFFYqTfdcGuKjtECUebX1eYF+9//N0NOUX0hM6ehR+r
         Z4Ceg262VLCcGFHHUX1Famj10vs3dgNRxIlAJHIuHyCwiWqD+8MD4PMt1tHi/5mmhB9P
         YftA==
X-Forwarded-Encrypted: i=1; AKwUvBy8dZBke6wGIqaQhDLAT7h702LotFjM3j8IaHfwNy8FrJQTUOPxO2BBd4pu85qb4mLViu4=@vger.kernel.org
X-Gm-Message-State: AFuF++n5yxMuvP3mKQuy1kDBtUAM3pdTCPEZRVqMa4Jv6GdwfzLvzbNW
	Mi/aVCCaCt+4adR3hN1z8CmzzBvFL7gEpVvWJUqC0b+/ASKCw3XfuhmH
X-Gm-Gg: AYBFou2WXXR0WM9JgYI+vfl8B2DaT2U3HC6gYso3VfzMcCRZDKC/sDJzR+gpLS2zRfP
	6gttaXoTfCrFOMtN9Id3sK9mSRIv3Fa2o558nojCjkYlI7/P3auRkocUtxUZEj1IxOPxXZIVUu+
	RLbNs2p+Ak499iWTLAOUSMqKeNwnd/g568eZnw9vZU6nlPSZpBT0TDO2zgoRRy55YYIGVH5KLVp
	MffUo1Os4aAeNK4AZ1han1Wa0eueP7625fEr+ZkeG9IJbggNZ+snSL3xVr5W42zhyzEleNWjnHH
	E/z0BCBPenuNumKgWq9mYpN6YriG00L8S4nU9G2ZAM0PMbAbhV1L9yPt6ALGBr/4SQRqatj8ygA
	UsHiBmsS/YRQMdTKqolErykghFnePMgK826JW6Yg7rL6kidlgZbqWREVvxHoWaVtiD2TnzfRvtr
	tVL8I43AznpieiOEoFmLlm8gEWoRSeZoDGAk3HbLJsRuGiAtiYqeZ9fcNCxQRqEyGbcW2HecfdN
	CsbpCyQNl9Mxr2tCQ==
X-Received: by 2002:a17:903:40c9:b0:2d5:3f5f:e645 with SMTP id d9443c01a7336-2dd6c6eb731mr39207435ad.12.1789378500232;
        Mon, 14 Sep 2026 02:35:00 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc2d3bsm46109865ad.48.2026.09.14.02.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:34:59 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org
Cc: josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH 3/5] srcutree: Preserve IRQ state in synchronize_srcu_atomic() callchain
Date: Mon, 14 Sep 2026 17:34:17 +0800
Message-ID: <20260914093419.1474829-4-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914093419.1474829-1-kunwu.chan@gmail.com>
References: <20260914093419.1474829-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

synchronize_srcu_atomic() may be called with interrupts disabled, but
its callchain uses raw_spin_lock_irq_rcu_node() /
raw_spin_unlock_irq_rcu_node(), which unconditionally enables
interrupts on unlock. This can incorrectly change the caller's IRQ
state.

Use the irqsave/irqrestore variants for the locks in this callchain
so that the caller's IRQ state is preserved.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/srcutree.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6c729e805fb3..d32615d54177 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -985,6 +985,7 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 	bool cbs;
 	bool last_lvl;
 	int cpu;
+	unsigned long flags;
 	unsigned long gpseq;
 	int idx;
 	unsigned long mask;
@@ -999,7 +1000,7 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 		mutex_lock(&sup->srcu_cb_mutex);
 
 	/* End the current grace period. */
-	raw_spin_lock_irq_rcu_node(sup);
+	raw_spin_lock_irqsave_rcu_node(sup, flags);
 	idx = rcu_seq_state(sup->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
 	if (srcu_gp_is_expedited(ssp))
@@ -1010,7 +1011,7 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 	gpseq = rcu_seq_current(&sup->srcu_gp_seq);
 	if (ULONG_CMP_LT(sup->srcu_gp_seq_needed_exp, gpseq))
 		WRITE_ONCE(sup->srcu_gp_seq_needed_exp, gpseq);
-	raw_spin_unlock_irq_rcu_node(sup);
+	raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 	if (!is_atomic)
 		mutex_unlock(&sup->srcu_gp_mutex);
 	/* A new grace period can start at this point.  But only one. */
@@ -1048,12 +1049,12 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 	if (!(gpseq & counter_wrap_check))
 		for_each_possible_cpu(cpu) {
 			sdp = per_cpu_ptr(ssp->sda, cpu);
-			raw_spin_lock_irq_rcu_node(sdp);
+			raw_spin_lock_irqsave_rcu_node(sdp, flags);
 			if (ULONG_CMP_GE(gpseq, sdp->srcu_gp_seq_needed + 100))
 				sdp->srcu_gp_seq_needed = gpseq;
 			if (ULONG_CMP_GE(gpseq, sdp->srcu_gp_seq_needed_exp + 100))
 				sdp->srcu_gp_seq_needed_exp = gpseq;
-			raw_spin_unlock_irq_rcu_node(sdp);
+			raw_spin_unlock_irqrestore_rcu_node(sdp, flags);
 		}
 
 	/* Callback initiation done, allow grace periods after next. */
@@ -1061,16 +1062,16 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 		mutex_unlock(&sup->srcu_cb_mutex);
 
 	/* Start a new grace period if needed. */
-	raw_spin_lock_irq_rcu_node(sup);
+	raw_spin_lock_irqsave_rcu_node(sup, flags);
 	gpseq = rcu_seq_current(&sup->srcu_gp_seq);
 	if (!rcu_seq_state(gpseq) &&
 	    ULONG_CMP_LT(gpseq, sup->srcu_gp_seq_needed)) {
 		WARN_ON_ONCE(ssp->srcu_reader_flavor & SRCU_READ_FLAVOR_ATOMIC);
 		srcu_gp_start(ssp);
-		raw_spin_unlock_irq_rcu_node(sup);
+		raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 		srcu_reschedule(ssp, 0);
 	} else {
-		raw_spin_unlock_irq_rcu_node(sup);
+		raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 	}
 
 	/* Transition to big if needed, but never for atomic SRCU. */
@@ -1221,10 +1222,11 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 {
 	unsigned long curdelay;
+	unsigned long flags;
 
-	raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
+	raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
 	curdelay = !srcu_get_delay(ssp);
-	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
+	raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 
 	for (;;) {
 		if (srcu_readers_active_idx_check(ssp, idx))
@@ -2024,6 +2026,7 @@ EXPORT_SYMBOL_GPL(srcu_batches_completed);
  */
 static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
 {
+	unsigned long flags;
 	int idx;
 
 	if (!is_atomic)
@@ -2041,10 +2044,10 @@ static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
 	 */
 	idx = rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq)); /* ^^^ */
 	if (idx == SRCU_STATE_IDLE) {
-		raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
+		raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
 		if (ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed)) {
 			WARN_ON_ONCE(rcu_seq_state(ssp->srcu_sup->srcu_gp_seq));
-			raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
+			raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 			if (!is_atomic)
 				mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return;
@@ -2054,7 +2057,7 @@ static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
 			WARN_ON_ONCE(ssp->srcu_reader_flavor & SRCU_READ_FLAVOR_ATOMIC);
 			srcu_gp_start(ssp);
 		}
-		raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
+		raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 		if (idx != SRCU_STATE_IDLE) {
 			if (!is_atomic)
 				mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
@@ -2070,10 +2073,10 @@ static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
 			return; /* readers present, retry later. */
 		}
 		srcu_flip(ssp);
-		raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
+		raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
 		rcu_seq_set_state(&ssp->srcu_sup->srcu_gp_seq, SRCU_STATE_SCAN2);
 		ssp->srcu_sup->srcu_n_exp_nodelay = 0;
-		raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
+		raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 	}
 
 	if (rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
@@ -2120,6 +2123,7 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 {
 	unsigned long srcu_state;
 	struct srcu_usage *sup = ssp->srcu_sup;
+	unsigned long flags;
 	unsigned long rdm0, rdm1;
 	unsigned long unlocks0, unlocks1;
 
@@ -2150,9 +2154,9 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 	}
 
 	// One last check for others doing our work for us under the lock.
-	raw_spin_lock_irq_rcu_node(sup);
+	raw_spin_lock_irqsave_rcu_node(sup, flags);
 	if (poll_state_synchronize_srcu(ssp, srcu_state)) {
-		raw_spin_unlock_irq_rcu_node(sup);
+		raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 		atomic_set(&sup->srcu_atomic_gp_flag, 0);
 		preempt_enable();
 		return;
@@ -2163,7 +2167,7 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 	smp_store_release(&sup->srcu_gp_seq_needed, srcu_state); // See srcu_funnel_gp_start().
 	ASSERT_EXCLUSIVE_WRITER(ssp->srcu_sup->srcu_gp_seq);
 	srcu_gp_start(ssp);
-	raw_spin_unlock_irq_rcu_node(sup);
+	raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 
 	//
 	// Fastpath:  If there are no readers at all, neither grace-period
@@ -2201,9 +2205,9 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 		// poll_state_synchronize_srcu() working, all under ->lock
 		// and ->srcu_atomic_gp_flag, which excludes concurrent
 		// sequence-number updates.
-		raw_spin_lock_irq_rcu_node(sup);
+		raw_spin_lock_irqsave_rcu_node(sup, flags);
 		rcu_seq_end(&sup->srcu_gp_seq);
-		raw_spin_unlock_irq_rcu_node(sup);
+		raw_spin_unlock_irqrestore_rcu_node(sup, flags);
 		WARN_ON_ONCE(!poll_state_synchronize_srcu(ssp, srcu_state));
 		atomic_set_release(&sup->srcu_atomic_gp_flag, 0);
 		preempt_enable();
-- 
2.43.0

