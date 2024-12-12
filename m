Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0120A199948;
	Thu, 12 Dec 2024 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029401; cv=none; b=G0yIjt/zqizdU/cXel1kBB72yEPCeAai+wLq281G8IgtpOVT0HnxG9ZEIssP1RQMLIsxhhrdXR0oQrGewuSxryuVZWcsS2qu35xhFX6emRgSKJUWcumQQJdfkfXLfmiYzt2+4Kkgvs88+nPo6SecBb0DibnhCWGcd3TRZNDzvRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029401; c=relaxed/simple;
	bh=jrsGkfPXZvC+aggfCdY5/hb5MNoGMJjtmssOpwq9cIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+M3zT8akILthC8cEDbHrgzK2kgbNNx3EjWivFOcBMHVgr2eiPn8zZbYW2xOjuh+3vzn81yU22zWnYBLXbZ4MvZt+fhSH69H9JafmZiK62aVa4ldaUwBnp3cPp/Nf3PhVjZPct4Wi/IaG/82qDPtZtXlwsGp8FqvJm1vV/EHGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liv2wPY3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liv2wPY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9F8C4CEF1;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=jrsGkfPXZvC+aggfCdY5/hb5MNoGMJjtmssOpwq9cIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liv2wPY3w0EUp+Qgh8bBDIdJhEs7+vU46sAsK85/UtAAEyGjnYo1AtN00OH5BkXJI
	 c0OtgF6FdvQl+1/Gw76jmloZNsUGZffPgv9PHarchWGDoosrMPaRRb3kqIWNJeOe7G
	 9Wgo6lfUZ6gFGRzBELCn3pCP7CZClEHWRc4mmpaNemeTeVRMpwd2EI6CGUXaWbsFIV
	 dblrqHX+Ba3WkrSAuEUoyds4sK+lqGna2zxd53WjzkB6je0Wvs0etGT/2ac5jGBzDX
	 ntj93Mz9950VCrIFIuOH/uLdjYLdB4MMoV8hZvlqiMKVusmBu0WEy4B06PN9rM44ii
	 XrviZ2lEpqgeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DDF53CE15A3; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 16/18] rcutorture: Read CPU ID for decoration protected by both reader types
Date: Thu, 12 Dec 2024 10:49:55 -0800
Message-Id: <20241212184957.2127441-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, rcutorture_one_extend() reads the CPU ID before making any
change to the type of RCU reader.  This can be confusing because the
properties of the code from which the CPU ID is read are not that of
the reader segment that this same CPU ID is listed with.

This commit therefore causes rcutorture_one_extend() to read the CPU
ID just after the new protections have been added, but before the old
protections have been removed.  With this change in place, all of the
protections of a given reader segment apply from the reading of one CPU ID
to the reading of the next.  This change therefore also allows a single
read of the CPU ID to work for both the old and the new reader segment.
And this dual use of a single read of the CPU ID avoids inflicting any
additional to heisenbugs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 70c27bd67be1e..ab354bb7f1b68 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -271,12 +271,12 @@ struct rt_read_seg {
 	unsigned long rt_delay_us;
 	bool rt_preempted;
 	int rt_cpu;
+	int rt_end_cpu;
 };
 static int err_segs_recorded;
 static struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
 static int rt_read_nsegs;
 static int rt_read_preempted;
-static int rt_last_cpu;
 
 static const char *rcu_torture_writer_state_getname(void)
 {
@@ -1922,6 +1922,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 				  struct torture_random_state *trsp,
 				  struct rt_read_seg *rtrsp)
 {
+	bool first;
 	unsigned long flags;
 	int idxnew1 = -1;
 	int idxnew2 = -1;
@@ -1930,12 +1931,11 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 	int statesnew = ~*readstate & newstate;
 	int statesold = *readstate & ~newstate;
 
+	first = idxold1 == 0;
 	WARN_ON_ONCE(idxold2 < 0);
 	WARN_ON_ONCE(idxold2 & ~RCUTORTURE_RDR_ALLBITS);
 	rcutorture_one_extend_check("before change", idxold1, statesnew, statesold, insoftirq);
 	rtrsp->rt_readstate = newstate;
-	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU))
-		rtrsp->rt_cpu = raw_smp_processor_id();
 
 	/* First, put new protection in place to avoid critical-section gap. */
 	if (statesnew & RCUTORTURE_RDR_BH)
@@ -1957,6 +1957,14 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 	rcutorture_one_extend_check("during change",
 				    idxold1 | statesnew, statesnew, statesold, insoftirq);
 
+	// Sample CPU under both sets of protections to reduce confusion.
+	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)) {
+		int cpu = raw_smp_processor_id();
+		rtrsp->rt_cpu = cpu;
+		if (!first)
+			rtrsp[-1].rt_end_cpu = cpu;
+	}
+
 	/*
 	 * Next, remove old protection, in decreasing order of strength
 	 * to avoid unlock paths that aren't safe in the stronger
@@ -2178,8 +2186,6 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	}
 	if (cur_ops->reader_blocked)
 		preempted = cur_ops->reader_blocked();
-	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU))
-		rt_last_cpu = raw_smp_processor_id();
 	rcutorture_one_extend(&readstate, 0, myid < 0, trsp, rtrsp);
 	WARN_ON_ONCE(readstate);
 	// This next splat is expected behavior if leakpointer, especially
@@ -3634,8 +3640,13 @@ rcu_torture_cleanup(void)
 					err_segs[i].rt_delay_jiffies);
 				firsttime = 0;
 			}
-			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU))
-				pr_cont(" CPU %-2d", err_segs[i].rt_cpu);
+			if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)) {
+				pr_cont(" CPU %2d", err_segs[i].rt_cpu);
+				if (err_segs[i].rt_cpu != err_segs[i].rt_end_cpu)
+					pr_cont("->%-2d", err_segs[i].rt_end_cpu);
+				else
+					pr_cont(" ...");
+			}
 			if (err_segs[i].rt_delay_ms != 0) {
 				pr_cont(" %s%ldms", firsttime ? "" : "+",
 					err_segs[i].rt_delay_ms);
@@ -3666,8 +3677,6 @@ rcu_torture_cleanup(void)
 		}
 		if (rt_read_preempted)
 			pr_alert("\tReader was preempted.\n");
-		if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU))
-			pr_alert("\tReader last ran on CPU %d.\n", rt_last_cpu);
 	}
 	if (atomic_read(&n_rcu_torture_error) || n_rcu_torture_barrier_error)
 		rcu_torture_print_module_parms(cur_ops, "End of test: FAILURE");
-- 
2.40.1

