Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C44189B8C;
	Wed,  7 May 2025 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617177; cv=none; b=n/2pGZuGWNnpaP5a4FPoqb3lBlz0VogivFOCcTaFjjtUH+QL47I1v4E1EoPQjbBoa0PAqBJNXSSAdZwzKNf5C64qzMlmc7BVi+IEz3HgPM0i/+r3lBb5a/3gm8iwDgB/mUXc3maOcrTglOfzDD59zsVbGCEkdC4FbPA66vR7OFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617177; c=relaxed/simple;
	bh=mQdRu9nt9DF6a/07VoCCoI4ODboFbNw2SfGiz+1z1M4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FJKx8JKbvqkDJ3Mt0cO+RaIztTgDFPBC64AM5zPuBHx8X7JzTUUECqEOyPb2/OKNUuibQkK40G5+XCBEi/kKNPeSO5GyoDy34TAl2dOgjYQg8kcF7MuBxybBDOM1eT/by6yVHXrUrkSCrmcd1wjuBIh6+oFNH/eqCFJDAudLNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFNyzTwq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFNyzTwq"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736c3e7b390so7570516b3a.2;
        Wed, 07 May 2025 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746617175; x=1747221975; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU4IPVDob4K1HuHAYIVlP4inH/rvK2N+HDjkyfBY+Uo=;
        b=NFNyzTwq9f3JeoE4oMD9n0A3KoUWY+rwFTQZrOo3GB6aweaXVFkz91nMMosftg+2Up
         sL/lpqygGo4O919xs1O9/zGFvaq3s3EEDpLMOe9lFB9bXrbMe1S4hYHUMIlICkbjCP54
         y/YCKBhA/42f07sOFRFMInaDnt6Ow3hoRjfUDR3XEKtWK5FlFvcbM6eXixkuJ7YxRHmk
         +J9jM3ivJSRjhESKiapTbdsnrLwVg2NL0TyGeSnoRsWMNiFrkOduw+V/teKyxCXBC1BE
         7t0RKP9Ddu2CWxdtxHRBK0l+7X4Ma82rQLC/v02VIQQJ+l7W70HFj9WkzobdUbvOrWoP
         0/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746617175; x=1747221975;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kU4IPVDob4K1HuHAYIVlP4inH/rvK2N+HDjkyfBY+Uo=;
        b=NJ1gPknBAfBqKc7yxYBUz8aPk0d+uP1OO9SeCrk5JOfwbJumSgtATVi5h2NjCVrISO
         Uo0DVeYQza0v4z2vYpblOnYf+0pMsuZ7+yV3nqn9h1rB7StoiIvuWe3ZqabaAZ6omcbw
         2MYMKEaEbE8TnmOgPcCVC0hVxBQWxO2f+yVLEhnX+xHcsXSIfcnl9/f7bOhGQdUn91rF
         j7NIwg5PlrKo0FhX0koYuMYiwveVcKDC1ZEK4NfIbpQgOblbwi+QCsPwgyc4dMT3zw3T
         +Y9PF4VvKYyafYQ/2pJbiQcOQX2oa4GZXyAU2loXmrXQiJUm74e6akocWzpFwAfHuU8g
         DmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1o2wJFM9pxZAlRaNCwz17nlT9IdkVO4vsTRJMNLpbSWTReEVVCTLxRixOmy2XpUhbecLKw8A3//3Aae0=@vger.kernel.org, AJvYcCVyLAoStbUAriN5rpQJ/xGyVnJ1A8Wq+ivRDeJD+AQOUlDKC6FiwAR+wqlOhloxWCPev8DS@vger.kernel.org
X-Gm-Message-State: AOJu0YxuSxwnYUCHheTv0ro4fUu+3s8TKGRkmojaT5WTMMpg2SCPzBRh
	HX5MpTWA9vInRmVUfeNMiSZ814tF8OkVAn+o2YCLUJ8JEsIlBIMfraQFJE2pzwQ=
X-Gm-Gg: ASbGnctOn3Lsgwo5KkncOjg8weGl9SKUreR13fi5Qboafwc67fyFrcGZwqvF0MPJfQg
	J1m1JxdvRclJux3qs80UxYr6nz34GKpQ5nBF9tvk7DYn7FthFI/ZIyt8mpi8pdDtJipCsdzGZ16
	0eADv7k6Tf6K9FcqEuTt+TaSz/UZlkbT1qqGOpF0vNdNhtsedxAqTKCo/wkgTJyM3JsU9+WtpAB
	Drfe/AagacDBV0GnZdwjbXZIDYCyRz/O79LRFtGB7mmt+caQWbwzkaw0ytAKbeeJnO6S4BEHDM/
	2KqU5FFaTKvWb7yFaHS3XfZwybtRYr7yIut7cE8r85eUNDG3N3gZz815defkyqkcaXMR2PbmsQ=
	=
X-Google-Smtp-Source: AGHT+IFCD49DiyJAUum+f5nQXJ25qce++pssO6RelGMftkAZs1bU3McbEpddihqy9/89a8+pRYs+Zw==
X-Received: by 2002:a05:6a21:6d84:b0:1fb:e271:82e2 with SMTP id adf61e73a8af0-2148b9227bemr4334687637.11.1746617174929;
        Wed, 07 May 2025 04:26:14 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590610desm11184898b3a.146.2025.05.07.04.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 04:26:14 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	urezki@gmail.com,
	boqun.feng@gmail.com
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Fix rcutorture_one_extend_check() splat in RT kernels
Date: Wed,  7 May 2025 19:26:03 +0800
Message-Id: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

For built with CONFIG_PREEMPT_RT=y kernels, running rcutorture
tests resulted in the following splat:

[   68.797425] rcutorture_one_extend_check during change: Current 0x1  To add 0x1  To remove 0x0  preempt_count() 0x0
[   68.797533] WARNING: CPU: 2 PID: 512 at kernel/rcu/rcutorture.c:1993 rcutorture_one_extend_check+0x419/0x560 [rcutorture]
[   68.797601] Call Trace:
[   68.797602]  <TASK>
[   68.797619]  ? lockdep_softirqs_off+0xa5/0x160
[   68.797631]  rcutorture_one_extend+0x18e/0xcc0 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
[   68.797646]  ? local_clock+0x19/0x40
[   68.797659]  rcu_torture_one_read+0xf0/0x280 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
[   68.797678]  ? __pfx_rcu_torture_one_read+0x10/0x10 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
[   68.797804]  ? __pfx_rcu_torture_timer+0x10/0x10 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
[   68.797815] rcu-torture: rcu_torture_reader task started
[   68.797824] rcu-torture: Creating rcu_torture_reader task
[   68.797824]  rcu_torture_reader+0x238/0x580 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
[   68.797836]  ? kvm_sched_clock_read+0x15/0x30

Disable BH does not change the SOFTIRQ corresponding bits in
preempt_count() for RT kernels, this commit therefore use
softirq_count() to check the if BH is disabled.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcutorture.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 373c65a6e103..ef439569f979 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -471,7 +471,7 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 	    !(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
 		started = cur_ops->get_gp_seq();
 		ts = rcu_trace_clock_local();
-		if (preempt_count() & (SOFTIRQ_MASK | HARDIRQ_MASK))
+		if ((preempt_count() & HARDIRQ_MASK) || softirq_count())
 			longdelay_ms = 5; /* Avoid triggering BH limits. */
 		mdelay(longdelay_ms);
 		rtrsp->rt_delay_ms = longdelay_ms;
@@ -1990,7 +1990,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
 		return;
 
 	WARN_ONCE((curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
-		  !(preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
+		  !softirq_count(), ROEC_ARGS);
 	WARN_ONCE((curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
 		  !(preempt_count() & PREEMPT_MASK), ROEC_ARGS);
 	WARN_ONCE(cur_ops->readlock_nesting &&
@@ -2004,7 +2004,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
 
 	WARN_ONCE(cur_ops->extendables &&
 		  !(curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
-		  (preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
+		  softirq_count(), ROEC_ARGS);
 
 	/*
 	 * non-preemptible RCU in a preemptible kernel uses preempt_disable()
@@ -2025,6 +2025,9 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
 	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
 		mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && softirq_count())
+		mask |= RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
+
 	WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
 		  cur_ops->readlock_nesting() > 0, ROEC_ARGS);
 }
-- 
2.17.1

