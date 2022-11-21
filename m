Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFE7C433FE
	for <rcu@archiver.kernel.org>; Mon, 21 Nov 2022 02:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiKUCjU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 20 Nov 2022 21:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKUCjU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 20 Nov 2022 21:39:20 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C577DD111
        for <rcu@vger.kernel.org>; Sun, 20 Nov 2022 18:39:18 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id b29so10070309pfp.13
        for <rcu@vger.kernel.org>; Sun, 20 Nov 2022 18:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1olZ2jV7XPHjV735Xu/YRwyQQrW0XAh7XAfa6bKadSs=;
        b=CJvUEuM/7oKgevRusRq1A1oHijcZCdFzDN2GnBuBUBU919wLv0P4vjR2FltjIZLZQf
         vl20U9RfaVIecTPi2Dl4XT9TYuEGWVzylUIuMEUS3ohuQ+f3t4Oscfg8yCumOjNZ3WKv
         2QNhwhJSJ7TK8DSZ+WWJhGjMvHQKSVoca/Mp43F57lBgncXGOJ29gL0KvpJZsapkG8XU
         YejyIzhdQegOgG+XA+xQvNbbUogH/PDlEC5guRwdUAzHSWJN9QvDN0L6Kz1HoiV3k+bx
         kTdZvYECnQm8InIXOkwO92bh3C+ctw4NQH5F5vQ7jGRISeXwhH0oKGZMCz7hRtZshcaJ
         KIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1olZ2jV7XPHjV735Xu/YRwyQQrW0XAh7XAfa6bKadSs=;
        b=qwn/F19xDZvqb5R/mo2rRTMucSbtflHYRPwzrqYMylrO0l4FBLrwHC6YxbqOSBij1s
         hiQ/dIAbdCiNekhcew3ZuRYB8S50jQ+vsoIoZ9iP95Kb5mRc+USvJgtGKruIJ0OJ78pD
         wXwwkTWpI+cNXbLKo5M30VLXs6pLRK276In78UvOVhkdR0Hoi2gW/U0M3x/OPThpNDRG
         6zRx9cELcMq8nYXKKZLXb4kBNtBNrf8qrfdBI2Uq8B3KmARxcyeTT7Vu7M7nBSfpJuqR
         3tr6tPQx0IOvTpHy5Vcj47u2ekdoT/NNWk0qjRS158wFcRshzB1gs40+bI8paqG70k3y
         Z4NQ==
X-Gm-Message-State: ANoB5pn6QfXqROMlFabMkd3rI/vCsgxtyYhRsHbiq4pmWHYv5mHx0Lie
        bQt3bder3P5rjJ+Ux99z0Q==
X-Google-Smtp-Source: AA0mqf5wuS5a63ealYAFNo2F6AvOxfZuQ0Et1GF8ylKuut0r/sHF1i8Wg+1c4i/6OuzVgS15HI8IUw==
X-Received: by 2002:a63:4813:0:b0:476:fdde:b1f6 with SMTP id v19-20020a634813000000b00476fddeb1f6mr3239526pga.212.1668998358229;
        Sun, 20 Nov 2022 18:39:18 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id md18-20020a17090b23d200b00218bd1745c5sm227775pjb.12.2022.11.20.18.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 18:39:17 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:39:12 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] srcu: Move updating of segcblist from srcu_gp_start() to
 srcu_might_be_idle()
Message-ID: <Y3rk0ApkTpzX3pm1@piliu.users.ipa.redhat.com>
References: <20221116015626.10872-1-kernelfans@gmail.com>
 <20221116175922.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3YJ+XX/UUQAkkmF@piliu.users.ipa.redhat.com>
 <20221119011050.GT4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119011050.GT4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 18, 2022 at 05:10:50PM -0800, Paul E. McKenney wrote:
> On Thu, Nov 17, 2022 at 06:16:25PM +0800, Pingfan Liu wrote:
> > On Wed, Nov 16, 2022 at 09:59:22AM -0800, Paul E. McKenney wrote:
> > > On Wed, Nov 16, 2022 at 09:56:26AM +0800, Pingfan Liu wrote:
> > > > The pair of segcblist operations: rcu_segcblist_advance() and
> > > > rcu_segcblist_accelerate() in srcu_gp_start() is needless from two
> > > > perspectives:
> > > > 
> > > >   -1. As a part of the SRCU state machine, it should take care of either
> > > > all sda or none. But here it only takes care of a single sda.
> > > 
> > > I am not so sure that I agree.
> > > 
> > > Taking care of all srcu_node structures' callbacks would be extremely
> > > expensive, with the expense increasing with the number of CPUs.  However,
> > > the cost of taking care of the current CPU's callbacks is quite cheap,
> > > at least in the case where the srcu_struct structure's ->srcu_size_state
> > > field is equal to SRCU_SIZE_BIG.
> > > 
> > > But are you seeing performance issues with that code on real hardware
> > > running real workloads when the srcu_struct structure's ->srcu_size_state
> > > field does not equal SRCU_SIZE_BIG?  My guess is "no" given that this
> > > code has already paid the cost of acquiring the srcu_struct structure's
> > > ->lock, but I figured I should ask.  The opinion of real hardware running
> > > real workloads beats any of our opinions, after all.  ;-)
> > > 
> > > If you are seeing real slowdowns, then one option is to decrease the
> > > default value of big_cpu_lim from 128 to some appropriate smaller value.
> > > Maybe 16 or 32?
> > > 
> > > Alternatively, the code in srcu_gp_start() that this patch removes might
> > > be executed only when ssp->srcu_size_state is equal to SRCU_SIZE_BIG.
> > > But this approach would likely still have performance issues due to the
> > > acquisition of srcu_struct structure's ->lock, right?
> > > 
> > > Also, if you are seeing real slowdowns, please place that information
> > > in the commit log.
> > 
> > Thanks for stiring up so much internal information. It is useful to
> > guild me through the code reading.
> > 
> > I have not seen any slowdowns, just try to organize the code. Since the
> > note before srcu_might_be_idle() explains why it only evaluate a local
> > sda, while srcu_gp_start() has not, so I am puzzled about it.
> 
> Locality of reference is a good thing in general, so unless it is a
> strange case, there won't always be a "do this to promote locality of
> reference" comment.
> 

Learned.

> > > Thoughts?
> > > 
> > > >   -2. From the viewpoint of the callback, at the entrance,
> > > > srcu_gp_start_if_needed() has called that pair operations and attached
> > > > it with gp_seq. At the exit, srcu_invoke_callbacks() calls that pair
> > > > again to extract the done callbacks. So the harvesting of the callback
> > > > is not affected by the call to that pair in srcu_gp_start().
> > > > 
> > > > But because the updating of RCU_DONE_TAIL by srcu_invoke_callbacks() may
> > > > have some delay than by srcu_gp_end()->srcu_gp_start(), the removal may
> > > > cause srcu_might_be_idle() not to be real time.  To compensate that,
> > > > supplement that pair just before the calling to rcu_segcblist_pend_cbs()
> > > > in srcu_might_be_idle().
> > > 
> > > I agree that srcu_might_be_idle() is not a bad place to add such a check,
> > > especially given that it has other reasons to acquire the srcu_data
> > > structure's ->lock.  Except that this misses both call_srcu() and
> > > synchronize_srcu_expedited(), so that if a workload invokes call_srcu()
> > > and/or synchronize_srcu_expedited() on a given srcu_struct structure,
> > > but never synchronize)srcu(), the opportunity to advance that CPU's
> > > callbacks at the beginning of a grace period will always be lost.
> > 
> > srcu_gp_start_if_needed() has rcu_segcblist_{advance/accelerate}()
> > unconditionally, so the beginning of a grace period will be always
> > detected via any path through __call_srcu(). Do I miss anything?
> 
> Grace periods can also be started by srcu_gp_end().
> 

But it is helpless for assiciating a gp with the enqueued callback. 

> > And I think the core issue is if it matters that the updating of
> > segcblist defers from srcu_gp_end()->srcu_gp_start() to
> > srcu_invoke_callbacks().
> 
> The main reason for advancing/accelerating from __call_srcu() is to
> make sure that the newly enqueued callback will be associated with a
> grace period.  Otherwise, the newly enqueued callback might well just
> sit there for a very long time.
> 
> Unlike normal RCU, there is no callback polling mechanism in SRCU.
> Nor can there reasonably be, due to the potentially very large number
> of srcu_struct structures.
> 
> (Yes, if __call_srcu() was to become a performance bottleneck, there
> are adjustments that could be made, but let's not increase complexity
> before we see a clear need to do so.)
> 
> > > Alternatively, if we have checks in both synchronize_srcu() and
> > > srcu_gp_start_if_needed(), we end up duplicating the work in the case
> > > where synchronize_srcu() is invoked.  This is also not particularly good.
> > 
> > Here srcu_gp_start() has the following caller:
> >   srcu_advance_state()
> >   srcu_funnel_gp_start()
> >   srcu_reschedule()
> >   srcu_gp_end()
> > 
> > Except srcu_gp_end() increase the gp_seq's counter, the rest has not changed the
> > gp_seq's counter. so the calling to rcu_segcblist_{advance/accelerate}() is
> > needless there.
> 
> Suppose that this srcu_struct is in state SRCU_SIZE_BIG, so that there
> is a callback list for each CPU.
> 
> > Anyway I tried to understand the code and some internal. If you dislike
> > it, please skip it.
> 
> Let's skip this for the moment.
> 

Sure. And I have learned a lot from this thread.

> > Thanks again for your precious time.
> 
> Please let me know if additional information on locality of reference
> would be helpful.
> 

No. That is enough.

Appreciate for your detailed explanation. It is very helpful for me to
understand the code more deeply.

Thanks,

	Pingfan


> 							Thanx, Paul
> 
> > 	Pingfan
> > 
> > > Again, thoughts?
> > > 
> > > 							Thanx, Paul
> > > 
> > > > Test info:
> > > > torture test passed using the following command against commit 094226ad94f4 ("Linux 6.1-rc5")
> > > >    tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs 18*SRCU-P
> > > > 
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > To: rcu@vger.kernel.org
> > > > ---
> > > >  kernel/rcu/srcutree.c | 15 ++++-----------
> > > >  1 file changed, 4 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 725c82bb0a6a..36ba18967133 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -659,21 +659,10 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
> > > >   */
> > > >  static void srcu_gp_start(struct srcu_struct *ssp)
> > > >  {
> > > > -	struct srcu_data *sdp;
> > > >  	int state;
> > > >  
> > > > -	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> > > > -		sdp = per_cpu_ptr(ssp->sda, 0);
> > > > -	else
> > > > -		sdp = this_cpu_ptr(ssp->sda);
> > > >  	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
> > > >  	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
> > > > -	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
> > > > -	rcu_segcblist_advance(&sdp->srcu_cblist,
> > > > -			      rcu_seq_current(&ssp->srcu_gp_seq));
> > > > -	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> > > > -				       rcu_seq_snap(&ssp->srcu_gp_seq));
> > > > -	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
> > > >  	WRITE_ONCE(ssp->srcu_gp_start, jiffies);
> > > >  	WRITE_ONCE(ssp->srcu_n_exp_nodelay, 0);
> > > >  	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
> > > > @@ -1037,6 +1026,10 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> > > >  	/* If the local srcu_data structure has callbacks, not idle.  */
> > > >  	sdp = raw_cpu_ptr(ssp->sda);
> > > >  	spin_lock_irqsave_rcu_node(sdp, flags);
> > > > +	rcu_segcblist_advance(&sdp->srcu_cblist,
> > > > +			      rcu_seq_current(&ssp->srcu_gp_seq));
> > > > +	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> > > > +				       rcu_seq_snap(&ssp->srcu_gp_seq));
> > > >  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
> > > >  		spin_unlock_irqrestore_rcu_node(sdp, flags);
> > > >  		return false; /* Callbacks already present, so not idle. */
> > > > -- 
> > > > 2.31.1
> > > > 
