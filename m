Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FAE2C21E8;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459716; cv=none; b=Mmb3SA9cIpRfsSImbutYvVtUdS6PTT8WL+jaICdk4NwrEu8khlx4wECgtmqaR17QluuXv+peX8vnyEJvkzybcF21UcON1drYOSFrWxpexy+5fsN5R7UKLnAXOD7nad0l4Q84NnkKT/+cG+VLXAPw4PmSYOFfsgflzMGdQlMXpM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459716; c=relaxed/simple;
	bh=i3dpuzl5wq1SgKz9jERsgeQa0FmhFGU2MN/ftPoAV74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFgRctYtElugh8+AutHRCycJF5hsp4GxDV+nYq+Bvag7Ks5f83kGHwCodSc62p8+gfm1y85ztAl2buz6nKJbWjPx2jihmfie4yd/mwF9OWVqstp52N9TqqEFCy+y1Pkxi5WWj2NltYM8UHwPAsX4kVCxebCsdQNRc2xYWv2RQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9MlRVNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9MlRVNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E861F00AC4;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=dI4sNn2eMnZtgM/Uui4WwC3vWER8RnYm1wD6B3jhCRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M9MlRVNKDxBhmPaeYCpF8opyoOuUYNfclE4P9f5p/rD5gIKclpEr6YWbJHBfR2GWc
	 iHMBdV4MUGzEmBWy1QdkGJ1bboeJYUcpv92n6tat8ZOItzM+XVEVM95LdN12oFF5/h
	 sZiRv7P2LiyJnXqnDiUbvodBNMZpjhnYJJt5rAYZDnh1jmblC8WhLuvKn3OwXyLqiK
	 dmpLlmQ3zqZs8zdzLUsZazInJYwlT8wXdYeeWmh6MNnV7ykjkOoyiprs+vmEm2MP9k
	 Gx/TCRgfezuN1jedjikarqRzZD3YJH2bbcgFt86bjeAP/quUFvSTG7AQxIxDcfsNlj
	 6iInIMcUflBpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AD53FCE100D; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 05/16] rcu: introduce rcu_defer_qs_clear() helper
Date: Thu, 30 Jul 2026 18:01:42 -0700
Message-Id: <20260731010153.3531313-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
References: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joel Fernandes <joelagnelf@nvidia.com>

Currently rdp->defer_qs_pending transitions from DEFER_QS_PENDING to
DEFER_QS_IDLE at two sites: rcu_preempt_deferred_qs_irqrestore() and
rcu_preempt_deferred_qs_handler() (depth>0 reset).  Both write the
IDLE value directly.

Introduce a single inline helper rcu_defer_qs_clear() in tree.h and
route both sites through it.  This becomes the single
PENDING->IDLE transition point for upcoming work.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h        | 5 +++++
 kernel/rcu/tree_plugin.h | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7dfc57e9adb18e..4069132f9d4446 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -296,6 +296,11 @@ struct rcu_data {
 	int cpu;
 };
 
+static inline void rcu_defer_qs_clear(struct rcu_data *rdp)
+{
+	WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
+}
+
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
 #define RCU_NOCB_WAKE_NOT	0
 #define RCU_NOCB_WAKE_BYPASS	1
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 95ad967adcf3cb..8637f405cb472f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -488,7 +488,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 
 	rdp = this_cpu_ptr(&rcu_data);
 	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
-		rdp->defer_qs_pending = DEFER_QS_IDLE;
+		rcu_defer_qs_clear(rdp);
 
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
@@ -645,7 +645,7 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	 * 5. Deferred QS reporting does not happen.
 	 */
 	if (rcu_preempt_depth() > 0)
-		WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
+		rcu_defer_qs_clear(rdp);
 }
 
 /*
-- 
2.40.1

