Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B3168AEB;
	Tue,  7 May 2024 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074579; cv=none; b=nFwteNHTlnuYxrcGCSGteIUtX1m6Iguftun5HHbGJKkL5JNzBf2y589rtVfCslFmPw0MCjoq4PnW+YBorOALa0t1YaAfsZ81m5uV8CzQgszWlESkOPEi1YxMNaJmHpiv7uQyw4BAcJDv690mpQUd3Foqou4wyaowOGGrI7CJeDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074579; c=relaxed/simple;
	bh=oelWA1yUmfghM3lDepfzYUmSPKLaOwMcYDivNtABeLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WAlcLwp0g27qypHqXoxyt5v3DTm6OaVTp3d92Ivys5cfnmQ9lvSSxtIV6wMx7gGNC1gs/lCUlCTf+1GJ5FfFFljbLzxU/kuAvcD0IwKGt8qLOS5lT4lKm58pcrVpZ2uSyJfSFX86fUqUacYTzGbnbsGmN8dmMBhNk44ttcrErhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fhvw2Mu8; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fhvw2Mu8"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e3e1ad0b19so8257971fa.0;
        Tue, 07 May 2024 02:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074576; x=1715679376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Epu6iZvnUCozfcFQLTzyJDJ7BNw1imFQ/N79IeKES7w=;
        b=Fhvw2Mu8QTcCUwNyBXrGFve3VeJ2K3Q4mcRLMmkaw7UxaMu4qr4jNgro5iPBgcOaIV
         KQsq6NZF5X5BzEQp7xYHxYoHX+sHPuacmUr28gsRhQdutlZ/Dpc/TAC7ump0LTg/fyst
         dlNcILuOgWDVYBOBkbqAqJMCkcE6AvcbhHKEWw7WhNzAwLHa1BNiAgOWN4a4q4QLy/C9
         NZDvipwptgZoc0om8IZw+k98qe5PI7ajQXn93iW/jfdgVkyCyclMdxDVi9HixgX3gden
         zwiKz6w9KTRM9Ki/ncZBa9EFadPAf4eXFK8SZOdXfoLJOjQNyhQ2oOezzZCPFQpv3Eeq
         BaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074576; x=1715679376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Epu6iZvnUCozfcFQLTzyJDJ7BNw1imFQ/N79IeKES7w=;
        b=IgwpeMZ1y9QTbNwMeiQeIRMkPA7RYV1wO9ORVV71qtsTJbiKa6+EFmSaTdRmeCVIV2
         wKsz/vFU8L5MjzJR6vFO0tu/+c+5QHsH4/Sjrn8LcoulHDBciOZFBuAdtjHttwZPPfyN
         7/ZTgaO6SwT4BYQEUFs1eQeMD86xCZI3/sbR4PTFz7rePCtTTsBEfP83tBEVHO7CuBPJ
         OUrDp77ajn7+Y5Sv8EwBYFlRoYAV9o6oBeuwVlT0fG71pnmnRHuNfBCclTqDTTexiDrC
         C+5waKX1e59LsWSPqCeAq+KjD//4Yw+sBMttN9hATvJPUT13+Y3ezvyxZOfKpp2fh71b
         FWmw==
X-Forwarded-Encrypted: i=1; AJvYcCVBiWNP4yHFpWA2n9lFrMEqghP09cAwXJpjcE8aK3Fd/eI6RVDyPCm8Kq5vpdLu1Qm4Pdaguj/ylPXNKCWeMjn2MepgtoMINkhvXsI+
X-Gm-Message-State: AOJu0YzbFJsuq6QdTdi2mPEnIREkh94+mIkHr82jUm/O5O6a6QaT3T8e
	YDpRjlXt7syRtWQSdGFHVvlJaiQbggi8kwS/Q0xMi6a+3ERfSgAn
X-Google-Smtp-Source: AGHT+IHDlh705pfvq4NGiRe19u8W45dtROF2rBhsHOfwyxGouaaLDWrAKOWVrr0T5sHNXGSNEqA3Hg==
X-Received: by 2002:a2e:7204:0:b0:2df:7824:7d32 with SMTP id n4-20020a2e7204000000b002df78247d32mr8358817ljc.50.1715074575658;
        Tue, 07 May 2024 02:36:15 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:15 -0700 (PDT)
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
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 44/48] rcutorture: Removing redundant function pointer initialization
Date: Tue,  7 May 2024 11:35:26 +0200
Message-Id: <20240507093530.3043-45-urezki@gmail.com>
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

From: Zqiang <qiang.zhang1211@gmail.com>

For these rcu_torture_ops structure's objects defined by using static,
if the value of the function pointer in its member is not set, the default
value will be NULL, this commit therefore remove the pre-existing
initialization of function pointers to NULL.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 85ff8a32f75a..3f9c3766f52b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -566,7 +566,6 @@ static struct rcu_torture_ops rcu_ops = {
 	.call			= call_rcu_hurry,
 	.cb_barrier		= rcu_barrier,
 	.fqs			= rcu_force_quiescent_state,
-	.stats			= NULL,
 	.gp_kthread_dbg		= show_rcu_gp_kthreads,
 	.check_boost_failed	= rcu_check_boost_fail,
 	.stall_dur		= rcu_jiffies_till_stall_check,
@@ -614,9 +613,6 @@ static struct rcu_torture_ops rcu_busted_ops = {
 	.sync		= synchronize_rcu_busted,
 	.exp_sync	= synchronize_rcu_busted,
 	.call		= call_rcu_busted,
-	.cb_barrier	= NULL,
-	.fqs		= NULL,
-	.stats		= NULL,
 	.irq_capable	= 1,
 	.name		= "busted"
 };
@@ -847,8 +843,6 @@ static struct rcu_torture_ops trivial_ops = {
 	.get_gp_seq	= rcu_no_completed,
 	.sync		= synchronize_rcu_trivial,
 	.exp_sync	= synchronize_rcu_trivial,
-	.fqs		= NULL,
-	.stats		= NULL,
 	.irq_capable	= 1,
 	.name		= "trivial"
 };
@@ -892,8 +886,6 @@ static struct rcu_torture_ops tasks_ops = {
 	.cb_barrier	= rcu_barrier_tasks,
 	.gp_kthread_dbg	= show_rcu_tasks_classic_gp_kthread,
 	.get_gp_data	= rcu_tasks_get_gp_data,
-	.fqs		= NULL,
-	.stats		= NULL,
 	.irq_capable	= 1,
 	.slow_gps	= 1,
 	.name		= "tasks"
@@ -934,8 +926,6 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
 	.get_gp_data	= rcu_tasks_rude_get_gp_data,
 	.cbflood_max	= 50000,
-	.fqs		= NULL,
-	.stats		= NULL,
 	.irq_capable	= 1,
 	.name		= "tasks-rude"
 };
@@ -987,8 +977,6 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
 	.get_gp_data    = rcu_tasks_trace_get_gp_data,
 	.cbflood_max	= 50000,
-	.fqs		= NULL,
-	.stats		= NULL,
 	.irq_capable	= 1,
 	.slow_gps	= 1,
 	.name		= "tasks-tracing"
-- 
2.39.2

