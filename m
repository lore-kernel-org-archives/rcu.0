Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9500BC4338F
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 19:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B4A60C51
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 19:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhG0Tdo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jul 2021 15:33:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53792 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhG0Tdn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jul 2021 15:33:43 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627414422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vTuPGRP/+EVrh+NDZKAnJQZvU8WcmQ9TOz+2l3oGsRI=;
        b=hU7tdpPY7GZw362jvSpZOVqB4+EBYjTXHhZ86b+1iI1Q8/VMVxqSZ1odMnGCkG2+I5SBc0
        qLvAKvVwd5kOPWH/CMzydXqTVEVeLU2Rvq4HQHCNBKEgwO+quWw5nnclfv1EH4PQq8L8dY
        qM6S4GWNsmjiqG3qfqZCnKuzNxDvO5a/cXP3kIBosn07bNBjVVCjZ6JCT/Ff6GfZCRsPzG
        BJBgQEJPwAT+OchUX4qBnFeUb6hhGBqo3x0/o671rUldrw3qbmv9mbCip2LBfoCjNMBWHI
        NkRNjMTZBzDlSsFsFvx11td2duTjEOMjd0Fdj/TzBHVPKyhvphjBoHBTglj0jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627414422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vTuPGRP/+EVrh+NDZKAnJQZvU8WcmQ9TOz+2l3oGsRI=;
        b=P+UdBdaYGiNJFelR6uOejF4WZ4zfNmw8q+a9Wq+rO5Ffnq7ncSHMaHUY64KxG1GllpJRxP
        ybXiSvY3XHgNRwCQ==
To:     paulmck@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] rcu/nocb: Extend checks for offloaded rdp by migrate_disable
In-Reply-To: <20210727172351.GC4397@paulmck-ThinkPad-P17-Gen-1>
References: <20210727163815.nwvg5delbqs3ysxl@linutronix.de> <20210727172351.GC4397@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 27 Jul 2021 21:33:42 +0200
Message-ID: <87wnpbpn55.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 27 2021 at 10:23, Paul E. McKenney wrote:
> On Tue, Jul 27, 2021 at 06:38:15PM +0200, Sebastian Andrzej Siewior wrote:
>> One thing that has been overseen is that a task within a migrate-disable
>> region (as on PREEMPT_RT with disabled BH) is fully preemptible but may
>> not be migrated to another CPU which should be enough to guarantee that
>> rdp remains stable.
>> 
>> Check also disabled migration of the task if the RCU data pointer is
>> from current CPU. Put the whole check within an SMP ifdef block since
>> without SMP there are not CPU migrations to worry about (also
>> task_struct::migration_disabled is missing).
>> 
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>> I don't fully understand why the CPU-hotplug lock matters here but this
>> is beside the point ;)
>
> If I remember correctly, any attempt to change the offloaded state
> must hold off CPU-hotplug operations.  So if the current thread is
> holding off CPU-hotplug operations, no other thread can be doing
> an offload or de-offload operation.

It only prevents unplugging of a CPU, but not plugging a CPU.

>>  kernel/rcu/tree_plugin.h | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index 0ff5e4fb933e7..d8a623ba7d243 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -57,16 +57,18 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>>  	 * timers have their own means of synchronization against the
>>  	 * offloaded state updaters.
>>  	 */
>> +#ifdef CONFIG_SMP
>>  	RCU_LOCKDEP_WARN(
>>  		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
>>  		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
>>  		  rcu_lockdep_is_held_nocb(rdp) ||
>>  		  (rdp == this_cpu_ptr(&rcu_data) &&
>> -		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
>> +		   (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) ||
>
>
>> +		    current->migration_disabled)) ||
>
> How does this change interact with the one proposed by Valentin?
>
> https://lore.kernel.org/lkml/20210721115118.729943-3-valentin.schneider@arm.com/

It does not interact, it conflicts and Valentin's is definitely the
better solution.

Thanks,

        tglx
