Return-Path: <SRS0=4XKx=DI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62244C4727F
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 09:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150AB20B1F
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 09:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n7x2dWCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbgJAJCY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Oct 2020 05:02:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:38692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgJAJCY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Oct 2020 05:02:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601542941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mkmENhVn20bp5HQouxB1eRhh03Q/scwiXHXj9HekMM8=;
        b=n7x2dWCKNJrL3TAdhQqqEHByjrD661TuWjjGzr4rOjPFzMz8cam/FLXe/imoMkcUfZBZSY
        5NCYusaI8IwNqC7nFpL+5JD1zMksBddacwBcC3zxyfMeKcBE4W1Ge7lf3bzAQLKTwsRsIn
        7Vsw96u2eNL5CrYYcpFGInEqvr8TUbI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C1DEAD49;
        Thu,  1 Oct 2020 09:02:21 +0000 (UTC)
Date:   Thu, 1 Oct 2020 11:02:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20201001090220.GA22560@dhcp22.suse.cz>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
 <20200928233102.24265-14-paulmck@kernel.org>
 <20200929120756.GC2277@dhcp22.suse.cz>
 <20200930015327.GX29330@paulmck-ThinkPad-P72>
 <20200930084139.GN2277@dhcp22.suse.cz>
 <20200930232154.GA29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930232154.GA29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 30-09-20 16:21:54, Paul E. McKenney wrote:
> On Wed, Sep 30, 2020 at 10:41:39AM +0200, Michal Hocko wrote:
> > On Tue 29-09-20 18:53:27, Paul E. McKenney wrote:
[...]
> > > No argument on it being confusing, and I hope that the added header
> > > comment helps.  But specifically, can_sleep==true is a promise by the
> > > caller to be schedulable and not to be holding any lock/mutex/whatever
> > > that might possibly be acquired by the memory allocator or by anything
> > > else that the memory allocator might invoke, to your point, including
> > > for but one example the reclaim logic.
> > > 
> > > The only way that can_sleep==true is if this function was invoked due
> > > to a call to single-argument kvfree_rcu(), which must be schedulable
> > > because its fallback is to invoke synchronize_rcu().
> > 
> > OK. I have to say that it is still not clear to me whether this call
> > path can be called from the memory reclaim context. If yes then you need
> > __GFP_NOMEMALLOC as well.
> 
> Right now the restriction is that single-argument (AKA can_sleep==true)
> kvfree_rcu() cannot be invoked from memory reclaim context.
> 
> But would adding __GFP_NOMEMALLOC to the can_sleep==true GFP_ flags
> allow us to remove this restriction?  If so, I will queue a separate
> patch making this change.  The improved ease of use would be well
> worth it, if I understand correctly (ha!!!).

It would be quite daring to claim it will be ok but it will certainly be
less problematic. Adding the flag will not hurt in any case. As this is
a shared called that might be called from many contexts I think it will
be safer to have it there. The justification is that it will prevent
consumption of memory reserves from MEMALLOC contexts.

> 
> > [...]
> > 
> > > > What is the point of calling kmalloc  for a PAGE_SIZE object? Wouldn't
> > > > using the page allocator directly be better?
> > > 
> > > Well, you guys gave me considerable heat about abusing internal allocator
> > > interfaces, and kmalloc() and kfree() seem to be about as non-internal
> > > as you can get and still be invoking the allocator.  ;-)
> > 
> > alloc_pages resp. __get_free_pages is a normal page allocator interface
> > to use for page size granular allocations. kmalloc is for more fine
> > grained allocations.
> 
> OK, in the short term, both work, but I have queued a separate patch
> making this change and recording the tradeoffs.  This is not yet a
> promise to push this patch, but it is a promise not to lose this part
> of the picture.  Please see below.

It doesn't matter all that much. Both allocators will work. It is just a
matter of using optimal tool for the specific purose.

> You mentioned alloc_pages().  I reverted to __get_free_pages(), but
> alloc_pages() of course looks nicer.  What are the tradeoffs between
> __get_free_pages() and alloc_pages()?

alloc_pages will return struct page but you need a kernel pointer. That
is what __get_free_pages will give you (or you can call page_address
directly).

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 490b638d7c241ac06cee168ccf8688bb8b872478
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Sep 30 16:16:39 2020 -0700
> 
>     kvfree_rcu(): Switch from kmalloc/kfree to __get_free_page/free_page.
>     
>     The advantages of using kmalloc() and kfree() are a possible small speedup
>     on CONFIG_SLAB=y systems, avoiding the allocation-side cast, and use of
>     more-familiar API members.  The advantages of using __get_free_page()
>     and free_page() are a possible reduction in fragmentation and direct
>     access to the buddy allocator.
>     
>     To help settle the question as to which to use, this commit switches
>     from kmalloc() and kfree() to __get_free_page() and free_page().
>     
>     Suggested-by: Michal Hocko <mhocko@suse.com>
>     Suggested-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Yes, looks good to me. I am not entirely sure about the fragmentation
argument. It really depends on the SL.B allocator internals. The same
applies for the potential speed up. I would be even surprised if the
SLAB was faster in average considering it has to use the page allocator
as well. So to me the primary motivation would be "use the right tool
for the purpose".

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2886e81..242f0f0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3225,7 +3225,8 @@ static void kfree_rcu_work(struct work_struct *work)
>  				bkvhead[i] = NULL;
>  			krc_this_cpu_unlock(krcp, flags);
>  
> -			kfree(bkvhead[i]);
> +			if (bkvhead[i])
> +				free_page((unsigned long)bkvhead[i]);
>  
>  			cond_resched_tasks_rcu_qs();
>  		}
> @@ -3378,7 +3379,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  		bnode = get_cached_bnode(*krcp);
>  		if (!bnode && can_alloc_page) {
>  			krc_this_cpu_unlock(*krcp, *flags);
> -			bnode = kmalloc(PAGE_SIZE, gfp);
> +			bnode = (struct kvfree_rcu_bulk_data *)__get_free_page(gfp);
>  			*krcp = krc_this_cpu_lock(flags);
>  		}
>  

-- 
Michal Hocko
SUSE Labs
