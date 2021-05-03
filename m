Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B73EC43460
	for <rcu@archiver.kernel.org>; Mon,  3 May 2021 17:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7F661176
	for <rcu@archiver.kernel.org>; Mon,  3 May 2021 17:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhECRBn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 May 2021 13:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233386AbhECQ5R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 May 2021 12:57:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AD886117A;
        Mon,  3 May 2021 16:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620060444;
        bh=rqiShYz2NDHqM5EtsoLoM7q+/D2LQEFZDElDZCdsSlQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qeAZKVivkiGyI0gCis7qBTBQlLQdTnTEA+ilBPTnExDRAe4JK9QbLs59Br8bYd+o+
         ikZ+qfuI6P99gMW2KD33VpvYux1jXQvC+9ubCS4R5xEFGKcCXSJsJjKzDDvUiIeIcC
         oqxKaJVgOnzDW6Dow+Yw3plPOadXyZth8QI+pg26BGrg0b1knnZRuKoUQ7Lsd179Qe
         AZPykKbG2eww+0WJ44osFqZlArL+e08GPDaPIG0PJnvNP6U41mAVORltlGeBu6AQKr
         07mnXNxPMohkR/lvtCkWxMDBOhcI/hZT/y1xHSgOS5Ea3z7dIcelchKGE39JRUVHo5
         f0nQrgulggpmA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E04905C0546; Mon,  3 May 2021 09:47:23 -0700 (PDT)
Date:   Mon, 3 May 2021 09:47:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 5/5] kvfree_rcu: Fix comments according to current code
Message-ID: <20210503164723.GX975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210428134422.1894-1-urezki@gmail.com>
 <20210428134422.1894-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428134422.1894-5-urezki@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 28, 2021 at 03:44:22PM +0200, Uladzislau Rezki (Sony) wrote:
> We used to have an "emergency path" and comments related
> to it. According to current kvfree_rcu() design that path
> is not considered as emergency anymore.
> 
> This patch rephrases and updates comments regarding this.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Queued as follows, thank you!  Please check my usual wordsmithing to
make sure that I did not mess anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 06c2113c4b1ce9ded69cd0ac4da9a00ed6be8834
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Wed Apr 28 15:44:22 2021 +0200

    kvfree_rcu: Fix comments according to current code
    
    The kvfree_rcu() function now defers allocations in the common
    case due to the fact that there is no lockless access to the
    memory-allocator caches/pools.  In addition, in CONFIG_PREEMPT_NONE=y
    and in CONFIG_PREEMPT_VOLUNTARY=y kernels, there is no reliable way to
    determine if spinlocks are held.  As a result, allocation is deferred in
    the common case, and the two-argument form of kvfree_rcu() thus uses the
    "channel 3" queue through all the rcu_head structures.  This channel
    is called referred to as the emergency case in comments, and these
    comments are now obsolete.
    
    This commit therefore updates these comments to reflect the new
    common-case nature of such emergencies.
    
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9089c23e80dc..4d93c6985d3f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3338,9 +3338,11 @@ static void kfree_rcu_work(struct work_struct *work)
 	}
 
 	/*
-	 * Emergency case only. It can happen under low memory
-	 * condition when an allocation gets failed, so the "bulk"
-	 * path can not be temporary maintained.
+	 * This is used when the "bulk" path can not be used for the
+	 * double-argument of kvfree_rcu().  This happens when the
+	 * page-cache is empty, which means that objects are instead
+	 * queued on a linked list through their rcu_head structures.
+	 * This list is named "Channel 3".
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
@@ -3386,8 +3388,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
 			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
 				(krcp->head && !krwp->head_free)) {
-			// Channel 1 corresponds to SLAB ptrs.
-			// Channel 2 corresponds to vmalloc ptrs.
+			// Channel 1 corresponds to the SLAB-pointer bulk path.
+			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
 				if (!krwp->bkvhead_free[j]) {
 					krwp->bkvhead_free[j] = krcp->bkvhead[j];
@@ -3395,7 +3397,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 				}
 			}
 
-			// Channel 3 corresponds to emergency path.
+			// Channel 3 corresponds to both SLAB and vmalloc
+			// objects queued on the linked list.
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
 				krcp->head = NULL;
