Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32917C9ED;
	Thu, 30 May 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076771; cv=none; b=MNrDAzJXAMNA+TdN+wEBqsxx6hkpir1463v9XebCNev7+8jMXsjEhJIdl9IUEAAJH28bgYdzwh79mzKoiSouiPejSsdtWidzAHABmqZ8xSL8JquRhkq+R0wZRfL2MKR/EIlbowRlM9G8t0plPgrg7ZC954O5yTtjgpCZt4n6nzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076771; c=relaxed/simple;
	bh=zOihjtXXxawP2UKkc/EPxOuxspC8wQgEULmFJLX+x9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUOpRpat1w8JzcUpMwoFkEIVTfvhqpw/Edptm+/Fhu77GpZFofZxnhJcztdxhJPin21gb3ifl9fFYbEoPMhbcnNIJGUuuWIJnltbVLwmqHIFtTVYXTdrUojV6egpoZaKx4mAvYXMjrWJr0P1tWCwJkeUBywK0/seLCVYKmS4cF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWSHQ5F4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWSHQ5F4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6FCC2BBFC;
	Thu, 30 May 2024 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717076770;
	bh=zOihjtXXxawP2UKkc/EPxOuxspC8wQgEULmFJLX+x9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWSHQ5F4gDw7m3IWLVu+Ir5QmaJpVria+IBeezj0sr/40YLt+8jZS6qdKX6aMILQf
	 Jk0mQAYRh7VUDdK7pU0I9SIf1zabnHrCMFBqYR1uoLkCg8KyC+mo4lppB+E5dGXM/z
	 6X4mE7KuJ8SntHSsY02X0GRudGz9++e0Jvm80XurXZ5Tg5hIrmHaX5tJqT+qEy/e0R
	 YdGrVkkWCXsypJpzhKuQNLmJaYl1vVeYw69BlP6gtC6T18eu5bDtx3ouWt52ZMMmpL
	 RA48cO4UjVYTbn2flMmd6HOq44Lw2vxvEzaMz8NCs6CCHgNDe4iupvO6tTkpQXZ2Ws
	 I98r9m6CPZHCA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 03/11] rcu/nocb: Assert no callbacks while nocb kthread allocation fails
Date: Thu, 30 May 2024 15:45:44 +0200
Message-ID: <20240530134552.5467-4-frederic@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530134552.5467-1-frederic@kernel.org>
References: <20240530134552.5467-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.45.1

