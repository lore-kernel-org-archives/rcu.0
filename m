Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DA6C433E0
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 12:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9CD239EF
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 12:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbhAUMkX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Jan 2021 07:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731344AbhAUMjT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Jan 2021 07:39:19 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD490C061575;
        Thu, 21 Jan 2021 04:38:38 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b26so2272082lff.9;
        Thu, 21 Jan 2021 04:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ateh8R/pigQiU3FBeBMITH3roUoBO98+fhC1CWQEaTY=;
        b=aKMVUjW8EDjPIK+/DGSt0Du4TAIPcuG/FMBZYBzgN0iQW2chArKQJKBOxJzXoT1vPh
         pqlBK+ypI+rAR98MrQs23bgNw3qNEJFMdGvcwYknlfvUikPFfYThH0yfLa70OUuoZ2ZV
         0gfwSKvHv5iKkocYPYnavsHsEWnthtQomtuI0/H9u6hO18etYKC+84gu7afBXczgGfCe
         G6imBQPImIzB+NpUOqa/03EmV/hWZygWGfXS3d1oh5gUjzda0vlhQ7KQBSj5Vzj7GWDo
         18d29CJTrDGrxfHmwJnUHtE1lAT1ZLjXzN/EKRzUA0SG7JgPkt8SiJFNquz8HLF8PKEc
         V6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ateh8R/pigQiU3FBeBMITH3roUoBO98+fhC1CWQEaTY=;
        b=RS9cpS1WyiNDTeWNRKiYjrKapovklhxnCJNkvGyuZWk32lh3P3xhle/o0NeYIiNPNd
         mBiCg715ckzu6xbCJW+8cTj7Dl6AEqIGWOi/LuJc3kGDhSl6hwKeePXynvQl86rV9u2O
         BeBlNSoHAMMhvPeFsD8wDgUZxBwg2wKZ4qig5u5ayR0rMpDZviFTpQHc/cMNDqVI/CUg
         SJ+mDDOtXRHJVKe7ITVEwUNMthpMsgYk5otWKuu/PmDPR3Oidb36q7N9BDhoTkxdYAfL
         scz2KQt7aM9Cn3aSsM1h3OHNfTX90EZUvhpwvapUtkdRbPmhdmLHw8OuCsbLulixBhJl
         WfEw==
X-Gm-Message-State: AOAM530nCFC0bVusCCoFC27TX1/9V4W7UmlDjjcrWvaq3Z5Ht4MGJ3uK
        OyRnMRZiSFH9miW3+FnlY8M=
X-Google-Smtp-Source: ABdhPJwerWKViVNyaNQJWLOpiSADFu+2lZmKLx8dUaClNs/3OUFe2YydFHXRtCelvu0r/1ZIbYA8Qg==
X-Received: by 2002:a05:6512:b12:: with SMTP id w18mr6963453lfu.323.1611232717373;
        Thu, 21 Jan 2021 04:38:37 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id b14sm516102lfi.164.2021.01.21.04.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 04:38:36 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 21 Jan 2021 13:38:34 +0100
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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
Message-ID: <20210121123834.GA1872@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120195757.3lgjrpvmzjvb2nce@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120195757.3lgjrpvmzjvb2nce@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> 
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
> 
__get_free_page() returns "unsigned long" whereas a bnode is a pointer
to kvfree_rcu_bulk_data struct, without a casting the compiler will
emit a warning.

> > +				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> > +			*krcp = krc_this_cpu_lock(flags);
> 
> so if bnode is NULL you could retry get_cached_bnode() since it might
> have been filled (given preemption or CPU migration changed something).
> Judging from patch #3 you think that a CPU migration is a bad thing. But
> why?
> 
I see your point. Indeed we can retry but honestly i do not see that it
makes a lot of sense. I prefer to keep the logic as simple as it can be.
If we are run out of free pages(low memory condition), there is a fallback
mechanism for such purpose, i.e it implies that a slow path can be hit.

>>
>> You think that a CPU migration is a bad thing. But why?
>>
It is not a bad thing. But if it happens we might queue a new bnode
to a drain list of another CPU where a previous element of a new
bnode may be just underutilized. So that is why i use migrate_disable()/enable()
to prevent it.

If there are some hidden issues with migrate_disable()/enable() or you
think it is a bad idea to use it, it would be appreciated if you could
describe your view in more detail.

Thanks for the comments!

--
Vlad Rezki
