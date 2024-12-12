Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774BA1DD0F2;
	Thu, 12 Dec 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029560; cv=none; b=ml/t4C1j79yu77YxaBJSXxVimyhHwG9xM19pbMHCTbLTp0GCdKLXMMdXOaHhVxKV6r4m2tzn17chAwArn1JoC2z2pzfhg8sR5ZBHxeHn0OF9FXJoGTw/z/F87tGhwCFWIvXeF64/qURTCUl6W8x/24s/m3NHSNkusUAtJ4qYe0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029560; c=relaxed/simple;
	bh=EgjJ/pkU6eyu/0DLDvBmQw0nCmw113WYEA9zJwKpP60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GBTTn/DarvxJGDSMfLWFH1lpP3e2FEC52g+utzmnsns9p0wsNxVb/mgf7eXE0WqnQsjLmDEUdhkIk+N9cNU5dkrIwj5YoUiZhc8YB8rdULg/zQg8KMHbr43zIAGIg6BcTH3xyE5ojXzJR0D4SLOq7z7t8LefJJGzD68XUiAN6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W64mK47C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W64mK47C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5035AC4CED3;
	Thu, 12 Dec 2024 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029560;
	bh=EgjJ/pkU6eyu/0DLDvBmQw0nCmw113WYEA9zJwKpP60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W64mK47C5k01mPj+DxVY8FNrTPC0ra/Dd91ebZw26VctU08WUqoghDKEOqSgGBg0a
	 GMBvL4yYWHWD0rW5iSZE8QaPHPWkyZA94JeD2e4TmL1uuB0IowcZBJbchlM8OCmiuO
	 4jCRFWthwrwrcutIm1+spehVLqBNMV6nbB2owKP9cv0YevvfiB1PI3WweWif+oqUpa
	 b2TSCI7FggMLmGYzEAws0+sOGJXay7lJgj7IMJZMzFG2Tx4N7tH12u5GeYqpnZVgzi
	 hokB70vKie16qC9ADyDVLBbzJ68HOjRJqAyepOjeT3+RzWfoR4dB7eP54Q6g4hQsW0
	 ValB5irZwVsjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 06B3BCE0F53; Thu, 12 Dec 2024 10:52:40 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 1/2] refscale: Add test for sched_clock()
Date: Thu, 12 Dec 2024 10:52:37 -0800
Message-Id: <20241212185238.2207771-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f9bb99e2-4369-4ff1-9ec7-4a403a0f496e@paulmck-laptop>
References: <f9bb99e2-4369-4ff1-9ec7-4a403a0f496e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a "sched-clock" test for the sched_clock() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/refscale.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index aacfcc9838b37..1b47376acdc40 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <linux/torture.h>
 #include <linux/types.h>
+#include <linux/sched/clock.h>
 
 #include "rcu.h"
 
@@ -531,6 +532,39 @@ static const struct ref_scale_ops acqrel_ops = {
 
 static volatile u64 stopopts;
 
+static void ref_sched_clock_section(const int nloops)
+{
+	u64 x = 0;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--)
+		x += sched_clock();
+	preempt_enable();
+	stopopts = x;
+}
+
+static void ref_sched_clock_delay_section(const int nloops, const int udl, const int ndl)
+{
+	u64 x = 0;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		x += sched_clock();
+		un_delay(udl, ndl);
+	}
+	preempt_enable();
+	stopopts = x;
+}
+
+static const struct ref_scale_ops sched_clock_ops = {
+	.readsection	= ref_sched_clock_section,
+	.delaysection	= ref_sched_clock_delay_section,
+	.name		= "sched-clock"
+};
+
+
 static void ref_clock_section(const int nloops)
 {
 	u64 x = 0;
@@ -1130,9 +1164,9 @@ ref_scale_init(void)
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
-		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops,
-		&clock_ops, &jiffies_ops, &typesafe_ref_ops, &typesafe_lock_ops,
-		&typesafe_seqlock_ops,
+		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
+		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
+		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.40.1

