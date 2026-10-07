Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD93641169F;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407051; cv=none; b=inB+BxGGfgas1bIv7tPmjf4DUxDuIA0ND19VB6lb0cm2/1F1cnOP+KV179staZ0UY1uvIyv8MUvNAX+iXW5ZJ2xdpk6rv6n8YO48jX+eae02ca1jT/B6BY1nXjjqOo6s+/th5F5XpbG38p/7dDsM49Q5pKKh1yheZYAiM6OfsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407051; c=relaxed/simple;
	bh=+NcX+b7yDvu4BE/EyrG89DSdiDt727HpSAk6yvMU9ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dhag8yOCQzzryXvN7XwvOjsyTdgB5cUKzNmdVlh1Tcb64gVBfXE3RiqAV2k66pZUIJ/PJSm5S4JdxXSzAsbfAC7P1x82+koqfd06V2EAWNF0Dia0zxQR6n2vPibnNos0qsK4GfMcl9Soc6QmipwfCxBwTkI2oYMsLWHSkNWIV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT185MR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT185MR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75541F0089D;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407049;
	bh=rOzvgu2DgJgVMTpRb75TJD+Wb3bbc+jBfZKtCo1gXbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HT185MR27bFugOkVsb2OBoyzRP3/XwX77/H5eUL0rYMZpllIzTEuB9wJrnsyHi0Rv
	 YjPSCFJ4sTVVjvB6UOcI5wL5FY/UotAISg4j97GeWG0iT2pG8tttn+srdEfQB24jZl
	 n+6OSpMKnVRNwoLoQz7P2vHHLDp08EmuLQVHgpQ8lAD1LPi708aS82cnCfpHj5sduS
	 qJ0HTxVJ32bR7gcdX+sf/grtxsxb1uSKa6c+O4nWEukYFvotb/wtIOvbo/EQhzNvfX
	 cwLv/8CzPzQc1FYYXavypuRp8SXX99WSnih4jQMTR5xyfcaX/moHqZ5usYoiyPpp1J
	 BkK7Zp5gcjX+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5AADFCE26CA; Wed,  7 Oct 2026 14:04:09 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 5/8] rcutorture: Add atomic SRCU lockdep support
Date: Wed,  7 Oct 2026 14:04:05 -0700
Message-Id: <20261007210408.1983713-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
References: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Add three testtypes covering atomic SRCU lockdep behavior:

  testtype 4: atomic SRCU same-type deadlock
  testtype 5: atomic SRCU + raw spinlock dependency cycle
  testtype 6: synchronize_srcu_atomic() inside rcu_read_lock()

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Boqun Feng <boqun@kernel.org>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 84 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 51ed35f5aab17..35dc61d871b98 100644
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
2.40.1

