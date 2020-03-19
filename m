Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0700C4332B
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 15:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757FA2072D
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584631375;
	bh=yzGcAxB0C+KeElt+4BpqJFWiXG2vLhWxT6V+UOeTDkU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=pBXMpovyJJoXNXdSJIkISKsQRTOAGyV0mtHjPPUPo8bveeqT/hk9wq9PusGKnHdjB
	 6A7Lrds8Np7SwpSo1My2uzAnjLtnhCuLluSNAzaat9vjpTryyaqsvUeuRM0wecCBd8
	 fYyKzdJM7SW2+szt7o880D4jkseILyujMW5Q7YwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgCSPWz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbgCSPWz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Mar 2020 11:22:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C84A120658;
        Thu, 19 Mar 2020 15:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584631373;
        bh=yzGcAxB0C+KeElt+4BpqJFWiXG2vLhWxT6V+UOeTDkU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q4vQwzA/flKbNBzlh8LqbfDrP15uXTdRUOA24G/lXRd8avNQYuhfpaMP0/HWm1Tcm
         kUtlbuuzTurieiNOLCyc/Amn1Q22I6u44QwUajrRhOyIRFyQVegoo6DmGfPf61MYoy
         PbvlokhE8IB2ebPIJ1I3GqwI5ZBO/J4HxG9LIJVU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9B13A3520F2A; Thu, 19 Mar 2020 08:22:53 -0700 (PDT)
Date:   Thu, 19 Mar 2020 08:22:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC v2 tip/core/rcu 03/22] rcutorture: Add flag to
 produce non-busy-wait task stalls
Message-ID: <20200319152253.GE3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319104614.11444-1-hdanton@sina.com>
 <20200319133947.12172-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319133947.12172-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 19, 2020 at 09:39:47PM +0800, Hillf Danton wrote:
> 
> On Thu, 19 Mar 2020 05:38:12 -0700 "Paul E. McKenney" wrote:
> > 
> > On Thu, Mar 19, 2020 at 06:46:14PM +0800, Hillf Danton wrote:
> > > 
> > > On Wed, 18 Mar 2020 17:10:41 -0700
> > > >  static int rcu_torture_stall(void *args)
> > > >  {
> > > > +	int idx;
> > > >  	unsigned long stop_at;
> > > >  
> > > >  	VERBOSE_TOROUT_STRING("rcu_torture_stall task started");
> > > > @@ -1610,21 +1612,22 @@ static int rcu_torture_stall(void *args)
> > > >  	if (!kthread_should_stop()) {
> > > >  		stop_at = ktime_get_seconds() + stall_cpu;
> > > >  		/* RCU CPU stall is expected behavior in following code. */
> > > > -		rcu_read_lock();
> > > > +		idx = cur_ops->readlock();
> > > >  		if (stall_cpu_irqsoff)
> > > >  			local_irq_disable();
> > > > -		else
> > > > +		else if (!stall_cpu_block)
> > > >  			preempt_disable();
> > > >  		pr_alert("rcu_torture_stall start on CPU %d.\n",
> > > > -			 smp_processor_id());
> > > > +			 raw_smp_processor_id());
> > > >  		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
> > > >  				    stop_at))
> > > > -			continue;  /* Induce RCU CPU stall warning. */
> > > > +			if (stall_cpu_block)
> > > > +				schedule_timeout_uninterruptible(HZ);
> > > 
> > > Why is the scheduled-in task so special that it will be running on
> > > the current CPU with irq disabled?
> > 
> > You lost me on this one.
> 
> Quite likely :)
> 
> > IRQs are not at all disabled.
> > 
> > > >  		if (stall_cpu_irqsoff)
> > > >  			local_irq_enable();
> 
> Local IRQs get enabled here depending on stall_cpu_irqsoff.
> 
> What I was asking is the scheduling case like
> 
> 	local_irq_disable();
> 	schedule_timeout(HZ);
> 	local_irq_enable();
> 
> Is it likely going to be ruled out in this patch?

If an rcutorture run specified both the rcutorture.stall_cpu_irqsoff and
the rcutorture.stall_cpu_block module parameters, then yes, exactly the
sequence you call out should occur.  Can't say that I have tried this,
though.  Nor would I expect to have ever done so without your suggesting
that I do.

But why not try it on current -rcu?

tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 12 --duration 3 --configs "TRACE01" --bootargs "rcutorture.stall_cpu=25 rcutorture.stall_cpu_holdoff=30 rcutorture.stall_cpu_block=1 rcupdate.rcu_task_stall_timeout=10000 rcutorture.stall_cpu_irqsoff"

This tells rcutorture to use all 12 hardware threads, to run the kernel for
three minutes, to run only the TRACE01 rcutorture scenario, and to test
RCU CPU stall warnings:

rcutorture.stall_cpu=25: Stall the CPU for 25 seconds.

rcutorture.stall_cpu_holdoff=30: Wait 30 seconds after boot to start stalling.

rcutorture.stall_cpu_block=1: Do the schedule_timeout_uninterruptible()
	while stalling.

rcupdate.rcu_task_stall_timeout=10000: Set the stall-warning timeout
	to 10,000 jiffies, or ten seconds.

rcutorture.stall_cpu_irqsoff: This tells rcutorture to execute the
	local_irq_disable() that you called out above.

And this results in a couple of stall warning messages, as expected
given that you get two ten-second intervals in a 25-second interval.

No other complaints, though.  And of course what happens is that
__schedule() enables interrupts on first call (as it must do) and they
remain enabled past that point.  Then local_irq_enable() redundantly
enables them.

> Or is it anything by design?

So no, not by design.  I don't see any reason to change it.  After all,
if you are running rcutorture and also asking rcutorture to make CPU
stall warnings, you have to expect a bit of noise from the kernel.
Testing that noise is after all the whole point.  ;-)

							Thanx, Paul

> > > > -		else
> > > > +		else if (!stall_cpu_block)
> > > >  			preempt_enable();
> > > > -		rcu_read_unlock();
> > > > +		cur_ops->readunlock(idx);
> > > >  		pr_alert("rcu_torture_stall end.\n");
> > > >  	}
> > > >  	torture_shutdown_absorb("rcu_torture_stall");
> > > > -- 
> > > > 2.9.5
> 
