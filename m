Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6315099C;
	Tue,  7 May 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074542; cv=none; b=RITgbmejqn39EEeXFRKP7fQkORwI5DJcGuVomJSz0OcI3Z6Vfa5jTt7kK1StyB8sHMhxSwxUr1M8QWEUJIyiUta0ZrNa4jyxmkVjaCbDN74Y1QesnEeSf43FshjH8PP1xtT7Hdq5Sk2TmvlBckA18bOV7jH0DsD6bTTJfGLzQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074542; c=relaxed/simple;
	bh=EPTqQr2FdmneGl4AimQETF40urKH1/71YF21d/iWyVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IysrOLjQEWs5w9QTpBFuvzhj7RP5w19sLliQ7OZz3Qust52KvKmcEcQV0AeRhs3ucgFwBqZb5EvBVjROiVwPbQzedmwWL1asKRYGPH8Aa1lHcNdOQMfM9qNhVaMLnDn9zqZm9HMDcj0YVdm50Uts9SaU8mbOR7WjmJIM12Tj2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHIizMS1; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHIizMS1"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e34e85ebf4so16678401fa.2;
        Tue, 07 May 2024 02:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074539; x=1715679339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeytRa7j93+R3e0SRP+HJTXGjEr2JuSSGpTGmEKlzUY=;
        b=CHIizMS1fK3R0JnFJ9FYfXfKmGxtdFZUhbrWYLrDdMFEMjxj1Z9dkwsCGcrEeERjNz
         2QCYQPMtS0UTouHLNAJqxtyOaX7N4dgkz7eA254DkBvWlcltTNFRRU3XOt5pgTJjqAn+
         eBF29sVxXgvl63OySGLJMu0hfY0tVRQF7mNp3dxyvrvU9gNZ8/rTyNkmkm+LEe+VDw6l
         Ehh0v2CfbmX+DZgHke2xwAWvCG0VTODEKjBwA61g4LTDhPYljWzs7NqBHFFgBOBkBXU9
         3pRxe0MT9l/s03qFVUu5wI7cAcvTGYlfbPTzc50uZvomYfhyHgqeEpZrBDCWS6UB2VZ1
         77Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074539; x=1715679339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeytRa7j93+R3e0SRP+HJTXGjEr2JuSSGpTGmEKlzUY=;
        b=lz5FJtQJOXRqjuFens8Gf12dT1Sns92E+CbrL3v8jgrfLQ0Q89P/WhtL7Afas4Yq/Z
         utIgHA0tk64Cd9Evm2oIjwTvAzxtZC7J9lfq6b8Y6A+HUetVJsFbj0V4WJsdv/6CCvIl
         JMsbBnUXBsKr/u8A2Z6TXUG9DsBkcp2Bj7aIojxU0g+hj5IUEjunFpvx6OoYuruqGOeP
         gCxiZJF4LLKI8lPjAFW/Dm8sdnft4VXJIkS3sLRT4rPx1JhEFX0USFJUcRMN9kboN77y
         iPoEqTxuhvgn2k+eASG7dbIpj16TmTp0TfCqQItYcDBoqjz7giVGOUpQbO6gpvoTDfhM
         qVYg==
X-Forwarded-Encrypted: i=1; AJvYcCXLFXxsn96RcMy8sq+DpGbf4vyZnDkXtDp6RnOzf9C66MRopmycO+Uu2bT46ItKSwXVH4g5U6UR4XHeo+f//KP9BDKqMt4Ry+rcHdLg
X-Gm-Message-State: AOJu0YxeOjz+RfeMdxgi/G+ObKUZJfYsa82X8rHQrHXPHD+K0G19HKpr
	k1+xnLRDBGt99q9GOqWfQExB86uzLeNAeIxMqKys3NBJ+PoN+F8n
X-Google-Smtp-Source: AGHT+IEWdV6/qAUYuncG7ZVsClM1CU+/ZyzcnOioJaa2iCWDjpsSvmMFljWZHYV748y60anlcnt3YQ==
X-Received: by 2002:a05:651c:20b:b0:2df:8bef:d900 with SMTP id y11-20020a05651c020b00b002df8befd900mr7026832ljn.16.1715074538723;
        Tue, 07 May 2024 02:35:38 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:38 -0700 (PDT)
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
Subject: [PATCH 06/48] rcutorture: Dump GP kthread state on insufficient cb-flood laundering
Date: Tue,  7 May 2024 11:34:48 +0200
Message-Id: <20240507093530.3043-7-urezki@gmail.com>
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

If a callback flood prevents grace period from completing, rcutorture
does a WARN_ON().  Avoiding this WARN_ON() currently requires that at
least three grace periods elapse during an eight-second callback-flood
interval.  Unfortunately, the current debug information does not include
anything about the grace-period state.  This commit therefore adds a
call to cur_ops->gp_kthread_dbg(), if this function pointer is non-NULL.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6611ef3e71c3..eff51a26216f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2832,7 +2832,8 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 
 	if (!torture_must_stop() && !READ_ONCE(rcu_fwd_emergency_stop) &&
 	    !shutdown_time_arrived()) {
-		WARN_ON(n_max_gps < MIN_FWD_CBS_LAUNDERED);
+		if (WARN_ON(n_max_gps < MIN_FWD_CBS_LAUNDERED) && cur_ops->gp_kthread_dbg)
+			cur_ops->gp_kthread_dbg();
 		pr_alert("%s Duration %lu barrier: %lu pending %ld n_launders: %ld n_launders_sa: %ld n_max_gps: %ld n_max_cbs: %ld cver %ld gps %ld #online %u\n",
 			 __func__,
 			 stoppedat - rfp->rcu_fwd_startat, jiffies - stoppedat,
-- 
2.39.2

