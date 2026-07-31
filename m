Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A402652A2;
	Fri, 31 Jul 2026 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459716; cv=none; b=osQfszL0RJnYDhCWD+LJiP374MKajKJf1iOcc/A6u+eeCUtPjCmL1BIib5nzPlYgBDUvKz5z89Q5MTJcLzGsd0Qdwcq1fex+fQbwZ4FI3QSbthRMglbp4s3a6Lpi4sSVroXBR4nvvSt4A73iV3rneXEXuem9BnuSJpIbNUa3Q3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459716; c=relaxed/simple;
	bh=TJZl+inXya+bKzsV0ZvGX1qSGLWmt0PKu81BCP+l2Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5ogCeetI7OqjJO6Pf5A7oN3M9Kvf4ReVfjXmIaVibbPcm/O4Bt6l8grCLYdO6l/E//AkIENzYEkMeLq31PtfUAQI5WUamHSpkXckDCoQxS5F3HbuZUVXMkigOpHaiMITHj5I9zNzMtsVoiOI9zZS4QzLhn0T1SZvt4AGitPl14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVosythP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVosythP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEAC1F000E9;
	Fri, 31 Jul 2026 01:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459714;
	bh=s2pp7xMhQIRb1HuLwmqNhcY2hIgp6WI9Kbpk3dFfE+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oVosythPGk7D2HpLk3M91yT0ICL70zbyO4F6yyIPtG6/nsTrOAu0pV2A/2yZnHqLa
	 CCgLcow6lgR7lmK4XhGvto5ZKmUA0sTbfuVnjAeGyPWbsl8ICxtS5eqKpceDIea1Zs
	 KklzvTTlKy1y70BcCTHCi+DA2ig8M3skfN4LIFPY0RFQst8rAAVyFEuOQycafgtj/e
	 ZKpPhUpgg1B9S3b8swzYIYbGb9SfeIgD6rPW4qZZNPSOxJpLYfsRgKntJeNtOT6qcG
	 VMxDuWyDIgcDpmLUQou+bzZUjxi5mRdsaEmo/7ifr+Kg52ToCBJ7pZudnevyXQb2sU
	 Dcqrl4KQb9gew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A3370CE0F69; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 01/16] rcu: Use task_state_to_char() in stall-warning prints
Date: Thu, 30 Jul 2026 18:01:38 -0700
Message-Id: <20260731010153.3531313-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
References: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
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

