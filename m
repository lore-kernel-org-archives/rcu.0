Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C9AC4741F
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 23:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE520206F4
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601508147;
	bh=duBLPQvxBptb43fIQLQ12wY3eNwbo2Do/jJyhHozeUM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OWxdai7GQnOJjLut/oykrwU9P4mjPKJJtdbjYJo//rVF7w/uK9a0NNFXq2X+TzUcg
	 xtYW4QDh6oO2hgnmUsRinIkVSC7n0HqILNjjzZFdMRJ+yTV6gy5zFogbXx+UMVrQZP
	 REDsTq7UnKGoSMa7Pn7dPsbZI/TQu5IgL9xSTpdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbgI3XWU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731255AbgI3XVz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 19:21:55 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79D5206F4;
        Wed, 30 Sep 2020 23:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601508114;
        bh=duBLPQvxBptb43fIQLQ12wY3eNwbo2Do/jJyhHozeUM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KoOkjI1GF/pOSo0R++TWIyd9yKaT3KkwoC3FKeRKFADO1qTWyeZxlAPzBWcxnJ1Fq
         TylWRvJ1endoyEhUtLnOVxCkdPPPcGHp52T+pjJSOBL87CJm1KP/RsDP0ENIP9zF26
         YKaC/LnmyIFezzIDk55upoudXt72JYe45cZR1Te4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8F2C7352303F; Wed, 30 Sep 2020 16:21:54 -0700 (PDT)
Date:   Wed, 30 Sep 2020 16:21:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 14/15] rcu/tree: Allocate a page when caller
 is preemptible
Message-ID: <20200930232154.GA29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
 <20200928233102.24265-14-paulmck@kernel.org>
 <20200929120756.GC2277@dhcp22.suse.cz>
 <20200930015327.GX29330@paulmck-ThinkPad-P72>
 <20200930084139.GN2277@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930084139.GN2277@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 30, 2020 at 10:41:39AM +0200, Michal Hocko wrote:
> On Tue 29-09-20 18:53:27, Paul E. McKenney wrote:
> > On Tue, Sep 29, 2020 at 02:07:56PM +0200, Michal Hocko wrote:
> > > On Mon 28-09-20 16:31:01, paulmck@kernel.org wrote:
> > > [...]
> > 
> > Apologies for the delay, but today has not been boring.
> > 
> > > > This commit therefore uses preemptible() to determine whether allocation
> > > > is possible at all for double-argument kvfree_rcu().
> > > 
> > > This deserves a comment. Because GFP_ATOMIC is possible for many
> > > !preemptible() contexts. It is the raw_spin_lock, NMIs and likely few
> > > others that are a problem. You are taking a conservative approach which
> > > is fine but it would be good to articulate that explicitly.
> > 
> > Good point, and so I have added the following as a header comment to
> > the add_ptr_to_bulk_krc_lock() function:
> > 
> > // Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
> > // state specified by flags.  If can_sleep is true, the caller must
> > // be schedulable and not be holding any locks or mutexes that might be
> > // acquired by the memory allocator or anything that it might invoke.
> > // If !can_sleep, then if !preemptible() no allocation will be undertaken,
> > // otherwise the allocation will use GFP_ATOMIC to avoid the remainder of
> > // the aforementioned deadlock possibilities.  Returns true iff ptr was
> > // successfully recorded, else the caller must use a fallback.
> 
> OK, not trivial to follow but at least verbose enough to understand the
> intention after some mulling. Definitely an improvement, thanks!

Glad it helped!  With some luck, perhaps it will improve with time...

> [...]
> > > > -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > > +add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> > > > +	unsigned long *flags, void *ptr, bool can_sleep)
> > > >  {
> > > >  	struct kvfree_rcu_bulk_data *bnode;
> > > > +	bool can_alloc_page = preemptible();
> > > > +	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL : GFP_ATOMIC) | __GFP_NOWARN;
> > > 
> > > This is quite confusing IMHO. At least without a further explanation.
> > > can_sleep is not as much about sleeping as it is about the reclaim
> > > recursion AFAIU your changelog, right?
> > 
> > No argument on it being confusing, and I hope that the added header
> > comment helps.  But specifically, can_sleep==true is a promise by the
> > caller to be schedulable and not to be holding any lock/mutex/whatever
> > that might possibly be acquired by the memory allocator or by anything
> > else that the memory allocator might invoke, to your point, including
> > for but one example the reclaim logic.
> > 
> > The only way that can_sleep==true is if this function was invoked due
> > to a call to single-argument kvfree_rcu(), which must be schedulable
> > because its fallback is to invoke synchronize_rcu().
> 
> OK. I have to say that it is still not clear to me whether this call
> path can be called from the memory reclaim context. If yes then you need
> __GFP_NOMEMALLOC as well.

Right now the restriction is that single-argument (AKA can_sleep==true)
kvfree_rcu() cannot be invoked from memory reclaim context.

But would adding __GFP_NOMEMALLOC to the can_sleep==true GFP_ flags
allow us to remove this restriction?  If so, I will queue a separate
patch making this change.  The improved ease of use would be well
worth it, if I understand correctly (ha!!!).

> [...]
> 
> > > What is the point of calling kmalloc  for a PAGE_SIZE object? Wouldn't
> > > using the page allocator directly be better?
> > 
> > Well, you guys gave me considerable heat about abusing internal allocator
> > interfaces, and kmalloc() and kfree() seem to be about as non-internal
> > as you can get and still be invoking the allocator.  ;-)
> 
> alloc_pages resp. __get_free_pages is a normal page allocator interface
> to use for page size granular allocations. kmalloc is for more fine
> grained allocations.

OK, in the short term, both work, but I have queued a separate patch
making this change and recording the tradeoffs.  This is not yet a
promise to push this patch, but it is a promise not to lose this part
of the picture.  Please see below.

You mentioned alloc_pages().  I reverted to __get_free_pages(), but
alloc_pages() of course looks nicer.  What are the tradeoffs between
__get_free_pages() and alloc_pages()?

							Thanx, Paul

------------------------------------------------------------------------

commit 490b638d7c241ac06cee168ccf8688bb8b872478
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Sep 30 16:16:39 2020 -0700

    kvfree_rcu(): Switch from kmalloc/kfree to __get_free_page/free_page.
    
    The advantages of using kmalloc() and kfree() are a possible small speedup
    on CONFIG_SLAB=y systems, avoiding the allocation-side cast, and use of
    more-familiar API members.  The advantages of using __get_free_page()
    and free_page() are a possible reduction in fragmentation and direct
    access to the buddy allocator.
    
    To help settle the question as to which to use, this commit switches
    from kmalloc() and kfree() to __get_free_page() and free_page().
    
    Suggested-by: Michal Hocko <mhocko@suse.com>
    Suggested-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2886e81..242f0f0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3225,7 +3225,8 @@ static void kfree_rcu_work(struct work_struct *work)
 				bkvhead[i] = NULL;
 			krc_this_cpu_unlock(krcp, flags);
 
-			kfree(bkvhead[i]);
+			if (bkvhead[i])
+				free_page((unsigned long)bkvhead[i]);
 
 			cond_resched_tasks_rcu_qs();
 		}
@@ -3378,7 +3379,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 		bnode = get_cached_bnode(*krcp);
 		if (!bnode && can_alloc_page) {
 			krc_this_cpu_unlock(*krcp, *flags);
-			bnode = kmalloc(PAGE_SIZE, gfp);
+			bnode = (struct kvfree_rcu_bulk_data *)__get_free_page(gfp);
 			*krcp = krc_this_cpu_lock(flags);
 		}
 
