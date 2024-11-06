Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF2201244;
	Wed,  6 Nov 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905179; cv=none; b=NYysOaEbcyt7fH9oaq4p5XJpbWsZPLjWPyRaHZSP/VbQwmsVh795fq2D7EQ05vaCDdJbpxVWQfrHLdGwWdPTCA9E/2DYBYZLDLjjcaL8uYvsvJBWq/lh7DyzTQd6fVwRtlk7gs8t49RPcnlOMUGce4f293xd6RHdxFu6U/EmGLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905179; c=relaxed/simple;
	bh=NCzmn7UNI9ILCBFE/qKxLNFeFkK0TChbvdeR5cTakVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFf2ec3EH1mHDBOMcFd2sGSuErET+KDSovWv6bC2gs2fwjazlrVaL2f8QgHsnUDX2WwhbjC5ss8Ik60lmOdsIacHUAf7Sl3Yj/P6ZQzDo5cK7qs4u4L+I8LmdPBh0p/kZw40Z9J1lzV1s/vws3KCKrnglAllF3hzc85vdDmy1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdsYGEP0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdsYGEP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56083C4CECC;
	Wed,  6 Nov 2024 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730905178;
	bh=NCzmn7UNI9ILCBFE/qKxLNFeFkK0TChbvdeR5cTakVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZdsYGEP07gLWRwz+PSqs+MGoqrU4Z405Le/QRS3thhITgodfGdlcxwlSm0qlhOyNz
	 PU9G+xEKjhtJk7iTK0r5J3FD8o+kG1LNT5zZsyEgIE95g9biS7SZJ6EmLX8Hx5gl6m
	 yRRhs9a/xN4G1o3kUNbqSCwfoyZm6yn0nK7Y6sZFEN3XXrK0jdm8fjL/OdtInAs+wZ
	 YP64xEKj0eyD3HUuO6m+cNd1l7BuuRrVNhdXgyNB3bvXMdr7SYcKeE+5WuG0aRAxDy
	 1QG7DBgO43qAjcIW4KytjVifNfoigNCCap9DbZK+cl/9qO401OAgTlqv6k99UAS1CY
	 MB5YgjJNUXTzA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
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
	rcu <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 7/8] rcu/srcutiny: don't return before reenabling preemption
Date: Wed,  6 Nov 2024 15:59:10 +0100
Message-ID: <20241106145911.35503-8-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106145911.35503-1-frederic@kernel.org>
References: <20241106145911.35503-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

Code after the return statement is dead. Enable preemption before
returning from srcu_drive_gp().

This will be important when/if PREEMPT_AUTO (lazy resched) gets merged.

Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable preemption")
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutiny.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 549c03336ee9..4dcbf8aa80ff 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -122,8 +122,8 @@ void srcu_drive_gp(struct work_struct *wp)
 	ssp = container_of(wp, struct srcu_struct, srcu_work);
 	preempt_disable();  // Needed for PREEMPT_AUTO
 	if (ssp->srcu_gp_running || ULONG_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max))) {
+		preempt_enable();
 		return; /* Already running or nothing to do. */
-		preempt_enable();
 	}
 
 	/* Remove recently arrived callbacks and wait for readers. */
-- 
2.46.0

