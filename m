Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D1412BEF
	for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378494; cv=none; b=eGkG1C9ViIYEYOnVuwYsLVrENkPGTgmoIqsiyVLuw1qM5B61nUP76sgzgaxSZ0fT7yRBv6DhEzwmqp+XLaKzZbjiFLDrrmE7SSbohUcBYuL58BvHyoQz7df/q5LEB5oLyfIzSYAd09nRVDLIoP7A0nWgeXxawnRl34iMrw8+u0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378494; c=relaxed/simple;
	bh=hLszDS3dQvGRDwX9LIEkBFevGqoODhAvW3lcutrJxzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYYLsqj+M9rS7lN8DTMmSM2t/Zgc0oH8C57Pde59extv+OPDe60G5L/Z0dvj9LirSjaN7rwJI8poiYHfAhc7r4Z15k6JtcM+/DlJ1/bnbpi4MCxn+EdZu1VBi0SlnyuuMlsl0Zze5uUTuSjLojWzhznLdWZE5kS9OxnyOUwQXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqtDK+iE; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqtDK+iE"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0135fso15544185ad.0
        for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 02:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789378492; x=1789983292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLgVCUWBW6raNqfUrqpJZy+OR3PZ3ZnJ+vGI+hldboE=;
        b=qqtDK+iE3AkLqMBILWgpaHBHMkt9ydCWRKIjCV+B/tuBuEsiAo5QS1LwEB8QqQ80NX
         weHriKNg0JFeXea7RceQvl1f9GtW91r1Ty+9AjRd7K3kIYwrR5nkl15QXAzFdVZbdwfa
         A17a9Hn7sXoJvXIc1CHPj2ouoKTHdoFC5GSm3GAaxT6x/KcEgMns7MBr008yJvtKVBlE
         FkTbXAGoVKpVpnYbsoqBkR8sC5puPReW+2RzJggTgUFJWYZPbnDDRXeg5Fwj8YIUDxeY
         5XpxrN5DWif7RmjL4ZEOvJ11LieJMqzGOyNkiNIWHfpxXRlEDVsu/3XA+WzdFC2KLYAm
         g8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789378492; x=1789983292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iLgVCUWBW6raNqfUrqpJZy+OR3PZ3ZnJ+vGI+hldboE=;
        b=bUlsjCVs2JLAu8kU1pNpEV1/IYW6ZFgkf1DThL9OnK0EqaFkOD8Pb2RKTn3Mh92Q4b
         2to7JvCxBlNnSSXICNNDvjzW+Q3ib8UGIRgRBtyJkzxDeNoXsEIA05HjuAQThG+M+qyR
         Gzqz0WFE4+gLU7r2N2F0O4jp4PlEOwKdaud2KO+WElVHei7D3zNCXTdwNQC4x/IeXTL3
         uyp8sx2ix4w2Ctpg2C1iYDbX/K1NsQAMSdnV0iEoCCdEmGoMOUjbiaDKV/n1R7L/GzzS
         /XJEsDqrA7nBUqaoSLitNmhIyg0apedftxxO7GTH7HNbUCzN9P8vUNORVnwt7KtXPu80
         VnAA==
X-Forwarded-Encrypted: i=1; AKwUvBxDx7hufOvDwdLPsfTxmzTWc3FxYhN2UtNQgKX2KU+ZCR2wGpsu1uncoUEENDpMu0peS+8=@vger.kernel.org
X-Gm-Message-State: AFuF++nLCC9DBCGqSoN5MoppCLwca8gyfErM3W13C1Ciq1jRd8CBX7Uq
	ux5a11y33ttHHqvgzdJaH8X1wu4PyR54/P4Pj1lXDv/2JnmBmI5AHM9D
X-Gm-Gg: AYBFou0jjqDjae4QklKqFyx9ioyMOGYBlAy6CEDpwk1tZyShm5tP6sfJnhYjvejDkkO
	4KoCiskZJdsbl+DSTZ/93ftGYYInGwMPekc0IDH6q/CMpPuiesNqulgwY2lYRockcR18bc5S0uz
	/CA2vsUmIO5WzWLO0TZsuW8ngBjbt5oZJwKelrPPU1a8MVIwUd5W6wz+B9Rp+TKTl8YSkBEribF
	ba4Ti21lrOzEB4ANvksRHAvGmy/7BH7jw0tGOzAB+/SYDNFWhLQJNIZuMi7xEGnzE7wGtfbZvgI
	OlPTNqUMCJuLAV1K0I/F8i8ek6E8bvwGCVtkufxQS+vB/ImS8cLi/owpDdKeIuzG5e7moFdiq5C
	ryrq4TBHIh5mIZxAORuUQNAMdqCveTJJA0Yzy8XDlB9gHZA51o5gRtMY8XHJJabG7Exd+cXsCwr
	r81o++vSYZThJufge2ykYKkRVovqe9PduSKApxghOGSamQX6OA3oGBKNqmsfalwnjycekFOOyA7
	FpcWv+2Hbos5fEAQw==
X-Received: by 2002:a17:903:2c07:b0:2d5:e3ce:3988 with SMTP id d9443c01a7336-2dd6c6e9b11mr38703905ad.11.1789378491934;
        Mon, 14 Sep 2026 02:34:51 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc2d3bsm46109865ad.48.2026.09.14.02.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:34:51 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org
Cc: josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH 1/5] rcutorture: Add atomic SRCU lockdep support
Date: Mon, 14 Sep 2026 17:34:15 +0800
Message-ID: <20260914093419.1474829-2-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914093419.1474829-1-kunwu.chan@gmail.com>
References: <20260914093419.1474829-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three testtypes covering atomic SRCU lockdep behavior:

  testtype 4: atomic SRCU same-type deadlock
  testtype 5: atomic SRCU + raw spinlock dependency cycle
  testtype 6: synchronize_srcu_atomic() inside rcu_read_lock()

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/rcutorture.c | 84 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d795e07a12ad..ac9c726cb391 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4662,6 +4662,17 @@ static DECLARE_RWSEM(rwsem7);
 static DECLARE_RWSEM(rwsem8);
 static DECLARE_RWSEM(rwsem9);
 
+static DEFINE_RAW_SPINLOCK(spin0);
+static DEFINE_RAW_SPINLOCK(spin1);
+static DEFINE_RAW_SPINLOCK(spin2);
+static DEFINE_RAW_SPINLOCK(spin3);
+static DEFINE_RAW_SPINLOCK(spin4);
+static DEFINE_RAW_SPINLOCK(spin5);
+static DEFINE_RAW_SPINLOCK(spin6);
+static DEFINE_RAW_SPINLOCK(spin7);
+static DEFINE_RAW_SPINLOCK(spin8);
+static DEFINE_RAW_SPINLOCK(spin9);
+
 DEFINE_STATIC_SRCU(srcu0);
 DEFINE_STATIC_SRCU(srcu1);
 DEFINE_STATIC_SRCU(srcu2);
@@ -4673,6 +4684,17 @@ DEFINE_STATIC_SRCU(srcu7);
 DEFINE_STATIC_SRCU(srcu8);
 DEFINE_STATIC_SRCU(srcu9);
 
+DEFINE_STATIC_SRCU_ATOMIC(srcu0_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu1_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu2_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu3_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu4_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu5_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu6_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu7_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu8_atomic);
+DEFINE_STATIC_SRCU_ATOMIC(srcu9_atomic);
+
 static int srcu_lockdep_next(const char *f, const char *fl, const char *fs, const char *fu, int i,
 			     int cyclelen, int deadlock)
 {
@@ -4702,6 +4724,12 @@ static void rcu_torture_init_srcu_lockdep(void)
 					  &rwsem5, &rwsem6, &rwsem7, &rwsem8, &rwsem9 };
 	struct srcu_struct *srcus[] = { &srcu0, &srcu1, &srcu2, &srcu3, &srcu4,
 					&srcu5, &srcu6, &srcu7, &srcu8, &srcu9 };
+	raw_spinlock_t *spins[] = { &spin0, &spin1, &spin2, &spin3, &spin4,
+				    &spin5, &spin6, &spin7, &spin8, &spin9 };
+	struct srcu_struct *srcus_atomic[] = { &srcu0_atomic, &srcu1_atomic, &srcu2_atomic,
+					       &srcu3_atomic, &srcu4_atomic, &srcu5_atomic,
+					       &srcu6_atomic, &srcu7_atomic, &srcu8_atomic,
+					       &srcu9_atomic };
 	int testtype;
 
 	if (!test_srcu_lockdep)
@@ -4812,11 +4840,65 @@ static void rcu_torture_init_srcu_lockdep(void)
 	}
 #endif // #ifdef CONFIG_TASKS_TRACE_RCU
 
+	if (testtype == 4) {
+		pr_info("%s: test_srcu_lockdep = %05d: SRCU_ATOMIC %d-way %sdeadlock.\n",
+			__func__, test_srcu_lockdep, cyclelen, deadlock ? "" : "non-");
+		if (deadlock && cyclelen == 1)
+			pr_info("%s: Expect hang.\n", __func__);
+		for (i = 0; i < cyclelen; i++) {
+			j = srcu_lockdep_next(__func__, "srcu_read_lock_atomic",
+					      "synchronize_srcu_atomic",
+					      "srcu_read_unlock_atomic", i,
+					      cyclelen, deadlock);
+			idx = srcu_read_lock_atomic(srcus_atomic[i]);
+			if (j >= 0)
+				synchronize_srcu_atomic(srcus_atomic[j]);
+			srcu_read_unlock_atomic(srcus_atomic[i], idx);
+		}
+		return;
+	}
+
+	if (testtype == 5) {
+		pr_info("%s: test_srcu_lockdep = %05d: SRCU_ATOMIC/raw_spinlock %d-way %sdeadlock.\n",
+			__func__, test_srcu_lockdep, cyclelen, deadlock ? "" : "non-");
+		for (i = 0; i < cyclelen; i++) {
+			pr_info("%s: srcu_read_lock_atomic(%d), raw_spin_lock(%d), raw_spin_unlock(%d), srcu_read_unlock_atomic(%d)\n",
+				__func__, i, i, i, i);
+			idx = srcu_read_lock_atomic(srcus_atomic[i]);
+			raw_spin_lock(spins[i]);
+			raw_spin_unlock(spins[i]);
+			srcu_read_unlock_atomic(srcus_atomic[i], idx);
+
+			j = srcu_lockdep_next(__func__, "raw_spin_lock",
+					      "synchronize_srcu_atomic",
+					      "raw_spin_unlock", i, cyclelen,
+					      deadlock);
+			raw_spin_lock(spins[i]);
+			if (j >= 0)
+				synchronize_srcu_atomic(srcus_atomic[j]);
+			raw_spin_unlock(spins[i]);
+		}
+		return;
+	}
+
+	if (testtype == 6) {
+		pr_info("%s: test_srcu_lockdep = %05d: synchronize_srcu_atomic() inside rcu_read_lock() %d-way.\n",
+			__func__, test_srcu_lockdep, cyclelen);
+		for (i = 0; i < cyclelen; i++) {
+			rcu_read_lock();
+			synchronize_srcu_atomic(srcus_atomic[i]);
+			rcu_read_unlock();
+		}
+		return;
+	}
+
 err_out:
 	pr_info("%s: test_srcu_lockdep = %05d does nothing.\n", __func__, test_srcu_lockdep);
 	pr_info("%s: test_srcu_lockdep = DNNL.\n", __func__);
 	pr_info("%s: D: Deadlock if nonzero.\n", __func__);
-	pr_info("%s: NN: Test number, 0=SRCU, 1=SRCU/mutex, 2=SRCU/rwsem, 3=SRCU/Tasks Trace RCU.\n", __func__);
+	pr_info("%s: NN: Test number, 0=SRCU, 1=SRCU/mutex, 2=SRCU/rwsem, 3=SRCU/Tasks Trace RCU, 4=SRCU_ATOMIC, ",
+		__func__);
+	pr_cont("5=SRCU_ATOMIC/raw_spinlock, 6=synchronize_srcu_atomic inside rcu_read_lock.\n");
 	pr_info("%s: L: Cycle length.\n", __func__);
 	if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU))
 		pr_info("%s: NN=3 disallowed because kernel is built with CONFIG_TASKS_TRACE_RCU=n\n", __func__);
-- 
2.43.0

