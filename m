Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6FC33CD2;
	Fri, 16 Aug 2024 04:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723783210; cv=none; b=P1JPvFb+WGRbYb8pAPSZkjikFEzPpRYoc2HzJ5IS8L2gGesBxC9QZrwVqhN1TepsNVdWghwFRqdYepBzg864StmggLTF9OQMCwnu/95EH3DrYSbMlWgu3v72MF7AabEVcxH8W2xrkybe8EHmKdPEXBUbqklc9r82ft217UKX1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723783210; c=relaxed/simple;
	bh=mlV2aeJQvODcnjObCuPPtD0W0gOiPC0drbmegr+nbl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tUMoH0Pk+2d0mMQhEFLd6TkNFsKvYYrJWq7KYelMCMerz72/5tXToBQEgKP1ujOmTGs/PB38INQW28X9Rx5MzEX6xWjJWToojNRTAStldpdHTUj414CjMyMxZuE68Aa0nqVfHG0sxTnypBXZLESvAgH36hozFnyFcEtBM/0qBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lt1i4s22; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lt1i4s22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12716C4AF0B;
	Fri, 16 Aug 2024 04:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723783210;
	bh=mlV2aeJQvODcnjObCuPPtD0W0gOiPC0drbmegr+nbl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lt1i4s22YAsJqB0QZCGmDithVDGt0yR2qei2DjNEmsqu6U9fuiekb3kU2E6y53ZWi
	 JIF9TqZZBW3ayXD7vFV+HBkwk7uvOa6rOT4WO6ncF8R5ylMSfV+NHGHUXHd+V9P4wS
	 gsv59jsPJd3Pnz6Et8JLPyuCcHjDDImYHDk3kjQicNxUYgJuzzJBw4O/OJYC2M/b/A
	 fczidfRC2wjfSsjIO5n9cTbvOC3AeI/TbTctDUuqHQviHrUZwGcMskbj4meyreKXqV
	 cQRm8w1uauTXk2BQv0CT6FAIo86p27LTGFGeEi9OUld/VUTnwJdDRR9G3Srj7NsCek
	 z8tNpk+1QYTRg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	mingo@kernel.org,
	peterz@infradead.org,
	leobras@redhat.com,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	tglx@linutronix.de
Subject: [PATCH rcu 3/4] locking/csd-lock: Use backoff for repeated reports of same incident
Date: Fri, 16 Aug 2024 10:09:16 +0530
Message-Id: <20240816043917.26537-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816043600.GA25206@neeraj.linux>
References: <20240816043600.GA25206@neeraj.linux>
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
index 202cda4d2a55..b484ee6dcaf6 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -226,7 +226,7 @@ bool csd_lock_is_stuck(void)
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
  * so waiting on other types gets much less information.
  */
-static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
+static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id, unsigned long *nmessages)
 {
 	int cpu = -1;
 	int cpux;
@@ -249,7 +249,9 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 	ts2 = sched_clock();
 	/* How long since we last checked for a stuck CSD lock.*/
 	ts_delta = ts2 - *ts1;
-	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
+	if (likely(ts_delta <= csd_lock_timeout_ns * (*nmessages + 1) *
+			       (!*nmessages ? 1 : (ilog2(num_online_cpus()) / 2 + 1)) ||
+		   csd_lock_timeout_ns == 0))
 		return false;
 
 	firsttime = !*bug_id;
@@ -266,6 +268,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
 		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
 		 cpu, csd->func, csd->info);
+	(*nmessages)++;
 	if (firsttime)
 		atomic_inc(&n_csd_lock_stuck);
 	/*
@@ -306,12 +309,13 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
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

