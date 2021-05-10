Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C7AC43462
	for <rcu@archiver.kernel.org>; Mon, 10 May 2021 14:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA566157E
	for <rcu@archiver.kernel.org>; Mon, 10 May 2021 14:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbhEJPAt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 May 2021 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241909AbhEJPAX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 May 2021 11:00:23 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40478C028005;
        Mon, 10 May 2021 07:20:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id f12so8441193ljp.2;
        Mon, 10 May 2021 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rmt53jkm2pEOW1Zp9XLb2RYP71D2t/e3KMRpzhTT0jc=;
        b=qFNkwBJYblgYpnwYhJClX/wLvPWe1H0S1qO70IqSb1C00+gtxnO83tB5cP+hUQdoCU
         I5T6PUK15qrRahvOJSR2PaPHxjOPpJy6MU3ZpnhWDcjzEQQPAaNQ7L07DURiusyLHGNY
         OwdEfh08Nndat5drstf/I10YUNW38hh6Oqh95b8XbRTbDdh8reffu6lVH4j6NMVOS/k6
         OcLPtHdd9Dg0lSSiMSdGsXnny2o6yxcdOKvxtqHoluDfr1qHIBi5U+RmmLtmQkWcXuxa
         dryLt3aLkpGmvzPp9Cw5zGEypZn2Dd0lX928cY7FN95dB2Ltplz8nxak0UXmqXcauz+Q
         ytBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rmt53jkm2pEOW1Zp9XLb2RYP71D2t/e3KMRpzhTT0jc=;
        b=XbGW4bZAJaZXD3o1DXzu4/tVx/izHSTW4JST4F9npNU/g0m6kCbarEqAJCHE3huQLd
         qL8VlGjWLUH4E2cIq+SY2EeVEZpAXc6enI0IlCwQULh2DUQ/dzDYFgAkbDuVWc9gZo7S
         njQPapDBtUcHqIuhNWA8iAoXLWlMTPkDeM68kBQHICmeZYfghZqZJYi94mo2YUIMQgkR
         4Tp/95TkJI4iBeOkeKW2dQ4LH5kSncGcOtsE/HcqitzfiZk/zHZSlrUWRJ6nVs6Rrp2P
         0xl4oj0Ye9ODFy8n60v08AT2YtbavInvPPDXIjrM144kZrjxWTh46O8K1wDX81xFTa7q
         A4kA==
X-Gm-Message-State: AOAM5303Ly6XiIWpYhI5R0tTBt5qtQmmQGYEiWA/QkAmdOkculZ/LvKc
        gMmCWSkV7s2Iy0u4dwHJHI8=
X-Google-Smtp-Source: ABdhPJzMm2+QaAnLzUv/AAD+5ojjXaBxq3FhUs69RVgQJdwLgGUwCd2mVKihCydGLFU5dGugIdPhtg==
X-Received: by 2002:a2e:b161:: with SMTP id a1mr20684999ljm.426.1620656421793;
        Mon, 10 May 2021 07:20:21 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t17sm2248305lff.25.2021.05.10.07.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:20:21 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 10 May 2021 16:20:18 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 4/5] kvfree_rcu: Refactor kfree_rcu_monitor() function
Message-ID: <20210510142018.GA2350@pc638.lan>
References: <20210428134422.1894-1-urezki@gmail.com>
 <20210428134422.1894-4-urezki@gmail.com>
 <20210509165954.347dd3cd8e8815b9dce67cfb@linux-foundation.org>
 <20210510100901.GA2019@pc638.lan>
 <20210510140143.GD975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510140143.GD975577@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 10, 2021 at 07:01:43AM -0700, Paul E. McKenney wrote:
> On Mon, May 10, 2021 at 12:09:01PM +0200, Uladzislau Rezki wrote:
> > On Sun, May 09, 2021 at 04:59:54PM -0700, Andrew Morton wrote:
> > > On Wed, 28 Apr 2021 15:44:21 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> > > 
> > > > Rearm the monitor work directly from its own function that
> > > > is kfree_rcu_monitor(). So this patch puts the invocation
> > > > timing control in one place.
> > > >
> > > > ...
> > > >
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3415,37 +3415,44 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> > > >  	return !repeat;
> > > >  }
> > > >  
> > > > -static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> > > > -					  unsigned long flags)
> > > > +/*
> > > > + * This function queues a new batch. If success or nothing to
> > > > + * drain it returns 1. Otherwise 0 is returned indicating that
> > > > + * a reclaim kthread has not processed a previous batch.
> > > > + */
> > > > +static inline int kfree_rcu_drain(struct kfree_rcu_cpu *krcp)
> > > >  {
> > > > +	unsigned long flags;
> > > > +	int ret;
> > > > +
> > > > +	raw_spin_lock_irqsave(&krcp->lock, flags);
> > > > +
> > > >  	// Attempt to start a new batch.
> > > > -	if (queue_kfree_rcu_work(krcp)) {
> > > > +	ret = queue_kfree_rcu_work(krcp);
> > > 
> > > This code has changed slightly in mainline.  Can you please redo,
> > > retest and resend?
> > > 
> > > > +	if (ret)
> > > >  		// Success! Our job is done here.
> > > >  		krcp->monitor_todo = false;
> > > > -		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > > -		return;
> > > > -	}
> > > 
> > > It's conventional to retain the braces here, otherwise the code looks
> > > weird.  Unless you're a python programmer ;)
> > > 
> > > 
> > Hello, Anrew.
> > 
> > This refactoring is not up to date and is obsolete, instead we have done 
> > bigger rework of kfree_rcu_monitor(). It is located here:
> > 
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu/+/2349a35d39e7af5eef9064cbd0e42309040551da%5E%21/#F0
> 
> If Andrew would like to start taking these kvfree_rcu() patches,
> that would be all to the good.  For example, there is likely much
> more opportunity for optimization by bringing them closer to the
> sl*b allocators.  Yes, they will need some privileged access to RCU
> internals, but not that much.  And at some point, they should move from
> their current home in kernel/rcu/tree.c to somewhere in mm.
> 
That is the plan to change the home :)


> To that end, here is the list in -rcu against current mainline, from
> youngest to oldest:
> 
> b5691dd1cd7a kvfree_rcu: Fix comments according to current code
> 2349a35d39e7 kvfree_rcu: Refactor kfree_rcu_monitor()
> bfa15885893f kvfree_rcu: Release a page cache under memory pressure
> de9d86c3b0b7 kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access to nr_bkv_objs
> 54a0393340f7 kvfree_rcu: Add a bulk-list check when a scheduler is run
> 7490789de1ac kvfree_rcu: Update "monitor_todo" once a batch is started
> 28e690ce0347 kvfree_rcu: Use kfree_rcu_monitor() instead of open-coded variant
> 
> Please let me know how you would like to proceed.
> 
> 							Thanx, Paul
