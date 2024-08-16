Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327C88489;
	Fri, 16 Aug 2024 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784225; cv=none; b=qPL4JkTRiDIMbRlaGwXG9/PSc0vQKmuZTcqj0jVs8b+1W06EbfpBFeTdpskz6P4pKpi/WSshgyh4j+cFM0bA0QWwvJr0W/QrevfFQjxNaYr4DPDE1eVSB3xKYltzZb/9HKAZQbNG+baJmY5N9QqQye5iPNAs0Vq+/YyS6UvAOjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784225; c=relaxed/simple;
	bh=yCly0aHF27SAN6lfI+ylrEaYYlaG0HcyWfxbMft4SBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OoP7iyYwZuTCDfGCDWu1yx2/xwwrhd6STpQiMruZv/jxnevBK255yZwiV7MCaB7eMtTFTOKJCrZ5iiGQ0K9V8u/C4hDUY/AYNkCxkacJKJORUsfLGCqnHaMsVxb0whLs7TzR99QXDX/OtZ1QDNA22TvZHJ/vgybN2ZTuvS6ZUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMliv9B9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMliv9B9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149BCC32782;
	Fri, 16 Aug 2024 04:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723784224;
	bh=yCly0aHF27SAN6lfI+ylrEaYYlaG0HcyWfxbMft4SBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMliv9B9yLJF9r9qQ39OOWiqYES9SKhDQ/sMxr1r9zCTPomEU3PSAa9fihQyeFImo
	 YDCVc4WQwi6VtANFdlbG/VsV3/U8Dyy+GLBUBI9RPLiYv60S2lJKXyATnrDRkrB02H
	 IZGgiqTy3OGmkDBs3BR2O52CYeGxAmtoUXhCsEJ+BFOErj79iwVUnIaeZMfZeuzKiB
	 xE8n0rhQP0vUnPWeqeVckUKlQnoLxc8IzoanOzp6BIdrU38MJPqGH60um2W78jyNaM
	 3qSln+GVjbvZF/MD/5FxtD2LmM6kcN8uVHUltS0JXzvLcyVp9+GzsK396+A/szG5Ow
	 Czd0hZbU2i3+A==
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
Subject: [PATCH rcu 03/11] rcu/nocb: Assert no callbacks while nocb kthread allocation fails
Date: Fri, 16 Aug 2024 10:26:00 +0530
Message-Id: <20240816045608.30564-4-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
References: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

When a NOCB CPU fails to create a nocb kthread on bringup, the CPU is
then deoffloaded. The barrier mutex is locked at this stage. It is
typically used to protect against concurrent (de-)offloading and/or
concurrent rcu_barrier() that would otherwise risk a nocb locking
imbalance. However:

* rcu_barrier() can't run concurrently if it's the boot CPU on early
  boot-up.

* rcu_barrier() can run concurrently if it's a secondary CPU but it is
  expected to see 0 callbacks on this target because it's the first
  time it boots.

* (de-)offloading can't happen concurrently with smp_init(), as
  rcutorture is initialized later, at least not before device_initcall(),
  and userspace isn't available yet.

* (de-)offloading can't happen concurrently with cpu_up(), courtesy of
  cpu_hotplug_lock.

But:

* The lazy shrinker might run concurrently with cpu_up(). It shouldn't
  try to grab the nocb_lock and risk an imbalance due to lazy_len
  supposed to be 0 but be extra cautious.

* Also be cautious against resume from hibernation potential subtleties.

So keep the locking and add some assertions and comments.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree_nocb.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f4112fc663a7..fdd0616f2fd1 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1442,7 +1442,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 				"rcuog/%d", rdp_gp->cpu);
 		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__)) {
 			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
-			goto end;
+			goto err;
 		}
 		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
 		if (kthread_prio)
@@ -1454,7 +1454,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	t = kthread_create(rcu_nocb_cb_kthread, rdp,
 			   "rcuo%c/%d", rcu_state.abbr, cpu);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
-		goto end;
+		goto err;
 
 	if (rcu_rdp_is_offloaded(rdp))
 		wake_up_process(t);
@@ -1467,7 +1467,15 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	WRITE_ONCE(rdp->nocb_cb_kthread, t);
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 	return;
-end:
+
+err:
+	/*
+	 * No need to protect against concurrent rcu_barrier()
+	 * because the number of callbacks should be 0 for a non-boot CPU,
+	 * therefore rcu_barrier() shouldn't even try to grab the nocb_lock.
+	 * But hold barrier_mutex to avoid nocb_lock imbalance from shrinker.
+	 */
+	WARN_ON_ONCE(system_state > SYSTEM_BOOTING && rcu_segcblist_n_cbs(&rdp->cblist));
 	mutex_lock(&rcu_state.barrier_mutex);
 	if (rcu_rdp_is_offloaded(rdp)) {
 		rcu_nocb_rdp_deoffload(rdp);
-- 
2.40.1

