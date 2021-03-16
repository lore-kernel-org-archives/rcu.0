Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EADDC433E6
	for <rcu@archiver.kernel.org>; Tue, 16 Mar 2021 21:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A4464F91
	for <rcu@archiver.kernel.org>; Tue, 16 Mar 2021 21:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhCPVBu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232193AbhCPVBZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Mar 2021 17:01:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 759F764F8F;
        Tue, 16 Mar 2021 21:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615928485;
        bh=dNBxTNQG9ePoDgWe8NBXWxpyQmJxDN9zVFlfWsiik50=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CZJwFPDm4v88ydBKSrA/PdY7mB63fCvh1qKtrd2+zvyXJ5U13mVI3iCxYTHotp0Bm
         NRGQwrNzQLNdAf4DeYji9kE8REzKTBRVZcd+DFy0eEYHdOK0aB8c9sNaoVrUNf9vxl
         mFHq32lAfYZPcLplaJMnTrcCQ4QYqkBbToiRDo/VnMJcpmrm8aZItP7udZRLNdz8oc
         K737v94koHi67wlgN9Y4cyIev7bwZGG7Q7wvQaDLC2yTlRtFHU41Z2Jq9N2qDnbL23
         MIXJa7GIWIwnPkqC+10GrQdMxBxdATGXd9pbuZgFRyOgrfwFAVpBt4zkXmf2Xaj2Zw
         d0vjzHV5ntomg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2DD12352262D; Tue, 16 Mar 2021 14:01:25 -0700 (PDT)
Date:   Tue, 16 Mar 2021 14:01:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
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
        Zhang Qiang <qiang.zhang@windriver.com>
Subject: Re: [PATCH v2 1/1] kvfree_rcu: Release a page cache under memory
 pressure
Message-ID: <20210316210125.GY2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210310200757.32331-1-urezki@gmail.com>
 <20210316163117.GU2696@paulmck-ThinkPad-P72>
 <20210316204207.GA2018@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316204207.GA2018@pc638.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 16, 2021 at 09:42:07PM +0100, Uladzislau Rezki wrote:
> > On Wed, Mar 10, 2021 at 09:07:57PM +0100, Uladzislau Rezki (Sony) wrote:
> > > From: Zhang Qiang <qiang.zhang@windriver.com>
> > > 
> > > Add a drain_page_cache() function to drain a per-cpu page cache.
> > > The reason behind of it is a system can run into a low memory
> > > condition, in that case a page shrinker can ask for its users
> > > to free their caches in order to get extra memory available for
> > > other needs in a system.
> > > 
> > > When a system hits such condition, a page cache is drained for
> > > all CPUs in a system. Apart of that a page cache work is delayed
> > > with 5 seconds interval until a memory pressure disappears.
> > 
> > Does this capture it?
> > 
> It would be good to have kind of clear interface saying that:
> 
> - low memory condition starts;
> - it is over, watermarks were fixed.
> 
> but i do not see it. Therefore 5 seconds back-off has been chosen
> to make a cache refilling to be less aggressive. Suppose 5 seconds
> is not enough, in that case the work will attempt to allocate some
> pages using less permissive parameters. What means that if we are
> still in a low memory condition a refilling will probably fail and
> next job will be invoked in 5 seconds one more time.

I would like such an interface as well, but from what I hear it is
easier to ask for than to provide.  :-/

> > ------------------------------------------------------------------------
> > 
> > Add a drain_page_cache() function that drains the specified per-cpu
> > page cache.  This function is invoked on each CPU when the system
> > enters a low-memory state, that is, when the shrinker invokes
> > kfree_rcu_shrink_scan().  Thus, when the system is low on memory,
> > kvfree_rcu() starts taking its slow paths.
> > 
> > In addition, the first subsequent attempt to refill the caches is
> > delayed for five seconds.
> > 
> > ------------------------------------------------------------------------
> > 
> > A few questions below.
> > 
> > 							Thanx, Paul
> > 
> > > Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > > ---
> > >  kernel/rcu/tree.c | 59 ++++++++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 51 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 2c9cf4df942c..46b8a98ca077 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3163,7 +3163,7 @@ struct kfree_rcu_cpu {
> > >  	bool initialized;
> > >  	int count;
> > >  
> > > -	struct work_struct page_cache_work;
> > > +	struct delayed_work page_cache_work;
> > >  	atomic_t work_in_progress;
> > >  	struct hrtimer hrtimer;
> > >  
> > > @@ -3175,6 +3175,17 @@ static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> > >  	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
> > >  };
> > >  
> > > +// A page shrinker can ask for freeing extra pages
> > > +// to get them available for other needs in a system.
> > > +// Usually it happens under low memory condition, in
> > > +// that case hold on a bit with page cache filling.
> > > +static unsigned long backoff_page_cache_fill;
> > > +
> > > +// 5 seconds delay. That is long enough to reduce
> > > +// an interfering and racing with a shrinker where
> > > +// the cache is drained.
> > > +#define PAGE_CACHE_FILL_DELAY (5 * HZ)
> > > +
> > >  static __always_inline void
> > >  debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
> > >  {
> > > @@ -3229,6 +3240,26 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > >  
> > >  }
> > >  
> > > +static int
> > > +drain_page_cache(struct kfree_rcu_cpu *krcp)
> > > +{
> > > +	unsigned long flags;
> > > +	struct llist_node *page_list, *pos, *n;
> > > +	int freed = 0;
> > > +
> > > +	raw_spin_lock_irqsave(&krcp->lock, flags);
> > > +	page_list = llist_del_all(&krcp->bkvcache);
> > > +	krcp->nr_bkv_objs = 0;
> > > +	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > +
> > > +	llist_for_each_safe(pos, n, page_list) {
> > > +		free_page((unsigned long)pos);
> > > +		freed++;
> > > +	}
> > > +
> > > +	return freed;
> > > +}
> > > +
> > >  /*
> > >   * This function is invoked in workqueue context after a grace period.
> > >   * It frees all the objects queued on ->bhead_free or ->head_free.
> > > @@ -3419,7 +3450,7 @@ schedule_page_work_fn(struct hrtimer *t)
> > >  	struct kfree_rcu_cpu *krcp =
> > >  		container_of(t, struct kfree_rcu_cpu, hrtimer);
> > >  
> > > -	queue_work(system_highpri_wq, &krcp->page_cache_work);
> > > +	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
> > >  	return HRTIMER_NORESTART;
> > >  }
> > >  
> > > @@ -3428,7 +3459,7 @@ static void fill_page_cache_func(struct work_struct *work)
> > >  	struct kvfree_rcu_bulk_data *bnode;
> > >  	struct kfree_rcu_cpu *krcp =
> > >  		container_of(work, struct kfree_rcu_cpu,
> > > -			page_cache_work);
> > > +			page_cache_work.work);
> > >  	unsigned long flags;
> > >  	bool pushed;
> > >  	int i;
> > > @@ -3457,10 +3488,14 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> > >  {
> > >  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> > >  			!atomic_xchg(&krcp->work_in_progress, 1)) {
> > > -		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
> > > -			HRTIMER_MODE_REL);
> > > -		krcp->hrtimer.function = schedule_page_work_fn;
> > > -		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> > > +		if (xchg(&backoff_page_cache_fill, 0UL)) {
> > 
> > How often can run_page_cache_worker() be invoked?  I am a bit
> > concerned about the possibility of heavy memory contention on the
> > backoff_page_cache_fill variable on large systems.  Unless there
> > is something that sharply bounds the frequency of calls to
> > run_page_cache_worker(), something like this would be more scalable:
> > 
> > 		if (backoff_page_cache_fill &&
> > 		    xchg(&backoff_page_cache_fill, 0UL)) {
> > 
> It is called per-cpu. Once the cache is empty it will be called. Next time
> will be after the worker completes filling the cache and krcp is run out of
> cache again. I do not consider it as high contention on the backoff_page_cache_fill
> variable. On my 64 CPUs system the run_page_cache_worker() itself does not
> consume much CPU cycles during the test:
> 
> Samples: 2K of event 'cycles:k', Event count (approx.): 1372274198                                                                                                                       
> Overhead  Command          Shared Object     Symbol                                                                                                                                      
>   27.45%  kworker/0:2-eve  [kernel.vmlinux]  [k] kmem_cache_free_bulk                                                                                                                    
>   14.56%  vmalloc_test/0   [kernel.vmlinux]  [k] kmem_cache_alloc_trace                                                                                                                  
>   11.34%  vmalloc_test/0   [kernel.vmlinux]  [k] kvfree_call_rcu                                                                                                                         
>    7.61%  vmalloc_test/0   [kernel.vmlinux]  [k] _raw_spin_unlock_irqrestore                                                                                                             
>    7.60%  vmalloc_test/0   [kernel.vmlinux]  [k] allocate_slab                                                                                                                           
>    5.38%  vmalloc_test/0   [kernel.vmlinux]  [k] check_preemption_disabled                                                                                                               
>    3.12%  vmalloc_test/0   [kernel.vmlinux]  [k] _raw_spin_lock                                                                                                                          
>    2.85%  vmalloc_test/0   [kernel.vmlinux]  [k] preempt_count_add                                                                                                                       
>    2.64%  vmalloc_test/0   [kernel.vmlinux]  [k] __list_del_entry_valid                                                                                                                  
>    2.53%  vmalloc_test/0   [kernel.vmlinux]  [k] preempt_count_sub                                                                                                                       
>    1.81%  vmalloc_test/0   [kernel.vmlinux]  [k] native_write_msr                                                                                                                        
>    1.05%  kworker/0:2-eve  [kernel.vmlinux]  [k] __slab_free                                                                                                                             
>    0.96%  vmalloc_test/0   [kernel.vmlinux]  [k] asm_sysvec_apic_timer_interrupt                                                                                                         
>    0.96%  vmalloc_test/0   [kernel.vmlinux]  [k] setup_object_debug.isra.69                                                                                                              
>    0.76%  kworker/0:2-eve  [kernel.vmlinux]  [k] free_pcppages_bulk                                                                                                                      
>    0.72%  kworker/0:2-eve  [kernel.vmlinux]  [k] put_cpu_partial                                                                                                                         
>    0.72%  vmalloc_test/0   [test_vmalloc]    [k] kvfree_rcu_2_arg_slab_test                                                                                                              
>    0.52%  kworker/0:2-eve  [kernel.vmlinux]  [k] kfree_rcu_work                                                                                                                          
>    0.52%  vmalloc_test/0   [kernel.vmlinux]  [k] get_page_from_freelist                                                                                                                  
>    0.52%  vmalloc_test/0   [kernel.vmlinux]  [k] run_page_cache_worker
> 
> <run_page_cache_worker>
>        │    arch_atomic_xchg():
>        │      mov   $0x1,%eax
>        │    run_page_cache_worker():
>        │      push  %rbx
>        │    arch_atomic_xchg():
>        │      xchg  %eax,0x188(%rdi)
>        │    run_page_cache_worker():
> 100.00 │      test  %eax,%eax
> <run_page_cache_worker>
> 
> <snip>
>     if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>         !atomic_xchg(&krcp->work_in_progress, 1)) { <-- here all cycles of run_page_cache_worker()
> <snip>

Understood, and the concern isn't so much lots of CPU time being burned
by the function, but rather the behavior when timing lines up badly.

> > It looks to me like all the CPUs could invoke run_page_cache_worker()
> > at the same time.  Or am I missing something that throttles calls to
> > run_page_cache_worker(), even on systems with hundreds of CPUs?
> >
> It is per-cpu, thus is serialized.

The cache is per-CPU, agreed, but backoff_page_cache_fill is global, right?

> > Also, if I am reading the code correctly, the unlucky first CPU to
> > attempt to refill cache after a shrinker invocation would be delayed
> > five seconds (thus invoking the slow path during that time), but other
> > CPUs would continue unimpeded.  Is this the intent?
> > 
> A backoff_page_cache_fill is global and shared among all CPUs. So, if one
> changes it following a slow path whereas all the rest will refill their
> caches anyway following a fast path.
> 
> That should be fixed making it per-cpu also. A shrinker should mark each
> CPU to back-off refilling.

That would be much better!

> > If I understand correctly, the point is to avoid the situation where
> > memory needed elsewhere is drained and then immediately refilled.
> > But the code will do the immediate refill when the rest of the CPUs show
> > up, correct?
> >
> Correct. We do not want to request pages for some period of time, because
> they might be needed for other needs and other users in a system. We have
> fall-backs, so there is no a high demand in it for our case.
> 
> > 
> > Might it be better to put a low cap on the per-CPU caches for some
> > period of time after the shrinker runs?  Maybe allow at most one page
> > to be cached for the five seconds following?
> > 
> That we can do!
> 
> > > +			queue_delayed_work(system_wq,
> > > +				&krcp->page_cache_work, PAGE_CACHE_FILL_DELAY);
> > > +		} else {
> > > +			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > > +			krcp->hrtimer.function = schedule_page_work_fn;
> > > +			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> > > +		}
> > >  	}
> > >  }
> > >  
> > > @@ -3612,14 +3647,20 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > >  {
> > >  	int cpu;
> > >  	unsigned long count = 0;
> > > +	unsigned long flags;
> > >  
> > >  	/* Snapshot count of all CPUs */
> > >  	for_each_possible_cpu(cpu) {
> > >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > >  
> > >  		count += READ_ONCE(krcp->count);
> > > +
> > > +		raw_spin_lock_irqsave(&krcp->lock, flags);
> > > +		count += krcp->nr_bkv_objs;
> > > +		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > 
> > Not a big deal given that this should not be invoked often, but couldn't
> > the read from ->nr_bkv_objs be READ_ONCE() without the lock?  (This would
> > require that updates use WRITE_ONCE() as well.)
> > 
> I was thinking about it. Will re-spin and rework :)

Sounds good, looking forward to seeing what you guys come up with!

							Thanx, Paul
