Return-Path: <SRS0=DmMr=ED=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD55C55179
	for <rcu@archiver.kernel.org>; Wed, 28 Oct 2020 21:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38753246CD
	for <rcu@archiver.kernel.org>; Wed, 28 Oct 2020 21:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603921724;
	bh=tw/yDsperue0fH+I8NRehAx9kRSS3XhcNMotzFMGITM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HvrWikddFT6zMcc5VvBCDKSwXQDSGXQ0uoJ7HUgU4o1TUyj66qw+k7DotOim+AzzJ
	 TGptyDPBKaDWEi7ECyVX3pduRyrLbyVc3m/4HRZQBjgn391j8Lj/0KZ4vkEPM/CaoM
	 W4V3YgdAZ8BwusJqp22y/XBF5GGYxyTQklb4YLsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgJ1VrZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727684AbgJ1VrY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A20247DA;
        Wed, 28 Oct 2020 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603900493;
        bh=tw/yDsperue0fH+I8NRehAx9kRSS3XhcNMotzFMGITM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XvJmT92epF7GePtzYYL3pTRcP/Ds7ILcY51W1EaQuH+qDYUPCRQseQp6OTNWslzDT
         /ZsIkxNJOEr9n3rQMIARlmXUzzgMWRn/2uZc84kOCCxAJrFRvOa7k9JafMkHfHLv7w
         aSJcjVM/8rM2KZdoCxa+5rBVi6etin1yiH9ZBlLc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B43A935212A6; Wed, 28 Oct 2020 08:54:52 -0700 (PDT)
Date:   Wed, 28 Oct 2020 08:54:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20201028155452.GD3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200727211012.30948-1-urezki@gmail.com>
 <160388700630.31056.4624109658766915987@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160388700630.31056.4624109658766915987@build.alporthouse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 28, 2020 at 12:10:06PM +0000, Chris Wilson wrote:
> Quoting Uladzislau Rezki (Sony) (2020-07-27 22:10:12)
> > If the kernel is built with CONFIG_PROVE_RAW_LOCK_NESTING
> > option, the lockedp will complain about violation of the
> > nesting rules:
> > 
> > <snip>
> > [   28.060389] =============================
> > [   28.060389] [ BUG: Invalid wait context ]
> > [   28.060389] 5.8.0-rc3-rcu #211 Tainted: G            E
> > [   28.060389] -----------------------------
> > [   28.060390] vmalloc_test/0/523 is trying to lock:
> > [   28.060390] ffff96df7ffe0228 (&zone->lock){-.-.}-{3:3}, at: get_page_from_freelist+0xcf0/0x16d0
> > [   28.060391] other info that might help us debug this:
> > [   28.060391] context-{5:5}
> > [   28.060392] 2 locks held by vmalloc_test/0/523:
> > [   28.060392]  #0: ffffffffc06750d0 (prepare_for_test_rwsem){++++}-{4:4}, at: test_func+0x76/0x240 [test_vmalloc]
> > [   28.060393]  #1: ffff96df5fa1d390 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x5c/0x230
> > [   28.060395] stack backtrace:
> > [   28.060395] CPU: 0 PID: 523 Comm: vmalloc_test/0 Tainted: G            E     5.8.0-rc3-rcu #211
> > [   28.060395] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > [   28.060396] Call Trace:
> > [   28.060397]  dump_stack+0x96/0xd0
> > [   28.060397]  __lock_acquire.cold.65+0x166/0x2d7
> > [   28.060398]  ? find_held_lock+0x2d/0x90
> > [   28.060399]  lock_acquire+0xad/0x370
> > [   28.060400]  ? get_page_from_freelist+0xcf0/0x16d0
> > [   28.060401]  ? mark_held_locks+0x48/0x70
> > [   28.060402]  _raw_spin_lock+0x25/0x30
> > [   28.060403]  ? get_page_from_freelist+0xcf0/0x16d0
> > [   28.060404]  get_page_from_freelist+0xcf0/0x16d0
> > [   28.060405]  ? __lock_acquire+0x3ee/0x1b90
> > [   28.060407]  __alloc_pages_nodemask+0x16a/0x3a0
> > [   28.060408]  __get_free_pages+0xd/0x30
> > [   28.060409]  kvfree_call_rcu+0x18a/0x230
> > <snip>
> 
> We've encountered the same warning and applying this patches resolves
> the issue.
> 
> > Internally the kfree_rcu() uses raw_spinlock_t whereas the
> > page allocator internally deals with spinlock_t to access
> > to its zones.
> > 
> > In order to prevent such vialation that is in question we
> > can drop the internal raw_spinlock_t before entering to
> > the page allocaor.
> > 
> > Short changelog (v1 -> v2):
> >     - rework the commit message;
> >     - rework the patch making it smaller;
> >     - add more comments.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/tree.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 21c2fa5bd8c3..2de112404121 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3287,6 +3287,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> >                 return false;
> >  
> >         lockdep_assert_held(&krcp->lock);
> > +       lockdep_assert_irqs_disabled();
> > +
> >         idx = !!is_vmalloc_addr(ptr);
> >  
> >         /* Check if a new block is required. */
> > @@ -3306,6 +3308,29 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> >                         if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >                                 return false;
> >  
> > +                       /*
> > +                        * If built with CONFIG_PROVE_RAW_LOCK_NESTING option,
> > +                        * the lockedp will complain about violation of the
> > +                        * nesting rules. It does the raw_spinlock vs. spinlock
> > +                        * nesting checks.
> > +                        *
> > +                        * That is why we drop the raw lock. Please note IRQs are
> > +                        * still disabled it guarantees that the "current" stays
> > +                        * on the same CPU later on when the raw lock is taken
> > +                        * back.
> > +                        *
> > +                        * It is important because if the page allocator is invoked
> > +                        * in fully preemptible context, it can be that we get a page
> > +                        * but end up on another CPU. That another CPU might not need
> > +                        * a page because of having some extra spots in its internal
> > +                        * array for pointer collecting. Staying on same CPU eliminates
> > +                        * described issue.
> > +                        *
> > +                        * Dropping the lock also reduces the critical section by
> > +                        * the time taken by the page allocator to obtain a page.
> > +                        */
> > +                       raw_spin_unlock(&krcp->lock);
> 
> Aiui, this makes the CONFIG_PREEMPT_RT check and subsequent comment redundant.
> 
> >                         /*
> >                          * NOTE: For one argument of kvfree_rcu() we can
> >                          * drop the lock and get the page in sleepable
> > @@ -3315,6 +3340,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> >                          */
> >                         bnode = (struct kvfree_rcu_bulk_data *)
> >                                 __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > +
> > +                       raw_spin_lock(&krcp->lock);
> >                 }
> 
> The consequence of dropping the lock here is that we may create two
> bnodes and add them both to krcp->bkvhead[idx]. The list remains intact,
> but the second entry may be underutilised. That should be transient.
> 
> It doesn't seem like the patch will break things, and removes the
> lockdep splat,
> Tested-by: Chris Wilson <chris@chris-wilson.co.uk>

Thank you for testing this, Chris!  We had objections to all patches
thus far, so we are going back to the drawing board, hopefully having
something for the v5.11 merge window.

							Thanx, Paul
