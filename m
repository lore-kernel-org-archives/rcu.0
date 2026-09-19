Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E92D322E;
	Sat, 19 Sep 2026 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778142; cv=none; b=P1Qe3XS8k3pVx7/fZNgxU7k554TU0XWyuZiNKgaoV50Xm75KW51O3kXP2Hp+wJpiFkBETzY5HkfO25B6UVipa9jXNfzk6kfiNK3ReJ3ibspB9Osp8ndcebTtsatt6dKPg5t3iI6GogBOn1xJhk+gXBInlI9wv726HNyBrj415X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778142; c=relaxed/simple;
	bh=JK39XQJMDIIKdRwRFmh13pmoUzSPv614icInc4VInBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PChkBHgnCSY9OEWkqNigGFXRpLG0syMb3N2DcwG2Qd2Hafonyz8gWkSjJLoUOvcd60rfZvMEulgDpVJDvr+pipdcBHZzXn4epfCHLaD7k3wsOsWl559tJdvXv9dqp09uh9S4UqcjRCrXQ7IKUyKFF0nH0xwAye+lDS948n5V82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmU2+O3Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmU2+O3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEA11F0089F;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=UFJzBMgvAKQlZsRN4fagWJwwYH6xcYWN5oYE/Woff8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kmU2+O3Zs7673oZSPWXOs9/G5JJYjkB3YUPp1EFgy2UG/4OJyAlsjRH4THbAmJUiX
	 HDqrcXXjE4F6RvxJa7hXbx2eNEsv5X1FEsOcPbnFocJeQ7EXl62BIpTbfZw2uXJhgq
	 leIxxqliq+D1Yxma8HJ8p7Ve0E7e0yYEhwLKBoJz0O6S6D4EN/fpGzhneOeJ9OiG9v
	 YSvXQKqX1PNCg1YanJ1Qjy407wMr8GJ92i+r0G1WmhULob411L16QlYKTfp8NsIN6v
	 3ownqDXVzi4V6eyD2GZkPvongvY9gU5yL7a7PMHJj1Lp/t+hnqwDvex/9bTkZmaB+1
	 feMF4Tca9Shyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AAFDDCE189E; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 10/19] srcutree: Warn if Tiny SRCU readers are preempted
Date: Fri, 18 Sep 2026 17:35:12 -0700
Message-Id: <20260919003521.3134552-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fastpath of synchronize_srcu_atomic() should always be taken
because readers always disable preemption.  Therefore, the fact that
synchronize_srcu_atomic() is running at all should mean that all readers
have ended.

But there are always bugs.  And responding to a usage bug with a
too-short SRCU grace period, and thus possibly corrupting memory
is at best a sadistic response so such a bug.  For this reason,
synchronize_srcu_atomic() explicitly waits for readers.  Except that
it does so silently, possibly failing to flag this bug.  This commit
therefore adds a splat if synchronize_srcu_atomic() fails to take the
early exit.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutiny.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index c6a2b74ae9d6..99f8bfd98b04 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -375,6 +375,14 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 		return;
 	}
 
+	// Because readers disable preemption, we should never get here.
+	// However, a splat and some spinning is usually preferable to
+	// memory corruption due to a too-short grace period.  There is
+	// the possibility that this will hang if the preempted reader is
+	// not looked upon favorably by the scheduler, but this is still
+	// preferable to memory corruption.
+	WARN_ON_ONCE(1);
+
 	// Wait to drive a grace period or for someone else to do it
 	// for us while we are lazily preempted.
 	while (ssp->srcu_atomic_gp_flag) {
-- 
2.40.1

