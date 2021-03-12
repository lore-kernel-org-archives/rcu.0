Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C281FC433DB
	for <rcu@archiver.kernel.org>; Fri, 12 Mar 2021 14:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936FB64F6A
	for <rcu@archiver.kernel.org>; Fri, 12 Mar 2021 14:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhCLOta (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Mar 2021 09:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhCLOtM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Mar 2021 09:49:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8217464F6A;
        Fri, 12 Mar 2021 14:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615560552;
        bh=XItlzqmS1GgbFrUy1lmYHco4asVlYr1fnKFtgVypdOc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qocWN2ABH3LybTsLHQVJtXDGBhxHZ8/Maf76z8hfmdcWXSYy8FlGbn70fZKD/ZOIC
         rwqc5c3WfY2fu46PjUOfM/VROHlV7IPEll6pyAEVC/nTGR7IM8cuhmrQpxsyIBCj+q
         rAd/u8K2y1xAitBYsUnNbrJEYIbemU58xbhBmrxJy6cKHWG7CAi7/mEaSO64TSN2Ck
         eV2IYd1yj+/W/t7cEZB8s5HfDAi6hdCHBudsa3FbAZ5JBi4N+xUViM+WV2elAKmMgG
         21WppUe7hdkxdNcvxMWFtMtrGx6sDH5K/PENVyu1/IpHt89p3QOLKdMP5PMymrovev
         47VsOEekNE7Jg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4C2CE3523783; Fri, 12 Mar 2021 06:49:12 -0800 (PST)
Date:   Fri, 12 Mar 2021 06:49:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] kvfree_rcu: convert a page cache to lock-free variant
Message-ID: <20210312144912.GG2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210308194950.12320-1-urezki@gmail.com>
 <20210308194950.12320-2-urezki@gmail.com>
 <CA+KHdyX-h2KHEEvZmbeLVdjBzW7o37_GvQrGj55-d4i-+HLboQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyX-h2KHEEvZmbeLVdjBzW7o37_GvQrGj55-d4i-+HLboQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 12, 2021 at 01:38:14PM +0100, Uladzislau Rezki wrote:
> Hello, Paul.
> 
> Please do not consider this patch. It is buggy :)

Consider it formally withdrawn, and thank you for letting me know!

							Thanx, Paul

> --
> Vlad Rezki
> 
> On Mon, Mar 8, 2021 at 8:50 PM Uladzislau Rezki (Sony) <urezki@gmail.com>
> wrote:
> 
> > Implement an access to the page cache as lock-free variant. This
> > is done because there are extra places where an access is required,
> > therefore making it lock-less will remove any lock contention.
> >
> > For example we have a shrinker path as well as a reclaim kthread.
> > In both cases a current CPU can access to a remote per-cpu page
> > cache that would require taking a lock to protect it.
> >
> > An "rcuscale" performance test suite can detect it and shows some
> > slight improvements:
> >
> > ../kvm.sh --memory 16G --torture rcuscale --allcpus --duration 10 \
> > --kconfig CONFIG_NR_CPUS=64 --bootargs "rcuscale.kfree_rcu_test=1 \
> > rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 \
> > rcuscale.kfree_rcu_test_double=1 torture.disable_onoff_at_boot"
> > --trust-make
> >
> > 100 iterations, checking total time taken by all kfree'ers in ns.:
> >
> > default: AVG: 10968415107.5 MIN: 10668412500 MAX: 11312145160
> > patch:   AVG: 10787596486.1 MIN: 10397559880 MAX: 11214901050
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/tree.c | 91 +++++++++++++++++++++++++++++------------------
> >  1 file changed, 56 insertions(+), 35 deletions(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 9c8cfb01e9a6..4f04664d5ac0 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3167,8 +3167,9 @@ struct kfree_rcu_cpu {
> >         atomic_t work_in_progress;
> >         struct hrtimer hrtimer;
> >
> > +       // lock-free cache.
> >         struct llist_head bkvcache;
> > -       int nr_bkv_objs;
> > +       atomic_t nr_bkv_objs;
> >  };
> >
> >  static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> > @@ -3215,49 +3216,79 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp,
> > unsigned long flags)
> >         raw_spin_unlock_irqrestore(&krcp->lock, flags);
> >  }
> >
> > +/*
> > + * Increment 'v', if 'v' is below 'thresh'. Returns true if we
> > + * succeeded, false if 'v' + 1 would be bigger than 'thresh'.
> > + *
> > + * Decrement 'v' if 'v' is upper 'thresh'. Returns true if we
> > + * succeeded, false if 'v' - 1 would be smaller than 'thresh'.
> > + */
> > +static inline bool
> > +atomic_test_inc_dec(atomic_t *v, unsigned int thresh, bool inc)
> > +{
> > +       unsigned int cur = atomic_read(v);
> > +       unsigned int old;
> > +
> > +       for (;;) {
> > +               if (inc) {
> > +                       if (cur >= thresh)
> > +                               return false;
> > +               } else {
> > +                       if (cur <= thresh)
> > +                               return false;
> > +               }
> > +
> > +               old = atomic_cmpxchg(v, cur, inc ? (cur + 1):(cur - 1));
> > +               if (old == cur)
> > +                       break;
> > +
> > +               cur = old;
> > +       }
> > +
> > +       return true;
> > +}
> > +
> >  static inline struct kvfree_rcu_bulk_data *
> >  get_cached_bnode(struct kfree_rcu_cpu *krcp)
> >  {
> > -       if (!krcp->nr_bkv_objs)
> > -               return NULL;
> > +       struct kvfree_rcu_bulk_data *bnode = NULL;
> >
> > -       krcp->nr_bkv_objs--;
> > -       return (struct kvfree_rcu_bulk_data *)
> > -               llist_del_first(&krcp->bkvcache);
> > +       if (atomic_test_inc_dec(&krcp->nr_bkv_objs, 0, false))
> > +               bnode = (struct kvfree_rcu_bulk_data *)
> > +                       llist_del_first(&krcp->bkvcache);
> > +
> > +       return bnode;
> >  }
> >
> >  static inline bool
> >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> >         struct kvfree_rcu_bulk_data *bnode)
> >  {
> > -       // Check the limit.
> > -       if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > -               return false;
> > -
> > -       llist_add((struct llist_node *) bnode, &krcp->bkvcache);
> > -       krcp->nr_bkv_objs++;
> > -       return true;
> > +       if (atomic_test_inc_dec(&krcp->nr_bkv_objs, rcu_min_cached_objs,
> > true)) {
> > +               llist_add((struct llist_node *) bnode, &krcp->bkvcache);
> > +               return true;
> > +       }
> >
> > +       return false;
> >  }
> >
> >  static int
> >  drain_page_cache(struct kfree_rcu_cpu *krcp)
> >  {
> > -       unsigned long flags;
> > -       struct llist_node *page_list, *pos, *n;
> > -       int freed = 0;
> > +       struct kvfree_rcu_bulk_data *bnode;
> > +       int num_pages, i;
> >
> > -       raw_spin_lock_irqsave(&krcp->lock, flags);
> > -       page_list = llist_del_all(&krcp->bkvcache);
> > -       krcp->nr_bkv_objs = 0;
> > -       raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > +       num_pages = atomic_read(&krcp->nr_bkv_objs);
> > +
> > +       for (i = 0; i < num_pages; i++) {
> > +               bnode = get_cached_bnode(krcp);
> > +               if (!bnode)
> > +                       break;
> >
> > -       llist_for_each_safe(pos, n, page_list) {
> > -               free_page((unsigned long)pos);
> > -               freed++;
> > +               free_page((unsigned long) bnode);
> >         }
> >
> > -       return freed;
> > +       return i;
> >  }
> >
> >  /*
> > @@ -3314,10 +3345,8 @@ static void kfree_rcu_work(struct work_struct *work)
> >                         }
> >                         rcu_lock_release(&rcu_callback_map);
> >
> > -                       raw_spin_lock_irqsave(&krcp->lock, flags);
> >                         if (put_cached_bnode(krcp, bkvhead[i]))
> >                                 bkvhead[i] = NULL;
> > -                       raw_spin_unlock_irqrestore(&krcp->lock, flags);
> >
> >                         if (bkvhead[i])
> >                                 free_page((unsigned long) bkvhead[i]);
> > @@ -3460,7 +3489,6 @@ static void fill_page_cache_func(struct work_struct
> > *work)
> >         struct kfree_rcu_cpu *krcp =
> >                 container_of(work, struct kfree_rcu_cpu,
> >                         page_cache_work.work);
> > -       unsigned long flags;
> >         bool pushed;
> >         int i;
> >
> > @@ -3469,10 +3497,7 @@ static void fill_page_cache_func(struct work_struct
> > *work)
> >                         __get_free_page(GFP_KERNEL | __GFP_NORETRY |
> > __GFP_NOMEMALLOC | __GFP_NOWARN);
> >
> >                 if (bnode) {
> > -                       raw_spin_lock_irqsave(&krcp->lock, flags);
> >                         pushed = put_cached_bnode(krcp, bnode);
> > -                       raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > -
> >                         if (!pushed) {
> >                                 free_page((unsigned long) bnode);
> >                                 break;
> > @@ -3647,17 +3672,13 @@ kfree_rcu_shrink_count(struct shrinker *shrink,
> > struct shrink_control *sc)
> >  {
> >         int cpu;
> >         unsigned long count = 0;
> > -       unsigned long flags;
> >
> >         /* Snapshot count of all CPUs */
> >         for_each_possible_cpu(cpu) {
> >                 struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> >
> >                 count += READ_ONCE(krcp->count);
> > -
> > -               raw_spin_lock_irqsave(&krcp->lock, flags);
> > -               count += krcp->nr_bkv_objs;
> > -               raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > +               count += atomic_read(&krcp->nr_bkv_objs);
> >         }
> >
> >         WRITE_ONCE(backoff_page_cache_fill, true);
> > --
> > 2.20.1
> >
> >
> 
> -- 
> Uladzislau Rezki
