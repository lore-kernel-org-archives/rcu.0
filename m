Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F38427F728;
	Thu, 16 Jul 2026 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161424; cv=none; b=Vxva6vp/7bFz7ev4OL9a0vghO/jdc3lp0RXvPQy/zt+Rj4ktXwx6rfh/nHkYNa0X5ObDnQMQj8xFxuU7g5BuRvx+K3XNdfggdCkQlpfQKQTrz7kHfSuj130pNedV8Jz3d9buEuxwgkxo1PV/dHF5Tp0QzszrjEJq9oyT3Ju3eAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161424; c=relaxed/simple;
	bh=ZdbNuEABPiqhXUjhSEu/l/SloewUpM1gGXhfPQFiQ2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zhw7CQ5Ffp3OIIucX11eHrzhMrc8xsC8N6supFkURBLpzPDKR/SWXhuex5F5XXylX7CNf+DdDRZ0Av7UoLb+EFZbhMuk5MZX/tzloDEYROh8DML6DBL09jFZhPXU2JLWVypyHiuXiwGT6R0d7AKdAvlAG+/WyaQx009VpCuibD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L32ER26/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L32ER26/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C181F0155B;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161421;
	bh=jEzo+0grXdACzkBeM9iuM6LYnhbcPZWJqxHYXca3fo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L32ER26/nA+0fKc9NJJB/PpqGx4dmzCuHO2HBY57YOcCI+bfZ0iW43P65PcFkKf55
	 MV+iXgsaHAw3W4Di8ByRjGbxC/EkTTu0/EQL6SITREY/SkJmygx8Dnaoof3tvCINJ/
	 YfAPvoHVK63zmlrkNNMyLgeb5GHrd1pD+iCTlEI0rDGGnFy07ia4NvnSPHqJvuYhtE
	 RBGYx9cDdEUdYYY7pNEhjPH3VL9v4yrbDR7vYc1vVQupWQJ60JH7qAqVN2VyDU3vFO
	 wQ3VUyEmhIe+TVrMp+WY2aFJBSWAXWMJ8UyjBznPQIWYuUYUxubed7VAbyxXnCEDV/
	 9a/gITwsLmhyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 07D26CE0E5D; Wed, 15 Jul 2026 17:23:41 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 09/10] rcu-tasks: Remove smp_mb() in rcu_spawn_tasks_kthread_generic()
Date: Wed, 15 Jul 2026 17:23:38 -0700
Message-Id: <20260716002339.11717-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
References: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

For the smp_mb() after kthread_run() in rcu_spawn_tasks_kthread_generic()
from these commits:

'commit eacd6f04a133 ("rcu-tasks: Move Tasks RCU to its own file")'
'commit 84a8f446ffd7 ("rcu: Defer rcu_tasks_kthread() creation till
 first call_rcu_tasks()")'

the memory order pairing as follows:

rcu_spawn_tasks_kthread()
->t = kthread_run(rcu_tasks_kthread, ...);
->smp_mb(); /* Ensure others see full kthread. */
->WRITE_ONCE(rcu_tasks_kthread_ptr, t);

							call_rcu_tasks()
					      		->if (READ_ONCE(rcu_tasks_kthread_ptr))
					         	  ->wake_up(&rcu_tasks_cbs_wq)
							    ->try_to_wake_up()
							      lock pi_lock
							      ->smp_mb__after_spinlock()
								//see full kthread

Because the 'commit d119357d0743 ("rcu-tasks: Treat only synchronous
grace periods urgently")' moved the kthread_ptr assignment into the
rcu_tasks_kthread() function, the following memory order pairings are
sufficient:

The runq's raw_spinlock/unlock(or smp_mb__after_spinlock()) from
wake_up_process() in kthread_run() and __schedule() provides memory order
barrier when the kthread is first scheduled, this ensures the kthread's
func observes all of the kthread's initialization.

The kthread's smp_store_release(&rtp->kthread_ptr, ...) in
rcu_tasks_kthread() and smp_load_acquire(&rtp->kthread_ptr)
in call_rcu_tasks_generic() compose release/acquire pairing, the
cumulativity of smp_store_release() propagates visibility of the kthread's
initialization through the scheduler chain.

This commit therefore remove smp_mb() in rcu_spawn_tasks_kthread_generic().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d9e1e53f4ccf31..79aa5d51388c45 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -681,7 +681,6 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 	t = kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthread, OOM is now expected behavior\n", __func__, rtp->name))
 		return;
-	smp_mb(); /* Ensure others see full kthread. */
 }
 
 #ifndef CONFIG_TINY_RCU
-- 
2.40.1

