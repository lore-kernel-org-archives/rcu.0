Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B628FFF3;
	Wed,  9 Jul 2025 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057774; cv=none; b=kz2mF3uKHix2Nv/Tnc2Idc38HB706mlVbeoT3P2MeYF9VnPrqNTcPjP14WRDKKy253NFwBOG9mQiuSua7OpZ0MzuRM5LuRJJeyWs7b7jh4xKinScF4is6DpsjbY42kHAhe2qYuaSK2Hhz8jMFnGiBtGGEERIe7r1+V9z7UB8vzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057774; c=relaxed/simple;
	bh=W754T72QzhrMs7jagPuYeJx2dNlz3h4n/qGsOD1cmH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sUfHZlIUa1QZ9+YDAuE3PxALJee9SIYsGgT68FiV8IU3nkrgKSz8Kr2vXuVyWEQCwrEINpegzKm3AelOnyReKcnl1t0JF3vpOrj3C5ytNbki2KMTirnK2wX3ml2lBVc156umd2SAHZuRrUt6tvl8zEbYzEijgIr115NOofTnAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4+azsNS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4+azsNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A84DC4CEF5;
	Wed,  9 Jul 2025 10:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057774;
	bh=W754T72QzhrMs7jagPuYeJx2dNlz3h4n/qGsOD1cmH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4+azsNSdulXhYcPJIW5q982aU8uQyuUctuPP4aBF1NPsUds6wmeZfm6CLlu5nH9o
	 mATDsOPAaMPqlX6M+iDg8AwBK/nc86UpRvicbG2+D16u0ove8m4PutmIaqLlPXJCu4
	 XR7IgQesehS8pRlA3NXT5Y7yY5b2xCScvgAvmFFJXboGxSaiPoxPcweapPOcnLkLkn
	 NOkM52HWN43fZ2xmtw8AUNbmP46pk+qUQVCIlCGQR61oj8tyUFxepdPfHdglIKjM7M
	 qCFzT9tT3tB60BZO/a4GCYePOUZImVaxS1HcyW0x3BHhmra6hWDMMusWLzMArxaSZn
	 ISBbu3crprZ3g==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 04/15] rcutorture: Add tests for SRCU up/down reader primitives
Date: Wed,  9 Jul 2025 16:12:04 +0530
Message-Id: <20250709104215.15562-5-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
References: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a new rcutorture.n_up_down kernel boot parameter
that specifies the number of outstanding SRCU up/down readers, which
begin in kthread context and end in an hrtimer handler.  There is a new
kthread ("rcu_torture_updown") that scans an per-reader array looking
for elements whose readers have ended.  This kthread sleeps between one
and two milliseconds between consecutive scans.

[ paulmck: Apply kernel test robot feedback. ]
[ paulmck: Apply Z qiang feedback. ]
[ joel: Fix build error: hrtimer_init is replaced by  hrtimer_setup. ]
[ joel: Apply Boqun bug fix to drop extra up_read() call in
        rcu_torture_updown()].

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 225 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 206 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7944cc69321d..bf87c0c4e77e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -55,22 +55,24 @@ MODULE_DESCRIPTION("Read-Copy Update module-based torture test facility");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@joshtriplett.org>");
 
-/* Bits for ->extendables field, extendables param, and related definitions. */
-#define RCUTORTURE_RDR_SHIFT_1	 8	/* Put SRCU index in upper bits. */
-#define RCUTORTURE_RDR_MASK_1	 (0xff << RCUTORTURE_RDR_SHIFT_1)
-#define RCUTORTURE_RDR_SHIFT_2	 16	/* Put SRCU index in upper bits. */
-#define RCUTORTURE_RDR_MASK_2	 (0xff << RCUTORTURE_RDR_SHIFT_2)
-#define RCUTORTURE_RDR_BH	 0x01	/* Extend readers by disabling bh. */
-#define RCUTORTURE_RDR_IRQ	 0x02	/*  ... disabling interrupts. */
-#define RCUTORTURE_RDR_PREEMPT	 0x04	/*  ... disabling preemption. */
-#define RCUTORTURE_RDR_RBH	 0x08	/*  ... rcu_read_lock_bh(). */
-#define RCUTORTURE_RDR_SCHED	 0x10	/*  ... rcu_read_lock_sched(). */
-#define RCUTORTURE_RDR_RCU_1	 0x20	/*  ... entering another RCU reader. */
-#define RCUTORTURE_RDR_RCU_2	 0x40	/*  ... entering another RCU reader. */
-#define RCUTORTURE_RDR_NBITS	 7	/* Number of bits defined above. */
-#define RCUTORTURE_MAX_EXTEND	 \
+// Bits for ->extendables field, extendables param, and related definitions.
+#define RCUTORTURE_RDR_SHIFT_1	8	// Put SRCU index in upper bits.
+#define RCUTORTURE_RDR_MASK_1	(0xff << RCUTORTURE_RDR_SHIFT_1)
+#define RCUTORTURE_RDR_SHIFT_2	16	// Put SRCU index in upper bits.
+#define RCUTORTURE_RDR_MASK_2	(0xff << RCUTORTURE_RDR_SHIFT_2)
+#define RCUTORTURE_RDR_BH	0x01	// Extend readers by disabling bh.
+#define RCUTORTURE_RDR_IRQ	0x02	//  ... disabling interrupts.
+#define RCUTORTURE_RDR_PREEMPT	0x04	//  ... disabling preemption.
+#define RCUTORTURE_RDR_RBH	0x08	//  ... rcu_read_lock_bh().
+#define RCUTORTURE_RDR_SCHED	0x10	//  ... rcu_read_lock_sched().
+#define RCUTORTURE_RDR_RCU_1	0x20	//  ... entering another RCU reader.
+#define RCUTORTURE_RDR_RCU_2	0x40	//  ... entering another RCU reader.
+#define RCUTORTURE_RDR_UPDOWN	0x80	//  ... up-read from task, down-read from timer.
+					//	Note: Manual start, automatic end.
+#define RCUTORTURE_RDR_NBITS	8	// Number of bits defined above.
+#define RCUTORTURE_MAX_EXTEND	\
 	(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | RCUTORTURE_RDR_PREEMPT | \
-	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)
+	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)  // Intentionally omit RCUTORTURE_RDR_UPDOWN.
 #define RCUTORTURE_RDR_ALLBITS	\
 	(RCUTORTURE_MAX_EXTEND | RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2 | \
 	 RCUTORTURE_RDR_MASK_1 | RCUTORTURE_RDR_MASK_2)
@@ -110,6 +112,7 @@ torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
 torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
 torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testing");
+torture_param(int, n_up_down, 32, "# of concurrent up/down hrtimer-based RCU readers");
 torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
@@ -156,6 +159,7 @@ static int nrealfakewriters;
 static struct task_struct *writer_task;
 static struct task_struct **fakewriter_tasks;
 static struct task_struct **reader_tasks;
+static struct task_struct *updown_task;
 static struct task_struct **nocb_tasks;
 static struct task_struct *stats_task;
 static struct task_struct *fqs_task;
@@ -378,6 +382,8 @@ struct rcu_torture_ops {
 	void (*readunlock)(int idx);
 	int (*readlock_held)(void);   // lockdep.
 	int (*readlock_nesting)(void); // actual nesting, if available, -1 if not.
+	int (*down_read)(void);
+	void (*up_read)(int idx);
 	unsigned long (*get_gp_seq)(void);
 	unsigned long (*gp_diff)(unsigned long new, unsigned long old);
 	void (*deferred_free)(struct rcu_torture *p);
@@ -427,6 +433,7 @@ struct rcu_torture_ops {
 	int no_pi_lock;
 	int debug_objects;
 	int start_poll_irqsoff;
+	int have_up_down;
 	const char *name;
 };
 
@@ -762,6 +769,50 @@ static int torture_srcu_read_lock_held(void)
 	return srcu_read_lock_held(srcu_ctlp);
 }
 
+static bool srcu_torture_have_up_down(void)
+{
+	int rf = reader_flavor;
+
+	if (!rf)
+		rf = SRCU_READ_FLAVOR_NORMAL;
+	return !!(cur_ops->have_up_down & rf);
+}
+
+static int srcu_torture_down_read(void)
+{
+	int idx;
+	struct srcu_ctr __percpu *scp;
+
+	WARN_ON_ONCE(reader_flavor & ~SRCU_READ_FLAVOR_ALL);
+	WARN_ON_ONCE(reader_flavor & (reader_flavor - 1));
+
+	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL)) {
+		idx = srcu_down_read(srcu_ctlp);
+		WARN_ON_ONCE(idx & ~0x1);
+		return idx;
+	}
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
+		scp = srcu_down_read_fast(srcu_ctlp);
+		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
+		WARN_ON_ONCE(idx & ~0x1);
+		return idx << 3;
+	}
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static void srcu_torture_up_read(int idx)
+{
+	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+		srcu_up_read_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
+	else if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) ||
+		 !(reader_flavor & SRCU_READ_FLAVOR_ALL))
+		srcu_up_read(srcu_ctlp, idx & 0x1);
+	else
+		WARN_ON_ONCE(1);
+}
+
 static unsigned long srcu_torture_completed(void)
 {
 	return srcu_batches_completed(srcu_ctlp);
@@ -819,6 +870,8 @@ static struct rcu_torture_ops srcu_ops = {
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
+	.down_read	= srcu_torture_down_read,
+	.up_read	= srcu_torture_up_read,
 	.readlock_held	= torture_srcu_read_lock_held,
 	.get_gp_seq	= srcu_torture_completed,
 	.gp_diff	= rcu_seq_diff,
@@ -839,6 +892,8 @@ static struct rcu_torture_ops srcu_ops = {
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.debug_objects	= 1,
+	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
+				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST,
 	.name		= "srcu"
 };
 
@@ -864,6 +919,8 @@ static struct rcu_torture_ops srcud_ops = {
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
 	.readlock_held	= torture_srcu_read_lock_held,
+	.down_read	= srcu_torture_down_read,
+	.up_read	= srcu_torture_up_read,
 	.get_gp_seq	= srcu_torture_completed,
 	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= srcu_torture_deferred_free,
@@ -883,6 +940,8 @@ static struct rcu_torture_ops srcud_ops = {
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.debug_objects	= 1,
+	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
+				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST,
 	.name		= "srcud"
 };
 
@@ -1994,7 +2053,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 
 	first = idxold1 == 0;
 	WARN_ON_ONCE(idxold2 < 0);
-	WARN_ON_ONCE(idxold2 & ~RCUTORTURE_RDR_ALLBITS);
+	WARN_ON_ONCE(idxold2 & ~(RCUTORTURE_RDR_ALLBITS | RCUTORTURE_RDR_UPDOWN));
 	rcutorture_one_extend_check("before change", idxold1, statesnew, statesold, insoftirq);
 	rtrsp->rt_readstate = newstate;
 
@@ -2070,6 +2129,11 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 		if (lockit)
 			raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 	}
+	if (statesold & RCUTORTURE_RDR_UPDOWN) {
+		cur_ops->up_read((idxold1 & RCUTORTURE_RDR_MASK_1) >> RCUTORTURE_RDR_SHIFT_1);
+		WARN_ON_ONCE(idxnew1 != -1);
+		idxold1 = 0;
+	}
 
 	/* Delay if neither beginning nor end and there was a change. */
 	if ((statesnew || statesold) && *readstate && newstate)
@@ -2210,7 +2274,8 @@ static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp
 	rtorsp->started = cur_ops->get_gp_seq();
 	rtorsp->ts = rcu_trace_clock_local();
 	rtorsp->p = rcu_dereference_check(rcu_torture_current,
-				  !cur_ops->readlock_held || cur_ops->readlock_held());
+					  !cur_ops->readlock_held || cur_ops->readlock_held() ||
+					  (rtorsp->readstate & RCUTORTURE_RDR_UPDOWN));
 	if (rtorsp->p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
 		rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
@@ -2379,6 +2444,121 @@ rcu_torture_reader(void *arg)
 	return 0;
 }
 
+struct rcu_torture_one_read_state_updown {
+	struct hrtimer rtorsu_hrt;
+	bool rtorsu_inuse;
+	struct torture_random_state rtorsu_trs;
+	struct rcu_torture_one_read_state rtorsu_rtors;
+};
+
+static struct rcu_torture_one_read_state_updown *updownreaders;
+static DEFINE_TORTURE_RANDOM(rcu_torture_updown_rand);
+static int rcu_torture_updown(void *arg);
+
+static enum hrtimer_restart rcu_torture_updown_hrt(struct hrtimer *hrtp)
+{
+	struct rcu_torture_one_read_state_updown *rtorsup;
+
+	rtorsup = container_of(hrtp, struct rcu_torture_one_read_state_updown, rtorsu_hrt);
+	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+	smp_store_release(&rtorsup->rtorsu_inuse, false);
+	return HRTIMER_NORESTART;
+}
+
+static int rcu_torture_updown_init(void)
+{
+	int i;
+	struct torture_random_state *rand = &rcu_torture_updown_rand;
+	int ret;
+
+	if (n_up_down < 0)
+		return 0;
+	if (!srcu_torture_have_up_down()) {
+		VERBOSE_TOROUT_STRING("rcu_torture_updown_init: Disabling up/down reader tests due to lack of primitives");
+		return 0;
+	}
+	updownreaders = kcalloc(n_up_down, sizeof(*updownreaders), GFP_KERNEL);
+	if (!updownreaders) {
+		VERBOSE_TOROUT_STRING("rcu_torture_updown_init: Out of memory, disabling up/down reader tests");
+		return -ENOMEM;
+	}
+	for (i = 0; i < n_up_down; i++) {
+		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
+		hrtimer_setup(&updownreaders[i].rtorsu_hrt, rcu_torture_updown_hrt, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+		torture_random_init(&updownreaders[i].rtorsu_trs);
+		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors,
+						&updownreaders[i].rtorsu_trs);
+	}
+	ret = torture_create_kthread(rcu_torture_updown, rand, updown_task);
+	if (ret) {
+		kfree(updownreaders);
+		updownreaders = NULL;
+	}
+	return ret;
+}
+
+static void rcu_torture_updown_cleanup(void)
+{
+	struct rcu_torture_one_read_state_updown *rtorsup;
+
+	for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
+		if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
+			continue;
+		if (!hrtimer_cancel(&rtorsup->rtorsu_hrt))
+			WARN_ON_ONCE(rtorsup->rtorsu_inuse);
+
+	}
+	kfree(updownreaders);
+	updownreaders = NULL;
+}
+
+/*
+ * RCU torture up/down reader kthread, starting RCU readers in kthread
+ * context and ending them in hrtimer handlers.  Otherwise similar to
+ * rcu_torture_reader().
+ */
+static int
+rcu_torture_updown(void *arg)
+{
+	int idx;
+	int rawidx;
+	struct rcu_torture_one_read_state_updown *rtorsup;
+	ktime_t t;
+
+	VERBOSE_TOROUT_STRING("rcu_torture_updown task started");
+	do {
+		for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
+			if (torture_must_stop())
+				break;
+			if (smp_load_acquire(&rtorsup->rtorsu_inuse))
+				continue;
+			init_rcu_torture_one_read_state(&rtorsup->rtorsu_rtors,
+							&rtorsup->rtorsu_trs);
+			rawidx = cur_ops->down_read();
+			idx = (rawidx << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
+			rtorsup->rtorsu_rtors.readstate = idx | RCUTORTURE_RDR_UPDOWN;
+			rtorsup->rtorsu_rtors.rtrsp++;
+			if (!rcu_torture_one_read_start(&rtorsup->rtorsu_rtors,
+							&rtorsup->rtorsu_trs, -1)) {
+				schedule_timeout_idle(HZ);
+				continue;
+			}
+			smp_store_release(&rtorsup->rtorsu_inuse, true);
+			t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
+			if (t < 10 * 1000)
+				t = 200 * 1000 * 1000;
+			hrtimer_start(&rtorsup->rtorsu_hrt, t,
+				      HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
+		}
+		torture_hrtimeout_ms(1, 1000, &rcu_torture_updown_rand);
+		stutter_wait("rcu_torture_updown");
+	} while (!torture_must_stop());
+	rcu_torture_updown_cleanup();
+	torture_kthread_stopping("rcu_torture_updown");
+	return 0;
+}
+
 /*
  * Randomly Toggle CPUs' callback-offload state.  This uses hrtimers to
  * increase race probabilities and fuzzes the interval between toggling.
@@ -2633,7 +2813,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "reader_flavor=%x "
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
 		 "test_nmis=%d "
-		 "preempt_duration=%d preempt_interval=%d\n",
+		 "preempt_duration=%d preempt_interval=%d n_up_down=%d\n",
 		 torture_type, tag, nrealreaders, nrealfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
@@ -2647,7 +2827,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 reader_flavor,
 		 nocbs_nthreads, nocbs_toggle,
 		 test_nmis,
-		 preempt_duration, preempt_interval);
+		 preempt_duration, preempt_interval, n_up_down);
 }
 
 static int rcutorture_booster_cleanup(unsigned int cpu)
@@ -3750,6 +3930,10 @@ rcu_torture_cleanup(void)
 		nocb_tasks = NULL;
 	}
 
+	if (updown_task) {
+		torture_stop_kthread(rcu_torture_updown, updown_task);
+		updown_task = NULL;
+	}
 	if (reader_tasks) {
 		for (i = 0; i < nrealreaders; i++)
 			torture_stop_kthread(rcu_torture_reader,
@@ -4284,6 +4468,9 @@ rcu_torture_init(void)
 	if (torture_init_error(firsterr))
 		goto unwind;
 
+	firsterr = rcu_torture_updown_init();
+	if (torture_init_error(firsterr))
+		goto unwind;
 	nrealnocbers = nocbs_nthreads;
 	if (WARN_ON(nrealnocbers < 0))
 		nrealnocbers = 1;
-- 
2.40.1

