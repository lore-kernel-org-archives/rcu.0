Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278D01A2C19;
	Wed,  9 Oct 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478347; cv=none; b=m7rQj2jeSCQJ+8zcoRH3uqxW7k8FpEh51MehQCnEExYhpk8HJjF5F4/QPx+1lwrW/k/bjbsffFDmK9tw8E9r8TMIUMFuIdWN4yLtXVSsKXJ3ikoEddQX/3M7TtWWYu38Z7XnW9KfVOPOZKr8pZ5WihvMv8S/VZrSDEggAjvA5Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478347; c=relaxed/simple;
	bh=lOXgRfOyLIl7elkNZsxeg0qekVV+z+V29DqLUPqFN78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wkanq1kYIY1cQHh5qkw7+5Qxmk0w3I8yCQhumXfeg73wA4vsE1d4VVc7Gr2YcbggtRy7ZayO+vFpsd+Hr5SJdna/Lqze3S8g4esPom1uBE1l0KiGi8MHnS4YRXcQoN9cYOgrAspt63LuVngb0xSQcMsKfGN+jXAvU8xl/Nw7gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2ZxVGxf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2ZxVGxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9566C4CEC5;
	Wed,  9 Oct 2024 12:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478346;
	bh=lOXgRfOyLIl7elkNZsxeg0qekVV+z+V29DqLUPqFN78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2ZxVGxfr/4AK7Agl9MI+e69zrPCZb4KtzRhkDgzTrYKQ3K5Z1h9lZNmmfZx08Feo
	 Vm49v6S2GgwaMl/SHf9zmG218tjoeJiodloI8duuCmI2Z55Lj00eZCl6L4w5hD3eMO
	 /wEzKBGJmkg5vCNpvJN2yZY6UG4yOYcAfr0WJl7q9FzwBP2XDNRK2jly2PU0Ewfu8E
	 GY/ss0KIeBs1We3lEfNwkuiaRLUEg6axGD+kSNsBwQyKBhG9vEum7C8iQcUTPrjA81
	 Klhth8uZ+zPjjBQeewcRFR/la0H2KZxtXjV1USkbXZyhtpuoLSgeWME8epe893eLj2
	 AbXNuCDN62hkw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joel@joelfernandes.org,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	peterz@infradead.org,
	neeraj.upadhyay@amd.com,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH v2 09/10] context_tracking: Invoke RCU-tasks enter/exit for NMI context
Date: Wed,  9 Oct 2024 18:21:26 +0530
Message-Id: <20241009125127.18902-10-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
References: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

rcu_task_enter() and rcu_task_exit() are not called on NMI
entry and exit. So, Tasks-RCU-Rude grace period wait is required to
ensure that NMI handlers have entered/exited into Tasks-RCU eqs.
For architectures which do not require Tasks-RCU-Rude (as the code
sections where RCU is not watching are marked as noinstr), when
those architectures switch to not using Tasks-RCU-Rude, NMI handlers
task exit to eqs will need to be handled correctly for Tasks-RCU holdout
tasks running on nohz_full CPUs. As it is safe to call these two
functions from NMI context, remove the in_nmi() check. This ensures
that RCU-tasks entry/exit is marked correctly for NMI handlers.
With this check removed, all callers of ct_kernel_exit_state() and
ct_kernel_enter_state() now also call rcu_task_exit() and
rcu_task_enter() respectively. So, fold rcu_task_exit() and
rcu_task_entry() calls into ct_kernel_exit_state() and
ct_kernel_enter_state().

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/context_tracking.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 938c48952d26..85ced563af23 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -91,6 +91,7 @@ static noinstr void ct_kernel_exit_state(int offset)
 	seq = ct_state_inc(offset);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
+	rcu_task_exit();
 }
 
 /*
@@ -102,6 +103,8 @@ static noinstr void ct_kernel_enter_state(int offset)
 {
 	int seq;
 
+	rcu_task_enter();
+
 	/*
 	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
 	 * and we also must force ordering with the next RCU read-side
@@ -149,7 +152,6 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 	// RCU is watching here ...
 	ct_kernel_exit_state(offset);
 	// ... but is no longer watching here.
-	rcu_task_exit();
 }
 
 /*
@@ -173,7 +175,6 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 		ct->nesting++;
 		return;
 	}
-	rcu_task_enter();
 	// RCU is not watching here ...
 	ct_kernel_enter_state(offset);
 	// ... but is watching here.
@@ -238,9 +239,6 @@ void noinstr ct_nmi_exit(void)
 	// RCU is watching here ...
 	ct_kernel_exit_state(CT_RCU_WATCHING);
 	// ... but is no longer watching here.
-
-	if (!in_nmi())
-		rcu_task_exit();
 }
 
 /**
@@ -273,9 +271,6 @@ void noinstr ct_nmi_enter(void)
 	 */
 	if (!rcu_is_watching_curr_cpu()) {
 
-		if (!in_nmi())
-			rcu_task_enter();
-
 		// RCU is not watching here ...
 		ct_kernel_enter_state(CT_RCU_WATCHING);
 		// ... but is watching here.
-- 
2.40.1

