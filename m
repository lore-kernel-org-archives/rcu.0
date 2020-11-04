Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6332FC388F7
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 11:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0751A2236F
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 11:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8WEpwn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgKDLjh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Nov 2020 06:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgKDLjg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Nov 2020 06:39:36 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156F4C0613D3;
        Wed,  4 Nov 2020 03:39:36 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id i6so26734186lfd.1;
        Wed, 04 Nov 2020 03:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jLMKc6I+EbQJCBgjBJI2KY+v34084Ns2D+3OvtBodnI=;
        b=n8WEpwn/ilb+6F5Ph+Y3gmqJL6KdIMCgNC7YqRl6aaBVV0c8ZvQ0eg8MwC/HE50qhd
         u4D3g5juoM/5//EZ8in3EC8pmjxScUnWZYsw4LvN+mf01KsAZHqZiqZC6fNhISN61gLF
         lUQhDwv+KUoszKHXO0KC/W/PXA2t7JlA76wfDESPj/CXFYcpNjDcT2eK5JU31ErvvCq+
         PSuBtNhcqNNkCXEFe1iWN1u6O1Hdl1zZrH94Qjj40Dp8xwU6RqKrc71DzC089iqlIMqG
         UM+gpnYDIkUBRLsC50jgC+Bubb5va884SJEC9Y+/X2Sf+vVDunNyOIFLrDbka0JMRAkt
         QNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jLMKc6I+EbQJCBgjBJI2KY+v34084Ns2D+3OvtBodnI=;
        b=rlYua7zRVJDUOmH4XlV9gWyJKtplNJfFgPejPpVDHFJIh+Pg+I9aojGQ75YFY2rB1w
         u3Kv6Way+vbaVNdxmxeRo3vP5zoO+6B7bm2HCyBh8oF37H5iTRE1l2yzMgw3S+Yd28vb
         CgqX5K7KzIkUjWQ4Qvb0DS112esMmTWcOqyXUSE93bPFKKvjDEXkvEC6v8QbLjtSmna/
         WMxHNFPmmv8gJn/oiaYu9hI8U05d2opuhE2B+j441XxiQ6s5qPLS2rYRSbalQHVcs/vl
         1yEu8IcbWVMnV/FOiiPrJuUVRPRGpD4PsVYPIUS3LMJA+8IMjkObrfbBWdkoNLaSN3wx
         AJWg==
X-Gm-Message-State: AOAM5305e7HrTBlXd38F7ziVEgrfX3cjZxRyboYgN4c0vnz+0ht/uyHq
        YvkHCzN21OtQwZF1Q6oy98k=
X-Google-Smtp-Source: ABdhPJxRAlqT2V2Jkkz44Cesa9bhxikRbK2ADSVQf9WHA6CiqKQgavoNueTH3Mh+MG2Tg/m559fzuA==
X-Received: by 2002:a19:ef09:: with SMTP id n9mr10530507lfh.334.1604489974520;
        Wed, 04 Nov 2020 03:39:34 -0800 (PST)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id j207sm381875lfj.122.2020.11.04.03.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 03:39:33 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 4 Nov 2020 12:39:31 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 15/16] rcu/tree: Allocate a page when caller is
 preemptible
Message-ID: <20201104113931.GA17782@pc636>
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201029165019.14218-15-urezki@gmail.com>
 <20201103180316.GC1310511@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103180316.GC1310511@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Joel.

> 
> On Thu, Oct 29, 2020 at 05:50:18PM +0100, Uladzislau Rezki (Sony) wrote:
> > Given that CONFIG_PREEMPT_COUNT is unconditionally enabled by the
> > earlier commits in this series, the preemptible() macro now properly
> > detects preempt-disable code regions even in kernels built with
> > CONFIG_PREEMPT_NONE.
> > 
> > This commit therefore uses preemptible() to determine whether allocation
> > is possible at all for double-argument kvfree_rcu().  If !preemptible(),
> > then allocation is not possible, and kvfree_rcu() falls back to using
> > the less cache-friendly rcu_head approach.  Even when preemptible(),
> > the caller might be involved in reclaim, so the GFP_ flags used by
> > double-argument kvfree_rcu() must avoid invoking reclaim processing.
> > 
> > Note that single-argument kvfree_rcu() must be invoked in sleepable
> > contexts, and that its fallback is the relatively high latency
> > synchronize_rcu().  Single-argument kvfree_rcu() therefore uses
> > GFP_KERNEL|__GFP_RETRY_MAYFAIL to allow limited sleeping within the
> > memory allocator.
> > 
> > [ paulmck: Add add_ptr_to_bulk_krc_lock header comment per Michal Hocko. ]
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 48 ++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 31 insertions(+), 17 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index f2da2a1cc716..3f9b016a44dc 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3406,37 +3406,55 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> >  	}
> >  }
> >  
> > +// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
> > +// state specified by flags.  If can_sleep is true, the caller must
> > +// be schedulable and not be holding any locks or mutexes that might be
> > +// acquired by the memory allocator or anything that it might invoke.
> > +// If !can_sleep, then if !preemptible() no allocation will be undertaken,
> > +// otherwise the allocation will use GFP_ATOMIC to avoid the remainder of
> > +// the aforementioned deadlock possibilities.  Returns true if ptr was
> > +// successfully recorded, else the caller must use a fallback.
> >  static inline bool
> > -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > +add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> > +	unsigned long *flags, void *ptr, bool can_sleep)
> >  {
> >  	struct kvfree_rcu_bulk_data *bnode;
> > +	bool can_alloc_page = preemptible();
> > +	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL :
> > +		GFP_ATOMIC) | __GFP_NOWARN;
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
> 
> Maybe convert this comment also to //... like the new ones you added (and the
> ones below).
> 
No, problem. I can convert it.

> > -	if (!krcp->bkvhead[idx] ||
> > -			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > -		bnode = get_cached_bnode(krcp);
> > -		/* Switch to emergency path. */
> > +	if (!(*krcp)->bkvhead[idx] ||
> > +			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > +		bnode = get_cached_bnode(*krcp);
> > +		if (!bnode && can_alloc_page) {
> 
> I think you can directly put preemptible() here with a comment saying
> allocate only if preemptible and get rid of can_alloc_page.
> 
Not really. We check preemtable() before acquiring the internal lock,
otherwise it will always return "false". Thus, it is checked on the
entry in the beginning.

> > +			krc_this_cpu_unlock(*krcp, *flags);
> > +			bnode = (struct kvfree_rcu_bulk_data *)
> > +				__get_free_page(gfp);
> > +			*krcp = krc_this_cpu_lock(flags);
> > +		}
> > +
> 
> I think the "Switch to emergency path" comment should stay here before the
> if().
> 
Right. We need to keep it. Will take it back.

--
Vlad Rezki
