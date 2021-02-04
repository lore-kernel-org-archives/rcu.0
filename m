Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBA8C433DB
	for <rcu@archiver.kernel.org>; Thu,  4 Feb 2021 22:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF1164F8C
	for <rcu@archiver.kernel.org>; Thu,  4 Feb 2021 22:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhBDWFK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Feb 2021 17:05:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229513AbhBDWFJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 Feb 2021 17:05:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10D9C64E4A;
        Thu,  4 Feb 2021 22:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612476268;
        bh=qAAT9HJM7fwWVQbjvRZFdY2wmLu61Pae5PFcJmMxvus=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AOfsoaADnmbOOjbaaPvbhBwXuUa4tMIYeU1IHnDHnz8FSUaITsGDDnGCrc/Q8V3dd
         bs68jhJn2SflfvAluCUmSuJ4hV5G4IEBnq+OMpdcakPbiNLO4bqf+RNrwkrsw5psZ3
         IJiAWIPQ3JWXHB9FSuMtlSvcNkbiLcCWVx4tfGy5HchjHkq9J5A7AGjg07D8Xo/YB4
         E5jnsHXeiK6KwkyyElrcOgCH38dlpOc1dRaCfYzFe2yWgcQYrBasmx5xys84mPRymQ
         nBuDol2mQaZB+P95OomdpROLyUyH2MOxPZas0vr7Nnkwun67PrYBCky+uQ5Gv8TUcN
         uCfdjDnBPbeVA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AEF013522F5F; Thu,  4 Feb 2021 14:04:27 -0800 (PST)
Date:   Thu, 4 Feb 2021 14:04:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 2/2] kvfree_rcu: Use same set of flags as for
 single-argument
Message-ID: <20210204220427.GM2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210129200505.5273-1-urezki@gmail.com>
 <20210129200505.5273-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129200505.5273-2-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 29, 2021 at 09:05:05PM +0100, Uladzislau Rezki (Sony) wrote:
> Running an rcuscale stress-suite can lead to "Out of memory"
> of a system. This can happen under high memory pressure with
> a small amount of physical memory.
> 
> For example a KVM test configuration with 64 CPUs and 512 megabytes
> can lead to of memory after running rcuscale with below parameters:
> 
> ../kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig CONFIG_NR_CPUS=64 \
> --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 \
>   rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make
> 
> <snip>
> [   12.054448] kworker/1:1H invoked oom-killer: gfp_mask=0x2cc0(GFP_KERNEL|__GFP_NOWARN), order=0, oom_score_adj=0
> [   12.055303] CPU: 1 PID: 377 Comm: kworker/1:1H Not tainted 5.11.0-rc3+ #510
> [   12.055416] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> [   12.056485] Workqueue: events_highpri fill_page_cache_func
> [   12.056485] Call Trace:
> [   12.056485]  dump_stack+0x57/0x6a
> [   12.056485]  dump_header+0x4c/0x30a
> [   12.056485]  ? del_timer_sync+0x20/0x30
> [   12.056485]  out_of_memory.cold.47+0xa/0x7e
> [   12.056485]  __alloc_pages_slowpath.constprop.123+0x82f/0xc00
> [   12.056485]  __alloc_pages_nodemask+0x289/0x2c0
> [   12.056485]  __get_free_pages+0x8/0x30
> [   12.056485]  fill_page_cache_func+0x39/0xb0
> [   12.056485]  process_one_work+0x1ed/0x3b0
> [   12.056485]  ? process_one_work+0x3b0/0x3b0
> [   12.060485]  worker_thread+0x28/0x3c0
> [   12.060485]  ? process_one_work+0x3b0/0x3b0
> [   12.060485]  kthread+0x138/0x160
> [   12.060485]  ? kthread_park+0x80/0x80
> [   12.060485]  ret_from_fork+0x22/0x30
> [   12.062156] Mem-Info:
> [   12.062350] active_anon:0 inactive_anon:0 isolated_anon:0
> [   12.062350]  active_file:0 inactive_file:0 isolated_file:0
> [   12.062350]  unevictable:0 dirty:0 writeback:0
> [   12.062350]  slab_reclaimable:2797 slab_unreclaimable:80920
> [   12.062350]  mapped:1 shmem:2 pagetables:8 bounce:0
> [   12.062350]  free:10488 free_pcp:1227 free_cma:0
> ...
> [   12.101610] Out of memory and no killable processes...
> [   12.102042] Kernel panic - not syncing: System is deadlocked on memory
> [   12.102583] CPU: 1 PID: 377 Comm: kworker/1:1H Not tainted 5.11.0-rc3+ #510
> [   12.102600] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> <snip>
> 
> Having a fallback mechanism we should not go with "GFP_KERNEL | __GFP_NOWARN"
> that implies a "hard" page request involving OOM killer. Replace such set with
> the same as the one used for a single argument.
> 
> Thus it will follow same rules:
>     a) minimize a fallback hitting;
>     b) avoid of OOM invoking;
>     c) do a light-wait page request;
>     d) avoid of dipping into the emergency reserves.
> 
> With this change an rcuscale and the parameters which are in question
> never runs into "Kernel panic".
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

I did have some misgivings about this one, but after a closer look at
the GFP flags you suggest along with offlist discussions it looks like
what needs to happen.  So thank you for persisting!  ;-)

I did the usual wordsmithing as shown below, so please check to make
sure that I did not mess anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit f60c420f9de536e7fc397f0ad8d6677d782d0141
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Fri Jan 29 21:05:05 2021 +0100

    kvfree_rcu: Use same set of GFP flags as does single-argument
    
    Running an rcuscale stress-suite can lead to "Out of memory" of a
    system. This can happen under high memory pressure with a small amount
    of physical memory.
    
    For example, a KVM test configuration with 64 CPUs and 512 megabytes
    can result in OOM when running rcuscale with below parameters:
    
    ../kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig CONFIG_NR_CPUS=64 \
    --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 \
      rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make
    
    <snip>
    [   12.054448] kworker/1:1H invoked oom-killer: gfp_mask=0x2cc0(GFP_KERNEL|__GFP_NOWARN), order=0, oom_score_adj=0
    [   12.055303] CPU: 1 PID: 377 Comm: kworker/1:1H Not tainted 5.11.0-rc3+ #510
    [   12.055416] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
    [   12.056485] Workqueue: events_highpri fill_page_cache_func
    [   12.056485] Call Trace:
    [   12.056485]  dump_stack+0x57/0x6a
    [   12.056485]  dump_header+0x4c/0x30a
    [   12.056485]  ? del_timer_sync+0x20/0x30
    [   12.056485]  out_of_memory.cold.47+0xa/0x7e
    [   12.056485]  __alloc_pages_slowpath.constprop.123+0x82f/0xc00
    [   12.056485]  __alloc_pages_nodemask+0x289/0x2c0
    [   12.056485]  __get_free_pages+0x8/0x30
    [   12.056485]  fill_page_cache_func+0x39/0xb0
    [   12.056485]  process_one_work+0x1ed/0x3b0
    [   12.056485]  ? process_one_work+0x3b0/0x3b0
    [   12.060485]  worker_thread+0x28/0x3c0
    [   12.060485]  ? process_one_work+0x3b0/0x3b0
    [   12.060485]  kthread+0x138/0x160
    [   12.060485]  ? kthread_park+0x80/0x80
    [   12.060485]  ret_from_fork+0x22/0x30
    [   12.062156] Mem-Info:
    [   12.062350] active_anon:0 inactive_anon:0 isolated_anon:0
    [   12.062350]  active_file:0 inactive_file:0 isolated_file:0
    [   12.062350]  unevictable:0 dirty:0 writeback:0
    [   12.062350]  slab_reclaimable:2797 slab_unreclaimable:80920
    [   12.062350]  mapped:1 shmem:2 pagetables:8 bounce:0
    [   12.062350]  free:10488 free_pcp:1227 free_cma:0
    ...
    [   12.101610] Out of memory and no killable processes...
    [   12.102042] Kernel panic - not syncing: System is deadlocked on memory
    [   12.102583] CPU: 1 PID: 377 Comm: kworker/1:1H Not tainted 5.11.0-rc3+ #510
    [   12.102600] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
    <snip>
    
    Because kvfree_rcu() has a fallback path, memory allocation failure is
    not the end of the world.  Furthermore, the added overhead of aggressive
    GFP settings must be balanced against the overhead of the fallback path,
    which is a cache miss for double-argument kvfree_rcu() and a call to
    synchronize_rcu() for single-argument kvfree_rcu().  The current choice
    of GFP_KERNEL|__GFP_NOWARN can result in longer latencies than a call
    to synchronize_rcu(), so less-tenacious GFP flags would be helpful.
    
    Here is the tradeoff that must be balanced:
        a) Minimize use of the fallback path,
        b) Avoid pushing the system into OOM,
        c) Bound allocation latency to that of synchronize_rcu(), and
        d) Leave the emergency reserves to use cases lacking fallbacks.
    
    This commit therefore changes GFP flags from GFP_KERNEL|__GFP_NOWARN to
    GFP_KERNEL|__GFP_NORETRY|__GFP_NOMEMALLOC|__GFP_NOWARN.  This combination
    leaves the emergency reserves alone and can initiate reclaim, but will
    not invoke the OOM killer.
    
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1e86212..2c9cf4d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3435,7 +3435,7 @@ static void fill_page_cache_func(struct work_struct *work)
 
 	for (i = 0; i < rcu_min_cached_objs; i++) {
 		bnode = (struct kvfree_rcu_bulk_data *)
-			__get_free_page(GFP_KERNEL | __GFP_NOWARN);
+			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
 		if (bnode) {
 			raw_spin_lock_irqsave(&krcp->lock, flags);
