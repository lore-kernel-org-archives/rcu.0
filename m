Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16E92BCF54;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154353; cv=none; b=TpYBgFzsLUEgKIdbiGUDJRBbnKdLmpwjMddF53KE+ynwzVXsoK+cfdLJK4myw7wg61Wrvw/MtuWFdHdkHiPYQKPhf6xSSRmFo6AjPDS5l2827YpOGfpvc2RQJaj8MUWpv5aUiBcp3QNF7QFntgERJ2Th9JhNLIc0AvRRAB5Dpfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154353; c=relaxed/simple;
	bh=9BQtYTW3cHMDKjYUKt5ajghnwRdt9/BJ0CAqZSRRKGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kOiRRKSpeG/K8ZRwecIc6epnd2ft1C91xjnARGv8W5CaAsbO8/Rq6n7BkpuYPdR81KCZT1fsxJeqO4y7aargbXNSsbRqYSEbp++HJhp7FRpCwBsq+uObjhAtYySLMNHgnWjvZ6YCOmB79dR6I7aKqZaKyT8pjoVvT+6Cnjc3qgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f15oXOG0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f15oXOG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F5AC4AF09;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154353;
	bh=9BQtYTW3cHMDKjYUKt5ajghnwRdt9/BJ0CAqZSRRKGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f15oXOG0GdvLlDZXnXqDvwKiR7A6FLAhGnxcZeY9f7xArdDA3sGf4w8rlr7/ZVHQV
	 DRhuap1Z/g1aTt+u/IlZcIV8VjDEjW0kI2mT3W+r1LgNepPmhN4ExMc7qUu1AmBMle
	 lu2jJQ/Oss+vXIU0va80yTmR5iA+tPgQOzR8blMp1oGGqejpEV62kbPKdNqgadtIsM
	 vSOY9wWuO6u6fWnewLbCJ5nCZkk4vfwfAb8YGWn+MR3l3qeGVQAuEIiDomFqM6vVHB
	 4vGDR5+Pz2vq9A8wa72jjiN9IX2R2+dzVKBvN6ZjuRLbOhNfx+SEZMslggLXhxhice
	 NpIQcrWHI6EvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EB6F5CE1104; Sun,  2 Nov 2025 14:49:49 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/8] refscale: Add local_bh_disable() readers
Date: Sun,  2 Nov 2025 14:49:43 -0800
Message-Id: <20251102224948.3906224-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
References: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds refscale readers based on local_bh_disable() and
local_bh_enable() ("refscale.scale_type=bh").  On my x86 laptop, these
are about 4.9ns.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 266a3fa94b54..1faed90231ab 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -636,6 +636,37 @@ static const struct ref_scale_ops jiffies_ops = {
 	.name		= "jiffies"
 };
 
+static void ref_bh_section(const int nloops)
+{
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		local_bh_disable();
+		local_bh_enable();
+	}
+	preempt_enable();
+}
+
+static void ref_bh_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		local_bh_disable();
+		un_delay(udl, ndl);
+		local_bh_enable();
+	}
+	preempt_enable();
+}
+
+static const struct ref_scale_ops bh_ops = {
+	.readsection	= ref_bh_section,
+	.delaysection	= ref_bh_delay_section,
+	.name		= "bh"
+};
+
 static void ref_irq_section(const int nloops)
 {
 	int i;
@@ -1236,7 +1267,8 @@ ref_scale_init(void)
 	static const struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &srcu_fast_ops, RCU_TRACE_OPS RCU_TASKS_OPS
 		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
-		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops, &irq_ops, &irqsave_ops,
+		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
+		&bh_ops, &irq_ops, &irqsave_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
 	};
 
-- 
2.40.1

