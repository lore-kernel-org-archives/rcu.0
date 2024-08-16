Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBE13777F;
	Fri, 16 Aug 2024 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791109; cv=none; b=jPiSODnJX6E7r4A0x2HCybWld/AbsmyhqaLpMh3vhKWMk/GVslFoSavIbVfSubAb7IhTwyYtqvV21WISOavzGn0ZbkfOe0vTZuM/xT1JXew94QHXDUO42Pahc36bU7jDYgGu+TuaQ5k1LYSau+ek8UZMLN1dp6VJl2z+qliQS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791109; c=relaxed/simple;
	bh=D8s5bN3jgVM8JPbRgvLUs8ZVTdCwr1h49SMsmogsp08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YumHu4TzzXclsGM1wsthdrKeF70kQ2ISWMs9jnR2lUptpT+6V893m/WHroa9n33XNomgJGgGFfw4LlvwnklY6Va2C4LwNcVTYYYNCmGifi65rdYKpEbt7S9LgALDXh3WpSWJ8IIX4BKRwzewiVaui8OlXoyDal/fourcSlcM+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbGtZ28N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbGtZ28N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E1CC32782;
	Fri, 16 Aug 2024 06:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791109;
	bh=D8s5bN3jgVM8JPbRgvLUs8ZVTdCwr1h49SMsmogsp08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbGtZ28NtVnsK3IecxIH0GNuFtvvK8noARrlYH8vqERTjYRg/J9DTVcG6a+i8PeMK
	 WbVjnCdRcKwu4GlmCjjNzX1UP2GQcubhd0A5vx40WxEwMlRT2Ra6FcUmLiTFnbXxlb
	 3EJr5jRtwB3ev8/ZI15CoSSyKCkf92j70vJ21b6eYqRrC6RepL06H7twsMsYXpr5SE
	 2/+l7XsEjKD+q3GePzoH8AqMHHoVsDjwwF773rQEQ3F1TJ31uPi7JjslId1Wx1Blf0
	 VcKcVe8zaAxn5gGeQ9R9SdA5EIlVBz8q7DeXDRy+MtyDZBNiXzcwkXwa4Sdz9sVJmP
	 KFUgU8bEauLLw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 12/12] rcu/tasks: Add rcu_barrier_tasks*() start time to diagnostics
Date: Fri, 16 Aug 2024 12:19:21 +0530
Message-Id: <20240816064921.57645-12-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816064730.GA56949@neeraj.linux>
References: <20240816064730.GA56949@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the start time, in jiffies, of the most recently started
rcu_barrier_tasks*() operation to the diagnostic output used by rcuscale.
This information can be helpful in distinguishing a hung barrier operation
from a long series of barrier operations.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tasks.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 5f6d80ce1e47..36be92efb0da 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -87,6 +87,7 @@ struct rcu_tasks_percpu {
  * @barrier_q_count: Number of queues being waited on.
  * @barrier_q_completion: Barrier wait/wakeup mechanism.
  * @barrier_q_seq: Sequence number for barrier operations.
+ * @barrier_q_start: Most recent barrier start in jiffies.
  * @name: This flavor's textual name.
  * @kname: This flavor's kthread name.
  */
@@ -122,6 +123,7 @@ struct rcu_tasks {
 	atomic_t barrier_q_count;
 	struct completion barrier_q_completion;
 	unsigned long barrier_q_seq;
+	unsigned long barrier_q_start;
 	char *name;
 	char *kname;
 };
@@ -430,6 +432,7 @@ static void __maybe_unused rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
 		mutex_unlock(&rtp->barrier_q_mutex);
 		return;
 	}
+	rtp->barrier_q_start = jiffies;
 	rcu_seq_start(&rtp->barrier_q_seq);
 	init_completion(&rtp->barrier_q_completion);
 	atomic_set(&rtp->barrier_q_count, 2);
@@ -785,8 +788,9 @@ static void rcu_tasks_torture_stats_print_generic(struct rcu_tasks *rtp, char *t
 		pr_cont(".\n");
 	else
 		pr_cont(" (none).\n");
-	pr_alert("\tBarrier seq %lu count %d holdout CPUs ",
-		 data_race(rtp->barrier_q_seq), atomic_read(&rtp->barrier_q_count));
+	pr_alert("\tBarrier seq %lu start %lu count %d holdout CPUs ",
+		 data_race(rtp->barrier_q_seq), j - data_race(rtp->barrier_q_start),
+		 atomic_read(&rtp->barrier_q_count));
 	if (cpumask_available(cm) && !cpumask_empty(cm))
 		pr_cont(" %*pbl.\n", cpumask_pr_args(cm));
 	else
-- 
2.40.1

