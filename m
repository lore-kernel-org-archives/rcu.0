Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E1839E3;
	Fri, 16 Aug 2024 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791095; cv=none; b=A07C/QZh6yYIzqAKSfcdZvUd70+bIK6QM2CrNtQcEcZc+qYHtK8d8HI/XdVg1jfDcf4jUzZgoV8EYVIfezFuEZCYsXTNSbxqdx18iwFcm4FAnA8NNqnUIb9vTAoEEvI3laqoTzU0CdXrlg7QHB5Ry1xiXbg/3XzC+oUkYR7LwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791095; c=relaxed/simple;
	bh=wi+lEcfaLQ4kKBI2cOT3M3q6JGLW3FpsAu/Mo0gCJ4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4gtUHCCWs9iJ+Sr/aC/NX9T+lY6FLlcSVaCQJwe+8Xjtthho4Hg2zqIEkIgs2ZXFGl+OI4O8SVWOPMZ3BfFT2BB+9HHTDF/wrtQMr0dlDm6rxYiOVunxFeEWui0JhYC+bLpBk13UxRoIt4qn6lS11FvU/gKCVrcgjuXabnIm1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEwAj0gw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEwAj0gw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB4DC4AF09;
	Fri, 16 Aug 2024 06:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791094;
	bh=wi+lEcfaLQ4kKBI2cOT3M3q6JGLW3FpsAu/Mo0gCJ4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEwAj0gwhsqb82LY0RTh1HZPLw3jSNKzErVcUE5waOBiPq7qlvXzysY1lwtrEGJFp
	 uM2QkZk7nZu6JmIE4tR+ijPTCi9VYdsSBvB7w7/BlPBnz2/GkMYv4+eTePfnH/ohPe
	 M0aHrEJP+vqgb2qqAdkRH1gbYJjoWrxVQQJwcUJGOfa5nHxompszjEHqfKyW9I6xzf
	 2A/dFS3IViVg6FKT6e4OTOo4beaGSFBvqUiooLojqGZodM329V3j+eN4qDEmvL5L15
	 uXUGMtHixw3Qr0k2km72cH8IQ//apyV+T41J5W7v0pMO4+zqi6VLUK5EEczGI32hMW
	 3BnLfZQzx+33A==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 10/12] rcu/tasks: Mark callbacks not currently participating in barrier operation
Date: Fri, 16 Aug 2024 12:19:19 +0530
Message-Id: <20240816064921.57645-10-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816064730.GA56949@neeraj.linux>
References: <20240816064730.GA56949@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Each Tasks RCU flavor keeps a count of the number of callbacks that the
current rcu_barrier_tasks*() is waiting on, but there is currently no
easy way to work out which callback is stuck.  One way to do this is to
mark idle RCU-barrier callbacks by making the ->next pointer point to
the callback itself, and this commit does just that.

Later commits will use this for debug output.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tasks.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 127018280618..d44abcd656d6 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -283,6 +283,7 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
 		if (!rtpcp->rtp_exit_list.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
+		rtpcp->barrier_q_head.next = &rtpcp->barrier_q_head;
 		maxcpu = cpu;
 	}
 
@@ -407,6 +408,7 @@ static void rcu_barrier_tasks_generic_cb(struct rcu_head *rhp)
 	struct rcu_tasks *rtp;
 	struct rcu_tasks_percpu *rtpcp;
 
+	rhp->next = rhp; // Mark the callback as having been invoked.
 	rtpcp = container_of(rhp, struct rcu_tasks_percpu, barrier_q_head);
 	rtp = rtpcp->rtpp;
 	if (atomic_dec_and_test(&rtp->barrier_q_count))
-- 
2.40.1

