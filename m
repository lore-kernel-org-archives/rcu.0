Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811524;
	b=P6rd/QrX0VkXxjK6kFkF25m+Z35Q1FKFNAA+GrtLa8fmCIm7fr7iiGUoQ4j8YdrRPAIv
	 Mt+BR++sqQVOK9B9balz6PYSslUHX3OSYi56VoQCflWnj0MQ6Jpg71MpL/yMzm+eGfqcB
	 CZG/ezlMPZKGqHFd9OJf9tBJpei9KR9DYGSOevIiecTJuX1kJfvsEfkiqOLFetQDAqva1
	 SQA5H8yiLIIrPNsOqCM9+1mal+jb5RxZu6v9nXquAU7lM3Rp4aUkKCWEp8C2zB8nL676d
	 A2KtctjdeZSuyMa/bKeUSma6OZdXov9jFJmLZM8kC2DF5/orYzmcXdIWHhCJSp7x4UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LPhJ/LZWrehxYqi2srB7hOfC0/MmzJuEkML/aEZarl0=;
	b=h05FX1Z4CQcHtkzcn/Mnk8qCMFuRrz75ZwQFKE6bUDk+fkFROMP1aTcL7ixDUuatOMLw
	 je8dreW/iC8LeoPl/N9y+3Jq1QIOhtUaKmoNWJBgdu6l0S2MW8KrKLP5wbqDawtJT82sT
	 2IDAxopaWou0dqXAVTBqKf8QyU+odS2qzAKAHgFG6e6ezG5IODqRasiMIihMKmE83O8L4
	 3lk5fH9xv91n2fGIwSWMjrNuVAql/IoNd/afKpOZxPnyXAGjYHHkmlZ2dKGoGEj5VUZfz
	 mDkTHnPqKmCPl5yuZdbWUbMpwEFRHDc62+wopbYk2zNk9vGi1gp538WJUOLdsdszaeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hyt1yD5+;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B09606D802
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66B09606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hyt1yD5+
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36dbde64409so286490eec.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811523; x=1794416323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LPhJ/LZWrehxYqi2srB7hOfC0/MmzJuEkML/aEZarl0=;
        b=hyt1yD5+jjpEugsWapKyMZusHbyyRtG0Zg8zegaXHJUzLqZqDfJPszfKMwqvjYCetj
         IrJWMeImtzM7GirY49bM2dx7cObOOL7N5Fnjg+WMtKNow21yslpCrdMmoqyKy1JKYZb7
         HSBDax1eDx/bfKPiGozjJAiPus92A2h3wak1w5kcJ9XsttzfsGltbO+5rakVtv1JKCCt
         3YsBqfJApCHWCf8Wtx3EFCczzcK4TrEoAg4a2+CYhPWdSeNB1+RVTbkEmMatwgzNtq9o
         WU/7ntw/yTf6kZi6In0JDuXse4r6ElsZnVli9DeG6p0sGR9houxwRgcJuDGjgpySqhUP
         MW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811523; x=1794416323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LPhJ/LZWrehxYqi2srB7hOfC0/MmzJuEkML/aEZarl0=;
        b=KC9+dsrIVCLrhQRql7QHO+5nruUJx/eBqdnnPy/0yloc4DIrt9mnA0wZC1+AL/+nH8
         5bQvREg2hO+d6+ediQMvcEyEt7q4SWrfDBnWUpnmScjX1rCicUjjnms0UsybYkWV3HDA
         Sb++wU14uWkgFfWuHFHkPFki4xxURu9WrG6katjxXnU3OsLxeM46Ealfce7EzBzLAOZ1
         2KYS3AFr8pAJcRV/gw0WFZyucP35v0lJsERkbymxKUjVCvMXwLWz3JwQ5MTdYfcWgoSv
         j4VYrcI8uNeoatqRG9An8odMudPIaR4OEHWaIl/EACHG8xv3tvdwThV/HHl37pV41ym6
         ax4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxFDJM5QlpBObTh42Tzqlu314o5oQRpbeKeqFa+7puQ+WyZbbJcD3UXkotjNZcYVCL9Vp0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gXu5QotnhbgCXH67uvsRlx34CuyEbCJGej/hsIa/KNz1zuwTF
	RpoBjH9/jw2FQf+kuNJ/qqz4sZbN9orESJIpmFHnJIdNKWfz/jttagNk
X-Gm-Gg: AYBFou1cdtAj4gQYAA3HMgsF5bj1qqmv1A1Nbj+lGqQaJVWzp9K1eQy4bv7C4/D8cpL
	rghoYPnHOc62GyFMwbGUoeH1dVxS40oXTaF/X9N9le0SH4QPR7/EZ5lF6zHTIrg5ycaWHZu5Fuu
	gEEPVvt7QtOJkEZZAarsO1w41sO2HJ+g6xzWwtfPAyTxy5Sjo6jRocsgT8xwjuRNNjDrt4LoLte
	WK/EPe8Uw4tr24JIDQgV8xb60hU2DG0Y6nCZKRdChGWrIIrGCKpsZ6yYMivKMr/UGVKd0QvshKm
	0/3LQVd27Bbb02nqKxfQdL0tPNewZV0gViziY/3zvwWi71kYVCcMtVooWDsTaQW/yHLO7sqPEu+
	/peFwEZwg9Y9rhUtEIK4zn1uoBsirKYJJzjJP/odn195O8ys2v6WiPUKA7xw8DudFDB4rtSjxa+
	1yDW13RlPUkqJ3IurQ25QU5J9+qfsDRhUwi+cJgtz94wq1FHJIUVixLbwitNVlUmFWN9kFa9xlM
	0vB7+hHD1J+72evvpKWXdEXkFXHneZrQAWT5g0wpeVLfUDw/cdD+ZGXjv5HULql6XzGU2suEL5G
	2autMPUuOCzE+ZJIflpTAc0R23Kn5/v/vnf89l0=
X-Received: by 2002:a05:693c:87c9:10b0:360:e2e6:f849 with SMTP id 5a478bee46e88-36a4241985bmr24785233eec.28.1793811522563;
        Wed, 04 Nov 2026 08:58:42 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:58:41 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 22/28] hazptrtorture: Add drain fairness rotation scenario
Date: Thu,  5 Nov 2026 00:54:40 +0800
Message-ID: <20261104165504.2430480-23-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two stuck addresses, each held by a dedicated holder for the
whole observation window (hot_fair_ms), with two sync waiters
launched back to back.  The first waiter's drain engages and,
because its holder never releases, must hit the fairness cap;
the second waiter's counter kept growing, so it gets the next
drain turn.  Rotation evidence comes from the kernel drain logs:
distinct addresses in "drain engaged" lines plus at least one
"drain disengaged (fairness-cap" line.

The module verdict only requires forward progress: after both
holders release, both syncs must drain within 30 s.  Rotation
observation is reported via console-log checks in hazptr.sh,
graded as notes (not errors) when the window is too short for
the configured HZ.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/hazptrtorture.c                    | 211 +++++++++++++++++-
 .../selftests/rcutorture/bin/hazptr.sh        |  51 +++++
 .../rcutorture/configs/hazptr/CFLIST          |   1 +
 .../rcutorture/configs/hazptr/FAIRNESS        |  19 ++
 .../rcutorture/configs/hazptr/FAIRNESS.boot   |   1 +
 5 files changed, 281 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/FAIRNESS
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/FAIRNESS.boot

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 5dbe04af7515..787862a4d4eb 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -64,6 +64,8 @@ torture_param(int, hot_longhold_ms, 0,
 	      "Long-hold round duration (ms), 0 disables; R0 holds past the stall timeout, no hammer");
 torture_param(bool, starve_expected, false,
 	      "Starvation episodes are expected (documenting mode)");
+torture_param(int, hot_fair_ms, 0,
+	      "Drain fairness rotation window (ms), 0 disables");
 
 static char *torture_type = "hazptr";
 module_param(torture_type, charp, 0444);
@@ -93,6 +95,24 @@ static DECLARE_COMPLETION(r0_held);
 static DECLARE_COMPLETION(r0_release);
 static bool hot_hammer_active;
 
+/* Fairness rotation scenario: two stuck addresses whose holders
+ * never release during the observation window.  Two sync waiters
+ * are launched; the drain fairness cap must rotate the drain
+ * between the two addresses instead of monopolizing one.
+ */
+static int fair_target_a;
+static int fair_target_b;
+static void *const fair_addr[2] = { &fair_target_a, &fair_target_b };
+static struct task_struct *fair_holder_tasks[2];
+static struct task_struct *fair_stage_task;
+static struct completion fair_held[2];
+static struct completion fair_release[2];
+static struct completion fair_released[2];
+static struct completion fair_sync_done[2];
+static atomic_t fair_live_syncs;
+static atomic_t n_fair_rounds;
+static atomic_t n_fair_timeout;
+
 #define HAZPTR_TORTURE_PIPE_LEN 10
 
 // Update-side data structure used to check RCU readers.
@@ -707,10 +727,13 @@ hazptr_torture_stats_print(void)
 		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_defer),
 		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_undefer),
 		atomic_read(&n_hazptr_torture_wq_churn));
-	pr_cont(" hotsync: %d hotstarve: %d hotseq: %d",
+	pr_cont(" hotsync: %d hotstarve: %d hotseq: %d"
+		" fairrounds: %d fairtimeout: %d",
 		atomic_read(&n_hot_syncs),
 		atomic_read(&n_hot_starves),
-		atomic_read(&n_hot_in_seq));
+		atomic_read(&n_hot_in_seq),
+		atomic_read(&n_fair_rounds),
+		atomic_read(&n_fair_timeout));
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (i > 1) {
@@ -1127,6 +1150,152 @@ static int hazptr_torture_hot_stage(void *unused)
 	return 0;
 }
 
+/*
+ * Fairness rotation scenario --- two stuck addresses, two
+ * perpetual holders, two sync waiters.
+ *
+ *   fair_holder_tasks[2]  each acquires its own address and holds
+ *                         it until commanded to release; the hold
+ *                         spans the whole observation window.
+ *   fair_stage_task       orchestrator: waits for both holds,
+ *                         launches both sync waiters (address A
+ *                         first so it is at the head of the
+ *                         scanning list), waits out the window,
+ *                         then releases both holders and requires
+ *                         both syncs to drain.
+ *
+ * The window must be long enough for the drain to engage (~100
+ * scan cycles) and hit the fairness cap (HAZPTR_DRAIN_MAX_CYCLES,
+ * default 1000) on address A, after which address B's waiter --
+ * whose re-engage counter kept growing -- gets the next drain
+ * turn.  Rotation evidence is read from the kernel drain logs
+ * ("drain engaged" for both addresses, at least one "drain
+ * disengaged (fairness-cap").
+ *
+ * The module verdict (n_hazptr_torture_error) does not depend on
+ * rotation: it fails only if a sync fails to drain after both
+ * holders released (a forward-progress regression).
+ */
+static int hazptr_torture_fair_holder(void *arg)
+{
+	long i = (long)arg;
+	struct hazptr_ctx ctx;
+	void *p;
+
+	VERBOSE_TOROUT_STRING("fair_holder task started");
+	p = fair_addr[i];
+	(void)hazptr_acquire(&ctx, &p);
+	complete(&fair_held[i]);
+	while (!wait_for_completion_timeout(&fair_release[i], HZ)) {
+		if (torture_must_stop())
+			break;
+	}
+	hazptr_release(&ctx, p);
+	complete(&fair_released[i]);
+	torture_kthread_stopping("fair_holder");
+	return 0;
+}
+
+/* Transient per-round sync kthread.  fair_live_syncs is
+ * incremented by the stage before kthread_run() and decremented
+ * here at exit, so the count covers the full lifetime including
+ * the window between thread creation and first execution.
+ */
+static int hazptr_torture_fair_do_sync(void *arg)
+{
+	long i = (long)arg;
+
+	hazptr_synchronize(fair_addr[i]);
+	complete(&fair_sync_done[i]);
+	atomic_dec(&fair_live_syncs);
+	return 0;
+}
+
+static int hazptr_torture_fair_stage(void *unused)
+{
+	int i;
+
+	VERBOSE_TOROUT_STRING("fair_stage task started");
+
+	while (!torture_must_stop() && !rcu_inkernel_boot_has_ended())
+		schedule_timeout_interruptible(HZ);
+	{
+		bool sync_launched[2] = { false, false };
+
+	/* Wait for both holders to acquire their addresses. */
+	for (i = 0; i < 2; i++) {
+		while (!wait_for_completion_timeout(&fair_held[i], HZ)) {
+			if (torture_must_stop())
+				goto out;
+		}
+	}
+
+	/* Launch both sync waiters; A first so it leads the list. */
+	for (i = 0; i < 2; i++) {
+		struct task_struct *t;
+
+		atomic_inc(&fair_live_syncs);
+		t = kthread_run(hazptr_torture_fair_do_sync, (void *)(long)i,
+				"fair_do_sync");
+		if (IS_ERR(t)) {
+			atomic_dec(&fair_live_syncs);
+			pr_alert("%sfair: sync kthread alloc failed (%d)\n",
+				 TORTURE_FLAG, i);
+			atomic_inc(&n_hazptr_torture_error);
+			goto release;
+		}
+		sync_launched[i] = true;
+	}
+
+	/* Observation window: drains rotate via the fairness cap. */
+	{
+		unsigned long end = jiffies + msecs_to_jiffies(hot_fair_ms);
+
+		while (time_before(jiffies, end) && !torture_must_stop())
+			schedule_timeout_interruptible(HZ);
+	}
+
+	/* Negative observation: holders still hold, so the syncs
+	 * must not have completed during the window.
+	 */
+	for (i = 0; i < 2; i++) {
+		if (completion_done(&fair_sync_done[i])) {
+			pr_alert("%sfair: sync %d completed while holder holds\n",
+				 TORTURE_FLAG, i);
+			atomic_inc(&n_hazptr_torture_error);
+		}
+	}
+
+release:
+	/* Release both holders; the syncs must now drain. */
+	for (i = 0; i < 2; i++)
+		complete(&fair_release[i]);
+	for (i = 0; i < 2; i++) {
+		unsigned long deadline = jiffies + 30 * HZ;
+
+		if (!sync_launched[i])
+			continue;
+		while (!wait_for_completion_timeout(&fair_sync_done[i], HZ)) {
+			if (torture_must_stop() ||
+			    time_after(jiffies, deadline)) {
+				pr_alert("%sfair: sync %d did not drain after release\n",
+					 TORTURE_FLAG, i);
+				atomic_inc(&n_hazptr_torture_error);
+				atomic_inc(&n_fair_timeout);
+				break;
+			}
+		}
+	}
+	atomic_inc(&n_fair_rounds);
+	}
+out:
+	/* Unblock holders even on skip paths. */
+	for (i = 0; i < 2; i++)
+		complete(&fair_release[i]);
+	torture_kthread_stopping("fair_stage");
+	return 0;
+}
+
 static void
 hazptr_torture_cleanup(void)
 {
@@ -1169,6 +1338,24 @@ hazptr_torture_cleanup(void)
 		unregister_trace_hazptr_waiter_enqueue(hot_probe_enqueue, NULL);
 	}
 
+	if (hot_fair_ms > 0) {
+		int wait_ms = 5000;
+
+		for (i = 0; i < 2; i++)
+			complete(&fair_release[i]);
+		for (i = 0; i < 2; i++)
+			torture_stop_kthread(hazptr_torture_fair_holder,
+					     fair_holder_tasks[i]);
+		torture_stop_kthread(hazptr_torture_fair_stage, fair_stage_task);
+		while (atomic_read(&fair_live_syncs) && wait_ms > 0) {
+			schedule_timeout_uninterruptible(msecs_to_jiffies(50));
+			wait_ms -= 50;
+		}
+		if (atomic_read(&fair_live_syncs))
+			pr_alert("%sfair: %d sync kthread(s) still alive at exit\n",
+				 TORTURE_FLAG, atomic_read(&fair_live_syncs));
+	}
+
 	torture_stop_kthread(hazptr_torture_writer, writer_task);
 
 	if (reader_tasks) {
@@ -1378,6 +1565,26 @@ static int __init hazptr_torture_init(void)
 		if (torture_init_error(firsterr))
 			goto unwind;
 	}
+	if (hot_fair_ms > 0) {
+		atomic_set(&fair_live_syncs, 0);
+		atomic_set(&n_fair_rounds, 0);
+		atomic_set(&n_fair_timeout, 0);
+		for (i = 0; i < 2; i++) {
+			init_completion(&fair_held[i]);
+			init_completion(&fair_release[i]);
+			init_completion(&fair_released[i]);
+			init_completion(&fair_sync_done[i]);
+			firsterr = torture_create_kthread(
+				hazptr_torture_fair_holder,
+				(void *)(long)i, fair_holder_tasks[i]);
+			if (torture_init_error(firsterr))
+				goto unwind;
+		}
+		firsterr = torture_create_kthread(hazptr_torture_fair_stage,
+						  NULL, fair_stage_task);
+		if (torture_init_error(firsterr))
+			goto unwind;
+	}
 
 	torture_init_end();
 	return 0;
diff --git a/tools/testing/selftests/rcutorture/bin/hazptr.sh b/tools/testing/selftests/rcutorture/bin/hazptr.sh
index d12735ddfefc..8109cb76bf04 100755
--- a/tools/testing/selftests/rcutorture/bin/hazptr.sh
+++ b/tools/testing/selftests/rcutorture/bin/hazptr.sh
@@ -297,6 +297,57 @@ else
 	nerrs=$((nerrs+1))
 fi
 
+# FAIRNESS: drain rotation between two stuck addresses.  The
+# module verdict covers forward progress (syncs drain after
+# release); rotation itself is observed from the kernel drain
+# logs.
+
+echo "--- hazptr FAIRNESS (drain rotation) ---"
+if run_kvm fairness FAIRNESS "$cpus" "" "50s"
+then
+	resdir="$RCUTORTURE/res/$ds/fairness/FAIRNESS"
+	console="$resdir/console.log"
+	fair_err=""
+	if ! test -f "$console"
+	then
+		echo "Missing console.log for FAIRNESS" > "$RCUTORTURE/res/$ds/fairness/kvm.sh.err"
+		fair_err=1
+	elif ! grep -q "End of test: SUCCESS" "$console"
+	then
+		echo "FAIRNESS: module verdict not SUCCESS" > "$resdir/kvm.sh.err"
+		fair_err=1
+	elif ! grep -q "fair_stage task started" "$console"
+	then
+		echo "FAIRNESS: scenario did not run" > "$resdir/kvm.sh.err"
+		fair_err=1
+	elif grep -q "fair: sync .* did not drain" "$console"
+	then
+		echo "FAIRNESS: sync failed to drain after release" > "$resdir/kvm.sh.err"
+		fair_err=1
+	fi
+	if [ -z "$fair_err" ]
+	then
+		engages=$(grep -o "drain engaged for [0-9a-f]*" "$console" | sort -u | wc -l)
+		caps=$(grep -c "drain disengaged (fairness-cap" "$console")
+		if test "$engages" -ge 2 -a "$caps" -ge 1
+		then
+			echo "FAIRNESS: drain rotated between $engages addresses, $caps fairness-cap disengage(s)"
+		elif test "$caps" -ge 1
+		then
+			echo "FAIRNESS note: fairness-cap hit but only $engages address engaged (window may be short)" > "$resdir/kvm.sh.note"
+		else
+			echo "FAIRNESS note: no fairness-cap observed (window too short for HZ; consider larger hot_fair_ms)" > "$resdir/kvm.sh.note"
+		fi
+	fi
+	if [ -n "$fair_err" ]
+	then
+		nerrs=$((nerrs+1))
+	fi
+else
+	nerrs=$((nerrs+1))
+fi
+echo
+
 # CPU scaling: optionally test at multiple CPU counts
 
 if test "$allcpus" -ne 0
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
index b3f6137ce8ab..03ce4940ab4a 100644
--- a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
@@ -8,3 +8,4 @@ CPU128
 CPU256
 HOTADDR
 LONGHOLD
+FAIRNESS
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/FAIRNESS b/tools/testing/selftests/rcutorture/configs/hazptr/FAIRNESS
new file mode 100644
index 000000000000..b81b57307036
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/FAIRNESS
@@ -0,0 +1,19 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=16
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=y
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
+CONFIG_HAZPTR_STALL_DETECTOR=y
+CONFIG_HAZPTR_STALL_TIMEOUT=60000
+CONFIG_HAZPTR_DRAIN_ASSIST=y
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/FAIRNESS.boot b/tools/testing/selftests/rcutorture/configs/hazptr/FAIRNESS.boot
new file mode 100644
index 000000000000..ef54cbfc5b50
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/FAIRNESS.boot
@@ -0,0 +1 @@
+hazptrtorture.nreaders=0 hazptrtorture.nwriters=0 hazptrtorture.hot_fair_ms=30000 hazptrtorture.shutdown_secs=45
-- 
2.43.0

