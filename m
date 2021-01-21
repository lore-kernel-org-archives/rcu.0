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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758A4C433DB
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 14:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFED239A4
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 14:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbhAUOAw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Jan 2021 09:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732526AbhAUNfy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Jan 2021 08:35:54 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C101C0613C1;
        Thu, 21 Jan 2021 05:35:14 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id b10so2487265ljp.6;
        Thu, 21 Jan 2021 05:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d8KFOAYCe2M2B/sWPksccHsHRhmRN1V3CQDzS2MrRJE=;
        b=K1nwmPzPDRUGsiApvGyQ5IiVLyODV7bMQhWpJMhW6xD02kuCepq52jFvoq2Ny2juaL
         EJBh3bUAfl8UM1QBuY9CjtKFtuzisxiDM2v8dxNV4IBRc9wSoUYD7p9ogMwg18qqX6HL
         zXkSPC8DGCNuzimjxaYQQz1+CT4B/DZ9L0KYlJI3F0KV42hLd0CdcoIZDsRxjOaGMQKo
         7CkuA/ZG4k5fLplKnRFB+pARb5yA/NRKC9oy5AbYkeDgdzuJzSrSPB9muZeZFwCbQ6/3
         UJZPmihLVPU4qPln8W+OoW1l3WNPpzxL9FKPFgnnU1KD10VvF9ZcMqPTN+7z9Io2KdbT
         b4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d8KFOAYCe2M2B/sWPksccHsHRhmRN1V3CQDzS2MrRJE=;
        b=M+z//TPxZm2onwtnWlsWnmgoMGcLGVEOy4t8NLvZssHOC7AAxuu3Pg+0aeYjITNHPf
         KA6kBQsGFR+CePdAmD8MCwmpHdg5ywV0nvR3BIttdKpbDud8RtuO9INy2ww4Dq09qVn6
         XpPAkebiDJu/X3Br3sIKAICSX8CLJlaXv1HGTmE52ObyKhK5/elh7ct9+Avai4kXxvGP
         n+sirLgH8v6J+29ByTowsPv63rwMOZOKs1fzG94f41PFX83EsqtPlb6QYRGq3zGOedR0
         CMhmh9gjsHn12WhOsqRjx6wVyWGLTDRgs6prXR5RqYxFG5gbhSKZET7jACtoGcKe5Qgf
         w6vg==
X-Gm-Message-State: AOAM532+A/IPEdy7tgVz01dT5153FRrqQN0jf+sBqrXEZmL2ZPFv/Rkv
        97vUAnvrxeU+rp+zS9OUeQw=
X-Google-Smtp-Source: ABdhPJxlo17L4ZxY+xa2p3jjXlhbFwU5HSQDwSGFJ/L/BHKFefxm1GcN12FSt7kGoxFvZJQDYLV1Xw==
X-Received: by 2002:a2e:9084:: with SMTP id l4mr6696460ljg.375.1611236112804;
        Thu, 21 Jan 2021 05:35:12 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t9sm531397lff.45.2021.01.21.05.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 05:35:12 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 21 Jan 2021 14:35:10 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
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
Message-ID: <20210121133510.GB1872@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120195757.3lgjrpvmzjvb2nce@linutronix.de>
 <20210120215403.GH2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120215403.GH2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 20, 2021 at 01:54:03PM -0800, Paul E. McKenney wrote:
> On Wed, Jan 20, 2021 at 08:57:57PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2021-01-20 17:21:46 [+0100], Uladzislau Rezki (Sony) wrote:
> > > For a single argument we can directly request a page from a caller
> > > context when a "carry page block" is run out of free spots. Instead
> > > of hitting a slow path we can request an extra page by demand and
> > > proceed with a fast path.
> > > 
> > > A single-argument kvfree_rcu() must be invoked in sleepable contexts,
> > > and that its fallback is the relatively high latency synchronize_rcu().
> > > Single-argument kvfree_rcu() therefore uses GFP_KERNEL|__GFP_RETRY_MAYFAIL
> > > to allow limited sleeping within the memory allocator.
> > > 
> > > [ paulmck: Add add_ptr_to_bulk_krc_lock header comment per Michal Hocko. ]
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/rcu/tree.c | 42 ++++++++++++++++++++++++++----------------
> > >  1 file changed, 26 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index e04e336bee42..2014fb22644d 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3465,37 +3465,50 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> > >  	}
> > >  }
> > >  
> > > +// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
> > > +// state specified by flags.  If can_alloc is true, the caller must
> > > +// be schedulable and not be holding any locks or mutexes that might be
> > > +// acquired by the memory allocator or anything that it might invoke.
> > > +// Returns true if ptr was successfully recorded, else the caller must
> > > +// use a fallback.
> > 
> > The whole RCU department is getting swamped by the // comments. Can't we
> > have proper kernel doc and /* */ style comments like the remaining part
> > of the kernel?
> 
> Because // comments are easier to type and take up less horizontal space.
> Also, this kvfree_call_rcu_add_ptr_to_bulk() function is local to
> kvfree_rcu(), and we don't normally docbook-ify such functions.
> 
> > >  static inline bool
> > > -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > +add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> > > +	unsigned long *flags, void *ptr, bool can_alloc)
> > >  {
> > >  	struct kvfree_rcu_bulk_data *bnode;
> > >  	int idx;
> > >  
> > > -	if (unlikely(!krcp->initialized))
> > > +	*krcp = krc_this_cpu_lock(flags);
> > > +	if (unlikely(!(*krcp)->initialized))
> > >  		return false;
> > >  
> > > -	lockdep_assert_held(&krcp->lock);
> > >  	idx = !!is_vmalloc_addr(ptr);
> > >  
> > >  	/* Check if a new block is required. */
> > > -	if (!krcp->bkvhead[idx] ||
> > > -			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > > -		bnode = get_cached_bnode(krcp);
> > > -		/* Switch to emergency path. */
> > > +	if (!(*krcp)->bkvhead[idx] ||
> > > +			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> > > +		bnode = get_cached_bnode(*krcp);
> > > +		if (!bnode && can_alloc) {
> > > +			krc_this_cpu_unlock(*krcp, *flags);
> > > +			bnode = (struct kvfree_rcu_bulk_data *)
> > 
> > There is no need for this cast.
> 
> Without it, gcc version 7.5.0 says:
> 
> 	warning: assignment makes pointer from integer without a cast
> 
> > > +				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> > > +			*krcp = krc_this_cpu_lock(flags);
> > 
> > so if bnode is NULL you could retry get_cached_bnode() since it might
> > have been filled (given preemption or CPU migration changed something).
> > Judging from patch #3 you think that a CPU migration is a bad thing. But
> > why?
> 
> So that the later "(*krcp)->bkvhead[idx] = bnode" assignment associates
> it with the correct CPU.
> 
> Though now that you mention it, couldn't the following happen?
> 
> o	Task A on CPU 0 notices that allocation is needed, so it
> 	drops the lock disables migration, and sleeps while
> 	allocating.
> 
> o	Task B on CPU 0 does the same.
> 
> o	The two tasks wake up in some order, and the second one
> 	causes trouble at the "(*krcp)->bkvhead[idx] = bnode"
> 	assignment.
> 
> Uladzislau, do we need to recheck "!(*krcp)->bkvhead[idx]" just after
> the migrate_enable()?  Along with the KVFREE_BULK_MAX_ENTR check?
> 
Probably i should have mentioned your sequence you described, that two tasks
can get a page on same CPU, i was thinking about it :) Yep, it can happen
since we drop the lock and a context is fully preemptible, so another one
can trigger kvfree_rcu() ending up at the same place - entering a page
allocator.

I spent some time simulating it, but with no any luck, therefore i did not
reflect this case in the commit message, thus did no pay much attention to
such scenario.

>
> Uladzislau, do we need to recheck "!(*krcp)->bkvhead[idx]" just after
> the migrate_enable()?  Along with the KVFREE_BULK_MAX_ENTR check?
>
Two woken tasks will be serialized, i.e. an assignment is protected by
the our local lock. We do krc_this_cpu_lock(flags); as a first step
right after that we do restore a migration. A migration in that case
can occur only when krc_this_cpu_unlock(*krcp, *flags); is invoked.

The scenario you described can happen, in that case a previous bnode
in the drain list can be either empty or partly utilized. But, again
i was non able to trigger such scenario.

If we should fix it, i think we can go with below "alloc_in_progress"
protection:

<snip>
urezki@pc638:~/data/raid0/coding/linux-rcu.git$ git diff
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cad36074366d..95485ec7267e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3488,12 +3488,19 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
        if (!(*krcp)->bkvhead[idx] ||
                        (*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
                bnode = get_cached_bnode(*krcp);
-               if (!bnode && can_alloc) {
+               if (!bnode && can_alloc && !(*krcp)->alloc_in_progress)  {
                        migrate_disable();
+
+                       /* Set it before dropping the lock. */
+                       (*krcp)->alloc_in_progress = true;
                        krc_this_cpu_unlock(*krcp, *flags);
+
                        bnode = (struct kvfree_rcu_bulk_data *)
                                __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
                        *krcp = krc_this_cpu_lock(flags);
+
+                       /* Clear it, the lock was taken back. */
+                       (*krcp)->alloc_in_progress = false;
                        migrate_enable();
                }
 
urezki@pc638:~/data/raid0/coding/linux-rcu.git$
<snip>

in that case a second task will follow a fallback path bypassing a page
request. I can send it as a separate patch if there are no any objections.

--
Vlad Rezki
