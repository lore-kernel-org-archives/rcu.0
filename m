Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709CF13B295;
	Wed,  7 Aug 2024 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048527; cv=none; b=FQsS4gx3MgvHX6qDIkvM0/6+8ApRQbJtyII/HLzjsEfXgGY6F+WC+PFpsYFdfLLMFhAmxsZWRE7PdcIr9mBZRQeAmJyPCjHWsE2uG4oNDcTQX+uDStNb9x2EbRQvfdHwJyprgcuklynSYL1oBUN7S3xad8obtEq7pUZ4DFMQ9Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048527; c=relaxed/simple;
	bh=yr3aOHt+uLB+h1sTltMDqgVWCOdkzLLN+vvWT2fjGgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D6Nj73jEPxh9BSWzcu27qiMahi/q1TC8+0gqCWriJXNj0IYTiwg9BvW8wiqt0EYFpCtLVMLNphXwTTKQJtilmO6cu6awbKc3Ct7N+/EHjxPzWeo6nw1nXDtWeu9Hv707HLJ8lvnfiOWWQeVKeUqspeBrkcf5KrJlsC9mBElfdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwHhhQzm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwHhhQzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452CEC32781;
	Wed,  7 Aug 2024 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723048527;
	bh=yr3aOHt+uLB+h1sTltMDqgVWCOdkzLLN+vvWT2fjGgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PwHhhQzmMKo2ImYm5LAaZ/pZqaRuKGstAg6Jm6u4BZurz+rHsz8XEwA/4zlXY9hXw
	 B7kOOC2NE6q616b7EHl+gSXLzMb2FBxvsUyhbR+NoO/lqQcbow0Zqt60YGb6EXkQI1
	 5Tk+jt6v2Zzl2x9ki1qRjwv0zGQu3ozfUFYLLq7CLCdt/tV2pX38jAiLdK9agQxrr8
	 PfEysBMwNenuA33FXwbtjTF2qmSMP7sIqZAtdLCsvwFbpG4JFrPfph637uxI6aGbmp
	 yrmHS1Uc1HnwsIC7GrYxenGbGGKvFgSnxmqc1nnZjEgq/A3b8HeMi4MknvUz3HdanN
	 2xBola/OlsnPA==
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
	neeraj.iitr10@gmail.com,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH 2/2] context_tracking: Invoke Tasks-RCU enter/exit for NMI context
Date: Wed,  7 Aug 2024 22:05:06 +0530
Message-Id: <20240807163506.434885-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240807163506.434885-1-neeraj.upadhyay@kernel.org>
References: <20240807163506.434885-1-neeraj.upadhyay@kernel.org>
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
functions from NMI context, remove the in_nmi() check to ensure that
Tasks-RCU entry/exit is marked correctly for NMI handlers.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/context_tracking.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 152b485a62db..626dd7a173a5 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -239,8 +239,7 @@ void noinstr ct_nmi_exit(void)
 	ct_kernel_exit_state(CT_RCU_WATCHING);
 	// ... but is no longer watching here.
 
-	if (!in_nmi())
-		rcu_task_exit();
+	rcu_task_exit();
 }
 
 /**
@@ -273,8 +272,7 @@ void noinstr ct_nmi_enter(void)
 	 */
 	if (!rcu_is_watching_curr_cpu()) {
 
-		if (!in_nmi())
-			rcu_task_enter();
+		rcu_task_enter();
 
 		// RCU is not watching here ...
 		ct_kernel_enter_state(CT_RCU_WATCHING);
-- 
2.40.1

