Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF02414A3E;
	Wed,  7 Oct 2026 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407053; cv=none; b=iTDm/ZKs9PThQI0lStLnMIjBduOQuGmJfMcwk0JMYg08Z+nO7MHvbfNEiY8i+jsVm/klCriCemcgmJ2//hDOVfMHQ8hizR0kb7Pj8Ijl4NAosiWizbphGWi38eYZExB10zXcOsGM7uN5QD5zt35nLZt42E8GVzrSVqGvDq1BpYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407053; c=relaxed/simple;
	bh=YnGrQ9l6n1IinnAn2qmNxXSPDEkowdqvbdD03XsC2lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqP6mMJbt6wCQty/cCabghcQeHI34a9r5eL19h3T2ihUI0Xb/dmT6HwNGYOSO5v9els6G9Ocm5SULdRsz1XrFd+/WLzBxsxUUAw4Pt4oynjCjvhWIDTY0QaWFWeMwBzIZRrSpni0ULq5phK08yXepgwNQ967vatUFV5pTsLBcEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWnaErIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWnaErIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8B81F0089F;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407050;
	bh=7G5UFyw6kveFR2HHsfb2gVtIie/+BtYS6SCJpwa8Kyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GWnaErIkznLHOPvzM28lLoDD6AnfpmCqbtU1lvosiH1E3yc5NPT+Atp2YKe9adwtj
	 8w5xWjgjQyodcby5atQWo7jzyUBgWs0UwbLoLb8OmBanzn5/ApiOBq8I+De59nWlPc
	 dsJw01hDosCTjmk4gPUVIZXFdNT1BG57Uz1GCLELlMXZ0HvknJlVp7pRKagzaGev4D
	 h4wv0jSfobsR9jKaXfBS7r6YniMDMi4K7moZWSykdoSsBpMVuHAH2lBJKYwwKGP4Fr
	 6eVJk8adrDpZjTADP5rv/vNw0v6Eza5M2TY3yNUzRwNP9aVN7dpMTPl9ff4y7nLnaj
	 hQcw+zIOXzIdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 628A2CE2742; Wed,  7 Oct 2026 14:04:09 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 8/8] rcutorture: Add atomic SRCU cross-CPU IRQ context mismatch test
Date: Wed,  7 Oct 2026 14:04:08 -0700
Message-Id: <20261007210408.1983713-8-paulmck@kernel.org>
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

Add testtype 7 to verify that lockdep detects an IRQ-context
mismatch when an atomic SRCU read-side critical section is held
with IRQs enabled on one CPU and synchronize_srcu_atomic() is
called from an IPI handler on another CPU.

This covers the cross-CPU case that cannot be detected by
checking the current task's held locks.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c                       | 27 +++++++++++++-
 .../selftests/rcutorture/bin/srcu_lockdep.sh  | 36 +++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 35dc61d871b98..968343be4e0d1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4695,6 +4695,8 @@ DEFINE_STATIC_SRCU_ATOMIC(srcu7_atomic);
 DEFINE_STATIC_SRCU_ATOMIC(srcu8_atomic);
 DEFINE_STATIC_SRCU_ATOMIC(srcu9_atomic);
 
+DEFINE_STATIC_SRCU_ATOMIC(srcu_irq);
+
 static int srcu_lockdep_next(const char *f, const char *fl, const char *fs, const char *fu, int i,
 			     int cyclelen, int deadlock)
 {
@@ -4709,6 +4711,11 @@ static int srcu_lockdep_next(const char *f, const char *fl, const char *fs, cons
 	return j;
 }
 
+static void srcu_sync_irq(void *unused)
+{
+	synchronize_srcu_atomic(&srcu_irq);
+}
+
 // Test lockdep on SRCU-based deadlock scenarios.
 static void rcu_torture_init_srcu_lockdep(void)
 {
@@ -4892,13 +4899,31 @@ static void rcu_torture_init_srcu_lockdep(void)
 		return;
 	}
 
+	if (testtype == 7) {
+		int cpu;
+
+		for (i = 0; i < cyclelen; i++) {
+			idx = srcu_read_lock_atomic(&srcu_irq);
+			cpu = cpumask_any_but(cpu_online_mask,
+					      smp_processor_id());
+			if (cpu < nr_cpu_ids) {
+				pr_info("%s: CPU%d sending IPI to CPU%d\n",
+					__func__, smp_processor_id(), cpu);
+				smp_call_function_single(cpu, srcu_sync_irq,
+					NULL, 1);
+			}
+			srcu_read_unlock_atomic(&srcu_irq, idx);
+		}
+		return;
+	}
+
 err_out:
 	pr_info("%s: test_srcu_lockdep = %05d does nothing.\n", __func__, test_srcu_lockdep);
 	pr_info("%s: test_srcu_lockdep = DNNL.\n", __func__);
 	pr_info("%s: D: Deadlock if nonzero.\n", __func__);
 	pr_info("%s: NN: Test number, 0=SRCU, 1=SRCU/mutex, 2=SRCU/rwsem, 3=SRCU/Tasks Trace RCU, 4=SRCU_ATOMIC, ",
 		__func__);
-	pr_cont("5=SRCU_ATOMIC/raw_spinlock, 6=synchronize_srcu_atomic inside rcu_read_lock.\n");
+	pr_cont("5=SRCU_ATOMIC/raw_spinlock, 6=synchronize_srcu_atomic inside rcu_read_lock, 7=atomic SRCU cross-CPU IRQ context mismatch.\n");
 	pr_info("%s: L: Cycle length.\n", __func__);
 	if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU))
 		pr_info("%s: NN=3 disallowed because kernel is built with CONFIG_TASKS_TRACE_RCU=n\n", __func__);
diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index 3acaffe52c784..c29a39f7d8914 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -115,6 +115,42 @@ do
 	fi
 done
 
+# Verify that synchronize_srcu_atomic() detects IRQ context mismatch
+# when SRCU reader previously ran with IRQs enabled.
+for c in 1 2 3
+do
+	err=
+	val=$((1000+7*10+c))
+	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s \
+		--configs "SRCU-P" \
+		--kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" \
+		--bootargs "rcutorture.test_srcu_lockdep=$val" \
+		--trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
+	ret=$?
+	mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
+	if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
+	then
+		echo "rcu_torture_init_srcu_lockdep:Error: CONFIG_PROVE_LOCKING" \
+				"disabled in rcutorture SRCU-P scenario"
+		err=1
+	fi
+	if test "$ret" -eq 0
+	then
+		err=1
+		echo -n Missing lockdep warning for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+	elif ! grep -q "inconsistent {HARDIRQ-ON-R}" "$RCUTORTURE/res/$ds/$val/SRCU-P/console.log"
+	then
+		err=1
+		echo -n Missing lockdep warning for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+	fi
+	if test -n "$err"
+	then
+		grep "rcu_torture_init_srcu_lockdep: test_srcu_lockdep = " "$RCUTORTURE/res/$ds/$val/SRCU-P/console.log" | sed -e 's/^.*rcu_torture_init_srcu_lockdep://' >> "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+		cat "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+		nerrs=$((nerrs+1))
+	fi
+done
+
 # Test lockdep-enabled testing of mixed SRCU readers.
 for val in 0x1 0xf
 do
-- 
2.40.1

