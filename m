Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CFB188736;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029400; cv=none; b=fgeRv1YaS2XctRTDLVCQMCmVA0t0taj8IR5EtJLxyK0lx6L6R9fkCUjKIuiKQEeJtoXxOOjgdK/WGRBnTHwLuhvIeAJ+liCiE4rAI/E87PZlz2QqWNW2rhFevcFeRqh9y9ewiGQD+j+5vdsCVYFlituK6owV5XJGpxHDteAI+IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029400; c=relaxed/simple;
	bh=2EcSl9m94OfpZsmwac22XD3a277QHniUKqccAA9fc2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMmHKiRkLSh9e1KU7ngk+fQk3hQ4fm6y2ePpuyqEHv3WSCk1DC4Ja29Ql73H3fiMrfNOr7qdTD1oIkRcxRhRwx6sG6atl0Sym5CXqs9Jj2wA09+tCKr4qUC5cRCH82e7JlaC8osZSoVriYp1bRHAEpedPwbSXftBwUXXzf5fXK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRIqd7xP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRIqd7xP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1355AC4CECE;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=2EcSl9m94OfpZsmwac22XD3a277QHniUKqccAA9fc2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRIqd7xPlDiqk4b+b04e1aqcjMt0cL8HWnvefJV0qEq7/jLRX0KXkIyFuBSztAhTv
	 IVIiC0yrcWXpLVo4VWImdquk1GxDRAOzMBFSurpNUndU1AxYLNqQtmLFzWpkJ95cFh
	 0YMPq9eWfFNcxS/fkKwvht4M9CUOBg2PuHUhvnVBrnV61m1DnxqVGaBPAoBYPFR9ld
	 pRZjlUFWqfJuLjT1WeKbdtvUofYZWiwSvxVMqTkCqdAt93znixikVBSZNX59tEaT0g
	 jDBx56MShjnDw+RPNwkbyw0Wov7wkPLMGDIAlNouOuwlNhmaeZ4Sv1kW2Lagu8mMMk
	 BJpDUNQbjEntQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B4213CE0F53; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/18] torture: Add dowarn argument to torture_sched_setaffinity()
Date: Thu, 12 Dec 2024 10:49:40 -0800
Message-Id: <20241212184957.2127441-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current use cases of torture_sched_setaffinity() are well served by its
unconditional warning on error.  However, an upcoming use case for a
preemption kthread needs to avoid warnings that might otherwise arise
when that kthread attempted to bind itself to a CPU on its way offline.
This commit therefore adds a dowarn argument that, when false, suppresses
the warning.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/torture.h      | 2 +-
 kernel/locking/locktorture.c | 6 +++---
 kernel/rcu/rcutorture.c      | 2 +-
 kernel/rcu/update.c          | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index c2e979f82f8d0..0134e7221cae6 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -130,7 +130,7 @@ void _torture_stop_kthread(char *m, struct task_struct **tp);
 #endif
 
 #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST) || IS_ENABLED(CONFIG_LOCK_TORTURE_TEST) || IS_MODULE(CONFIG_LOCK_TORTURE_TEST)
-long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask);
+long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool dowarn);
 #endif
 
 #endif /* __LINUX_TORTURE_H */
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index de95ec07e4771..cc33470f4de97 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -106,7 +106,7 @@ static const struct kernel_param_ops lt_bind_ops = {
 module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0644);
 module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0644);
 
-long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask);
+long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool dowarn);
 
 static struct task_struct *stats_task;
 static struct task_struct **writer_tasks;
@@ -1358,7 +1358,7 @@ static int __init lock_torture_init(void)
 		if (torture_init_error(firsterr))
 			goto unwind;
 		if (cpumask_nonempty(bind_writers))
-			torture_sched_setaffinity(writer_tasks[i]->pid, bind_writers);
+			torture_sched_setaffinity(writer_tasks[i]->pid, bind_writers, true);
 
 	create_reader:
 		if (cxt.cur_ops->readlock == NULL || (j >= cxt.nrealreaders_stress))
@@ -1369,7 +1369,7 @@ static int __init lock_torture_init(void)
 		if (torture_init_error(firsterr))
 			goto unwind;
 		if (cpumask_nonempty(bind_readers))
-			torture_sched_setaffinity(reader_tasks[j]->pid, bind_readers);
+			torture_sched_setaffinity(reader_tasks[j]->pid, bind_readers, true);
 	}
 	if (stat_interval > 0) {
 		firsterr = torture_create_kthread(lock_torture_stats, NULL,
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 612d276903352..908506b68c412 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -857,7 +857,7 @@ static void synchronize_rcu_trivial(void)
 	int cpu;
 
 	for_each_online_cpu(cpu) {
-		torture_sched_setaffinity(current->pid, cpumask_of(cpu));
+		torture_sched_setaffinity(current->pid, cpumask_of(cpu), true);
 		WARN_ON_ONCE(raw_smp_processor_id() != cpu);
 	}
 }
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index f8436969e0c89..c912b594ba987 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -527,12 +527,12 @@ EXPORT_SYMBOL_GPL(do_trace_rcu_torture_read);
 
 #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST) || IS_ENABLED(CONFIG_LOCK_TORTURE_TEST) || IS_MODULE(CONFIG_LOCK_TORTURE_TEST)
 /* Get rcutorture access to sched_setaffinity(). */
-long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
+long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool dowarn)
 {
 	int ret;
 
 	ret = sched_setaffinity(pid, in_mask);
-	WARN_ONCE(ret, "%s: sched_setaffinity(%d) returned %d\n", __func__, pid, ret);
+	WARN_ONCE(dowarn && ret, "%s: sched_setaffinity(%d) returned %d\n", __func__, pid, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(torture_sched_setaffinity);
-- 
2.40.1

