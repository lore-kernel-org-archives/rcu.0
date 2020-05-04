Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C042C3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 15:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84C820721
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588605878;
	bh=MzNiVO8MVdci6uJ3eTJQ2QquqS+q1KU5qC3zotobsgU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=E8EJz6gdQG+dGeJut1zdTuiEKyvvCHsv4ityBC1rLDk77WhD4WWbI+oOyjeiDSuY0
	 nRa3NLGnmfIhHEpZIm1bYu6+tRPuTx2SuuHoSBoKW+MYLcIb+8XfR8FUxEBLsyjYfH
	 FFx66infAsUmkOIrmzd/yAHxr7ZCfSkR3kwMStCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgEDPYi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 11:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgEDPYi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 May 2020 11:24:38 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6258206D9;
        Mon,  4 May 2020 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588605877;
        bh=MzNiVO8MVdci6uJ3eTJQ2QquqS+q1KU5qC3zotobsgU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iKyQy2S9W7xUonlWX2EvnoprGb7t1/U0JR5DNbgCp3J8300h8ihPmw5xaobu3gUc+
         xjiVh2F8aVSbO/fU3l+Whp6JAlCWD3fQAZJiWZLyU2N3Fijk5/UtjEGrvQubn0q5pk
         vKBTDos/HQ/K6c1H1ZpWrK5YTunXhWl4B+1yX1ok=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9474D3522C68; Mon,  4 May 2020 08:24:37 -0700 (PDT)
Date:   Mon, 4 May 2020 08:24:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 09/24] rcu/tree: cache specified number of objects
Message-ID: <20200504152437.GK2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-10-urezki@gmail.com>
 <20200501212749.GD7560@paulmck-ThinkPad-P72>
 <20200504124323.GA17577@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504124323.GA17577@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 04, 2020 at 02:43:23PM +0200, Uladzislau Rezki wrote:
> On Fri, May 01, 2020 at 02:27:49PM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 28, 2020 at 10:58:48PM +0200, Uladzislau Rezki (Sony) wrote:
> > > Cache some extra objects per-CPU. During reclaim process
> > > some pages are cached instead of releasing by linking them
> > > into the list. Such approach provides O(1) access time to
> > > the cache.
> > > 
> > > That reduces number of requests to the page allocator, also
> > > that makes it more helpful if a low memory condition occurs.
> > > 
> > > A parameter reflecting the minimum allowed pages to be
> > > cached per one CPU is propagated via sysfs, it is read
> > > only, the name is "rcu_min_cached_objs".
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  kernel/rcu/tree.c | 64 ++++++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 60 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 89e9ca3f4e3e..d8975819b1c9 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -178,6 +178,14 @@ module_param(gp_init_delay, int, 0444);
> > >  static int gp_cleanup_delay;
> > >  module_param(gp_cleanup_delay, int, 0444);
> > >  
> > > +/*
> > > + * This rcu parameter is read-only, but can be write also.
> > 
> > You mean that although the parameter is read-only, you see no reason
> > why it could not be converted to writeable?
> > 
> I added just a note. If it is writable, then we can change the size of the
> per-CPU cache dynamically, i.e. "echo 5 > /sys/.../rcu_min_cached_objs"
> would cache 5 pages. But i do not have a strong opinion if it should be
> writable.
> 
> > If it was writeable, and a given CPU had the maximum numbr of cached
> > objects, the rcu_min_cached_objs value was decreased, but that CPU never
> > saw another kfree_rcu(), would the number of cached objects change?
> > 
> No. It works the way: unqueue the page from cache in the kfree_rcu(),
> whereas "rcu work" will put it back if number of objects < rcu_min_cached_objs,
> if >= will free the page.

Just to make sure I understand...  If someone writes a smaller number to
the sysfs variable, the per-CPU caches will be decreased at that point,
immediately during that sysfs write?  Or are you saying something else?

> > (Just curious, not asking for a change in functionality.)
> > 
> > > + * It reflects the minimum allowed number of objects which
> > > + * can be cached per-CPU. Object size is equal to one page.
> > > + */
> > > +int rcu_min_cached_objs = 2;
> > > +module_param(rcu_min_cached_objs, int, 0444);
> > > +
> > >  /* Retrieve RCU kthreads priority for rcutorture */
> > >  int rcu_get_gp_kthreads_prio(void)
> > >  {
> > > @@ -2887,7 +2895,6 @@ struct kfree_rcu_cpu_work {
> > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> > >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> > >   * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
> > > - * @bcached: Keeps at most one object for later reuse when build chain blocks
> > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> > >   * @lock: Synchronize access to this structure
> > >   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> > > @@ -2902,7 +2909,6 @@ struct kfree_rcu_cpu_work {
> > >  struct kfree_rcu_cpu {
> > >  	struct rcu_head *head;
> > >  	struct kfree_rcu_bulk_data *bhead;
> > > -	struct kfree_rcu_bulk_data *bcached;
> > >  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > >  	raw_spinlock_t lock;
> > >  	struct delayed_work monitor_work;
> > > @@ -2910,6 +2916,15 @@ struct kfree_rcu_cpu {
> > >  	bool initialized;
> > >  	// Number of objects for which GP not started
> > >  	int count;
> > > +
> > > +	/*
> > > +	 * Number of cached objects which are queued into
> > > +	 * the lock-less list. This cache is used by the
> > > +	 * kvfree_call_rcu() function and as of now its
> > > +	 * size is static.
> > > +	 */
> > > +	struct llist_head bkvcache;
> > > +	int nr_bkv_objs;
> > >  };
> > >  
> > >  static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> > > @@ -2946,6 +2961,31 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
> > >  	local_irq_restore(flags);
> > >  }
> > >  
> > > +static inline struct kfree_rcu_bulk_data *
> > > +get_cached_bnode(struct kfree_rcu_cpu *krcp)
> > > +{
> > > +	if (!krcp->nr_bkv_objs)
> > > +		return NULL;
> > > +
> > > +	krcp->nr_bkv_objs--;
> > > +	return (struct kfree_rcu_bulk_data *)
> > > +		llist_del_first(&krcp->bkvcache);
> > > +}
> > > +
> > > +static inline bool
> > > +put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > > +	struct kfree_rcu_bulk_data *bnode)
> > > +{
> > > +	/* Check the limit. */
> > > +	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > > +		return false;
> > > +
> > > +	llist_add((struct llist_node *) bnode, &krcp->bkvcache);
> > > +	krcp->nr_bkv_objs++;
> > > +	return true;
> > > +
> > > +}
> > > +
> > >  /*
> > >   * This function is invoked in workqueue context after a grace period.
> > >   * It frees all the objects queued on ->bhead_free or ->head_free.
> > > @@ -2981,7 +3021,12 @@ static void kfree_rcu_work(struct work_struct *work)
> > >  		kfree_bulk(bhead->nr_records, bhead->records);
> > >  		rcu_lock_release(&rcu_callback_map);
> > >  
> > > -		if (cmpxchg(&krcp->bcached, NULL, bhead))
> > > +		krcp = krc_this_cpu_lock(&flags);
> > 
> > Presumably the list can also be accessed without holding this lock,
> > because otherwise we shouldn't need llist...
> > 
> Hm... We increase the number of elements in cache, therefore it is not
> lockless. From the other hand i used llist_head to maintain the cache
> because it is single linked list, we do not need "*prev" link. Also
> we do not need to init the list.
> 
> But i can change it to list_head. Please let me know if i need :)

Hmmm...  Maybe it is time for a non-atomic singly linked list?  In the RCU
callback processing, the operations were open-coded, but they have been
pushed into include/linux/rcu_segcblist.h and kernel/rcu/rcu_segcblist.*.

Maybe some non-atomic/protected/whatever macros in the llist.h file?
Or maybe just open-code the singly linked list?  (Probably not the
best choice, though.)  Add comments stating that the atomic properties
of the llist functions aren't neded?  Something else?

The comments would be a good start.  Just to take pity on people seeing
the potential for concurrency and wondering how the concurrent accesses
actually happen.  ;-)

							Thanx, Paul
