Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238861D698
	for <rcu@vger.kernel.org>; Thu,  7 Mar 2024 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709855340; cv=none; b=qGtPpr0Q4Q5TV4/KmVXI0sR0wVSnELMBVAVp1TEguDyPQyfZqqgjZxaDFdaO5DXym3KOjHMw2HG0WRLHkDF4A7tZNks8gwfGdowvYHMwptZWGadBYzAcbQR9ihszwbDbqdfgkMb7mb2GtYtis8/7Ki1VivjmOpApiDptczmVwX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709855340; c=relaxed/simple;
	bh=RxrVHpsg2Dx2BK8X3581XvrwOzOq8HuNBnuD6LOVaeg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RmwpMg9HdpcH0S5bzrdwLsNNM+fsscSEasMRQGVBfSLWNeJQXX2IN9j8tn3qKwPRnoHFIHDuGw1N+kAyAPakR24CS0lJTOmNMvHDLKCDqJzfb1l1ceWGxzpYLQ6a6okYTooJ2hOV2qYmhviOVqBunruGEhFhJxsLoFBlpG52OjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=UqYhQJyU; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UqYhQJyU"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7dad83f225cso513595241.2
        for <rcu@vger.kernel.org>; Thu, 07 Mar 2024 15:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709855338; x=1710460138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oYvliaxZHHBmxRsoWW/yY+ZGpMLYNfkC8wPuph2ba+I=;
        b=UqYhQJyUXhxEkZLK/rHVtwYhsz2FtravUlbjPH0/ZdC3hlERktMkw7NZNlHbYeMPiL
         otAvY5uW4OkY8BEY6CWBi1aX/XnfDWD+mCSr4cMzZa9JHNyf5sokwuC6rkxb7Ce1w/TY
         KDizQH0P9VED4p+M2mGaLy0l9vtYLzWhMcbVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709855338; x=1710460138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYvliaxZHHBmxRsoWW/yY+ZGpMLYNfkC8wPuph2ba+I=;
        b=kAxh2gDjCj3xdxtvk3tW85GmE3MKRNlboOvY1s942ZLieRp2GcP8pO/D/ZO078c1se
         3ivWQqt+S8eMX5vj+UpuzvaJNvsk3p5Dpuh26boBx4d51i7hSnJcDZyxY7MJie77PnnP
         Yg6Gg47R3b+hyYi0IZE2A15v/f4GIEj4xQ57a6nRTPotH2rzVuA0Fw5kyTLdSz46TzqB
         6u72V6HYZ4WiiLanaSpp2RtWgDttdvElHgyFXJyjTSMBfo72jKCsSZf/Suu6l4etYxkI
         kE+TY8YaYq2eI0X9G8UGTVewPFP4wY48dtP+Zzd8126nsey/6EQLkwqaBp5PDsZQc5aN
         hfaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOe0oKuLOeHm7D41+HWTfVa1RFt3UXHiAF3agxpf+5e1izSbydCqzNMBQ+klbNtNA5SFaeozEiXmNbsQSqJUMJnfhM
X-Gm-Message-State: AOJu0Yy/pjVcaO7gt0wLD2a1C4VGKsFuWzittISaTUGoiixGPk+l41v4
	GGSb6XM7IBjt0BxJVAl1qumEbFnzRvtOn7J1cX+c3O5GAe1j4nGhpB2O6bGNFVw=
X-Google-Smtp-Source: AGHT+IG80+aEd9lIN5B2HVx0CQ34g6WerPXfDJlUp6/m/zTDrrep9d6Wz39fnLHME4Zb74ahclhAbw==
X-Received: by 2002:a05:6122:996:b0:4cd:44db:b24b with SMTP id g22-20020a056122099600b004cd44dbb24bmr9607129vkd.5.1709855337543;
        Thu, 07 Mar 2024 15:48:57 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id t4-20020ac865c4000000b0042f04d37e89sm2980907qto.10.2024.03.07.15.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 15:48:56 -0800 (PST)
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
Subject: [PATCH] [RFC] rcu/tree: Reduce wake up for synchronize_rcu() common case
Date: Thu,  7 Mar 2024 18:48:51 -0500
Message-Id: <20240307234852.2132637-1-joel@joelfernandes.org>
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
 kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
 kernel/rcu/tree.h |  1 +
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 12978049cb99..cba3a82e9ed9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
 	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
 	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
 		rcu_sr_normal_gp_cleanup_work),
+	.srs_cleanups_pending = ATOMIC_INIT(0),
 };
 
 /* Dump rcu_node combining tree at boot to verify correct setup. */
@@ -1641,8 +1642,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
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
@@ -1665,6 +1669,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 
 		rcu_sr_put_wait_head(rcu);
 	}
+
+	/* Order list manipulations with atomic access. */
+	atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
 }
 
 /*
@@ -1672,7 +1679,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-	struct llist_node *wait_tail, *next, *rcu;
+	struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
 	int done = 0;
 
 	wait_tail = rcu_state.srs_wait_tail;
@@ -1698,16 +1705,35 @@ static void rcu_sr_normal_gp_cleanup(void)
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
-	queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
+	atomic_inc(&rcu_state.srs_cleanups_pending);
+	if (!queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work)) {
+		atomic_dec(&rcu_state.srs_cleanups_pending);
+	}
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2832787cee1d..f162b947c5b6 100644
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

