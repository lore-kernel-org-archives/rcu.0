Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E0940D589
	for <rcu@vger.kernel.org>; Thu, 11 Jun 2026 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163183; cv=none; b=sCPWvJFyudZOmy7QrpAPIfVRNbjG88dFgDEkHCl9T8dRpb0emFw6HJbRNIKkio//wWfGkXeusF6/UXFJPN//j1fZMs0HS+wCT/x1ieKj60ew4bfyGZrEV6OJY4s7VdUIN7accU01CsL5/DwVhVuTC25sI1JKU/6/Xa9e5fP836I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163183; c=relaxed/simple;
	bh=b9Tlx25RXuAClYq9rl38boE9K5SpisHZRsSCO0FaWk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EcZxZuVMuQe08hlrltGQRfQ1NFLLnvaUdtPLoQsd2tr1yyT898V0BsydcF4wfGRQta00GKT09Kqp6mpWLWOn6+JSecgril4oE6nQZ3A7W/w7dhao01k3NaOPIQlth/vliDCUSnUXY3eqRsbyIOxBdLaPoaGWwhIm/sLbOCpQrO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LQ58nyqR; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LQ58nyqR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781163178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R1MiBfAMRsEVqkQTwOGbLdBbmKfoWauEQVGgroevOKY=;
	b=LQ58nyqRVya6vT3G83/oprWmS3rp9Ub9WmsgmS+ylJzqF2sDwMaTDwj2kkNO6YaJ0VxmEz
	OX33MhA2NZNWgGXBz3qXyG6XzqeEGr/IQQR2cxniT2JD170g4zsC/5nSrrWeNs1mtfrNWh
	cgK5GkSD7rcl6Zq9gUhbUpv3HRw91r0=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dave@stgolabs.net
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Wang Lian <lianux.mm@gmail.com>
Subject: [PATCH] rcu: Use task_state_to_char() in stall-warning prints
Date: Thu, 11 Jun 2026 15:32:01 +0800
Message-ID: <20260611073201.3889919-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <kunwu.chan@gmail.com>

RCU stall warnings currently print task states as raw hexadecimal
values (e.g., ->state=0x402), forcing developers to manually decode
them from memory.

Replace these raw hex values with the compact, single-letter symbols
already established by sched_show_task():

    ->state=0x402  becomes  ->state=I  (TASK_IDLE)
    ->state=0x0    becomes  ->state=R  (TASK_RUNNING)
    ->state=0x2    becomes  ->state=D  (TASK_UNINTERRUPTIBLE)

Convert five print sites across tree_stall.h, rcutorture.c, and
hazptrtorture.c to use task_state_to_char() instead of the raw
->__state value.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Co-developed-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Wang Lian <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

---
Based on: linux-rcu repo (dev branch)
URL: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
base-commit: 85bf11e84 ("smp: Make CSD lock acquisition atomic for debug mode")
---
 kernel/rcu/hazptrtorture.c |  4 ++--
 kernel/rcu/rcutorture.c    |  4 ++--
 kernel/rcu/tree_stall.h    | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 0da0a4606..19ea479c9 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -497,10 +497,10 @@ hazptr_torture_stats_print(void)
 		unsigned long __maybe_unused gp_seq = 0;
 
 		wtp = READ_ONCE(writer_task);
-		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
+		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %c cpu %d\n",
 			 hazptr_torture_writer_state_getname(),
 			 hazptr_torture_writer_state, gp_seq, flags,
-			 wtp == NULL ? ~0U : wtp->__state,
+			 wtp == NULL ? '?' : task_state_to_char(wtp),
 			 wtp == NULL ? -1 : (int)task_cpu(wtp));
 		if (!splatted && wtp) {
 			sched_show_task(wtp);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index fcb421ced..4d4ebeeea 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3074,10 +3074,10 @@ rcu_torture_stats_print(void)
 		if (cur_ops->get_gp_data)
 			cur_ops->get_gp_data(&flags, &gp_seq);
 		wtp = READ_ONCE(writer_task);
-		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
+		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %c cpu %d\n",
 			 rcu_torture_writer_state_getname(),
 			 rcu_torture_writer_state, gp_seq, flags,
-			 wtp == NULL ? ~0U : wtp->__state,
+			 wtp == NULL ? '?' : task_state_to_char(wtp),
 			 wtp == NULL ? -1 : (int)task_cpu(wtp));
 		if (!splatted && wtp) {
 			sched_show_task(wtp);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 317ef91b1..7ca434b08 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -596,13 +596,13 @@ static void rcu_check_gp_kthread_starvation(void)
 
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
 
@@ -639,12 +639,12 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
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
@@ -971,10 +971,10 @@ void show_rcu_gp_kthreads(void)
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
2.43.0

