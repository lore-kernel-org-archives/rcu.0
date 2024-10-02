Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535328F40;
	Wed,  2 Oct 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881070; cv=none; b=T8WY5LmtG2Uxpjue1jhemzIMygQZwR+whCEdH3yLiellB2Q3T7JkxJl9QLVF6ejDZ4X/j0ltDV0bvwqBDdk1P1y0GHAy3Hhj7gtqIgdWnjy+izDOyni6n3D1SYK41AronOob83IwZGmdzh6qRJUvet3IJN20yMuKVcB+cuNBlt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881070; c=relaxed/simple;
	bh=SYJkoM5PGYwL725ftsKaTc8bvBhYpRQfbSnmPZHax3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxI3jcGKmzVdFsLMq3PMVeA/gbr+o/kiHHk2Jxxnb4AyJFx104wYTWzGdE5WROGC3uUHPoN0rIO1CGfgM7lvQ0AgOyMiQ1xtBdEH/yr6cWfDIoE7vkK493AVPaIucDd326JVQAHHOsPr+4fnS3r2ZT7swb/YCwNxuZ9aJkooC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awdZS7b1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awdZS7b1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF31C4CECE;
	Wed,  2 Oct 2024 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881070;
	bh=SYJkoM5PGYwL725ftsKaTc8bvBhYpRQfbSnmPZHax3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awdZS7b1nsHiDnErnZfcDNy/1vYhTsJaUk57GzK/w+4XLqRQLgV8tY9KoOHRitF2l
	 EQ3x6edRBguRS8DZqE6jh0vwI6bI391QZZlQ7WocZptxfGhQcnguyErkNt0jLADrSG
	 zqXTN54x9n+WgGyuiWjfN1EWRy/FrOSGAQhOE2mjRLk2kJSzzyqQQLWKpbGaeciv+S
	 jwTbRR/l4DCelLOWk+xRazfYpv1Gxw4O/PLUk9MnTIRGERNZz3I5ZCPdYhNLo+G8/Q
	 tZoYesd75TzH2EDUoHZaqjqPEEE1niDla8mRXUoAV//0iKeg84lmfja/33SHtiEBgN
	 gylgITOO4nJHQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 2/3] rcu/nocb: Fix rcuog wake-up from offline softirq
Date: Wed,  2 Oct 2024 16:57:37 +0200
Message-ID: <20241002145738.38226-3-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002145738.38226-1-frederic@kernel.org>
References: <20241002145738.38226-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a CPU has set itself offline and before it eventually calls
rcutree_report_cpu_dead(), there are still opportunities for callbacks
to be enqueued, for example from an IRQ. When that happens on NOCB, the
rcuog wake-up is deferred through an IPI to an online CPU in order not
to call into the scheduler and risk arming the RT-bandwidth after
hrtimers have been migrated out and disabled.

But performing a synchronized IPI from an IRQ is buggy as reported in
the following scenario:

	WARNING: CPU: 1 PID: 26 at kernel/smp.c:633 smp_call_function_single
	Modules linked in: rcutorture torture
	CPU: 1 UID: 0 PID: 26 Comm: migration/1 Not tainted 6.11.0-rc1-00012-g9139f93209d1 #1
	Stopper: multi_cpu_stop+0x0/0x320 <- __stop_cpus+0xd0/0x120
	RIP: 0010:smp_call_function_single
	<IRQ>
	swake_up_one_online
	__call_rcu_nocb_wake
	__call_rcu_common
	? rcu_torture_one_read
	call_timer_fn
	__run_timers
	run_timer_softirq
	handle_softirqs
	irq_exit_rcu
	? tick_handle_periodic
	sysvec_apic_timer_interrupt
	</IRQ>

The periodic tick must be shutdown when the CPU is offline, just like is
done for oneshot tick. This must be fixed but this is not enough:
softirqs can happen on any hardirq tail and reproduce the above scenario.

Fix this with introducing a special deferred rcuog wake up mode when the
CPU is offline. This deferred wake up doesn't arm any timer and simply
wait for rcu_report_cpu_dead() to be called in order to flush any
pending rcuog wake up.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409231644.4c55582d-lkp@intel.com
Fixes: 9139f93209d1 ("rcu/nocb: Fix RT throttling hrtimer armed from offline CPU")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.h      |  1 +
 kernel/rcu/tree_nocb.h | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a9a811d9d7a3..7ed060edd12b 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -290,6 +290,7 @@ struct rcu_data {
 #define RCU_NOCB_WAKE_LAZY	2
 #define RCU_NOCB_WAKE		3
 #define RCU_NOCB_WAKE_FORCE	4
+#define RCU_NOCB_WAKE_OFFLINE   5
 
 #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
 					/* For jiffies_till_first_fqs and */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2fb803f863da..8648233e1717 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -295,6 +295,8 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	case RCU_NOCB_WAKE_FORCE:
 		if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
 			mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
+		fallthrough;
+	case RCU_NOCB_WAKE_OFFLINE:
 		if (rdp_gp->nocb_defer_wakeup < waketype)
 			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
 		break;
@@ -562,8 +564,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	lazy_len = READ_ONCE(rdp->lazy_len);
 	if (was_alldone) {
 		rdp->qlen_last_fqs_check = len;
-		// Only lazy CBs in bypass list
-		if (lazy_len && bypass_len == lazy_len) {
+		if (cpu_is_offline(rdp->cpu)) {
+			/*
+			 * Offline CPUs can't call swake_up_one_online() from IRQs. Rely
+			 * on the final deferred wake-up rcutree_report_cpu_dead()
+			 */
+			rcu_nocb_unlock(rdp);
+			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_OFFLINE,
+					   TPS("WakeEmptyIsDeferredOffline"));
+		} else if (lazy_len && bypass_len == lazy_len) {
+			// Only lazy CBs in bypass list
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
-- 
2.46.0

