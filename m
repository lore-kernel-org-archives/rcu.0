Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548F1E9B01;
	Thu, 30 Jan 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262968; cv=none; b=RviSXaHIMAzMYkZydeAGqu/dtTlis6n0oXKvv0cn5H5cSGRy2gqEX5Uo5Z6gjgelHLeZRq0G6Ehtb1QZenUAL0/qoHqmQH0kCJRG5Oty/SM5r01cp/pjKtYHanVXfLnLIHzuYVZOQnvEFJZ6JNBr9T4OiZ8DkqRmv0zFat6ONvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262968; c=relaxed/simple;
	bh=qCA8DvUvboeyMmYJDVVZIq4KuZNK5Bsr/7UY0MrYMtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nMSkZ6lW03aopRUQ/ykcjXTvrt+kpNfUUAhVNqgGuJxx1VbM94zC/IQw2n382VZrdNgi/bNaGoxOKV6+vZnt2B6OH2OytRwDoOUwody0NpUAbbGb0a/csajcvjmQ+gwLIWd6FlgqDB4vNB3C2n03GybIF5Q7nKXmZVha9Y4Cb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd9FuL5y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd9FuL5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2C5C4CEE6;
	Thu, 30 Jan 2025 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738262967;
	bh=qCA8DvUvboeyMmYJDVVZIq4KuZNK5Bsr/7UY0MrYMtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qd9FuL5yWf23TkS4i/wqvRv2B3lVLhZk3fWTlCP24VnZFTQFTjXJh5RcLJC9ABvRp
	 FYJX/334ivPtoLsuoyKQsBE+YzJyBlxDE7xB2pefV9lZczNiADONZR8nBqw5vT3Jhv
	 2bxIacQFW0rYFvsolbRNe0olso+wX2Jomsqk1jecCr8CDxGUJKGfohbqbS/3yVlITi
	 QQ36doawtr+mkkfTVVZFRxkyMEy9WN4IBV1M9dIes6BKCz2ode+KdDdlHTD3vV82ZN
	 D1+VjshvyvAvSdqQmuFJluqyOR1jIYmCEbJn/J1l4M8E60hwfdBlFFy72mmNDBDZeD
	 DggcAOG0hZDJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33570CE37DF; Thu, 30 Jan 2025 10:49:27 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2 5/7] rcu: Add CONFIG_RCU_LAZY delays to call_rcu() kernel-doc header
Date: Thu, 30 Jan 2025 10:49:23 -0800
Message-Id: <20250130184925.1651665-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <851fd11f-6397-4411-983b-96f7234326d5@paulmck-laptop>
References: <851fd11f-6397-4411-983b-96f7234326d5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a description of the energy-efficiency delays that
call_rcu() can impose, along with a pointer to call_rcu_hurry() for
latency-sensitive kernel code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index befe35058c49..229f427b8c82 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3193,6 +3193,13 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
  *
  * Implementation of these memory-ordering guarantees is described here:
  * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
+ *
+ * Specific to call_rcu() (as opposed to the other call_rcu*() functions),
+ * in kernels built with CONFIG_RCU_LAZY=y, call_rcu() might delay for many
+ * seconds before starting the grace period needed by the corresponding
+ * callback.  This delay can significantly improve energy-efficiency
+ * on low-utilization battery-powered devices.  To avoid this delay,
+ * in latency-sensitive kernel code, use call_rcu_hurry().
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-- 
2.40.1

