Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9FFC3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664392075B
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0HOjBb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgEDMnb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 08:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727103AbgEDMn2 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 08:43:28 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53084C061A0E;
        Mon,  4 May 2020 05:43:28 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z22so9424255lfd.0;
        Mon, 04 May 2020 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LY2vVgC+cbtdUXhh6dmU56B7JQpHi0i0aYK6LOUqicI=;
        b=H0HOjBb9hzV/FDQ0/d0UiRz3Ycph1g+TCIEQVTHFobzyrZ3lr3MgEgj2O0R5TuLOOq
         mZ3+YKZkLBVz0wojifBQxAhPMATX+OaGfEA0DhhPYIVhqB9AAWNHFfAYWVBmxSHjT1AL
         LOwkD8d+wVq1lQ/wtdhGpgZcz+WLh/vW56RpEc3uk45gJN+CZAXSVUazBI9a5BpXnuUt
         MsFtr8zkxk1Zf17Y6m2qNHVom8hIwdkKzU5jvQcLTOzEe8VV21+1KauaDHmC7RRpXoLs
         xMRBSd5xZifuzumCOCMeG1G33OamL3Oy95aqsbYkllKH/17rASM06//9oMtjlFNkMc8/
         qz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LY2vVgC+cbtdUXhh6dmU56B7JQpHi0i0aYK6LOUqicI=;
        b=cpsf/0qVjWjAGeHSQgr2xWAIyvyQXxUcREm2KIQ5fM5CQ/gSI2VYkj9JdD4R/8soQY
         KhSUNgX7y5gPF6qUOLCh+kufRkfsG4vKFVhuP7nrvJbb2SBq7A5XFr+ZSC6uvib03VG2
         HSi8Co/XHpOmOCmARV9jcwOuyTAvGPbN6sR7jhLRvzmenk+btR9BYauAK9hV0Lwyp1BD
         SV7tECqNqmKap7quWixVCib4Vw44D/6w8MiBhDZbgR0utgVZtIzav4UNmX3s8VYMkoqA
         MX8R1Cg8Rbxer1Y1BJdvSzOh3esokxLi2GX5cSu5Bv5llLbgy29grjL7dNCZ0U1mTlo+
         6kHg==
X-Gm-Message-State: AGi0PubYOj6gnWzbIaRISHLozc2WL4LKnJ+BxpN4BYIEsizoirA8WyIE
        3XDR1df0EloAtnGmlUxKTqI=
X-Google-Smtp-Source: APiQypKIkNZaeqpNNjFZCpFyjTIpjvlXudh08G2yez832a5PcnPpsYMXTySn3pJQXCwgq57cS6RVHw==
X-Received: by 2002:a05:6512:31c1:: with SMTP id j1mr11627561lfe.14.1588596206766;
        Mon, 04 May 2020 05:43:26 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id u3sm4650793lfq.59.2020.05.04.05.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:43:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 May 2020 14:43:23 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
Message-ID: <20200504124323.GA17577@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-10-urezki@gmail.com>
 <20200501212749.GD7560@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501212749.GD7560@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 01, 2020 at 02:27:49PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 28, 2020 at 10:58:48PM +0200, Uladzislau Rezki (Sony) wrote:
> > Cache some extra objects per-CPU. During reclaim process
> > some pages are cached instead of releasing by linking them
> > into the list. Such approach provides O(1) access time to
> > the cache.
> > 
> > That reduces number of requests to the page allocator, also
> > that makes it more helpful if a low memory condition occurs.
> > 
> > A parameter reflecting the minimum allowed pages to be
> > cached per one CPU is propagated via sysfs, it is read
> > only, the name is "rcu_min_cached_objs".
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/tree.c | 64 ++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 60 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 89e9ca3f4e3e..d8975819b1c9 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -178,6 +178,14 @@ module_param(gp_init_delay, int, 0444);
> >  static int gp_cleanup_delay;
> >  module_param(gp_cleanup_delay, int, 0444);
> >  
> > +/*
> > + * This rcu parameter is read-only, but can be write also.
> 
> You mean that although the parameter is read-only, you see no reason
> why it could not be converted to writeable?
> 
I added just a note. If it is writable, then we can change the size of the
per-CPU cache dynamically, i.e. "echo 5 > /sys/.../rcu_min_cached_objs"
would cache 5 pages. But i do not have a strong opinion if it should be
writable.

>
> If it was writeable, and a given CPU had the maximum numbr of cached
> objects, the rcu_min_cached_objs value was decreased, but that CPU never
> saw another kfree_rcu(), would the number of cached objects change?
> 
No. It works the way: unqueue the page from cache in the kfree_rcu(),
whereas "rcu work" will put it back if number of objects < rcu_min_cached_objs,
if >= will free the page.

>
> (Just curious, not asking for a change in functionality.)
> 
> > + * It reflects the minimum allowed number of objects which
> > + * can be cached per-CPU. Object size is equal to one page.
> > + */
> > +int rcu_min_cached_objs = 2;
> > +module_param(rcu_min_cached_objs, int, 0444);
> > +
> >  /* Retrieve RCU kthreads priority for rcutorture */
> >  int rcu_get_gp_kthreads_prio(void)
> >  {
> > @@ -2887,7 +2895,6 @@ struct kfree_rcu_cpu_work {
> >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> >   * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
> > - * @bcached: Keeps at most one object for later reuse when build chain blocks
> >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> >   * @lock: Synchronize access to this structure
> >   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> > @@ -2902,7 +2909,6 @@ struct kfree_rcu_cpu_work {
> >  struct kfree_rcu_cpu {
> >  	struct rcu_head *head;
> >  	struct kfree_rcu_bulk_data *bhead;
> > -	struct kfree_rcu_bulk_data *bcached;
> >  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> >  	raw_spinlock_t lock;
> >  	struct delayed_work monitor_work;
> > @@ -2910,6 +2916,15 @@ struct kfree_rcu_cpu {
> >  	bool initialized;
> >  	// Number of objects for which GP not started
> >  	int count;
> > +
> > +	/*
> > +	 * Number of cached objects which are queued into
> > +	 * the lock-less list. This cache is used by the
> > +	 * kvfree_call_rcu() function and as of now its
> > +	 * size is static.
> > +	 */
> > +	struct llist_head bkvcache;
> > +	int nr_bkv_objs;
> >  };
> >  
> >  static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> > @@ -2946,6 +2961,31 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
> >  	local_irq_restore(flags);
> >  }
> >  
> > +static inline struct kfree_rcu_bulk_data *
> > +get_cached_bnode(struct kfree_rcu_cpu *krcp)
> > +{
> > +	if (!krcp->nr_bkv_objs)
> > +		return NULL;
> > +
> > +	krcp->nr_bkv_objs--;
> > +	return (struct kfree_rcu_bulk_data *)
> > +		llist_del_first(&krcp->bkvcache);
> > +}
> > +
> > +static inline bool
> > +put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > +	struct kfree_rcu_bulk_data *bnode)
> > +{
> > +	/* Check the limit. */
> > +	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > +		return false;
> > +
> > +	llist_add((struct llist_node *) bnode, &krcp->bkvcache);
> > +	krcp->nr_bkv_objs++;
> > +	return true;
> > +
> > +}
> > +
> >  /*
> >   * This function is invoked in workqueue context after a grace period.
> >   * It frees all the objects queued on ->bhead_free or ->head_free.
> > @@ -2981,7 +3021,12 @@ static void kfree_rcu_work(struct work_struct *work)
> >  		kfree_bulk(bhead->nr_records, bhead->records);
> >  		rcu_lock_release(&rcu_callback_map);
> >  
> > -		if (cmpxchg(&krcp->bcached, NULL, bhead))
> > +		krcp = krc_this_cpu_lock(&flags);
> 
> Presumably the list can also be accessed without holding this lock,
> because otherwise we shouldn't need llist...
> 
Hm... We increase the number of elements in cache, therefore it is not
lockless. From the other hand i used llist_head to maintain the cache
because it is single linked list, we do not need "*prev" link. Also
we do not need to init the list.

But i can change it to list_head. Please let me know if i need :)

--
Vlad Rezki
