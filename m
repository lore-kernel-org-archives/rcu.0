Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9671E0DC5;
	Wed,  9 Oct 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496847; cv=none; b=PX5jnZHLxWHWPOyAZH5Xrh9HQiCXlFi5xAAWecKZG895u/PnQPO/lxtHKQWfOvo8zoEP2235znLs6GfYHWVvLbPLQ9kvAACvwNG3uDvEgm+X2vtHHLdXJgstv+TTIKBuhyBzGu0UVDlIOx5k18hcitRX9gBbd2WKm1Ant7Mc2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496847; c=relaxed/simple;
	bh=vpuIgx5kDOrF1tvN1wFdkRmFqkJZGZwsKVqT4sAsn8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXx1OyqytY0LolwZDHuxL5t/a4q8Ar8hmMTKEGrDk5JMxNFvfk8dofv460W23Ntdt2rpbB7wNFJK4fEiu/6+FWgXlj4jQhEhPgC8t7c6dMDu5AIGD1s8XLfa+pHs9+lWOhqCMQ3hbczQhLvPJS2soNKM7qEIrLR4hKsmLGqgK04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGcpGRHG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGcpGRHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ACCC4CECF;
	Wed,  9 Oct 2024 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496846;
	bh=vpuIgx5kDOrF1tvN1wFdkRmFqkJZGZwsKVqT4sAsn8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGcpGRHGEXMF9dLRiTMFtMsfpal65nz3iH4dwnTOVDbZNXp/l/8IUf8yG85J/dJhb
	 7yWJY/K1pFKDQP97xf56Q36xSVy8JoHnCkO0bVKr0OAkePB9PsqzjXHZ5WAL1mZIRm
	 9SM5fTxx1D1P6aI4F0Bd0KHYOHmlgQGBnhNKd9sY0RG/REnBmW9sBY+3ifs6bCpkrb
	 IEkBXd2wuq0d5dD5ZpI7CSq2OZYk8tq6F0sZQDvdJhC3RoXi1X05DbUBxoRJmPcz3U
	 ivpP8uopy1/dpgXilpKAnjqMTE1wsXCUBVCBG7G8TT2tj7dmAaH3YKzz0En8KrkiJD
	 ThTBKgT2m1efA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6E7C8CE0BB1; Wed,  9 Oct 2024 11:00:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 3/7] rcu: Allow short-circuiting of synchronize_rcu_tasks_rude()
Date: Wed,  9 Oct 2024 11:00:41 -0700
Message-Id: <20241009180045.777721-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
References: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/rcu/tasks.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6333f4ccf024b..dd9730fd44fbe 100644
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
2.40.1

