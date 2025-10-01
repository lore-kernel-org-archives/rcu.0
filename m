Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D09C255E53;
	Wed,  1 Oct 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330117; cv=none; b=Jm9rN4H+W5/wRAZ/UyWixcDA+LeAAkFpH691D0PSRjLX6Xte+93bFT5ZA5AK4xzycDKizrRdVUZUe/3EKxj23cHCcb8rBmhNVsKZDlGE3xGx8H1fi1puW7kffZWNH4w760ZNkMnFJRIsUab9/tAYeSR85IYFgkooxzOyz815rqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330117; c=relaxed/simple;
	bh=yBaOC5W3nSd5obx3kTATstlLARGhR3bToCH6Ph5k7XI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WsQkFSUXIc9AC2arXn2caTFBy0KqLnB1Do0c5poTIVDT7AsmMgQHZIspxawzCwUcA02+BoBIaPT11oUEN8wVkW00O90m7uSMJBZKwlBAChYnKS++QS3ENcRwiIJVixprsRFNNPKQX6dlODm3tAkVAtj1iurEg3u8Bmb8l6dLZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF2moIKC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF2moIKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CFEC4AF09;
	Wed,  1 Oct 2025 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330117;
	bh=yBaOC5W3nSd5obx3kTATstlLARGhR3bToCH6Ph5k7XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aF2moIKCka1hqUOXop3oQvxhAKe/BXCPx97xVp/mE9ItMG3K/h+i/ghzX318Kp6As
	 f2AY2VJN/xjcCd8BG5j9zp+GZURLFUj51FIOU1RYuxvMFIzFF3WbL63/8GqIBKM3Zb
	 hCGXUech9tW2fVynOHA9Arn1KlJi9wWTpk2yypz5GIpeTiY9oXPBRjpm2iJJy+OQIZ
	 dag7ZwMkLsbF3dh1nGH7dRmurEzY1AxARUl4NViJUNs3yb/wshRGm/4BdIXed3B8Er
	 FGx//8qafCnETh0L00oT3Z+gZdprXDdFm+2SPeeF/e1rS/1KhnwXfwYMODCvSwha/x
	 Twe7h2badvVeA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5FDC8CE0F80; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH v2 01/21] srcu: Permit Tiny SRCU srcu_read_unlock() with interrupts disabled
Date: Wed,  1 Oct 2025 07:48:12 -0700
Message-Id: <20251001144832.631770-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
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
index e3b64a5e0ec7e1..3450c3751ef7ad 100644
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

