Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275515ECE1;
	Tue,  7 May 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074562; cv=none; b=b28z+RRz/b1G+vjkWpZoiiHCRYkQ9RX2ZQDsRfzJHAMs8HpUvMpan9nm9MiETjd5S49TA+H9Aju4i0yeym0Lkxn6qwhCZXOchU44QhD+6rX59dMIh/os97X0bL/qdKC1FfzGU7LWk59Jm1FCakY/WQ9f8kVHnzJDd/9CFzjKFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074562; c=relaxed/simple;
	bh=frqB9JdZ2wKj2UZVAquGEnh6KcOwmldyv4Qg+7qDgQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qD5KXEpjXSYHU7bJ6keUKHL+9z7snzbYdGxPjUz1li1OoQO0iyzVufeY9ZOwBw/mnOvIjn1+CIbuyNGO3xTlw4jp4PR0bBlpCTkZs/vyxyAaTxPuOnCtAdSv6WKZlvZcPdhKGATjL9SsJAmQa3TTRujv84ses5bd0/ZbNtXVXRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUd2qyDf; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUd2qyDf"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e3e1ad0b19so8252491fa.0;
        Tue, 07 May 2024 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074557; x=1715679357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wXXp0y3/5Dvry2xeNwt9T3OFvkk1THegZM211jibMU=;
        b=hUd2qyDf6Yd1OstOLXOUSm+9GB/qqI0Al6aDbMSm1KhuTERcul3i963bSnedE5uLgL
         /1iRMMxpewRnn4ixryBfU2g8OmaW0hPdX0qE7fnDZlV7wuTYuI7YHqsKvF5BZxcML3Uf
         S7IMa0b3voxbtVdB7znU16IFn28j0dYKxpY8IS5wGlcMmQgLWRYlrB8YQ5/xTUdnkXvt
         sJjX4IKN5VcsAuWjknC8UORWyslbQxRPdY0s2Izx99CdoIhlEeKkrAI5Hzi9Y8RYFmSm
         8nTkb8BK+ykrw7FWFUTpip8y7Ty84xHpKfa/10VyZ4h8w4aSAotMso+jXD5HbZ8ga6Uo
         A/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074557; x=1715679357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wXXp0y3/5Dvry2xeNwt9T3OFvkk1THegZM211jibMU=;
        b=odZRZSQkF4I+8yl/h/lFCqp3C36ZZdZnR6U9XhOYCtmfoJMFalz8+GOivFCH94ADZ0
         RS3joLdLry2b5ykT2Zg51ALtDiOa9GfHxBZb89A+oijzzmWHBKw6ZfgfsLDPpcqRb3NL
         IJ0+I+tYbrLjNFjak9XN0lIwVZFiYbVKVfwEwILBYv7UwrIyHHFT6gvo4QqqX11AaMvT
         28fphWnvyNV66OpFUoalkcN8b7cRyWW2t3w2WlokzVC8JXeVJ59GU8QkyVjVNSeX3RUA
         /0xhSAya5Faf9wG9uZ5bVNHk7LKUeMeWMS+1N+PtvHmqqRZgow5ouZuK5+zzSpPML1e2
         mp5g==
X-Forwarded-Encrypted: i=1; AJvYcCWeWiEvCDO1WT8AP2LNV8ClcyXUPJ0n4bRKn+J2gew67nGI/yeFqPrGrfIi00shRFyDMLa7Dd52i6Kg5s/bpHcs/cq4qVLIjMJJhnv6
X-Gm-Message-State: AOJu0YxX6DBsgGopjv8vpDhM6iP5hTDg3Th0Lb5KBCAKGddPBb2G6B3A
	rnuRNacelCOshWJg95pZBN5zHTwBUtzz7SPFd5cDBDKFM0ciDcw2
X-Google-Smtp-Source: AGHT+IGrg8/gY8t0r/95q18a1/2aEvenTXHbcwBbeF3Em7DTV1B7pZ46ANDu9JWC/D6UZVRXaIA73g==
X-Received: by 2002:a2e:2e0b:0:b0:2e2:3dac:447b with SMTP id u11-20020a2e2e0b000000b002e23dac447bmr9471424lju.18.1715074556582;
        Tue, 07 May 2024 02:35:56 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:56 -0700 (PDT)
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
	Frederic Weisbecker <frederic@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
Date: Tue,  7 May 2024 11:35:07 +0200
Message-Id: <20240507093530.3043-26-urezki@gmail.com>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_sync structure's ->gp_count field is updated under the protection
of ->rss_lock, but read locklessly, and KCSAN noted the data race.
This commit therefore uses WRITE_ONCE() to do this update to clearly
document its racy nature.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/sync.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 86df878a2fee..6c2bd9001adc 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -122,7 +122,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
 		 * we are called at early boot time but this shouldn't happen.
 		 */
 	}
-	rsp->gp_count++;
+	WRITE_ONCE(rsp->gp_count, rsp->gp_count + 1);
 	spin_unlock_irq(&rsp->rss_lock);
 
 	if (gp_state == GP_IDLE) {
@@ -151,11 +151,15 @@ void rcu_sync_enter(struct rcu_sync *rsp)
  */
 void rcu_sync_exit(struct rcu_sync *rsp)
 {
+	int gpc;
+
 	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
 	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
 
 	spin_lock_irq(&rsp->rss_lock);
-	if (!--rsp->gp_count) {
+	gpc = rsp->gp_count - 1;
+	WRITE_ONCE(rsp->gp_count, gpc);
+	if (!gpc) {
 		if (rsp->gp_state == GP_PASSED) {
 			WRITE_ONCE(rsp->gp_state, GP_EXIT);
 			rcu_sync_call(rsp);
-- 
2.39.2

