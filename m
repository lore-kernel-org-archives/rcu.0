Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD615FA82;
	Tue,  7 May 2024 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074577; cv=none; b=Rh/fZScds+IGSArgM9FZFgOH5IwUHYVy2E9glNo+eDTPmYudSs01TjCNVmlB/F+t84BKR2DILNZVIlzyaJqaYoJOfJYvdcEQ9Aoirgg89mjQRvZufWP6FCfNGLqRUz4qIRm2UJZJakJiMiQma94rv4GtL8JQCw7hyyuR8uwGwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074577; c=relaxed/simple;
	bh=QKSqgdzxusUu2mHIh3mAgH0aWgzgQr+xVcxYkLJ9pLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C40F2mBE5XDLohFCFoqrUPQC03vHl3fRGZbptnHTTG/tfRENj029aBxXSB74807+3FGSrDrICBdTRBs5UNpCg6CvXs3cHq9Ob5H16B/d9iHylihuo8oMoE7he3OpbJaK5465uK6UtfEFGw/CqmyGfpDttIQZDSPBBXrNN2dsspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEH12vyn; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEH12vyn"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2df848f9325so34230421fa.1;
        Tue, 07 May 2024 02:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074570; x=1715679370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMiIpeM1d8lFeOaPEE+VPZ7k+2yYPj98QEqarfz20oU=;
        b=QEH12vynqZPLxg6EMqXvkYhrKvN5tud8VrEukfJBisF8RfKVrrk/QNOTrq5kMp0tY0
         wNWvApK9INPloEPdLkTIuSFa8ldVAE9onHoQwDfuWqgYV+YmqB4tw7cylBjk18CrV7e1
         u0M0vB5IMfBUecT77hediettyrmYy/EyCmOwEEBF+AovM2YXThJQnYp1S/1LduE3wnOD
         koblzXyJT2lGS89iSt9cu+nLteUvvkzrvp3n3RZ3JRTgvs8bHHNBLYSQfH/LZhyd3deT
         CsLjTZn6/BEGHfzm4p+tWVC+rwJMmAjg/Ak0tWQ2Q+EA8Xs1pRs1ex3rBKyHOrXeUwBs
         Lv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074570; x=1715679370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMiIpeM1d8lFeOaPEE+VPZ7k+2yYPj98QEqarfz20oU=;
        b=gks9z8R8BhsVxVUdi/sdIr9Pcjka/naISdMOSOME0T0bBlIjvUQ90gqVC99ZUnWpHP
         BQWGJ6fq7/4pmvwCvHh2QKK+r4zENlql83VxXSF0hj1V77XnQeb1EZ/m2OVR1GTEC92B
         Y22JnVGIyruakadxIZgOQBCMNZFS8tPX+3OS/5ywMxOmbn2HxygD4tOvsk4o1FsQN44P
         c7T3IPeXvWwx30rfHV7W8WS6qKxjtqAnzGrsFy3N1aqs5TY4GFEhLX/cv9QY7qZSmoDQ
         M3ZF/E4gDDcCir6LBMYFJ8UPJSZiSeA4GJBdUXl+ObCgcghBUnNoHEr4A6olBMEIRcO8
         6gOA==
X-Forwarded-Encrypted: i=1; AJvYcCWVi3rSoXbxpfRppSP0JcguXtuo4/9sMlmsvEqlA373WHvUrQpcF7T/bXTX8BDx/0jeaWBbc2st5alaropt/jszb23WL+c5LVRmS46Y
X-Gm-Message-State: AOJu0Yzr2yxE5nmw3vyAVch6MfPxmNTsgByCoB13u/NdUixkSWR5Qi0I
	LHai7p6KYM9RIuD/jCH+9hQImmJmqpr/MtZoDTgpcZ/9oELPh0w1
X-Google-Smtp-Source: AGHT+IFTSPnMqNJuabynMCKLpS20u3n4+Lw184hqoe3LFtLJl+j8mMtkSJH2spEebBcJhJkTG6mi8Q==
X-Received: by 2002:a2e:b173:0:b0:2da:49cc:ef3f with SMTP id a19-20020a2eb173000000b002da49ccef3fmr7916188ljm.42.1715074570392;
        Tue, 07 May 2024 02:36:10 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:10 -0700 (PDT)
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
Subject: [PATCH 38/48] rcu: Allocate WQ with WQ_MEM_RECLAIM bit set
Date: Tue,  7 May 2024 11:35:20 +0200
Message-Id: <20240507093530.3043-39-urezki@gmail.com>
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

synchronize_rcu() users have to be processed regardless
of memory pressure so our private WQ needs to have at least
one execution context what WQ_MEM_RECLAIM flag guarantees.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2a270abade4d..1d5c000e5c7a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1582,6 +1582,7 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
 /* Disabled by default. */
 static int rcu_normal_wake_from_gp;
 module_param(rcu_normal_wake_from_gp, int, 0644);
+static struct workqueue_struct *sync_wq;
 
 static void rcu_sr_normal_complete(struct llist_node *node)
 {
@@ -1680,7 +1681,7 @@ static void rcu_sr_normal_gp_cleanup(void)
 	 * of outstanding users(if still left) and releasing wait-heads
 	 * added by rcu_sr_normal_gp_init() call.
 	 */
-	schedule_work(&rcu_state.srs_cleanup_work);
+	queue_work(sync_wq, &rcu_state.srs_cleanup_work);
 }
 
 /*
@@ -5585,6 +5586,9 @@ void __init rcu_init(void)
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_gp_wq);
 
+	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
+	WARN_ON(!sync_wq);
+
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
 	if (qovld < 0)
-- 
2.39.2

