Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB5FC11;
	Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558868; cv=none; b=k9XiCysAbMTyvY1kqTZPwFwfurqmE+a20whpaW2EZi/hxGob3N3eZmUHckXTRbGPrmUXW4GPGLIhkVYon/+GS3gc1ZkllOnkNYfgwXLJ4Pygb6bZgFN9kvC3rh64JNOoU45+fFZw5dTFde8cFqJN5Z+AsSuS6Ku5Xt9D0+xMkcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558868; c=relaxed/simple;
	bh=WJLXF1GgJdCg9l8dn7wE1jff0VI3lwIKjJqHLcAH/5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXPdzBqhjAJim+e7coIjSPcjyiSNAScqlLq85h16mq0Km8krczPZBFfl0LhMyxE7NvulvKKNq3QWCXU+3FRIzdXUW33xvJJ7Y1LeXtmoNLA5rbqMf4RTvUbjrLUK0RmIEp2/Y+eWdTsD0J2sTwr4wjb/M0OXMiN1AQAimJSpfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMPh5fDZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMPh5fDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCE5C4AF11;
	Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558868;
	bh=WJLXF1GgJdCg9l8dn7wE1jff0VI3lwIKjJqHLcAH/5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CMPh5fDZMdEgSp4Yus7Z0MxD/aGB9QEPISJmjUPfxtrODPdU/8XfLA3udQGtqqxQQ
	 1MW6X8JsEd1aL83lHvuhXOw4bANrQEz5bkICNUgejronVf33Np2bIMMU3ZXQJ8cjaj
	 ebFlT4311PBCeOqpJuSj19epAvb+h8eiqGzuWtR/sfD0LnL+MxG2rDMpJLirE0QBJl
	 Xz4L7dY8wNWz9y9oDeS/g52qyvOMF0LKztYA7bD+V8jYJkj9Vgk9KV4+HuXTd/qWzb
	 W0KQXtowjPspa8TsWs3qi2/G/7KrgoYz8v0VRlAoV7GyPgQw8FlmVBBJ987OqijFXw
	 3mkVXJu84naBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EA26FCE0E0B; Thu,  1 Aug 2024 17:34:27 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/6] rcu/tasks: Mark callbacks not currently participating in barrier operation
Date: Thu,  1 Aug 2024 17:34:24 -0700
Message-Id: <20240802003426.4134196-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
References: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each Tasks RCU flavor keeps a count of the number of callbacks that the
current rcu_barrier_tasks*() is waiting on, but there is currently no
easy way to work out which callback is stuck.  One way to do this is to
mark idle RCU-barrier callbacks by making the ->next pointer point to
the callback itself, and this commit does just that.

Later commits will use this for debug output.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index cf273c554f3b0..6f1e82e548bbc 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -281,6 +281,7 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
 		if (!rtpcp->rtp_exit_list.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
+		rtpcp->barrier_q_head.next = &rtpcp->barrier_q_head;
 		maxcpu = cpu;
 	}
 
@@ -405,6 +406,7 @@ static void rcu_barrier_tasks_generic_cb(struct rcu_head *rhp)
 	struct rcu_tasks *rtp;
 	struct rcu_tasks_percpu *rtpcp;
 
+	rhp->next = rhp; // Mark the callback as having been invoked.
 	rtpcp = container_of(rhp, struct rcu_tasks_percpu, barrier_q_head);
 	rtp = rtpcp->rtpp;
 	if (atomic_dec_and_test(&rtp->barrier_q_count))
-- 
2.40.1

