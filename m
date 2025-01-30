Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5E21F0E4E;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263324; cv=none; b=eqQ0YMZoQDURr4tODkHFJINOPVRHSAj6euk5VRbg7Tf/tMHlvPcasUd3cn7ziBi9eKg1d//GeqX4ZPVlEIIknc6B7QqI0CscAIu3JqiWUFXys5PjtnCOzfTPYoNDHy78YAMV9YsjA531jhSscxBzyUknCuWA2Wxb077C6FvZG+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263324; c=relaxed/simple;
	bh=JtnsE4qtHTaRkqiJLwlk6TcjetiG4zzhIrMVIESdTq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFAqMLmyZ8RJQ/n2bRy0UHkRp72TCRK2LqUxV+2jHLVcRWDECOzl2RqnXttqXnzMWbh0a+/2S0F7xT4BdeIqJDjd4YiECkddcfKzXqSr3sCTq7ELJt34ZutiGqNL6idX5mK5N/p6Enbn+xu8OISvdYNWGvol9PU+du73A75JIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiMzLguD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiMzLguD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36458C4CEF0;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263324;
	bh=JtnsE4qtHTaRkqiJLwlk6TcjetiG4zzhIrMVIESdTq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LiMzLguDUxJtkBR3zVelHzmJOriCJ7K6HqJECyQ9C3s+GIZe04MR6g1FzudtOY76Z
	 QuvpgadXUwlIABiZJpBfOKUlHxQjycBApb/OkwhRnvCJCMm9EkVMop62+3n7F3IeLC
	 vizaKGFiedMDKldMvJGRtCw9xpp88Taygtqpxx15kOIYSqGuM8IXsHlTfJhmVn9sov
	 WhLyKJYEv0+GsTEyOtktL6mqvd3NLfJqTvuavn5tEhMbo8pXD6qZFsUFplJIed9Xuo
	 72RZhOIqlGZo1m5f0FCtX/mdB+CfATZCUN6hwnRIc6TPzlNlX77/P2VezsRadR1pr8
	 4R92ouRvalXGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 939D7CE37E0; Thu, 30 Jan 2025 10:55:23 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu v2] 6/9] osnoise: provide quiescent states
Date: Thu, 30 Jan 2025 10:55:19 -0800
Message-Id: <20250130185522.1652093-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
References: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

To reduce RCU noise for nohz_full configurations, osnoise depends
on cond_resched() providing quiescent states for PREEMPT_RCU=n
configurations. For PREEMPT_RCU=y configurations -- where
cond_resched() is a stub -- we do this by directly calling
rcu_momentary_eqs().

With (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), however, we have a
configuration with (PREEMPTION=y, PREEMPT_RCU=n) where neither
of the above can help.

Handle that by providing an explicit quiescent state here for all
configurations.

As mentioned above this is not needed for non-stubbed cond_resched(),
but, providing a quiescent state here just pulls in one that a future
cond_resched() would provide, so doesn't cause any extra work for
this configuration.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/trace/trace_osnoise.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index b9f96c77527d..2340ffcefb9d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1531,27 +1531,25 @@ static int run_osnoise(void)
 
 		/*
 		 * In some cases, notably when running on a nohz_full CPU with
-		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
-		 * This will eventually cause unwarranted noise as PREEMPT_RCU
-		 * will force preemption as the means of ending the current
-		 * grace period. We avoid this problem by calling
-		 * rcu_momentary_eqs(), which performs a zero duration
-		 * EQS allowing PREEMPT_RCU to end the current grace period.
-		 * This call shouldn't be wrapped inside an RCU critical
-		 * section.
+		 * a stopped tick PREEMPT_RCU or PREEMPT_LAZY have no way to
+		 * account for QSs. This will eventually cause unwarranted
+		 * noise as RCU forces preemption as the means of ending the
+		 * current grace period.  We avoid this by calling
+		 * rcu_momentary_eqs(), which performs a zero duration EQS
+		 * allowing RCU to end the current grace period. This call
+		 * shouldn't be wrapped inside an RCU critical section.
 		 *
-		 * Note that in non PREEMPT_RCU kernels QSs are handled through
-		 * cond_resched()
+		 * Normally QSs for other cases are handled through cond_resched().
+		 * For simplicity, however, we call rcu_momentary_eqs() for all
+		 * configurations here.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
-			if (!disable_irq)
-				local_irq_disable();
+		if (!disable_irq)
+			local_irq_disable();
 
-			rcu_momentary_eqs();
+		rcu_momentary_eqs();
 
-			if (!disable_irq)
-				local_irq_enable();
-		}
+		if (!disable_irq)
+			local_irq_enable();
 
 		/*
 		 * For the non-preemptive kernel config: let threads runs, if
-- 
2.40.1

