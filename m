Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34299C43381
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114DC64EFD
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhCDBAy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388877AbhCDAMS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:12:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E83DB64FD3;
        Thu,  4 Mar 2021 00:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816697;
        bh=tkAUtqlgtbGaZ3Ea1HKIpTF3HvvWrVZ0SZjS9Naz76Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3jnc4CwoB4ypjKjKEjvb/FRqUV+TQ/JW06qk1vg+n9fIXUJvfeQpm17Gh67j9RB0
         KG4kCr1tJ2b7Z/nX/xREYuYKUUjcPnInWlhklw8QDURHBJXrongkjzIniob3iHTz3h
         dzmp8C1Nv7D3dV5wfAGT4h3zjuMyUONQJKNk9inrJiOdl3Cq92+buWVoVRUyvj7oq8
         bJ5A0wZ1Z2ZMQzVemUhuIL7/FWEtNr5ailTiJYkGOuktNTiEeKcPP9S0b90vYi5tQW
         itthNJDyzAgnWUyik2RT+3yGWwjm0LrafPL6jXyL91yuc3PPZFazKPx9U1HhDX3/w7
         dpFVTzteB1rvA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 5/6] kvfree_rcu: Use same set of GFP flags as does single-argument
Date:   Wed,  3 Mar 2021 16:11:33 -0800
Message-Id: <20210304001134.22977-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304001044.GA22871@paulmck-ThinkPad-P72>
References: <20210304001044.GA22871@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

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
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ecc1fb..4120d4b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3463,7 +3463,7 @@ static void fill_page_cache_func(struct work_struct *work)
 
 	for (i = 0; i < rcu_min_cached_objs; i++) {
 		bnode = (struct kvfree_rcu_bulk_data *)
-			__get_free_page(GFP_KERNEL | __GFP_NOWARN);
+			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
 		if (bnode) {
 			raw_spin_lock_irqsave(&krcp->lock, flags);
-- 
2.9.5

