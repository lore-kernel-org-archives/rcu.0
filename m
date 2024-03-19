Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF0038DC3
	for <rcu@vger.kernel.org>; Tue, 19 Mar 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874506; cv=none; b=WBAXXHEqGxCIkzckHAgeYegA9oypnH69Nu9Z8xgQ9IwKMm9fmmhdxwle6T+96tVXNi7WmzFHMOb7KDe6MKhrwq1F5/JLtA4mcNZ2zygrgCjlc+57BpqPX1n0KVasxnIiZY+Slov1ImCzDRTLnBifh/t1FjSVZ6XlHQw1VXdyOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874506; c=relaxed/simple;
	bh=9tQwu/pTYuSg4zKOhht1Xekaj5u2ebuKBMHtRD/e+M0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EP6whzYuSWfkn43+ZtEiw3j8m3J0fxjdxWNaV5mZAI9VnSqo+YtLveC3L1qLu1/CVIIGP3D3QwwyTJtuFTz5waBlkLHxXBGrL99jsraRrk5oXP/gfTT9rOjOFA3TMkbpTlBL+pAY/9f5PTNZoZwSyVnp0D0SSbThc7iMjs6dElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=s2WeZm35; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="s2WeZm35"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e675db6fbaso3483253a34.1
        for <rcu@vger.kernel.org>; Tue, 19 Mar 2024 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710874503; x=1711479303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1rbLDP9C5tBEsyxTYFGuT0+N/vSDd8dZonUgNGX8BHM=;
        b=s2WeZm35n5r6lclZ9WfmlwxVr7lBrNQ4jT+IL+uIYk6mRl1AkE44eISLbL27y2OPWt
         spsthZnRT2nacWqCAsL+Qto9Y1V8h95F4QW+7xzcEJQUljYm5ba26CEz9AS9mkY2/LbG
         PFM3i6JnM9tXczWW62vc2g4mkw4GvnqY0HLm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710874503; x=1711479303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rbLDP9C5tBEsyxTYFGuT0+N/vSDd8dZonUgNGX8BHM=;
        b=Y8Px7ycJEJkk2s8Om5aAb+9CaUjKDeZM5esu95ynPCCdchUTn0KpaViegZQ6KxngPn
         w5Pg4qY/1f5ieUjQyMgBlFELQ/22fSqnQt1nz2+EY/7aBCT73ZNKwXYGcl1xVKzkNtJI
         MEqhTYdVxEfDevb2wbdFRUmz2MZBGKPDecmzyp3n00Sfcbv7VcG14wj4sliwzmWU5MG1
         oLSv52ImfcZ/69m8JwovHH5xbdUSPCsT/pz+Jb/Nudi22bCl50RoBX7SefS7in7QhP93
         h8bycMRFwBtrZoO/I32MSyRuCAnSqvEDRhusbJiAmGX3GLcFG9tTlXQrofXEzvP9pe02
         B72g==
X-Forwarded-Encrypted: i=1; AJvYcCWrKlXwcvwZJQnKDMC6IYDc2YUOciZgI8wnxvhN6Ao+5VhLV5S+3wsOo9nfTcY7NZN5CBtbB0l4JfNx9Z2eSP/PN7t4
X-Gm-Message-State: AOJu0Yzztfh4/HlzsRXCcqv0eF44aCkFdyOjqr0o4AauVMYAdtrFTu1z
	/dnZniM8u6r+5+yfxk4P6pn9e5RJ979TlwdoE3oLTVfnzXcFAH/kFir3BzoDwEg=
X-Google-Smtp-Source: AGHT+IGRuRQLFJ+LQ7GNxxar6uONk9dp+dom60UmGbwCzV2PiV02mP8ZtM6CtxNZWJET0w94SVR5kg==
X-Received: by 2002:a05:6830:12c3:b0:6e6:968d:8df4 with SMTP id a3-20020a05683012c300b006e6968d8df4mr3604953otq.26.1710874503419;
        Tue, 19 Mar 2024 11:55:03 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b0078a0edbaa94sm1135519qkj.91.2024.03.19.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:55:02 -0700 (PDT)
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
Subject: [PATCH v4] rcu/tree: Reduce wake up for synchronize_rcu() common case
Date: Tue, 19 Mar 2024 14:54:57 -0400
Message-Id: <20240319185458.3968308-1-joel@joelfernandes.org>
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
v3->v4: Apply clean ups from Vlad. Tested rcutorture all scenarios.
---
 kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
 kernel/rcu/tree.h |  1 +
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9fbb5ab57c84..f3193670fe42 100644
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
@@ -1699,16 +1706,34 @@ static void rcu_sr_normal_gp_cleanup(void)
 			break;
 	}
 
-	// concurrent sr_normal_gp_cleanup work might observe this update.
-	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+	/*
+	 * Fast path, no more users to process except putting the second last
+	 * wait head if no inflight-workers. If there are in-flight workers,
+	 * they will remove the last wait head.
+	 *
+	 * Note that the ACQUIRE orders atomic access with list manipulation.
+	 */
+	if (wait_tail->next && wait_tail->next->next == NULL &&
+	    rcu_sr_is_wait_head(wait_tail->next) &&
+	    !atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
+		rcu_sr_put_wait_head(wait_tail->next);
+		wait_tail->next = NULL;
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
+	if (wait_tail->next) {
+		atomic_inc(&rcu_state.srs_cleanups_pending);
+		if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
+			atomic_dec(&rcu_state.srs_cleanups_pending);
+	}
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

