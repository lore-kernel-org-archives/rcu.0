Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AFE1F7580;
	Sun,  2 Nov 2025 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119878; cv=none; b=Ro3GM1ceuZyTvOYDmVMGKqDHz4hxH8E1elRTnuRpsZFWrV4SbmqC06dAHUlRr9x+2MO9zkLJdKhwmfupBXqhY/aRaEKWvDWOJ0hcNR2pBEoCb2OVcHO4VTiiixRUj7VZX4QeWciWxcvZuPG0Pap4ayQy32jkLX0MIZZAvu0ibTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119878; c=relaxed/simple;
	bh=ZFNuHVX2di4q2gqCJGVL5/EBAk3Kdb3wjGuQ316eoLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VglbR57XrUDFxka6XnodcI/LS/sdot+qzPvZLtFrB14l6xdSo3nPzqvbef/sFRPO9GgFV15w2Kf80jONakhbifwTPXPVXHMcB2U1XRP4Bd8TnyI8Y5IAIAS+2WW1SqllKCpibh0KeXJpahy/oSJ5Mlit0Go1Zkv6X2qnjQurJSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5l8mNeB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5l8mNeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD38C4CEF7;
	Sun,  2 Nov 2025 21:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762119877;
	bh=ZFNuHVX2di4q2gqCJGVL5/EBAk3Kdb3wjGuQ316eoLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5l8mNeB8i76/k6rRYPk85GRs3k5wyWNC5EF40Lq2BSQaLaROn69Vn9/Dk5FdJrX1
	 BdArVSYGgKwzvw7tJc7DGBt9MhIf6mtxKdzWDOhkkotLRcI1EzySt1Q6M+asABprf6
	 Bbtd5AxHH0HzcKJtHdB/okNInxXBF9Voz8w0r7o9HQHp00AQ1aXVZjn7UZxn0LwrGY
	 GBIGI2Zo2t7QIcXMQ1QWlQEGscnxyh9KZMBvtLtriBzVH+SoRxFTCH4eBoswTTacth
	 B8eH6xvGfRAomw9AwIxMk821+y4es6vfFES/SyG+rLizWKnPVBqS0wHk392seGEwiu
	 R3icKwEXve95w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 78BE0CE0F4C; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH 01/19] srcu: Permit Tiny SRCU srcu_read_unlock() with interrupts disabled
Date: Sun,  2 Nov 2025 13:44:18 -0800
Message-Id: <20251102214436.3905633-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current Tiny SRCU implementation of srcu_read_unlock() awakens
the grace-period processing when exiting the outermost SRCU read-side
critical section.  However, not all Linux-kernel configurations and
contexts permit swake_up_one() to be invoked while interrupts are
disabled, and this can result in indefinitely extended SRCU grace periods.
This commit therefore only invokes swake_up_one() when interrupts are
enabled, and introduces polling to the grace-period workqueue handler.

Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Zqiang <qiang.zhang@linux.dev>
Closes: https://lore.kernel.org/oe-lkp/202508261642.b15eefbb-lkp@intel.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutiny.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index e3b64a5e0ec7..3450c3751ef7 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -106,15 +106,15 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
 	preempt_enable();
-	if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task())
+	if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task() && !irqs_disabled())
 		swake_up_one(&ssp->srcu_wq);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
 /*
  * Workqueue handler to drive one grace period and invoke any callbacks
- * that become ready as a result.  Single-CPU and !PREEMPTION operation
- * means that we get away with murder on synchronization.  ;-)
+ * that become ready as a result.  Single-CPU operation and preemption
+ * disabling mean that we get away with murder on synchronization.  ;-)
  */
 void srcu_drive_gp(struct work_struct *wp)
 {
@@ -141,7 +141,12 @@ void srcu_drive_gp(struct work_struct *wp)
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
 	preempt_enable();
-	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
+	do {
+		// Deadlock issues prevent __srcu_read_unlock() from
+		// doing an unconditional wakeup, so polling is required.
+		swait_event_timeout_exclusive(ssp->srcu_wq,
+					      !READ_ONCE(ssp->srcu_lock_nesting[idx]), HZ / 10);
+	} while (READ_ONCE(ssp->srcu_lock_nesting[idx]));
 	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
-- 
2.40.1

