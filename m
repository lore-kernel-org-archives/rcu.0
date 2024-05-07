Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9226B15ECCC;
	Tue,  7 May 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074574; cv=none; b=ht7Js9Z18dtj7op/t4dpAIMFSzvGLaTrfLII9+rs2fpTscgqbtjFP4zJGZNbUor9TY3r2RhJy9kuFkrc8w1gvEOWYnxKXNacwwTvqy/CZoueIRk3rYLW6QnANHf8ukwUX1PGODWrDx41qFhGg3BBBnQPFJTG0QWd7x9MhALCft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074574; c=relaxed/simple;
	bh=FSe7L4XahPulJ5NWwKASJPrFyN+6QSNIQKLFJWJyFOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r8M/7TPahBJZW53Br+cmnXoGptq1BXiWFwoeMMIthVnUVdnqCYnGduJDAXzoKqQCnZ6ajOl9VVBkGhCDiE2wzcCzX8MyuOZVEQaRs8fZBAdwdjJRb/kbpeYR7xz3YU6d13hAxFdZACVjbq2RQq+lh82SyR5zAZWJNKFAVk2WiRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYZ0ep+x; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYZ0ep+x"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e3e18c240fso8460181fa.0;
        Tue, 07 May 2024 02:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074569; x=1715679369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2K4LgSBtjYfVsokX8qgwwcmFotZID2ml7T+yfPfGHDY=;
        b=mYZ0ep+x5jwNKoVZINdgBE3KuH9yfI/Rwi2PxKVpeKEWuS0CW24QSi43BPPcFfcbGg
         WJcUDbmLhyaeg3fdbkPqidgc723KRKFhfjC4hYf2xzZaNrEpvMDuYJSp0amp5FYj0Zcm
         h+w21M3gr/smMzqU3xa9Xulfpli8QW8ZiNJ/tD7vVTcG2JuufKLFTvXTGtqasWGjY6pC
         WFf3jQsZQa8i+ObFfkvAaZHfcvEGnWZW4ekzyyIg1bglqUSlqfcWxz/2YYN5nXbhlYDo
         3EmZWz/nl4gIlMcruzHRZpusex/35AXB/daPbWMv9J6thojEbcKbaQAzBSBkXuh9bM6u
         Zthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074569; x=1715679369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2K4LgSBtjYfVsokX8qgwwcmFotZID2ml7T+yfPfGHDY=;
        b=QgMZdVf29veObcmVNTjY1ZSxmud+Bg1p5ez/kRr6rAwvK/3qzFaJDvig/+XenHaktj
         Y0/lV6ybCsvKX4ScvhkhQ3ITZPPu52FZvKFYJ3UEJNvWndtDybhGrgpLxnY3aFnDn+NZ
         5J/no/mW0j5o/gQO8V8QnylL4zqKVcRQRZJzMTc3wSO/FGyn0AFtK/eO+qKyKeveBCye
         H+0Jdy/8p0FBsFFHMVbK1wrUqb1SQoejk8sA7vGzcBCRRbOKzAeeWuvQKU3vPhVdh8qT
         AWZbf8cDB0mJwSp9zuKaaf62KXe/zNiwq9GFii3jKjIl3c6D8sZI2VvyauA7scDRnYiW
         CNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhhNSr+CMYOVVGVxZEuhz7dRgT5bkpqx6gjYlyM62RmzQihmxYiOp4zjfoD8EZ+BKV1tcGnQHDYDc5fITupVCDVUfUiulxZniWdAGP
X-Gm-Message-State: AOJu0YwPEr1WFb5BAx1M4E4J+yEa+EHHAwUMn7sPsvzCtMQHKq9NyZCm
	+bENiiE+344sSrqA+7AkCsZVDduRA9zx0iGI+aeXrzoQSFZRUbaI
X-Google-Smtp-Source: AGHT+IHFO+7vnyh7sLgrAAy1bapshrWvgpxYIMic2T3SiCD6fIcqP0vLE6uWUTB4gSO9QyJ3221r+A==
X-Received: by 2002:a2e:3309:0:b0:2e1:f05f:6424 with SMTP id d9-20020a2e3309000000b002e1f05f6424mr9920045ljc.15.1715074569596;
        Tue, 07 May 2024 02:36:09 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:09 -0700 (PDT)
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
Subject: [PATCH 37/48] rcu: Support direct wake-up of synchronize_rcu() users
Date: Tue,  7 May 2024 11:35:19 +0200
Message-Id: <20240507093530.3043-38-urezki@gmail.com>
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

This patch introduces a small enhancement which allows to do a
direct wake-up of synchronize_rcu() callers. It occurs after a
completion of grace period, thus by the gp-kthread.

Number of clients is limited by the hard-coded maximum allowed
threshold. The remaining part, if still exists is deferred to
a main worker.

Link: https://lore.kernel.org/lkml/Zd0ZtNu+Rt0qXkfS@lothringen/

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 24 +++++++++++++++++++++++-
 kernel/rcu/tree.h |  6 ++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2e1c5be6d64b..2a270abade4d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1645,7 +1645,8 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-	struct llist_node *wait_tail;
+	struct llist_node *wait_tail, *next, *rcu;
+	int done = 0;
 
 	wait_tail = rcu_state.srs_wait_tail;
 	if (wait_tail == NULL)
@@ -1653,11 +1654,32 @@ static void rcu_sr_normal_gp_cleanup(void)
 
 	rcu_state.srs_wait_tail = NULL;
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
+	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
+
+	/*
+	 * Process (a) and (d) cases. See an illustration.
+	 */
+	llist_for_each_safe(rcu, next, wait_tail->next) {
+		if (rcu_sr_is_wait_head(rcu))
+			break;
+
+		rcu_sr_normal_complete(rcu);
+		// It can be last, update a next on this step.
+		wait_tail->next = next;
+
+		if (++done == SR_MAX_USERS_WAKE_FROM_GP)
+			break;
+	}
 
 	// concurrent sr_normal_gp_cleanup work might observe this update.
 	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
 
+	/*
+	 * We schedule a work in order to perform a final processing
+	 * of outstanding users(if still left) and releasing wait-heads
+	 * added by rcu_sr_normal_gp_init() call.
+	 */
 	schedule_work(&rcu_state.srs_cleanup_work);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b942b9437438..2832787cee1d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -315,6 +315,12 @@ do {									\
 	__set_current_state(TASK_RUNNING);				\
 } while (0)
 
+/*
+ * A max threshold for synchronize_rcu() users which are
+ * awaken directly by the rcu_gp_kthread(). Left part is
+ * deferred to the main worker.
+ */
+#define SR_MAX_USERS_WAKE_FROM_GP 5
 #define SR_NORMAL_GP_WAIT_HEAD_MAX 5
 
 struct sr_wait_node {
-- 
2.39.2

