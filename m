Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B6201273;
	Wed,  6 Nov 2024 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905158; cv=none; b=gVesSokXbDztgCTmiIvl+Kyl/KAWfqODnnTU7FQAleIli16RldCko9X1SbLeIe6zs/+MLTD5uIb0LnKRYQiLKUasnePNqkm8xbW8j0x6klnhaoGOYe2VT+i3Mv3KkELv/1TD/onq57dlpyiAs2uh2Zf6jkj9jvdl0YyaeG3Tp2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905158; c=relaxed/simple;
	bh=s81i9ZIZZNHkWTh1KjD9SljtlZQoCxFnPvf6o+EJn50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QbB6J3UKJDz8Vuwzgj94fJTDlfaUHGWhqhik2T9Zt33m7D6hfrzvst5hJXK5qawzNoRcehbw8ABo9P6AzBbYPZdyzGAoCVL8pRN/ZRyO15qFqFRk7dEvya8yo7qoSs+m4jGzv9ZUnssoVPG9KLz/XDvkpvrEe/PonMSZPYD4klE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a07KJYr7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a07KJYr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2E3C4CEC6;
	Wed,  6 Nov 2024 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730905157;
	bh=s81i9ZIZZNHkWTh1KjD9SljtlZQoCxFnPvf6o+EJn50=;
	h=From:To:Cc:Subject:Date:From;
	b=a07KJYr7jbBoRLyZC7QvSo7QGUBbbC3C3LEo7cVAg3VIW/EEnTIsf4jlY/RyxTzlc
	 UmYEZ3eR8LIAQqnxXBZdu5WY5EAdGUKdRq3snlXAognMZdqqSorKu/GnGm8zjZ74ib
	 q7srI4wcikIswQ2Ml9WfaQSFwoRBjbH6oNUkJzuU7tCkFZNPwuRkyww2iTJzcngUMy
	 99xzYEwpwNnTdxu7748pafDZ6AJs875E3XFJu2nBY0bD1ZZXAVNPxQRRtsy2vconYp
	 euvWPSz8JJTvNa+ZAMoWS0/LImdz6+q3VpP30crlE4OElxlWdI5IcHHXBX1ivU/v63
	 ziecLTlKZCSdA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/8] RCU fixes for v6.13
Date: Wed,  6 Nov 2024 15:59:03 +0100
Message-ID: <20241106145911.35503-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Please find below the general RCU fixes targeted for the upcoming
merge window.

Michal Schmidt (1):
  rcu/srcutiny: don't return before reenabling preemption

Paul E. McKenney (6):
  doc: Add rcuog kthreads to kernel-per-CPU-kthreads.rst
  rcu: Allow short-circuiting of synchronize_rcu_tasks_rude()
  rcu: Permit start_poll_synchronize_rcu*() with interrupts disabled
  rcutorture: Test start-poll primitives with interrupts disabled
  doc: Remove kernel-parameters.txt entry for rcutorture.read_exit
  rcu-tasks: Remove open-coded one-byte cmpxchg() emulation

Uladzislau Rezki (Sony) (1):
  rcu/kvfree: Fix data-race in __mod_timer / kvfree_call_rcu

 .../admin-guide/kernel-parameters.txt         |  5 -----
 .../admin-guide/kernel-per-CPU-kthreads.rst   |  2 +-
 kernel/rcu/rcutorture.c                       | 10 +++++++++
 kernel/rcu/srcutiny.c                         |  2 +-
 kernel/rcu/tasks.h                            | 20 +++---------------
 kernel/rcu/tree.c                             | 21 +++++++++++--------
 6 files changed, 27 insertions(+), 33 deletions(-)

Thanks.
-- 
2.46.0

