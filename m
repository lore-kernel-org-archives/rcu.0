Return-Path: <SRS0=lUfD=3G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F71C33C9E
	for <rcu@archiver.kernel.org>; Fri, 17 Jan 2020 22:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1191D21D56
	for <rcu@archiver.kernel.org>; Fri, 17 Jan 2020 22:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LfRx5pvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgAQWSI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:18:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33587 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgAQWSI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Jan 2020 17:18:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id z16so12576050pfk.0
        for <rcu@vger.kernel.org>; Fri, 17 Jan 2020 14:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=apkoNmNueEmlW6DbknDEwDUk7paJjuboBqdPKRt5uKE=;
        b=LfRx5pvZwjleMwhu3r9sLni1dQV3OOv7jBLLHK9p5Wr5Bq3oeGJF7dfy13mJVVshc/
         HtouQj9zyrAiSNGFoiql1YGNnUGKrV3j2B47NoGGv1HBdVWtMD+Gj9v9AttyIQI/JOWn
         vO34laggYffBHcbzOpDj0PBkKLr+LvAsYChgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=apkoNmNueEmlW6DbknDEwDUk7paJjuboBqdPKRt5uKE=;
        b=n/hvsMLniYEwkUi2Q3/Bs2QSLykxG5IJx/CW7Q4uyD0r6oXGqnJ4dFEHtF4JkcxuPH
         2zDTrirwGKW/EYJSNgwHypvQdf3Ab5ikmWx0qZgZ6hjGKbYEi1MA5C0CMYuzMyNVxbZC
         CLpz0X0ebDI9aKWBFv01uH+Q0d1XVNS6+gdZCEQJN84ExrKQ5LD6RqX1lPJ4r3UGXiGc
         IBMBlclzWivvs81xzMd7bRDLEOaBOYd0z9SOo0E7WBkIopDZSyx7nU8MRElhaqfNSB1v
         ynsePlro1RxYxpr5vgaen24MjisFl/x7gCdWCe6hAhGQijJti6kOjEwd9nTNxYclNbGb
         gnQw==
X-Gm-Message-State: APjAAAWWBjU13iPmcwXf4kKb6jS2Dt6abME/2pP5XpwnptLKDjP3TxUM
        PTzrvCh2BcQr915WgQOBIK94t63hxGY=
X-Google-Smtp-Source: APXvYqwIjHrNnIGY3KFBFxkV7T/YNv6TdLCbXtRxh6q0QTTX0ss8FQUFJbKXpqlXKe1AeD2SO1wybw==
X-Received: by 2002:a62:158c:: with SMTP id 134mr5078321pfv.81.1579299486267;
        Fri, 17 Jan 2020 14:18:06 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m19sm7434662pjv.10.2020.01.17.14.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 14:18:05 -0800 (PST)
Date:   Fri, 17 Jan 2020 17:18:04 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org, paulmck@kernel.org, rostedt@goodmis.org,
        bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200117221804.GA211665@google.com>
References: <20200117215814.GB206250@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117215814.GB206250@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 17, 2020 at 04:58:14PM -0500, Joel Fernandes wrote:
> Hi,
> Me and Daniel were poking around with RCU_BOOST. I wrote a kernel module to
> test it a bit and I don't see the boost happening (thanks to Daniel for idea
> of writing a module). Haven't debugged it more yet. Will look more tomorrow.
> But below is the kernel module code and it prints a FAIL message to kernel
> logs in a few seconds.
> 
> I see the reader thread not getting CPU for several seconds. RCU_BOOST_DELAY
> is set to 500.
> 
> Thoughts?

So this could be because I did not start a grace period which is quite silly.
I am sorry about that. I will add another thread to start grace periods as
well and let you know if I still see a problem.

thanks,

 - Joel


> 
> ---8<-----------------------
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
> index 000000000000..76cc9524ccac
> --- /dev/null
> +++ b/drivers/misc/ptest.c
> @@ -0,0 +1,112 @@
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/vmalloc.h>
> +#include <linux/kthread.h>
> +#include <linux/delay.h>
> +
> +#define RCU_READER_DELAY 100 //ms
> +#define RCU_BLOCKER_DELAY 600 //ms
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
> +static int rcu_reader(void *a)
> +{
> +	ktime_t start, end, reader_begin;
> +	s64 delta;
> +
> +	reader_begin = ktime_get();
> +
> +	while (!kthread_should_stop() && !stop_test) {
> +		start = ktime_get();
> +		rcu_read_lock();
> +		trace_printk("rcu_reader entering RSCS\n");
> +		mdelay(RCU_READER_DELAY);
> +		trace_printk("rcu_reader exiting RSCS\n");
> +		rcu_read_lock();
> +		end = ktime_get();
> +		delta = ktime_to_ns(ktime_sub(end, start));
> +
> +		if (delta < 0 || (ns_to_ms(delta) > (2 * RCU_READER_DELAY))) {
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
> +	struct task_struct *reader, *blocker;
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
> +	wake_up_process(reader);
> +
> +	// Let reader run a little
> +	mdelay(50);
> +
> +	wake_up_process(blocker);
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
