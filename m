Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F21A2540;
	Wed,  9 Oct 2024 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478322; cv=none; b=AcWy5sz1/nc0+afsLxNER1Nrdcg/0AxgOvyG5/VBPRdu8WaGfoc7UMJAcUSd+JJwbkOtEzRh6IeAwDm+HWZjsdcUc5BzTooV+vI4X+OXBgn9d/k5vZcofS7F6ZWHd3P1gPornGYtf6RgDp5F06bkzVGFXD9Wvle6lzfWxei/F7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478322; c=relaxed/simple;
	bh=+KNwfAeGfopxST2YcyDd++R2YqnV7Z//j5Y+S4cdFGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bDIi15QzUgpQgpVjRmxJtaClvmUeq5DDBhSk7GGBkD5pwKQjo6T6tHHnsvgdzYxR6t02s16rLohJB9Rf/vlLq/+NzAe5/U5KpaTAyvWefg3XMdNtg/VgRX7UU4ZwGZ10VkVbTDATTzVQ6lM0nX/ZL08wvnXzME7V9R5kulgddy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKfsG7XJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKfsG7XJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3C2C4CEC5;
	Wed,  9 Oct 2024 12:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478322;
	bh=+KNwfAeGfopxST2YcyDd++R2YqnV7Z//j5Y+S4cdFGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKfsG7XJH/N7e+l+FLANgLva7Ppn0kXak1ESbL/pKgXvCLqlIuMmvYlQvCxPtyqzK
	 rin8pYgxFASnk/9259KLAmMUct/Q9DsBu1/SiQg/a5nIlm1pgpSdGSguSZsgw0yab7
	 RuGSLGT6HtQLrCwR+Vya9mWDUgOzE6c1uiuOZRw6mUQEIuYIp2zGKM4omLr+l6yhCd
	 h15QBDL0FUd2gVmjyM26Yy1cADtpVpNYEbbnbBlxlvWubaDcyPJSp+5ozz71iPScYJ
	 XyT01xs5i8ADF9KhnPmV3KkC1d7KtMkOPWHj6n4bueLMW1eK5DD72Gr3bLjZhP9fNm
	 hTbTvWxHWWpjw==
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
Subject: [PATCH v2 04/10] rcu/tasks: Create rcu_idle_task_is_holdout() definition for !SMP
Date: Wed,  9 Oct 2024 18:21:21 +0530
Message-Id: <20241009125127.18902-5-neeraj.upadhyay@kernel.org>
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

rcu_idle_task_is_holdout() is called in rcu_tasks_kthread() context.
As idle tasks cannot be non-voluntary preempted, non-running idle tasks
are not in RCU-tasks critical section. So, idle task is not a RCU-tasks
holdout task on !SMP (which also covers TINY_RCU).

Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tasks.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 56015ced3f37..b794deeaf6d8 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -976,6 +976,7 @@ static void rcu_tasks_pregp_step(struct list_head *hop)
 	synchronize_rcu();
 }
 
+#ifdef CONFIG_SMP
 static bool rcu_idle_task_is_holdout(struct task_struct *t, int cpu)
 {
 	/* Idle tasks on offline CPUs are RCU-tasks quiescent states. */
@@ -984,6 +985,17 @@ static bool rcu_idle_task_is_holdout(struct task_struct *t, int cpu)
 
 	return true;
 }
+#else /* #ifdef CONFIG_SMP */
+static inline bool rcu_idle_task_is_holdout(struct task_struct *t, int cpu)
+{
+	/*
+	 * rcu_idle_task_is_holdout() is called in rcu_tasks_kthread()
+	 * context. Idle thread would have done a voluntary context
+	 * switch.
+	 */
+	return false;
+}
+#endif
 
 /* Check for quiescent states since the pregp's synchronize_rcu() */
 static bool rcu_tasks_is_holdout(struct task_struct *t)
-- 
2.40.1

