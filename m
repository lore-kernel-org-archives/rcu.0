Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6CDC433DB
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 15:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B06238A1
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 15:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbhAUPIe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:08:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732600AbhAUPIV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Jan 2021 10:08:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0157D238A1;
        Thu, 21 Jan 2021 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611241661;
        bh=t66ihdVricTWu9MQVQckI4MNndPEFqeK9SofzzdlUCw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HBSFMs9lw1kmippPS/jl1FCp+oJOHG3OaPDy3l/HYs0RaiVduuJWowkyg1RnAZWOn
         Px+sJ4HlXwFIMYTxvmkPIRylg+e21QvcehiLgcxqxM0luVsGHOvthSgmBHtHW6JgE8
         2w7DUeirRsKKfzOVQGHaZbzkZ8xYoufYsMoZggJdMGJFnWblRrs0hcVhnEhk8PJ79w
         jtRetuqSSiuntQviBafoQ+0H8EbcptU/Irz3T+mXqirEGmIyRWPZwWvMphivX+50U1
         RDY1QO94TS9NGFW8tJrgNEMfnCfcq2CH9Ugv7JBbV8+9YglO1Kfz6p2Dx6C0GIdy9t
         gWmupy3CQ8byA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B0E19352268F; Thu, 21 Jan 2021 07:07:40 -0800 (PST)
Date:   Thu, 21 Jan 2021 07:07:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <20210121150740.GO2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120195757.3lgjrpvmzjvb2nce@linutronix.de>
 <20210120215403.GH2743@paulmck-ThinkPad-P72>
 <20210121133510.GB1872@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121133510.GB1872@pc638.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 21, 2021 at 02:35:10PM +0100, Uladzislau Rezki wrote:
> On Wed, Jan 20, 2021 at 01:54:03PM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 20, 2021 at 08:57:57PM +0100, Sebastian Andrzej Siewior wrote:

[ . . . ]

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
> > 
> > Uladzislau, do we need to recheck "!(*krcp)->bkvhead[idx]" just after
> > the migrate_enable()?  Along with the KVFREE_BULK_MAX_ENTR check?
> > 
> Probably i should have mentioned your sequence you described, that two tasks
> can get a page on same CPU, i was thinking about it :) Yep, it can happen
> since we drop the lock and a context is fully preemptible, so another one
> can trigger kvfree_rcu() ending up at the same place - entering a page
> allocator.
> 
> I spent some time simulating it, but with no any luck, therefore i did not
> reflect this case in the commit message, thus did no pay much attention to
> such scenario.
> 
> >
> > Uladzislau, do we need to recheck "!(*krcp)->bkvhead[idx]" just after
> > the migrate_enable()?  Along with the KVFREE_BULK_MAX_ENTR check?
> >
> Two woken tasks will be serialized, i.e. an assignment is protected by
> the our local lock. We do krc_this_cpu_lock(flags); as a first step
> right after that we do restore a migration. A migration in that case
> can occur only when krc_this_cpu_unlock(*krcp, *flags); is invoked.
> 
> The scenario you described can happen, in that case a previous bnode
> in the drain list can be either empty or partly utilized. But, again
> i was non able to trigger such scenario.

Ah, we did discuss this previously, and yes, the result for a very
rare race is just underutilization of a page.  With the change below,
the result of this race is instead needless use of the slowpath.

> If we should fix it, i think we can go with below "alloc_in_progress"
> protection:
> 
> <snip>
> urezki@pc638:~/data/raid0/coding/linux-rcu.git$ git diff
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index cad36074366d..95485ec7267e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3488,12 +3488,19 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>         if (!(*krcp)->bkvhead[idx] ||
>                         (*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
>                 bnode = get_cached_bnode(*krcp);
> -               if (!bnode && can_alloc) {
> +               if (!bnode && can_alloc && !(*krcp)->alloc_in_progress)  {
>                         migrate_disable();
> +
> +                       /* Set it before dropping the lock. */
> +                       (*krcp)->alloc_in_progress = true;
>                         krc_this_cpu_unlock(*krcp, *flags);
> +
>                         bnode = (struct kvfree_rcu_bulk_data *)
>                                 __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
>                         *krcp = krc_this_cpu_lock(flags);
> +
> +                       /* Clear it, the lock was taken back. */
> +                       (*krcp)->alloc_in_progress = false;
>                         migrate_enable();
>                 }
>  
> urezki@pc638:~/data/raid0/coding/linux-rcu.git$
> <snip>
> 
> in that case a second task will follow a fallback path bypassing a page
> request. I can send it as a separate patch if there are no any objections.

I was thinking in terms of something like the following.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

static bool add_ptr_to_bulk_krc_no_space(struct kfree_rcu_cpu *krcp)
{
	return !(krcp)->bkvhead[idx] ||
	       (krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR;
}

static inline bool
add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
	unsigned long *flags, void *ptr, bool can_alloc)
{
	struct kvfree_rcu_bulk_data *bnode;
	int idx;

	*krcp = krc_this_cpu_lock(flags);
	if (unlikely(!(*krcp)->initialized))
		return false;

	idx = !!is_vmalloc_addr(ptr);

	/* Check if a new block is required. */
	if (add_ptr_to_bulk_krc_no_space(*krcp)) {
		bnode = get_cached_bnode(*krcp);
		if (!bnode && can_alloc) {
			migrate_disable();
			krc_this_cpu_unlock(*krcp, *flags);
			bnode = (struct kvfree_rcu_bulk_data *)
				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
			*krcp = krc_this_cpu_lock(flags);
			migrate_enable();
		}

		if (!bnode && add_ptr_to_bulk_krc_no_space(*krcp)) {
			return false;
		} else if (bnode && add_ptr_to_bulk_krc_no_space(*krcp))
			/* Initialize the new block. */
			bnode->nr_records = 0;
			bnode->next = (*krcp)->bkvhead[idx];

			/* Attach it to the head. */
			(*krcp)->bkvhead[idx] = bnode;
		} else if (bnode) {
			// Or attempt to add it to the cache?
			free_page((unsigned long)bnode);
		}
	}

	/* Finally insert. */
	(*krcp)->bkvhead[idx]->records
		[(*krcp)->bkvhead[idx]->nr_records++] = ptr;

	return true;
}
