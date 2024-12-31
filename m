Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0411ACEC1;
	Tue, 31 Dec 2024 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735664848; cv=none; b=O/TNsw4F6bPou6xo3iIxcSsXlRnauDFt5Zi9JFQCTKULS6uMeJZwt6LzMnd+YfVtwOqB1INgSh1d1RcazYxJWsnT4EuX8CFoRznh+H+ZSeuE1K1sHSYMMKcB343lWRxPjhFydZB/Wa0BC1K8z82vLUfQ+PAaBBEOg0zHUi5l4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735664848; c=relaxed/simple;
	bh=XXNH+Dnp1D3Zjpb2+5qN8FoOThPlB2AxN8n/acRXUxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdfCUvaFrViuErh7pp8FKOUKKR2L/ONjiK5RNAjFn0N3jKoaEEKBSp8777FkW4+8EzlBTixJUqMWxzNNHHFaGblzkxdF5h7LU0fFko9AhoIZ4VN7g+NepaocjAefLnd7Gppe949tXdpChiGF/JPUP1OJdGpwuSVcOuy8nv/mPJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncCpCnte; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncCpCnte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E330BC4CED2;
	Tue, 31 Dec 2024 17:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735664848;
	bh=XXNH+Dnp1D3Zjpb2+5qN8FoOThPlB2AxN8n/acRXUxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncCpCnteShZx52Ydniy5c1UBQYI1rFXiY8Pe8e+Um1jkWCgB4OqdOH110CDIwKoRD
	 Pthgg34PRB82WLGxX4Gs2UTHjps9NXVHa2ysCdQNxp0HaEzLbGLzBrDblWyS2pTHdC
	 l+rxmFThQvlw62mhFc2tgj6b+MafiPWQuWX+CJ6NzHqmcPgUJM3Q9zRV4ARp/XtJDz
	 2g+IML9Gfd/+WReFcNwwzFuPsFe/n6NwjqB1AhCuZeINvY3vsxiGSrnvyoE6VQo929
	 YHUDV4Ihz4FR7PbCR88wmZ+wXr9gLHJFSWb26iFsY7uvhc1kSRIrm6hWa09cf4qYjI
	 zyO2CyBbT0HyA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	vlad.wing@gmail.com,
	rcu@vger.kernel.org,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	neeraj.upadhyay@amd.com,
	urezki@gmail.com,
	qiang.zhang1211@gmail.com,
	Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	paulmck@kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 1/3 v3] hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
Date: Tue, 31 Dec 2024 18:07:10 +0100
Message-ID: <20241231170712.149394-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241231170712.149394-1-frederic@kernel.org>
References: <20241231170712.149394-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hrtimers are migrated away from the dying CPU to any online target at
the CPUHP_AP_HRTIMERS_DYING stage in order not to delay bandwidth timers
handling tasks involved in the CPU hotplug forward progress.

However wake ups can still be performed by the outgoing CPU after
CPUHP_AP_HRTIMERS_DYING. Those can result again in bandwidth timers
being armed. Depending on several considerations (crystal ball
power management based election, earliest timer already enqueued, timer
migration enabled or not), the target may eventually be the current
CPU even if offline. If that happens, the timer is eventually ignored.

The most notable example is RCU which had to deal with each an every of
those wake-ups by deferring them to an online CPU, along with related
workarounds:

_ e787644caf76 (rcu: Defer RCU kthreads wakeup when CPU is dying)
_ 9139f93209d1 (rcu/nocb: Fix RT throttling hrtimer armed from offline CPU)
_ f7345ccc62a4 (rcu/nocb: Fix rcuog wake-up from offline softirq)

The problem isn't confined to RCU though as the stop machine kthread
(which runs CPUHP_AP_HRTIMERS_DYING) reports its completion at the end
and performs a wake up that eventually arms the deadline server timer:

           WARNING: CPU: 94 PID: 588 at kernel/time/hrtimer.c:1086 hrtimer_start_range_ns+0x289/0x2d0
           Modules linked in:
           CPU: 94 UID: 0 PID: 588 Comm: migration/94 Not tainted
           Stopper: multi_cpu_stop+0x0/0x120 <- stop_machine_cpuslocked+0x66/0xc0
           RIP: 0010:hrtimer_start_range_ns+0x289/0x2d0
           Code: 41 5c 41 5d 41 5e 41 5f 5d e9 63 94 ea 00 0f 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d e9 39 fc 15 01 0f 0b e9 c1 fd ff ff <0f> 0b 48 8b
+45 00 e9 59 ff ff ff f3 0f 1e fa 65 8b 05 1d ec e8 7e
           RSP: 0018:ffffc900019cbcc8 EFLAGS: 00010046
           RAX: ffff88bf449a4c40 RBX: 0000000000000082 RCX: 0000000000000001
           RDX: 0000000000000001 RSI: ffff88bf43224c80 RDI: ffff88bf449a4c40
           RBP: ffff88bf449a4c80 R08: ffff888280970090 R09: 0000000000000000
           R10: ffff88bf432252e0 R11: ffffffff811abf70 R12: ffff88bf449a4c40
           R13: ffff88bf43234b28 R14: ffff88bf43224c80 R15: 0000000000000000
           FS:  0000000000000000(0000) GS:ffff88bf44980000(0000) knlGS:0000000000000000
           CR2: 0000000000000000 CR3: 000000404b230001 CR4: 0000000000770ef0
           PKRU: 55555554
           Call Trace:
            <TASK>
            ? __warn+0xcf/0x1b0
            ? hrtimer_start_range_ns+0x289/0x2d0
            ? report_bug+0x120/0x1a0
            ? handle_bug+0x60/0x90
            ? exc_invalid_op+0x1a/0x50
            ? asm_exc_invalid_op+0x1a/0x20
            ? register_refined_jiffies+0xb0/0xb0
            ? hrtimer_start_range_ns+0x289/0x2d0
            ? hrtimer_start_range_ns+0x186/0x2d0
            start_dl_timer+0xfc/0x150
            enqueue_dl_entity+0x367/0x640
            dl_server_start+0x53/0xa0
            enqueue_task_fair+0x363/0x460
            enqueue_task+0x3c/0x200
            ttwu_do_activate+0x94/0x240
            try_to_wake_up+0x315/0x600
            complete+0x4b/0x80

Instead of providing yet another bandaid to work around the situation,
fix it from hrtimers infrastructure instead: always migrate away a
timer to an online target whenever it is enqueued from an offline CPU.

This will also allow to revert all the above RCU disgraceful hacks.

Reported-by: Vlad Poenaru <vlad.wing@gmail.com>
Reported-by: Usama Arif <usamaarif642@gmail.com>
Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
Closes: 20241213203739.1519801-1-usamaarif642@gmail.com
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/hrtimer_defs.h |  1 +
 kernel/time/hrtimer.c        | 53 +++++++++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index c3b4b7ed7c16..84a5045f80f3 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -125,6 +125,7 @@ struct hrtimer_cpu_base {
 	ktime_t				softirq_expires_next;
 	struct hrtimer			*softirq_next_timer;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
+	call_single_data_t		csd;
 } ____cacheline_aligned;
 
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 80fe3749d2db..1ea9ef57d710 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -58,6 +58,8 @@
 #define HRTIMER_ACTIVE_SOFT	(HRTIMER_ACTIVE_HARD << MASK_SHIFT)
 #define HRTIMER_ACTIVE_ALL	(HRTIMER_ACTIVE_SOFT | HRTIMER_ACTIVE_HARD)
 
+static void retrigger_next_event(void *arg);
+
 /*
  * The timer bases:
  *
@@ -111,7 +113,8 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 			.clockid = CLOCK_TAI,
 			.get_time = &ktime_get_clocktai,
 		},
-	}
+	},
+	.csd = CSD_INIT(retrigger_next_event, NULL)
 };
 
 static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
@@ -716,8 +719,6 @@ static inline int hrtimer_is_hres_enabled(void)
 	return hrtimer_hres_enabled;
 }
 
-static void retrigger_next_event(void *arg);
-
 /*
  * Switch to high resolution mode
  */
@@ -1202,10 +1203,49 @@ hrtimer_update_softirq_timer(struct hrtimer_cpu_base *cpu_base, bool reprogram)
 	hrtimer_reprogram(cpu_base->softirq_next_timer, reprogram);
 }
 
+/*
+ * If the current CPU is offline and timers have been already
+ * migrated away, make sure not to enqueue locally and perform
+ * a remote retrigger as a last resort.
+ */
+static void enqueue_hrtimer_offline(struct hrtimer *timer,
+				    struct hrtimer_clock_base *base,
+				    const enum hrtimer_mode mode)
+{
+#ifdef CONFIG_HOTPLUG_CPU
+	struct hrtimer_cpu_base *new_cpu_base, *old_cpu_base, *this_cpu_base;
+	struct hrtimer_clock_base *new_base;
+	int cpu;
+
+	old_cpu_base = base->cpu_base;
+	this_cpu_base = this_cpu_ptr(&hrtimer_bases);
+
+	if (old_cpu_base == this_cpu_base || !old_cpu_base->online) {
+		WARN_ON_ONCE(hrtimer_callback_running(timer));
+		cpu = cpumask_any_and(cpu_online_mask,
+				      housekeeping_cpumask(HK_TYPE_TIMER));
+		new_cpu_base = &per_cpu(hrtimer_bases, cpu);
+		new_base = &new_cpu_base->clock_base[base->index];
+		WRITE_ONCE(timer->base, &migration_base);
+		raw_spin_unlock(&old_cpu_base->lock);
+		raw_spin_lock(&new_cpu_base->lock);
+		WRITE_ONCE(timer->base, new_base);
+	} else {
+		new_base = base;
+		new_cpu_base = new_base->cpu_base;
+		cpu = new_cpu_base->cpu;
+	}
+
+	if (enqueue_hrtimer(timer, new_base, mode))
+		smp_call_function_single_async(cpu, &new_cpu_base->csd);
+#endif
+}
+
 static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 				    u64 delta_ns, const enum hrtimer_mode mode,
 				    struct hrtimer_clock_base *base)
 {
+	struct hrtimer_cpu_base *this_cpu_base = this_cpu_ptr(&hrtimer_bases);
 	struct hrtimer_clock_base *new_base;
 	bool force_local, first;
 
@@ -1217,7 +1257,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	 * and enforce reprogramming after it is queued no matter whether
 	 * it is the new first expiring timer again or not.
 	 */
-	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
+	force_local = base->cpu_base == this_cpu_base;
 	force_local &= base->cpu_base->next_timer == timer;
 
 	/*
@@ -1240,6 +1280,11 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 
 	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
 
+	if (unlikely(!this_cpu_base->online)) {
+		enqueue_hrtimer_offline(timer, base, mode);
+		return 0;
+	}
+
 	/* Switch the timer base, if necessary: */
 	if (!force_local) {
 		new_base = switch_hrtimer_base(timer, base,
-- 
2.46.0

