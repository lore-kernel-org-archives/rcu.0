Return-Path: <SRS0=P5Uu=WI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4177C433FF
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 21:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F352070C
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 21:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="L0btrFgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfHLVUR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:20:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39684 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfHLVUR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Aug 2019 17:20:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so50111434pgi.6
        for <rcu@vger.kernel.org>; Mon, 12 Aug 2019 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Va9WpJmX/ilyW47nZhClyWmlHa/zXmc6nqxMFypMIBQ=;
        b=L0btrFgtX9Ewu3XxqbZN2CPEhn+6jUVtcuLKhI6bqgGASvnuLI9hJ+yZXXznIifr1f
         gZH9Yg0cTDK2Zhe00o04D3SXBBoS+PDmkQjDWV3s+XHZHdHpmvFJaikGvPs2pQll16LU
         6UMhCx+YHDId3tVNv+Iyq1mUc0L1n8hJwlwpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Va9WpJmX/ilyW47nZhClyWmlHa/zXmc6nqxMFypMIBQ=;
        b=nGCg6e5ZC1CvPXngWmw7R3SJq0P4bB4YykqdIGRv4ZOd9uopvoHtSjZzsx5zVsS5QK
         0o+nKITNn3ba/OtToDUQBDRhJkxkKCVhu+0Ykhl+pS7FaHPCxa5gyjKmcSJkAlJPrAQ2
         Dl8W4YjgysGuoY7AFdb5ex3b0xGw2iuhh9Rcdc/FdNfDfT1oQ/vHjrbRTU3NbwQ0si61
         i8UZyhBg+gTqimyFw7JVvtp1oYM2cXDg5rUukjviWb9DrVFZ19nGeESTajOxCppNTdDQ
         Upt2ksaFBgx4xVlz20iqy4Z7mm7z58q8kdwRMj81GRG4cK8yhVGSjw+vqazsMOPrkr9j
         xvZw==
X-Gm-Message-State: APjAAAU5vxEPKch1GZl4bMlWL1jlESzwdg7wja8e8ax0uMIEBirs1W+u
        qSXmTlpd0qQ/h/qdbpBZ+qZU1Q==
X-Google-Smtp-Source: APXvYqzJ7ekZWQZciFqNh3qpr6/sRYnbWlfLAZDGD7ssmoXjW0xAMdMHu8RwBtJxCAlawztAFENlQQ==
X-Received: by 2002:a63:6f41:: with SMTP id k62mr8615654pgc.32.1565644815967;
        Mon, 12 Aug 2019 14:20:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o129sm85354833pfg.1.2019.08.12.14.20.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 14:20:14 -0700 (PDT)
Date:   Mon, 12 Aug 2019 17:20:13 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190812212013.GB48751@google.com>
References: <20190811180852.GA128944@google.com>
 <20190811211318.GX28441@linux.ibm.com>
 <20190812032142.GA171001@google.com>
 <20190812035306.GE28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812035306.GE28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 11, 2019 at 08:53:06PM -0700, Paul E. McKenney wrote:
> On Sun, Aug 11, 2019 at 11:21:42PM -0400, Joel Fernandes wrote:
> > On Sun, Aug 11, 2019 at 02:13:18PM -0700, Paul E. McKenney wrote:
> > [snip]
> > > This leaves NO_HZ_FULL=y&&PREEMPT=y kernels.  In that case, RCU is
> > > more aggressive about using resched_cpu() on CPUs that have not yet
> > > reported a quiescent state for the current grace period.
> > 
> > Just wanted to ask something - how does resched_cpu() help for this case?
> > 
> > Consider a nohz_full CPU and a PREEMPT=y kernel. Say a single task is running
> > in kernel mode with scheduler tick off. As we discussed, we have no help from
> > cond_resched() (since its a PREEMPT=y kernel).  Because enough time has
> > passed (jtsq*3), we send the CPU a re-scheduling IPI.
> > 
> > This seems not that useful. Even if we enter the scheduler due to the
> > rescheduling flags set on that CPU, nothing will do the rcu_report_qs_rdp()
> > or rcu_report_qs_rnp() on those CPUs, which are needed to propagate the
> > quiescent state to the leaf node. Neither will anything to do a
> > rcu_momentary_dyntick_idle() for that CPU. Without this, the grace period
> > will still end up getting blocked.
> > 
> > Could you clarify which code paths on a nohz_full CPU running PREEMPT=y
> > kernel actually helps to end the grace period when we call resched_cpu() on
> > it?  Don't we need atleast do a rcu_momentary_dyntick_idle() from the
> > scheduler IPI handler or from resched_cpu() for the benefit of a nohz_full
> > CPU? Maybe I should do an experiment to see this all play out.
> 
> An experiment would be good!

Hi Paul,
Some very interesting findings!

Experiment: a tight loop rcuperf thread bound to a nohz_full CPU with
CONFIG_PREEMPT=y and CONFIG_NO_HZ_FULL=y. Executes for 5000 jiffies and
exits. Diff for test is appended.

Inference: I see that the tick is off on the nohz_full CPU 3 (the looping
thread is affined to CPU 3). The FQS loop does resched_cpu on 3, but the
grace period is unable to come to an end with the hold up seemingly due to
CPU 3.

I see that the scheduler tick is off mostly, but occasionally is turned back
on during the test loop. However it has no effect and the grace period is
stuck on the same rcu_state.gp_seq value for the duration of the test. I
think the scheduler-tick ineffectiveness could be because of this patch?
https://lore.kernel.org/patchwork/patch/446044/

Relevant traces, sorry I did not wrap it for better readability:

Here I marked the start of the test:

[   24.852639] rcu_perf-163    13.... 1828278us : rcu_perf_writer: Start of rcuperf test
[   24.853651] rcu_perf-163    13dN.1 1828284us : rcu_grace_period: rcu_preempt 18446744073709550677 cpuqs
[   24.971709] rcu_pree-10      0d..1 1833228us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   26.493607] rcu_pree-10      0d..1 2137286us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   28.090618] rcu_pree-10      0d..1 2441290us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3

Scheduler tick came in but almost 6 seconds of start of test, probably because migrate thread increase number of tasks queued on RQ:

[   28.355513] rcu_perf-163     3d.h. 2487447us : rcu_sched_clock_irq: sched-tick
[   29.592912] rcu_pree-10      0d..1 2745293us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   30.238041] rcu_perf-163     3d..2 2879562us : sched_switch: prev_comm=rcu_perf_writer prev_pid=163 prev_prio=98 prev_state=R+ ==> next_comm=migration/3 next_pid=26 next_prio=0
[   30.269203] migratio-26      3d..2 2879745us : sched_switch: prev_comm=migration/3 prev_pid=26 prev_prio=0 prev_state=S ==> next_comm=rcu_perf_writer next_pid=163 next_prio=98
[   31.109635] rcu_pree-10      0d..1 3049301us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   32.627686] rcu_pree-10      0d..1 3353298us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   34.071163] rcu_pree-10      0d..1 3657299us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3

Several context-switches on CPU 3, but grace-period is still extended:

[   34.634814] rcu_perf-163     3d..2 3775310us : sched_switch: prev_comm=rcu_perf_writer prev_pid=163 prev_prio=98 prev_state=R+ ==> next_comm=kworker/3:0 next_pid=28 next_prio=120
[   34.638532] kworker/-28      3d..2 3775343us : sched_switch: prev_comm=kworker/3:0 prev_pid=28 prev_prio=120 prev_state=D ==> next_comm=cpuhp/3 next_pid=25 next_prio=120
[   34.640338]  cpuhp/3-25      3d..2 3775348us : sched_switch: prev_comm=cpuhp/3 prev_pid=25 prev_prio=120 prev_state=S ==> next_comm=swapper/3 next_pid=0 next_prio=120
[   34.653831]   <idle>-0       3d..2 3775522us : sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/3:0 next_pid=28 next_prio=120
[   34.657770] kworker/-28      3d..2 3775536us : sched_switch: prev_comm=kworker/3:0 prev_pid=28 prev_prio=120 prev_state=I ==> next_comm=kworker/3:1 next_pid=177 next_prio=120
[   34.661758] kworker/-177     3d..2 3775543us : sched_switch: prev_comm=kworker/3:1 prev_pid=177 prev_prio=120 prev_state=I ==> next_comm=swapper/3 next_pid=0 next_prio=120
[   34.866007]   <idle>-0       3d..2 3789967us : sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/3:0H next_pid=29 next_prio=100
[   34.874200] kworker/-29      3d..2 3789988us : sched_switch: prev_comm=kworker/3:0H prev_pid=29 prev_prio=100 prev_state=I ==> next_comm=swapper/3 next_pid=0 next_prio=120
[   35.128506]   <idle>-0       3d..2 3816391us : sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=cpuhp/3 next_pid=25 next_prio=120
[   35.130481]  cpuhp/3-25      3d..2 3816503us : sched_switch: prev_comm=cpuhp/3 prev_pid=25 prev_prio=120 prev_state=S ==> next_comm=swapper/3 next_pid=0 next_prio=120
[   35.509469]   <idle>-0       3d..2 3828462us : sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_perf_writer next_pid=163 next_prio=98

Scheduler tick doesn't do much to help:

[   35.512436] rcu_perf-163     3d.h. 3829210us : rcu_sched_clock_irq: sched-tick

Now scheduler tick is completely off for the next 29 seconds. FQS loops keeps
doing resched_cpu on CPU 3 at 300 jiffy intervals (my HZ=1000):

[   36.160145] rcu_pree-10      0d..1 3958214us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   38.778574] rcu_pree-10      0d..1 4262288us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   40.604108] rcu_pree-10      0d..1 4566246us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   42.565345] rcu_pree-10      0d..1 4870294us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   44.322041] rcu_pree-10      0d..1 5174293us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   46.083710] rcu_pree-10      0d..1 5478290us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   47.851449] rcu_pree-10      0d..1 5782289us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   49.693127] rcu_pree-10      0d..1 6086293us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   51.432018] rcu_pree-10      0d..1 6390283us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   53.187991] rcu_pree-10      0d..1 6694294us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
[   53.970850] rcu_perf-163     3.... 6828237us : rcu_perf_writer: End of rcuperf test

I feel we could do one of:
1. Call rcu_momentary_dyntick_idle() from the re-schedule IPI handler
2. Raise the RCU softirq for NOHZ_FULL CPUs from re-schedule IPI handler or timer tick.

What do you think?  Also test diff is below.

thanks,

 - Joel

---8<-----------------------

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 70d6ac19cbff..181cd9ce733a 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -366,17 +366,15 @@ rcu_perf_writer(void *arg)
 	u64 t;
 	u64 *wdp;
 	u64 *wdpp = writer_durations[me];
+	unsigned long jiffies_init;
 
 	VERBOSE_PERFOUT_STRING("rcu_perf_writer task started");
+	trace_printk("Start of rcuperf test\n");
 	WARN_ON(!wdpp);
-	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	set_cpus_allowed_ptr(current, cpumask_of(3));
 	sp.sched_priority = 1;
 	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
 
-	if (holdoff)
-		schedule_timeout_uninterruptible(holdoff * HZ);
-
-	t = ktime_get_mono_fast_ns();
 	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
 		t_rcu_perf_writer_started = t;
 		if (gp_exp) {
@@ -387,80 +385,21 @@ rcu_perf_writer(void *arg)
 		}
 	}
 
+	jiffies_init = jiffies;
 	do {
-		if (writer_holdoff)
-			udelay(writer_holdoff);
-		wdp = &wdpp[i];
-		*wdp = ktime_get_mono_fast_ns();
-		if (gp_async) {
-retry:
-			if (!rhp)
-				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
-			if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
-				rcu_perf_writer_state = RTWS_ASYNC;
-				atomic_inc(this_cpu_ptr(&n_async_inflight));
-				cur_ops->async(rhp, rcu_perf_async_cb);
-				rhp = NULL;
-			} else if (!kthread_should_stop()) {
-				rcu_perf_writer_state = RTWS_BARRIER;
-				cur_ops->gp_barrier();
-				goto retry;
-			} else {
-				kfree(rhp); /* Because we are stopping. */
-			}
-		} else if (gp_exp) {
-			rcu_perf_writer_state = RTWS_EXP_SYNC;
-			cur_ops->exp_sync();
-		} else {
-			rcu_perf_writer_state = RTWS_SYNC;
-			cur_ops->sync();
-		}
-		rcu_perf_writer_state = RTWS_IDLE;
-		t = ktime_get_mono_fast_ns();
-		*wdp = t - *wdp;
-		i_max = i;
-		if (!started &&
-		    atomic_read(&n_rcu_perf_writer_started) >= nrealwriters)
-			started = true;
-		if (!done && i >= MIN_MEAS) {
-			done = true;
-			sp.sched_priority = 0;
-			sched_setscheduler_nocheck(current,
-						   SCHED_NORMAL, &sp);
-			pr_alert("%s%s rcu_perf_writer %ld has %d measurements\n",
-				 perf_type, PERF_FLAG, me, MIN_MEAS);
-			if (atomic_inc_return(&n_rcu_perf_writer_finished) >=
-			    nrealwriters) {
-				schedule_timeout_interruptible(10);
-				rcu_ftrace_dump(DUMP_ALL);
-				PERFOUT_STRING("Test complete");
-				t_rcu_perf_writer_finished = t;
-				if (gp_exp) {
-					b_rcu_gp_test_finished =
-						cur_ops->exp_completed() / 2;
-				} else {
-					b_rcu_gp_test_finished =
-						cur_ops->get_gp_seq();
-				}
-				if (shutdown) {
-					smp_mb(); /* Assign before wake. */
-					wake_up(&shutdown_wq);
-				}
-			}
-		}
-		if (done && !alldone &&
-		    atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters)
-			alldone = true;
-		if (started && !alldone && i < MAX_MEAS - 1)
-			i++;
-		rcu_perf_wait_shutdown();
-	} while (!torture_must_stop());
-	if (gp_async) {
-		rcu_perf_writer_state = RTWS_BARRIER;
-		cur_ops->gp_barrier();
+		i++;
+		cond_resched();
+	} while ((jiffies < jiffies_init + 5000) && !torture_must_stop());
+
+	trace_printk("End of rcuperf test\n");
+	schedule_timeout_interruptible(10);
+	rcu_ftrace_dump(DUMP_ALL);
+	PERFOUT_STRING("Test complete");
+	if (shutdown) {
+		smp_mb(); /* Assign before wake. */
+		wake_up(&shutdown_wq);
 	}
-	rcu_perf_writer_state = RTWS_STOPPING;
-	writer_n_durations[me] = i_max;
+
 	torture_kthread_stopping("rcu_perf_writer");
 	return 0;
 }
@@ -797,7 +736,7 @@ rcu_perf_init(void)
 	if (kfree_rcu_test)
 		return kfree_perf_init();
 
-	nrealwriters = compute_real(nwriters);
+	nrealwriters = 1;
 	nrealreaders = compute_real(nreaders);
 	atomic_set(&n_rcu_perf_reader_started, 0);
 	atomic_set(&n_rcu_perf_writer_started, 0);
@@ -814,6 +753,8 @@ rcu_perf_init(void)
 			goto unwind;
 		schedule_timeout_uninterruptible(1);
 	}
+
+#if 0
 	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (reader_tasks == NULL) {
@@ -829,6 +770,7 @@ rcu_perf_init(void)
 	}
 	while (atomic_read(&n_rcu_perf_reader_started) < nrealreaders)
 		schedule_timeout_uninterruptible(1);
+#endif
 	writer_tasks = kcalloc(nrealwriters, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	writer_durations = kcalloc(nrealwriters, sizeof(*writer_durations),
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 102a5f606d78..e3deb9431544 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1066,6 +1066,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	if (tick_nohz_full_cpu(rdp->cpu) &&
 		   time_after(jiffies,
 			      READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
+		trace_printk("Sending urgent resched to cpu %d\n", rdp->cpu);
 		resched_cpu(rdp->cpu);
 		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
 	}
@@ -2168,6 +2169,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
  */
 void rcu_sched_clock_irq(int user)
 {
+	trace_printk("sched-tick\n");
+
 	trace_rcu_utilization(TPS("Start scheduler-tick"));
 	raw_cpu_inc(rcu_data.ticks_this_gp);
 	/* The load-acquire pairs with the store-release setting to true. */
