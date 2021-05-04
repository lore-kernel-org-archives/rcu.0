Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70DCC433B4
	for <rcu@archiver.kernel.org>; Tue,  4 May 2021 13:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F67061183
	for <rcu@archiver.kernel.org>; Tue,  4 May 2021 13:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhEDNrS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 4 May 2021 09:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhEDNrS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 4 May 2021 09:47:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4618C061574;
        Tue,  4 May 2021 06:46:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s25so11247702lji.0;
        Tue, 04 May 2021 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hJ5QyVIpYQ1X+QkoXdJD/TF6wPHqmqX75c0eCSUXBCw=;
        b=uP+BqWmIIwkdG04CgC0QKtbS/4UeHN3LCEM5GfAlywyjqgPR5U0gjkNDT3LodIV9dX
         onHCbYWXzclxEQgv2xh0AfrjDMyrAJRgm/KfbVHEKpNRgZv8iIv9xr9peLBgI/NJiCel
         ESzYINl2PveHv8+lscqCCQVCmQhSCade1aY8L8oBAMUpV8Z857Z5VTLCWycSbh4+f14W
         lKOBt3vLc/6gXk2w9V6G8rid5f9ELj1Hr7ZQtdXmQ0EICOLnMC6DdZAiyUmCOPyf7zMe
         RES1LmbjT+RqhTL0eYChPItY7h0wBWGdbPgJyfna48xRkqUOFvr++RH/xLXGKzRkGLrT
         ZTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hJ5QyVIpYQ1X+QkoXdJD/TF6wPHqmqX75c0eCSUXBCw=;
        b=jJ5rSaZ4QltxOxM1ZU7aOaGVqURA5d/v/gDWKhfEu+zJ7j2AwpV8MgkYpwgPogUXR0
         d3xuXpFFyJN9NL4PtZbxRJLFJzbJZOJmsT3GPdE23xQtnii9qe81xLkyPsbMnzG+Hei5
         a/Fr6JPjVeb/oiK+/0BpfWG0HD/QM8WJuFBuy3blAsMfPq3HQPO6kguJh43rO/joyJ9k
         gYSirgNYg9Igi3tOPhiApmvg3sgX9ZNDUo/fS7mwJPhzATdmbWGFPj0z4XGMjRG7wVs2
         wYVmBe066B/3EEyZQoVZkCYmmsqXTdCwuGxkuUytUZnUEks3HeTM+gy/ABQIhmszbqqX
         CZBA==
X-Gm-Message-State: AOAM530TEMXFYmEOjlHe3fijWj+ZxZQ1WaZ+p2b9ARIgBL/pG2EGsD79
        fWl9eTswc1OvCuZw881W2JLoEHsR+LF4rw==
X-Google-Smtp-Source: ABdhPJyoKjScTmdFdxo74elK7xIxGuv/w/Dmi1x6DDXrxlqvP9VsEcq5Esvqg+sT1qPJ8VAQKWjkYQ==
X-Received: by 2002:a2e:b0cb:: with SMTP id g11mr3999585ljl.261.1620135981201;
        Tue, 04 May 2021 06:46:21 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id w4sm270300lfu.105.2021.05.04.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 06:46:20 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 4 May 2021 15:46:18 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 4/5] kvfree_rcu: Refactor kfree_rcu_monitor() function
Message-ID: <20210504134618.GA2468@pc638.lan>
References: <20210428134422.1894-1-urezki@gmail.com>
 <20210428134422.1894-4-urezki@gmail.com>
 <20210503181214.GA2270@pc638.lan>
 <20210503225213.GA975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503225213.GA975577@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 03, 2021 at 03:52:13PM -0700, Paul E. McKenney wrote:
> On Mon, May 03, 2021 at 08:12:14PM +0200, Uladzislau Rezki wrote:
> > Hello, Paul.
> > 
> > > Rearm the monitor work directly from its own function that
> > > is kfree_rcu_monitor(). So this patch puts the invocation
> > > timing control in one place.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  kernel/rcu/tree.c | 35 +++++++++++++++++++++--------------
> > >  1 file changed, 21 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index e44d6f8c56f0..229e909ad437 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3415,37 +3415,44 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> > >  	return !repeat;
> > >  }
> > >  
> > > -static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> > > -					  unsigned long flags)
> > > +/*
> > > + * This function queues a new batch. If success or nothing to
> > > + * drain it returns 1. Otherwise 0 is returned indicating that
> > > + * a reclaim kthread has not processed a previous batch.
> > > + */
> > > +static inline int kfree_rcu_drain(struct kfree_rcu_cpu *krcp)
> > >  {
> > > +	unsigned long flags;
> > > +	int ret;
> > > +
> > > +	raw_spin_lock_irqsave(&krcp->lock, flags);
> > > +
> > >  	// Attempt to start a new batch.
> > > -	if (queue_kfree_rcu_work(krcp)) {
> > > +	ret = queue_kfree_rcu_work(krcp);
> > > +	if (ret)
> > >  		// Success! Our job is done here.
> > >  		krcp->monitor_todo = false;
> > > -		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > -		return;
> > > -	}
> > >  
> > >  	// Previous RCU batch still in progress, try again later.
> > > -	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > +	return ret;
> > >  }
> > >  
> > >  /*
> > >   * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
> > > - * It invokes kfree_rcu_drain_unlock() to attempt to start another batch.
> > > + * It invokes kfree_rcu_drain() to attempt to start another batch.
> > >   */
> > >  static void kfree_rcu_monitor(struct work_struct *work)
> > >  {
> > > -	unsigned long flags;
> > >  	struct kfree_rcu_cpu *krcp = container_of(work, struct kfree_rcu_cpu,
> > >  						 monitor_work.work);
> > >  
> > > -	raw_spin_lock_irqsave(&krcp->lock, flags);
> > > -	if (krcp->monitor_todo)
> > > -		kfree_rcu_drain_unlock(krcp, flags);
> > > -	else
> > > -		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > +	if (kfree_rcu_drain(krcp))
> > > +		return;
> > > +
> > > +	// Not success. A previous batch is still in progress.
> > > +	// Rearm a work to repeat an attempt of starting another batch.
> > > +	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > >  }
> > >  
> > >  static enum hrtimer_restart
> > > -- 
> > > 2.20.1
> > > 
> > 
> > Please see below a v2 of this patch. The main difference between v1
> > is that, the monitor work now is open-coded, thus some extra inline
> > functions were eliminated:
> > 
> > >From 7d153a640a4f791cbfd9b546e32f90fb2c60c480 Mon Sep 17 00:00:00 2001
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > Date: Wed, 21 Apr 2021 13:22:52 +0200
> > Subject: [PATCH v2] kvfree_rcu: Refactor kfree_rcu_monitor()
> > 
> > Currently we have three functions which depend on each other.
> > Two of them are quite tiny and the last one where the most
> > work is done. All of them are related to queuing RCU batches
> > to reclaim objects after a GP.
> > 
> > 1. kfree_rcu_monitor(). It consist of few lines. It acquires
> >    the spin-lock and calls "drain" function.
> > 
> > 2. kfree_rcu_drain_unlock(). It also consists of few lines of
> >    code. It calls a func. to queue the batch. If not success
> >    rearm the monitor work to repeat an attempt one more time.
> > 
> > 3. queue_kfree_rcu_work(). Main core part is implemented here.
> >    In short, it attempts to start a new batch to free objects
> >    after a GP.
> > 
> > Since there are no external users of [2] and [3] functions we
> > can eliminate both by moving all logic directly into [1]. That
> > makes the kfree_rcu_monitor() to be open-coded what is easier
> > to follow thus becomes less complicated.
> > 
> > Apart of that, replace comments which start with "/*" to "//"
> > format to make it unified across the file.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Queued and pushed as shown below.  Nice diffstat!  ;-)
> 
After such refactoring everything seems has been settled :)

Thanks.

--
Vlad Rezki
