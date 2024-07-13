Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070513B287;
	Sat, 13 Jul 2024 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889970; cv=none; b=ODyCFYn9qhdtTmUNmKVaUqSDD2YNumlwCgGpR+M+iLHT8yhuNjnbECYpEp+5X5A6GHEfcdKr7xGHuVXrhTLCW15j5Lyd7lIKs3Oxcg3GaDRel5sxUm4jfplyaSWD+oMpIzpPgMEPoaDwLGUuk3L8h/K6PcP0KGl9itkqhkIok+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889970; c=relaxed/simple;
	bh=KYBad74cZVInqYWF85EGV9C9g4LucoMsE/dNGXtFggU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAbv4iLS/TnftM/3AYyV+P3TsrUPCeC5cpplkFeVKqp3dVTOlgsdOrxSr9rM4pDVGhAOCY/ULwWoLNRUF4OpixBAv2hpg6h01l75e0zjYq9qx/AR43E1gbdVHJLg+KAJSlMS/jp2Lgx9zwkU8whBwsJBuEXJjTxCLMkcusa3Hrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivG7ua0f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivG7ua0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F9BC32781;
	Sat, 13 Jul 2024 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720889969;
	bh=KYBad74cZVInqYWF85EGV9C9g4LucoMsE/dNGXtFggU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivG7ua0fflJ90aOgBFrUgWD74Fli9Tt2UpLfAAa5BmG38tcX1yzE5dT0+R8fu2o8Q
	 v7wM+vzKoqBt0Gix3uFgjZ7aOkTpjzY2SADh+SlSjjo/H76d+rBGCib/FS4tigubCM
	 WjRwsOBipxMb78kh8kTzJDo43CN+CRuHfh1uT5tWY/nVC5mbl/vzPVL2/k9HC+okQI
	 5Kp4jqK99HflrmHzA4iowWdyzZmgEP3lt9rzq0Iss775MaR2/nfT2qEAtss45A3Z29
	 XHOefIVdkUHIN2fry/uTVYjbq693nsIr8HSmctvU+oT4umRVeY6uyjZBHCwlImIXG5
	 PSJWPtxTsZwgw==
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
	neeraj.upadhyay@kernel.org
Subject: [PATCH  1/3] locking/csd_lock: Print large numbers as negatives
Date: Sat, 13 Jul 2024 22:28:44 +0530
Message-Id: <20240713165846.216174-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240713165642.GA215331@neeraj.linux>
References: <20240713165642.GA215331@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The CSD-lock-hold diagnostics from CONFIG_CSD_LOCK_WAIT_DEBUG are
printed in nanoseconds as unsigned long longs, which is a bit obtuse for
human readers when timing bugs result in negative CSD-lock hold times.
Yes, there are some people to whom it is immediately obvious that
18446744073709551615 is really -1, but for the rest of us...

Therefore, print these numbers as signed long longs, making the negative
hold times immediately apparent.

Reported-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Imran Khan <imran.f.khan@oracle.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..81f7083a53e2 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -248,8 +248,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
 	/* How long since this CSD lock was stuck. */
 	ts_delta = ts2 - ts0;
-	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
-		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
+	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
+		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
 		 cpu, csd->func, csd->info);
 	/*
 	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
-- 
2.40.1

