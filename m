Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94A9C433DB
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 22:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653F82220B
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 22:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbhATWZx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Jan 2021 17:25:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732679AbhATVys (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Jan 2021 16:54:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D80BC235F9;
        Wed, 20 Jan 2021 21:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611179643;
        bh=9uCIoNTqSujww0WyWHTQe652w3SNwj3GXwVl53iL7Hk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uQ4lh3g5MNW/4HX7y+c8MMDW4iaA8LHntbZAZBtAKt84AZBdFOSRSn8/PrhGv0dHk
         rbubLCUw6B2xbYZ+pxprq7X81mgdky5QUH4HWcNMSyEl6MMjyzc9nPOSoI7D0fFU0l
         yYisLeC6WFJXuIWMHgGBOJynBhbXKTSH9ITi1lRlWVZwpz+ey8GuE9bUMmcGelctey
         7DMd3ERZutupgx7ta+E9vWdrDCEPjmx84lfD8QeC+mz3ll02/a57reT93Lgo5XJ4Be
         sEUm0bxPWmISQx4OhX/azWFi7h48zW6axJZSZRTSkUPAQZntPgOBblZQpaZ4yvzISX
         LK7Qh3aekbgVQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A9AD83522B82; Wed, 20 Jan 2021 13:54:03 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:54:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Message-ID: <20210120215403.GH2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120195757.3lgjrpvmzjvb2nce@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120195757.3lgjrpvmzjvb2nce@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 20, 2021 at 08:57:57PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-01-20 17:21:46 [+0100], Uladzislau Rezki (Sony) wrote:
> > For a single argument we can directly request a page from a caller
> > context when a "carry page block" is run out of free spots. Instead
> > of hitting a slow path we can request an extra page by demand and
> > proceed with a fast path.
> > 
> > A single-argument kvfree_rcu() must be invoked in sleepable contexts,
> > and that its fallback is the relatively high latency synchronize_rcu().
> > Single-argument kvfree_rcu() therefore uses GFP_KERNEL|__GFP_RETRY_MAYFAIL
> > to allow limited sleeping within the memory allocator.
> > 
> > [ paulmck: Add add_ptr_to_bulk_krc_lock header comment per Michal Hocko. ]
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 42 ++++++++++++++++++++++++++----------------
> >  1 file changed, 26 insertions(+), 16 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index e04e336bee42..2014fb22644d 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3465,37 +3465,50 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> >  	}
> >  }
> >  
> > +// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
> > +// state specified by flags.  If can_alloc is true, the caller must
> > +// be schedulable and not be holding any locks or mutexes that might be
> > +// acquired by the memory allocator or anything that it might invoke.
> > +// Returns true if ptr was successfully recorded, else the caller must
> > +// use a fallback.
> 
> The whole RCU department is getting swamped by the // comments. Can't we
> have proper kernel doc and /* */ style comments like the remaining part
> of the kernel?

Because // comments are easier to type and take up less horizontal space.
Also, this kvfree_call_rcu_add_ptr_to_bulk() function is local to
kvfree_rcu(), and we don't normally docbook-ify such functions.

> >  static inline bool
> > -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > +add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> > +	unsigned long *flags, void *ptr, bool can_alloc)
> >  {
> >  	struct kvfree_rcu_bulk_data *bnode;
> >  	int idx;
> >  
> > -	if (unlikely(!krcp->initialized))
> > +	*krcp = krc_this_cpu_lock(flags);
> > +	if (unlikely(!(*krcp)->initialized))
> >  		return false;
> >  
> > -	lockdep_assert_held(&krcp->lock);
> >  	idx = !!is_vmalloc_addr(ptr);
> >  
> >  	/* Check if a new block is required. */
> > -	if (!krcp->bkvhead[idx] ||
> > -			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > -		bnode = get_cached_bnode(krcp);
> > -		/* Switch to emergency path. */
> > +	if (!(*krcp)->bkvhead[idx] ||
> > +			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > +		bnode = get_cached_bnode(*krcp);
> > +		if (!bnode && can_alloc) {
> > +			krc_this_cpu_unlock(*krcp, *flags);
> > +			bnode = (struct kvfree_rcu_bulk_data *)
> 
> There is no need for this cast.

Without it, gcc version 7.5.0 says:

	warning: assignment makes pointer from integer without a cast

> > +				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> > +			*krcp = krc_this_cpu_lock(flags);
> 
> so if bnode is NULL you could retry get_cached_bnode() since it might
> have been filled (given preemption or CPU migration changed something).
> Judging from patch #3 you think that a CPU migration is a bad thing. But
> why?

So that the later "(*krcp)->bkvhead[idx] = bnode" assignment associates
it with the correct CPU.

Though now that you mention it, couldn't the following happen?

o	Task A on CPU 0 notices that allocation is needed, so it
	drops the lock disables migration, and sleeps while
	allocating.

o	Task B on CPU 0 does the same.

o	The two tasks wake up in some order, and the second one
	causes trouble at the "(*krcp)->bkvhead[idx] = bnode"
	assignment.

Uladzislau, do we need to recheck "!(*krcp)->bkvhead[idx]" just after
the migrate_enable()?  Along with the KVFREE_BULK_MAX_ENTR check?

							Thanx, Paul
