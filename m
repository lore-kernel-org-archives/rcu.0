Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361D1FF7C5;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161422; cv=none; b=EOXCQrMBgxgzuYyn3RLyYN3LxesjaTw1bIJ4U38XAEgs7uWRTe0QtL521RlThLytl21EQqchBfjzLo9Wu4q/ZWr0XCt6BtucTsN7/XkzKeIw2NhR25Fe7cK6yW5+nSNuwt0OCkM14JMXcKq67/fMEC3EaQwk9gVMrdnhwBPvf3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161422; c=relaxed/simple;
	bh=TJZl+inXya+bKzsV0ZvGX1qSGLWmt0PKu81BCP+l2Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gsKbbefhufktFbqzGWRu8LtBoJwMkv0LUUgNylGHNjyEOjZiGJCHFYw2Swira+Oa63vob4l4nuhMlxgsLQsDw/RRdPcKv+CErki1HeTdLO+5PpepHiVaB5jcca2Q9dVgDrQtAR3DogZAQPx2+YC7zRwcQ8fiM+Jz5z2I9rVHNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdK9b+22; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdK9b+22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB691F00A3A;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161421;
	bh=s2pp7xMhQIRb1HuLwmqNhcY2hIgp6WI9Kbpk3dFfE+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BdK9b+228NLxwTucAr+bDewC7s5RGoBfNYkEGRwAXlTXc/JH2qA/lrNDGi4oal+KN
	 i0a5eqXb45L1CvNb3BMZI9MvoqOfUsSQ6eFSq0LP3nI8uTdqMOzA/PglDVrfl8dvO9
	 D4aqwUs10MXFiggjvoM3reYaLHGFi000P8DNP20nk8R3H5VtaeOyKHcqY1yTDO36KX
	 0yu05UgyJuBPVCE3B9mni28AGtNxg7M1cKDHjvSfMpFyvFTIviFdw8EYT2csBDyLkk
	 FWixAVD4WpT377Ncu0GrRv3KXkQH8o5Rqew6xNslcTINsFrzHOkfmzRwmvw2D/cq+9
	 S2ZVrJbCb62Ug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EAC2ACE0B87; Wed, 15 Jul 2026 17:23:40 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 02/10] rcu: Use task_state_to_char() in stall-warning prints
Date: Wed, 15 Jul 2026 17:23:31 -0700
Message-Id: <20260716002339.11717-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
References: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

RCU stall warnings currently print task states as raw hexadecimal
values, requiring developers to manually decode them.

Use task_state_to_char() so that stall warnings show the same symbolic
task-state representation used elsewhere in the kernel.

For example:
	->state=0x402  becomes  ->state=I
	->state=0x0    becomes  ->state=R
	->state=0x2    becomes  ->state=D

This improves readability while preserving the underlying diagnostic
information.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Co-developed-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index cf7ae51cba4033..45b9856ccd2b23 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -573,13 +573,13 @@ static void rcu_check_gp_kthread_starvation(void)
 
 	if (rcu_is_gp_kthread_starving(&j)) {
 		cpu = gpk ? task_cpu(gpk) : -1;
-		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x ->cpu=%d\n",
+		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%c ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
 		       data_race(READ_ONCE(rcu_state.gp_flags)),
 		       gp_state_getname(rcu_state.gp_state),
 		       data_race(READ_ONCE(rcu_state.gp_state)),
-		       gpk ? data_race(READ_ONCE(gpk->__state)) : ~0, cpu);
+		       gpk ? task_state_to_char(gpk) : '?', cpu);
 		if (gpk) {
 			struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
@@ -616,12 +616,12 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 	    time_after(jiffies, jiffies_fqs + RCU_STALL_MIGHT_MIN) &&
 	    gpk && !READ_ONCE(gpk->on_rq)) {
 		cpu = task_cpu(gpk);
-		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x\n",
+		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%c\n",
 		       rcu_state.name, (jiffies - jiffies_fqs),
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
 		       data_race(READ_ONCE(rcu_state.gp_flags)), // Diagnostic read
 		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
-		       data_race(READ_ONCE(gpk->__state)));
+		       task_state_to_char(gpk));
 		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
 		       cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
 	}
@@ -948,10 +948,10 @@ void show_rcu_gp_kthreads(void)
 	jr = j - data_race(READ_ONCE(rcu_state.gp_req_activity));
 	js = j - data_race(READ_ONCE(rcu_state.gp_start));
 	jw = j - data_race(READ_ONCE(rcu_state.gp_wake_time));
-	pr_info("%s: wait state: %s(%d) ->state: %#x ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_max %lu ->gp_flags %#x\n",
+	pr_info("%s: wait state: %s(%d) ->state: %c ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_max %lu ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
 		data_race(READ_ONCE(rcu_state.gp_state)),
-		t ? data_race(READ_ONCE(t->__state)) : 0x1ffff, t ? t->rt_priority : 0xffU,
+		t ? task_state_to_char(t) : '?', t ? t->rt_priority : 0xffU,
 		js, ja, jr, jw, (long)data_race(READ_ONCE(rcu_state.gp_wake_seq)),
 		(long)data_race(READ_ONCE(rcu_state.gp_seq)),
 		(long)data_race(READ_ONCE(rcu_get_root()->gp_seq_needed)),
-- 
2.40.1

