Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26C14F90;
	Mon, 22 Jul 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655480; cv=none; b=cW5O4S/E5lMp4w7oqWNjxefVWjXb7IUTWZKMqZUEtVd4Y2pPO+o7breKn2TbMTvFqDf7AwKDdBCBSZ5D4a0+v4U3On2/xI55IZjImzvoi6uRVVTb9N/qnfdkgsBc/EbVm4RQHjqHzvPn+e70WFkSq3xP9rsDXKhu445KbLqrtKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655480; c=relaxed/simple;
	bh=KbZ0G6tmSn77UgwcV1sEKkUrgKMBPdvgbJK/0kc7aF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJIRTH/StI6NXzDr4VSV2i+aDZ2vOT6iXe0F2rkLEltz60P/iDBYb6w+j65acU7cLi47VAwtnFXhUnE4cD3ps0kKBW5Vawwj/Iw5u/Bg6sVrmrwWVoMrbWNfshkC6vzGTTt6QSYPAV2suPsBA4jTu3Z6eqdZAJu8wzvnnSA4hKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBmv+1Tx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBmv+1Tx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE45C4AF0B;
	Mon, 22 Jul 2024 13:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721655480;
	bh=KbZ0G6tmSn77UgwcV1sEKkUrgKMBPdvgbJK/0kc7aF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBmv+1TxMQYW+7kbUJshAnxB0gSK2IXL7c1CEeINK2BxdctfCy7a+MEJhxZoU4s1n
	 KT9jBGjChnF79+p8/EbrEMZKkpJqMQOMaY7zs+93GZA4dXvGmI8kvRZy7o4IC2bqSa
	 E0DMb55xSDac3crlXMO1g0z2dDKrL3hPNTlniXz7sFew2QYdoHSjsTA0LxFONkvTfk
	 GsmeAYMLvvXOyuFB1Yy53YzLUFB2MtL+JwMh6FIcOxySGpgRvD6nQuo9SP7wevDB08
	 SJDmVEUFFLvdz+dZsmSn1tOxftqLowfrWn8q0yZbtPyNF1p8+VY2OD+yO0q15KPWK5
	 0Nmg9HflFoWVw==
From: neeraj.upadhyay@kernel.org
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	mingo@kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	leobras@redhat.com,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	neeraj.upadhyay@kernel.org,
	tglx@linutronix.de
Subject: [PATCH v2 3/3] locking/csd-lock: Use backoff for repeated reports of same incident
Date: Mon, 22 Jul 2024 19:07:35 +0530
Message-Id: <20240722133735.667161-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240722133559.GA667117@neeraj.linux>
References: <20240722133559.GA667117@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the CSD-lock diagnostics in CONFIG_CSD_LOCK_WAIT_DEBUG=y
kernels are emitted at five-second intervals.  Although this has proven
to be a good time interval for the first diagnostic, if the target CPU
keeps interrupts disabled for way longer than five seconds, the ratio
of useful new information to pointless repetition increases considerably.

Therefore, back off the time period for repeated reports of the same
incident, increasing linearly with the number of reports and logarithmicly
with the number of online CPUs.

[ paulmck: Apply Dan Carpenter feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Imran Khan <imran.f.khan@oracle.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/smp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 9385cc05de53..dfcde438ef63 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -225,7 +225,7 @@ bool csd_lock_is_stuck(void)
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
  * so waiting on other types gets much less information.
  */
-static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
+static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id, unsigned long *nmessages)
 {
 	int cpu = -1;
 	int cpux;
@@ -248,7 +248,9 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 	ts2 = sched_clock();
 	/* How long since we last checked for a stuck CSD lock.*/
 	ts_delta = ts2 - *ts1;
-	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
+	if (likely(ts_delta <= csd_lock_timeout_ns * (*nmessages + 1) *
+			       (!*nmessages ? 1 : (ilog2(num_online_cpus()) / 2 + 1)) ||
+		   csd_lock_timeout_ns == 0))
 		return false;
 
 	firsttime = !*bug_id;
@@ -265,6 +267,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
 		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
 		 cpu, csd->func, csd->info);
+	(*nmessages)++;
 	if (firsttime)
 		atomic_inc(&n_csd_lock_stuck);
 	/*
@@ -305,12 +308,13 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
  */
 static void __csd_lock_wait(call_single_data_t *csd)
 {
+	unsigned long nmessages = 0;
 	int bug_id = 0;
 	u64 ts0, ts1;
 
 	ts1 = ts0 = sched_clock();
 	for (;;) {
-		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
+		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id, &nmessages))
 			break;
 		cpu_relax();
 	}
-- 
2.40.1

