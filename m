Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEAB12DDB2;
	Fri, 17 May 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959393; cv=none; b=PmKvgxyNu6+o62sVFkS3urpiBEEfOnt20bPXMQQRCMxWnYc/7ngJaekswM7jsv0gx8/PboT/0lTjpID9VSAzJVR/GYKQYGvyls5Bv7lee8NUXorRF+q6mPG6QmxCsbHn2NbOCVuXp1uj4XmaJPV7c18oBA7eCer8uBCZnhZoizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959393; c=relaxed/simple;
	bh=dCPBNm5XG7KcpOZZ3bbUTe1uj7ZPUYusD02ZamB9Xa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fprfqKcI2qXco6tFl/2E82ydm9KNJbDVeav60XX+PkYuERMNJm4nMms2mTKNoyFR8qEyXRUU8BUJjfIrPgFdd5YGgOiA5LlpdxmuJKv8mYQ+Um7/zfomZr/bQUfDkmGvFFiSEZ/7E8KPZPTsQIsRBFpy4qhgQM5ITMa6GGUND0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grVB+SUq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grVB+SUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA4BC32789;
	Fri, 17 May 2024 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715959393;
	bh=dCPBNm5XG7KcpOZZ3bbUTe1uj7ZPUYusD02ZamB9Xa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grVB+SUq0oM1ILAxe3WbMaKnAKdugjKkH1Gwb1GCBLLmtrhS8QuHiIvpOlC+J7PRs
	 AR2HieUyfD06cQbBP0VDlltmnho/aaq6s3HlXbUFvmWW57liAJMsHKUKbFQ8azc504
	 WxsPVVffKLZgMD3PmgjfGjgbhYIq2Ao4tt9AD8AjGoz4RNhOkJt205aIiPAbbUbm00
	 5HGY2vFZqp2HRJU2dLdVKch+z2yYTA9brKog0aJpHPF847xorD3xKIr9Gj9uUjkC/T
	 +3jscrf3aB5uOrCxE7Q3e8VRrXcGVJIVoH0khAwXl8zgxW8Zk/MDULMNncXwXNQj9r
	 RF948QAhkUimg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] rcu/tasks: Further comment ordering around current task snapshot on TASK-TRACE
Date: Fri, 17 May 2024 17:23:03 +0200
Message-ID: <20240517152303.19689-3-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240517152303.19689-1-frederic@kernel.org>
References: <20240517152303.19689-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Comment the current understanding of barriers and locking role around
task snapshot.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tasks.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6a9ee35a282e..05413b37dd6e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1738,9 +1738,21 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 	for_each_online_cpu(cpu) {
 		rcu_read_lock();
 		/*
-		 * RQ must be locked because no ordering exists/can be relied upon
-		 * between rq->curr write and subsequent read sides. This ensures that
-		 * further context switching tasks will see update side pre-GP accesses.
+		 * RQ lock + smp_mb__after_spinlock() before reading rq->curr serve
+		 * two purposes:
+		 *
+		 * 1) Ordering against previous tasks accesses (though already enforced
+		 *    by upcoming IPIs and post-gp synchronize_rcu()).
+		 *
+		 * 2) Make sure not to miss latest context switch, because no ordering
+		 *    exists/can be relied upon between rq->curr write and subsequent read
+		 *    sides.
+		 *
+		 * 3) Make sure subsequent context switching tasks will see update side
+		 *    pre-GP accesses.
+		 *
+		 * smp_mb() after reading rq->curr doesn't play a significant role and might
+		 * be considered for removal in the future.
 		 */
 		t = cpu_curr_snapshot(cpu);
 		if (rcu_tasks_trace_pertask_prep(t, true))
-- 
2.44.0

