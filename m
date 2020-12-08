Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C165EC2BB40
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9D323AC0
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 15:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgLHPzk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 10:55:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbgLHPzk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 10:55:40 -0500
Date:   Tue, 8 Dec 2020 16:54:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607442900;
        bh=oeMJmaYdkYBRZuie6pH9o0N2Zu33NAcbpL9OlNBHGvM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPvERiQONzGEcL0ZxgpBFY0CnWmBAWZwhEtPY670+YmKEbh8op9bSqfmjCzOczaub
         UrDZnwmnifKIXlOwvrsBdeE0O3EeY8gA3PnXd9eHK/tXN3C8/duDOPTYqhpkT9myIP
         1YmeeN+ArKGnAcQeI7Qb/KelcG6z3IW8jBJhzLZ5gAH8Mz0PAEo65PwkVTGWMHvSXo
         ZM+Lk+ICQpuQYTQsWxvMw105+g9oFHpPdmO4z/AnFzN/ONT64Ge2qfqUxm5zjvO8Py
         fyK7VZ3yq0DoqS6Q8dNdtct7G7Gnyh3ceLoeSeaeCTV+po/Fss+NODgVth73VaswX6
         xj4qgPZ6jnQ3g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     boqun.feng@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: One potential issue with concurrent execution of RCU callbacks...
Message-ID: <20201208155457.GA3916@lothringen>
References: <20201208145810.GA4875@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208145810.GA4875@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 08, 2020 at 06:58:10AM -0800, Paul E. McKenney wrote:
> Hello, Frederic,
> 
> Boqun just asked if RCU callbacks ran in BH-disabled context to avoid
> concurrent execution of the same callback.  Of course, this raises the
> question of whether a self-posting callback can have two instances of
> itself running concurrently while a CPU is in the process of transitioning
> between softirq and rcuo invocation of callbacks.
> 
> I believe that the answer is "no" because BH-disabled context is
> an implicit RCU read-side critical section.  Therefore, the initial
> invocation of the RCU callback must complete in order for a new grace
> period to complete, and a new grace period must complete before the
> second invocation of that same callback to start.
> 
> Does that make sense, or am I missing something?

Sounds like a good explanation. But then why are we actually calling
the entire rcu_do_batch() under BH-disabled context? Was it to quieten
lockdep against rcu_callback_map ?

Wouldn't rcu_read_lock() around callbacks invocation be enough? Or is
there another reason for the BH-disabled context that I'm missing?

Untested below:

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bd04b09b84b3..207eff8a4e1a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2468,6 +2468,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 		debug_rcu_head_unqueue(rhp);
 
+		rcu_read_lock();
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_callback(rcu_state.name, rhp);
 
@@ -2476,6 +2477,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		f(rhp);
 
 		rcu_lock_release(&rcu_callback_map);
+		rcu_read_unlock();
 
 		/*
 		 * Stop only if limit reached and CPU has something to do.
@@ -2494,11 +2496,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		}
 		if (offloaded) {
 			WARN_ON_ONCE(in_serving_softirq());
-			local_bh_enable();
 			lockdep_assert_irqs_enabled();
 			cond_resched_tasks_rcu_qs();
 			lockdep_assert_irqs_enabled();
-			local_bh_disable();
 		}
 	}
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fd8a52e9a887..2a3d3c59d650 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2095,9 +2095,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	local_irq_save(flags);
 	rcu_momentary_dyntick_idle();
 	local_irq_restore(flags);
-	local_bh_disable();
 	rcu_do_batch(rdp);
-	local_bh_enable();
 	lockdep_assert_irqs_enabled();
 	rcu_nocb_lock_irqsave(rdp, flags);
 	if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&

