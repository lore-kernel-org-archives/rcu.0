Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E371E30215C;
	Thu, 18 Sep 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190675; cv=none; b=sS8Wo8Vpr389XZeIx4FevNC2FvbkhJiwUgpGZ4ntWB8tF3p6NtTtx0NRN6QeDW5oF4vbCNqNeuOVs3drWx0g8qMnZD4yAX0hv0KcPuMMpHzRdqXG32Jatp0IQKEUyUWzc10bUx+fw2MVczH2nyt7IkzW/a+/RWPsbm1HcM47k0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190675; c=relaxed/simple;
	bh=rq+Ub4PUmYMUmVVmwp0dloL83Muh245hgWWFkowVhoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S0+jl+YGVW+gOmQY728qdxPGYZvsdoYkdTNwNkl/e7RLo0wbEATxLdOnX/Wl6xxSMd+PNNC+YsQSWRRZRuvqa7Jje4hoKe0Q2UTycudP00W6Kko0IFHDSDhwaOuAqy0Cr87b9uC1e+M7BgcOKjzBe2C6NDzu6ftT9DKjj0S+g/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJISAZut; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJISAZut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90283C4CEF7;
	Thu, 18 Sep 2025 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190674;
	bh=rq+Ub4PUmYMUmVVmwp0dloL83Muh245hgWWFkowVhoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJISAZutESJCuvWl0KKfu9OQ2JV04oaraSTyjAud3PkdnU7nqKzW/8kGxl7YmakUS
	 dPEFe+Ajj+5ywh7ZSSzpNRupqEiy63T+9/5Tlu4EGVq6xHJ1PnfOy05bpBWtMBfTbP
	 4C5jvxT6rGBuDSz85m43OQ8MnGeCIxtfePR/Cszth/BYJP1utxfyYr737Yp5n51qEG
	 p3Lnl/0kbC9ejhNa4E6vz2igf6rs9XTr3wUFspvqhaE3XygJpebVgNASshjV1ea0oJ
	 WrAnKYKSsdgfqjzv96jcyq1PKhXfHS6287P0+hINnQQ79UDkXRwdHGGNkqsOX/dYwC
	 Tj+IxYWz1YgLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 14972CE0D66; Thu, 18 Sep 2025 03:17:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 2/5] rcu: Remove local_irq_save/restore() in rcu_preempt_deferred_qs_handler()
Date: Thu, 18 Sep 2025 03:17:49 -0700
Message-Id: <20250918101752.2592512-2-paulmck@kernel.org>
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

From: Zqiang <qiang.zhang@linux.dev>

The per-CPU rcu_data structure's ->defer_qs_iw field is initialized
by IRQ_WORK_INIT_HARD(), which means that the subsequent invocation of
rcu_preempt_deferred_qs_handler() will always be executed with interrupts
disabled.  This commit therefore removes the local_irq_save/restore()
operations from rcu_preempt_deferred_qs_handler() and adds a call to
lockdep_assert_irqs_disabled() in order to enable lockdep to diagnose
mistaken invocations of this function from interrupts-enabled code.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4cd170b2d6551d..d85763336b3c0f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -626,11 +626,10 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
  */
 static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 {
-	unsigned long flags;
 	struct rcu_data *rdp;
 
+	lockdep_assert_irqs_disabled();
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
-	local_irq_save(flags);
 
 	/*
 	 * If the IRQ work handler happens to run in the middle of RCU read-side
@@ -647,8 +646,6 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	 */
 	if (rcu_preempt_depth() > 0)
 		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
-
-	local_irq_restore(flags);
 }
 
 /*
-- 
2.40.1

