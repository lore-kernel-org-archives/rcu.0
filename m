Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B89C433E0
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 15:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B86223A84
	for <rcu@archiver.kernel.org>; Fri, 22 Jan 2021 15:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbhAVPaj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Jan 2021 10:30:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbhAVP3g (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Jan 2021 10:29:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86B1E23AA3;
        Fri, 22 Jan 2021 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611329335;
        bh=9ldXAsBajJcOkkUbYctJnr9HIysDXrYHwaQqogk30ac=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=W88fzHVQM+jkXCokbspmzzReL5QnMNWA1enC9NXfyscIRNA7z5mJJ6O6OgMUuyytg
         AvcWEAKD0r29DEhTtGdUBf7aBOkCpRcswhPxlxW1CL0g7ubRjRlDOwX/AEkoeJ1Lnf
         t0+NF9RNN4o1TK1Rf0hjR94r7TuZBHgoKlCWRGeCoB7wXLXhcyn1UXn+DAd1xYliGb
         DXtVyWYE6NNf0Lf3GT7/dFo77z/HEciPMWRZQLgXYOjW0Ycg4GImcRd0oggRmu9ULj
         qS7kkz3GmiQc1B58bKoQUUINRLfH7lZGDK/EizDVOL5gfEao7tkq4pQisMvHeRVAzt
         kPkN2ZlCunnSw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5AB953522649; Fri, 22 Jan 2021 07:28:55 -0800 (PST)
Date:   Fri, 22 Jan 2021 07:28:55 -0800
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
Message-ID: <20210122152855.GE2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120195757.3lgjrpvmzjvb2nce@linutronix.de>
 <20210120215403.GH2743@paulmck-ThinkPad-P72>
 <20210122111733.tcwfl43akypz3x42@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122111733.tcwfl43akypz3x42@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 22, 2021 at 12:17:33PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-01-20 13:54:03 [-0800], Paul E. McKenney wrote:
> > > > +// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
> > > > +// state specified by flags.  If can_alloc is true, the caller must
> > > > +// be schedulable and not be holding any locks or mutexes that might be
> > > > +// acquired by the memory allocator or anything that it might invoke.
> > > > +// Returns true if ptr was successfully recorded, else the caller must
> > > > +// use a fallback.
> > > 
> > > The whole RCU department is getting swamped by the // comments. Can't we
> > > have proper kernel doc and /* */ style comments like the remaining part
> > > of the kernel?
> > 
> > Because // comments are easier to type and take up less horizontal space.
> 
> As for the typing I could try to sell you 
>   ab // /*
> 
> for your .vimrc and then //<enter> would become /* ;) As for the
> horizontal space, I don't have currently anything in my shop. I'm sorry.

;-)

> > Also, this kvfree_call_rcu_add_ptr_to_bulk() function is local to
> > kvfree_rcu(), and we don't normally docbook-ify such functions.
> 
> I didn't mean to promote using docbook to use every. For instance if you
> look at kernel/trace/trace.c, there are no // comments around, just /*
> style, even for things like tracing_selftest_running.
> 
> Basically I was curious if I could learn where this // is coming and if
> I could stop it.

Because they are now allowed and because they make my life easier as
noted above.  Also in-function comment blocks are either one line or two
lines shorter.  Yeah, they look strange at first, but it is not that hard
to get used to them.  After all, I did manage to get used to the /* */
comment style shortly after first encountering it.  ;-)

> > > >  static inline bool
> > > > -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > > +add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> > > > +	unsigned long *flags, void *ptr, bool can_alloc)
> > > >  {
> > > >  	struct kvfree_rcu_bulk_data *bnode;
> > > >  	int idx;
> > > >  
> > > > -	if (unlikely(!krcp->initialized))
> > > > +	*krcp = krc_this_cpu_lock(flags);
> > > > +	if (unlikely(!(*krcp)->initialized))
> > > >  		return false;
> > > >  
> > > > -	lockdep_assert_held(&krcp->lock);
> > > >  	idx = !!is_vmalloc_addr(ptr);
> > > >  
> > > >  	/* Check if a new block is required. */
> > > > -	if (!krcp->bkvhead[idx] ||
> > > > -			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > > > -		bnode = get_cached_bnode(krcp);
> > > > -		/* Switch to emergency path. */
> > > > +	if (!(*krcp)->bkvhead[idx] ||
> > > > +			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > > > +		bnode = get_cached_bnode(*krcp);
> > > > +		if (!bnode && can_alloc) {
> > > > +			krc_this_cpu_unlock(*krcp, *flags);
> > > > +			bnode = (struct kvfree_rcu_bulk_data *)
> > > 
> > > There is no need for this cast.
> > 
> > Without it, gcc version 7.5.0 says:
> > 
> > 	warning: assignment makes pointer from integer without a cast
> > 
> 
> I'm sorry. I forgot the part where __get_free_page() does not return
> (void *).
> But maybe it should given that free_pages() casts that long back to
> (void *) and __get_free_pages() -> page_address() returns (void *)
> which is then casted long.

No argument here.  Then again, I am not the one in need of convincing.

There are use cases like this from pte_alloc_one_kernel():

	unsigned long page = __get_free_page(GFP_DMA);

But a quick look indicates that they are in the minority.

> > > > +				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> > > > +			*krcp = krc_this_cpu_lock(flags);
> > > 
> > > so if bnode is NULL you could retry get_cached_bnode() since it might
> > > have been filled (given preemption or CPU migration changed something).
> > > Judging from patch #3 you think that a CPU migration is a bad thing. But
> > > why?
> > 
> > So that the later "(*krcp)->bkvhead[idx] = bnode" assignment associates
> > it with the correct CPU.
> > 
> > Though now that you mention it, couldn't the following happen?
> > 
> > o	Task A on CPU 0 notices that allocation is needed, so it
> > 	drops the lock disables migration, and sleeps while
> > 	allocating.
> > 
> > o	Task B on CPU 0 does the same.
> > 
> > o	The two tasks wake up in some order, and the second one
> > 	causes trouble at the "(*krcp)->bkvhead[idx] = bnode"
> > 	assignment.
> 
> Yes it could, good point.
> I would really recommend using migrate_disable() at a minimum and only
> if it is really needed. It is more expensive than preempt_disable() and
> it isn't exactly good in terms of scheduling since the task is run able
> but restricted to a specific CPU.
> If it is unavoidable it is unavoidable but in this case I wouldn't use
> migrate_disable() but re-evaluate the situation after the allocation.

I could imagine the following alternatives:

o	Acquire the old CPU's lock despite having been migrated.
	If the above race happened, put the extra page in the
	per-CPU cache.  As Uladzislau notes, this would require
	some sort of periodic cleanup that would be good to avoid.

o	As now, which can result in an unfilled page, though only
	in an uncommon race condition.  (Uladzislau convinced me
	that this was a good approach some months ago, and the
	fact that he cannot make it happen easily does add some
	weight to his argument.)

o	Use migrate_disable().

Other ideas?

							Thanx, Paul

> > Uladzislau, do we need to recheck "!(*krcp)->bkvhead[idx]" just after
> > the migrate_enable()?  Along with the KVFREE_BULK_MAX_ENTR check?
> > 
> > 							Thanx, Paul
> 
> Sebastian
