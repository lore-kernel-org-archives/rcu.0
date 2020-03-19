Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7C6C4332B
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 12:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FD620752
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584621494;
	bh=MGIyi6ywD1IeN+3Zs3XfjScHnDNRPdw+xWx620PErQg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Kxt8FuIGzKZdk28A5O0RiiKEkrbqboeD778BGFWJzGFT5XGgL9Mm68YmqePCkGfZ6
	 zwkcXLyMC3kflFlsfYcouaP3wZuAknGadnmDNyPrpACaQfEQdd9leUir3esWjG0kpR
	 osXG31c0RbxdCow6vrcrFEULF0rEe0T4CgFP/NUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgCSMiN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgCSMiN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Mar 2020 08:38:13 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82DEA20739;
        Thu, 19 Mar 2020 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584621492;
        bh=MGIyi6ywD1IeN+3Zs3XfjScHnDNRPdw+xWx620PErQg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WIq600DCKsGwHQXFnp/jna5HAq2UnQAJeguEU9QsZpi3Cztfg/mSTKLzRPloHSNTs
         svaItfWL53PonxCzMxk69qiT1Vi2ExZMN2qSbDJuZpQoO6Nz/we5ILTXeajD3Uhhxk
         J7KxKPzlFxHmKYNS3Ee9IcHjaGDGZ18R7JE8GCZg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 50D1C35227C6; Thu, 19 Mar 2020 05:38:12 -0700 (PDT)
Date:   Thu, 19 Mar 2020 05:38:12 -0700
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
Message-ID: <20200319123812.GA3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319104614.11444-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319104614.11444-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 19, 2020 at 06:46:14PM +0800, Hillf Danton wrote:
> 
> On Wed, 18 Mar 2020 17:10:41 -0700
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit aids testing of RCU task stall warning messages by adding
> > an rcutorture.stall_cpu_block module parameter that results in the
> > induced stall sleeping within the RCU read-side critical section.
> > Spinning with interrupts disabled is still available via the
> > rcutorture.stall_cpu_irqsoff module parameter, and specifying neither
> > of these two module parameters will spin with preemption disabled.
> > 
> > Note that sleeping (as opposed to preemption) results in additional
> > complaints from RCU at context-switch time, so yet more testing.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
> >  kernel/rcu/rcutorture.c                         | 15 +++++++++------
> >  2 files changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 6d16b78..17eff15 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4161,6 +4161,11 @@
> >  			Duration of CPU stall (s) to test RCU CPU stall
> >  			warnings, zero to disable.
> >  
> > +	rcutorture.stall_cpu_block= [KNL]
> > +			Sleep while stalling if set.  This will result
> > +			in warnings from preemptible RCU in addition
> > +			to any other stall-related activity.
> > +
> >  	rcutorture.stall_cpu_holdoff= [KNL]
> >  			Time to wait (s) after boot before inducing stall.
> >  
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index b3301f3..ada5b91 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -102,6 +102,7 @@ torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
> >  torture_param(int, stall_cpu_holdoff, 10,
> >  	     "Time to wait before starting stall (s).");
> >  torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
> > +torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
> >  torture_param(int, stat_interval, 60,
> >  	     "Number of seconds between stats printk()s");
> >  torture_param(int, stutter, 5, "Number of seconds to run/halt test");
> > @@ -1599,6 +1600,7 @@ static int rcutorture_booster_init(unsigned int cpu)
> >   */
> >  static int rcu_torture_stall(void *args)
> >  {
> > +	int idx;
> >  	unsigned long stop_at;
> >  
> >  	VERBOSE_TOROUT_STRING("rcu_torture_stall task started");
> > @@ -1610,21 +1612,22 @@ static int rcu_torture_stall(void *args)
> >  	if (!kthread_should_stop()) {
> >  		stop_at = ktime_get_seconds() + stall_cpu;
> >  		/* RCU CPU stall is expected behavior in following code. */
> > -		rcu_read_lock();
> > +		idx = cur_ops->readlock();
> >  		if (stall_cpu_irqsoff)
> >  			local_irq_disable();
> > -		else
> > +		else if (!stall_cpu_block)
> >  			preempt_disable();
> >  		pr_alert("rcu_torture_stall start on CPU %d.\n",
> > -			 smp_processor_id());
> > +			 raw_smp_processor_id());
> >  		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
> >  				    stop_at))
> > -			continue;  /* Induce RCU CPU stall warning. */
> > +			if (stall_cpu_block)
> > +				schedule_timeout_uninterruptible(HZ);
> 
> Why is the scheduled-in task so special that it will be running on
> the current CPU with irq disabled?

You lost me on this one.  IRQs are not at all disabled.

Oh, you mean the _uninterruptible suffix?

That only affects accounting during the sleep.  Since this is rcutorture,
the exact suffix is not all that relevant.  So the current state is that
rcutorture tends to use _uninterruptible.

Or am I missing your point?

							Thanx, Paul

> >  		if (stall_cpu_irqsoff)
> >  			local_irq_enable();
> > -		else
> > +		else if (!stall_cpu_block)
> >  			preempt_enable();
> > -		rcu_read_unlock();
> > +		cur_ops->readunlock(idx);
> >  		pr_alert("rcu_torture_stall end.\n");
> >  	}
> >  	torture_shutdown_absorb("rcu_torture_stall");
> > -- 
> > 2.9.5
> 
