Return-Path: <SRS0=sWdW=3E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D02C32771
	for <rcu@archiver.kernel.org>; Wed, 15 Jan 2020 22:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FB72465A
	for <rcu@archiver.kernel.org>; Wed, 15 Jan 2020 22:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IgvOoCwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgAOWDD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:03:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38656 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAOWDC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jan 2020 17:03:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id f20so7405278plj.5
        for <rcu@vger.kernel.org>; Wed, 15 Jan 2020 14:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OfUmHA2N2gB3jiyi66P8DQbMcvSOXxfX/GVnmb4/r5U=;
        b=IgvOoCwjGvKgofX3iIWSL/R9UT7n9CE7t86ajwFilcui77qeOGzxTOZTYerBikWHIG
         2Bh+Z9DaI7jIDvoTnhJs94pfXuJmYWGjvo0FOrVp6cVSg+TBnWKlzniXhCf3ZHCVnVml
         A9vgtACoeO7zeYE7A+SYF7rYISsdweis0cYwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OfUmHA2N2gB3jiyi66P8DQbMcvSOXxfX/GVnmb4/r5U=;
        b=JxXP7UTFCtCIclO72aQoqrtehCsaC2ZkXVB501jMDgBKc9CSLNAEfFgDdB45vGZXdD
         lJWJ8Og1i0Sr++/k67rxvxX33bDpP0QZt7nxlm95twm7mmpxreBsRwblFcV1z6DE8ObY
         EZeTjVU5oYufjwBczDOXRyDl5tiFeOGQjFAN7/UxMD7lWQ1GniI7eJW2Woy1rGioLHQM
         GXZYh/pApE1PLcyT7rvmHHhHIdTlSIPsg7XQsdhVGbge5648SM41bQQ8ojAVT6CtlR4C
         nfuIJ8LcuWWzeCSJHzSD2mVE1xC1C8bfDQ+pvMkGrWq2onXkaSY8PdP+wN1ceuaoMyFx
         bOiw==
X-Gm-Message-State: APjAAAWiaemhMJfLmbmijXKzJm6lZHcpQS/UKJ185p0ONdKMV+r4lkN3
        RmiBUKPTQ96rHU+d/nYSKxRgYw==
X-Google-Smtp-Source: APXvYqxKBa7xQEOkNvOUAe9QKP6M9HSsck19nD7h+zPTmAvSMgipTP5T9rx3u3ddRoSE+DB4vGm8gg==
X-Received: by 2002:a17:90a:c389:: with SMTP id h9mr2692806pjt.128.1579125782088;
        Wed, 15 Jan 2020 14:03:02 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i11sm818878pjg.0.2020.01.15.14.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:03:01 -0800 (PST)
Date:   Wed, 15 Jan 2020 17:03:00 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        frextrite@gmail.com, madhuparnabhowmik04@gmail.com,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 rcu-dev] rcuperf: Measure memory footprint during
 kfree_rcu() test
Message-ID: <20200115220300.GA94036@google.com>
References: <20191219211349.235877-1-joel@joelfernandes.org>
 <20191221000729.GH2889@paulmck-ThinkPad-P72>
 <20191221033714.GB156579@google.com>
 <20200106195200.GS13449@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106195200.GS13449@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 06, 2020 at 11:52:00AM -0800, Paul E. McKenney wrote:
> On Fri, Dec 20, 2019 at 10:37:14PM -0500, Joel Fernandes wrote:
> > On Fri, Dec 20, 2019 at 04:07:29PM -0800, Paul E. McKenney wrote:
> > > On Thu, Dec 19, 2019 at 04:13:49PM -0500, Joel Fernandes (Google) wrote:
> > > > During changes to kfree_rcu() code, we often check the amount of free
> > > > memory.  As an alternative to checking this manually, this commit adds a
> > > > measurement in the test itself.  It measures four times during the test
> > > > for available memory, digitally filters these measurements to produce a
> > > > running average with a weight of 0.5, and compares this digitally
> > > > filtered value with the amount of available memory at the beginning of
> > > > the test.
> > > > 
> > > > We apply the digital filter only once we are more than 25% into the
> > > > test. At the 25% mark, we just read available memory and don't apply any
> > > > filtering. This prevents the first sample from skewing the results
> > > > as we would not consider memory readings that were before memory was
> > > > allocated.
> > > > 
> > > > A sample run shows something like:
> > > > 
> > > > Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > Much better!  A few comments below.
> > > 
> > > 							Thanx, Paul
> > > 
> > > > ---
> > > > v1->v2: Minor corrections
> > > > v1->v3: Use long long to prevent 32-bit system's overflow
> > > > 	Handle case where some threads start later than others.
> > > > 	Start measuring only once 25% into the test. Slightly more accurate.
> > > > 
> > > > Cc: bristot@redhat.com
> > > > Cc: frextrite@gmail.com
> > > > Cc: madhuparnabhowmik04@gmail.com
> > > > Cc: urezki@gmail.com
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > 
> > > >  kernel/rcu/rcuperf.c | 23 +++++++++++++++++++++--
> > > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > > > index da94b89cd531..67e0f804ea97 100644
> > > > --- a/kernel/rcu/rcuperf.c
> > > > +++ b/kernel/rcu/rcuperf.c
> > > > @@ -12,6 +12,7 @@
> > > >  #include <linux/types.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/init.h>
> > > > +#include <linux/mm.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/kthread.h>
> > > >  #include <linux/err.h>
> > > > @@ -604,6 +605,8 @@ struct kfree_obj {
> > > >  	struct rcu_head rh;
> > > >  };
> > > >  
> > > > +long long mem_begin;
> > > > +
> > > >  static int
> > > >  kfree_perf_thread(void *arg)
> > > >  {
> > > > @@ -611,6 +614,7 @@ kfree_perf_thread(void *arg)
> > > >  	long me = (long)arg;
> > > >  	struct kfree_obj *alloc_ptr;
> > > >  	u64 start_time, end_time;
> > > > +	long long mem_during = si_mem_available();
> > > 
> > > You initialize here, which makes quite a bit of sense...
> > > 
> > > >  	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> > > >  	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> > > > @@ -626,6 +630,15 @@ kfree_perf_thread(void *arg)
> > > >  	}
> > > >  
> > > >  	do {
> > > > +		// Moving average of memory availability measurements.
> > > > +		// Start measuring only from when we are at least 25% into the test.
> > > > +		if (loop && kfree_loops > 3 && (loop % (kfree_loops / 4) == 0)) {
> > > > +			if (loop == (kfree_loops / 4))
> > > > +				mem_during = si_mem_available();
> > > 
> > > But then you reinitialize here.  Perhaps to avoid the compiler being
> > > confused into complaining about uninitialized variables?  (But if so,
> > > please comment it.)
> > 
> > It is reinitialized here like that, because if kfree_loops is < 4, then
> > mem_during needs to hold some value to avoid the (mem_begin - mem_during) to
> > falsely appear quite large. That's why I initialized it in the beginning. If
> > kfree_loops is >= 4, then yes it will be initialized twice but that's Ok.
> > 
> > I can add a comment to the earlier initialization if you like.
> 
> Could we just force kfree_loops >= 4?  Complain if not, set it to 4?

Sure.

> > > The thing is that by the fourth measurement, the initial influence has
> > > been diluted by a factor of something like 16 or 32, correct?  I don't
> > > believe that your measurements are any more accurate than that, given the
> > > bursty nature of the RCU reclamation process.  So why not just initialize
> > > it and average it at each sample point?
> > 
> > Yes but diluting 200MB of delta by 16 is still high and causes a skew.
> 
> You get similar errors by only sampling four times, though.  Assuming a
> reasonably long test run compared to the typical grace-period duration,
> each of the four samples has a 50% chance of being above the median,
> thus a 1/16 chance of all four samples being above the median.

[snip]
> > We can certainly refine it further but at this time I am thinking of spending
> > my time reviewing Lai's patches and learning some other RCU things I need to
> > catch up on. If you hate this patch too much, we can also defer this patch
> > review for a bit and I can carry it in my tree for now as it is only a patch
> > to test code. But honestly, in its current form I am sort of happy with it.
> 
> OK, I will keep it as is for now and let's look again later on.  It is not
> in the bucket for the upcoming merge window in any case, so we do have
> quite a bit of time.
> 
> It is not that I hate it, but rather that I want to be able to give
> good answers to questions that might come up.  And given that I have
> occasionally given certain people a hard time about their statistics,
> it is only reasonable to expect them to return the favor.  I wouldn't
> want you to be caught in the crossfire.  ;-)

Since the weights were concerning, I was thinking of just using a weight of
(1 / N) where N is the number of samples. Essentially taking the average.
That could be simple enough and does not cause your concerns with weight
tuning. I tested it and looks good, I'll post it shortly.

thanks,

 - Joel

