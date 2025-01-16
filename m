Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB2523F263;
	Thu, 16 Jan 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057762; cv=none; b=TrqCwjNN7ffrPWkJukPoSppB7sQfmggW3YcktxOAbM1nD5s+mVJNqARyMjdj/6y95qs/KSUnzv5JhzzY8pavDyv6z8MczXaYwYtUNWgCv/txdF7oP7Lp9NZ9tdINcIb4w5mPjzauKToy2IZYVX+Q6JhQoCrcexqw1AQPK0dw2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057762; c=relaxed/simple;
	bh=YaVLSsW7PyxGcjEkwPWdmu0BULuqG4DED/ZbOXpCbco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i8EzY2wcBXcX0UcUWXhkIDYRzxd8zEbu8DsPxiwiEL+xd2faIEsb3WRSzZYlPP6UdeEanP2U14lcCn2q4Aqne7TUQLR7q3T3ORDEC8C9v3d++I48/APLiIbGi3aFnt1qR7Fa9S2VEg9NvuTB6ARfTMxrQJ5C31asb2+gFl9Xv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTJTGboL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTJTGboL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC825C4CEEA;
	Thu, 16 Jan 2025 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057761;
	bh=YaVLSsW7PyxGcjEkwPWdmu0BULuqG4DED/ZbOXpCbco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTJTGboLdcqnAM3RTXIFIl/yBcPpuXefkftz9oN74iS7GZh0sqiIpoAZK9p55s7LN
	 QYtYHHCJO4ZKbEu5zpdXme76XbGRIBq/xpbCN+plW1gDohXUTq3tjBNSKDx+xPMDwj
	 AdCmfPMfyl1uQMHyRm5XRe9kKDgNpSgIkDDs6156uB5uxrJbmn8bQHZDTE55+Ni/Ws
	 uSswqK8mtZBo8INMSEgXU5l4roXTG55/7Ay9JK2WhkDf2zyYVbcMH9DGYezdOA9f7z
	 Weajtk9AWqnmsYBh6rDxqJqAr73GeB/C/xlcwR63yMTtjrqzbgX/cp1bM17glN7NhV
	 7eElULNEKVjnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 37005CE37D2; Thu, 16 Jan 2025 12:02:41 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joe Perches <joe@perches.com>
Subject: [PATCH rcu 7/7] rcu: Remove references to old grace-period-wait primitives
Date: Thu, 16 Jan 2025 12:02:39 -0800
Message-Id: <20250116200239.3782374-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
References: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
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
index 6da7f66da2a80..12a7b059654f7 100644
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
index 48e5c03df1dd8..3bb554723074d 100644
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

