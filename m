Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787D72209B;
	Wed,  7 Aug 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048516; cv=none; b=TxIinaWRE9aw07o08fjoSD96zV2QCq3oXwZEjc9QTSm33i4KrB4WcGC+59P8U+HELH/oOi5pveTTSQeTBFhcwagh1z1j2N2KtHxcXZ09zHiw2EbLPWcwzCTnOIe6uqdZo+rxGGLNQeMwTsI8vOiOxMnJHHTBq/02a9u3SzUeAKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048516; c=relaxed/simple;
	bh=RCZCL7h5UkWNj58Vaysmd73SIQcercRo3wSY7LzStdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bwd1VPC8hOVaWmqzOD9SwDxaN+ijRTQQ4tQZSmZ6FKNewU5SPfKDWi0FZNTeYWt3Tv6/fgZC68D42dNmtg7lD2dNltY5PEUYjNMy01GodWUDkhY1SfQsFdel/jySgbXdyKQ55IF+Dtd2aJV6QZVe+A7p8KBVDxD5V4UxGa73iFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pacQHUzn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pacQHUzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0F1C32781;
	Wed,  7 Aug 2024 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723048516;
	bh=RCZCL7h5UkWNj58Vaysmd73SIQcercRo3wSY7LzStdc=;
	h=From:To:Cc:Subject:Date:From;
	b=pacQHUznhGIVVG7B+bEKUuI0XOPjLktoc1SwfysdDQWmc7GiGHxwLKmWPzkT8qAmY
	 Z6crHfc/rfCN3m/HMvj3AarAS9YynSoNSnbVpAjZGU/yH6cUXKmV1APD7zii5SvaMf
	 cNCiD3qDzoOV5veTmztKVAy0BzTxe/mII84QPdRpdDcsDSGt+qd/U5u/Aljl+yqNMo
	 aKYrSBAlncINIidGlmW1WPpfCHKiXO2n8FVBL2Mco9Td3Ie+UdlLla7oL5UGRIxDBW
	 qtfPKdJp9WZj+Vn/VY2z+Vf3WL/ijvQxsrgOv8Ax0dR29X3X7g1OIW+iKdK5XVFK+K
	 O8m1qeTG5FtSg==
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
Subject: [PATCH 0/2] Modify RCU Tasks to scan idle tasks
Date: Wed,  7 Aug 2024 22:05:04 +0530
Message-Id: <20240807163506.434885-1-neeraj.upadhyay@kernel.org>
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
https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=rcu-tasks-watch-idle.07.08.24a


- Neeraj


Neeraj Upadhyay (2):
  rcu-tasks: Make RCU-Tasks pay attention to idle tasks
  context_tracking: Invoke Tasks-RCU enter/exit for NMI context

 .../RCU/Design/Requirements/Requirements.rst  |  12 +-
 kernel/context_tracking.c                     |   6 +-
 kernel/rcu/rcu.h                              |   4 +
 kernel/rcu/tasks.h                            | 107 ++++++++++++------
 kernel/rcu/tree.c                             |  12 +-
 kernel/rcu/tree_exp.h                         |   2 +-
 6 files changed, 91 insertions(+), 52 deletions(-)

-- 
2.40.1

