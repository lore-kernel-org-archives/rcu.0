Return-Path: <SRS0=jKPx=DA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB495C4363D
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 07:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9252220D
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 07:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="rwl7rzsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIWHWv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:22:51 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:63282 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgIWHWu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Sep 2020 03:22:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600845769; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=pFUg1O6TaPa2Sz1vngsUvigj6ljyzP1o52zJXZpUic8=; b=rwl7rzsm/Lb9xl5wNxHhQHdJYOvIe505nXLnsvLqBySD6dPi345qbUYSFtCk0J9J4M/Cdmsa
 e2DZAb/TzR+cuVA/id7qFRQGKDgfTapBhhwvzfSCJ6nKtpAT6ur2rPlwT2kcZlyYsKQ25GZn
 SQJUj1aiuA1bjeN7iGL5+R3SaVM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f6af7bd588e0a9888f1d6f7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Sep 2020 07:22:37
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0613BC433F1; Wed, 23 Sep 2020 07:22:37 +0000 (UTC)
Received: from [192.168.0.103] (unknown [124.123.174.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC35AC433CB;
        Wed, 23 Sep 2020 07:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC35AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu/tree: Correctly handle single cpu check in
 rcu_blocking_is_gp
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1600717557-19880-1-git-send-email-neeraju@codeaurora.org>
 <20200922202917.GB29330@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <bb919430-a81f-daae-b3a9-8581ae334ac5@codeaurora.org>
Date:   Wed, 23 Sep 2020 12:52:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922202917.GB29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On 9/23/2020 1:59 AM, Paul E. McKenney wrote:
> On Tue, Sep 22, 2020 at 01:15:57AM +0530, Neeraj Upadhyay wrote:
>> Currently, for non-preempt kernels (with CONFIG_PREEMPTION=n),
>> rcu_blocking_is_gp() checks (with preemption disabled), whether
>> there is only one cpu online. It uses num_online_cpus() to
>> decide whether only one cpu is online. If there is only single
>> cpu online, synchronize_rcu() is optimized to return without
>> doing all the work to wait for grace period. However, there are
>> few issues with the num_online_cpus() check used:
> 
> Great catch!!!
> 
> I do have some questions about your suggested fix, though.
> 
>> 1. num_online_cpus() does a atomic_read(&__num_online_cpus). As
>>     hotplug locks are not held, this does not ensure that
>>     new incoming cpus update of the count is visible. This can
>>     result in read side section on new incoming cpu, observe
>>     updates which should not be visible beyond the grace period
>>     corresponding to synchronize_rcu().
>>
>>     For e.g. below litmus test, where P0 process corresponds to
>>     synchronize_rcu() and P1 corresponds to new online cpu,  has
>>     positive witnesses; confirming the possibility of read side
>>     section to extend before and after the grace period, thereby
>>     breaking guarantees provided by synchronize_rcu().
>>
>>     {
>>       int x = 0;
>>       atomic_t numonline = ATOMIC_INIT(1);
>>     }
>>
>>     P0(int *x, atomic_t *numonline)
>>     {
>>       int r0;
>>       WRITE_ONCE(*x, 1);
>>       r0 = atomic_read(numonline);
>>       if (r0 == 1) {
>>         smp_mb();
>>       } else {
>>         synchronize_rcu();
>>       }
>>       WRITE_ONCE(*x, 2);
>>     }
>>
>>     P1(int *x, atomic_t *numonline)
>>     {
>>       int r0; int r1;
>>
>>       atomic_inc(numonline);
>>       smp_mb();
>>       rcu_read_lock();
>>       r0 = READ_ONCE(*x);
>>       smp_rmb();
>>       r1 = READ_ONCE(*x);
>>       rcu_read_unlock();
>>     }
>>
>>     locations [x;numonline;]
>>
>>     exists (1:r0=0 /\ 1:r1=2)
>>
>> 2. Second problem is, the same early exit, from synchronize_rcu()
>>     does not provide full ordering, memory barrier, w.r.t. memory
>>     accesses after synchronize_rcu() call.
>>
>> 3. Third, more important issue is related to outgoing cpu. Checking
>>     only for __num_online_cpus with preemotion disabled isn't sufficient
>>     for RCU, as, on completion of CPUHP_TEARDOWN_CPU stop machine (which
>>     clears outgoing cpu from __num_online_cpus, the CPU switches to idle
>>     task. So, checking only for __num_online_cpus does not consider
>>     RCU read side sections in scheduler code (before switching to idle
>>     task) and any potential read side sections in idle task, before final
>>     RCU-quiesce entry into cpuhp_report_idle_dead() -> rcu_report_dead().
>>
>> To handle these issues, add a new rcu_state member n_online_cpus, to
>> keep account of the current number of online cpus. The atomic updates
>> to this counter from rcu_report_dead() and rcu_cpu_starting() and
>> the added read/write memory ordering semantics ensure that
>> synchronize_rcu() fast path waits for all read side sections, where
>> incoming/outgoing cpus are considered online, for RCU i.e. after
>> rcu_cpu_starting() and before rcu_report_dead().
>>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>> ---
>>
>> Below is the reproducer for issue described in point 3; this snippet
>> is based on klitmus generated test, which is modified to sample reads
>> from idle thread:
>>
>> static void code0(int* x) {
>> WRITE_ONCE(*x, 1);
>>    idle_ctr = 0;
>>    smp_mb();
>>    mdelay(10);
>>    WRITE_ONCE(*x, 1);
>>    idle_ctr = 1;
>>    synchronize_rcu();
>>    WRITE_ONCE(*x, 2);
>>    idle_ctr = 2;
>>
>> }
>>
>> static int thread0(void *_p) {
>>    int _j, _i;
>>    ctx_t *_a = (ctx_t *)_p;
>>
>>    smp_mb();
>>    for (_j = 0 ; _j < stride ; _j++) {
>>      for (_i = _j ; _i < size ; _i += stride) {
>>        while (idle_wait1) {
>>            cpu_relax();
>>            cond_resched();
>>          }
>>        code0(&_a->x[_i]);
>>        smp_mb();
>>        get_online_cpus();
>>        idle_wait1 = true;
>>        put_online_cpus();
>>      }
>>    }
>>    atomic_inc(&done);
>>    smp_mb();
>>    wake_up(wq);
>>    smp_mb();
>>    do_exit(0);
>> }
>>
>>
>> static void code1(int* x,int* out_1_r1,int* out_1_r0) {
>>
>>    int r0; int r1;
>>
>>    r0 = READ_ONCE(idle_ctr_snap1);
>>    r1 = READ_ONCE(idle_ctr_snap2);
>>
>>    *out_1_r1 = (int)r1;
>>    *out_1_r0 = (int)r0;
>> }
>>
>> static int thread1(void *_p) {
>>    ctx_t *_a = (ctx_t *)_p;
>>    int _j, _i;
>>
>>    smp_mb();
>>    for (_j = 0 ; _j < stride ; _j++) {
>>      for (_i = _j ; _i < size ; _i += stride) {
>>        while (idle_wait2) {
>>            cpu_relax();
>>            cond_resched();
>>        }
>>        get_online_cpus();
>>        code1(&_a->x[_i],&_a->out_1_r1[_i],&_a->out_1_r0[_i]);
>>        smp_mb();
>>        idle_wait2 = true;
>>        put_online_cpus();
>>      }
>>    }
>>    atomic_inc(&done);
>>    smp_mb();
>>    wake_up(wq);
>>    smp_mb();
>>    do_exit(0);
>> }
>>
>> Idle thread snippet:
>>
>> if (cpu_is_offline(cpu)) {
>>          smp_mb();
>>          idle_wait1 = false;
>>          mdelay(8);
>>          smp_mb();
>>          rcu_read_lock();
>>          idle_ctr_snap1 = idle_ctr;
>>          mdelay(40);
>>          smp_rmb();
>>          idle_ctr_snap2 = idle_ctr;
>>          rcu_read_unlock();
>>          smp_mb();
>>          idle_wait2 = false;
>>          tick_nohz_idle_stop_tick();
>>          cpuhp_report_idle_dead();
>>          arch_cpu_idle_dead();
>>
>>   kernel/rcu/tree.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   kernel/rcu/tree.h |  1 +
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 2424e2a..33493f0 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -3609,9 +3609,59 @@ static int rcu_blocking_is_gp(void)
>>   	if (IS_ENABLED(CONFIG_PREEMPTION))
>>   		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
>>   	might_sleep();  /* Check for RCU read-side critical section. */
>> +	/*
>> +	 * a = p
>> +	 * a = NULL
>> +	 * synchronize_rcu()
>> +	 *   rcu_blocking_is_gp()
>> +	 *     num_online_cpus()
>> +	 *       atomic_read(&__num_online_cpus)
>> +	 * kfree(p);
>> +	 *
>> +	 *      - VS -
>> +	 *
>> +	 *              __cpu_up()
>> +	 *                set_cpu_online(cpu)
>> +	 *                  atomic_inc(&__num_online_cpus)
>> +	 *              rcu_read_lock()
>> +	 *              rcu_dereference(a) (a == p)
>> +	 *              rcu_read_unlock()
>> +	 *
>> +	 * rcu_blocking_is_gp() must observe atomic_inc(&__num_online_cpus),
>> +	 * in order to ensure that, RCU read side critical section on new
>> +	 * online cpu, either start after synchronize_rcu()'s GP starts or
>> +	 * it completes before synchronize_rcu() returns.
>> +	 *
>> +	 * However, atomic_read(&__num_online_cpus) does not ensure that.
>> +	 *
>> +	 * Essentially, below condition exist:
>> +	 *
>> +	 * {
>> +	 *   int x = 0;
>> +	 *   atomic_t numonline = ATOMIC_INIT(1);
>> +	 * }
>> +	 *
>> +	 * P0(int *x, atomic_t *numonline)     P1(int *x, atomic_t *numonline)
>> +	 * {                                   {
>> +	 *   int r0;                             int r0; int r1;
>> +	 *   WRITE_ONCE(*x, 1);                  atomic_inc(numonline);
>> +	 *   r0 = atomic_read(numonline);        rcu_read_lock();
>> +	 *   if (r0 == 2) {                      r0 = READ_ONCE(*x);
>> +	 *     synchronize_rcu();                smp_rmb();
>> +	 *   }                                   r1 = READ_ONCE(*x);
>> +	 *   WRITE_ONCE(*x, 2);                  rcu_read_unlock();
>> +	 * }                                   }
>> +	 *
>> +	 * exists (1:r0=0 /\ 1:r1=2)
>> +	 *
>> +	 * atomic_add_return(0, &rcu_state.n_online_cpus) and corresponding
>> +	 * atomic_inc(&rcu_state.n_online_cpus) in rcu_cpu_starting() corrects
>> +	 * this ordering issue.
>> +	 */
>>   	preempt_disable();
>>   	ret = num_online_cpus() <= 1;
> 
> Here I assume that rcu_state.n_online_cpus is incremented early in
> the CPU-hotplug CPU-online process, that is, on one of the CPUs that
> was running prior to the new CPU coming online.  (The problem with the
> existing code is not the lack of ordering, but rather that the changes
> to the number of online CPUs happen in places that are not helpful to
> synchronize_rcu().)
> 
> If rcu_state.n_online_cpus is equal to one at any point in this region of
> code, there is only one CPU, and that CPU sees all prior accesses made
> by any CPU that was online at the time of its access.  Furthermore, if
> rcu_state.n_online_cpus is equal to one, its value cannot change until
> after the preempt_enable() below.
> 
> Furthermore, if n_online_cpus is equal to one here, all later CPUs
> (both this one and any that come online later on) are guaranteed to see
> all accesses by any CPU prior to this point in the code, and without
> added memory barriers.  Those memory barriers have to be present in the
> CPU-hotplug code or lots of things would break.
> 
> On the other hand, if n_online_cpus is greater than one, then we
> will be using the heavyweight call to synchronize_rcu(), which will
> guarantee all the ordering we need.  (Please refer to the rather
> lengthy header comment for synchronize_rcu().)
> 
> So if you access rcu_state.n_online_cpus with preemption disabled,
> READ_ONCE() suffices and no memory barriers are required.
> 
>>   	preempt_enable();
> 
> And we only get to this point in the code when CONFIG_PREEMPT_NONE=y,
> so the preempt_disable() and preempt_enable() are optional.  Though they
> can be argued to be useful documentation.  Or maybe not...
> 

I also noticed it. For CONFIG_PREEMPTION=n, preempt_disable() and 
preempt_enable() adds barrier(); I thought that was required for the
case where num online cpus <= 1?

>> +	ret = ret && (atomic_add_return(0, &rcu_state.n_online_cpus) <= 1);
>>   	return ret;
>>   }
>>   
>> @@ -3655,6 +3705,11 @@ void synchronize_rcu(void)
>>   			 lock_is_held(&rcu_sched_lock_map),
>>   			 "Illegal synchronize_rcu() in RCU read-side critical section");
>>   	if (rcu_blocking_is_gp())
>> +		/*
>> +		 * atomic_add_return() in rcu_blocking_is_gp () provides
>> +		 * full memory barrier ordering with any rcu section after
>> +		 * synchronize_rcu() call.
>> +		 */
> 
> Given your fix of having RCU keep its own count of the number of online
> CPUs, no additional ordering is required.  Either synchronize_rcu()
> provides what is required or we are in single-CPU state, meaning we
> don't need any ordering.
> 
>>   		return;
>>   	if (rcu_gp_is_expedited())
>>   		synchronize_rcu_expedited();
>> @@ -4086,6 +4141,10 @@ void rcu_cpu_starting(unsigned int cpu)
>>   	mask = rdp->grpmask;
>>   	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>>   	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
>> +	/* Order with access of n_online_cpus in rcu_blocking_is_gp */
>> +	atomic_inc(&rcu_state.n_online_cpus);
>> +	/* Order with rcu-side usages after this */
>> +	smp_mb__after_atomic();
> 
> Ah, here is the problem.  Please instead put the increment in
> rcutree_prepare_cpu(), which in the one-to-two transition will be running
> on the single CPU in the system, thus avoiding the need for ordering.
> Yes, this will result in unnecessary calls to synchronize_rcu() during
> the CPU-online process, but who cares?  ;-)
> 
>>   	newcpu = !(rnp->expmaskinitnext & mask);
>>   	rnp->expmaskinitnext |= mask;
>>   	/* Allow lockless access for expedited grace periods. */
>> @@ -4138,6 +4197,12 @@ void rcu_report_dead(unsigned int cpu)
>>   		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>>   	}
>>   	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
>> +	/*
>> +	 * Order with access of n_online_cpus in rcu_blocking_is_gp().
>> +	 * Release semantics ensures that RCU read sections before it
>> +	 * are observed by rcu_blocking_is_gp().
>> +	 */
>> +	atomic_dec_return_release(&rcu_state.n_online_cpus);
> 
> Similarly, please put this decrement into rcutree_dead_cpu(), which
> runs on one of the remaining CPUs after the outgoing CPU is long gone.
> In the two-to-one transition, this will run on the single remaining
> CPU in the system, thus avoiding the need for ordering.  Again, yes,
> this will result in unnecessary calls to synchronize_rcu() during the
> CPU-online process, but again who cares?
> 
>>   	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>>   	raw_spin_unlock(&rcu_state.ofl_lock);
>>   
>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>> index e4f66b8..4d9a9c0 100644
>> --- a/kernel/rcu/tree.h
>> +++ b/kernel/rcu/tree.h
>> @@ -298,6 +298,7 @@ struct rcu_state {
>>   						/* Hierarchy levels (+1 to */
>>   						/*  shut bogus gcc warning) */
>>   	int ncpus;				/* # CPUs seen so far. */
>> +	atomic_t n_online_cpus;			/* # CPUs online for RCU. */
> 
> With those changes in place, this can be just an int.  The increments
> and decrements can use normal C-language loads and WRITE_ONCE() for the
> stores.  The trick is that this value will only change from one to two
> (and vice versa) when there is only one online CPU.
> 
> And the num_online_cpus() can be replaced with a READ_ONCE().
> 
> Does this make sense, or am I missing something?
> 
> 							Thanx, Paul
> 

Yes, this makes sense; thanks for the details! Will post v2.


Thanks
Neeraj

>>   	/* The following fields are guarded by the root rcu_node's lock. */
>>   
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
