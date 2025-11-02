Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20B2BEC4A;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154354; cv=none; b=J/CQ2lEk2UOTKitxXOjrPqiBriyf5cXAay/vjncK2SbrmQKFiwd9FdMW6k8MZR6IyVicZ64K6219l3lf7e4t6FYCDB4QaaqYyp5AGfcRsGTOoSpPlbCN0K1LrCD6u2bv/wv/Jx6oh06DVZjdBjyxJfQnz8cPq0Ekm4rFPHbDoxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154354; c=relaxed/simple;
	bh=LuhGHYxKKiGIAFnwvtKfy9cMeJ9OKzRJZ6z1CGVEEN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTjV3ZFDzTTZaFfFpHdkFb0wV/XJ0+cY28JMrcqakBWsLI6lxhr9XcvZYsZj6q013gdUFZeFByxAcuzQYnnaFNU7ifeNxZWZH8Z2oWgh6MDLOWCnGbayfXK1UxREZrDQUDFmSLR1LBxqZ4VLNGXU7z+8JOD/HCMp2B03Yc3m5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoXkWsu0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoXkWsu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47502C116D0;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154354;
	bh=LuhGHYxKKiGIAFnwvtKfy9cMeJ9OKzRJZ6z1CGVEEN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoXkWsu0Jv+mg1UfXUsDOiZUs81R4R+rk1KA4mpA+MQ5OwBF62BAR0H6e/VGGbKMb
	 o+d1pgunHZ9BkSeOuNHSWREPMiKIGoKvkZ3RUQSh24Cs474dIfbTKqd+Al1Yvelwjr
	 Fo5oeOSF7G2guDdv8zrSAAAVPfvUB3/f4em2aQ4whp42h8fZyCBB9yPi/CjTNvX6KH
	 MHCb78wsxOq8csnWfThl9m+U7G9hz3tkzhPHR7kb/c4+P5pYQybi0or7pxoVftsCHy
	 nB1adMokSWPB0HtOMl5jB3NsYSX1XtPO3FxEi72USUUyZFwgXEw6iETy0ESCecLQz2
	 PYtAf2G75SR4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EE471CE122D; Sun,  2 Nov 2025 14:49:49 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 4/8] refscale: Add preempt_disable() readers
Date: Sun,  2 Nov 2025 14:49:44 -0800
Message-Id: <20251102224948.3906224-4-paulmck@kernel.org>
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

This commit adds refscale readers based on preempt_disable() and
preempt_enable() ("refscale.scale_type=preempt").  On my x86 laptop, these
are about 2.8ns.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 1faed90231ab..ac9a0b6332ac 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -636,6 +636,37 @@ static const struct ref_scale_ops jiffies_ops = {
 	.name		= "jiffies"
 };
 
+static void ref_preempt_section(const int nloops)
+{
+	int i;
+
+	migrate_disable();
+	for (i = nloops; i >= 0; i--) {
+		preempt_disable();
+		preempt_enable();
+	}
+	migrate_enable();
+}
+
+static void ref_preempt_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	migrate_disable();
+	for (i = nloops; i >= 0; i--) {
+		preempt_disable();
+		un_delay(udl, ndl);
+		preempt_enable();
+	}
+	migrate_enable();
+}
+
+static const struct ref_scale_ops preempt_ops = {
+	.readsection	= ref_preempt_section,
+	.delaysection	= ref_preempt_delay_section,
+	.name		= "preempt"
+};
+
 static void ref_bh_section(const int nloops)
 {
 	int i;
@@ -1268,7 +1299,7 @@ ref_scale_init(void)
 		&rcu_ops, &srcu_ops, &srcu_fast_ops, RCU_TRACE_OPS RCU_TASKS_OPS
 		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
 		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
-		&bh_ops, &irq_ops, &irqsave_ops,
+		&preempt_ops, &bh_ops, &irq_ops, &irqsave_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
 	};
 
-- 
2.40.1

