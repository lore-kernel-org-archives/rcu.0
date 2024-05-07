Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2614C156F36;
	Tue,  7 May 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074548; cv=none; b=oxUnVqEU7lVrPQ3a6LZUB/8FMblrj+9EZdgcFMkLRKIyDfX8w6g2cli0ZkC5Wfhp9K9emq3/+CHtKpoW0dAuXvYxKtV+0ohN5mZxqcioK5rJfwEun+uPUNoqEU7HImYGmCDyQZgmKH8YerbCxLYPVcd66u0B61l6c2sKdkRTv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074548; c=relaxed/simple;
	bh=uI1wZYUdEsHG1vr/UD/ng0oR9crfeMvCEO8dnQg07kM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RbWAF6zOqdTbBWwde892XP+1ysZN4nlPAXhfGPOJFvX00+LH0iWSH6XeCbGugdjsvuRww8G6GFF4pm1CYyQYNftY93qgpOU2f26xRo/O17BdSpIYqACBsmnSL+betDSOYnHU0OF79LCL9+eb1K2/GibhBYo6XrN4JlL6MgTaemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLQDeegI; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLQDeegI"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e0a0cc5e83so29085011fa.1;
        Tue, 07 May 2024 02:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074545; x=1715679345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9khWE7rlDVNG5sjle6yOolXySu0ObdFH96voTvp2Qf4=;
        b=CLQDeegInkUSqAvqe+S8qHHa3bUS5VAhJUngZl6s5hA8v+wvH9BCKk8/Bk0lEtO5ku
         svOZKolrB14Ivox+oWC2QVLfDudX3vLM3wdYPHP3jeLHs1ZbkugavmyGNGG8j3ckpwTv
         yI7g6i5Q1FOi5/WKBpC0JTOqfKG+MK8/9U40t/X2lhIQF1g8KErpIlSKChTauDKQV7rr
         WtHMDYo6vuLeHm9oDC8lz/oDi/NlTcqFZC7j93661wV3yXhK5MUOiQffFpfwHS0ucsmV
         h0p/73k8cIWqJH/O2PSLRErtJjEyQEYTz7UJ4TyD9YTWUQiXGFZsqjYvzrwcJAYOTpa9
         /m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074545; x=1715679345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9khWE7rlDVNG5sjle6yOolXySu0ObdFH96voTvp2Qf4=;
        b=a9H1L+D24Qo/kRtoYL6h7e5M6bL0HkyvjCKyHXjmAYRRslZWC0EnPiWwn2IKTeW80M
         0fiwAvexrQa8LgDphnSaP3Idw/QRfcZa3j8Gb2MX58rtxz/oker4VDEevCN4a2OUHcjo
         hJ4q1kittb7jPxNq2QzXa0SOhlSZU9nIpAgqxFGh9GIFAlV9Gs7aQ0v8zPbOrXnChO2L
         ToAPFoU4YsZdp27bx2wNjTYWfVe3GmXeOlV8EfrSawbAEXwty9uvOypjEZjCgMqkzi5r
         Bir1R7HSLGaHip3KeH6+0Y9zBtGfB9V31snCQ0/DKcWPWqv0wDgNfDmyubGt9Xq8SA8e
         oFJw==
X-Forwarded-Encrypted: i=1; AJvYcCUi4mOFs6yPkNfPIpHe4YfQFFGMoP5X8RyAeODZMV/BMTY39KLeOcHsicLXQ8mgRBoOe88NHJHS8PhOn9Yj5arOjqZ/QDMtCKN/8XlD
X-Gm-Message-State: AOJu0Yx+YXyLwQ9/Pcs53DXUGG6/KWXsQerT1U7ihfqczUekcwMArhOj
	k7KPBIfbVQDCKeUb24EYXG7U2ikeD2qFAEtLzDi3HsyT36ksTblT
X-Google-Smtp-Source: AGHT+IGz8XnvZ8KkknLMrsQ7bPyorVmuS3zglfZMTVnQ3etWj7zmuGV3RWijd25RAAzMNeZbT7uXpQ==
X-Received: by 2002:a05:651c:604:b0:2e0:4cbb:858a with SMTP id k4-20020a05651c060400b002e04cbb858amr6192750lje.27.1715074545378;
        Tue, 07 May 2024 02:35:45 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:45 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 13/48] rcu: Add data structures for synchronize_rcu()
Date: Tue,  7 May 2024 11:34:55 +0200
Message-Id: <20240507093530.3043-14-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The synchronize_rcu() call is going to be reworked, thus
this patch adds dedicated fields into the rcu_state structure.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index df48160b3136..b942b9437438 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -315,6 +315,13 @@ do {									\
 	__set_current_state(TASK_RUNNING);				\
 } while (0)
 
+#define SR_NORMAL_GP_WAIT_HEAD_MAX 5
+
+struct sr_wait_node {
+	atomic_t inuse;
+	struct llist_node node;
+};
+
 /*
  * RCU global state, including node hierarchy.  This hierarchy is
  * represented in "heap" form in a dense array.  The root (first level)
@@ -400,6 +407,13 @@ struct rcu_state {
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
 	int nocb_is_setup;			/* nocb is setup from boot */
+
+	/* synchronize_rcu() part. */
+	struct llist_head srs_next;	/* request a GP users. */
+	struct llist_node *srs_wait_tail; /* wait for GP users. */
+	struct llist_node *srs_done_tail; /* ready for GP users. */
+	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
+	struct work_struct srs_cleanup_work;
 };
 
 /* Values for rcu_state structure's gp_flags field. */
-- 
2.39.2

