Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2484E3ECA;
	Fri, 25 Sep 2026 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366174; cv=none; b=PF9r9kSVwaq2fGtG9WxdFcSzWNjlJZGJQCffl8YsY79jxcp20BeNCQIA/ActI9FYMVDUe+OsMwgcrIaRZ23TJv45vSYcK+q3+P9dJ7bRjFiwrwxiePAB+0OsNy0PTREupgK4uiTCoeFM92V/NeAYgNo4v4AnVBbhUcy+qeixamA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366174; c=relaxed/simple;
	bh=audB0FpfDuBfRyPBf9bWcCoNtlhwyLxuyZnOlMpzEJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUMRskgjBwBg3OStAL4O4ZYuM27krg6yf9uuE7gv7mTuoBPNIjUt7EABEKPXJQ32l8Dz7jULT4orSeOX2W4EgsveQVOfBUGi74OzveYHjW8IJ8pETWajqLl0gky1wLoBIqDAhf8pAVZ991HJ6dJB7AWmzvg32x2NtK0agnAAvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Wq313/Pc; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Wq313/Pc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1790365805;
	bh=87cpbqsvmvNk3D+HWx2HPcws+nCHaTHP+1cQwQL9204=;
	h=From:To:Cc:Subject:Date:From;
	b=Wq313/PcFbW8iZ61i863Ef88wzhMoiLcYCMPsCOq0XIOXF4vOhHJF2VoxQwAgNv3G
	 zXbgVy/7oC3QRMawBIwj6zsHHaQ2UI/EOtJfSlRSgqEXFpRRfFnEoecn0s3E8Q9Me4
	 QCadYiWUg4853PVzCYZFiLYbumIGL0e3ODW7z6jgHFab/XLjdaikdFr6XqjPs6EEf0
	 mAjCR2/jWeh7FSxYY9iMM8jF12WapgchU2o94vRP+lL1gstHQKavEbQSEk2l5RBn3l
	 IiIGOUwmD4WlnyH1MryF+Chrp0n9+zNJLpxdPlyparsRzq44R45OD899vApttUpjXI
	 xB9H68P46auwg==
Received: from compudjdev.. (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4hs1Wd22khzgw0;
	Fri, 25 Sep 2026 15:50:05 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: [PATCH] hazptr: Fix two-phase hazptr_synchronize race with detach
Date: Fri, 25 Sep 2026 15:49:42 -0400
Message-ID: <20260925194952.4704-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Boqun Feng pointed out that a detach happening concurrently with
hazptr_synchronize can miss a slot. Indeed, scanning the per-CPU
slots needs to be done *before* scanning the overflow lists. Fix the
implementation accordingly.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: Boqun Feng <boqun@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/hazptr.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index d3d1050d92cf..ccc19843edbd 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -24,6 +24,9 @@ static DEFINE_MUTEX(hazptr_wildcard_lock);	/* Protect the wildcard flip. */
 void *hazptr_wildcard = (void *) 1UL;
 EXPORT_SYMBOL_GPL(hazptr_wildcard);
 
+/* The current overflow list phase. */
+static unsigned int hazptr_overflow_list_phase;
+
 struct hazptr_overflow_list {
 	raw_spinlock_t lock;		/* Lock protecting overflow list and list generation. */
 	struct hlist_head head;		/* Overflow list head. */
@@ -53,6 +56,12 @@ void *flip_wildcard(void *wildcard)
 	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
 }
 
+static
+unsigned int flip_list_phase(unsigned int phase)
+{
+	return 1 - phase;
+}
+
 static
 bool is_wildcard(void *addr)
 {
@@ -178,15 +187,12 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
 }
 
 static
-void hazptr_scan_period(void *addr, void *scan_wildcard)
+void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
 {
-	unsigned int scan_idx = (unsigned long) scan_wildcard - 1;
 	int cpu;
 
 	/* Scan all CPUs slots. */
 	for_each_possible_cpu(cpu) {
-		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
-
 		/*
 		 * Scan CPU slots.
 		 * Forward progress against recurring wildcards is guaranteed
@@ -199,6 +205,17 @@ void hazptr_scan_period(void *addr, void *scan_wildcard)
 		 * to acquire that same hazard pointer value.
 		 */
 		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
+	}
+}
+
+static
+void hazptr_scan_overflow_list_period(void *addr, unsigned int scan_idx)
+{
+	int cpu;
+
+	/* Scan all CPUs overflow lists. */
+	for_each_possible_cpu(cpu) {
+		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
 
 		/*
 		 * Scan backup slots in percpu overflow lists.
@@ -218,6 +235,7 @@ void hazptr_scan_period(void *addr, void *scan_wildcard)
  */
 void hazptr_synchronize(void *addr)
 {
+	unsigned int scan_list_phase;
 	void *scan_wildcard;
 
 	/*
@@ -236,10 +254,21 @@ void hazptr_synchronize(void *addr)
 	smp_mb();
 
 	guard(mutex)(&hazptr_wildcard_lock);
+
+	/* Scan per-CPU slots. */
 	scan_wildcard = flip_wildcard(hazptr_wildcard);
-	hazptr_scan_period(addr, scan_wildcard);
-	WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
-	hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
+	hazptr_scan_cpu_slots_period(addr, scan_wildcard);
+	WRITE_ONCE(hazptr_wildcard, scan_wildcard);			/* Flip the current wildcard. */
+	hazptr_scan_cpu_slots_period(addr, flip_wildcard(scan_wildcard));
+
+	/*
+	 * Scan overflow lists *after* scanning per-CPU slots. See
+	 * hazptr_promote_to_backup_slot() for scan ordering requirement.
+	 */
+	scan_list_phase = flip_list_phase(hazptr_overflow_list_phase);
+	hazptr_scan_overflow_list_period(addr, scan_list_phase);
+	WRITE_ONCE(hazptr_overflow_list_phase, scan_list_phase);	/* Flip the current list phase. */
+	hazptr_scan_overflow_list_period(addr, flip_list_phase(scan_list_phase));
 }
 EXPORT_SYMBOL_GPL(hazptr_synchronize);
 
-- 
2.43.0

