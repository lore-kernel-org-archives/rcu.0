Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC80630216D;
	Thu, 18 Sep 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190674; cv=none; b=itai4g0MUG8qUk3eX/lfxrmfOJzp+qc+9eEroSihuimimnpjRaSoFZR9d+e3VkE/cy4WqKB3dfUgqR37sGRGCjxrEZkBKDHeAp6RNVOU/ebvHB6fVrA2uP1MVYN2xOPTfE18gAdyf4WKmfghzE4ObXzd6r12DDt+FhG0wurgewE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190674; c=relaxed/simple;
	bh=tt2fnvxyKHuxMWduq2G5iWtwAxgOUA1tzVmzIKN+kzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HfLVCandQuN4vIoufp8TWjyeS77+l26EATyGucuOHUTb1MVveqSF5u1eZ/VUkHGibQ13PW5AlUydSCv0gN3ZCWp7KYzNXV/x985JfOwpuvvuXhXn4dGX0vMZfD05MmJDkQuhomOTOWKWbEYMP/sPgA14mSnCwehi4Ud5/l0wS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIPylFx9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIPylFx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCEBC4CEE7;
	Thu, 18 Sep 2025 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190674;
	bh=tt2fnvxyKHuxMWduq2G5iWtwAxgOUA1tzVmzIKN+kzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIPylFx9ChvcXM7wjTxfr4qUJQo/k9aqvgOr3xgTCMA4EYzaNxzibcmUyUz6oGiso
	 Ltj5RIOX83KZpjI8IckALIVdER+Swnyzbtd3cXwFAMbIvaWAu8M8Mp33JILJKdqel5
	 Of3UD3LnODF3O2zLZu2V6hq7F39/+f7KHx835Yrr08G6kOTUf46UvVkKtayTB7C9HM
	 WdLyraTGZr5/ku1efz2XxrmFjSj//O5lm233tT57feIsIM+ZkgKvTx/rP+Ubir++4H
	 S1+eNngmWLx4oGogohgn9ImjJYD3A/wzbGcUNpSTkUhCqFVne2A8/Vx8ECmupkZKW+
	 f0MC9s+ZL8CaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 116BFCE0B32; Thu, 18 Sep 2025 03:17:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 1/5] rcu: Document that rcu_barrier() hurries lazy callbacks
Date: Thu, 18 Sep 2025 03:17:48 -0700
Message-Id: <20250918101752.2592512-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3773a6e3-8ec8-48c5-9277-264cd8ccbb10@paulmck-laptop>
References: <3773a6e3-8ec8-48c5-9277-264cd8ccbb10@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds to the rcu_barrier() kerneldoc header stating that this
function hurries lazy callbacks and that it does not normally result in
additional RCU grace periods.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8eff357b0436be..1291e0761d70ab 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3800,6 +3800,11 @@ static void rcu_barrier_handler(void *cpu_in)
  * to complete.  For example, if there are no RCU callbacks queued anywhere
  * in the system, then rcu_barrier() is within its rights to return
  * immediately, without waiting for anything, much less an RCU grace period.
+ * In fact, rcu_barrier() will normally not result in any RCU grace periods
+ * beyond those that were already destined to be executed.
+ *
+ * In kernels built with CONFIG_RCU_LAZY=y, this function also hurries all
+ * pending lazy RCU callbacks.
  */
 void rcu_barrier(void)
 {
-- 
2.40.1

