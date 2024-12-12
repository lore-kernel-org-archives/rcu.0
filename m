Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4B2253E2;
	Thu, 12 Dec 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028778; cv=none; b=P1Iw1YArS9a7yoLZv+9m8PGwASqEGOnRMo0tGbGc4eFEWu4awCUwLeZ0jGdVdCt7P+W79XqN2akfm1eBKw5MpL7ZBBcNXgl4nTZIi2Rqjb7ig0Pv1dBVwRz10+7cxncmQMqOhc6R5x8Lz8zGB2ZYF+50nn6xLmgBN9QIUYNJHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028778; c=relaxed/simple;
	bh=NPrDpbJ1EYy/FKp6+0iFszw6r20I/MKhMPqZuoOvBWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqp7b1Ks3uVIp8nJm1gmC1RXxCjIj0NhueQ4PB38H9dRa036rF7WL99R21Z38Q4sMfKTi1TMStrSUVhSPL5oR5PnHYTt3yIziQ4NzAOYMZ569vwgklwHkGghXF0xaMI58e9+GL1kID7T6gpFgzYpvi17hrD2z4Hzhh1hD0URDlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGnfxG/m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGnfxG/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE085C4CEE6;
	Thu, 12 Dec 2024 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028777;
	bh=NPrDpbJ1EYy/FKp6+0iFszw6r20I/MKhMPqZuoOvBWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGnfxG/miUSrtoIo2HEXANEwnjjjg6FHXGttSUbXLVeyAAlJ1VVOl+JcLiH40X7vE
	 q1Lx3QM3rZ9XnjGNQAf/GhrI5vUC7RN4ntCmszZJYFl9O76d564cO7NdZl5kettB74
	 tDmAWwv1y9IrHXpfwqnKY6n7kD5R9f+uTEfyfqUuqtMEbGW4IcsdbOqqnbpf0OICLl
	 XJYaNcfCxfQZ0ou6gmL8/2gUWSJJ6Ik1vWq7d4560aTDdi1GDJVUjFugVeNlf4ZcJh
	 q0+ZC3yIwOvWTTkW1SF1DTti/pnk2HlwJjQ4K46SH9OqXXrtb7u+64CPjMnG3MB0zd
	 lhf3dSFyyKYdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 48635CE0FF1; Thu, 12 Dec 2024 10:39:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 6/8] rcu: Add KCSAN exclusive-writer assertions for rdp->cpu_no_qs.b.exp
Date: Thu, 12 Dec 2024 10:39:34 -0800
Message-Id: <20241212183936.1936196-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
References: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of rdp->cpu_no_qs.b.exp may be changed only by the corresponding
CPU, and that CPU is not even allowed to race with itself, for example,
via interrupt handlers.  This commit therefore adds KCSAN exclusive-writer
assertions to check this constraint.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h    | 4 ++++
 kernel/rcu/tree_plugin.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6985c998fe6b1..ce5b09921d04e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -262,6 +262,7 @@ static void rcu_report_exp_rdp(struct rcu_data *rdp)
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	WRITE_ONCE(rdp->cpu_no_qs.b.exp, false);
+	ASSERT_EXCLUSIVE_WRITER(rdp->cpu_no_qs.b.exp);
 	rcu_report_exp_cpu_mult(rnp, flags, rdp->grpmask, true);
 }
 
@@ -721,6 +722,7 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
 /* Request an expedited quiescent state. */
 static void rcu_exp_need_qs(void)
 {
+	ASSERT_EXCLUSIVE_WRITER_SCOPED(*this_cpu_ptr(&rcu_data.cpu_no_qs.b.exp));
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
 	/* Store .exp before .rcu_urgent_qs. */
 	smp_store_release(this_cpu_ptr(&rcu_data.rcu_urgent_qs), true);
@@ -753,6 +755,7 @@ static void rcu_exp_handler(void *unused)
 	 * sync_sched_exp_online_cleanup() implementation being a no-op,
 	 * so warn if this does happen.
 	 */
+	ASSERT_EXCLUSIVE_WRITER_SCOPED(rdp->cpu_no_qs.b.exp);
 	if (WARN_ON_ONCE(!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
 			 READ_ONCE(rdp->cpu_no_qs.b.exp)))
 		return;
@@ -867,6 +870,7 @@ static void rcu_exp_handler(void *unused)
 	struct rcu_node *rnp = rdp->mynode;
 	bool preempt_bh_enabled = !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
 
+	ASSERT_EXCLUSIVE_WRITER_SCOPED(rdp->cpu_no_qs.b.exp);
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		return;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3927ea5f7955c..bb7ca6eb9ef04 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -275,6 +275,7 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 		rcu_report_exp_rdp(rdp);
 	else
 		WARN_ON_ONCE(rdp->cpu_no_qs.b.exp);
+	ASSERT_EXCLUSIVE_WRITER_SCOPED(rdp->cpu_no_qs.b.exp);
 }
 
 /*
-- 
2.40.1

