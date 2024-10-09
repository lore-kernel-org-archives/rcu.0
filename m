Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0421E1A1B;
	Wed,  9 Oct 2024 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478327; cv=none; b=LY5SYw5yAkJP/psIWb322BKn9A0IKG5V2hKI21wd17t2IzetbgW4M7LAz0KP4b7qLAbQcuwfoGyDEVeiAEFQ9or9RRisU5cYJuJHCrSgJ8FAOTsPgGfR4b7zi4UEa/mvuh9Y5eIDXH7kOSDKxhnTjPYQBLekDIyPAUJmWFBQ0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478327; c=relaxed/simple;
	bh=A1yHtMIzh/btwkSjs1f15zt7Ryx3LfuM9GWls63if/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iLuFwzk9tLYuLTclmmHZQ9qo6rQQcOkWtPdW+u3zeSy/5MilF27+NpT1jwwe83Ie+0yKjeTWEgw1pKGrY7+1bS54oLcVi8l8Ua+KHEpchTqI4TkUKYBYP7BFW+cgA1k7K6iHrYhPil27CLAY65RQDkK9HdvcMbBXQihaY1NdTfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUXoabhT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUXoabhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391B3C4CEC5;
	Wed,  9 Oct 2024 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478327;
	bh=A1yHtMIzh/btwkSjs1f15zt7Ryx3LfuM9GWls63if/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUXoabhTLLWNdcfYOPlIRFhUvh8ZOscsUNJ2KZ28Otiv1LprsJwHDIUGz8J+egJ8Z
	 t43OVZztbRs+RRQhUizvS34DIb7Ey5vyr8C5QFWr3dqg+DQVmtM5wpyEmx1zQ15PwD
	 XqRQrhiruR49Wy9skGtt0R7hJIQjJ23snTWvWg4PAShWuhca4zjDGe7o5P2qZgLyso
	 Fiw1q647bIt6BNNtkeVimnt0IxjU8jnSyFBnz+ie087ba6h+1BLPl3bnJsZmWJRqVR
	 mac+ZgzUtwdwMLtBAVhdMWLQf9SjxjDgumnEkH6fbYxr72USe6JK3CEhYzEZFWRTWv
	 086WhOrIoEb4g==
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
Subject: [PATCH v2 05/10] rcu/tasks: Consider idle tasks not running on CPU as non-holdouts
Date: Wed,  9 Oct 2024 18:21:22 +0530
Message-Id: <20241009125127.18902-6-neeraj.upadhyay@kernel.org>
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

As idle tasks cannot be non-voluntary preempted, idle tasks which
are not running on CPU are not in RCU-tasks read side critical
section. So, remove them for holdout tasks for RCU-tasks.

Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tasks.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b794deeaf6d8..9523aff6cdae 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -983,6 +983,15 @@ static bool rcu_idle_task_is_holdout(struct task_struct *t, int cpu)
 	if (!rcu_cpu_online(cpu))
 		return false;
 
+	/*
+	 * As idle tasks cannot be involuntary preempted, non-running idle tasks
+	 * are not in RCU-tasks critical section.
+	 * synchronize_rcu() calls in rcu_tasks_pregp_step() and rcu_tasks_postgp()
+	 * ensure that all ->on_cpu transitions are complete.
+	 */
+	if (!t->on_cpu)
+		return false;
+
 	return true;
 }
 #else /* #ifdef CONFIG_SMP */
-- 
2.40.1

