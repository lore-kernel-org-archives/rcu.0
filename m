Return-Path: <SRS0=sWdW=3E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714F9C32771
	for <rcu@archiver.kernel.org>; Wed, 15 Jan 2020 22:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A6522522
	for <rcu@archiver.kernel.org>; Wed, 15 Jan 2020 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579128173;
	bh=OpKt8/pfHILR+EuTGuw/jy37NDHG/7N76p1ncVe51RA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dHgdFYEutvoi7yzk/O0JhtmfODfKDioZVYm8rzAPTsqzeY1hJzvI0ZZhSsGokTmtY
	 c+6pSAIZueYT2t8qLNUejtwJm+yqVM2vSKbX2UGeyQHnLZyuRao9/qQiQTuhy9hWjH
	 uf0luT0pZRiNRBXm34oxmOO4atY/xUQYoU+FNE+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgAOWmx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729442AbgAOWmw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jan 2020 17:42:52 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02C5E2081E;
        Wed, 15 Jan 2020 22:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579128172;
        bh=OpKt8/pfHILR+EuTGuw/jy37NDHG/7N76p1ncVe51RA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c2KCEjSeVGyFmY90JfckWI0xiJlo85ZoqCu40BjvIDXbYE5PR8D0LoDEi2CxmHy31
         yGI8kH/g+EJzgOZCeLSgmFC2vpXoBZ/fKK/f268vaOGhL37QPiTwFYXpc8JqU72qk2
         EHo/n7naPvNlSzrUsdfiwsVr1beHkk12cRevAwO0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A129C352274D; Wed, 15 Jan 2020 14:42:51 -0800 (PST)
Date:   Wed, 15 Jan 2020 14:42:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        frextrite@gmail.com, madhuparnabhowmik04@gmail.com,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 rcu-dev] rcuperf: Measure memory footprint during
 kfree_rcu() test
Message-ID: <20200115224251.GK2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191219211349.235877-1-joel@joelfernandes.org>
 <20191221000729.GH2889@paulmck-ThinkPad-P72>
 <20191221033714.GB156579@google.com>
 <20200106195200.GS13449@paulmck-ThinkPad-P72>
 <20200115220300.GA94036@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115220300.GA94036@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 15, 2020 at 05:03:00PM -0500, Joel Fernandes wrote:
> On Mon, Jan 06, 2020 at 11:52:00AM -0800, Paul E. McKenney wrote:
> > On Fri, Dec 20, 2019 at 10:37:14PM -0500, Joel Fernandes wrote:
> > > On Fri, Dec 20, 2019 at 04:07:29PM -0800, Paul E. McKenney wrote:
> > > > On Thu, Dec 19, 2019 at 04:13:49PM -0500, Joel Fernandes (Google) wrote:
> > > > > During changes to kfree_rcu() code, we often check the amount of free
> > > > > memory.  As an alternative to checking this manually, this commit adds a
> > > > > measurement in the test itself.  It measures four times during the test
> > > > > for available memory, digitally filters these measurements to produce a
> > > > > running average with a weight of 0.5, and compares this digitally
> > > > > filtered value with the amount of available memory at the beginning of
> > > > > the test.
> > > > > 
> > > > > We apply the digital filter only once we are more than 25% into the
> > > > > test. At the 25% mark, we just read available memory and don't apply any
> > > > > filtering. This prevents the first sample from skewing the results
> > > > > as we would not consider memory readings that were before memory was
> > > > > allocated.
> > > > > 
> > > > > A sample run shows something like:
> > > > > 
> > > > > Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB
> > > > > 
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > 
> > > > Much better!  A few comments below.
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > > ---
> > > > > v1->v2: Minor corrections
> > > > > v1->v3: Use long long to prevent 32-bit system's overflow
> > > > > 	Handle case where some threads start later than others.
> > > > > 	Start measuring only once 25% into the test. Slightly more accurate.
> > > > > 
> > > > > Cc: bristot@redhat.com
> > > > > Cc: frextrite@gmail.com
> > > > > Cc: madhuparnabhowmik04@gmail.com
> > > > > Cc: urezki@gmail.com
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > 
> > > > >  kernel/rcu/rcuperf.c | 23 +++++++++++++++++++++--
> > > > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > > > > index da94b89cd531..67e0f804ea97 100644
> > > > > --- a/kernel/rcu/rcuperf.c
> > > > > +++ b/kernel/rcu/rcuperf.c
> > > > > @@ -12,6 +12,7 @@
> > > > >  #include <linux/types.h>
> > > > >  #include <linux/kernel.h>
> > > > >  #include <linux/init.h>
> > > > > +#include <linux/mm.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/kthread.h>
> > > > >  #include <linux/err.h>
> > > > > @@ -604,6 +605,8 @@ struct kfree_obj {
> > > > >  	struct rcu_head rh;
> > > > >  };
> > > > >  
> > > > > +long long mem_begin;
> > > > > +
> > > > >  static int
> > > > >  kfree_perf_thread(void *arg)
> > > > >  {
> > > > > @@ -611,6 +614,7 @@ kfree_perf_thread(void *arg)
> > > > >  	long me = (long)arg;
> > > > >  	struct kfree_obj *alloc_ptr;
> > > > >  	u64 start_time, end_time;
> > > > > +	long long mem_during = si_mem_available();
> > > > 
> > > > You initialize here, which makes quite a bit of sense...
> > > > 
> > > > >  	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
> > > > >  	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> > > > > @@ -626,6 +630,15 @@ kfree_perf_thread(void *arg)
> > > > >  	}
> > > > >  
> > > > >  	do {
> > > > > +		// Moving average of memory availability measurements.
> > > > > +		// Start measuring only from when we are at least 25% into the test.
> > > > > +		if (loop && kfree_loops > 3 && (loop % (kfree_loops / 4) == 0)) {
> > > > > +			if (loop == (kfree_loops / 4))
> > > > > +				mem_during = si_mem_available();
> > > > 
> > > > But then you reinitialize here.  Perhaps to avoid the compiler being
> > > > confused into complaining about uninitialized variables?  (But if so,
> > > > please comment it.)
> > > 
> > > It is reinitialized here like that, because if kfree_loops is < 4, then
> > > mem_during needs to hold some value to avoid the (mem_begin - mem_during) to
> > > falsely appear quite large. That's why I initialized it in the beginning. If
> > > kfree_loops is >= 4, then yes it will be initialized twice but that's Ok.
> > > 
> > > I can add a comment to the earlier initialization if you like.
> > 
> > Could we just force kfree_loops >= 4?  Complain if not, set it to 4?
> 
> Sure.
> 
> > > > The thing is that by the fourth measurement, the initial influence has
> > > > been diluted by a factor of something like 16 or 32, correct?  I don't
> > > > believe that your measurements are any more accurate than that, given the
> > > > bursty nature of the RCU reclamation process.  So why not just initialize
> > > > it and average it at each sample point?
> > > 
> > > Yes but diluting 200MB of delta by 16 is still high and causes a skew.
> > 
> > You get similar errors by only sampling four times, though.  Assuming a
> > reasonably long test run compared to the typical grace-period duration,
> > each of the four samples has a 50% chance of being above the median,
> > thus a 1/16 chance of all four samples being above the median.
> 
> [snip]
> > > We can certainly refine it further but at this time I am thinking of spending
> > > my time reviewing Lai's patches and learning some other RCU things I need to
> > > catch up on. If you hate this patch too much, we can also defer this patch
> > > review for a bit and I can carry it in my tree for now as it is only a patch
> > > to test code. But honestly, in its current form I am sort of happy with it.
> > 
> > OK, I will keep it as is for now and let's look again later on.  It is not
> > in the bucket for the upcoming merge window in any case, so we do have
> > quite a bit of time.
> > 
> > It is not that I hate it, but rather that I want to be able to give
> > good answers to questions that might come up.  And given that I have
> > occasionally given certain people a hard time about their statistics,
> > it is only reasonable to expect them to return the favor.  I wouldn't
> > want you to be caught in the crossfire.  ;-)
> 
> Since the weights were concerning, I was thinking of just using a weight of
> (1 / N) where N is the number of samples. Essentially taking the average.
> That could be simple enough and does not cause your concerns with weight
> tuning. I tested it and looks good, I'll post it shortly.

YES!!!  ;-)

Snapshot mem_begin before entering the loop.  For the mean value to
be solid, you need at least 20-30 samples, which might mean upping the
default for kfree_loops.  Have an "unsigned long long" to accumulate the
sum, which should avoid any possibility of overflow for current systems
and for all systems for kfree_loops less than PAGE_SIZE.  At which point,
forget the "%" stuff and just sum up the si_mem_available() on each pass
through the loop.

Do the division on exit from the loop, preferably checking for divide
by zero.

Straightforward, fast, reasonably reliable, and easy to defend.

							Thanx, Paul
