Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641D42D0C67;
	Wed,  2 Jul 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468387; cv=none; b=FFFf8FSmUS84l6c+XbqsKfZrZsdagfgfjO5J+lrC6YphfkBZLHPEehXphGWa75xUJ2e1h8YEQo0aaXPBTx7aP4o4r4u+ptifwntE2290E1PkxRwi30ajMfbJhS11Lui+GQFb/gICFDQ7Jj5mI7oxKMKDawQYlirNFAsDjWuxoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468387; c=relaxed/simple;
	bh=fs0CjMey3bO82t/QWIEcxcaffE8u3Amxc93FWTHJHOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uW51kZugvzS6OJ9Cu/yt5mucZ7+ot8JAR1GIt4+j0qnOVRzD3LUojMxVO183iPd5ldoDrYheFp9GFduKRN5EdOd2urLM5nOaO0I8IzApiiL25D52SQW0CS5w7ukmfU3aOfwRgTu2ALruaV5Nyx2ieNr+554UbuHW9neGXtblz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwQ49Yot; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwQ49Yot"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553dceb345eso5489917e87.1;
        Wed, 02 Jul 2025 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751468382; x=1752073182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HIHNyOTsqAfeOMHAWemDKg4C0xGlnmJ0N8JxEgXyV0I=;
        b=jwQ49YotQq3a9rTIGtP/+ZAe8OPh3Cv5rcThVbbc6UsnKyaV4P+ZPXMuzfGS/9lyfw
         9a8DJ45yyHnpqfZOWG5CYTnQVvGyT2S8GbYiwcW182d1p3hPrtygIZo2Cydn9Ozwh1rE
         ENEZCcM4u4pj61UgoC/FQTjw7G7o2ypuv1v9FR5qLNw+8MW5skmimhSSNtgHzKvocYDk
         VcHufJ4FHBvzUMjXaVRRfXL0kCecacnreZoQfphIr2Pnxp2tNIP7veyvFGyLbU92dWDa
         kiLFIVpC8/p1jvodHP2LXQQJmyeRq5LPex8RxAMt0tTidFkGmLgcbzsfsK9GPx7dHg79
         /54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468382; x=1752073182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIHNyOTsqAfeOMHAWemDKg4C0xGlnmJ0N8JxEgXyV0I=;
        b=aHo2oTemH7X8rKv+Rg0wwHKzKZk35yCraVPi65gqdzx9jvUvMfvagg9fyNbHVsaXIF
         gOurJi917cSVSKGPhy4GVa24xYdBgVkysEYD8otMwd7VxZt91W/txOlN6JvX+rk32Sqi
         iXe6dCVQKywojhmR4zQiZtD+fyUrp0akYutikSkqv8JdqTC1qPrgiMc/MhrF/UawhNKv
         va8Zifq/dUQmFqhJej0bYnl2VWfXJLCb2+l/acyGZH1SfrMuqLp1tJ9iYoDPMi6mbe9y
         eeWcO73JkeXQmXMW7AiTgFzo4L8MRxeRBQlZ8xZNRdunZsQG6trVMlRYnQLjZcuMFBmM
         QaYg==
X-Forwarded-Encrypted: i=1; AJvYcCUiRNWpUTYDzKFVyzay0L+HnPez8wr4SD5PkQMjUWb3MTOhwQEY/CBJxbQQbTQY9SYRNBU603HaZ/h7Ur4=@vger.kernel.org, AJvYcCX3LTXDtWp0UacLNyO0zjLJSiz3I/QWt79pog8um2lKblIk0yQBtTujnRZqD1XE1UfW9JxI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyazl2mkIdGzvDiuguKgwH6OSqWTyVzJelr9QNpCqV2PoUdqeFm
	XfSoFCVxbizaM9siAJeNSwF+A8dhpqnSd3C8af8khhPijIuvo6gOZCKA
X-Gm-Gg: ASbGncv/ndjIEsgdYwCxNqr2oDl2I/il2eCXUWy63ad8bVSKFYDVm/Rw674T08cCUPq
	JKq6yWXDR33iNTl0bUvn0HTFRUVkLuf7dZpfiyRWdtzyuPqQAz1aX7QfMV59dKYHpOmm1E2PzuG
	5VegOcxvBwFrwo70SjOAq9bhriAtlTRAOJrJ0R4atXdHDjpp7nNTLpxD07g2FH3ISYOPYTPtUJq
	os6SF104oa1pbQNhsBiQj85GEepopJA22RBaBRHPAw4UQW2Gc1GE+hdqbvzZ1isYNE4OSMFJq+9
	bYtg66dj/1re4jOTW5Od6mPknhyzxttIVk2qljGZUH/WU1dSWQ89VXmD/g==
X-Google-Smtp-Source: AGHT+IFABYnSIbMhTZdwm6kglZiidnRRkfk7mI5btiZ201N3xFV670NENb350xQ2zky6CNXsrPC7lg==
X-Received: by 2002:a05:6512:1307:b0:553:2375:c6ea with SMTP id 2adb3069b0e04-556283c7090mr1439638e87.50.1751468382064;
        Wed, 02 Jul 2025 07:59:42 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b24010esm2166907e87.50.2025.07.02.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 07:59:41 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v3 1/2] rcu: Enable rcu_normal_wake_from_gp on small systems
Date: Wed,  2 Jul 2025 16:59:36 +0200
Message-Id: <20250702145938.66459-1-urezki@gmail.com>
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

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
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

