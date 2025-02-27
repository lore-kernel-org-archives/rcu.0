Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6222F38E;
	Thu, 27 Feb 2025 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662181; cv=none; b=sggsuC6IxqjDg2B4/crJvXETWmrRZmmTHsjz2T4nEPobBWUP3vS1yU8T3x9htgmkQpixTl8iYLEMe1TjTVpzGFxaWW30+nLjYDSmb+2AFXxV1aHC9ZdB/VoDKLxlG2FDtH0zP452fG1dNICFrBqmPKW4x5WET4h7AlZQT/iST50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662181; c=relaxed/simple;
	bh=bYUZ+mFYgQy3fmEZhoYJu6Kf0gd8Eq8OYrkuc81YJ4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fDx3tEqn7VoT5v/tq//mFQtfhlCDm9wUpqO5kBJbLY7ytIxBN34DSlNwk7gefdvTqLjCoYu3ZhEjfereAJJzOmBWa08Q77EaKKMewUCfYwj3RuhU0sH2hxkVpWYoIIyNUHth2XvuKFM4ILn/fOcIu8IALM9YvdFJ7tMGm3bMcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KojPpKf3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KojPpKf3"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-546267ed92fso919865e87.2;
        Thu, 27 Feb 2025 05:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740662178; x=1741266978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RTsy7+StkyF/uZICr0cKjY+TqTfaQpfCUKBRMx4ff0=;
        b=KojPpKf3wdhe0z9S0/NFI/Qu3NCoqr4NgkfO/A2VKW9Q3XkbFUpGfe41LMq4jxNQZ4
         JvjOmGfE7voEmu64Yg7yvBTGJPZ6S7sxtLMGzkTrl6vebUTyFTIno8XDGq5GLhl/Y4u7
         eMPVpRtPGtU0IttEAO2oE1oMX87hffJZ6Xzg56D2E69lvzZ8rf5SsVOgvH5td5bGxvFq
         GkGBlA5HaE6sV3W28AVyeHKW/icY11A7bnEiSjbd2u7HP86VwYzj5whmtU/1QD9I1rYx
         e/rgj2u9CteYivR0pmCEfWCoh8rOTGGN7l/Yva0Q7oRaZKZ2zRlAEEOmPlGPMT2IM7un
         S8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662178; x=1741266978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RTsy7+StkyF/uZICr0cKjY+TqTfaQpfCUKBRMx4ff0=;
        b=TXihGsWEyXKH1H5m82aCZjEeN2DqPc+jWP4g2nsQsqWlahrvzwUP9srS4eVUDC92JT
         8rLgyLU24NViBEwUX2SGMs2vSFfRRg8Cb92U7PqO9nyUeWNN5gzWi7MHbfFPmpe6uVWS
         GYlzIfax5RF08K+48FxHPcFLxQJdIZq/RWGAZd69rHIIGvUZOaNiyJ4l1edF3J2qMWhq
         ADKX9IOz8HZFDwCWYiC4RK1wG3B5IJTmEeXTfvUith7JFKkSXYmB8JEAWsgaU08yvjIM
         Pg8RsFmQl3Om2c9z9or3kvl/HFDG31KrEj+AO4gI4LTzrrknkPRkY+TQXuOp8oEEi/Z5
         obCw==
X-Forwarded-Encrypted: i=1; AJvYcCX5F2hYUvM78KNJv8fvpFnIn9qqkOvIvUIBNQMV71Z/pRxHI5Q7QMRLjvZMBkm/lBz4OhKL+Gy0wqAvFr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcLNOxg/5ioVTpZ6wgV0zJS7dUTHsJSEPdgwlvm55QR1Ywi0Dv
	HQkc7tSr/kdDFpStg+h83pMh/mKSpqMrehdNy/n2Vj8RyW56V7Yg
X-Gm-Gg: ASbGnctb/oOcOJBBhYTnasoFwFOw0NOOsXvlgNP+54/ObbZv+RrHWf4U8ure7azwv7x
	TaGg+cdwlgSe/311QZTDIZuUBz3m/1kPNb3ejt4BmsooqJcNM3WOB/ZTKBAClA2mS913mr1o5mV
	sUtjZkq9D+9K3mdx15FFhnpECfVTU1TNpEPNNU0wzF8KdjJO+votFu0K5QJSZ2WR3ArNhN0ZhxA
	E6ka2ORrfXihi892eFAIt7kznxjIEfb56vOV8TghPnzqTURiCq8bXuiv3iIoepW2UQiSWjL1/dA
	GDATDPzrl3B4Iz1Qf1obrA==
X-Google-Smtp-Source: AGHT+IFR9Hk30gIJ7yteYrIHtrcQYiEdSi1movsTxUujeeNXz5xGprrz0YptnKOLbXdsoX2pYNP1lQ==
X-Received: by 2002:ac2:4e07:0:b0:545:a2a:589 with SMTP id 2adb3069b0e04-548510ed8e7mr6796685e87.52.1740662177923;
        Thu, 27 Feb 2025 05:16:17 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54944174505sm157011e87.37.2025.02.27.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:16:16 -0800 (PST)
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
Subject: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Date: Thu, 27 Feb 2025 14:16:13 +0100
Message-Id: <20250227131613.52683-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227131613.52683-1-urezki@gmail.com>
References: <20250227131613.52683-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch for using of get_state_synchronize_rcu_full() and
poll_state_synchronize_rcu_full() pair to debug a normal
synchronize_rcu() call.

Just using "not" full APIs to identify if a grace period is
passed or not might lead to a false-positive kernel splat.

It can happen, because get_state_synchronize_rcu() compresses
both normal and expedited states into one single unsigned long
value, so a poll_state_synchronize_rcu() can miss GP-completion
when synchronize_rcu()/synchronize_rcu_expedited() concurrently
run.

To address this, switch to poll_state_synchronize_rcu_full() and
get_state_synchronize_rcu_full() APIs, which use separate variables
for expedited and normal states.

Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
Reported-by: cheung wall <zzqq0103.hey@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate_wait.h | 3 +++
 kernel/rcu/tree.c             | 8 +++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index f9bed3d3f78d..4c92d4291cce 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -16,6 +16,9 @@
 struct rcu_synchronize {
 	struct rcu_head head;
 	struct completion completion;
+
+	/* This is for debugging. */
+	struct rcu_gp_oldstate oldstate;
 };
 void wakeme_after_rcu(struct rcu_head *head);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8625f616c65a..48384fa2eaeb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1632,12 +1632,10 @@ static void rcu_sr_normal_complete(struct llist_node *node)
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
@@ -3247,7 +3245,7 @@ static void synchronize_rcu_normal(void)
 	 * snapshot before adding a request.
 	 */
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
-		rs.head.func = (void *) get_state_synchronize_rcu();
+		get_state_synchronize_rcu_full(&rs.oldstate);
 
 	rcu_sr_normal_add_req(&rs);
 
-- 
2.39.5

