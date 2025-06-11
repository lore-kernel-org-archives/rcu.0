Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A5223DD7;
	Wed, 11 Jun 2025 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664624; cv=none; b=Ljm9ZudOTLNugqI42L83M0u5feRjZMuM1PRrzCMC0NSNL4COlyb7N1Qi7rbjtDrJJItNc/h7T/DZ/BuXMPhM932jOV+af2J4yxsxFeKMze7y3MI2cxc8qR5hw7G98M37u1y67aMA3F+jtSZbn7vwrYBVYrTHILR0HS6GdMcUPM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664624; c=relaxed/simple;
	bh=iKPTna4nKkfa8XyeeaeDDDGGxssnxNMy5Hly+3Y9s3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D8wZgx/4I0aB8j7cwIAmBynPa0Lr/NVV33stavzQLfC4GTvRBeCQJuIfOS3686NWz6tfUyhZZ4gXkMVyCMcnIwkzDa4KvHi9dwjPDxyevhnRgNQQn0OXdUXdpxnbV4+oy8+JeOeajqp8zRXd8h+ba8rLDZ4z1DEXpbgNwiInyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfVLEJGu; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfVLEJGu"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5536b9be607so36968e87.0;
        Wed, 11 Jun 2025 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749664621; x=1750269421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ptaNBN0vV7LvzsN1JdzUNyN5uGL6NSic8/J0BeQprnQ=;
        b=FfVLEJGuwNgyjhkGonq2dxn4FWYT/8fhl47/ZCrJ+7HxMOV1KTGLulNzIX5hFKw5Dc
         uU6nWpKOM50Qa16LWj8E8CeuMObnHjr6s7at0NFvIk54GMARL1gibATxAycHNPcU64+a
         g+M3jzOVwydsJddcu47+yahQyJ/634JrmFCMPSb455IMrnSH1sSDxyLKad/8ETjeLm6v
         Y/DdtKIpzPH3+ahNDDHqgQc8TWwlH/CeKb0bZRmrvjgHdAZ60LzrmPXKo3yqs9SYd6+2
         D3cQyGKZubuSiauZ5aiAV9CNOVqJaFXVk2Z6zPLRqFdiz+ne2PAlNVeu0Ao3a+a0yPq6
         +wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749664621; x=1750269421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptaNBN0vV7LvzsN1JdzUNyN5uGL6NSic8/J0BeQprnQ=;
        b=aCjsGIzNML9KowSotywQFwhxAdSEMiSfS4u6F3934wrIv4Ka65cgD+jux9wbiQtZkl
         odLU/UiSS9dOriOQdN/+XnkmkqmxzqYywd1ATsDt3CRjYySUKSqIJWt1MGes4ZoRlI1V
         D0RC+8KCdGP2COSGpdzN8imbnzTGsdqGjlUDhfEiP3U5qOH44ygaUd2lyVkiZIAm0UU4
         n1i+iEH9J+LQ4josqFEDI3ns3TMiZ21WCamE7Tkqn8uj0QjVIcsqbPOuLU4kXY/WW1Ku
         SDZJkdGimFmWHUNZWqukooXxa+ei2aPk/HUGJstaHMPF3J/4lgAfM9gmlfgQ8OK1jgMS
         hHhg==
X-Forwarded-Encrypted: i=1; AJvYcCVCjulknUS2lYW4522pV2A6KMq2yKRYOJl+//r3M6DIU6gsJRJVSHCYUEjLFJL27SxJl69H@vger.kernel.org, AJvYcCWQGFnWRw49xqbv6Mgw2zb3ZSG9Avat6l6CCmH5Am9DXT+2XigrpGUP4grRefnm7KNy4VfE6mKmhRyXkfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4/Crr9KWGysTtrV8EY9avPz1VM/YthPRzrZUcB5fh5npFItY
	BRj6J7wZgRAuhOcb+7G1mEK0oNAUG3J4da+VCKRCD9RFuyZX2tRKqaeq52t0WODZ
X-Gm-Gg: ASbGncu+SIPv7JDnl3HO5/UXr97Wq2dIgr8A47YvBQwVIKLtAGjoT4ckWo/mBqdY9W1
	/1vjC0KGnyIW911Rhb7vYsUTnZVxWgLQMkRL5/oLp9SdXv8eskRbwxMx+O+94Z9HFBmI1smd2xr
	z5uiNQnb+RgM/cV+3i2lTNoJYibcJVnqDJeM+RfwnaT68CuAHKOfygiBbJnbUPeLQfnufVujmWZ
	wTLMN719PuZGzAoLBy9h/nHmawQfAaodQgJGubjbkxPFN7HmNuaARN8y91m5SJlT6B6U9DoHUPU
	v6zCrEMufAkrR4RvXFZzQ6nzoFT8lIJCjV1c54YSYn+e6U/VQqqF1AeKaiPw4E9CdkUm
X-Google-Smtp-Source: AGHT+IE2zotykWid212DM/+eqjD9o7gy/Nqq1aeZIL17mTjbMqJ076cAsgdzsEyQbZVZMTihPc+Pmw==
X-Received: by 2002:a05:6512:2304:b0:553:2c93:6140 with SMTP id 2adb3069b0e04-5539c0a047dmr1430683e87.9.1749664620436;
        Wed, 11 Jun 2025 10:57:00 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5536772a899sm2003603e87.170.2025.06.11.10.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:56:59 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2 1/2] rcu: Enable rcu_normal_wake_from_gp on small systems
Date: Wed, 11 Jun 2025 19:56:57 +0200
Message-Id: <20250611175658.91361-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Automatically enable the rcu_normal_wake_from_gp parameter on
systems with a small number of CPUs. The activation threshold
is set to 16 CPUs.

This helps to reduce a latency of normal synchronize_rcu() API
by waking up GP-waiters earlier and decoupling synchronize_rcu()
callers from regular callback handling.

A benchmark running 64 parallel jobs(system with 64 CPUs) invoking
synchronize_rcu() demonstrates a notable latency reduction with the
setting enabled.

Latency distribution (microseconds):

<default>
 0      - 9999   : 1
 10000  - 19999  : 4
 20000  - 29999  : 399
 30000  - 39999  : 3197
 40000  - 49999  : 10428
 50000  - 59999  : 17363
 60000  - 69999  : 15529
 70000  - 79999  : 9287
 80000  - 89999  : 4249
 90000  - 99999  : 1915
 100000 - 109999 : 922
 110000 - 119999 : 390
 120000 - 129999 : 187
 ...
<default>

<rcu_normal_wake_from_gp>
 0      - 9999  : 1
 10000  - 19999 : 234
 20000  - 29999 : 6678
 30000  - 39999 : 33463
 40000  - 49999 : 20669
 50000  - 59999 : 2766
 60000  - 69999 : 183
 ...
<rcu_normal_wake_from_gp>

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e8a4b720d7d2..b88ceb35cebd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1625,8 +1625,10 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
 	atomic_set_release(&sr_wn->inuse, 0);
 }
 
-/* Disabled by default. */
-static int rcu_normal_wake_from_gp;
+/* Enable rcu_normal_wake_from_gp automatically on small systems. */
+#define WAKE_FROM_GP_CPU_THRESHOLD 16
+
+static int rcu_normal_wake_from_gp = -1;
 module_param(rcu_normal_wake_from_gp, int, 0644);
 static struct workqueue_struct *sync_wq;
 
@@ -3239,7 +3241,7 @@ static void synchronize_rcu_normal(void)
 
 	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
 
-	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
+	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
 		wait_rcu_gp(call_rcu_hurry);
 		goto trace_complete_out;
 	}
@@ -4843,6 +4845,12 @@ void __init rcu_init(void)
 	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!sync_wq);
 
+	/* Respect if explicitly disabled via a boot parameter. */
+	if (rcu_normal_wake_from_gp < 0) {
+		if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
+			rcu_normal_wake_from_gp = 1;
+	}
+
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
 	if (qovld < 0)
-- 
2.39.5

