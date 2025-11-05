Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39334CFDC;
	Wed,  5 Nov 2025 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374742; cv=none; b=IEO4XDWsd8acGIPB41SGm9V7x9KzQaiafpF9gK5Zf97w6jdh+L03t8LvLBo/5oLsd/Bt7CwTjxnuBzFO6n33wNUY+vUneXLZy4cinI3SYuZqxTSl2/PB7wHNtLH4lj0VAMq1BtP0hBqfX7w+G3OQKjmZslayXb1D20XgSZxs5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374742; c=relaxed/simple;
	bh=aJyIfG6g9+3VDV5coLmO7dbxbwXJBSKpYVjzcCHpIds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fzLEoFOMbecjSm+eV9diXkuattIGxdb+32UkcI9dhjUXKEpORUZE+HdZA+25HYb+Hdy9kfPSAng/aMZBUWAVOw0PKm0RKNz+HuzWfCOQDKkobox/c6a9fX26ZDduOVjWU3RkxAvukHQ3o28utBD92SFMgMLpkm6AxsdI1ZZE2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2bZSqg6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2bZSqg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EC2C19421;
	Wed,  5 Nov 2025 20:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374741;
	bh=aJyIfG6g9+3VDV5coLmO7dbxbwXJBSKpYVjzcCHpIds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2bZSqg6l9PPM5qYpntafEwkVG4YOoE+G410qYshznWVMhYd2xKmxOqDJ3IvVF5nd
	 bno1xlTnI1yGqkKdeV+M++pHH9/KrALffQNRjmXFGpkG2UNFvIMU+QVi1YScTuMvxy
	 fj1Egd8MJq8GY8NzAp65ByzFF8ADdy9R7kjFbwTmi7aZ3L1w7Ovu/nW18GHuFppaSN
	 7xc4WDcLuOZs7GET0LsfAnwPaOeHlkrtBt9RSw4qgNTMTekjb2S3pUWlhJRu0VI/vC
	 rgPOGBM6CkgflQe5xn4x1syEFgqhm5eAkY/dPmI2j030zMyJH7CuD1yOV7eVPZj7Gp
	 dr30vTLRW5MIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ADB1BCE1063; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 16/16] rcutorture: Make srcu{,d}_torture_init() announce the SRCU type
Date: Wed,  5 Nov 2025 12:32:16 -0800
Message-Id: <20251105203216.2701005-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit causes rcutorture's srcu_torture_init() and
srcud_torture_init() functions to announce on the console log
which variant of SRCU is being tortured, for example: "torture:
srcud_torture_init fast SRCU".

[ paulmck: Apply feedback from kernel test robot. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index a52e21634b28..11906c927321 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -701,10 +701,18 @@ static struct rcu_torture_ops srcud_ops;
 static void srcu_torture_init(void)
 {
 	rcu_sync_torture_init();
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+	if (!reader_flavor || (reader_flavor & SRCU_READ_FLAVOR_NORMAL))
+		VERBOSE_TOROUT_STRING("srcu_torture_init normal SRCU");
+	if (reader_flavor & SRCU_READ_FLAVOR_NMI)
+		VERBOSE_TOROUT_STRING("srcu_torture_init NMI-safe SRCU");
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
 		srcu_ctlp = &srcu_ctlf;
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
+		VERBOSE_TOROUT_STRING("srcu_torture_init fast SRCU");
+	}
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN) {
 		srcu_ctlp = &srcu_ctlfud;
+		VERBOSE_TOROUT_STRING("srcu_torture_init fast-up/down SRCU");
+	}
 }
 
 static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
@@ -920,12 +928,21 @@ static struct rcu_torture_ops srcu_ops = {
 static void srcud_torture_init(void)
 {
 	rcu_sync_torture_init();
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
-		WARN_ON(init_srcu_struct_fast_updown(&srcu_ctld));
-	else if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+	if (!reader_flavor || (reader_flavor & SRCU_READ_FLAVOR_NORMAL)) {
+		WARN_ON(init_srcu_struct(&srcu_ctld));
+		VERBOSE_TOROUT_STRING("srcud_torture_init normal SRCU");
+	} else if (reader_flavor & SRCU_READ_FLAVOR_NMI) {
+		WARN_ON(init_srcu_struct(&srcu_ctld));
+		VERBOSE_TOROUT_STRING("srcud_torture_init NMI-safe SRCU");
+	} else if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
 		WARN_ON(init_srcu_struct_fast(&srcu_ctld));
-	else
+		VERBOSE_TOROUT_STRING("srcud_torture_init fast SRCU");
+	} else if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN) {
+		WARN_ON(init_srcu_struct_fast_updown(&srcu_ctld));
+		VERBOSE_TOROUT_STRING("srcud_torture_init fast-up/down SRCU");
+	} else {
 		WARN_ON(init_srcu_struct(&srcu_ctld));
+	}
 	srcu_ctlp = &srcu_ctld;
 }
 
-- 
2.40.1

