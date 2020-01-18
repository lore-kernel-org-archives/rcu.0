Return-Path: <SRS0=UQpt=3H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9E8C33C9E
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 02:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF582176D
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 02:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Y8pq/MAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgARCKw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Jan 2020 21:10:52 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56121 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgARCKv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Jan 2020 21:10:51 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so3940812pjz.5
        for <rcu@vger.kernel.org>; Fri, 17 Jan 2020 18:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A3mJoEZ75E34Z/+ZBS4uMt/mW6saGjkBnPzIGjYHbdI=;
        b=Y8pq/MAZi3ID1KLSarOWFHPAZk6qAPdCsbPYgIxcm7I2V1Oexecf/6ZWg7Tl/cnndB
         wnKswxtBoT+NQV9dFGI+LIXRcHCRr3/S19Yf47EiNLduIp7KBxcM0FSVW05FXGDvPMWL
         Tivh7kTYKzloTVn86LOPbN3/zVRCwZxqJF8B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A3mJoEZ75E34Z/+ZBS4uMt/mW6saGjkBnPzIGjYHbdI=;
        b=qwFrfrmWlL4jWSCXqwRXtfQXeyzxvDVZ017FjQB2iemmuai4rW00CLVswM8QJ/DwF1
         udf8GmpSxa0WRhhppxBqmu5SqCVllCIB5MTjqENZFnC/xSvhUJ0vYB1VVvla+US2bF5f
         g7kmBKfvdwJwMsM9si/6VOurIcWKohe0eTsIT+s3vywetR6pm0KPaxQcV6YxLB3J42fO
         tOnpHETUsiVdf55Dme0gTCSffW07hzn3MJgJiv8Izj9y5VL+69MpxkuP0O6cKLCYAk6M
         hRMQ8GKtdPOEQm1qLTY9XmfA4waNUJwSD8y2u1uThWpDOyeIXWOkk8SfWUNuP+nfEuYD
         mzDg==
X-Gm-Message-State: APjAAAWJa9k2RJ6p+q1+LNUJGAUobiDmFeusZW7nFLrNRxJhrrFuVVV/
        m9dzXgbSHkPtbCV15eaDS8FVKw==
X-Google-Smtp-Source: APXvYqxAvaDjaEhjPJV1zlaL84d/KEjvnfNBF3JKtTRWVLAA6J1224Op3hGZKcWJAWNLw9ZN17/IHQ==
X-Received: by 2002:a17:90b:46c4:: with SMTP id jx4mr9568922pjb.32.1579313451052;
        Fri, 17 Jan 2020 18:10:51 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m22sm31022284pgn.8.2020.01.17.18.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 18:10:50 -0800 (PST)
Date:   Fri, 17 Jan 2020 21:10:49 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rostedt@goodmis.org, bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200118021049.GC211665@google.com>
References: <20200117215814.GB206250@google.com>
 <20200117221804.GA211665@google.com>
 <20200117231756.GO2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117231756.GO2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 17, 2020 at 03:17:56PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 17, 2020 at 05:18:04PM -0500, Joel Fernandes wrote:
> > On Fri, Jan 17, 2020 at 04:58:14PM -0500, Joel Fernandes wrote:
> > > Hi,
> > > Me and Daniel were poking around with RCU_BOOST. I wrote a kernel module to
> > > test it a bit and I don't see the boost happening (thanks to Daniel for idea
> > > of writing a module). Haven't debugged it more yet. Will look more tomorrow.
> > > But below is the kernel module code and it prints a FAIL message to kernel
> > > logs in a few seconds.
> > > 
> > > I see the reader thread not getting CPU for several seconds. RCU_BOOST_DELAY
> > > is set to 500.
> > > 
> > > Thoughts?
> > 
> > So this could be because I did not start a grace period which is quite silly.
> > I am sorry about that. I will add another thread to start grace periods as
> > well and let you know if I still see a problem.
> 
> In addition, the RCU_READER_DELAY isn't long enough to trigger RCU priority
> boosting.  And RCU_BLOCKER_DELAY would be, except that I am not seeing
> an RCU read-side critical section surrounding it.

I was assuming that only the thread being preempted needs an RCU read-side
critical section. That preempted section would inherit the priority of the
thread preempting it (the blocking thread). So the blocking thread would not
need a read-side critical section, it just would need to be higher priority
than the thread it is preempting and preempt it long enough to trigger the
boosting.

Did I miss something?

> 
> But rcutorture already has tests for RCU priority boosting.  Or are those
> failing in some way?
> 
> Either way, it is good to see interest in RCU priority boosting.  ;-)

The interest is purely academic and curiousity-driven at this point ;-).
Speaking of which why is the config not default-enabled and would it not be a
good thing to enable everywhere or there some who dislike it?

Another thought is for RCU_BOOST systems to reduce the threshold of
triggering boost dynamically if the system is at the risk of running out of
memory.

thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > > 
> > > ---8<-----------------------
> > > 
> > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > > index c1860d35dc7e..ba34957dff26 100644
> > > --- a/drivers/misc/Makefile
> > > +++ b/drivers/misc/Makefile
> > > @@ -2,7 +2,7 @@
> > >  #
> > >  # Makefile for misc devices that really don't fit anywhere else.
> > >  #
> > > -
> > > +obj-m += ptest.o
> > >  obj-$(CONFIG_IBM_ASM)		+= ibmasm/
> > >  obj-$(CONFIG_IBMVMC)		+= ibmvmc.o
> > >  obj-$(CONFIG_AD525X_DPOT)	+= ad525x_dpot.o
> > > diff --git a/drivers/misc/ptest.c b/drivers/misc/ptest.c
> > > new file mode 100644
> > > index 000000000000..76cc9524ccac
> > > --- /dev/null
> > > +++ b/drivers/misc/ptest.c
> > > @@ -0,0 +1,112 @@
> > > +#include <linux/init.h>
> > > +#include <linux/module.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/vmalloc.h>
> > > +#include <linux/kthread.h>
> > > +#include <linux/delay.h>
> > > +
> > > +#define RCU_READER_DELAY 100 //ms
> > > +#define RCU_BLOCKER_DELAY 600 //ms
> > > +
> > > +MODULE_LICENSE("GPL");
> > > +
> > > +struct sched_param {
> > > +	int sched_priority;
> > > +};
> > > +
> > > +int stop_test = 0;
> > > +int test_pass = 1;
> > > +int reader_exit = 0;
> > > +s64 delta_fail;
> > > +
> > > +#define ns_to_ms(delta) (delta / 1000000ULL)
> > > +
> > > +static int rcu_reader(void *a)
> > > +{
> > > +	ktime_t start, end, reader_begin;
> > > +	s64 delta;
> > > +
> > > +	reader_begin = ktime_get();
> > > +
> > > +	while (!kthread_should_stop() && !stop_test) {
> > > +		start = ktime_get();
> > > +		rcu_read_lock();
> > > +		trace_printk("rcu_reader entering RSCS\n");
> > > +		mdelay(RCU_READER_DELAY);
> > > +		trace_printk("rcu_reader exiting RSCS\n");
> > > +		rcu_read_lock();
> > > +		end = ktime_get();
> > > +		delta = ktime_to_ns(ktime_sub(end, start));
> > > +
> > > +		if (delta < 0 || (ns_to_ms(delta) > (2 * RCU_READER_DELAY))) {
> > > +			delta_fail = delta;
> > > +			test_pass = 0;
> > > +			break;
> > > +		}
> > > +
> > > +		// Don't let the rcu_reader() run more than 3s inorder to
> > > +		// not starve the blocker incase reader prio > blocker prio.
> > > +		delta = ktime_to_ns(ktime_sub(end, reader_begin));
> > > +		if (ns_to_ms(delta) > 3000)
> > > +			break;
> > > +	}
> > > +
> > > +	stop_test = 1;
> > > +	reader_exit = 1;
> > > +	pr_err("Exiting reader\n");
> > > +	return 0;
> > > +}
> > > +
> > > +static int rcu_blocker(void *a)
> > > +{
> > > +	int loops = 5;
> > > +
> > > +	while (!kthread_should_stop() && loops-- && !stop_test) {
> > > +		trace_printk("rcu_blocker entering\n");
> > > +		mdelay(RCU_BLOCKER_DELAY);
> > > +		trace_printk("rcu_blocker exiting\n");
> > > +	}
> > > +
> > > +	pr_err("Exiting blocker\n");
> > > +	stop_test = 1;
> > > +
> > > +	// Wait for reader to finish
> > > +	while (!reader_exit)
> > > +		schedule_timeout_uninterruptible(1);
> > > +
> > > +	if (test_pass)
> > > +		pr_err("TEST PASSED\n");
> > > +	else
> > > +		pr_err("TEST FAILED, failing delta=%lldms\n", ns_to_ms(delta_fail));
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __init ptest_init(void){
> > > +	struct sched_param params;
> > > +	struct task_struct *reader, *blocker;
> > > +
> > > +	reader = kthread_create(rcu_reader, NULL, "reader");
> > > +	params.sched_priority = 50;
> > > +	sched_setscheduler(reader, SCHED_FIFO, &params);
> > > +	kthread_bind(reader, smp_processor_id());
> > > +
> > > +	blocker = kthread_create(cu_blocker, NULL, "blocker");
> > > +	params.sched_priority = 60;
> > > +	sched_setscheduler(blocker, SCHED_FIFO, &params);
> > > +	kthread_bind(blocker, smp_processor_id());
> > > +
> > > +	wake_up_process(reader);
> > > +
> > > +	// Let reader run a little
> > > +	mdelay(50);
> > > +
> > > +	wake_up_process(blocker);
> > > +	return 0;
> > > +}
> > > +
> > > +static void __exit ptest_exit(void){
> > > +}
> > > +
> > > +module_init(ptest_init);
> > > +module_exit(ptest_exit);
> > > -- 
> > > 2.25.0.341.g760bfbb309-goog
> > > 
