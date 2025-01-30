Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857511F0E51;
	Thu, 30 Jan 2025 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262968; cv=none; b=JS0IDvgRn/AiHHMAQM0RIxTmdnMoyu8HsJQ5QzpQo+UZkg7QAeRp8KJPRPfnFu/gtZrN8chzsexUaoqtlMN9IyO4Kyu5fJfbtpilg+WX39VrFKCj+Lx9kPgA+0Ek8FLRwreKvR5GFx3MLNttpjVdzmXqer25DNLkOvHek69QUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262968; c=relaxed/simple;
	bh=8xv5dwr+Q1Ceg+Jl4Hr+mTM9cUS7fLdtpRRTPhhkq7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KZZ0KOcINpBmnqQu6WV0suD3yGKorN4I50Ck49Are7yOQq+MRacxf/B1JmPO7ganTeiqcnoOJ+xMg8C2mtuDwoT29wZ2BYibn5fu+3zROLXaY8+Sg5WHCBmcHZ1ESuXPC1wZ6UNAPlmzcIl8BIUrjOfPI5vV8H4B6OrafLXLwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0oK3vtc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0oK3vtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74AFC4CEEA;
	Thu, 30 Jan 2025 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738262968;
	bh=8xv5dwr+Q1Ceg+Jl4Hr+mTM9cUS7fLdtpRRTPhhkq7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0oK3vtcQN6Bt1VRaYHQxgHKa8a7V1EXUkqHXMtyQ7HWQu/xQcerIiCu+avsSAsuH
	 ATRLfPeA23ddNaFJx61ri9+qB3PxPxfxxHfLW5/QSxgZMfjoqSL7dfXIZOjErTlDU/
	 bbB/PDcIIbit1K/5EBZ0V00vdDzWuVAwmQqglvsG7GuytgEkfGqgT6qfQIoZvkK2Dd
	 UWNukYbIPX+HykfeEgx71Xj/bae8DezeJmuzs+z5IBAyM+7OvBOSNtI65CLGW7ngTX
	 NJ1CEJO3qBJQ4hMKzliNSjZVGdenUdmQZThKlCU7hVttMQ0/hrIhqaQ/bhS9z9Ci7b
	 xbmLoW22nuVDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 38AC3CE37E2; Thu, 30 Jan 2025 10:49:27 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joe Perches <joe@perches.com>
Subject: [PATCH rcu v2 7/7] rcu: Remove references to old grace-period-wait primitives
Date: Thu, 30 Jan 2025 10:49:25 -0800
Message-Id: <20250130184925.1651665-7-paulmck@kernel.org>
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

The rcu_barrier_sched(), synchronize_sched(), and synchronize_rcu_bh()
RCU API members have been gone for many years.  This commit therefore
removes non-historical instances of them.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcubarrier.rst |  5 +----
 include/linux/rcupdate.h         | 17 +++++++----------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.rst
index 6da7f66da2a8..12a7b059654f 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -329,10 +329,7 @@ Answer:
 	was first added back in 2005.  This is because on_each_cpu()
 	disables preemption, which acted as an RCU read-side critical
 	section, thus preventing CPU 0's grace period from completing
-	until on_each_cpu() had dealt with all of the CPUs.  However,
-	with the advent of preemptible RCU, rcu_barrier() no longer
-	waited on nonpreemptible regions of code in preemptible kernels,
-	that being the job of the new rcu_barrier_sched() function.
+	until on_each_cpu() had dealt with all of the CPUs.
 
 	However, with the RCU flavor consolidation around v4.20, this
 	possibility was once again ruled out, because the consolidated
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 48e5c03df1dd..3bb554723074 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -806,11 +806,9 @@ do {									      \
  * sections, invocation of the corresponding RCU callback is deferred
  * until after the all the other CPUs exit their critical sections.
  *
- * In v5.0 and later kernels, synchronize_rcu() and call_rcu() also
- * wait for regions of code with preemption disabled, including regions of
- * code with interrupts or softirqs disabled.  In pre-v5.0 kernels, which
- * define synchronize_sched(), only code enclosed within rcu_read_lock()
- * and rcu_read_unlock() are guaranteed to be waited for.
+ * Both synchronize_rcu() and call_rcu() also wait for regions of code
+ * with preemption disabled, including regions of code with interrupts or
+ * softirqs disabled.
  *
  * Note, however, that RCU callbacks are permitted to run concurrently
  * with new RCU read-side critical sections.  One way that this can happen
@@ -865,11 +863,10 @@ static __always_inline void rcu_read_lock(void)
  * rcu_read_unlock() - marks the end of an RCU read-side critical section.
  *
  * In almost all situations, rcu_read_unlock() is immune from deadlock.
- * In recent kernels that have consolidated synchronize_sched() and
- * synchronize_rcu_bh() into synchronize_rcu(), this deadlock immunity
- * also extends to the scheduler's runqueue and priority-inheritance
- * spinlocks, courtesy of the quiescent-state deferral that is carried
- * out when rcu_read_unlock() is invoked with interrupts disabled.
+ * This deadlock immunity also extends to the scheduler's runqueue
+ * and priority-inheritance spinlocks, courtesy of the quiescent-state
+ * deferral that is carried out when rcu_read_unlock() is invoked with
+ * interrupts disabled.
  *
  * See rcu_read_lock() for more information.
  */
-- 
2.40.1

