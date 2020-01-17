Return-Path: <SRS0=lUfD=3G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F62C33C9E
	for <rcu@archiver.kernel.org>; Fri, 17 Jan 2020 23:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EB721D7D
	for <rcu@archiver.kernel.org>; Fri, 17 Jan 2020 23:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579303077;
	bh=l2JrLIxpzLl7o37MDa557oe6R7nr826zfDS+Oyza8mc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=P2xZkH9TjnNmo+3+weHlzDMmnE8P8mq+4DjOgYrzb4WYNu5k3ZAxouxjaDn6zILOh
	 DyPubmWjwY/3kDPWD1CjE1vIvsfa1U65B5uhxQ2kmphVA2eoYsaQ6lrhV9ZVAYJVqR
	 bImiZWp299eZTX13nChdSkOQ+GXjUJw5ivgx/s0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgAQXR5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgAQXR5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Jan 2020 18:17:57 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B5CD21835;
        Fri, 17 Jan 2020 23:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579303076;
        bh=l2JrLIxpzLl7o37MDa557oe6R7nr826zfDS+Oyza8mc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iShH654ajefMt43zeyUXi4kcYXJ9rcSZr/WeRle97+WXfr+YxDe/KsbFTItIPU66f
         2H5dMuLIMT+CMX/zidVODZBPbzL0q/ghxUlRRzV9BQOttAy80E7T7XAIKWen1PqcJ9
         uH7gtMQi0sbjdL8VsFgh3htkoKz2wnxyIOVQZDAA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1F75035228BF; Fri, 17 Jan 2020 15:17:56 -0800 (PST)
Date:   Fri, 17 Jan 2020 15:17:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rostedt@goodmis.org, bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200117231756.GO2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200117215814.GB206250@google.com>
 <20200117221804.GA211665@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117221804.GA211665@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 17, 2020 at 05:18:04PM -0500, Joel Fernandes wrote:
> On Fri, Jan 17, 2020 at 04:58:14PM -0500, Joel Fernandes wrote:
> > Hi,
> > Me and Daniel were poking around with RCU_BOOST. I wrote a kernel module to
> > test it a bit and I don't see the boost happening (thanks to Daniel for idea
> > of writing a module). Haven't debugged it more yet. Will look more tomorrow.
> > But below is the kernel module code and it prints a FAIL message to kernel
> > logs in a few seconds.
> > 
> > I see the reader thread not getting CPU for several seconds. RCU_BOOST_DELAY
> > is set to 500.
> > 
> > Thoughts?
> 
> So this could be because I did not start a grace period which is quite silly.
> I am sorry about that. I will add another thread to start grace periods as
> well and let you know if I still see a problem.

In addition, the RCU_READER_DELAY isn't long enough to trigger RCU priority
boosting.  And RCU_BLOCKER_DELAY would be, except that I am not seeing
an RCU read-side critical section surrounding it.

But rcutorture already has tests for RCU priority boosting.  Or are those
failing in some way?

Either way, it is good to see interest in RCU priority boosting.  ;-)

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 
> > ---8<-----------------------
> > 
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index c1860d35dc7e..ba34957dff26 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -2,7 +2,7 @@
> >  #
> >  # Makefile for misc devices that really don't fit anywhere else.
> >  #
> > -
> > +obj-m += ptest.o
> >  obj-$(CONFIG_IBM_ASM)		+= ibmasm/
> >  obj-$(CONFIG_IBMVMC)		+= ibmvmc.o
> >  obj-$(CONFIG_AD525X_DPOT)	+= ad525x_dpot.o
> > diff --git a/drivers/misc/ptest.c b/drivers/misc/ptest.c
> > new file mode 100644
> > index 000000000000..76cc9524ccac
> > --- /dev/null
> > +++ b/drivers/misc/ptest.c
> > @@ -0,0 +1,112 @@
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/kthread.h>
> > +#include <linux/delay.h>
> > +
> > +#define RCU_READER_DELAY 100 //ms
> > +#define RCU_BLOCKER_DELAY 600 //ms
> > +
> > +MODULE_LICENSE("GPL");
> > +
> > +struct sched_param {
> > +	int sched_priority;
> > +};
> > +
> > +int stop_test = 0;
> > +int test_pass = 1;
> > +int reader_exit = 0;
> > +s64 delta_fail;
> > +
> > +#define ns_to_ms(delta) (delta / 1000000ULL)
> > +
> > +static int rcu_reader(void *a)
> > +{
> > +	ktime_t start, end, reader_begin;
> > +	s64 delta;
> > +
> > +	reader_begin = ktime_get();
> > +
> > +	while (!kthread_should_stop() && !stop_test) {
> > +		start = ktime_get();
> > +		rcu_read_lock();
> > +		trace_printk("rcu_reader entering RSCS\n");
> > +		mdelay(RCU_READER_DELAY);
> > +		trace_printk("rcu_reader exiting RSCS\n");
> > +		rcu_read_lock();
> > +		end = ktime_get();
> > +		delta = ktime_to_ns(ktime_sub(end, start));
> > +
> > +		if (delta < 0 || (ns_to_ms(delta) > (2 * RCU_READER_DELAY))) {
> > +			delta_fail = delta;
> > +			test_pass = 0;
> > +			break;
> > +		}
> > +
> > +		// Don't let the rcu_reader() run more than 3s inorder to
> > +		// not starve the blocker incase reader prio > blocker prio.
> > +		delta = ktime_to_ns(ktime_sub(end, reader_begin));
> > +		if (ns_to_ms(delta) > 3000)
> > +			break;
> > +	}
> > +
> > +	stop_test = 1;
> > +	reader_exit = 1;
> > +	pr_err("Exiting reader\n");
> > +	return 0;
> > +}
> > +
> > +static int rcu_blocker(void *a)
> > +{
> > +	int loops = 5;
> > +
> > +	while (!kthread_should_stop() && loops-- && !stop_test) {
> > +		trace_printk("rcu_blocker entering\n");
> > +		mdelay(RCU_BLOCKER_DELAY);
> > +		trace_printk("rcu_blocker exiting\n");
> > +	}
> > +
> > +	pr_err("Exiting blocker\n");
> > +	stop_test = 1;
> > +
> > +	// Wait for reader to finish
> > +	while (!reader_exit)
> > +		schedule_timeout_uninterruptible(1);
> > +
> > +	if (test_pass)
> > +		pr_err("TEST PASSED\n");
> > +	else
> > +		pr_err("TEST FAILED, failing delta=%lldms\n", ns_to_ms(delta_fail));
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init ptest_init(void){
> > +	struct sched_param params;
> > +	struct task_struct *reader, *blocker;
> > +
> > +	reader = kthread_create(rcu_reader, NULL, "reader");
> > +	params.sched_priority = 50;
> > +	sched_setscheduler(reader, SCHED_FIFO, &params);
> > +	kthread_bind(reader, smp_processor_id());
> > +
> > +	blocker = kthread_create(cu_blocker, NULL, "blocker");
> > +	params.sched_priority = 60;
> > +	sched_setscheduler(blocker, SCHED_FIFO, &params);
> > +	kthread_bind(blocker, smp_processor_id());
> > +
> > +	wake_up_process(reader);
> > +
> > +	// Let reader run a little
> > +	mdelay(50);
> > +
> > +	wake_up_process(blocker);
> > +	return 0;
> > +}
> > +
> > +static void __exit ptest_exit(void){
> > +}
> > +
> > +module_init(ptest_init);
> > +module_exit(ptest_exit);
> > -- 
> > 2.25.0.341.g760bfbb309-goog
> > 
