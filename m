Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715E9C433EF
	for <rcu@archiver.kernel.org>; Sat, 14 May 2022 14:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiENOoa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 14 May 2022 10:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiENOo3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 14 May 2022 10:44:29 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A912C1169
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:44:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a76so9366747qkg.12
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J6a7H0TuCiyoO5iT3GYQR9ZbDjC5gV1q0yvpiffLSNs=;
        b=iDNj0JiOek94RM1Lu/EHga8FJTczdLo5Hk4h1Ip0aFF/H5uXjwyuje6QyGmijVL2Rv
         nVZMcNQaYvnFOOlYGwQ2dPkpLc5gPGFjqaAuh8dIvXgrrvETMyCrjxfQbUCLlqH+VlvE
         MbytIapxsGYyyqYim5ywg5sS37mSKjVum248k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6a7H0TuCiyoO5iT3GYQR9ZbDjC5gV1q0yvpiffLSNs=;
        b=SgRFiVMPsxaHspfec+gAey92i07HNz6wjcwi21wHMIWFsoui5SQwd5UYQlEOWeSPHb
         hKOc3pFtex2tIM4mSNw2kFZyv3dWi94eT9ms6iwiON71TqwiaWA3BQzRWOVF6vtaH+Q7
         S7R4vhfxu/veRvthJiVvDH1KIRlrNFhFiPPVicJtWS81xhkR1stNAHfpgzsVr0fK/N3d
         teA4Es9fhRe+f8dFGu7Z1N68nWmoGGY5CykdmXKhzvCxJq4BADKF3xOPELeZTGbGufXx
         0Ue4s/iEBm1ryme8nDbh11LbsUYu/oxQPThdpEbFThUGdYTy0kf+85CZ2XH42WxPbLtS
         lsUw==
X-Gm-Message-State: AOAM530//5Ej/JNANTpGaqtJ+EGm8LtUagkvX+sSUik3dF26IJlifzKa
        jHAujo4yAhrQlulLNBPw3Imbyw==
X-Google-Smtp-Source: ABdhPJyMhCWw27VYIxwiukawd5onZ0HwsRsrNvl9d+18ph8BhTV/W1Nn1MRO0V6ltq39OQw+6/Q/PA==
X-Received: by 2002:a05:620a:1706:b0:6a0:263e:35d9 with SMTP id az6-20020a05620a170600b006a0263e35d9mr6989338qkb.477.1652539467809;
        Sat, 14 May 2022 07:44:27 -0700 (PDT)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id bs13-20020a05620a470d00b0069fc13ce1fesm2950606qkb.47.2022.05.14.07.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 07:44:27 -0700 (PDT)
Date:   Sat, 14 May 2022 14:44:27 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 02/14] workqueue: Add a lazy version of queue_rcu_work()
Message-ID: <Yn/ASx54ooFbhb0R@google.com>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-3-joel@joelfernandes.org>
 <20220512235818.GV1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512235818.GV1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 04:58:18PM -0700, Paul E. McKenney wrote:
> On Thu, May 12, 2022 at 03:04:30AM +0000, Joel Fernandes (Google) wrote:
> > This will be used in kfree_rcu() later to make it do call_rcu() lazily.
> 
> Given that kfree_rcu() does its own laziness in filling in the page
> of pointers, do we really need to add additional laziness?
> 
> Or are you measuring a significant benefit from doing this?

The benefit I was measuring was, prior to this, I was seeing frequent calls
to queue_delay_rcu(). Based on the latest test results, though, I am not
seeing a signficant benefit and Vlad also confirms it. So I might drop this
patch completely. For easier testing though, it would be nice to make
KFREE_DRAIN_JIFFIES and mainline that change as well, since I believe we can
achieve similar effect by just increasing that timeout.

thanks!

 - Joel

> 
> 							Thanx, Paul
> 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  include/linux/workqueue.h |  1 +
> >  kernel/workqueue.c        | 25 +++++++++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> > index 7fee9b6cfede..2678a6b5b3f3 100644
> > --- a/include/linux/workqueue.h
> > +++ b/include/linux/workqueue.h
> > @@ -444,6 +444,7 @@ extern bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
> >  extern bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
> >  			struct delayed_work *dwork, unsigned long delay);
> >  extern bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork);
> > +extern bool queue_rcu_work_lazy(struct workqueue_struct *wq, struct rcu_work *rwork);
> >  
> >  extern void flush_workqueue(struct workqueue_struct *wq);
> >  extern void drain_workqueue(struct workqueue_struct *wq);
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 33f1106b4f99..9444949cc148 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -1796,6 +1796,31 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
> >  }
> >  EXPORT_SYMBOL(queue_rcu_work);
> >  
> > +/**
> > + * queue_rcu_work_lazy - queue work after a RCU grace period
> > + * @wq: workqueue to use
> > + * @rwork: work to queue
> > + *
> > + * Return: %false if @rwork was already pending, %true otherwise.  Note
> > + * that a full RCU grace period is guaranteed only after a %true return.
> > + * While @rwork is guaranteed to be executed after a %false return, the
> > + * execution may happen before a full RCU grace period has passed.
> > + */
> > +bool queue_rcu_work_lazy(struct workqueue_struct *wq, struct rcu_work *rwork)
> > +{
> > +	struct work_struct *work = &rwork->work;
> > +
> > +	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> > +		rwork->wq = wq;
> > +		call_rcu_lazy(&rwork->rcu, rcu_work_rcufn);
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +EXPORT_SYMBOL(queue_rcu_work_lazy);
> > +
> > +
> >  /**
> >   * worker_enter_idle - enter idle state
> >   * @worker: worker which is entering idle state
> > -- 
> > 2.36.0.550.gb090851708-goog
> > 
