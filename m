Return-Path: <SRS0=j702=DH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEC9C4727F
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 08:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7763E206D4
	for <rcu@archiver.kernel.org>; Wed, 30 Sep 2020 08:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BB1G0Pjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgI3Ilx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Sep 2020 04:41:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:41804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgI3Ilx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Sep 2020 04:41:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601455310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gwGgMRR34sznVsdus5CtHuBnVhfV73MLfqJxGlaOrwU=;
        b=BB1G0PjroOEwFKoOVkvbCSuD7UNEL7i5xYleWMjhioIukbpxTB74hbDaohh0IOiImUStD7
        QwPoxkkGoMW+cjdGlpyHm+wl9AZB7czhyvWAe7gKCLHEvEiA2n/Xqp1/MY0xB8OwUTx3YA
        6HzNGOiKeyOeoz1XEczQlExBaDhnFcE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A170CAB0E;
        Wed, 30 Sep 2020 08:41:50 +0000 (UTC)
Date:   Wed, 30 Sep 2020 10:41:39 +0200
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
Message-ID: <20200930084139.GN2277@dhcp22.suse.cz>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
 <20200928233102.24265-14-paulmck@kernel.org>
 <20200929120756.GC2277@dhcp22.suse.cz>
 <20200930015327.GX29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930015327.GX29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue 29-09-20 18:53:27, Paul E. McKenney wrote:
> On Tue, Sep 29, 2020 at 02:07:56PM +0200, Michal Hocko wrote:
> > On Mon 28-09-20 16:31:01, paulmck@kernel.org wrote:
> > [...]
> 
> Apologies for the delay, but today has not been boring.
> 
> > > This commit therefore uses preemptible() to determine whether allocation
> > > is possible at all for double-argument kvfree_rcu().
> > 
> > This deserves a comment. Because GFP_ATOMIC is possible for many
> > !preemptible() contexts. It is the raw_spin_lock, NMIs and likely few
> > others that are a problem. You are taking a conservative approach which
> > is fine but it would be good to articulate that explicitly.
> 
> Good point, and so I have added the following as a header comment to
> the add_ptr_to_bulk_krc_lock() function:
> 
> // Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
> // state specified by flags.  If can_sleep is true, the caller must
> // be schedulable and not be holding any locks or mutexes that might be
> // acquired by the memory allocator or anything that it might invoke.
> // If !can_sleep, then if !preemptible() no allocation will be undertaken,
> // otherwise the allocation will use GFP_ATOMIC to avoid the remainder of
> // the aforementioned deadlock possibilities.  Returns true iff ptr was
> // successfully recorded, else the caller must use a fallback.

OK, not trivial to follow but at least verbose enough to understand the
intention after some mulling. Definitely an improvement, thanks!

[...]
> > > -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > +add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> > > +	unsigned long *flags, void *ptr, bool can_sleep)
> > >  {
> > >  	struct kvfree_rcu_bulk_data *bnode;
> > > +	bool can_alloc_page = preemptible();
> > > +	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL : GFP_ATOMIC) | __GFP_NOWARN;
> > 
> > This is quite confusing IMHO. At least without a further explanation.
> > can_sleep is not as much about sleeping as it is about the reclaim
> > recursion AFAIU your changelog, right?
> 
> No argument on it being confusing, and I hope that the added header
> comment helps.  But specifically, can_sleep==true is a promise by the
> caller to be schedulable and not to be holding any lock/mutex/whatever
> that might possibly be acquired by the memory allocator or by anything
> else that the memory allocator might invoke, to your point, including
> for but one example the reclaim logic.
> 
> The only way that can_sleep==true is if this function was invoked due
> to a call to single-argument kvfree_rcu(), which must be schedulable
> because its fallback is to invoke synchronize_rcu().

OK. I have to say that it is still not clear to me whether this call
path can be called from the memory reclaim context. If yes then you need
__GFP_NOMEMALLOC as well.

[...]

> > What is the point of calling kmalloc  for a PAGE_SIZE object? Wouldn't
> > using the page allocator directly be better?
> 
> Well, you guys gave me considerable heat about abusing internal allocator
> interfaces, and kmalloc() and kfree() seem to be about as non-internal
> as you can get and still be invoking the allocator.  ;-)

alloc_pages resp. __get_free_pages is a normal page allocator interface
to use for page size granular allocations. kmalloc is for more fine
grained allocations.
-- 
Michal Hocko
SUSE Labs
