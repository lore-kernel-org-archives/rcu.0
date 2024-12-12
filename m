Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC81925AF;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029400; cv=none; b=SoRa3I+3WxFaGc9UcHRqg25MkWBxrYsm0K8xpPlQKfWRDfC+y9dt20uxWooTDerQfk0r3W9VxwZOoDGQyXfwzwPdn7YC17ek/kP9rX2Rl+hzkkpOnWDFFBPwRSP18xL1vCm6S5GtUNH1Sf5iFeXKdIZC3kHXUG7wcvaBN2aztB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029400; c=relaxed/simple;
	bh=6f1bdzkLfN90HspjzqN2gzg8OcwyUn9YF4LnrPbcbsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DWB916ZeZhdNoaJ4hK56MTitK/89TKTcKci7nlz14jNNPE7Fg011eC+odlLI/xrJiugGo80elFbn9wmknVgoQTI0cxBoggLV9yWATi7bKbAAw7WgWyZ1ihjVvxkCqhkuF7qURS2/5xbGK1VRO2B9fuVRVsT726+HyVMinSGzB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tioTpXxy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tioTpXxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753DEC4CEE4;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=6f1bdzkLfN90HspjzqN2gzg8OcwyUn9YF4LnrPbcbsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tioTpXxy9XIyQyOlIpyY7Dis1YsN5Z7KYKRtQSbGBL0v4qpiDarTC1Q3M8i4Ve1H7
	 h6WkOA7SkLH+1jRu5qvVrHac+JGnrH8+Fr62nLNrqDKPhxPbV0OfjL9xs/L5+wtyrz
	 UY0n0FyCht37Mh//gfLs9dDYqfJMf6kArrxeUs1GQzXmY8+/pgqBmxFgsbEvW44EIX
	 5Odw2zAZvYTuOf7XO039sOz8yZ1b+rtgyFW/3xbIk4StvKaNSyCMwKNzzIAplz7onA
	 xAZIuVTE7PMYIqdDNXxtSlw+ashT3xvBNNj0bSQcAErRAlETfgpZH3H80iGmz4PPGK
	 4QUcadFMz4dvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C7E99CE109D; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 08/18] rcutorture: Decorate failing reader segments with last CPU ID
Date: Thu, 12 Dec 2024 10:49:47 -0800
Message-Id: <20241212184957.2127441-8-paulmck@kernel.org>
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

In kernels built with CONFIG_RCU_TORTURE_TEST_LOG_CPU=y, the CPU is
logged at the beginning of each reader segment.  This commit further
logs it at the end of the full set of reader segments in order to show
any migration that might have occurred during the last reader segment.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcutorture.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9b81e21c75d18..61b092a3dc3f3 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -268,6 +268,7 @@ static int err_segs_recorded;
 static struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
 static int rt_read_nsegs;
 static int rt_read_preempted;
+static int rt_last_cpu;
 
 static const char *rcu_torture_writer_state_getname(void)
 {
@@ -2108,6 +2109,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	}
 	if (cur_ops->reader_blocked)
 		preempted = cur_ops->reader_blocked();
+	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU))
+		rt_last_cpu = raw_smp_processor_id();
 	rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
 	WARN_ON_ONCE(readstate);
 	// This next splat is expected behavior if leakpointer, especially
@@ -3580,6 +3583,8 @@ rcu_torture_cleanup(void)
 		}
 		if (rt_read_preempted)
 			pr_alert("\tReader was preempted.\n");
+		if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU))
+			pr_alert("\tReader last ran on CPU %d.\n", rt_last_cpu);
 	}
 	if (atomic_read(&n_rcu_torture_error) || n_rcu_torture_barrier_error)
 		rcu_torture_print_module_parms(cur_ops, "End of test: FAILURE");
-- 
2.40.1

