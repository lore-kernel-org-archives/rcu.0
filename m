Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65C5C433F5
	for <rcu@archiver.kernel.org>; Fri, 27 May 2022 23:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350729AbiE0XMK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 May 2022 19:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347750AbiE0XMJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 May 2022 19:12:09 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5E4134E06
        for <rcu@vger.kernel.org>; Fri, 27 May 2022 16:12:06 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id p123so6921908qke.5
        for <rcu@vger.kernel.org>; Fri, 27 May 2022 16:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a5q96MK6+l/WlUzvMNA0PSr/r1ec6rODdCeRRNTCeHM=;
        b=X9A2t49MfAiE+6sKpma8aWtNd9sjAusvYL92qSM3mbJlxaK+ERd2qjq2xC+P6IWNBs
         1q+8VnvmD4LeZCKoIZwWRTc0pYLgdRNEtBRNBYNTn6C/UWO7vPydnz7BZU8ieT54MSXM
         jaWNM6qLGsoQtaqXVN4o39Y0pOMUiUcZFjW6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a5q96MK6+l/WlUzvMNA0PSr/r1ec6rODdCeRRNTCeHM=;
        b=wedFCX7Sue/A7mikR16NrQV7sMgQ3v/hbTNqHdPhOrHPDHgv8ttMP77wgYT6jUs96z
         7+pq5SNYUsNNOhdsUvhR5TAoeFUrEkwaDGm3M1Z6oIX0HSzq/Y1l7LZPAefKBSxt2PIG
         af57b60K2RKlsVHW0+V4hXW7e7+Wxl7P29yebv/D7KgX/s1POV65LgY/6EyqpX0LWUA+
         YLgyWCmoeTRu+wymloRg5GmaUtPG/Ycr9iN8nHQDog5osoaYJF2SM1SuhyI2uLpc3dvx
         eP5cQ8r7y4DF94AjCM7GFfy08netyXqtEAGApWI6ki1/rP+SRkfAbLkxOBMom0KiWkRD
         4+Zg==
X-Gm-Message-State: AOAM531NcSKPWDRrx0z/k/f/5xKtetT+DLvFg3VPt2N9mHkcGiUoPW1T
        FLHAzC4oEaAVX0yx7WKII59VBw==
X-Google-Smtp-Source: ABdhPJxpjwkUTkNB/qLAKy9Uq0Fn4rOd5hOUDEbyfiVbz6xUdK94BL43353kt58TsR63xLqIcp4gFw==
X-Received: by 2002:a37:9381:0:b0:69f:62c6:56a7 with SMTP id v123-20020a379381000000b0069f62c656a7mr30506725qkd.643.1653693125009;
        Fri, 27 May 2022 16:12:05 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id p74-20020a37a64d000000b0069fc13ce1d7sm3583177qke.8.2022.05.27.16.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 16:12:04 -0700 (PDT)
Date:   Fri, 27 May 2022 23:12:03 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Message-ID: <YpFawyhgLCj1+X1A@google.com>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-2-joel@joelfernandes.org>
 <20220512235603.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yn/F8V5kYR8fybPV@google.com>
 <20220514163421.GR1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514163421.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, May 14, 2022 at 09:34:21AM -0700, Paul E. McKenney wrote:
> On Sat, May 14, 2022 at 03:08:33PM +0000, Joel Fernandes wrote:
> > Hi Paul,
> > 
> > Thanks for bearing with my slightly late reply, I did "time blocking"
> > technique to work on RCU today! ;-)
> > 
> > On Thu, May 12, 2022 at 04:56:03PM -0700, Paul E. McKenney wrote:
> > > On Thu, May 12, 2022 at 03:04:29AM +0000, Joel Fernandes (Google) wrote:
> > > > Implement timer-based RCU callback batching. The batch is flushed
> > > > whenever a certain amount of time has passed, or the batch on a
> > > > particular CPU grows too big. Also memory pressure can flush it.
> > > > 
> > > > Locking is avoided to reduce lock contention when queuing and dequeuing
> > > > happens on different CPUs of a per-cpu list, such as when shrinker
> > > > context is running on different CPU. Also not having to use locks keeps
> > > > the per-CPU structure size small.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > It is very good to see this!  Inevitable comments and questions below.
> > 
> > Thanks for taking a look!
> > 
> > > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > > index bf8e341e75b4..c09715079829 100644
> > > > --- a/kernel/rcu/Kconfig
> > > > +++ b/kernel/rcu/Kconfig
> > > > @@ -241,4 +241,12 @@ config TASKS_TRACE_RCU_READ_MB
> > > >  	  Say N here if you hate read-side memory barriers.
> > > >  	  Take the default if you are unsure.
> > > >  
> > > > +config RCU_LAZY
> > > > +	bool "RCU callback lazy invocation functionality"
> > > > +	depends on RCU_NOCB_CPU
> > > > +	default y
> > > 
> > > This "default y" is OK for experimentation, but for mainline we should
> > > not be forcing this on unsuspecting people.  ;-)
> > 
> > Agreed. I'll default 'n' :)
> > 
> > > > +	help
> > > > +	  To save power, batch RCU callbacks and flush after delay, memory
> > > > +          pressure or callback list growing too big.
> > > > +
> > > >  endmenu # "RCU Subsystem"
> > > > diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
> > > > index 0cfb009a99b9..8968b330d6e0 100644
> > > > --- a/kernel/rcu/Makefile
> > > > +++ b/kernel/rcu/Makefile
> > > > @@ -16,3 +16,4 @@ obj-$(CONFIG_RCU_REF_SCALE_TEST) += refscale.o
> > > >  obj-$(CONFIG_TREE_RCU) += tree.o
> > > >  obj-$(CONFIG_TINY_RCU) += tiny.o
> > > >  obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
> > > > +obj-$(CONFIG_RCU_LAZY) += lazy.o
> > > > diff --git a/kernel/rcu/lazy.c b/kernel/rcu/lazy.c
> > > > new file mode 100644
> > > > index 000000000000..55e406cfc528
> > > > --- /dev/null
> > > > +++ b/kernel/rcu/lazy.c
> > > > @@ -0,0 +1,145 @@
> > > > +/*
> > > > + * Lockless lazy-RCU implementation.
> > > > + */
> > > > +#include <linux/rcupdate.h>
> > > > +#include <linux/shrinker.h>
> > > > +#include <linux/workqueue.h>
> > > > +#include "rcu.h"
> > > > +
> > > > +// How much to batch before flushing?
> > > > +#define MAX_LAZY_BATCH		2048
> > > > +
> > > > +// How much to wait before flushing?
> > > > +#define MAX_LAZY_JIFFIES	10000
> > > 
> > > That is more than a minute on a HZ=10 system.  Are you sure that you
> > > did not mean "(10 * HZ)" or some such?
> > 
> > Yes, you are right. I need to change that to be constant regardless of HZ. I
> > will make the change as you suggest.
> > 
> > > > +
> > > > +// We cast lazy_rcu_head to rcu_head and back. This keeps the API simple while
> > > > +// allowing us to use lockless list node in the head. Also, we use BUILD_BUG_ON
> > > > +// later to ensure that rcu_head and lazy_rcu_head are of the same size.
> > > > +struct lazy_rcu_head {
> > > > +	struct llist_node llist_node;
> > > > +	void (*func)(struct callback_head *head);
> > > > +} __attribute__((aligned(sizeof(void *))));
> > > 
> > > This needs a build-time check that rcu_head and lazy_rcu_head are of
> > > the same size.  Maybe something like this in some appropriate context:
> > > 
> > > 	BUILD_BUG_ON(sizeof(struct rcu_head) != sizeof(struct_rcu_head_lazy));
> > > 
> > > Never mind!  I see you have this in rcu_init_lazy().  Plus I now see that
> > > you also mention this in the above comments.  ;-)
> > 
> > Cool, great minds think alike! ;-)
> > 
> > > > +
> > > > +struct rcu_lazy_pcp {
> > > > +	struct llist_head head;
> > > > +	struct delayed_work work;
> > > > +	atomic_t count;
> > > > +};
> > > > +DEFINE_PER_CPU(struct rcu_lazy_pcp, rcu_lazy_pcp_ins);
> > > > +
> > > > +// Lockless flush of CPU, can be called concurrently.
> > > > +static void lazy_rcu_flush_cpu(struct rcu_lazy_pcp *rlp)
> > > > +{
> > > > +	struct llist_node *node = llist_del_all(&rlp->head);
> > > > +	struct lazy_rcu_head *cursor, *temp;
> > > > +
> > > > +	if (!node)
> > > > +		return;
> > > 
> > > At this point, the list is empty but the count is non-zero.  Can
> > > that cause a problem?  (For the existing callback lists, this would
> > > be OK.)
> > > 
> > > > +	llist_for_each_entry_safe(cursor, temp, node, llist_node) {
> > > > +		struct rcu_head *rh = (struct rcu_head *)cursor;
> > > > +		debug_rcu_head_unqueue(rh);
> > > 
> > > Good to see this check!
> > > 
> > > > +		call_rcu(rh, rh->func);
> > > > +		atomic_dec(&rlp->count);
> > > > +	}
> > > > +}
> > > > +
> > > > +void call_rcu_lazy(struct rcu_head *head_rcu, rcu_callback_t func)
> > > > +{
> > > > +	struct lazy_rcu_head *head = (struct lazy_rcu_head *)head_rcu;
> > > > +	struct rcu_lazy_pcp *rlp;
> > > > +
> > > > +	preempt_disable();
> > > > +        rlp = this_cpu_ptr(&rcu_lazy_pcp_ins);
> > > 
> > > Whitespace issue, please fix.
> > 
> > Fixed, thanks.
> > 
> > > > +	preempt_enable();
> > > > +
> > > > +	if (debug_rcu_head_queue((void *)head)) {
> > > > +		// Probable double call_rcu(), just leak.
> > > > +		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> > > > +				__func__, head);
> > > > +
> > > > +		// Mark as success and leave.
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	// Queue to per-cpu llist
> > > > +	head->func = func;
> > > > +	llist_add(&head->llist_node, &rlp->head);
> > > 
> > > Suppose that there are a bunch of preemptions between the preempt_enable()
> > > above and this point, so that the current CPU's list has lots of
> > > callbacks, but zero ->count.  Can that cause a problem?
> > > 
> > > In the past, this sort of thing has been an issue for rcu_barrier()
> > > and friends.
> > 
> > Thanks, I think I dropped the ball on this. You have given me something to
> > think about. I am thinking on first thought that setting the count in advance
> > of populating the list should do the trick. I will look more on it.
> 
> That can work, but don't forget the need for proper memory ordering.
> 
> Another approach would be to what the current bypass list does, namely
> count the callback in the ->cblist structure.

I have been thinking about this, and I also arrived at the same conclusion
that it is easier to make it a segcblist structure which has the functions do
the memory ordering. Then we can make rcu_barrier() locklessly sample the
->len of the new per-cpu structure, I *think* it might work.

However, I was actually considering another situation outside of rcu_barrier,
where the preemptions you mentioned would cause the list to appear to be
empty if one were to rely on count, but actually have a lot of stuff queued.
This causes shrinkers to not know that there is a lot of memory available to
free. I don't think its that big an issue, if we can assume the caller's
process context to have sufficient priority. Obviously using a raw spinlock
makes the process context to be highest priority briefly but without the
lock, we don't get that. But yeah that can be sorted by just updating the
count proactively, and then doing the queuing operations.

Another advantage of using the segcblist structure, is, we can also record
the grace period numbers in it, and avoid triggering RCU from the timer if gp
already elapsed (similar to the rcu-poll family of functions).

WDYT?

thanks,

 - Joel

> > > > +	// Flush queue if too big
> > > 
> > > You will also need to check for early boot use.
> > > 
> > > I -think- it suffice to simply skip the following "if" statement when
> > > rcu_scheduler_active == RCU_SCHEDULER_INACTIVE suffices.  The reason being
> > > that you can queue timeouts at that point, even though CONFIG_PREEMPT_RT
> > > kernels won't expire them until the softirq kthreads have been spawned.
> > > 
> > > Which is OK, as it just means that call_rcu_lazy() is a bit more
> > > lazy than expected that early.
> > > 
> > > Except that call_rcu() can be invoked even before rcu_init() has been
> > > invoked, which is therefore also before rcu_init_lazy() has been invoked.
> > 
> > In other words, you are concerned that too many lazy callbacks might be
> > pending before rcu_init() is called?
> 
> In other words, I am concerned that bad things might happen if fields
> in a rcu_lazy_pcp structure are used before they are initialized.
> 
> I am not worried about too many lazy callbacks before rcu_init() because
> the non-lazy callbacks (which these currently are) are allowed to pile
> up until RCU's grace-period kthreads have been spawned.  There might
> come a time when RCU callbacks need to be invoked earlier, but that will
> be a separate problem to solve when and if, but with the benefit of the
> additional information derived from seeing the problem actually happen.
> 
> > I am going through the kfree_rcu() threads/patches involving
> > RCU_SCHEDULER_RUNNING check, but was the concern that queuing timers before
> > the scheduler is running causes a crash or warnings?
> 
> There are a lot of different issues that arise in different phases
> of boot.  In this particular case, my primary concern is the
> use-before-initialized bug.
> 
> > > I thefore suggest something like this at the very start of this function:
> > > 
> > > 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> > > 		call_rcu(head_rcu, func);
> > > 
> > > The goal is that people can replace call_rcu() with call_rcu_lazy()
> > > without having to worry about invocation during early boot.
> > 
> > Yes, this seems safer. I don't expect much power savings during system boot
> > process anyway ;-). I believe perhaps a static branch would work better to
> > take a branch out from what is likely a fast path.
> 
> A static branch would be fine.  Maybe encapsulate it in a static inline
> function for all such comparisons, but most such comparisons are far from
> anything resembling a fastpath, so the main potential benefit would be
> added readability.  Which could be a compelling reason in and of itself.
> 
> 							Thanx, Paul
> 
> > > Huh.  "head_rcu"?  Why not "rhp"?  Or follow call_rcu() with "head",
> > > though "rhp" is more consistent with the RCU pointer initials approach.
> > 
> > Fixed, thanks.
> > 
> > > > +	if (atomic_inc_return(&rlp->count) >= MAX_LAZY_BATCH) {
> > > > +		lazy_rcu_flush_cpu(rlp);
> > > > +	} else {
> > > > +		if (!delayed_work_pending(&rlp->work)) {
> > > 
> > > This check is racy because the work might run to completion right at
> > > this point.  Wouldn't it be better to rely on the internal check of
> > > WORK_STRUCT_PENDING_BIT within queue_delayed_work_on()?
> > 
> > Oops, agreed. Will make it as you suggest.
> > 
> > thanks,
> > 
> >  - Joel
> > 
> > > > +			schedule_delayed_work(&rlp->work, MAX_LAZY_JIFFIES);
> > > > +		}
> > > > +	}
> > > > +}
> > > > +
> > > > +static unsigned long
> > > > +lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > > > +{
> > > > +	unsigned long count = 0;
> > > > +	int cpu;
> > > > +
> > > > +	/* Snapshot count of all CPUs */
> > > > +	for_each_possible_cpu(cpu) {
> > > > +		struct rcu_lazy_pcp *rlp = per_cpu_ptr(&rcu_lazy_pcp_ins, cpu);
> > > > +
> > > > +		count += atomic_read(&rlp->count);
> > > > +	}
> > > > +
> > > > +	return count;
> > > > +}
> > > > +
> > > > +static unsigned long
> > > > +lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > > > +{
> > > > +	int cpu, freed = 0;
> > > > +
> > > > +	for_each_possible_cpu(cpu) {
> > > > +		struct rcu_lazy_pcp *rlp = per_cpu_ptr(&rcu_lazy_pcp_ins, cpu);
> > > > +		unsigned long count;
> > > > +
> > > > +		count = atomic_read(&rlp->count);
> > > > +		lazy_rcu_flush_cpu(rlp);
> > > > +		sc->nr_to_scan -= count;
> > > > +		freed += count;
> > > > +		if (sc->nr_to_scan <= 0)
> > > > +			break;
> > > > +	}
> > > > +
> > > > +	return freed == 0 ? SHRINK_STOP : freed;
> > > 
> > > This is a bit surprising given the stated aim of SHRINK_STOP to indicate
> > > potential deadlocks.  But this pattern is common, including on the
> > > kvfree_rcu() path, so OK!  ;-)
> > > 
> > > Plus do_shrink_slab() loops if you don't return SHRINK_STOP, so there is
> > > that as well.
> > > 
> > > > +}
> > > > +
> > > > +/*
> > > > + * This function is invoked after MAX_LAZY_JIFFIES timeout.
> > > > + */
> > > > +static void lazy_work(struct work_struct *work)
> > > > +{
> > > > +	struct rcu_lazy_pcp *rlp = container_of(work, struct rcu_lazy_pcp, work.work);
> > > > +
> > > > +	lazy_rcu_flush_cpu(rlp);
> > > > +}
> > > > +
> > > > +static struct shrinker lazy_rcu_shrinker = {
> > > > +	.count_objects = lazy_rcu_shrink_count,
> > > > +	.scan_objects = lazy_rcu_shrink_scan,
> > > > +	.batch = 0,
> > > > +	.seeks = DEFAULT_SEEKS,
> > > > +};
> > > > +
> > > > +void __init rcu_lazy_init(void)
> > > > +{
> > > > +	int cpu;
> > > > +
> > > > +	BUILD_BUG_ON(sizeof(struct lazy_rcu_head) != sizeof(struct rcu_head));
> > > > +
> > > > +	for_each_possible_cpu(cpu) {
> > > > +		struct rcu_lazy_pcp *rlp = per_cpu_ptr(&rcu_lazy_pcp_ins, cpu);
> > > > +		INIT_DELAYED_WORK(&rlp->work, lazy_work);
> > > > +	}
> > > > +
> > > > +	if (register_shrinker(&lazy_rcu_shrinker))
> > > > +		pr_err("Failed to register lazy_rcu shrinker!\n");
> > > > +}
> > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > index 24b5f2c2de87..a5f4b44f395f 100644
> > > > --- a/kernel/rcu/rcu.h
> > > > +++ b/kernel/rcu/rcu.h
> > > > @@ -561,4 +561,9 @@ void show_rcu_tasks_trace_gp_kthread(void);
> > > >  static inline void show_rcu_tasks_trace_gp_kthread(void) {}
> > > >  #endif
> > > >  
> > > > +#ifdef CONFIG_RCU_LAZY
> > > > +void rcu_lazy_init(void);
> > > > +#else
> > > > +static inline void rcu_lazy_init(void) {}
> > > > +#endif
> > > >  #endif /* __LINUX_RCU_H */
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index a4c25a6283b0..ebdf6f7c9023 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -4775,6 +4775,8 @@ void __init rcu_init(void)
> > > >  		qovld_calc = DEFAULT_RCU_QOVLD_MULT * qhimark;
> > > >  	else
> > > >  		qovld_calc = qovld;
> > > > +
> > > > +	rcu_lazy_init();
> > > >  }
> > > >  
> > > >  #include "tree_stall.h"
> > > > -- 
> > > > 2.36.0.550.gb090851708-goog
> > > > 
