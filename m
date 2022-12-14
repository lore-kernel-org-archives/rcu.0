Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653E0C4332F
	for <rcu@archiver.kernel.org>; Wed, 14 Dec 2022 12:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiLNMgu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Dec 2022 07:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbiLNMgT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Dec 2022 07:36:19 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B7FBC8A
        for <rcu@vger.kernel.org>; Wed, 14 Dec 2022 04:34:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a9so3170510pld.7
        for <rcu@vger.kernel.org>; Wed, 14 Dec 2022 04:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flxTKkYdV+Ux5I+C9jOGJuLoMb60/HSAb/gzXohwkO8=;
        b=ZGXAD+u5EHsvfnKBI/kAoFFdeGFB4GD2Pskdl/drSoGQd4OMOjz11nRLGc7QvuLMnz
         mvl8gPljvQhk9sXWEF4K6Gs6jFyI2erertAAj8UuJWQSyCrqPLnoeuG3AXNhwH7+o3p5
         fBgqQXQn7D+Lq49Z0IKSc8FSRzDA66yKL05bDGPA4Xv0xI67DAUbowRypQSwRYHetF0r
         PBfijwiCUThunfYrE9lsSPZPGxiJjvkXb4VNl/ED1xq9XxL9NtPuNe3Hb/xU4WPNVH28
         6Co055ZiGEaAyD+ScTJt2xGHLRVyGJ5aqu8+qwWEWebzn8ucyK5Zqry3Nck5UgLKp2pJ
         2RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flxTKkYdV+Ux5I+C9jOGJuLoMb60/HSAb/gzXohwkO8=;
        b=I59ab/KvqQud7TC7Uwcvo4cdnrk4ZA3CGHwNquM+9lJxzMnwxdXQxHBXS8xn9x+UU/
         dtzPMLRq6Mzy/Nea8RnhippXzO2Dp7h+vl3qwA9wzwbqWXO8cX6aQAdLwLDvZMnaz4o1
         4ABVD3sCvLVpujJydJKsaoWR6oH8nZ9t+Hd3b5OgGqcmaYr1q3X2CwZNnYxjaB+3i/TB
         D+BM0mbSZXl89Z8I2vRRuCb3vVOKLN1kFPERhe5y2B2gEiUF0BQCdmym2miWFOeTXarQ
         3Q+IxfenxyUsUccZJPzR/ShynfFlK9Lvt90AT/6K3F0tMizS2Hxg00b4WLaHqSlyzPDx
         jP5w==
X-Gm-Message-State: ANoB5pnVza7oxGEdnrHJFCCpcIwteXWccZbAMW1YcpLbliDlBSCbQiVF
        yLw7t70FnayAUuuF0V7iYDk3hRwOn5Ki
X-Google-Smtp-Source: AA0mqf51/mYm4q0moxW2741cQGPr4DzRMVxxx0YHEvI/Yfy5MGQGv2AE/F6FlI0jEkQiQjWjWNWTCQ==
X-Received: by 2002:a17:902:b414:b0:186:7a6b:dcdb with SMTP id x20-20020a170902b41400b001867a6bdcdbmr24614461plr.40.1671021286847;
        Wed, 14 Dec 2022 04:34:46 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903120700b0017f73dc1549sm1756784plh.263.2022.12.14.04.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 04:34:45 -0800 (PST)
Date:   Wed, 14 Dec 2022 20:34:35 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: Re: [PATCH] srcu: switch work func to allow concurrent gp
Message-ID: <Y5nC2yBhaUYirByo@piliu.users.ipa.redhat.com>
References: <20221130083902.31577-1-kernelfans@gmail.com>
 <Y4eKl2fCNDX2ka1g@boqun-archlinux>
 <Y4ix4BWZvTrk9WkJ@piliu.users.ipa.redhat.com>
 <Y5h3bmckCkJQ6cmg@piliu.users.ipa.redhat.com>
 <Y5jXuVHKippIZ24j@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5jXuVHKippIZ24j@boqun-archlinux>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 13, 2022 at 11:51:21AM -0800, Boqun Feng wrote:
> On Tue, Dec 13, 2022 at 09:00:30PM +0800, Pingfan Liu wrote:
> > On Thu, Dec 01, 2022 at 09:53:36PM +0800, Pingfan Liu wrote:
> > > On Wed, Nov 30, 2022 at 08:53:43AM -0800, Boqun Feng wrote:
> > > > On Wed, Nov 30, 2022 at 04:39:02PM +0800, Pingfan Liu wrote:
> > > > > ssp->srcu_cb_mutex is introduced to allow the other srcu state machine
> > > > > to advance as soon as possible. But according to the implement of
> > > > > workqueue, the same work_struct is serialized and can not run
> > > > > concurrently in fact.
> > > > > 
> > > > > Quoting from Documentation/core-api/workqueue.rst
> > > > > "
> > > > > Non-reentrance Conditions
> > > > > =========================
> > > > > 
> > > > > Workqueue guarantees that a work item cannot be re-entrant if the following
> > > > > conditions hold after a work item gets queued:
> > > > > 
> > > > >         1. The work function hasn't been changed.
> > > > >         2. No one queues the work item to another workqueue.
> > > > >         3. The work item hasn't been reinitiated.
> > > > > "
> > > > > 
> > > > > To allow the concurrence to some extent, it can be achieved by changing
> > > > > the work function to break the conditions. As a result, when
> > > > > srcu_gp_end() releases srcu_gp_mutex, a new state machine can begin.
> > > > > 
> > > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> > > > > To: rcu@vger.kernel.org
> > > > > ---
> > > > >  kernel/rcu/srcutree.c | 19 +++++++++++++++++++
> > > > >  1 file changed, 19 insertions(+)
> > > > > 
> > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > index 1c304fec89c0..56dd9bb2c8b8 100644
> > > > > --- a/kernel/rcu/srcutree.c
> > > > > +++ b/kernel/rcu/srcutree.c
> > > > > @@ -75,6 +75,7 @@ static bool __read_mostly srcu_init_done;
> > > > >  static void srcu_invoke_callbacks(struct work_struct *work);
> > > > >  static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
> > > > >  static void process_srcu(struct work_struct *work);
> > > > > +static void process_srcu_wrap(struct work_struct *work);
> > > > >  static void srcu_delay_timer(struct timer_list *t);
> > > > >  
> > > > >  /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(). */
> > > > > @@ -763,6 +764,11 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > > > >  		cbdelay = 0;
> > > > >  
> > > > >  	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
> > > > > +	/* Change work func so work can be concurrent */
> > > > > +	if (ssp->work.work.func == process_srcu_wrap)
> > > > > +		ssp->work.work.func = process_srcu;
> > > > > +	else
> > > > > +		ssp->work.work.func = process_srcu_wrap;
> > > > 
> > > > This looks really hacky ;-) It would be good that workqueue has an API
> > > > to allow "resetting" a work.
> > > > 
> > > 
> > > Indeed, it is hacky and it can be done by using alternative work_struct
> > > so that from the workqueue API, it is intact.
> > > 
> > > > Do you have any number of the potential performance improvement?
> > > > 
> > > 
> > > I will try to bring out one. But the result may heavily depend on the
> > > test case.
> > > 
> > 
> > Sorry to update late, I was interrupted by something else.
> 
> No worries, thanks for looking into it.
> 
> > 
> > I used two machine to test
> > 
> > -1. on 144 cpus hpe-dl560gen10
> > 
> > modprobe rcutorture   torture_type=srcud  fwd_progress=144 fwd_progress_holdoff=1 shutdown_secs=36000 stat_interval=60 verbose=1
> > 
> > # no patch
> > [37587.632155] srcud:  End-test grace-period state: g28287244 f0x0 total-gps=28287244
> > #my patch
> > [36443.468017] srcud:  End-test grace-period state: g29026056 f0x0 total-gps=29026056
> > 
> > 
> > -2. on 256 cpus amd-milan
> > modprobe rcutorture   torture_type=srcud  fwd_progress=256 fwd_progress_holdoff=1 shutdown_secs=36000 stat_interval=60 verbose=1
> > 
> > # no patch
> > [36093.605732] srcud:  End-test grace-period state: g10850284 f0x0 total-gps=10850284
> > #my patch
> > [36093.856713] srcud:  End-test grace-period state: g10672632 f0x0 total-gps=10672632
> > 
> > 
> > The first test shows that it has about 2.6% improvement, while the
> > second test shows it has no significant effect.
> > 
> > 
> > I wonder if any test case can be in flavour of my patch. Any suggestion?
> > 
> 
> I actually wait you to tell me that ;-) Your trick clearly can improve
> the degree of parallel a bit, but IIUC you need that srcu_end_gp() runs
> at the same time with the srcu work function (i.e. pending bit is
> cleared) to archieve that. And that's really a small time window ;-)
> 

Yes, it is smaller than I expected.

> And there's always the Amdahl's law: do we know whether the state
> machine processing of SRCU is the bottleneck in any workload?
> 
> And are we willing to give CPU time to SRCU state machine processing
> instead of anything else?
> 
> My suggestion is to keep this patch somewhere, and whenever you see a
> related problem, try the patch and see whether it helps ;-)
> 

Yes. Thanks for your suggestion.

Again, appreciate for your help and advice.

Regards,

	Pingfan

> Regards,
> Boqun
> 
> > 
> > Thanks,
> > 
> > 	Pingfan
> > 
> > > Thanks,
> > > 
> > > 	Pingfan
> > > 
> > > > Regards,
> > > > Boqun
> > > > 
> > > > >  	rcu_seq_end(&ssp->srcu_gp_seq);
> > > > >  	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
> > > > >  	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
> > > > > @@ -1637,6 +1643,19 @@ static void process_srcu(struct work_struct *work)
> > > > >  	srcu_reschedule(ssp, curdelay);
> > > > >  }
> > > > >  
> > > > > +/*
> > > > > + * The ssp->work is expected to be concurrent to some extent, but the current
> > > > > + * workqueue does not support the concurrence on the same work. (Refer to the
> > > > > + * section "Non-reentrance Conditions" in the file workqueue.rst)
> > > > > + * Resolving it by changing the work func.
> > > > > + *
> > > > > + * Prevent compilering from optimizing out it.
> > > > > + */
> > > > > +static __used void process_srcu_wrap(struct work_struct *work)
> > > > > +{
> > > > > +	process_srcu(work);
> > > > > +}
> > > > > +
> > > > >  void srcutorture_get_gp_data(enum rcutorture_type test_type,
> > > > >  			     struct srcu_struct *ssp, int *flags,
> > > > >  			     unsigned long *gp_seq)
> > > > > -- 
> > > > > 2.31.1
> > > > > 
