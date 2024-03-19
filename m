Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99817620
	for <rcu@vger.kernel.org>; Tue, 19 Mar 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869058; cv=none; b=AWOQVMWMPI4oE5E9tT+PxTGtHiHiJuSZXJplxGZFNVNXUY3UHeUzgTcWue4awWYua/TFaZB52jNZEoh7KkGtb4Bd9B0sZ0Q54sUglYqxSicZatbaySDZQPn22hZO1uJvEqq/CzghyzdMsOHDLeG0TkZCfjZW2b52VKV47dxFeT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869058; c=relaxed/simple;
	bh=e7yeIqUpzRjjdTvOBKM5mQZ7beBxblyQQJZNb13cJvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X5w1jh1uuklSNNqb2HKQMVVyrl5KWOMDcowU72juDTL/Ug6Z3VU8NTU6iAow46VAq/GCSZXz3oG7GtXgf6rnXVG+NadUl8+y6EwEWjrn3Z+thVCNpbcYVaBIeQXojGeN9gIV3G64GDZr2sppOY9Md2G98JIDqeSTpPiVB64aegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=MpHKHX5A; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MpHKHX5A"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c35c4d8878so2621602b6e.1
        for <rcu@vger.kernel.org>; Tue, 19 Mar 2024 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710869055; x=1711473855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGf7OdIZL/0mVWg7rMGIh3EEFJoK6ZbRGH0lmn+lIjc=;
        b=MpHKHX5A8reaZRm9sw+d1bMQpEoIavfB1xkO1dNgqIZzSAVrBV8BBPvKhEY7qc7Z+k
         eJ/HMyHdZbqmrhDSNQDuL42MF1/4bR97UFEclaFOC4y6+s5hGf77zfrb3ZEZ9tFaTre/
         h5gOe2xVYbH0l4IMpBZRpxvx2TDRBUQxENwsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869055; x=1711473855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGf7OdIZL/0mVWg7rMGIh3EEFJoK6ZbRGH0lmn+lIjc=;
        b=DrNSt+VTwfp1X9Z7+W3Om/Re3SE4r1ypyTlBJwfJdsN0iqNoC3MwVI/R8fysbtr/FC
         FeNNM2PTCOEMcF7SaKTt09y1LQ4fBr0Q8y1MUiuVYyqGGZXdpQDFmuTSVy3Y/smx4qxj
         FFmmEHJoolknpfz48O0Ac/olFiJhYvMRyR/TpaWUR9htcelAFnLYPNOt+tK9Bsyx9NBH
         53dH8MQii5Fs0aNlY1zC0ScIodck1HF65RSEE6fgmlC4JfaKMxAemwBW8Mei2XlP28gI
         XOfG9JUl+2ieRDTwDejreyUJS9Zp1TJhRtkXMKtKJSPdgef1CndTrcfkUhvB1eEHNsnz
         /T9g==
X-Forwarded-Encrypted: i=1; AJvYcCWu71p58t2RhajTu7Y/7oxQJhCYejcSyktf+FCF/R7oBHwDb2sCHKYONuyGPMYBKivEtUdw/IMNgZt5W4jwl+uY/nDH
X-Gm-Message-State: AOJu0YzZIsQ2gpZYPmoiwa5632Q19p8qnbVgSqhje2XJNbhX2pq4INwd
	sAYhO+5nXSgaBosA0nvQhcBNR/e5KuUebzGFTot3mWBizrOvucVLYcHzFhWCpMA=
X-Google-Smtp-Source: AGHT+IGr+lA72U15DPRVE9LxkyBtJUHTWLbWUf55SlFl333j8vPBbZeMOCrcpSgj2WhhLDcnmke5Vw==
X-Received: by 2002:a05:6808:2219:b0:3c2:bec:69d7 with SMTP id bd25-20020a056808221900b003c20bec69d7mr21116497oib.48.1710869055467;
        Tue, 19 Mar 2024 10:24:15 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id ch14-20020a05622a40ce00b00430dcca3fb5sm1624717qtb.16.2024.03.19.10.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:24:14 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: urezki@gmail.com,
	neeraj.iitr10@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH v3] rcu/tree: Reduce wake up for synchronize_rcu() common case
Date: Tue, 19 Mar 2024 13:24:11 -0400
Message-Id: <20240319172412.2083384-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the synchronize_rcu() common case, we will have less than
SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
is pointless just to free the last injected wait head since at that point,
all the users have already been awakened.

Introduce a new counter to track this and prevent the wakeup in the
common case.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Rebase on paul/dev
v2->v3: Additional optimization for wait_tail->next == NULL case.

 kernel/rcu/tree.c | 37 ++++++++++++++++++++++++++++++++-----
 kernel/rcu/tree.h |  1 +
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9fbb5ab57c84..f06d13993478 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
 	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
 	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
 		rcu_sr_normal_gp_cleanup_work),
+	.srs_cleanups_pending = ATOMIC_INIT(0),
 };
 
 /* Dump rcu_node combining tree at boot to verify correct setup. */
@@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 	 * the done tail list manipulations are protected here.
 	 */
 	done = smp_load_acquire(&rcu_state.srs_done_tail);
-	if (!done)
+	if (!done) {
+		/* See comments below. */
+		atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
 		return;
+	}
 
 	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
 	head = done->next;
@@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 
 		rcu_sr_put_wait_head(rcu);
 	}
+
+	/* Order list manipulations with atomic access. */
+	atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
 }
 
 /*
@@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-	struct llist_node *wait_tail, *next, *rcu;
+	struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
 	int done = 0;
 
 	wait_tail = rcu_state.srs_wait_tail;
@@ -1699,16 +1706,36 @@ static void rcu_sr_normal_gp_cleanup(void)
 			break;
 	}
 
-	// concurrent sr_normal_gp_cleanup work might observe this update.
-	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+	/* Fast path, no more users to process. */
+	if (!wait_tail->next)
+		return;
+
+	/*
+	 * Fast path, no more users to process except putting the second last
+	 * wait head if no inflight-workers. If there are in-flight workers,
+	 * they will remove the last wait head.
+	 */
+	if (rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
+		/* Order atomic access with list manipulation. */
+		!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
+		wait_tail->next = NULL;
+		rcu_sr_put_wait_head(rcu);
+		smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+		return;
+	}
+
+	/* Concurrent sr_normal_gp_cleanup work might observe this update. */
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
+	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
 
 	/*
 	 * We schedule a work in order to perform a final processing
 	 * of outstanding users(if still left) and releasing wait-heads
 	 * added by rcu_sr_normal_gp_init() call.
 	 */
-	queue_work(sync_wq, &rcu_state.srs_cleanup_work);
+	atomic_inc(&rcu_state.srs_cleanups_pending);
+	if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
+		atomic_dec(&rcu_state.srs_cleanups_pending);
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index bae7925c497f..affcb92a358c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -420,6 +420,7 @@ struct rcu_state {
 	struct llist_node *srs_done_tail; /* ready for GP users. */
 	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
 	struct work_struct srs_cleanup_work;
+	atomic_t srs_cleanups_pending; /* srs inflight worker cleanups. */
 };
 
 /* Values for rcu_state structure's gp_flags field. */
-- 
2.34.1

