Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EBB18A6AE;
	Thu, 23 Jan 2025 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658717; cv=none; b=hKYgvYZRGlftYkDWwlP2eI1ooeBahJ7p6iEo820FRaCzrnTwn8qaDw0Gt09Y8DtwbUWRQT+TMZEbCdbzeW0zPVPzgKWzSdpVCjgMWoUDO5SgY3UquqEzr/Mhkpq/zplHpGeJhjUGys/7ElDyDDUS2qP2dgQCTtO+geqWOmVSJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658717; c=relaxed/simple;
	bh=1sllsi9F/Q/N7eTgfTFGVbPA87tR/DUWvo5VkBPNlPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CkXRTyKueyUzYs8ujmM7V5zjwD7KWwOZoOYhtrJglZHUAR23nhOQr7THO0hKGbv7ulCyC3YWyp/n4+ernWwn+ItQ4JmX/MvsLL+KvRjUemGsj1Dbib3ySp76o+k9fsELMYGMNkIosWE35CJ1h/t8wEqpZnl6d2wvOhRj+Efnjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1PYfeWJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1PYfeWJ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-540218726d5so1429933e87.2;
        Thu, 23 Jan 2025 10:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737658714; x=1738263514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQMpcEzLxZWnBlEPxsQY2sa6eEqK7zJT3M51w1wAnJ8=;
        b=M1PYfeWJqsehadbgbBgdvIJ3sAa7s9NyB4u3ta+ia1KhXZgzagyGz0QZWFHHhdfuaf
         6M4YyHgqYkJL9wJf5e9EQxjZfVPz3Y/wRweBOp6gGNNjXOdkAhjDmW94UgHkmmwny7ru
         im4Dmq3bR02CQEzEGd0tFE7nBQTqh7f2c3tIJT2RqeeMdEBk6+zCOQPDDNAxnq8+VvA4
         AYulXiADbSd6bDr91zQmpJSo3u8K2GyUBMfj94XJlwQ04miIyV/D+rzm6KmISDANj7cv
         bR2MN3N2Onih3DxT+piYp8q64i4FNkGWv6uSOJoodgg9+nKV+p/5SUD+PB8xc69xj3Oe
         jfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737658714; x=1738263514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQMpcEzLxZWnBlEPxsQY2sa6eEqK7zJT3M51w1wAnJ8=;
        b=di3rxV0nqpyZ2EqUPhcjVKFIdxMDN8+qdApJvEi53aVF03kTQBOWcegQc4M/Hes4Q/
         +rM3NQoYzzKvWk5uNrPRK1Bk+6o1cPr22HwNsgpeFgdDNgQpCjSEOQSMytgaS7BBJKQ3
         lyqQmA97RKYwG+UzAsS3IogUjganAVgcAhDJhLEx3lqBSBkhVYWtnB21VhnlEa357NW0
         xfvflv7A9LaLncJcnCxCPScoyiSGCPSogDoGBhkdjXpfIZorf4BjyQq7hn8sQg+llAfj
         kjxhP/mogDdQyegnTWz9UYQEsDr9ZWpzlr0yo93S8926lTj/PsYW4iPmIiHD+Q7y1B8P
         tTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5DHtHaZ+5I1UUT/uXncLKA/GaY760RGNhkGy/k2O/qeDUnaUgw1Tu366qlG36TQTpEB2PoHweJhIh/NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyybCIOO8YAI5Xcu1+fCTvCh53v0vnI8XplV7S+WiWtXMGIvhGY
	vas9HxBvxSr5lfwpU5QjBV8yqS5LJ2dF7w8ERc28Q2e3i+OLiPjD
X-Gm-Gg: ASbGnctknoWXtvfUMBIDUSzBhXUNkS6Gfj+NiwTc6BkjiRFT87KofPK+N08EcxyO6jh
	OVefhXwBOpzllmAPKHrba4cLoaxRkxdb5IAnLMcI0PYAq86bpd18GTfJDNWn5x+46srAZgLo3rx
	je2sF37/ng2mR0QmiofCjZfYDdn/JGXu7DCl8xer+b3vIG3WYzM+D/AB/iqmxPiHsphalP263av
	1gD8nFY2hIM6hFbqW5yi1AGxzV0vFkwGF4I8k2vWRBNvAbHyfwCWuISbhtjzbQQa1KBzZVKx1LD
X-Google-Smtp-Source: AGHT+IG8HDMu/dBffQQYFZIQ8XixOEGsiXfgz39zicgDR+ac6qtsBNYC7P3vQR7esdELtQTbMcLelA==
X-Received: by 2002:ac2:41d7:0:b0:542:2a8b:d56f with SMTP id 2adb3069b0e04-5439c22ca36mr8146588e87.4.1737658713713;
        Thu, 23 Jan 2025 10:58:33 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8368497sm9644e87.151.2025.01.23.10.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 10:58:33 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 4/4] rcu: Use _full() API to debug synchronize_rcu()
Date: Thu, 23 Jan 2025 19:58:28 +0100
Message-Id: <20250123185828.460836-4-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250123185828.460836-1-urezki@gmail.com>
References: <20250123185828.460836-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch for using of get_state_synchronize_rcu_full() and
poll_state_synchronize_rcu_full() pair for debug a normal
synchronize_rcu() call.

Just using "not" full APIs to identify if a grace period
is passed or not might lead to a false kernel splat.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate_wait.h | 4 ++++
 kernel/rcu/tree.c             | 8 +++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index f9bed3d3f78d..a16fc2a9a7d7 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -16,6 +16,10 @@
 struct rcu_synchronize {
 	struct rcu_head head;
 	struct completion completion;
+#ifdef CONFIG_PROVE_RCU
+	/* This is for testing. */
+	struct rcu_gp_oldstate oldstate;
+#endif
 };
 void wakeme_after_rcu(struct rcu_head *head);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2795d6b5109c..0ae90089ef09 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1612,12 +1612,10 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 {
 	struct rcu_synchronize *rs = container_of(
 		(struct rcu_head *) node, struct rcu_synchronize, head);
-	unsigned long oldstate = (unsigned long) rs->head.func;
 
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
-		!poll_state_synchronize_rcu(oldstate),
-		"A full grace period is not passed yet: %lu",
-		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
+		!poll_state_synchronize_rcu_full(&rs->oldstate),
+		"A full grace period is not passed yet!\n");
 
 	/* Finally. */
 	complete(&rs->completion);
@@ -3214,7 +3212,7 @@ static void synchronize_rcu_normal(void)
 	 * snapshot before adding a request.
 	 */
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
-		rs.head.func = (void *) get_state_synchronize_rcu();
+		get_state_synchronize_rcu_full(&rs.oldstate);
 
 	rcu_sr_normal_add_req(&rs);
 
-- 
2.39.5

