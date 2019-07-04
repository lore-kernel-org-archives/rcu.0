Return-Path: <SRS0=COUN=VB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C6AC0651F
	for <rcu@archiver.kernel.org>; Thu,  4 Jul 2019 17:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CAE218A0
	for <rcu@archiver.kernel.org>; Thu,  4 Jul 2019 17:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfGDRNV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Jul 2019 13:13:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbfGDRNV (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 4 Jul 2019 13:13:21 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64HCWf0036483
        for <rcu@vger.kernel.org>; Thu, 4 Jul 2019 13:13:19 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2thjebew39-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Thu, 04 Jul 2019 13:13:18 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 4 Jul 2019 18:13:18 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Jul 2019 18:13:15 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x64HDExa44892420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 17:13:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC7C0B2066;
        Thu,  4 Jul 2019 17:13:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A28FFB2068;
        Thu,  4 Jul 2019 17:13:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.225.224])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jul 2019 17:13:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5322316C0C46; Thu,  4 Jul 2019 10:13:15 -0700 (PDT)
Date:   Thu, 4 Jul 2019 10:13:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Reply-To: paulmck@linux.ibm.com
References: <20190703164134.GA125833@google.com>
 <20190703173935.GU26519@linux.ibm.com>
 <20190703212426.GC146386@google.com>
 <20190703215714.GW26519@linux.ibm.com>
 <20190703222406.GA203913@google.com>
 <20190703230103.GX26519@linux.ibm.com>
 <20190704002130.GA68801@google.com>
 <20190704003213.GA218086@google.com>
 <20190704005009.GZ26519@linux.ibm.com>
 <20190704032454.GA259593@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704032454.GA259593@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070417-2213-0000-0000-000003A96050
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011378; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01227397; UDB=6.00646253; IPR=6.01008634;
 MB=3.00027587; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-04 17:13:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070417-2214-0000-0000-00005F1B8C10
Message-Id: <20190704171315.GG26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040219
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 03, 2019 at 11:24:54PM -0400, Joel Fernandes wrote:
> On Wed, Jul 03, 2019 at 05:50:09PM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 03, 2019 at 08:32:13PM -0400, Joel Fernandes wrote:

[ . . . ]

> > > If I add an rcu_perf_wait_shutdown() to the end of the loop, the outliers go away.
> > > 
> > > Still can't explain that :)
> > > 
> > > 	do {
> > > 		...
> > > 		...
> > > +               rcu_perf_wait_shutdown();
> > >         } while (!torture_must_stop());
> > 
> > Might it be the cond_resched_tasks_rcu_qs() invoked from within
> > rcu_perf_wait_shutdown()?  So I have to ask...  What happens if you
> > use cond_resched_tasks_rcu_qs() at the end of that loop instead of
> > rcu_perf_wait_shutdown()?
> 
> I don't think it is, if I call cond_resched_tasks_rcu_qs(), it still doesn't
> help. Only calling rcu_perf_wait_shutdown() cures it.

My eyes seem to be working better today.

Here is rcu_perf_wait_shutdown():

	static void rcu_perf_wait_shutdown(void)
	{
		cond_resched_tasks_rcu_qs();
		if (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters)
			return;
		while (!torture_must_stop())
			schedule_timeout_uninterruptible(1);
	}

Take a close look at the "while" loop.  It is effectively ending your
test prematurely and thus rendering the code no longer CPU-bound.  ;-)

							Thanx, Paul

>                                                       If you would like try
> it out, below is the diff and the command is:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --qemu-args -net nic,model=e1000
> --bootargs "rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000 rcuperf.holdout=5
>    rcuperf.pd_resched=0 rcutree.jiffies_till_sched_qs=50 rcutree.kthread_prio=10
>    ftrace_dump_on_oops trace_event=rcu:rcu_grace_period"
> 
> (The diff is just for debugging and not meant for upstreaming, atleast not yet)
> ------8<-------
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
> index 4513807cd4c4..08ff48ffa065 100644
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
> @@ -464,6 +478,68 @@ rcu_perf_writer(void *arg)
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
> +		rcu_perf_wait_shutdown();
> +	} while (!torture_must_stop());
> +
> +	torture_kthread_stopping("rcu_perf_preempt_disable");
> +	return 0;
> +}
> +
>  static void
>  rcu_perf_print_module_parms(struct rcu_perf_ops *cur_ops, const char *tag)
>  {
> @@ -548,6 +624,11 @@ rcu_perf_cleanup(void)
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
> @@ -571,7 +652,9 @@ static int compute_real(int n)
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
> @@ -681,6 +764,20 @@ rcu_perf_init(void)
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
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
> index db0375a57f28..c8fd6bb6d8cb 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
> @@ -1,4 +1,5 @@
>  #!/bin/bash
> +set -x
>  # SPDX-License-Identifier: GPL-2.0+
>  #
>  # Analyze a given results directory for rcuperf performance measurements.
> @@ -78,6 +79,7 @@ END {
>  	print "90th percentile grace-period duration: " gptimes[pct90];
>  	print "99th percentile grace-period duration: " gptimes[pct99];
>  	print "Maximum grace-period duration: " gptimes[newNR];
> +	print "Batches " nbatches " done";
>  	print "Grace periods: " ngps + 0 " Batches: " nbatches + 0 " Ratio: " ngps / nbatches;
>  	print "Computed from rcuperf printk output.";
>  }'
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> index 33c669619736..f6ec8de276b7 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> @@ -1,4 +1,5 @@
>  #!/bin/bash
> +set -x
>  # SPDX-License-Identifier: GPL-2.0+
>  #
>  # Run a kvm-based test of the specified tree on the specified configs.
> 

