Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10412202625;
	Wed,  6 Nov 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905164; cv=none; b=ZpJ2NTNfakG0Xy0UueCnnh4EvCzyR7uKTnVPa1eecIF1CZ5yhvtccP17apkNYlfylsM0SbPZSenzydC8GHpImeVDOJXi6k9b7fCNI6FEtCICA2CeaZCoUqSNLo8LfK0dtM5ApIR7V4sF2jQcWi9JkwTha1w/3qeWlLubD1F/uWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905164; c=relaxed/simple;
	bh=+ZiepWhi94NGo7vByz0jA+dg9Rjr5KkBmO7yVbgAD8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2wDcELkjEhkiHRsjd1f+ZjdW5RmDNS29Y/P2zt/HEAoFuA4HFasqY0nAe44d3539yfcQTIWXu3xwUpxh79XKuYLwg99M11Aw94EC/Qx92n4sB9rCcawUVLMlbVtCXOb1XjnvXdQOS4WDwfHHrRpt+e6Bj1RkxCMnXHrMhi8xmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1sGyXur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1sGyXur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5789C4CED5;
	Wed,  6 Nov 2024 14:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730905163;
	bh=+ZiepWhi94NGo7vByz0jA+dg9Rjr5KkBmO7yVbgAD8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1sGyXurEsjXhdxOTwtcP5dAZR3ha1gmmQYBTLGYuoVLWop6t74Vi/celdwHeWkpJ
	 xUBU734TXM8UwCwnpQPfPybrFRpVholT+ut5DJmpN8H0TyXCNx/i2tvoOaOon6z4Ah
	 alBXGnGdEOqh7fN0lzWHMF1tOMhiEUheITMZAPEBKyiuLILR8NgQSf6J6iJjlGDZwb
	 9GFRyNshlDnCfHtGW95b6ns+1/VbGg2nlnQPto51ALVtCtu3E++CFAdugsJd765SzK
	 2eUZSkwl90Q8NawA+RXxuZC7SrGBJ/bfMVORkcVtTSh/1zk+XCr1jXSFTSg+G7WHR0
	 XAZq3Kclxnybg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 2/8] rcu: Allow short-circuiting of synchronize_rcu_tasks_rude()
Date: Wed,  6 Nov 2024 15:59:05 +0100
Message-ID: <20241106145911.35503-3-frederic@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

There are now architectures for which all deep-idle and entry-exit
functions are properly inlined or marked noinstr.  Such architectures do
not need synchronize_rcu_tasks_rude(), or will not once RCU Tasks has
been modified to pay attention to idle tasks.  This commit therefore
allows a CONFIG_ARCH_HAS_NOINSTR_MARKINGS Kconfig option to turn
synchronize_rcu_tasks_rude() into a no-op.

To facilitate testing, kernels built by rcutorture scripting will enable
RCU Tasks Trace even on systems that do not need it.

[ paulmck: Apply Peter Zijlstra feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tasks.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6333f4ccf024..dd9730fd44fb 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1398,7 +1398,8 @@ static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)
  */
 void synchronize_rcu_tasks_rude(void)
 {
-	synchronize_rcu_tasks_generic(&rcu_tasks_rude);
+	if (!IS_ENABLED(CONFIG_ARCH_WANTS_NO_INSTR) || IS_ENABLED(CONFIG_FORCE_TASKS_RUDE_RCU))
+		synchronize_rcu_tasks_generic(&rcu_tasks_rude);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_rude);
 
-- 
2.46.0

