Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA16292B5B;
	Wed,  9 Jul 2025 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057823; cv=none; b=P60gyfBeDI47sLpvtBTNiFfU4fm/IERU5aSSTgIIxmxbZJwyiw8ZyfTOhavpgb6lC3XWD0d+eJwYp/6sV1rWlNhGfu/aLkVK614kET4h0oumbZ3CFxj8xYUz9lqzPxxntC/uxcJ4HTSKg7RZvyUdBJXP5DOq3/UXYnl425CNoT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057823; c=relaxed/simple;
	bh=rlpZsvOHlInyJAVqjUW/0651NDCFnnRESbttLKrNIQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ODG0aLWCTeDA4AVTR5b0lBEieR3ruev1vIUKLRoQmR+ZiYz80k9NIbzp831GVqr43eIJaMs0XLPxvUfsP5zzKS+SZsYYr9KrpVZbGtN9qVLv2iA2u9Xz28UUsVSJ9K9fKryg3Z6sWwph10vwwDdXGcdkToavcWzfFYj9oHBpXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQhgEej6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQhgEej6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BB6C4CEF4;
	Wed,  9 Jul 2025 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057822;
	bh=rlpZsvOHlInyJAVqjUW/0651NDCFnnRESbttLKrNIQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQhgEej6pJj/OjIKG3QwFHi9giYGcplm+dsG8tPqFePRNHA8N+XRycPHipvlP7vNh
	 G9JdKTBm2pAANWLY9gySFoSI5VVJmliYZ+FK282sv5PNTz3s9MtgSKP2Y5FH4lYskF
	 K68sroxPmT4XbqKZlx0Z9LDOUXCpBJlQEQLCcLV2Q1CCUuzbDT87zf5CmoSDpgIhTv
	 zLUlECTN7CU3c0UAE2tPgJ5s13r/lU/2NteJnGDUhodlhNtRk1rdDZZRdLEoSmTlkP
	 dSuAa6FR5PalpUs4ZOFOs8GowV2Lg7RN/DS0jMeGu1MJseAcxhR7Pb7g6lhfvmaZDy
	 IwP/Pr1H7D+IA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 12/15] rcutorture: Fix rcutorture_one_extend_check() splat in RT kernels
Date: Wed,  9 Jul 2025 16:12:12 +0530
Message-Id: <20250709104215.15562-13-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
References: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang1211@gmail.com>

For built with CONFIG_PREEMPT_RT=y kernels, running rcutorture
tests resulted in the following splat:

[   68.797425] rcutorture_one_extend_check during change: Current 0x1  To add 0x1  To remove 0x0  preempt_count() 0x0
[   68.797533] WARNING: CPU: 2 PID: 512 at kernel/rcu/rcutorture.c:1993 rcutorture_one_extend_check+0x419/0x560 [rcutorture]
[   68.797601] Call Trace:
[   68.797602]  <TASK>
[   68.797619]  ? lockdep_softirqs_off+0xa5/0x160
[   68.797631]  rcutorture_one_extend+0x18e/0xcc0 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
[   68.797646]  ? local_clock+0x19/0x40
[   68.797659]  rcu_torture_one_read+0xf0/0x280 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
[   68.797678]  ? __pfx_rcu_torture_one_read+0x10/0x10 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
[   68.797804]  ? __pfx_rcu_torture_timer+0x10/0x10 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
[   68.797815] rcu-torture: rcu_torture_reader task started
[   68.797824] rcu-torture: Creating rcu_torture_reader task
[   68.797824]  rcu_torture_reader+0x238/0x580 [rcutorture 2466dbd2ff34dbaa36049cb323a80c3306ac997c]
[   68.797836]  ? kvm_sched_clock_read+0x15/0x30

Disable BH does not change the SOFTIRQ corresponding bits in
preempt_count() for RT kernels, this commit therefore use
softirq_count() to check the if BH is disabled.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7a07b2590c27..213f23f20a64 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -471,7 +471,7 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 	    !(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
 		started = cur_ops->get_gp_seq();
 		ts = rcu_trace_clock_local();
-		if (preempt_count() & (SOFTIRQ_MASK | HARDIRQ_MASK))
+		if ((preempt_count() & HARDIRQ_MASK) || softirq_count())
 			longdelay_ms = 5; /* Avoid triggering BH limits. */
 		mdelay(longdelay_ms);
 		rtrsp->rt_delay_ms = longdelay_ms;
@@ -2001,7 +2001,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old)
 		return;
 
 	WARN_ONCE((curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
-		  !(preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
+		  !softirq_count(), ROEC_ARGS);
 	WARN_ONCE((curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
 		  !(preempt_count() & PREEMPT_MASK), ROEC_ARGS);
 	WARN_ONCE(cur_ops->readlock_nesting &&
@@ -2015,7 +2015,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old)
 
 	WARN_ONCE(cur_ops->extendables &&
 		  !(curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
-		  (preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
+		  softirq_count(), ROEC_ARGS);
 
 	/*
 	 * non-preemptible RCU in a preemptible kernel uses preempt_disable()
@@ -2036,6 +2036,9 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old)
 	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
 		mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && softirq_count())
+		mask |= RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
+
 	WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
 		  cur_ops->readlock_nesting() > 0, ROEC_ARGS);
 }
-- 
2.40.1

