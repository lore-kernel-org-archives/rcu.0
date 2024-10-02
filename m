Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4C1D0B89;
	Wed,  2 Oct 2024 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881072; cv=none; b=W3tC/W0Kcze5O58FliIzU/yAqqXgwca5OZSPs6gosLC7XgLeEM2E/5BUg+YqvnQWVvgccQWS3mbtD1SwDzYR4tiOOuAORlgNhBo/76J24QAVL9ndQ3TVGB4Jvazs8ixxdRjtAWsH3GgoiV8IBHQihaHROYIPqdQ6fbxhOSLQsRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881072; c=relaxed/simple;
	bh=4jN7m4YdBZpe108+MCUL/gz1eAHliwNklGS/JkzIwho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PF77DT2VAL9kg1c5zsWX4LXwNBxm0eBdJuLbGpbUQm8vx7B/uUjrVAUJMXRmoUauaLLxWV8lMNPGAneMDSRoWXZyyT/Oq3xmmut0+y8N3A/dT76kvy9zJHmRtdYSuYYAQMMbt/T2VC2hTxzz7Msk+BPZzf+92NOPO28jOwK5yvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qY58D3Kl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qY58D3Kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC9CC4CECF;
	Wed,  2 Oct 2024 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881072;
	bh=4jN7m4YdBZpe108+MCUL/gz1eAHliwNklGS/JkzIwho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qY58D3KlK0tRBqsKkUDY1pzUaYqgPGgj7mXMnAMOr2JH2v7LXE3JCU7o6W8gi6Juc
	 JMVrpPX0G0kwPSPLvcbQ2wtUC6YdRjLtqFWRPBJ1m+52f/ICF7E9igm0bE2o0J5BTw
	 jg/7mHZ4EXEhn9StcP3QOLNUn/xlL8pBpY5CdimB34VH6YuqfH1CfQcfb6dZrZu8WY
	 5FyXZufbzcaHbBQJoQilB04WsZv3XMlw5zwqsU3JnWABQyLFnuLxAMPGVXxoEdDlqB
	 /SeI48Ayq+JvaRqc/lpeMFjTR+3/18N5PwNtsh7lSRnljHgZ0GvX54rlAAg7WdsZL2
	 SLFjMor11fdIQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 3/3] rcu: Report callbacks enqueued on offline CPU blind spot
Date: Wed,  2 Oct 2024 16:57:38 +0200
Message-ID: <20241002145738.38226-4-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002145738.38226-1-frederic@kernel.org>
References: <20241002145738.38226-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callbacks enqueued after rcutree_report_cpu_dead() fall into RCU barrier
blind spot. Report any potential misuse.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a60616e69b66..36070b6bf4a1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3084,8 +3084,11 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	head->func = func;
 	head->next = NULL;
 	kasan_record_aux_stack_noalloc(head);
+
 	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
+	RCU_LOCKDEP_WARN(rcu_rdp_cpu_online(rdp), "Callback enqueued on offline CPU!");
+
 	lazy = lazy_in && !rcu_async_should_hurry();
 
 	/* Add the callback to our list. */
-- 
2.46.0

