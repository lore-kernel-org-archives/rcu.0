Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BB15E818;
	Tue,  7 May 2024 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074559; cv=none; b=V+fIsk8QHADVyT4fMGYbwsYb8d4n0puTtfeXoCHAem8OjmOQLHU9N2FK7Ef8b0WegvGewN0J5YeNGh3MP72LuLzPP7wC2L72xvXtIJCcrWVVgyTIHjWgLzQmBIX/haLmFHN7wYtvUrTPlv/OLkHTCRuWcBBYPrxHMPN+Jpj1B9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074559; c=relaxed/simple;
	bh=UN+MaHfAdkJ1rWWOKXorY2bu4/QkrbWb/32kAy3Tizk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tM6FzsWezZysHZMpgEbPsUwCrUaSPRZq7n8GJkfESNGZYXSQttvHFyvt3ewav1ONBBdn/sT+5Dha21LujDJ/uYBx31uej977Db9Tz3/Fz/WRAvRCH9f/Vh3RbMfnCdwGSa2ZQOar+EdbDJ7anONL8641M2Mt922RqD+oLUT53q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/9ws5iR; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/9ws5iR"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e0933d3b5fso37210831fa.2;
        Tue, 07 May 2024 02:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074555; x=1715679355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDinHeFOFRoHZYFqFBiK+RU+jTH857k5hI4wyyJy1g4=;
        b=C/9ws5iR8Fd7KKkeQ4Kn59FJN5sknAPLxGAfMJU2gJ+0U9rlCvyWfgE6CVG5/d3KI3
         HX1b/Eq5/7pJpR//flWqXWVNvxZ3HlCmnmw8BadZ3G/Nsame69eM5URWCI/2SDl6/sHc
         Zoq2Q8ubZt7wZ3VmBwPfE+ba/IIbprm+8djhwENN4XnQJKL7WaOLUQPZhYsccs4GXNTS
         XeO941Ov2rhSfWjakwRuAgdonXdw38AV4N1JVx25HjAwdwfbstQhqhX0NOleyBK+LTtg
         P7x3j5AaYpvS+tKNTWr3Y+xCB/GICTDJ1Y2UKe38N5gSG0LEAVYS+mCFqfjl0/+wtqNv
         t9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074555; x=1715679355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDinHeFOFRoHZYFqFBiK+RU+jTH857k5hI4wyyJy1g4=;
        b=sQqXiyKYuDIrzDIoeHBLatF7DUfMZTXNvn/loJ38aj0Ch7eIFzNIIwcVtKUhE3s47K
         6anJkYw18C5SQXTDBrvZpaVlSwBypEz9/m6092I2Zha+6gZCDhB/Q7E4bu9fiScgb+ua
         W7wt7xo09MpPYXpoSYbWH0LdyeWpZWNRHJAIW6Rbn7ymsiwaK9D/VN9Eq7ECmGIAhdYH
         mhgSqnOY1nj7hq73kKfvJln3Ailwws1A/3lXJCSPNihndWfop6PYYrvdyvBxAmPSSlKN
         qHoyNUnOSEoBxxmJ37dFfNS49X5y4hK64NfW3+6JRnrnm69vN3Ngbo1obYpoQSnhYInw
         ym1w==
X-Forwarded-Encrypted: i=1; AJvYcCU9XtaAStYvvUQCW9FchbTIra3Xj98+Cc7YmiH4tu44tKCD85156DuCrhzUcdgRy5GXxtawV64QI6LoahAw3Crrego7FYvWMXXCj56T
X-Gm-Message-State: AOJu0YwrNzw7SXiUQbBBEW4SElOucbFYwKySlPDOAClfHBJ6vDUCQ7oI
	sOGkmtKX0GGXB+YMsijP6O4I8svaV1apT0sZ5wYl5I9PioJYc4tr
X-Google-Smtp-Source: AGHT+IGFwWHJtNfle5tH6dVJd1sPaxZAFj/yLFYo/LOxrHHE0mYRMwj1W/uNqv+wKea2tN1WaCwzXA==
X-Received: by 2002:a2e:981a:0:b0:2dd:409:3b25 with SMTP id a26-20020a2e981a000000b002dd04093b25mr8529160ljj.4.1715074554889;
        Tue, 07 May 2024 02:35:54 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:54 -0700 (PDT)
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
	Linus Torvalds <torvalds@linux-foundation.org>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH 23/48] rcu: Remove redundant READ_ONCE() of rcu_state.gp_flags in tree.c
Date: Tue,  7 May 2024 11:35:05 +0200
Message-Id: <20240507093530.3043-24-urezki@gmail.com>
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

Although it is functionally OK to do READ_ONCE() of a variable that
cannot change, it is confusing and at best an accident waiting to happen.
This commit therefore removes a number of READ_ONCE(rcu_state.gp_flags)
instances from kernel/rcu/tree.c that are not needed due to updates
to this field being excluded by virtue of holding the root rcu_node
structure's ->lock.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/lkml/4857c5ef-bd8f-4670-87ac-0600a1699d05@paulmck-laptop/T/#mccb23c2a4902da4d3c750165329f8de056903c58
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/lkml/4857c5ef-bd8f-4670-87ac-0600a1699d05@paulmck-laptop/T/#md1b5c026584f9c3c7b0fbc9240dd7de584597b73
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2795a1457acf..559f2d0d271f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1463,7 +1463,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 
 	WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	raw_spin_lock_irq_rcu_node(rnp);
-	if (!READ_ONCE(rcu_state.gp_flags)) {
+	if (!rcu_state.gp_flags) {
 		/* Spurious wakeup, tell caller to go back to sleep.  */
 		raw_spin_unlock_irq_rcu_node(rnp);
 		return false;
@@ -1648,8 +1648,7 @@ static void rcu_gp_fqs(bool first_time)
 	/* Clear flag to prevent immediate re-entry. */
 	if (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) {
 		raw_spin_lock_irq_rcu_node(rnp);
-		WRITE_ONCE(rcu_state.gp_flags,
-			   READ_ONCE(rcu_state.gp_flags) & ~RCU_GP_FLAG_FQS);
+		WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags & ~RCU_GP_FLAG_FQS);
 		raw_spin_unlock_irq_rcu_node(rnp);
 	}
 }
@@ -1910,8 +1909,7 @@ static void rcu_report_qs_rsp(unsigned long flags)
 {
 	raw_lockdep_assert_held_rcu_node(rcu_get_root());
 	WARN_ON_ONCE(!rcu_gp_in_progress());
-	WRITE_ONCE(rcu_state.gp_flags,
-		   READ_ONCE(rcu_state.gp_flags) | RCU_GP_FLAG_FQS);
+	WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(), flags);
 	rcu_gp_kthread_wake();
 }
@@ -2426,8 +2424,7 @@ void rcu_force_quiescent_state(void)
 		raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
 		return;  /* Someone beat us to it. */
 	}
-	WRITE_ONCE(rcu_state.gp_flags,
-		   READ_ONCE(rcu_state.gp_flags) | RCU_GP_FLAG_FQS);
+	WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
 	rcu_gp_kthread_wake();
 }
-- 
2.39.2

