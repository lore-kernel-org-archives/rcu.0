Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63C1865FA;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263324; cv=none; b=kDRtQLjo/Am6lvFhkH8ghOcZlHu9O7l5Yi39hWnAiMS6knqttQwYvNGlt61aEDrqf+PGd5Tf3SEMrFHXNiJ99eTxl/3CAvlueKfRtDW7Rp+hNglyKt+GbMKNZJB8GO5XWRlQ0AOR297fJOOnNzuLA8xIZeRIZIc7YD9+BQ+hM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263324; c=relaxed/simple;
	bh=efLrKy8qqjkUcQS3cdfrbL+4GrIptjk7nMLVvA5SR+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSmMfpgdvD34Gs/H9crbDj0ac6Lmu+QcJOwcRMGJmfhwciGFWkpLWtit2UsFLVEgpEmtkRq3ysbStAUzdM3BRr6nedGen6Niwftq66jwGmy0Jp6Bk8BJO27dDaMx0GWzbYF4k/Wyv+F00ugl5Ho85OvZEDZwxCfcf/ZGIyZ0vvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjeYWDaT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjeYWDaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1D7C4CEE7;
	Thu, 30 Jan 2025 18:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263324;
	bh=efLrKy8qqjkUcQS3cdfrbL+4GrIptjk7nMLVvA5SR+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjeYWDaTI/Erq2G+HTE71scMidmYi/3xRv07FLFWP+R7bYy6gL/VRfQWQvGPcYUxp
	 oM7yMUHWhi7jLIeafRk0O5M7eSxNuBIOoq0sWl3NYcBfyI/URNejRL9IVYWAqOCc4n
	 5d4+/1GzUpkQToVn6JPxSS2F8gG0zlESpMEF+IeJPiVe/AZpmvYLoXghnyysZC2SaP
	 8gFKWJn9GVfuNWccdAa/HP1XEI4/aCkgWwznL/5GPvND7xrYGcsrIvJWdu5ZKySsXa
	 VU1E5tL/mhLMBMc7LLOGGhVXXaHJqG2eny6TI9yt5DuvTTBxDcYTV3zB/E4Qzk33IZ
	 Txu0JIkHmjZqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8DBC1CE37DD; Thu, 30 Jan 2025 10:55:23 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 4/9] rcu: handle unstable rdp in rcu_read_unlock_strict()
Date: Thu, 30 Jan 2025 10:55:17 -0800
Message-Id: <20250130185522.1652093-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
References: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

rcu_read_unlock_strict() can be called with preemption enabled
which can make for an unstable rdp and a racy norm value.

Fix this by dropping the preempt-count in __rcu_read_unlock()
after the call to rcu_read_unlock_strict(), adjusting the
preempt-count check appropriately.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  2 +-
 kernel/rcu/tree_plugin.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index c6c4aee47df2..9b05db8ff061 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
 
 static inline void __rcu_read_unlock(void)
 {
-	preempt_enable();
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		rcu_read_unlock_strict();
+	preempt_enable();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index bb7ca6eb9ef0..b025e95ede05 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -833,8 +833,17 @@ void rcu_read_unlock_strict(void)
 {
 	struct rcu_data *rdp;
 
-	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+	if (irqs_disabled() || in_atomic_preempt_off() || !rcu_state.gp_kthread)
 		return;
+
+	/*
+	 * rcu_report_qs_rdp() can only be invoked with a stable rdp and
+	 * from the local CPU.
+	 *
+	 * The in_atomic_preempt_off() check ensures that we come here holding
+	 * the last preempt_count (which will get dropped once we return to
+	 * __rcu_read_unlock().
+	 */
 	rdp = this_cpu_ptr(&rcu_data);
 	rdp->cpu_no_qs.b.norm = false;
 	rcu_report_qs_rdp(rdp);
-- 
2.40.1

