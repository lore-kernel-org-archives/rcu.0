Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153CB18FDCE;
	Thu, 30 Jan 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262968; cv=none; b=UBXLJU+g8AK/Sye5jZNnFnEYQ2GiTYSHNVHgdbm2o0rL9mcj5/XQ4TDuZv1l0W/6iERrZ6336qlm1/c7bTyTzKf8Gj0HDCFmOokQy+YF6gFt03mtayfMwSCqAhvl/oISUXeSK6dr9hTw2fADY3rCG+A0rPUX+MBDRHBsIJhf8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262968; c=relaxed/simple;
	bh=yoC9OP6s92AXVsVN10VonOg90I/4EWnjKGqOWBcb8Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KIYs7vTEdVstljQoeaYxvGbueTqCNOsRRLjrrXa9Qyez7ltvZA+7LktuZ1cjcjKUKT75IkSEw+gkeRuVOMJDcRS0UfJqHAk3j57e3fh3Y3aDvb7xScXC10ag9cbr7w7wuSR2jPM8s2NU5blZb9J01MPfKlogVJLtuWQOOqbA1DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvqP9Dli; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvqP9Dli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F78C4CEE3;
	Thu, 30 Jan 2025 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738262967;
	bh=yoC9OP6s92AXVsVN10VonOg90I/4EWnjKGqOWBcb8Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvqP9DliyLTTXhwpDWyw/+lsoaYgg3soWJKUazXcrVY3fQPpUcLpfMow7Z8urlBlZ
	 qXpmAHWpsiE3VTtg57z04R6pjPCwbp05dYifmI2QOeZ6jhz8Mqtg2qhnJaHV67NQCK
	 3fNF4ZL1arasyixGawkdqYDH3i67hS3VALtj/9RgyojN/OcriXHBd3gtrxFlhiJ1L4
	 YHJljPW3CjfD7nL5Rq8++d88NbEFsWY0o8CNEHPNOBi/GVs8oOoNYdgmVEfLRKvtVk
	 MneLr40EivztD0KgEkjDUEYsruni2DEMbUvPkpzkyy5FwX6hwwbFrsKFcX+nC+TEQC
	 E0ONRO0UczmMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 30D3ACE37DD; Thu, 30 Jan 2025 10:49:27 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2 4/7] srcu: Point call_srcu() to call_rcu() for detailed memory ordering
Date: Thu, 30 Jan 2025 10:49:22 -0800
Message-Id: <20250130184925.1651665-4-paulmck@kernel.org>
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

This commit causes the call_srcu() kernel-doc header to reference that
of call_rcu() for detailed memory-ordering guarantees.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b83c74c4dcc0..f87a9fb6d6bb 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1398,8 +1398,12 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
  * read-side critical sections are delimited by srcu_read_lock() and
  * srcu_read_unlock(), and may be nested.
  *
- * The callback will be invoked from process context, but must nevertheless
- * be fast and must not block.
+ * The callback will be invoked from process context, but with bh
+ * disabled.  The callback function must therefore be fast and must
+ * not block.
+ *
+ * See the description of call_rcu() for more detailed information on
+ * memory ordering guarantees.
  */
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	       rcu_callback_t func)
-- 
2.40.1

