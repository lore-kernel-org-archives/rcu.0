Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36177111;
	Fri, 16 Aug 2024 04:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723783198; cv=none; b=kCNixKUREk88vpQJVuC4jr800P6zby/UyHiP+O7FyamlD8rnaAHaBJL7jXv6sObNWUMLTELRFaM+GjdP+f8tQYjTdHEVgMTXv8vsFVwzDAPF3XIRzLtzV2O7j5YNmGhMla/4CpYgowMkUYBvZrAANKlyGvdYjFFDj4I6qeJvUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723783198; c=relaxed/simple;
	bh=EQ7mddlc0hf+YaM1u17yUZvNq42jgh8Dic8l77MpinI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jB90XMA4HOA+VVAuMTpq4+cjFdvPY5DmvOybYqjyl2B40Kws3TmJdCh3/pOnQMwOzQto4YxN7yyyU6U/I2PPvOy5UOEZvnEVzzm5tWCkRXaFcbHN/0NjlaC7RQiWOBiGiAS425rof4GY2H28zp1SIshTuzw3wVxEJR1qeIgl9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4VWccQx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4VWccQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012DAC32782;
	Fri, 16 Aug 2024 04:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723783196;
	bh=EQ7mddlc0hf+YaM1u17yUZvNq42jgh8Dic8l77MpinI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4VWccQxvsZoXHT7JlT10k6GxP55bWAnR5Uf0t0vDxdMUWltkNnkDEL2akWGX+HSn
	 KnGIuLkxUFa1k3Y1GxJ3WVLd/sK/2qbXhiYmy0+cpmnAuxAOGl9CjvG1VyXtRVN5BY
	 HUCo1XXN3HAtVBfy5l9hTUhWR+7D6YG8X8Ayc+BnXaweFa+BwM9Pys7ztwWiHJ69UJ
	 7/n+dtuxbeIe5BiYVUxjK2+2YNukcgPYgIUE+zkkPivRPlhubp0esth4r0UjgbeiFU
	 xWnReSUXlDipjyoHmBRPJTRsky8luwpmX7nuRcZ1XMkKOhFtXLOhPmOzRDzbgSYVfJ
	 6WLVh+D9hYpEg==
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
Subject: [PATCH rcu 1/4] locking/csd_lock: Print large numbers as negatives
Date: Fri, 16 Aug 2024 10:09:14 +0530
Message-Id: <20240816043917.26537-1-neeraj.upadhyay@kernel.org>
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
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index aaffecdad319..e87953729230 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -249,8 +249,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
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

