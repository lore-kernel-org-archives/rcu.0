Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366CD29CE6;
	Wed, 10 Jul 2024 04:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586756; cv=none; b=DlV/KGkCcXmdPiyAqOkfb4gbNHqBzRnAGYn+iExY4+CCtGysQOhG1PPvdKhctAoPiaEWvJZrz66f5CaUNekevHyW5kYQtc8+YXl+VMYqMwRc+bPq82FYA65qGyto8cy4YEgx8ng/0tRC+uJBC3Imid+i1JzIJEte0uKxfYJ4WNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586756; c=relaxed/simple;
	bh=upzHT+jYkh6/SZegi4wrmofTUtqgtVCKeRasrQtirO0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=osM9w1GVaBdCtJa2W7JxIVNUVk5LBJZ0qlhhwf83CfahlTkrcQWYcP7lDei7dcxweQ2k2iB4/OpsMqmBGBXhcwJt1NEUkNaAqe7TcN8CLmkptqtCU862lh1uVOjGQskBUw/vGOUIAwqMfhtD2OJvOTEePlFANZxSFURrv9MX6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eC2QD35c; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC2QD35c"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb05b0be01so35080275ad.2;
        Tue, 09 Jul 2024 21:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720586754; x=1721191554; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGdCz4dekPI8GbQLbF7pYbrDYm1q6fTyOuhQ9mCfYKY=;
        b=eC2QD35cfoYaD0ni7+ySnfF1hNsVWMGCV9H4NhuzXYJW9oyO1/GS2aikbuK4qNythM
         XRHTC21V+LJIKryF1f9APXEUZU2sLSpRBuq1oRakblX2bPgvY0Yqy/8o2WS/VNIf/VRe
         hfWC3YqYTqFqijiU9RNFFtq9ea3rq7jlKlRdN7oOmYSXo4tCsrQICgIP6K6W3dI0b/HF
         ALLbPIPHzXwfOD6jkNf6zGEFYMkg5UE5mBpvFxtszjtTgwO66MnUZSIJLCv7+hwqR+/B
         ZWb0aTGzjEdlE4aepWPtfiVyU65NZf6AhJovQERD2BzWv3OoHlYVVygpd+glQ2azSg6E
         WHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720586754; x=1721191554;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGdCz4dekPI8GbQLbF7pYbrDYm1q6fTyOuhQ9mCfYKY=;
        b=nHgWEBHsYQ4du8e7es/GriDpOWAb/mR9nJapiwxn621/UYeEKHFL/kbzWreJOILXyT
         UPSNUsJQ/Dhz+etimzMCgtxLD0/48OWTplWEt3+UZ8ZYA0W1fjLoZvI09D3fE594kqsF
         naVDPPdbc/UHhwrD+T+P8HawlZSj94N6+85GmobG4SgyNYRfmTOdTMZfqf8u6/O5IA6f
         mRLkREe73umfjG4Q1e9RvQwUDNC7MEjFxoN4JuZHoDX3M3Rot2mEcoyOrdy4tFlUIQyd
         HSJ/LzpIfdgHawEYqguHpzx63y5uk+Hg9yVHKS2fNUi5OhoAv/Fjs1qnZm+ZzLaihzfc
         GW6w==
X-Forwarded-Encrypted: i=1; AJvYcCWdYSdFCOUn2w2wlHWpHKYPYw/5n8b3FTT7V7Z1OHuYiVOVhE2N87hs258Dc5dN6801uBiPP1cQOgxG1jLh+L4Meyi1CIbQFxI6k+cnOCoxwz8b7HJagOFxWR3YNbaf3jfs
X-Gm-Message-State: AOJu0YxnLwBcMgzCUa436tHQjkHkWzI8C6+TcnbEPa6YYRuReQr6p2YX
	Rp5eEXBVAdP3wSxnL2o//7KzHHdVup7hD99YK5J11+PwmUXgeMR5
X-Google-Smtp-Source: AGHT+IE3k4WNlxBuk8joGdVc29dj/O1MsPLMoSsoB/VdOrMItsHHtVNHwhDUCbUNY4iabl/92OnEIA==
X-Received: by 2002:a17:903:2288:b0:1fb:72ed:420a with SMTP id d9443c01a7336-1fbb6d42b9fmr39684945ad.16.1720586754137;
        Tue, 09 Jul 2024 21:45:54 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a122cfsm25020705ad.5.2024.07.09.21.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 21:45:53 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	urezki@gmail.com,
	boqun.feng@gmail.com
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb()
Date: Wed, 10 Jul 2024 12:45:42 +0800
Message-Id: <20240710044542.444-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

For kernels built with CONFIG_FORCE_NR_CPUS=y, the nr_cpu_ids is
defined as NR_CPUS instead of the number of possible cpus, this
will cause the following system panic:

smpboot: Allowing 4 CPUs, 0 hotplug CPUs
...
setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:512 nr_node_ids:1
...
BUG: unable to handle page fault for address: ffffffff9911c8c8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 15 Comm: rcu_tasks_trace Tainted: G W
6.6.21 #1 5dc7acf91a5e8e9ac9dcfc35bee0245691283ea6
RIP: 0010:rcu_tasks_need_gpcb+0x25d/0x2c0
RSP: 0018:ffffa371c00a3e60 EFLAGS: 00010082
CR2: ffffffff9911c8c8 CR3: 000000040fa20005 CR4: 00000000001706f0
Call Trace:
<TASK>
? __die+0x23/0x80
? page_fault_oops+0xa4/0x180
? exc_page_fault+0x152/0x180
? asm_exc_page_fault+0x26/0x40
? rcu_tasks_need_gpcb+0x25d/0x2c0
? __pfx_rcu_tasks_kthread+0x40/0x40
rcu_tasks_one_gp+0x69/0x180
rcu_tasks_kthread+0x94/0xc0
kthread+0xe8/0x140
? __pfx_kthread+0x40/0x40
ret_from_fork+0x34/0x80
? __pfx_kthread+0x40/0x40
ret_from_fork_asm+0x1b/0x80
</TASK>

Considering that there may be holes in the CPU numbers, use the
maximum possible cpu number, instead of nr_cpu_ids, for configuring
enqueue and dequeue limits.

Closes: https://lore.kernel.org/linux-input/CALMA0xaTSMN+p4xUXkzrtR5r6k7hgoswcaXx7baR_z9r5jjskw@mail.gmail.com/T/#u
Reported-by: Zhixu Liu <zhixu.liu@gmail.com>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/tasks.h | 80 +++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2b1d6abf3ba3..12d63ce84cc9 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -49,6 +49,7 @@ struct rcu_tasks_percpu {
 	struct list_head rtp_blkd_tasks;
 	struct list_head rtp_exit_list;
 	int cpu;
+	int index;
 	struct rcu_tasks *rtpp;
 };
 
@@ -110,6 +111,7 @@ struct rcu_tasks {
 	call_rcu_func_t call_func;
 	unsigned int wait_state;
 	struct rcu_tasks_percpu __percpu *rtpcpu;
+	struct rcu_tasks_percpu **rtpcp_array;
 	int percpu_enqueue_shift;
 	int percpu_enqueue_lim;
 	int percpu_dequeue_lim;
@@ -182,6 +184,8 @@ module_param(rcu_task_collapse_lim, int, 0444);
 static int rcu_task_lazy_lim __read_mostly = 32;
 module_param(rcu_task_lazy_lim, int, 0444);
 
+static int rcu_task_cpu_ids;
+
 /* RCU tasks grace-period state for debugging. */
 #define RTGS_INIT		 0
 #define RTGS_WAIT_WAIT_CBS	 1
@@ -245,6 +249,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	int cpu;
 	int lim;
 	int shift;
+	int maxcpu;
+	int index = 0;
 
 	if (rcu_task_enqueue_lim < 0) {
 		rcu_task_enqueue_lim = 1;
@@ -254,14 +260,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	}
 	lim = rcu_task_enqueue_lim;
 
-	if (lim > nr_cpu_ids)
-		lim = nr_cpu_ids;
-	shift = ilog2(nr_cpu_ids / lim);
-	if (((nr_cpu_ids - 1) >> shift) >= lim)
-		shift++;
-	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
-	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
-	smp_store_release(&rtp->percpu_enqueue_lim, lim);
+	rtp->rtpcp_array = kcalloc(num_possible_cpus(), sizeof(struct rcu_tasks_percpu *), GFP_KERNEL);
+	BUG_ON(!rtp->rtpcp_array);
+
 	for_each_possible_cpu(cpu) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
@@ -273,14 +274,29 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
 		rtpcp->cpu = cpu;
 		rtpcp->rtpp = rtp;
+		rtpcp->index = index;
+		rtp->rtpcp_array[index] = rtpcp;
+		index++;
 		if (!rtpcp->rtp_blkd_tasks.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
 		if (!rtpcp->rtp_exit_list.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
+		maxcpu = cpu;
 	}
 
-	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
-			data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim), rcu_task_cb_adjust);
+	rcu_task_cpu_ids = maxcpu + 1;
+	if (lim > rcu_task_cpu_ids)
+		lim = rcu_task_cpu_ids;
+	shift = ilog2(rcu_task_cpu_ids / lim);
+	if (((rcu_task_cpu_ids - 1) >> shift) >= lim)
+		shift++;
+	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
+	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
+	smp_store_release(&rtp->percpu_enqueue_lim, lim);
+
+	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
+			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
+			rcu_task_cb_adjust, rcu_task_cpu_ids);
 }
 
 // Compute wakeup time for lazy callback timer.
@@ -348,7 +364,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 			rtpcp->rtp_n_lock_retries = 0;
 		}
 		if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
-		    READ_ONCE(rtp->percpu_enqueue_lim) != nr_cpu_ids)
+		    READ_ONCE(rtp->percpu_enqueue_lim) != rcu_task_cpu_ids)
 			needadjust = true;  // Defer adjustment to avoid deadlock.
 	}
 	// Queuing callbacks before initialization not yet supported.
@@ -368,10 +384,10 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	if (unlikely(needadjust)) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
-		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
+		if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
 			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
-			WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
-			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
+			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
+			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
 			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
@@ -444,6 +460,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 
 	dequeue_limit = smp_load_acquire(&rtp->percpu_dequeue_lim);
 	for (cpu = 0; cpu < dequeue_limit; cpu++) {
+		if (!cpu_possible(cpu))
+			continue;
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 		/* Advance and accelerate any new callbacks. */
@@ -481,7 +499,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim > 1) {
-			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(nr_cpu_ids));
+			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(rcu_task_cpu_ids));
 			smp_store_release(&rtp->percpu_enqueue_lim, 1);
 			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
 			gpdone = false;
@@ -496,7 +514,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
 		}
 		if (rtp->percpu_dequeue_lim == 1) {
-			for (cpu = rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
+			for (cpu = rtp->percpu_dequeue_lim; cpu < rcu_task_cpu_ids; cpu++) {
+				if (!cpu_possible(cpu))
+					continue;
 				struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 				WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
@@ -511,30 +531,32 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 // Advance callbacks and invoke any that are ready.
 static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu *rtpcp)
 {
-	int cpu;
-	int cpunext;
 	int cpuwq;
 	unsigned long flags;
 	int len;
+	int index;
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	struct rcu_tasks_percpu *rtpcp_next;
 
-	cpu = rtpcp->cpu;
-	cpunext = cpu * 2 + 1;
-	if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
-		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-		cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
-		queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
-		cpunext++;
-		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
-			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-			cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
+	index = rtpcp->index * 2 + 1;
+	if (index < num_possible_cpus()) {
+		rtpcp_next = rtp->rtpcp_array[index];
+		if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
+			cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
 			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+			index++;
+			if (index < num_possible_cpus()) {
+				rtpcp_next = rtp->rtpcp_array[index];
+				if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
+					cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
+					queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+				}
+			}
 		}
 	}
 
-	if (rcu_segcblist_empty(&rtpcp->cblist) || !cpu_possible(cpu))
+	if (rcu_segcblist_empty(&rtpcp->cblist))
 		return;
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
-- 
2.17.1

