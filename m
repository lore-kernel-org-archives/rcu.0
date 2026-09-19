Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95694313540;
	Sat, 19 Sep 2026 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778141; cv=none; b=roMeNyO5ScY+2w+99vm/DQ4AdG5UpI4wt45YtajOPIsqJpvj4juZ48jkxcfhqW752Z16ZYTgc+RG5STK67h/3ZVJ/m5KIFNELiUnjAnOc7LxWjxFnUSa6lbMRMg8GwkCZgWsRHiuL4w9VfQxqOak+qi8q//Qutm20NuEA8XCM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778141; c=relaxed/simple;
	bh=F+pCzo3cDD2zK1hhMxtQgJHDd0uf/3RDbaCnaYledug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c50NTMZgHVgmGXgaFGikBUts66o5/yKm+0VshVmmPktIrBXDyDyc34r5hbvhys4JklJkOMTlhSWQBa6u4gABmHaF/g6gmnxS1TVppdS3LGNdOJIjcVEz+lXUZIsE4AAzFKml4iasE60VR6Cyom7emKi0o8xDwrmvcisGcZhGiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/TqVmTp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/TqVmTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263AF1F008A4;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=yEKXxAEHBb72CclaisHRvemRz11VX9F9+cb+Cg2o9r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I/TqVmTpNfiCsi6FrGuCeGwZUm1237RYffcZpjV51EQj1EdEKaN9RQj+js4/rkHWT
	 hbMcb3Nn7nIwKBez7Jnh8SA0Jzhz8csiywDH94VVMM01R+cUYf9IuESuwImZMH40fm
	 /VdV6U7ZHdl6JjDZceHnIF78EANmg8FAhLZVD1RyTkBTA57BotAKGGTxVg/GmlL/hz
	 o8VAY92ZLxeewLTw30VlEduvfEQBlS8qLdK77TrCar7FmzIP1oA6Jvm4B64ynwBQMA
	 Y9n+fKgQ8MpF1LVWE7ct6Cp8rMVnTXCl9VGAi4zRtd3ccg9vNHVu/1K4EKWYdXBsx6
	 UfCmep5ALdsoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A8290CE1887; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Sunho Park <shpark061104@gmail.com>,
	syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 09/19] srcu: Fix WARN_ON() for rcu_segcblist_n_cbs() in cleanup_srcu_struct()
Date: Fri, 18 Sep 2026 17:35:11 -0700
Message-Id: <20260919003521.3134552-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunho Park <shpark061104@gmail.com>

The WARN_ON() added by commit 78a38cbf6f20 ("srcu: Queue sdp->work
when the delay timer is successfully deleted") uses rcu_segcblist_n_cbs()
to detect callbacks that srcu_barrier() failed to wait for. However, the
->len counter is decremented only at the end of srcu_invoke_callbacks(),
after the invoking loop has finished. Since srcu_barrier() can return
right after the barrier callback is invoked, cleanup_srcu_struct() can see
a non-zero n_cbs even though the cblist is already physically empty,
falsely triggering the WARN_ON() together with a still-pending delay_work
timer.

This can be triggered as follows, as seen in the syzbot report against
kvm_destroy_vm() -> cleanup_srcu_struct(&kvm->srcu):

1. call_srcu(&kvm->srcu, &bus->rcu, __free_bus) starts SRCU grace
   period GP1.

2. GP1 ends: a delay timer is armed and sdp->work is queued, but
   sdp->work has not run yet.

3. Another call_srcu(&kvm->srcu, &bus->rcu, __free_bus) call invokes
   srcu_segcblist_advance(), which moves the GP1 callback to
   RCU_DONE_TAIL, and starts SRCU grace period GP2.

4. srcu_barrier() is called. It queues its barrier callback after the
   GP2 callback and waits for srcu_invoke_callbacks() to invoke it.

5. GP2 ends: another delay timer is armed, and the sdp->work queued in
   step 2 begins to run. Its srcu_invoke_callbacks() call invokes
   srcu_segcblist_advance() again, moving the GP2 and barrier callbacks
   to RCU_DONE_TAIL as well, and then invokes all of them. However,
   rcu_segcblist_add_len(), which updates srcu_cblist's ->len, has not
   run yet at this point.

6. srcu_barrier() returns once its callback has been invoked, and
   cleanup_srcu_struct() starts running. It finds the delay timer
   armed in step 5 still pending and srcu_cblist's ->len still
   non-zero (because step 5 has not reached rcu_segcblist_add_len()
   yet), and WARN_ON() fires even though every callback has actually
   been invoked.

Use rcu_segcblist_empty(), which checks the actual head of the cblist,
instead of rcu_segcblist_n_cbs(), which checks the racy ->len counter.
Callbacks that have genuinely not been invoked yet still leave the list
non-empty, so the WARN_ON() still catches callers that skip srcu_barrier()
or queue callbacks after it.

Link: https://lore.kernel.org/rcu/e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev/T/#t
Reported-by: syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d4faf7db59e11f6fd1ab
Fixes: 78a38cbf6f20 ("srcu: Queue sdp->work when the delay timer is successfully deleted")
Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Sunho Park <shpark061104@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6625420cfb43..64081c8eacc8 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -787,7 +787,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 		// Call srcu_barrier() before this cleanup_srcu_struct()
 		// to avoid triggering this WARN_ON().
 		if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
-			    rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
+			    !rcu_segcblist_empty(&sdp->srcu_cblist)) &&
 		    rcu_cpu_beenfullyonline(sdp->cpu))
 			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
 		flush_work(&sdp->work);
-- 
2.40.1

