Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8286C43217
	for <rcu@archiver.kernel.org>; Thu,  1 Dec 2022 13:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiLANx4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Dec 2022 08:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiLANxz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Dec 2022 08:53:55 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A14A1EAFC
        for <rcu@vger.kernel.org>; Thu,  1 Dec 2022 05:53:54 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g10so1682452plo.11
        for <rcu@vger.kernel.org>; Thu, 01 Dec 2022 05:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7fZGIGpys3hFomsbDWkYfnPyHGAIi2Fw65qRSE6pZbY=;
        b=bfJ2hC8WRKm2l9/l4BV7DkoGh2Km0kdbeXeRNCMZcnTerP5p2fKqdT2m/M6f6li1zO
         EkFsAaHx4KpROhRmnsFBxwR7xUxPEI0Wdof5cG9TKoAFAJOIbqj9pbQTa2B+6AJLZ9jP
         8qs3Rwd5wJQm0bHfRXZ9fuqvObL7wx5mE+BjxkPE0Rt+OspqzguEZw/5Rjid/yHFdggX
         6CybdIenz79ToNElLPg6X/tTbhUiAcxOP9zRRN3GKsqg9f46L63uLbnwyhF21NT35JFl
         zguarVGdiXEcla0XaHDonU6g/r9UCNRnFS7Vpko4trOrxRjVe6OBG7/n7iK39FqT1FbK
         IxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fZGIGpys3hFomsbDWkYfnPyHGAIi2Fw65qRSE6pZbY=;
        b=EsUlyd4eTgBYxyz0j/tmwRnizdRCB3llB9IZY1Yz5Sr0xjVFHWu/5wrd+QRF982+Kc
         XTx+SWvtI++h9XwjlvViwBZXGzoGAit1A0/lD8LlWk507xsiv52x2SENf4BeaKPFjZtd
         7x/vFxdSTvI4fS/gAmRIBW6tVhxcXLSQwY+Xii6pF6RgqW7lXowJZF33w1JYKoQv6Srf
         rb/PmJ08wUvNLsD9siJS0VicmP3JD1wIlX/9T5MvPRM0TPa7Vyvu0LPPZQsN4DlV5DW1
         FzzFX8eZwjTlePtBwLrH7ki6JsIQnxCt1fFTHuYDShhW/UsgLVlgySekZ8H8O3wGIrKt
         S+qA==
X-Gm-Message-State: ANoB5pmRVaSXi3VrO4ZuJ9I6TwWons5bASTUYYNZ7+7ziF96ndYHFrny
        pGgLG63Z7sRJxs8AVAkObA==
X-Google-Smtp-Source: AA0mqf6QFeSbonZEekIKE7vmqBaMFHf6xrK0NEB6IiZgfQdDAWPbQHtPwuSFjkPgeb1RbO4H4J6PYg==
X-Received: by 2002:a17:902:7885:b0:189:1366:fba7 with SMTP id q5-20020a170902788500b001891366fba7mr48972001pll.45.1669902833861;
        Thu, 01 Dec 2022 05:53:53 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902e18500b00174f7d10a03sm3620502pla.86.2022.12.01.05.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:53:53 -0800 (PST)
Date:   Thu, 1 Dec 2022 21:53:36 +0800
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
Message-ID: <Y4ix4BWZvTrk9WkJ@piliu.users.ipa.redhat.com>
References: <20221130083902.31577-1-kernelfans@gmail.com>
 <Y4eKl2fCNDX2ka1g@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4eKl2fCNDX2ka1g@boqun-archlinux>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 30, 2022 at 08:53:43AM -0800, Boqun Feng wrote:
> On Wed, Nov 30, 2022 at 04:39:02PM +0800, Pingfan Liu wrote:
> > ssp->srcu_cb_mutex is introduced to allow the other srcu state machine
> > to advance as soon as possible. But according to the implement of
> > workqueue, the same work_struct is serialized and can not run
> > concurrently in fact.
> > 
> > Quoting from Documentation/core-api/workqueue.rst
> > "
> > Non-reentrance Conditions
> > =========================
> > 
> > Workqueue guarantees that a work item cannot be re-entrant if the following
> > conditions hold after a work item gets queued:
> > 
> >         1. The work function hasn't been changed.
> >         2. No one queues the work item to another workqueue.
> >         3. The work item hasn't been reinitiated.
> > "
> > 
> > To allow the concurrence to some extent, it can be achieved by changing
> > the work function to break the conditions. As a result, when
> > srcu_gp_end() releases srcu_gp_mutex, a new state machine can begin.
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> > To: rcu@vger.kernel.org
> > ---
> >  kernel/rcu/srcutree.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 1c304fec89c0..56dd9bb2c8b8 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -75,6 +75,7 @@ static bool __read_mostly srcu_init_done;
> >  static void srcu_invoke_callbacks(struct work_struct *work);
> >  static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
> >  static void process_srcu(struct work_struct *work);
> > +static void process_srcu_wrap(struct work_struct *work);
> >  static void srcu_delay_timer(struct timer_list *t);
> >  
> >  /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(). */
> > @@ -763,6 +764,11 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> >  		cbdelay = 0;
> >  
> >  	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
> > +	/* Change work func so work can be concurrent */
> > +	if (ssp->work.work.func == process_srcu_wrap)
> > +		ssp->work.work.func = process_srcu;
> > +	else
> > +		ssp->work.work.func = process_srcu_wrap;
> 
> This looks really hacky ;-) It would be good that workqueue has an API
> to allow "resetting" a work.
> 

Indeed, it is hacky and it can be done by using alternative work_struct
so that from the workqueue API, it is intact.

> Do you have any number of the potential performance improvement?
> 

I will try to bring out one. But the result may heavily depend on the
test case.


Thanks,

	Pingfan

> Regards,
> Boqun
> 
> >  	rcu_seq_end(&ssp->srcu_gp_seq);
> >  	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
> >  	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
> > @@ -1637,6 +1643,19 @@ static void process_srcu(struct work_struct *work)
> >  	srcu_reschedule(ssp, curdelay);
> >  }
> >  
> > +/*
> > + * The ssp->work is expected to be concurrent to some extent, but the current
> > + * workqueue does not support the concurrence on the same work. (Refer to the
> > + * section "Non-reentrance Conditions" in the file workqueue.rst)
> > + * Resolving it by changing the work func.
> > + *
> > + * Prevent compilering from optimizing out it.
> > + */
> > +static __used void process_srcu_wrap(struct work_struct *work)
> > +{
> > +	process_srcu(work);
> > +}
> > +
> >  void srcutorture_get_gp_data(enum rcutorture_type test_type,
> >  			     struct srcu_struct *ssp, int *flags,
> >  			     unsigned long *gp_seq)
> > -- 
> > 2.31.1
> > 
