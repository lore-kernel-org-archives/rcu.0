Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C736EC61DD8
	for <rcu@archiver.kernel.org>; Mon, 16 Nov 2020 16:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BCA02223D
	for <rcu@archiver.kernel.org>; Mon, 16 Nov 2020 16:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="cg4ODbsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbgKPQFY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:05:24 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:21730 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729795AbgKPQFY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Nov 2020 11:05:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605542722; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=7F+PuoXWB2FigaPPoo4CtmceDe9MskEyoQRjJxVJmv8=; b=cg4ODbsgYYAnqqeziuP45JmIUpqnHN6mmbDH4R6Xt70KtCpxl5+ZvhFWq+Dq0UH0n70gpXhs
 1bAEMnV4tJUvQHOk6a1XBfpcs+ZVHt0boMlRtL2t8KUuq1IQxsFRP/Z7mTdIUMMEiyLMHHGg
 nWlwY3JkDyVGBUYh/vFK1//k5rQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fb2a33d25da3a0fa9f24b0f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Nov 2020 16:05:17
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 02332C433C6; Mon, 16 Nov 2020 16:05:17 +0000 (UTC)
Received: from [192.168.0.105] (unknown [124.123.182.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6925FC433ED;
        Mon, 16 Nov 2020 16:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6925FC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu: Check and report missed fqs timer wakeup on RCU
 stall
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1605103657-25815-1-git-send-email-neeraju@codeaurora.org>
 <20201111193121.GC3249@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <46fb3937-3a1d-7fb1-9493-bf11b6ef8dad@codeaurora.org>
Date:   Mon, 16 Nov 2020 21:35:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201111193121.GC3249@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On 11/12/2020 1:01 AM, Paul E. McKenney wrote:
> On Wed, Nov 11, 2020 at 07:37:37PM +0530, Neeraj Upadhyay wrote:
>> For a new grace period request, RCU GP kthread transitions
>> through following states:
>>
>> a. [RCU_GP_WAIT_GPS] -> [RCU_GP_DONE_GPS]
>>
>> Initial state, where GP kthread waits for a new GP start
>> request is RCU_GP_WAIT_GPS. On new GP request (started by
>> callers, for any new callbacks, by setting RCU_GP_FLAG_INIT
>> gp_state flag and waking up the GP kthread) GP kthread
>> enters RCU_GP_DONE_GPS.
>>
>> b. [RCU_GP_DONE_GPS] -> [RCU_GP_ONOFF]
>>
>> Grace period initialization starts in rcu_gp_init(), which
>> records the start of new GP in rcu_state.gp_seq and enters
>> into RCU_GP_ONOFF state.
>>
>> c. [RCU_GP_ONOFF] -> [RCU_GP_INIT]
>>
>> In RCU_GP_ONOFF state, for each leaf rnp node, GP kthread
>> applies the buffered online/offline information of its cpus,
>> from ->qsmaskinitnext to ->qsmaskinit, which is basically
>> the mask of cpus, which need to report quiescent state, for
>> the new GP to complete.
>>
>> Also, in this state, an outgoing rnp's (for which all cpus
>> are now offline and there are no tasks blocked inside
>> RCU read section) or an incoming rnp's (for which first cpu
>> comes online) participation in the new and subsequent GP is
>> advertised, by propagating its qsmaskinit information up the
>> tree.
>>
>> d. [RCU_GP_INIT] -> [RCU_GP_WAIT_FQS]
>>
>> In RCU_GP_INIT state, current GPs qs mask information and new
>> GP seq is propagated down the tree, into all rnp nodes,
>> in breadth first order.
>>
>> On GP initialization completion, GP kthread enters a fqs loop,
>> which does following things, to get quiescent state reported
>> for cpus, which aren't quiesce in ->qsmask:
>>
>>    i. For CPUs, which have entered idle since the first iteration,
>>       report quiescent state up the tree.
>>
>>    ii. Based on how long the current grace period has been running
>>        for, either, set the appropriate flags, so that sched clock
>>        interrupt on that cpu, does qs reporting or do a resched
>>        on that cpu.
>>
>> On each iteration, it transitions through following states. The fqs
>> loop is terminated on GP completion, when all CPUs report their
>> quiescent state and all RCU readers, blocking current grace period
>> have completed the RCU read section.
>>
>> e. [RCU_GP_WAIT_FQS] -> [RCU_GP_DOING_FQS]
>>
>> GP kthread uses a timed wait (jiffies_till_first_fqs for first
>> iteration and jiffies_till_next_fqs for subsequent iterations),
>> before doing all the work, to force quiescent state on
>> all cpus. It wakes up from this state, either on timeout, or
>> when (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD) flags are set, either
>> on callback overload conditions or when last cpu reports its
>> quiescent state and all RCU readers blocking current GP, have
>> left the RCU read section.
>>
>> f. [RCU_GP_CLEANUP] -> [RCU_GP_CLEANED]
>>
>> Mark end of grace period, in ->gp_seq, on all rnp nodes, in breadth
>> first order and finally in rcu_state.
>>
>> For cases where timers are not served (due to issues in timer
>> configuration, in timer framework or due to softirqs not getting
>> handled, when there is a storm of interrupts) on the CPU,
>> where GP kthread queued a timer (for timed wait, which is done
>> in RCU_GP_WAIT_FQS) its possible that RCU kthread never wakes up.
>> Report the same from stall warnings, if GP thread is in RCU_GP_WAIT_FQS
>> state, and the timeout has elapsed and the kthread is not woken.
>>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>> ---
>>   kernel/rcu/tree.c       | 25 +++++++++++++++----------
>>   kernel/rcu/tree_stall.h | 33 +++++++++++++++++++++++++++++++++
>>   2 files changed, 48 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 413831b..804e543 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -1767,7 +1767,7 @@ static bool rcu_gp_init(void)
>>   	 * go offline later.  Please also refer to "Hotplug CPU" section
>>   	 * of RCU's Requirements documentation.
>>   	 */
>> -	rcu_state.gp_state = RCU_GP_ONOFF;
>> +	WRITE_ONCE(rcu_state.gp_state, RCU_GP_ONOFF);
>>   	rcu_for_each_leaf_node(rnp) {
>>   		smp_mb(); // Pair with barriers used when updating ->ofl_seq to odd values.
>>   		firstseq = READ_ONCE(rnp->ofl_seq);
>> @@ -1833,7 +1833,7 @@ static bool rcu_gp_init(void)
>>   	 * The grace period cannot complete until the initialization
>>   	 * process finishes, because this kthread handles both.
>>   	 */
>> -	rcu_state.gp_state = RCU_GP_INIT;
>> +	WRITE_ONCE(rcu_state.gp_state, RCU_GP_INIT);
>>   	rcu_for_each_node_breadth_first(rnp) {
>>   		rcu_gp_slow(gp_init_delay);
>>   		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>> @@ -1932,17 +1932,22 @@ static void rcu_gp_fqs_loop(void)
>>   	ret = 0;
>>   	for (;;) {
>>   		if (!ret) {
>> -			rcu_state.jiffies_force_qs = jiffies + j;
>> +			WRITE_ONCE(rcu_state.jiffies_force_qs, jiffies + j);
>> +			/*
>> +			 * jiffies_force_qs before RCU_GP_WAIT_FQS state
>> +			 * update; required for stall checks.
>> +			 */
>> +			smp_wmb();
>>   			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
>>   				   jiffies + (j ? 3 * j : 2));
>>   		}
>>   		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>>   				       TPS("fqswait"));
>> -		rcu_state.gp_state = RCU_GP_WAIT_FQS;
>> +		WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_FQS);
>>   		ret = swait_event_idle_timeout_exclusive(
>>   				rcu_state.gp_wq, rcu_gp_fqs_check_wake(&gf), j);
>>   		rcu_gp_torture_wait();
>> -		rcu_state.gp_state = RCU_GP_DOING_FQS;
>> +		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
>>   		/* Locking provides needed memory barriers. */
>>   		/* If grace period done, leave loop. */
>>   		if (!READ_ONCE(rnp->qsmask) &&
>> @@ -2056,7 +2061,7 @@ static void rcu_gp_cleanup(void)
>>   	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
>>   	rcu_seq_end(&rcu_state.gp_seq);
>>   	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
>> -	rcu_state.gp_state = RCU_GP_IDLE;
>> +	WRITE_ONCE(rcu_state.gp_state, RCU_GP_IDLE);
>>   	/* Check for GP requests since above loop. */
>>   	rdp = this_cpu_ptr(&rcu_data);
>>   	if (!needgp && ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
>> @@ -2095,12 +2100,12 @@ static int __noreturn rcu_gp_kthread(void *unused)
>>   		for (;;) {
>>   			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>>   					       TPS("reqwait"));
>> -			rcu_state.gp_state = RCU_GP_WAIT_GPS;
>> +			WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_GPS);
>>   			swait_event_idle_exclusive(rcu_state.gp_wq,
>>   					 READ_ONCE(rcu_state.gp_flags) &
>>   					 RCU_GP_FLAG_INIT);
>>   			rcu_gp_torture_wait();
>> -			rcu_state.gp_state = RCU_GP_DONE_GPS;
>> +			WRITE_ONCE(rcu_state.gp_state, RCU_GP_DONE_GPS);
>>   			/* Locking provides needed memory barrier. */
>>   			if (rcu_gp_init())
>>   				break;
>> @@ -2115,9 +2120,9 @@ static int __noreturn rcu_gp_kthread(void *unused)
>>   		rcu_gp_fqs_loop();
>>   
>>   		/* Handle grace-period end. */
>> -		rcu_state.gp_state = RCU_GP_CLEANUP;
>> +		WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANUP);
>>   		rcu_gp_cleanup();
>> -		rcu_state.gp_state = RCU_GP_CLEANED;
>> +		WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANED);
>>   	}
>>   }
>>   
>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>> index 70d48c5..4ff7990 100644
>> --- a/kernel/rcu/tree_stall.h
>> +++ b/kernel/rcu/tree_stall.h
>> @@ -468,6 +468,37 @@ static void rcu_check_gp_kthread_starvation(void)
>>   	}
>>   }
>>   
>> +/* Complain about missing wakeups from expired fqs wait timer */
>> +static void rcu_check_gp_kthread_expired_fqs_timer(void)
>> +{
>> +	struct task_struct *gpk = rcu_state.gp_kthread;
>> +	short gp_state;
>> +	unsigned long jiffies_fqs;
>> +	int cpu;
>> +
>> +	gp_state = READ_ONCE(rcu_state.gp_state);
>> +	/*
>> +	 * Order reads of .gp_state and .jiffies_force_qs.
>> +	 * Matching smp_wmb() is present in rcu_gp_fqs_loop().
>> +	 */
>> +	smp_rmb();
>> +	jiffies_fqs = READ_ONCE(rcu_state.jiffies_force_qs);
> 
> Or you could use smp_load_acquire() instead of the smp_rmb()/READ_ONCE()
> combination.  (Other parts of the stall-warning code might also be able
> to do this, given that they predate smp_load_acquire().)
> 

Done for this part; will check other parts for cleanup.

>> +
>> +	if (gp_state == RCU_GP_WAIT_FQS &&
>> +	    time_before(jiffies + RCU_STALL_MIGHT_MIN, jiffies_fqs) &&
>> +	    gpk && !READ_ONCE(gpk->on_rq)) {
>> +		cpu = task_cpu(gpk);
>> +		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx\n",
>> +		       rcu_state.name, (jiffies - jiffies_fqs),
>> +		       (long)rcu_seq_current(&rcu_state.gp_seq),
>> +		       data_race(rcu_state.gp_flags),
>> +		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
>> +		       gpk->state);
>> +		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
>> +		       cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
>> +	}
> 
> Otherwise looks plausible.
> 
>> +}
>> +
>>   static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>>   {
>>   	int cpu;
>> @@ -530,6 +561,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>>   			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
>>   
>>   	rcu_check_gp_kthread_starvation();
>> +	rcu_check_gp_kthread_expired_fqs_timer();
>>   
>>   	panic_on_rcu_stall();
>>   
>> @@ -565,6 +597,7 @@ static void print_cpu_stall(unsigned long gps)
>>   		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
>>   
>>   	rcu_check_gp_kthread_starvation();
>> +	rcu_check_gp_kthread_expired_fqs_timer();
> 
> I don't have an opinion about the ordering of this output within the
> RCU CPU stall warning message, but I do encourage you to try out a
> few different options.
> 

I think all stall warnings which describe GP kthread state - like 
starvation, timer wakeup, can be kept close to each other?

> Here is one possible way to test this code:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs TREE09 --bootargs "rcutorture.stall_cpu=25 rcutorture.stall_cpu_irqsoff=1" --trust-make
> 
> As an alternative to the above "--bootargs" parameter, the
> rcutorture.stall_gp_kthread module parameter should also be interesting.
> If I remember correctly, it should result in a stall without causing
> your timer code above to print anything.
> 
> See recent paulmck.livejournal.com posts for additional information
> on rcutorture and running it.
> 
> 							Thanx, Paul
> 

Thanks! Wasn't able to get the warning with below:
tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 
--configs TREE09 --bootargs "rcutorture.stall_cpu=25 
rcutorture.stall_cpu_irqsoff=1" --trust-make

Possibly, for single cpu case, while interrupts are disabled, stall
checks didn't happen?

Was able to reproduce with

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 
--configs TREE01 --bootargs "rcutorture.stall_gp_kthread=50" --trust-make

Below is the log output; I moved the warning above starvation logs,
so that its visible before nmi backtrace printed from starvation logs:

[   32.780341] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   32.782062]  (detected by 4, t=21003 jiffies, g=981, q=36134)
[   32.782065] rcu: All QSes seen, last rcu_preempt kthread activity 
20958 (4294699485-4294678527), jiffies_till_next_fqs=3, root ->qsmask 0x0
[   32.786652] rcu: rcu_preempt kthread timer wakeup didn't happen for 
20957 jiffies! g981 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x402
[   32.788868] rcu:     Possible timer handling issue on cpu=4 
timer-softirq=11142
[   32.789946] rcu: rcu_preempt kthread starved for 20960 jiffies! g981 
f0x2 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=4 fqs: 4294678530/4294699487
[   32.791866] rcu:     Unless rcu_preempt kthread gets sufficient CPU 
time, OOM is now expected behavior.
[   32.793258] rcu: RCU grace-period kthread stack dump:
[   32.794046] task:rcu_preempt     state:I stack:14624 pid:   10 ppid: 
     2 flags:0x00004000
[   32.795326] Call Trace:
[   32.795718]  __schedule+0x269/0x6b0
[   32.796262]  schedule+0x41/0xe0
[   32.796704]  schedule_timeout+0x19c/0x2e0



Thanks
Neeraj

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
