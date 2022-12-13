Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B6BC4332F
	for <rcu@archiver.kernel.org>; Tue, 13 Dec 2022 13:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiLMNAk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Dec 2022 08:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbiLMNAj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Dec 2022 08:00:39 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BFB1D67E
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 05:00:37 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so3429355pjs.4
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 05:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZZ+Bi4FwMyUPJpSLJausq6bt6iSkLW5ucujWMLSUMU=;
        b=nbUUZZgAceFsQywDNPpwJ+tYDpuZgy1WXLrGA3872weRhGCWbv+SHBB6tvfzC51Jpg
         qb+HAxna27VegpYaZn27l6z/B8Fq9Hcf2VCy0yTOilM88jx/xJOpadVjVLJBDfg2+mij
         FPC62JQCBLJ19YM2J1z4kJqdMKZGmg1UsfLCaZh3mTL+fu1G6ACYk8orXchSgBYcrzx8
         zdO53+PAz2tx1UbIKyfYTo2i39CP37sfHrmrZ+7ZnruCebxWa9pfYdNYicmqt9e59BVF
         ACHKy8RxL9VZ9jFhSg+GMY1SWSUZBpghwhlNL306hOo5Zwv3Yx4ys7Quv8pmF4CRmrUm
         b7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZZ+Bi4FwMyUPJpSLJausq6bt6iSkLW5ucujWMLSUMU=;
        b=aB4l5HJeyhDdtBd/Nqe7rYobIqPRjLtTHu6bEyCpM97HjcCwdfZ5qJeF6eKOfnZx49
         U746RjZ3/x4VbCOLo2CDLYqWv81dTg+uuwRu3j8zQ+NyWvSn4ROOu9kt2aVv/jYg61gT
         wobjEvpk0UVhsiqRH0H7UCA3ckKFETNZojk5sXCARZdCDYqD+BuwtYB+6rFmPLQRLd7o
         eJIJSCkGu2uhvUqw2iTZWLehyd6RfC/9o8rfES0DUi/TIyW9W78Y/O8LC5n1haY6OpQA
         CfUYHuSvgGfK/EnTGjiBLMFUNkDC6D2ns8eCnpBQTEeZi6QfOpB1wjhiQfQt1OqHNLpy
         3dng==
X-Gm-Message-State: ANoB5pmuFu5a1XindWCx1lTKkX1peFEUXQQ9Uo/m5Ccadn77Ffho+kqS
        mf5SQLcHoIVxtJqH+JJ0VQ==
X-Google-Smtp-Source: AA0mqf6i3WECrWy4dSfIpstXTyA50XVZF2wqzi9Y2bZYxEK0nRputhHutRcZ5WEdjVKU469mID95rA==
X-Received: by 2002:a17:902:9a93:b0:189:44a2:4cb6 with SMTP id w19-20020a1709029a9300b0018944a24cb6mr19510460plp.20.1670936437329;
        Tue, 13 Dec 2022 05:00:37 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e5c300b00189947bd9f7sm8433517plf.50.2022.12.13.05.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 05:00:36 -0800 (PST)
Date:   Tue, 13 Dec 2022 21:00:30 +0800
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
Message-ID: <Y5h3bmckCkJQ6cmg@piliu.users.ipa.redhat.com>
References: <20221130083902.31577-1-kernelfans@gmail.com>
 <Y4eKl2fCNDX2ka1g@boqun-archlinux>
 <Y4ix4BWZvTrk9WkJ@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4ix4BWZvTrk9WkJ@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Dec 01, 2022 at 09:53:36PM +0800, Pingfan Liu wrote:
> On Wed, Nov 30, 2022 at 08:53:43AM -0800, Boqun Feng wrote:
> > On Wed, Nov 30, 2022 at 04:39:02PM +0800, Pingfan Liu wrote:
> > > ssp->srcu_cb_mutex is introduced to allow the other srcu state machine
> > > to advance as soon as possible. But according to the implement of
> > > workqueue, the same work_struct is serialized and can not run
> > > concurrently in fact.
> > > 
> > > Quoting from Documentation/core-api/workqueue.rst
> > > "
> > > Non-reentrance Conditions
> > > =========================
> > > 
> > > Workqueue guarantees that a work item cannot be re-entrant if the following
> > > conditions hold after a work item gets queued:
> > > 
> > >         1. The work function hasn't been changed.
> > >         2. No one queues the work item to another workqueue.
> > >         3. The work item hasn't been reinitiated.
> > > "
> > > 
> > > To allow the concurrence to some extent, it can be achieved by changing
> > > the work function to break the conditions. As a result, when
> > > srcu_gp_end() releases srcu_gp_mutex, a new state machine can begin.
> > > 
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> > > To: rcu@vger.kernel.org
> > > ---
> > >  kernel/rcu/srcutree.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 1c304fec89c0..56dd9bb2c8b8 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -75,6 +75,7 @@ static bool __read_mostly srcu_init_done;
> > >  static void srcu_invoke_callbacks(struct work_struct *work);
> > >  static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
> > >  static void process_srcu(struct work_struct *work);
> > > +static void process_srcu_wrap(struct work_struct *work);
> > >  static void srcu_delay_timer(struct timer_list *t);
> > >  
> > >  /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(). */
> > > @@ -763,6 +764,11 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > >  		cbdelay = 0;
> > >  
> > >  	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
> > > +	/* Change work func so work can be concurrent */
> > > +	if (ssp->work.work.func == process_srcu_wrap)
> > > +		ssp->work.work.func = process_srcu;
> > > +	else
> > > +		ssp->work.work.func = process_srcu_wrap;
> > 
> > This looks really hacky ;-) It would be good that workqueue has an API
> > to allow "resetting" a work.
> > 
> 
> Indeed, it is hacky and it can be done by using alternative work_struct
> so that from the workqueue API, it is intact.
> 
> > Do you have any number of the potential performance improvement?
> > 
> 
> I will try to bring out one. But the result may heavily depend on the
> test case.
> 

Sorry to update late, I was interrupted by something else.

I used two machine to test

-1. on 144 cpus hpe-dl560gen10

modprobe rcutorture   torture_type=srcud  fwd_progress=144 fwd_progress_holdoff=1 shutdown_secs=36000 stat_interval=60 verbose=1

# no patch
[37587.632155] srcud:  End-test grace-period state: g28287244 f0x0 total-gps=28287244
#my patch
[36443.468017] srcud:  End-test grace-period state: g29026056 f0x0 total-gps=29026056


-2. on 256 cpus amd-milan
modprobe rcutorture   torture_type=srcud  fwd_progress=256 fwd_progress_holdoff=1 shutdown_secs=36000 stat_interval=60 verbose=1

# no patch
[36093.605732] srcud:  End-test grace-period state: g10850284 f0x0 total-gps=10850284
#my patch
[36093.856713] srcud:  End-test grace-period state: g10672632 f0x0 total-gps=10672632


The first test shows that it has about 2.6% improvement, while the
second test shows it has no significant effect.


I wonder if any test case can be in flavour of my patch. Any suggestion?


Thanks,

	Pingfan

> Thanks,
> 
> 	Pingfan
> 
> > Regards,
> > Boqun
> > 
> > >  	rcu_seq_end(&ssp->srcu_gp_seq);
> > >  	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
> > >  	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
> > > @@ -1637,6 +1643,19 @@ static void process_srcu(struct work_struct *work)
> > >  	srcu_reschedule(ssp, curdelay);
> > >  }
> > >  
> > > +/*
> > > + * The ssp->work is expected to be concurrent to some extent, but the current
> > > + * workqueue does not support the concurrence on the same work. (Refer to the
> > > + * section "Non-reentrance Conditions" in the file workqueue.rst)
> > > + * Resolving it by changing the work func.
> > > + *
> > > + * Prevent compilering from optimizing out it.
> > > + */
> > > +static __used void process_srcu_wrap(struct work_struct *work)
> > > +{
> > > +	process_srcu(work);
> > > +}
> > > +
> > >  void srcutorture_get_gp_data(enum rcutorture_type test_type,
> > >  			     struct srcu_struct *ssp, int *flags,
> > >  			     unsigned long *gp_seq)
> > > -- 
> > > 2.31.1
> > > 
