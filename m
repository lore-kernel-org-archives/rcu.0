Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF91168DA;
	Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558869; cv=none; b=g5tTesnLxmNwuZ2ZKwmtlYHQutUKCRp3ysJozvP97M+dYhaCr+vXRRpl7ReAhtMbshQ6pK7anD7cQOSW9WktfETquETYpdVlhhjGS4o7VUvn1ev3hX0BWievQZDUKHINzNXMjPmscUT5lj4huM15gmsPQFzOXi7nzfz1PWLPRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558869; c=relaxed/simple;
	bh=9C6fIiB/R+CnzPnUcGPw5yPIwJNQLck0Q+T4uibP3zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FR4NNSiRbGFMtnlUEUyicKH7RVslS59NvUD01QMP5MdFgAmhl4Ax9/bzkqBXrKA7swwr5mw6vP5c8y9PT8aEsFCM+iNdRC7aC9xOYP5h5EXy0okgV++vjuJUAkX9mDbBFMyO5Fih6VhKWRCMRFmm6lNpiH98vuYAzDS3QkoYt60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJeZdika; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJeZdika"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9903AC4AF15;
	Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558868;
	bh=9C6fIiB/R+CnzPnUcGPw5yPIwJNQLck0Q+T4uibP3zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJeZdikadeB8zMehwiJaMByVnqDWfOB3bNNwugWjvE2xxBNfwVH1DVEsGCcBSeClk
	 3+2gy5m6qBgoO/uvVtqXx7wDnibQISE9gYfIoA6FLMV9rxYqMAomKlY1BPr00OHLG1
	 PpOk2SILhUlN//PCThh5Mm25O+9YaWmgYa6CE/iz8yEQwcAJzl6Y5cFj/6DN0hnzuT
	 CQBUbDw6Z8Hd5SCoTEawSavdT6BU9I5xCrVdV1eRTNs4gbC6gdKzNuolO0JUTeuKit
	 bJkemCSDdjGh6wkaDprZXWVS7r6ZgDBxk3tKJ6T3a9LvaD3ikZlNAwSZJCrXzYOvs6
	 q3WQntdSCc8Tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EF11CCE0FA1; Thu,  1 Aug 2024 17:34:27 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/6] rcu/tasks: Add rcu_barrier_tasks*() start time to diagnostics
Date: Thu,  1 Aug 2024 17:34:26 -0700
Message-Id: <20240802003426.4134196-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
References: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the start time, in jiffies, of the most recently started
rcu_barrier_tasks*() operation to the diagnostic output used by rcuscale.
This information can be helpful in distinguishing a hung barrier operation
from a long series of barrier operations.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 37597f7c581ca..2f8d6c8e3c4ce 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -85,6 +85,7 @@ struct rcu_tasks_percpu {
  * @barrier_q_count: Number of queues being waited on.
  * @barrier_q_completion: Barrier wait/wakeup mechanism.
  * @barrier_q_seq: Sequence number for barrier operations.
+ * @barrier_q_start: Most recent barrier start in jiffies.
  * @name: This flavor's textual name.
  * @kname: This flavor's kthread name.
  */
@@ -120,6 +121,7 @@ struct rcu_tasks {
 	atomic_t barrier_q_count;
 	struct completion barrier_q_completion;
 	unsigned long barrier_q_seq;
+	unsigned long barrier_q_start;
 	char *name;
 	char *kname;
 };
@@ -428,6 +430,7 @@ static void __maybe_unused rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
 		mutex_unlock(&rtp->barrier_q_mutex);
 		return;
 	}
+	rtp->barrier_q_start = jiffies;
 	rcu_seq_start(&rtp->barrier_q_seq);
 	init_completion(&rtp->barrier_q_completion);
 	atomic_set(&rtp->barrier_q_count, 2);
@@ -783,8 +786,9 @@ static void rcu_tasks_torture_stats_print_generic(struct rcu_tasks *rtp, char *t
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

