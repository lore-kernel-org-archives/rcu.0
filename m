Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB6526AFC;
	Thu, 10 Oct 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578176; cv=none; b=k7Xv7pXc5UaoUYLwhEQS18lUbEHlyS1k+wPa6EeJUqjp9YWowtZBD4WMKPgpTzCIhcFwKYY7NkbtXEzJ1HFsNfbJWeseuVBECp8Be0GYYOT7eS38n2x47eo+tfuFm2GBaZCoViJDQSVlz5mmYpEqaU+0J67r00BBg4ezoC/ZYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578176; c=relaxed/simple;
	bh=+PcoP17wyqxQzVgGZJNk+lyONjE1Gzqm03Ri5IiE3Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1q4IyUYSS68FZXEjGtAzh6gCHAbSGgMUY3lFvcHSw7SxcWnuoWGI7fhPsT529eyP5WHMCjzEIRShKcbj9X9Kxn0tc77YZLNmmsRUgUXe7Zx0KCP8QnitOLyaTEUu5ixktVvV6fdiVnNyN+1WddSxEqu7fMwVvUhSHCCFP+3Uxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyQAye1x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyQAye1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941C5C4CEC5;
	Thu, 10 Oct 2024 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728578175;
	bh=+PcoP17wyqxQzVgGZJNk+lyONjE1Gzqm03Ri5IiE3Io=;
	h=From:To:Cc:Subject:Date:From;
	b=fyQAye1x2Otw3ge0mMDzsHotis3zDP2aXjfoDKs4QIeuvs4c0FB/glmDslvb6iHN/
	 tulS94mFUDBJd72e8rQpglJn1+lsOZbRB4Z+3FbOcFUnOfqOdHABysqacA1fDSzyNz
	 ewBfXMFIf6NF73Ik9WYyQJ73/N2lfCwd0Xr+LL3oHyUmCPmj43IwLXL10oShTeN5hQ
	 l9X8/79r/+6hPhQv1oGwFpTDDBQzyN+RxOLF44xi+h/ZuYb/iZLwklmuxTlAHsV9Q+
	 7Vvp2NTSqMS79lh5sAwnntg5z2tQMQNrPut64a4I0D1yr9ZmJJ5da3LfJbja2XMoL0
	 Zi178BqpedrRg==
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
Subject: [PATCH] rcu/nocb: Fix rcuog wake-up from offline softirq
Date: Thu, 10 Oct 2024 18:36:09 +0200
Message-ID: <20241010163609.51273-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a CPU has set itself offline and before it eventually calls
rcutree_report_cpu_dead(), there are still opportunities for callbacks
to be enqueued, for example from a softirq. When that happens on NOCB,
the rcuog wake-up is deferred through an IPI to an online CPU in order
not to call into the scheduler and risk arming the RT-bandwidth after
hrtimers have been migrated out and disabled.

But performing a synchronized IPI from a softirq is buggy as reported in
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

Fix this with forcing deferred rcuog wake up through the NOCB timer when
the CPU is offline. The actual wake up will happen from
rcutree_report_cpu_dead().

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409231644.4c55582d-lkp@intel.com
Fixes: 9139f93209d1 ("rcu/nocb: Fix RT throttling hrtimer armed from offline CPU")
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 97b99cd06923..16865475120b 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -554,13 +554,19 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
-		} else if (!irqs_disabled_flags(flags)) {
+		} else if (!irqs_disabled_flags(flags) && cpu_online(rdp->cpu)) {
 			/* ... if queue was empty ... */
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp(rdp, false);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
+			/*
+			 * Don't do the wake-up upfront on fragile paths.
+			 * Also offline CPUs can't call swake_up_one_online() from
+			 * (soft-)IRQs. Rely on the final deferred wake-up from
+			 * rcutree_report_cpu_dead()
+			 */
 			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
-- 
2.46.0

