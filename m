Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F18C433B4
	for <rcu@archiver.kernel.org>; Mon, 10 May 2021 14:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D388611BE
	for <rcu@archiver.kernel.org>; Mon, 10 May 2021 14:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbhEJOIj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 May 2021 10:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhEJOCt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 May 2021 10:02:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E2C36101B;
        Mon, 10 May 2021 14:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620655304;
        bh=F7dbRtEIaaThwBLKKfEpeXJ/mhUzWheRAgnCoFAyEwM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lUuYc6yk7D1Y57pKfM61xU70A/ZwBKnBFIIF5lm0vkdMLhBIHWcT6UqBDD89l4dUl
         vjZ/mlvuO5ZR6z2LKgsBvjZrDWXtuuwxnBYK6EJMHfrtb9O5vGrq4hSF804WvEkZF/
         01ocGttJbpbTIhWW2XD5XQ6anS0BGPC4oAGlYd0BHpwgqRtA6yHoKiAPl7/iEcGvBT
         R359LZvxxTBsqvpOIue3LUbhps0b+8nJaZqEkD1Q+sJ93/4EgeXIf0ol8Obiv+EGlN
         qgwH/jpI5JRQLSHX7CEsJ/mQzeU/PToVcHSNARWkLMXNge/2izTBtdzbbAK48T7+iE
         n3aj7myzAbHcg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DEEE65C00D5; Mon, 10 May 2021 07:01:43 -0700 (PDT)
Date:   Mon, 10 May 2021 07:01:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20210510140143.GD975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210428134422.1894-1-urezki@gmail.com>
 <20210428134422.1894-4-urezki@gmail.com>
 <20210509165954.347dd3cd8e8815b9dce67cfb@linux-foundation.org>
 <20210510100901.GA2019@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510100901.GA2019@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 10, 2021 at 12:09:01PM +0200, Uladzislau Rezki wrote:
> On Sun, May 09, 2021 at 04:59:54PM -0700, Andrew Morton wrote:
> > On Wed, 28 Apr 2021 15:44:21 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> > 
> > > Rearm the monitor work directly from its own function that
> > > is kfree_rcu_monitor(). So this patch puts the invocation
> > > timing control in one place.
> > >
> > > ...
> > >
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
> > 
> > This code has changed slightly in mainline.  Can you please redo,
> > retest and resend?
> > 
> > > +	if (ret)
> > >  		// Success! Our job is done here.
> > >  		krcp->monitor_todo = false;
> > > -		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > -		return;
> > > -	}
> > 
> > It's conventional to retain the braces here, otherwise the code looks
> > weird.  Unless you're a python programmer ;)
> > 
> > 
> Hello, Anrew.
> 
> This refactoring is not up to date and is obsolete, instead we have done 
> bigger rework of kfree_rcu_monitor(). It is located here:
> 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu/+/2349a35d39e7af5eef9064cbd0e42309040551da%5E%21/#F0

If Andrew would like to start taking these kvfree_rcu() patches,
that would be all to the good.  For example, there is likely much
more opportunity for optimization by bringing them closer to the
sl*b allocators.  Yes, they will need some privileged access to RCU
internals, but not that much.  And at some point, they should move from
their current home in kernel/rcu/tree.c to somewhere in mm.

To that end, here is the list in -rcu against current mainline, from
youngest to oldest:

b5691dd1cd7a kvfree_rcu: Fix comments according to current code
2349a35d39e7 kvfree_rcu: Refactor kfree_rcu_monitor()
bfa15885893f kvfree_rcu: Release a page cache under memory pressure
de9d86c3b0b7 kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access to nr_bkv_objs
54a0393340f7 kvfree_rcu: Add a bulk-list check when a scheduler is run
7490789de1ac kvfree_rcu: Update "monitor_todo" once a batch is started
28e690ce0347 kvfree_rcu: Use kfree_rcu_monitor() instead of open-coded variant

Please let me know how you would like to proceed.

							Thanx, Paul
