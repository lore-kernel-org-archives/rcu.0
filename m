Return-Path: <SRS0=UQpt=3H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEDFC32771
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 22:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22397246A8
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 22:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579387061;
	bh=gY5n9et+/X3yIwnTpbRLRDdB/7bsxGOGYMeQ3XI0eQs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Wosom70TAIxEiF4g4kGl+sSMszs7j0VV4DxW63D54DM95KbNgNOgo+kA2ffk8N0uS
	 Dki+Cxn4v+a8a3ZI88U39ZUMM7t/YqObqbG8xE9NHUXaLGr/DrM9K3kNHKhLrZ4QaM
	 6PR6nf7axPPy6JgUAlzmv0VRVnApW5Kgrp646Dr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgARWhk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Jan 2020 17:37:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbgARWhk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Jan 2020 17:37:40 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637622469D;
        Sat, 18 Jan 2020 22:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579387059;
        bh=gY5n9et+/X3yIwnTpbRLRDdB/7bsxGOGYMeQ3XI0eQs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TaBUuZGoSGEm7WpYzB67uuswObAKO3TrAuHi0L4HI3selH8XIz27zfOC5wbv7W4AY
         VyA5FyqF+d/zCfNPdM9K60YqwutkmXkes9GiwAxlolMcPirH0yz5RKx7FLmj+g7gLQ
         5XpM9BgVM6fhaaN3HoLe6n2E+XitNLrCEN97tjdk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2DA3735227D6; Sat, 18 Jan 2020 14:37:39 -0800 (PST)
Date:   Sat, 18 Jan 2020 14:37:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rostedt@goodmis.org, bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200118223739.GX2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200117215814.GB206250@google.com>
 <20200117221804.GA211665@google.com>
 <20200117231756.GO2935@paulmck-ThinkPad-P72>
 <20200118021049.GC211665@google.com>
 <20200118042826.GR2935@paulmck-ThinkPad-P72>
 <20200118201208.GC244899@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118201208.GC244899@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jan 18, 2020 at 03:12:08PM -0500, Joel Fernandes wrote:
> On Fri, Jan 17, 2020 at 08:28:26PM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 17, 2020 at 09:10:49PM -0500, Joel Fernandes wrote:
> > > On Fri, Jan 17, 2020 at 03:17:56PM -0800, Paul E. McKenney wrote:
> > > > On Fri, Jan 17, 2020 at 05:18:04PM -0500, Joel Fernandes wrote:
> > > > > On Fri, Jan 17, 2020 at 04:58:14PM -0500, Joel Fernandes wrote:
> > > > > > Hi,
> > > > > > Me and Daniel were poking around with RCU_BOOST. I wrote a kernel module to
> > > > > > test it a bit and I don't see the boost happening (thanks to Daniel for idea
> > > > > > of writing a module). Haven't debugged it more yet. Will look more tomorrow.
> > > > > > But below is the kernel module code and it prints a FAIL message to kernel
> > > > > > logs in a few seconds.
> > > > > > 
> > > > > > I see the reader thread not getting CPU for several seconds. RCU_BOOST_DELAY
> > > > > > is set to 500.
> > > > > > 
> > > > > > Thoughts?
> > > > > 
> > > > > So this could be because I did not start a grace period which is quite silly.
> > > > > I am sorry about that. I will add another thread to start grace periods as
> > > > > well and let you know if I still see a problem.
> > > > 
> > > > In addition, the RCU_READER_DELAY isn't long enough to trigger RCU priority
> > > > boosting.  And RCU_BLOCKER_DELAY would be, except that I am not seeing
> > > > an RCU read-side critical section surrounding it.
> > > 
> > > I was assuming that only the thread being preempted needs an RCU read-side
> > > critical section. That preempted section would inherit the priority of the
> > > thread preempting it (the blocking thread). So the blocking thread would not
> > > need a read-side critical section, it just would need to be higher priority
> > > than the thread it is preempting and preempt it long enough to trigger the
> > > boosting.
> > > 
> > > Did I miss something?
> > 
> > Yes.  That is not how RCU priority boosting works.
> > 
> > What happens instead is that a set of rcub kthreads (one per leaf
> > rcu_node structure) run at the SCHED_FIFO priority specified by the
> > rcutree.kthread_prio kernel-boot parameter (as does the grace-period
> > kthread when RCU priority boosting is enabled).  When the grace-period
> > kthread decides that boosting is needed, it awakens the relevant rcub
> > kthread.  The rcub kthread initializes an rt_mutex into a state where
> > it appears to be held by the task that has been too long in an RCU
> > read-side critical section, then acquires the lock.  The lock-based
> > priority-boosting mechanism kicks in at that point.  (I heard this
> > approach from tglx.)
> 
> Thanks for the details. It makes sense to me.

Glad it helped!

> > And I missed something as well, namely that everything is bound to the
> > same CPU in your test.  But did you remember to set rcutree.kthread_prio
> > to greater than 60?  It defaults to 1 when RCU priority boosting is
> > enabled, which isn't going to do much to a prio-50 SCHED_FIFO task,
> > let alone a prio-60 SCHED_FIFO task.
> 
> Yes indeed this was the issue. I set rcutree.kthread_prio to 90 and see the
> test passing now. Below is the updated test code for archival.

Very good!

> But wouldn't this be an issue unless rcu.kthread_prio is set the MAX_RT_PRIO
> or some high number? Because otherwise there could always be threads that
> don't get boosted.

It depends on the details of the real-time application and system.

Some systems might need rcu.kthread_prio to be set to (say) 57 so that it
didn't interfere with critical userspace tasks running at 58 and above.
So why default to 1 for CONFIG_RCU_BOOST in mainline?  Because the main
usecase there is a system with a massive overload of SCHED_NORMAL tasks.
In this case, SCHED_FIFO priority 1 suffices and minimally interferes
with any realtime workload that might be running.

> > > > But rcutorture already has tests for RCU priority boosting.  Or are those
> > > > failing in some way?
> > > > 
> > > > Either way, it is good to see interest in RCU priority boosting.  ;-)
> > > 
> > > The interest is purely academic and curiousity-driven at this point ;-).
> > 
> > Fair enough!
> > 
> > > Speaking of which why is the config not default-enabled and would it not be a
> > > good thing to enable everywhere or there some who dislike it?
> > 
> > It is enabled by default in the -rt kernel.  It has been some time since
> > I proposed enabling it by default in mainline, but the last time that
> > proposal was not well received.  My approach is to wait until it becomes
> > a problem in mainline, and if it does, propose making it the default in
> > mainline.
> 
> It could also be some problem that no one has root caused to a lack of
> boosting?  ;-)

Quite possibly.  But please understand that setting rcutree.kthread_prio
even to 1 significantly increasees context-switch overhead, which is why
it defaults to zero for CONFIG_RCU_BOOST=n and is also another reason
why CONFIG_RCU_BOOST defaults to n.

> > Except that I haven't heard of any such problems, so I have made no
> > such proposal.
> 
> Makes sense.
> 
> > > Another thought is for RCU_BOOST systems to reduce the threshold of
> > > triggering boost dynamically if the system is at the risk of running out of
> > > memory.
> > 
> > Agreed, and that is in fact the purpose of the check of rcu_state.cbovld
> > in rcu_initiate_boost().  And why we need to get the number of
> > outstanding kfree_rcu() blocks fed into the computation leading up to
> > rcu_state.cbovld.  ;-)
> 
> Oh, I see this new code. I will study it and look into it more. Agreed on the
> feeding of kfree_rcu() blocks and/or memory pressure information into the
> computations leading up to cbovld.

Very good!

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] Kernel module to test RCU_BOOST
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  drivers/misc/Makefile |   2 +-
>  drivers/misc/ptest.c  | 141 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 142 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/ptest.c
> 
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index c1860d35dc7e..ba34957dff26 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -2,7 +2,7 @@
>  #
>  # Makefile for misc devices that really don't fit anywhere else.
>  #
> -
> +obj-m += ptest.o
>  obj-$(CONFIG_IBM_ASM)		+= ibmasm/
>  obj-$(CONFIG_IBMVMC)		+= ibmvmc.o
>  obj-$(CONFIG_AD525X_DPOT)	+= ad525x_dpot.o
> diff --git a/drivers/misc/ptest.c b/drivers/misc/ptest.c
> new file mode 100644
> index 000000000000..e5ece58e45ea
> --- /dev/null
> +++ b/drivers/misc/ptest.c
> @@ -0,0 +1,141 @@
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/vmalloc.h>
> +#include <linux/kthread.h>
> +#include <linux/delay.h>
> +
> +#define RCU_READER_DELAY 100 //ms
> +#define RCU_BLOCKER_DELAY 800 //ms
> +
> +/* Max delta in rcu_reader beyond which we can
> + * say boosting failed.  CONFIG_RCU_BOOST=200 in my setup plus booster wakes up
> + * after 50ms and writer wakes up 150 ms after that So the GP starts only 150ms
> + * later. To be safe, give a max of 400ms for the reader-section.
> + */
> +#define RCU_READER_MAX_DELTA 400 // ms
> +
> +MODULE_LICENSE("GPL");
> +
> +struct sched_param {
> +	int sched_priority;
> +};
> +
> +int stop_test = 0;
> +int test_pass = 1;
> +int reader_exit = 0;
> +s64 delta_fail;
> +
> +#define ns_to_ms(delta) (delta / 1000000ULL)
> +
> +static int rcu_writer(void *a)
> +{
> +	while (!kthread_should_stop() && !stop_test) {
> +		trace_printk("starting gp\n");
> +		synchronize_rcu();
> +		trace_printk("ending gp\n");
> +		msleep(10);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rcu_reader(void *a)
> +{
> +	ktime_t start, end, reader_begin;
> +	s64 delta;
> +
> +	reader_begin = ktime_get();
> +
> +	while (!kthread_should_stop() && !stop_test) {
> +		rcu_read_lock();
> +		trace_printk("rcu_reader entering RSCS\n");
> +		start = ktime_get();
> +		mdelay(RCU_READER_DELAY);
> +		end = ktime_get();
> +		trace_printk("rcu_reader exiting RSCS\n");
> +		rcu_read_lock();
> +		delta = ktime_to_ns(ktime_sub(end, start));
> +
> +		if (delta < 0 || (ns_to_ms(delta) > RCU_READER_MAX_DELTA)) {
> +			delta_fail = delta;
> +			test_pass = 0;
> +			break;
> +		}
> +
> +		// Don't let the rcu_reader() run more than 3s inorder to
> +		// not starve the blocker incase reader prio > blocker prio.
> +		delta = ktime_to_ns(ktime_sub(end, reader_begin));
> +		if (ns_to_ms(delta) > 3000)
> +			break;
> +	}
> +
> +	stop_test = 1;
> +	reader_exit = 1;
> +	pr_err("Exiting reader\n");
> +	return 0;
> +}
> +
> +static int rcu_blocker(void *a)
> +{
> +	int loops = 5;
> +
> +	while (!kthread_should_stop() && loops-- && !stop_test) {
> +		trace_printk("rcu_blocker entering\n");
> +		mdelay(RCU_BLOCKER_DELAY);
> +		trace_printk("rcu_blocker exiting\n");
> +	}
> +
> +	pr_err("Exiting blocker\n");
> +	stop_test = 1;
> +
> +	// Wait for reader to finish
> +	while (!reader_exit)
> +		schedule_timeout_uninterruptible(1);
> +
> +	if (test_pass)
> +		pr_err("TEST PASSED\n");
> +	else
> +		pr_err("TEST FAILED, failing delta=%lldms\n", ns_to_ms(delta_fail));
> +
> +	return 0;
> +}
> +
> +static int __init ptest_init(void){
> +	struct sched_param params;
> +	struct task_struct *reader, *blocker, *writer;
> +
> +	reader = kthread_create(rcu_reader, NULL, "reader");
> +	params.sched_priority = 50;
> +	sched_setscheduler(reader, SCHED_FIFO, &params);
> +	kthread_bind(reader, smp_processor_id());
> +
> +	blocker = kthread_create(rcu_blocker, NULL, "blocker");
> +	params.sched_priority = 60;
> +	sched_setscheduler(blocker, SCHED_FIFO, &params);
> +	kthread_bind(blocker, smp_processor_id());
> +
> +	writer = kthread_create(rcu_writer, NULL, "writer");
> +	params.sched_priority = 70;
> +	sched_setscheduler(writer, SCHED_FIFO, &params);
> +	kthread_bind(writer, smp_processor_id());
> +
> +	wake_up_process(reader);
> +
> +	// Let reader run a little
> +	mdelay(50);
> +
> +	wake_up_process(blocker);
> +
> +	// Let blocker run a little
> +	mdelay(100);
> +
> +	wake_up_process(writer);
> +	return 0;
> +}
> +
> +static void __exit ptest_exit(void){
> +}
> +
> +module_init(ptest_init);
> +module_exit(ptest_exit);
> -- 
> 2.25.0.341.g760bfbb309-goog
> 
