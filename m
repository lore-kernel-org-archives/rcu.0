Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC734845D;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374740; cv=none; b=qfExtaMREh0Bb39tePWRLr0Lwpu5BEboaIDyUtYQpGTrJGaNoj8bGFLKfYq1xH48mw0VWynPhrMTqIXANEY8P60qMRtcIy+r9tEOz836xYpnhx2vtnz1rdul/81KLlDe7cHz25MaaxndNRobLg9Xq1daIAr04+h+HcqfeR7e4nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374740; c=relaxed/simple;
	bh=ZFNuHVX2di4q2gqCJGVL5/EBAk3Kdb3wjGuQ316eoLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpSfv29Ve7+jQ2h7vuG0KeHvJ6QBsbUUZMtl4JawFv4MoF0qidK5vLDoOVyy2inKJrdLP3+Zvm2rcLi+3YQ624XxtHTNs9YNaxeEPTYyiUbmAT9jEXmH31KA03lzKVZ8bENMgE4ELzCtM4wAWeoscf6r0AbEsWVrQi1VN6y/rCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1syEvtK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1syEvtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634CFC4CEF5;
	Wed,  5 Nov 2025 20:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374739;
	bh=ZFNuHVX2di4q2gqCJGVL5/EBAk3Kdb3wjGuQ316eoLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1syEvtKZACwITkLFfQVm+DUEDVzwY4gE7UCqsGOqpAb+E76WWOJC37XNDXqiKFkb
	 +TOowTp85JZHbH31OTRXH2eam0N9Gssg3CGsOdRGes3lY1udJsKZrMDKMwS0RniOIF
	 GS9l62kay1PiyOEY5651pYWq/lvppHqL7ADCOvwb1CBll/SymAET+DjOowSP10lao4
	 28Hup0ZDwPyeqIskkqodvDYrHUGQ1E0btu/ekzrqjy4n1JMukkIZmWPFUyS+oU7myi
	 YBYW5fcG3pfCOHOr15jKZkUuA68b5zj9Y80v5lOPiMqLbvjWG35ZLa4rMXaL0r8A+s
	 lFVnjnrjZMKTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 86460CE0B94; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH v2 01/16] srcu: Permit Tiny SRCU srcu_read_unlock() with interrupts disabled
Date: Wed,  5 Nov 2025 12:32:01 -0800
Message-Id: <20251105203216.2701005-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
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

