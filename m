Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0946BC4332D
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC97A64E22
	for <rcu@archiver.kernel.org>; Thu, 28 Jan 2021 18:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhA1SQo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhA1SGc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Jan 2021 13:06:32 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B5BC0611C2;
        Thu, 28 Jan 2021 10:03:03 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id c18so7444113ljd.9;
        Thu, 28 Jan 2021 10:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5OZYmrNcxG3BvJiqZEDeQgXJXCAtsmjQULD8f7sH9Uk=;
        b=f/9VviffW7U61PDTs2O6LL9Zyq5IYUAwFc86VO6Hge9QxvhrBQ6Kj3fb8E5Q7iFWYK
         wdBy8IjuLLxBTvlavGuHaIagwQOhPmCn687Tvm5r4KkKR+Sy8MyPzKZLat4vTOasGc8P
         D/r7KoWibyGouKPf2QzgrYPQfrEgi112V4vVK4KM8rp8xhSdm3Kutg3yUxEeVwsSsgro
         6jqPXNZXexdB7F9zz9o6z4Ml9lryhcY9rYHKzlZyWLhXhPk3GG1FcNSthpWNZRI0JUKZ
         WHyVjrIMUItGhzwYjdcpp2MAKmzmyodJD3QwXJur3rcVKN2VJ6B7c4iMGTCP3nmiknPw
         Hdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5OZYmrNcxG3BvJiqZEDeQgXJXCAtsmjQULD8f7sH9Uk=;
        b=uD+fEXW9XGVqU/cmD9jkQAPM8zCNTCIchdSV0OGZW+HJk1cPe3C/knB+K+9mJ3mk1H
         URMGXeVUX95CZ0BsoSOjSdD/CYRt1L/pIZwyQB9ETZN4+7M9KAWAjfgiV5JR/JL9XYd0
         AT8AGQGDiQ1xsE3nt4/+Ed1jNzkB7kDO4YutLDb1rB2TMqVk/BAA0nH+MPwTwOJ0fbwW
         EU18k/021UpSPBpbAZf1DhIbQFEXGrbar20M+ZCnVAv4zNksywAfocMBr24O7DGN0ICy
         3xBDltHsbUjpjNRAk7wD8wtIBqARYi6s+FG77+0TmDDMcbVMBnyUatwLJLAfCce5ZiIc
         eU2g==
X-Gm-Message-State: AOAM5318Kh25O6+XEREFxx7ZoU7v0FqETi1TVR3zhpImXfmZS3rrIPoe
        HNnniLl3Pdcd+6l8wRKmc08=
X-Google-Smtp-Source: ABdhPJy8OuBlRl1VwDZvg5NcJoVhHuMdZgcnQpVF8cmLrBUKXNkpeTcqBZXntvAOr3qTXmwYxQqMxw==
X-Received: by 2002:a2e:824b:: with SMTP id j11mr241497ljh.473.1611856981250;
        Thu, 28 Jan 2021 10:03:01 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id o14sm2199218ljp.48.2021.01.28.10.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:50 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 28 Jan 2021 19:02:37 +0100
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Message-ID: <20210128180237.GA5144@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210125132236.GJ827@dhcp22.suse.cz>
 <20210125143150.GA2282@pc638.lan>
 <20210125153943.GN827@dhcp22.suse.cz>
 <20210125162559.GA52712@pc638.lan>
 <20210128151152.GA1867@pc638.lan>
 <YBLVbZzy0KSONizm@dhcp22.suse.cz>
 <20210128153017.GA2006@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128153017.GA2006@pc638.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 28, 2021 at 04:30:17PM +0100, Uladzislau Rezki wrote:
> On Thu, Jan 28, 2021 at 04:17:01PM +0100, Michal Hocko wrote:
> > On Thu 28-01-21 16:11:52, Uladzislau Rezki wrote:
> > > On Mon, Jan 25, 2021 at 05:25:59PM +0100, Uladzislau Rezki wrote:
> > > > On Mon, Jan 25, 2021 at 04:39:43PM +0100, Michal Hocko wrote:
> > > > > On Mon 25-01-21 15:31:50, Uladzislau Rezki wrote:
> > > > > > > On Wed 20-01-21 17:21:46, Uladzislau Rezki (Sony) wrote:
> > > > > > > > For a single argument we can directly request a page from a caller
> > > > > > > > context when a "carry page block" is run out of free spots. Instead
> > > > > > > > of hitting a slow path we can request an extra page by demand and
> > > > > > > > proceed with a fast path.
> > > > > > > > 
> > > > > > > > A single-argument kvfree_rcu() must be invoked in sleepable contexts,
> > > > > > > > and that its fallback is the relatively high latency synchronize_rcu().
> > > > > > > > Single-argument kvfree_rcu() therefore uses GFP_KERNEL|__GFP_RETRY_MAYFAIL
> > > > > > > > to allow limited sleeping within the memory allocator.
> > > > > > > 
> > > > > > > __GFP_RETRY_MAYFAIL can be quite heavy. It is effectively the most heavy
> > > > > > > way to allocate without triggering the OOM killer. Is this really what
> > > > > > > you need/want? Is __GFP_NORETRY too weak?
> > > > > > > 
> > > > > > Hm... We agreed to proceed with limited lightwait memory direct reclaim.
> > > > > > Johannes Weiner proposed to go with __GFP_NORETRY flag as a starting
> > > > > > point: https://www.spinics.net/lists/rcu/msg02856.html
> > > > > > 
> > > > > > <snip>
> > > > > >     So I'm inclined to suggest __GFP_NORETRY as a starting point, and make
> > > > > >     further decisions based on instrumentation of the success rates of
> > > > > >     these opportunistic allocations.
> > > > > > <snip>
> > > > > 
> > > > > I completely agree with Johannes here.
> > > > > 
> > > > > > but for some reason, i can't find a tail or head of it, we introduced
> > > > > > __GFP_RETRY_MAYFAIL what is a heavy one from a time consuming point of view.
> > > > > > What we would like to avoid.
> > > > > 
> > > > > Not that I object to this use but I think it would be much better to use
> > > > > it based on actual data. Going along with it right away might become a
> > > > > future burden to make any changes in this aspect later on due to lack of 
> > > > > exact reasoning. General rule of thumb for __GFP_RETRY_MAYFAIL is really
> > > > > try as hard as it can get without being really disruptive (like OOM
> > > > > killing something). And your wording didn't really give me that
> > > > > impression.
> > > > > 
> > > > Initially i proposed just to go with GFP_NOWAIT flag. But later on there
> > > > was a discussion about a fallback path, that uses synchronize_rcu() can be
> > > > slow, thus minimizing its hitting would be great. So, here we go with a
> > > > trade off.
> > > > 
> > > > Doing it hard as __GFP_RETRY_MAYFAIL can do, is not worth(IMHO), but to have some
> > > > light-wait requests would be acceptable. That is why __GFP_NORETRY was proposed.
> > > > 
> > > > There were simple criterias we discussed which we would like to achieve:
> > > > 
> > > > a) minimize a fallback hitting;
> > > > b) avoid of OOM involving;
> > > > c) avoid of dipping into the emergency reserves. See kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu()
> > > > 
> > > One question here. Since the code that triggers a page request can be
> > > directly invoked from reclaim context as well as outside of it. We had
> > > a concern about if any recursion is possible, but what i see it is safe.
> > > The context that does it can not enter it twice:
> > > 
> > > <snip>
> > >     /* Avoid recursion of direct reclaim */
> > >     if (current->flags & PF_MEMALLOC)
> > >         goto nopage;
> > > <snip>
> > 
> > Yes this is a recursion protection.
> > 
> > > What about any deadlocking in regards to below following flags?
> > > 
> > > GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN
> > 
> > and __GFP_NOMEMALLOC will make sure that the allocation will not consume
> > all the memory reserves. The later should be clarified in one of your
> > patches I have acked IIRC.
> >
> Yep, it is clarified and reflected in another patch you ACKed.
> 
> Thanks!
> 

Please find below the V2.

Changelog V1 -> V2:
    - replace the __GFP_RETRY_MAYFAIL by __GFP_NORETRY;
    - add more comments explaining why and which flags are used.

<snip>
From 0bdb8ca1ae62088790e0a452c4acec3821e06989 Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Wed, 20 Jan 2021 17:21:46 +0100
Subject: [PATCH v2 1/1] kvfree_rcu: Directly allocate page for single-argument
 case

Single-argument kvfree_rcu() must be invoked from sleepable contexts,
so we can directly allocate pages.  Furthermmore, the fallback in case
of page-allocation failure is the high-latency synchronize_rcu(), so it
makes sense to do these page allocations from the fastpath, and even to
permit limited sleeping within the allocator.

This commit therefore allocates if needed on the fastpath using
GFP_KERNEL|__GFP_NORETRY.  This also has the beneficial effect
of leaving kvfree_rcu()'s per-CPU caches to the double-argument variant
of kvfree_rcu(), given that the double-argument variant cannot directly
invoke the allocator.

[ paulmck: Add add_ptr_to_bulk_krc_lock header comment per Michal Hocko. ]
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 51 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e04e336bee42..e450c17a06b2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3465,37 +3465,59 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 	}
 }
 
+// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
+// state specified by flags.  If can_alloc is true, the caller must
+// be schedulable and not be holding any locks or mutexes that might be
+// acquired by the memory allocator or anything that it might invoke.
+// Returns true if ptr was successfully recorded, else the caller must
+// use a fallback.
 static inline bool
-kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
+	unsigned long *flags, void *ptr, bool can_alloc)
 {
 	struct kvfree_rcu_bulk_data *bnode;
 	int idx;
 
-	if (unlikely(!krcp->initialized))
+	*krcp = krc_this_cpu_lock(flags);
+	if (unlikely(!(*krcp)->initialized))
 		return false;
 
-	lockdep_assert_held(&krcp->lock);
 	idx = !!is_vmalloc_addr(ptr);
 
 	/* Check if a new block is required. */
-	if (!krcp->bkvhead[idx] ||
-			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
-		bnode = get_cached_bnode(krcp);
-		/* Switch to emergency path. */
+	if (!(*krcp)->bkvhead[idx] ||
+			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
+		bnode = get_cached_bnode(*krcp);
+		if (!bnode && can_alloc) {
+			krc_this_cpu_unlock(*krcp, *flags);
+
+			// __GFP_NORETRY - allows a light-weight direct reclaim
+			// what is OK from minimizing of fallback hitting point of
+			// view. Apart of that it forbids any OOM invoking what is
+			// also beneficial since we are about to release memory soon.
+			//
+			// __GFP_NOWARN - it is supposed that an allocation can
+			// be failed under low memory or high memory pressure
+			// scenarios.
+			bnode = (struct kvfree_rcu_bulk_data *)
+				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
+			*krcp = krc_this_cpu_lock(flags);
+		}
+
 		if (!bnode)
 			return false;
 
 		/* Initialize the new block. */
 		bnode->nr_records = 0;
-		bnode->next = krcp->bkvhead[idx];
+		bnode->next = (*krcp)->bkvhead[idx];
 
 		/* Attach it to the head. */
-		krcp->bkvhead[idx] = bnode;
+		(*krcp)->bkvhead[idx] = bnode;
 	}
 
 	/* Finally insert. */
-	krcp->bkvhead[idx]->records
-		[krcp->bkvhead[idx]->nr_records++] = ptr;
+	(*krcp)->bkvhead[idx]->records
+		[(*krcp)->bkvhead[idx]->nr_records++] = ptr;
 
 	return true;
 }
@@ -3533,8 +3555,6 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		ptr = (unsigned long *) func;
 	}
 
-	krcp = krc_this_cpu_lock(&flags);
-
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
@@ -3542,12 +3562,11 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 			  __func__, head);
 
 		// Mark as success and leave.
-		success = true;
-		goto unlock_return;
+		return;
 	}
 
 	kasan_record_aux_stack(ptr);
-	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		run_page_cache_worker(krcp);
 
-- 
2.20.1
<snip>

--
Vlad Rezki
