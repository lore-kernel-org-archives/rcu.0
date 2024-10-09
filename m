Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B7191F74;
	Wed,  9 Oct 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478303; cv=none; b=YMXWcc566Ybbkiez/ZC5tCWNy0m70dFnJqCjPmavINCDc6iTxHbwp8BCVgJ47hRhi3Vb1WLP7nY8vUe2N4tyTu5fKsF/PH9LfC13j+smtUwXjvm2SbNGR6pT57zBAYuF+MOklQ27JCZ9vaELJqkUAcdmilJa3N/djFJh/xaQZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478303; c=relaxed/simple;
	bh=tly/MWZa0oRwFhms5sXnxLza3S15ZekHONwA8y2aC14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f6jDgEAIOe8bIlrrp76kyO0BfVlfhZaxIP+niDl5SqGOD5eLRqSNLyOgxiZPZ7SSNpcI+Cw+Svbo7K9TIL6tCYl+Ig+6WeeBULTHRZ4LqByI8Ew38DBdgyyY0JN2to0WDt4PdUWmaPtANY+PmSozI4N8++4Z+2aS7ZsdLpf5lm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhsulU5g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhsulU5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B4CC4CEC5;
	Wed,  9 Oct 2024 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478303;
	bh=tly/MWZa0oRwFhms5sXnxLza3S15ZekHONwA8y2aC14=;
	h=From:To:Cc:Subject:Date:From;
	b=OhsulU5gMWY2KUpsQ+d4mPHopGIcxIKSaTFrcQvM5tm48hpFaIhzK1okWJbCNvwN7
	 891YvaBt/K3Qr5r9zamr1xzW5kkuuJfUh/DLU96gxZ+Vpw8PLv34RFa9wayohY0Z5w
	 GQlUnLtyXhJIvKEZ98ypfU6IOpWcIVH5E49BR8bXnyCNZF6K8Kz60NhjlSnKO89hwk
	 cF/Gme5eYTUwxCpLgYZwvd+ZHJz6mTMTwQXq0lf9pZ8zF6X3vyPVoe39f5044TtMJF
	 CdD905g60v1cLx5R8W3fMzqW20F1ZiYcNDDw/i5jiuKGs0qBjNb+iUzbiM/2UfpOkG
	 lF+7vw7/8BDYQ==
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
Subject: [PATCH v2 00/10] Make RCU Tasks scan idle tasks
Date: Wed,  9 Oct 2024 18:21:17 +0530
Message-Id: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

Architectures for which all deep-idle and entry-exit functions are
marked noinstr, synchronize_rcu_tasks_rude() is not required. However,
disabling synchronize_rcu_tasks_rude() for such architectures require
RCU-tasks to pay attention to idle tasks until they enter the context
where RCU is not watching. In addition, NMI context need to track RCU-tasks
entry/exit for NO_HZ_FULL CPUs. This series adds changes for both of
these requirements.

The series is available in git tree at:

https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=rcu.tasks.idle

Changes since v1: https://lore.kernel.org/lkml/20240807163506.434885-1-neeraj.upadhyay@kernel.org/

- Split into multiple patches (Paul)
- Various restructuring updates (Frederic)
- Fix race with early boot code (Frederic)
- Check RCU watching state for idle injection tasks.
- Include patch to turn synchronize_rcu_tasks_rude() into noop
  for architectures with CONFIG_ARCH_WANTS_NO_INSTR enabled.

Neeraj Upadhyay (9):
  rcu: Change rdp arg to cpu number for
    rcu_watching_snap_stopped_since()
  rcu: Make some rcu_watching_* functions global
  rcu/tasks: Move holdout checks for idle task to a separate function
  rcu/tasks: Create rcu_idle_task_is_holdout() definition for !SMP
  rcu/tasks: Consider idle tasks not running on CPU as non-holdouts
  rcu/tasks: Check RCU watching state for holdout idle tasks
  rcu/tasks: Check RCU watching state for holdout idle injection tasks
  rcu/tasks: Make RCU-tasks pay attention to idle tasks
  context_tracking: Invoke RCU-tasks enter/exit for NMI context

Paul E. McKenney (1):
  rcu: Allow short-circuiting of synchronize_rcu_tasks_rude()

 .../RCU/Design/Requirements/Requirements.rst  |  12 +-
 kernel/context_tracking.c                     |  11 +-
 kernel/rcu/rcu.h                              |   4 +
 kernel/rcu/tasks.h                            | 148 ++++++++++++++----
 kernel/rcu/tree.c                             |  16 +-
 kernel/rcu/tree_exp.h                         |   2 +-
 6 files changed, 140 insertions(+), 53 deletions(-)

-- 
2.40.1

