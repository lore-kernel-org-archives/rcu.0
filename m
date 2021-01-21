Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B65C433DB
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 19:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCF423136
	for <rcu@archiver.kernel.org>; Thu, 21 Jan 2021 19:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbhAUTTM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Jan 2021 14:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbhAUTSd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Jan 2021 14:18:33 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CEAC061756;
        Thu, 21 Jan 2021 11:17:52 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v24so4109018lfr.7;
        Thu, 21 Jan 2021 11:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H9aZKC/pDE3mvANpGosd9UN2M4W2cDqH5ujfgp0p6Q8=;
        b=AcMrXXF+hZqM4XsW0qMddc0WSTAWlY6+CR+pU93g5miyEKMaUFQ4y4NTf5XlAUNEho
         /sjq2pN8j7DDR/LG2jpwaqxaIGqtdUN5cFvDB5iDcVWDeGQgBptAaymGRVvXGYSEnLgE
         Fsxbxll7o13jfnib9iU6i6VNA1I8H7935dGGnNEFvKBkae+R/Ma5NY0j2w3sCeEjsRoa
         LAWCmpj+Oqn66KvQmCqaGqK9tfxPFjlgW0FGbFYikDcAzxwupPnwaZV7Vd9MqOybjOkH
         +TcmIAgPadgmlU5Rvb2NlnXIMA9Tt7xWIiVwtLl0USGqXpFQvsxK/FtheJwoLBBfPE1I
         yswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H9aZKC/pDE3mvANpGosd9UN2M4W2cDqH5ujfgp0p6Q8=;
        b=WFiIyFYXUhARLMdoL8CyXsoce+Dws7/vIA2JR6gltrwK90rrnqIP0FAsOpnDqgTbsS
         PFl/D4NhRLw62xbvfkrNgsQaAAFofwIMGhC81dFyRNqRPppQpMNL3pe+odD10sUmVuEZ
         Xmv3surrr+3vwRdN2BumkZb6iL5K4xotk+dxoYT77gKi/o1PcVEE+IXXpah5m4dhrsC6
         xJweBeiIASBHRSeYTgtY6rGoDDojD14bPQEd35pvjWiMVKaqDBl35VzBLUIIxcKFzJpD
         yFrf+8LJW7xslHvW1e3PnPWxCQiq1uW9JIpiT0359qs6HIKyPMg269hxwofvvF1o74fW
         WU9w==
X-Gm-Message-State: AOAM532FmZ8hmdzeSoEDDP3YOYImVljXMzLQChTxFEFTgHjmGxiFYL+Y
        L7i9qT9GIN7wPPTE45h/36k=
X-Google-Smtp-Source: ABdhPJw7pB5OqwbIqbqfo3Sx3jCbev9l8f/CdcQovNL6QZ0KCHI9N+mxu6QCVC3PVdb3yM6DmJCIpA==
X-Received: by 2002:a19:6453:: with SMTP id b19mr307548lfj.527.1611256670953;
        Thu, 21 Jan 2021 11:17:50 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id s10sm616960lfs.169.2021.01.21.11.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:17:50 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 21 Jan 2021 20:17:48 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <20210121191748.GA2454@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120195757.3lgjrpvmzjvb2nce@linutronix.de>
 <20210120215403.GH2743@paulmck-ThinkPad-P72>
 <20210121133510.GB1872@pc638.lan>
 <20210121150740.GO2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121150740.GO2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 21, 2021 at 07:07:40AM -0800, Paul E. McKenney wrote:
> On Thu, Jan 21, 2021 at 02:35:10PM +0100, Uladzislau Rezki wrote:
> > On Wed, Jan 20, 2021 at 01:54:03PM -0800, Paul E. McKenney wrote:
> > > On Wed, Jan 20, 2021 at 08:57:57PM +0100, Sebastian Andrzej Siewior wrote:
> 
> [ . . . ]
> 
> > > > so if bnode is NULL you could retry get_cached_bnode() since it might
> > > > have been filled (given preemption or CPU migration changed something).
> > > > Judging from patch #3 you think that a CPU migration is a bad thing. But
> > > > why?
> > > 
> > > So that the later "(*krcp)->bkvhead[idx] = bnode" assignment associates
> > > it with the correct CPU.
> > > 
> > > Though now that you mention it, couldn't the following happen?
> > > 
> > > o	Task A on CPU 0 notices that allocation is needed, so it
> > > 	drops the lock disables migration, and sleeps while
> > > 	allocating.
> > > 
> > > o	Task B on CPU 0 does the same.
> > > 
> > > o	The two tasks wake up in some order, and the second one
> > > 	causes trouble at the "(*krcp)->bkvhead[idx] = bnode"
> > > 	assignment.
> > > 
> > > Uladzislau, do we need to recheck "!(*krcp)->bkvhead[idx]" just after
> > > the migrate_enable()?  Along with the KVFREE_BULK_MAX_ENTR check?
> > > 
> > Probably i should have mentioned your sequence you described, that two tasks
> > can get a page on same CPU, i was thinking about it :) Yep, it can happen
> > since we drop the lock and a context is fully preemptible, so another one
> > can trigger kvfree_rcu() ending up at the same place - entering a page
> > allocator.
> > 
> > I spent some time simulating it, but with no any luck, therefore i did not
> > reflect this case in the commit message, thus did no pay much attention to
> > such scenario.
> > 
> > >
> > > Uladzislau, do we need to recheck "!(*krcp)->bkvhead[idx]" just after
> > > the migrate_enable()?  Along with the KVFREE_BULK_MAX_ENTR check?
> > >
> > Two woken tasks will be serialized, i.e. an assignment is protected by
> > the our local lock. We do krc_this_cpu_lock(flags); as a first step
> > right after that we do restore a migration. A migration in that case
> > can occur only when krc_this_cpu_unlock(*krcp, *flags); is invoked.
> > 
> > The scenario you described can happen, in that case a previous bnode
> > in the drain list can be either empty or partly utilized. But, again
> > i was non able to trigger such scenario.
> 
> Ah, we did discuss this previously, and yes, the result for a very
> rare race is just underutilization of a page.  With the change below,
> the result of this race is instead needless use of the slowpath.
> 
> > If we should fix it, i think we can go with below "alloc_in_progress"
> > protection:
> > 
> > <snip>
> > urezki@pc638:~/data/raid0/coding/linux-rcu.git$ git diff
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index cad36074366d..95485ec7267e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3488,12 +3488,19 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> >         if (!(*krcp)->bkvhead[idx] ||
> >                         (*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> >                 bnode = get_cached_bnode(*krcp);
> > -               if (!bnode && can_alloc) {
> > +               if (!bnode && can_alloc && !(*krcp)->alloc_in_progress)  {
> >                         migrate_disable();
> > +
> > +                       /* Set it before dropping the lock. */
> > +                       (*krcp)->alloc_in_progress = true;
> >                         krc_this_cpu_unlock(*krcp, *flags);
> > +
> >                         bnode = (struct kvfree_rcu_bulk_data *)
> >                                 __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
> >                         *krcp = krc_this_cpu_lock(flags);
> > +
> > +                       /* Clear it, the lock was taken back. */
> > +                       (*krcp)->alloc_in_progress = false;
> >                         migrate_enable();
> >                 }
> >  
> > urezki@pc638:~/data/raid0/coding/linux-rcu.git$
> > <snip>
> > 
> > in that case a second task will follow a fallback path bypassing a page
> > request. I can send it as a separate patch if there are no any objections.
> 
> I was thinking in terms of something like the following.  Thoughts?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> static bool add_ptr_to_bulk_krc_no_space(struct kfree_rcu_cpu *krcp)
> {
> 	return !(krcp)->bkvhead[idx] ||
> 	       (krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR;
> }
>
Agree we should have such wrapper. So the code becomes more readable and
simpler.

> 
> static inline bool
> add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> 	unsigned long *flags, void *ptr, bool can_alloc)
> {
> 	struct kvfree_rcu_bulk_data *bnode;
> 	int idx;
> 
> 	*krcp = krc_this_cpu_lock(flags);
> 	if (unlikely(!(*krcp)->initialized))
> 		return false;
> 
> 	idx = !!is_vmalloc_addr(ptr);
> 
> 	/* Check if a new block is required. */
> 	if (add_ptr_to_bulk_krc_no_space(*krcp)) {
> 		bnode = get_cached_bnode(*krcp);
> 		if (!bnode && can_alloc) {
> 			migrate_disable();
> 			krc_this_cpu_unlock(*krcp, *flags);
> 			bnode = (struct kvfree_rcu_bulk_data *)
> 				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
> 			*krcp = krc_this_cpu_lock(flags);
> 			migrate_enable();
> 		}
> 
> 		if (!bnode && add_ptr_to_bulk_krc_no_space(*krcp)) {
> 			return false;
> 		} else if (bnode && add_ptr_to_bulk_krc_no_space(*krcp))
> 			/* Initialize the new block. */
> 			bnode->nr_records = 0;
> 			bnode->next = (*krcp)->bkvhead[idx];
> 
> 			/* Attach it to the head. */
> 			(*krcp)->bkvhead[idx] = bnode;
> 		} else if (bnode) {
> 			// Or attempt to add it to the cache?
> 			free_page((unsigned long)bnode);
> 		}
> 	}
> 
> 	/* Finally insert. */
> 	(*krcp)->bkvhead[idx]->records
> 		[(*krcp)->bkvhead[idx]->nr_records++] = ptr;
> 
> 	return true;
> }
I see your point. But i do not see how it solves double/more entering to page
allocator by two tasks or maybe more :)

Yep, comparing with the flag i proposed, this approach will not likely hit a
slow path in pretty rare case, from the other hand we need to do something with
an extra page. We can not simply free it in a current context. We should at
least drop the lock again and then free.

Adding to the cache will require an extra decay logic. The simplest scenario
is to attach that extra block to the drain list. If we attach or free
the behaviour becomes almost the same as the patch #3 - kvfree_rcu: use migrate_disable/enable()

Thoughts?

--
Vlad Rezki
