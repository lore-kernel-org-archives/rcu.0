Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C32D611
	for <rcu@vger.kernel.org>; Fri,  8 Mar 2024 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937885; cv=none; b=a0N0njQDDMgr0HWRhKBEZ4hE3OnyQtqkt7/wTFA7ltAHHHrCcm1eDtZb3GbxnvTq4i0556EqCQ3LRtNvZGVX+r9APi6KqrmM23/k2d47Th957pYHq0R5bp2rwxgGOxMMNLF49BWuWAcVmEJwMNWdsgtTMKMbZEwRnAsG0LqZSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937885; c=relaxed/simple;
	bh=v7DZ+Vb8YxhnbKdMmawFNDI46ZsBdnSyQ11R4R+guOw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Ee/Nq9JuNfqLumGGFSq+z8l6FMmQx2sF05rqAZGIc7Cm7pQOY75W8ZN1ZvDBN/hXbIKHA35wbrdAWs/1/drVjkQ+Hr6r/Xy8IJPhnPHc/qWakQS4URLXZQF8ZdJE+bpWghFAIbj93hbRdYhB4N0V/K9VkU8UaErNL1q6enrPmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=ix7yo8ZX; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ix7yo8ZX"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-690a60d396aso8281536d6.1
        for <rcu@vger.kernel.org>; Fri, 08 Mar 2024 14:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709937883; x=1710542683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iD+SjmlOeaPExLkTxwHt+ImqT/q8k7wQBnKxxPL1kU=;
        b=ix7yo8ZX96vxUxSVjOxN70xy7zq52YXv1T0yFs2RocuSfwpUtu+x35KdLNsnts2ldL
         f6O6MXD1C+jKkwrKa9D6HJM9jQ7jm2K01fqlQ2azhSjvlQK2FuYhDPFtyw2Rg5JwPmL2
         TqUo5VHL79ilzSPEwA7SO6a7qU/Qn+/cp0iuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937883; x=1710542683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iD+SjmlOeaPExLkTxwHt+ImqT/q8k7wQBnKxxPL1kU=;
        b=D7BA5GVbRFp/JFKCgZ2y+qAkiH8foBGGC8yX6+bbrivU9yNs+7wYHjC0PM9ulTSaAz
         mD2ll5sK3fFYWbVETTouFTmhnd6xRPK3K2caW3feL2q5SU7SYUxmdKavwf6Bm+OO0S5k
         KgoYozUmeXBjGa9eebGYkM72vVfarRKoMQPS274iojZyr463c8g0DC13E2oDAuj2eD6N
         9+DZ7KVs/JO9ikZTkFTvrpW5xWGLXIOlQOXsMIyH1iv/oDpHo0Kt/xxiFOfwsKhPMOa1
         jNh/yAg4WR+2LjdUtG3+jhBGAFhZMyH0AGMFnAR04z3HjGaUcIB3MXMxEfyhR3UI05ed
         EkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXirTnzH88KRhxmHXJZq5DcZvrDgf+7k0F3t+peziqgyAORuYrwL3/k3dmUCHRn/VZxaJB1YsNsNcLrC9ubTg+ld3ix
X-Gm-Message-State: AOJu0YzH+Q5Q7bw8qjgOj2WHnw0vfTaOPYSPtrnL6MYHGBRTt3KdKCp0
	PeVRHJLU5C0vWYFWHHSiQAubfDqw6LwAU82ANMUKYpQTYPs42VFZwAwz22mqhQg=
X-Google-Smtp-Source: AGHT+IGQSXboq0XMNYKPbxgEvyg2w6pTP2ja7wrLRngBon1irEPARjIk6bbhJ2ojEp/4/OR48b4JKg==
X-Received: by 2002:a0c:f786:0:b0:690:b4a4:4298 with SMTP id s6-20020a0cf786000000b00690b4a44298mr429378qvn.61.1709937882865;
        Fri, 08 Mar 2024 14:44:42 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id px21-20020a056214051500b00690c0936d70sm36960qvb.127.2024.03.08.14.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:44:42 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	neeraj.iitr10@gmail.com,
	joel@joelfernandes.org,
	rcu@vger.kernel.org,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 rcu/dev 1/2] rcu/tree: Reduce wake up for synchronize_rcu() common case
Date: Fri,  8 Mar 2024 17:44:37 -0500
Message-Id: <20240308224439.281349-1-joel@joelfernandes.org>
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
Rebased on paul/dev of today.

 kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
 kernel/rcu/tree.h |  1 +
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9fbb5ab57c84..bd29fe3c76bf 100644
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
@@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
 			break;
 	}
 
-	// concurrent sr_normal_gp_cleanup work might observe this update.
-	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+	/*
+	 * Fast path, no more users to process. Remove the last wait head
+	 * if no inflight-workers. If there are in-flight workers, let them
+	 * remove the last wait head.
+	 */
+	WARN_ON_ONCE(!rcu);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
 
+	if (rcu && rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
+		/* Order atomic access with list manipulation. */
+		!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
+		wait_tail->next = NULL;
+		rcu_sr_put_wait_head(rcu);
+		smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+		return;
+	}
+
+	/* Concurrent sr_normal_gp_cleanup work might observe this update. */
+	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+
 	/*
 	 * We schedule a work in order to perform a final processing
 	 * of outstanding users(if still left) and releasing wait-heads
 	 * added by rcu_sr_normal_gp_init() call.
 	 */
-	queue_work(sync_wq, &rcu_state.srs_cleanup_work);
+	atomic_inc(&rcu_state.srs_cleanups_pending);
+	if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work)) {
+		atomic_dec(&rcu_state.srs_cleanups_pending);
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

