Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446CBB67E;
	Fri, 31 Jul 2026 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459846; cv=none; b=lSNlEbRcHr6KH2DnpYGjIXjgM+kPEcOUXg4iE7CnPZxgPcDgTDFEZVy/Kag3kFuajADE3WqTOcfTt+XwSShInGi+CgraVRPqaJJo2rH5/JmpMEsX9PEr1Eppps3BlWeEfMMbGPjEix+F7PoJ6RdRx3xH5sm1jgUn/Cm94fyezeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459846; c=relaxed/simple;
	bh=ZdbNuEABPiqhXUjhSEu/l/SloewUpM1gGXhfPQFiQ2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jIcfRqFbNQKh0Tok2UBgB42KrRmdGM5Zq1DHw3IlLriqaKosw6tWerDmc6Bej08pEgUQVeJzLVHcYE34Zo4uce9lmztS/1k/XyRB8F54/FX6LO6L/NPVvWKB1jQGLIXtM2P61cQ6ex6LFcq8B32Ksk8UOydO/mJMnZjCqrLTg8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le+KKPXP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le+KKPXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E108B1F00AC4;
	Fri, 31 Jul 2026 01:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459843;
	bh=jEzo+0grXdACzkBeM9iuM6LYnhbcPZWJqxHYXca3fo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=le+KKPXPu7Wt03SQ0EytR90ziG/+0f9IOfjaARKX6dboZ+lGENr5bX9QyYWHMhsEW
	 QaB7NT9NXER/oCFQ2n0+hiYSGgun14hFPR1E3uvMFebO3MhG3Q7PKjbObFGn3zkNS1
	 yVcXR4DYEuk03T8W/w3/QpMWAixW3a1CekWc1kI3V+ekGOiZK5n69033ihzWjM65Jp
	 l1K5XXSsLwn8x6spJ3BuSKyJoqlhe01K+lQJGqHhKy208IEVtCQATGlAIl0MAf2/1n
	 kO3HK0y7NKQxQecysOJGVclK9UcwTbC5or7ZRaF5FDiaJKO6QoYoARSWPXUf9S2k/D
	 YBa60HyIKkSRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 949E2CE100D; Thu, 30 Jul 2026 18:04:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 05/10] rcu-tasks: Remove smp_mb() in rcu_spawn_tasks_kthread_generic()
Date: Thu, 30 Jul 2026 18:03:56 -0700
Message-Id: <20260731010401.3531631-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
References: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
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

