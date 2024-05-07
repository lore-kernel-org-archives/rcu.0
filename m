Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15D16C845;
	Tue,  7 May 2024 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074582; cv=none; b=H96gLqaPQA96g19Z9XOmeGs+TpNsPHnpOZpwxr9+wJiuYGwgRyPLyuEMBFxjRJFnwMyzolFgSSIOom25Jm8GNjzB1+XYfGs0fdbHf7A8FRkEp6+0I+o/wOMy8fx4YKrmJORJHF0dUA0giqmi6oJVMdYvPGiASkdbEirWOOgacuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074582; c=relaxed/simple;
	bh=9oDpi+Fem3Cos/zr4jTtNfAvBbEDM16i8DVTJbcW2hI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UcXDcFuZjb4LlaOu5t7BAdfi+Nil6+1h/qPPQ4F6S3T2Lh5TOKsv9adxmYjSuehRKyJ1QUD/4wOGoEs1+1TG2rMsdt2fugD9J5nNBtt9IJ3otLR6Q8tWNHjpowpqrV601GYGgHLUzIUa8wX9PcNLPn02ZI7WXgfiUhxpHKe9VLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfOVQ2sh; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfOVQ2sh"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e30c625178so25907111fa.1;
        Tue, 07 May 2024 02:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074579; x=1715679379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpnem8fG8lmGj5qC7Q/yc7iEgYHNFLn5w8ZfsCfYrbA=;
        b=DfOVQ2shsKkWi9DxW1gvp3QKE6lj01hDprItFuu78PLVjyrthL/Bb3CfTPtM/gaXnn
         aD5Yb2nSpNt9EocvMZ9UA8V50e/H1pnE8gOjDixsfC69M95KNXwLLir3b0VDiCWqd5xh
         /y/sQ+xfve9AaGrYNVz+JMAWJRo/GHvWYbRjvuCgkc0IPrc5Q3hDEkUSECB2x2x+nvHe
         7uIcfK4S7GFKvAhmga1C/9J50MwoRK7cuOYYZCN4NBs4PZSXV5B0jDaIwTFgxsPmfypX
         DSEGob8Hbuy8as3urM7VaFZxdeKDA23XEnVI3F9xhrkzqzJPHU9U7kuVaCBagHoVOZaj
         EL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074579; x=1715679379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpnem8fG8lmGj5qC7Q/yc7iEgYHNFLn5w8ZfsCfYrbA=;
        b=dfxrxXv7QoZZ/cMmnRO3YszdLuUHft5415EsBdqmlnGgcEOFFSzfGrRRTSpwTfSt1Z
         /X/4eJuiR4hK7Ae+9iXS04D6znpKmtDZYoiGG/oRtq9esFgeX9RuhhdwQGi0kTvWz7ZH
         1njNns4VZFUBVyuCwI+BpgBcRBY9bJRcrYlMsV/aVE7f+9jOdOXV2Sy6+Fki0cqIkMhS
         P+GHGeKtEpoR8whWhsOUFNWdahOFX77NY/uQPeGb/kcOaM+yWmhNvH56SBQ+7SCrq4XW
         o2V5HPmooSAycqx0uLh/5JNJv4LLXjjgz0u02VfR8mwh0IiOSLlJwbMUSELFQ/pqAAdg
         2yLg==
X-Forwarded-Encrypted: i=1; AJvYcCWXNKDpkw3XD1FRQVHIqvfcNFbZJC5N5FjUj6qvA2C6wAXtD+epXHNs4ighQbeUzTTzU8V1LF1/6xfGdnmQaivtUt4iKMNlt6IMtbUT
X-Gm-Message-State: AOJu0Yy4D0adqntnR9G2iqWDVtYPASrn1F31enVostIT+y68ojLETt1P
	asKiE2G1WqCiVM6PRK+FxYdTI+gkPIyH6y3Wofq9qvz1YGIj/SMw
X-Google-Smtp-Source: AGHT+IFxFDhj+lL2nzeOJOW9nLi0WbJqK1ZevxlqT1AqLU0U8bAmZbYThOh/2rGOyiHKLN9VnuOH4Q==
X-Received: by 2002:a2e:9006:0:b0:2dc:b964:b15 with SMTP id h6-20020a2e9006000000b002dcb9640b15mr7563411ljg.25.1715074579178;
        Tue, 07 May 2024 02:36:19 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:18 -0700 (PDT)
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
Subject: [PATCH 48/48] rcutorture: Use rcu_gp_slow_register/unregister() only for rcutype test
Date: Tue,  7 May 2024 11:35:30 +0200
Message-Id: <20240507093530.3043-49-urezki@gmail.com>
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

The rcu_gp_slow_register/unregister() is only useful in tests where
torture_type=rcu, so this commit therefore generates ->gp_slow_register()
and ->gp_slow_unregister() function pointers in the rcu_torture_ops
structure, and slows grace periods only when these function pointers
exist.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8654e99bd4a3..807fbf6123a7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -382,6 +382,8 @@ struct rcu_torture_ops {
 	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
 	int (*stall_dur)(void);
 	void (*get_gp_data)(int *flags, unsigned long *gp_seq);
+	void (*gp_slow_register)(atomic_t *rgssp);
+	void (*gp_slow_unregister)(atomic_t *rgssp);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -570,6 +572,8 @@ static struct rcu_torture_ops rcu_ops = {
 	.check_boost_failed	= rcu_check_boost_fail,
 	.stall_dur		= rcu_jiffies_till_stall_check,
 	.get_gp_data		= rcutorture_get_gp_data,
+	.gp_slow_register	= rcu_gp_slow_register,
+	.gp_slow_unregister	= rcu_gp_slow_unregister,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -3343,12 +3347,12 @@ rcu_torture_cleanup(void)
 			pr_info("%s: Invoking %pS().\n", __func__, cur_ops->cb_barrier);
 			cur_ops->cb_barrier();
 		}
-		rcu_gp_slow_unregister(NULL);
+		if (cur_ops->gp_slow_unregister)
+			cur_ops->gp_slow_unregister(NULL);
 		return;
 	}
 	if (!cur_ops) {
 		torture_cleanup_end();
-		rcu_gp_slow_unregister(NULL);
 		return;
 	}
 
@@ -3447,7 +3451,8 @@ rcu_torture_cleanup(void)
 	else
 		rcu_torture_print_module_parms(cur_ops, "End of test: SUCCESS");
 	torture_cleanup_end();
-	rcu_gp_slow_unregister(&rcu_fwd_cb_nodelay);
+	if (cur_ops->gp_slow_unregister)
+		cur_ops->gp_slow_unregister(NULL);
 }
 
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
@@ -3929,7 +3934,8 @@ rcu_torture_init(void)
 	if (object_debug)
 		rcu_test_debug_objects();
 	torture_init_end();
-	rcu_gp_slow_register(&rcu_fwd_cb_nodelay);
+	if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
+		cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
 	return 0;
 
 unwind:
-- 
2.39.2

