Return-Path: <SRS0=tj9r=VA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF84C0650E
	for <rcu@archiver.kernel.org>; Wed,  3 Jul 2019 17:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D6D21881
	for <rcu@archiver.kernel.org>; Wed,  3 Jul 2019 17:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGCRkG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:40:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726490AbfGCRkF (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 3 Jul 2019 13:40:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63Hb7W7016571;
        Wed, 3 Jul 2019 13:39:36 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tgybkbv7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 13:39:36 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x63HdOJq001658;
        Wed, 3 Jul 2019 17:39:35 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2tdym776t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 17:39:35 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x63HdYDH50463226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jul 2019 17:39:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 794AFB2064;
        Wed,  3 Jul 2019 17:39:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D3FFB205F;
        Wed,  3 Jul 2019 17:39:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  3 Jul 2019 17:39:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CEEA416C8EB3; Wed,  3 Jul 2019 10:39:35 -0700 (PDT)
Date:   Wed, 3 Jul 2019 10:39:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190703173935.GU26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <CAEXW_YTzPJptrLqx1zzouVSYpssE0JExDYLr+HRnPQco+9Tk2g@mail.gmail.com>
 <20190703113036.04f6169d@gandalf.local.home>
 <20190703164134.GA125833@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703164134.GA125833@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030214
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 03, 2019 at 12:41:34PM -0400, Joel Fernandes wrote:
> On Wed, Jul 03, 2019 at 11:30:36AM -0400, Steven Rostedt wrote:
> > On Wed, 3 Jul 2019 11:25:20 -0400
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > 
> > > I am sorry if this is not a realistic real-life problem, but more a
> > > "doctor it hurts if I do this" problem as Steven once said ;-)
> > > 
> > > I'll keep poking ;-)
> > 
> > Hi Joel,
> > 
> > Can you also share the tests you are performing as well as any
> > module/code changes you made so that we can duplicate the results?
> 
> Sure thing. Below is the diff that I applied to Paul's /dev branch. But I
> believe Linus's tree should have same results.
> 
> After applying the diff below, I run it like this:
> tools/testing/selftests/rcutorture/bin/kvm.sh --bootargs rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000 rcuperf.holdout=5 rcuperf.pd_resched=0 --duration 1 --torture rcuperf
> 
> Some new options I added:
> pd_test=1 runs the preempt disable loop test
> pd_busy_wait is the busy wait time each pass through the loop in microseconds
> pd_resched is whether the loop should set the need-resched flag periodically.
> 
> If your qemu is a bit old or from debian, then you may also need to pass: --qemu-args "-net nic,model=e1000"
> 
> With pd_resched = 0, I get quite high average grace-period latencies. The
> preempt-disable loop thread is running on its own CPU. Enabling the rcu:*
> tracepoints, I see that for long periods of time, the FQS rcu loop can be
> running while the scheduler tick learns from rcu_preempt_deferred_qs() that
> there's nothing to worry about (at least this is what I remember tracing).
> 
> With pd_resched = 0, the output of the command above:
> Average grace-period duration: 195629 microseconds
> Minimum grace-period duration: 30111.7
> 50th percentile grace-period duration: 211000
> 90th percentile grace-period duration: 218000
> 99th percentile grace-period duration: 222999
> Maximum grace-period duration: 236351
> 
> With pd_resched = 1, you get more like twice (10ms) the busy-wait time (5ms).
> I wonder why its twice, but that's still Ok. It is as follows:
> Average grace-period duration: 12302.2 microseconds
> Minimum grace-period duration: 5998.35
> 50th percentile grace-period duration: 12000.4
> 90th percentile grace-period duration: 15996.4
> 99th percentile grace-period duration: 18000.6
> Maximum grace-period duration: 20998.6

Both of these results are within the design range for normal
RCU grace-period durations on busy systems.  See the code in
adjust_jiffies_till_sched_qs(), which is setting one of the "panic
durations" at which RCU starts taking more aggressive actions to end
the current grace period.  See especially:

	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)
		j = HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;
	pr_info("RCU calculated value of scheduler-enlistment delay is %ld jiffies.\n", j);
	WRITE_ONCE(jiffies_to_sched_qs, j);

This usually gets you about 100 milliseconds, and if you are starting
grace periods in quick succession from a single thread while other threads
are doing likewise, each grace-period wait gets to wait about two grace
periods worth due to the end of the previous grace period having started
a new grace period before the thread is awakened.

Of course, if this is causing trouble for some use case, it would not
be hard to create a tunable to override this panic duration.  But that
would of course require a real use case in real use, given that RCU isn't
exactly short on tunables at the moment.  Significantly shortening this
panic duration caused 0day to complain about slowness last I tried it,
just so you know.

> The config for the test is in the kernel sources itself:
> tools/testing/selftests/rcutorture/configs/rcuperf/TREE

Thank you!  And those Kconfig options are consistent with your results.

							Thanx, Paul

> (Sorry for any commented out dead code)
> (Also I hardcoded the default number of readers/writers as 10 but you can
>  pass them as you like to the rcuperf options)
> -------8<---------
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 8fd4f82c9b3d..5d30dbc7000b 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -429,12 +429,14 @@ static inline void srcu_init(void) { }
>  static inline bool rcu_gp_is_normal(void) { return true; }
>  static inline bool rcu_gp_is_expedited(void) { return false; }
>  static inline void rcu_expedite_gp(void) { }
> +static inline bool rcu_expedite_gp_called(void) { }
>  static inline void rcu_unexpedite_gp(void) { }
>  static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
>  #else /* #ifdef CONFIG_TINY_RCU */
>  bool rcu_gp_is_normal(void);     /* Internal RCU use. */
>  bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
>  void rcu_expedite_gp(void);
> +bool rcu_expedite_gp_called(void);
>  void rcu_unexpedite_gp(void);
>  void rcupdate_announce_bootup_oddness(void);
>  void rcu_request_urgent_qs_task(struct task_struct *t);
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 4513807cd4c4..67208b844128 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -34,6 +34,7 @@
>  #include <linux/stat.h>
>  #include <linux/srcu.h>
>  #include <linux/slab.h>
> +#include <linux/trace_clock.h>
>  #include <asm/byteorder.h>
>  #include <linux/torture.h>
>  #include <linux/vmalloc.h>
> @@ -79,13 +80,16 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
>  torture_param(bool, gp_async, false, "Use asynchronous GP wait primitives");
>  torture_param(int, gp_async_max, 1000, "Max # outstanding waits per reader");
>  torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
> -torture_param(int, holdoff, 10, "Holdoff time before test start (s)");
> -torture_param(int, nreaders, -1, "Number of RCU reader threads");
> -torture_param(int, nwriters, -1, "Number of RCU updater threads");
> +torture_param(int, holdoff, 5, "Holdoff time before test start (s)");
> +torture_param(int, nreaders, 10, "Number of RCU reader threads");
> +torture_param(int, nwriters, 10, "Number of RCU updater threads");
>  torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
>  	      "Shutdown at end of performance tests.");
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
> +torture_param(int, pd_test, 0, "Do the preempt disable loop test");
> +torture_param(int, pd_busy_wait, 5000, "Preempt-disable per-loop wait in usecs");
> +torture_param(int, pd_resched, 1, "Preempt-disable per-loop wait in usecs");
>  
>  static char *perf_type = "rcu";
>  module_param(perf_type, charp, 0444);
> @@ -96,6 +100,7 @@ static int nrealwriters;
>  static struct task_struct **writer_tasks;
>  static struct task_struct **reader_tasks;
>  static struct task_struct *shutdown_task;
> +static struct task_struct *pd_task;
>  
>  static u64 **writer_durations;
>  static int *writer_n_durations;
> @@ -375,6 +380,11 @@ rcu_perf_writer(void *arg)
>  	if (holdoff)
>  		schedule_timeout_uninterruptible(holdoff * HZ);
>  
> +	// Wait for rcu_unexpedite_gp() to be called from init to avoid
> +	// doing expedited GPs if we are not supposed to
> +	while (!gp_exp && rcu_expedite_gp_called())
> +		schedule_timeout_uninterruptible(1);
> +
>  	t = ktime_get_mono_fast_ns();
>  	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
>  		t_rcu_perf_writer_started = t;
> @@ -413,6 +423,9 @@ rcu_perf_writer(void *arg)
>  		} else {
>  			rcu_perf_writer_state = RTWS_SYNC;
>  			cur_ops->sync();
> +			if (i % 20 == 0) {
> +				//pr_err("writer %ld loop=%d gpseq=%lu\n", me, i, cur_ops->get_gp_seq());
> +			}
>  		}
>  		rcu_perf_writer_state = RTWS_IDLE;
>  		t = ktime_get_mono_fast_ns();
> @@ -452,6 +465,7 @@ rcu_perf_writer(void *arg)
>  			alldone = true;
>  		if (started && !alldone && i < MAX_MEAS - 1)
>  			i++;
> +		//pr_err("writer %d i now %d\n", me, i);
>  		rcu_perf_wait_shutdown();
>  	} while (!torture_must_stop());
>  	if (gp_async) {
> @@ -464,6 +478,67 @@ rcu_perf_writer(void *arg)
>  	return 0;
>  }
>  
> +static void busy_wait(int time_us)
> +{
> +	u64 start, end;
> +	start = trace_clock_local();
> +	do {
> +		end = trace_clock_local();
> +		if (kthread_should_stop())
> +			break;
> +	} while ((end - start) < (time_us * 1000));
> +}
> +
> +static int
> +rcu_perf_preempt_disable(void *arg)
> +{
> +	struct sched_param sp;
> +
> +	VERBOSE_PERFOUT_STRING("rcu_perf_preempt_disable task thread enter");
> +
> +	// Create pd thread on last CPU
> +	set_cpus_allowed_ptr(current, cpumask_of(nr_cpu_ids - 1));
> +	sp.sched_priority = 1;
> +	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
> +
> +	// Wait for holdoff
> +	if (holdoff)
> +		schedule_timeout_uninterruptible(holdoff * HZ);
> +
> +	// Wait for rcu_unexpedite_gp() to be called from init to avoid
> +	// doing expedited GPs if we are not supposed to
> +	while (!gp_exp && rcu_expedite_gp_called())
> +		schedule_timeout_uninterruptible(1);
> +
> +	pr_err("PD test started on cpu %d\n", smp_processor_id());
> +
> +	do {
> +		preempt_disable();
> +		busy_wait(pd_busy_wait);
> +
> +		/* Prevent stalls and unnecessary extension of grace period */
> +		if (pd_resched) {
> +			set_tsk_need_resched(current);
> +			set_preempt_need_resched();
> +		}
> +
> +		preempt_enable();
> +
> +		/* Just in case preempt_enable didn't resched ;-) */
> +		if (pd_resched)
> +			cond_resched();
> +#if 0
> +		if (i++ % 1000 == 0){
> +			pr_err("pd: looped once in 1000, i = %d\n", i);
> +			trace_printk("pd: looped once in 1000, i = %d\n", i);
> +		}
> +#endif
> +	} while (!torture_must_stop());
> +
> +	torture_kthread_stopping("rcu_perf_preempt_disable");
> +	return 0;
> +}
> +
>  static void
>  rcu_perf_print_module_parms(struct rcu_perf_ops *cur_ops, const char *tag)
>  {
> @@ -548,6 +623,11 @@ rcu_perf_cleanup(void)
>  		kfree(writer_n_durations);
>  	}
>  
> +	if (pd_task) {
> +		torture_stop_kthread(rcu_perf_preempt_disable, pd_task);
> +		kfree(pd_task);
> +	}
> +
>  	/* Do torture-type-specific cleanup operations.  */
>  	if (cur_ops->cleanup != NULL)
>  		cur_ops->cleanup();
> @@ -571,7 +651,9 @@ static int compute_real(int n)
>  		if (nr <= 0)
>  			nr = 1;
>  	}
> -	return nr;
> +
> +	// Reserve 2 cpus for testing
> +	return nr - 2;
>  }
>  
>  /*
> @@ -681,6 +763,20 @@ rcu_perf_init(void)
>  		if (firsterr)
>  			goto unwind;
>  	}
> +
> +	if (pd_test) {
> +		pd_task = kzalloc(sizeof(*pd_task), GFP_KERNEL);
> +		if (!pd_task) {
> +			firsterr = -ENOMEM;
> +			goto unwind;
> +		}
> +
> +		firsterr = torture_create_kthread(rcu_perf_preempt_disable,
> +				NULL, pd_task);
> +		if (firsterr)
> +			goto unwind;
> +	}
> +
>  	torture_init_end();
>  	return 0;
>  
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 249517058b13..840f62805d62 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -154,6 +154,15 @@ void rcu_expedite_gp(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_expedite_gp);
>  
> +/**
> + * rcu_expedite_gp_called - Was there a prior call to rcu_expedite_gp()?
> + */
> +bool rcu_expedite_gp_called(void)
> +{
> +	return (atomic_read(&rcu_expedited_nesting) != 0);
> +}
> +EXPORT_SYMBOL_GPL(rcu_expedite_gp_called);
> +
>  /**
>   * rcu_unexpedite_gp - Cancel prior rcu_expedite_gp() invocation
>   *
> 
