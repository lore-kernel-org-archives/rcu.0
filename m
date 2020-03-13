Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753B8C4CECE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 10:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4D42073E
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 10:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jmgce857"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCMKVM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:21:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59200 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgCMKVM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 06:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UNS9qfdE8QK8g+6d8TkL9IzCb5kYV8ynuRbXqP8orQU=; b=jmgce857R/Quhq12vgQJA2bK3P
        dNHeyC0SfGhC4DosYbWBYqqNOswRjd0HLKNNT4sD1H+aTUZX8ohBg15HghZ0LQ7R5/gYAKbd4+XZ2
        KMpf2a+NoSgJiDnYTvrFPX8ZeMyfKT4u8rK0FqN2VWlCUrWZQgjd9Vq5LF27KP3iZT/cC1PA8nd/i
        vbc3PwQULoSQlRwoNHbknjO3WsZlfNOGpUf2QRdc+2RmqvPp2wZm5Ebsh2L+4k3mVqzZPxkWOr539
        no9JCHgd6mUS6yxMxoMXDu+jWCFNAI+PIrslYQq+n1fR6WCEdrThvSHTj/pFXNdGdmZnWNjb/iD/8
        LqolF4sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jChRF-00077H-SL; Fri, 13 Mar 2020 10:21:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11629300470;
        Fri, 13 Mar 2020 11:21:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3A822B64FF63; Fri, 13 Mar 2020 11:21:07 +0100 (CET)
Date:   Fri, 13 Mar 2020 11:21:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] locking/lockdep: Avoid recursion in
 lockdep_count_{for,back}ward_deps()
Message-ID: <20200313102107.GX12561@hirez.programming.kicks-ass.net>
References: <20200312151258.128036-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312151258.128036-1-boqun.feng@gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 12, 2020 at 11:12:55PM +0800, Boqun Feng wrote:
> The warning got triggered because lockdep_count_forward_deps() call
> __bfs() without current->lockdep_recursion being set, as a result
> a lockdep internal function (__bfs()) is checked by lockdep, which is
> unexpected, and the inconsistency between the irq-off state and the
> state traced by lockdep caused the warning.

This also had me look at __bfs(), while there is a WARN in there, it
doesn't really assert all the expectations.

This lead to the below patch.

---
Subject: locking/lockdep: Rework lockdep_lock
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Mar 13 11:09:49 CET 2020

A few sites want to assert we own the graph_lock/lockdep_lock, provide
a more conventional lock interface for it with a number of trivial
debug checks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   89 +++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -84,12 +84,39 @@ module_param(lock_stat, int, 0644);
  * to use a raw spinlock - we really dont want the spinlock
  * code to recurse back into the lockdep code...
  */
-static arch_spinlock_t lockdep_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static arch_spinlock_t __lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static struct task_struct *__owner;
+
+static inline void lockdep_lock(void)
+{
+	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+
+	arch_spin_lock(&__lock);
+	__owner = current;
+	current->lockdep_recursion++;
+}
+
+static inline void lockdep_unlock(void)
+{
+	if (debug_locks && DEBUG_LOCKS_WARN_ON(__owner != current))
+		return;
+
+	current->lockdep_recursion--;
+	__owner = NULL;
+	arch_spin_unlock(&__lock);
+}
+
+static inline bool lockdep_assert_locked(void)
+{
+	return DEBUG_LOCKS_WARN_ON(__owner != current);
+}
+
 static struct task_struct *lockdep_selftest_task_struct;
 
+
 static int graph_lock(void)
 {
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	/*
 	 * Make sure that if another CPU detected a bug while
 	 * walking the graph we dont change it (while the other
@@ -97,27 +124,15 @@ static int graph_lock(void)
 	 * dropped already)
 	 */
 	if (!debug_locks) {
-		arch_spin_unlock(&lockdep_lock);
+		lockdep_unlock();
 		return 0;
 	}
-	/* prevent any recursions within lockdep from causing deadlocks */
-	current->lockdep_recursion++;
 	return 1;
 }
 
-static inline int graph_unlock(void)
+static inline void graph_unlock(void)
 {
-	if (debug_locks && !arch_spin_is_locked(&lockdep_lock)) {
-		/*
-		 * The lockdep graph lock isn't locked while we expect it to
-		 * be, we're confused now, bye!
-		 */
-		return DEBUG_LOCKS_WARN_ON(1);
-	}
-
-	current->lockdep_recursion--;
-	arch_spin_unlock(&lockdep_lock);
-	return 0;
+	lockdep_unlock();
 }
 
 /*
@@ -128,7 +143,7 @@ static inline int debug_locks_off_graph_
 {
 	int ret = debug_locks_off();
 
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 
 	return ret;
 }
@@ -1475,6 +1490,8 @@ static int __bfs(struct lock_list *sourc
 	struct circular_queue *cq = &lock_cq;
 	int ret = 1;
 
+	lockdep_assert_locked();
+
 	if (match(source_entry, data)) {
 		*target_entry = source_entry;
 		ret = 0;
@@ -1497,8 +1514,6 @@ static int __bfs(struct lock_list *sourc
 
 		head = get_dep_list(lock, offset);
 
-		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
-
 		list_for_each_entry_rcu(entry, head, entry) {
 			if (!lock_accessed(entry)) {
 				unsigned int cq_depth;
@@ -1725,11 +1740,9 @@ unsigned long lockdep_count_forward_deps
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion++;
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	ret = __lockdep_count_forward_deps(&this);
-	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion--;
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -1754,11 +1767,9 @@ unsigned long lockdep_count_backward_dep
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion++;
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	ret = __lockdep_count_backward_deps(&this);
-	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion--;
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -2813,7 +2824,7 @@ static inline int add_chain_cache(struct
 	 * disabled to make this an IRQ-safe lock.. for recursion reasons
 	 * lockdep won't complain about its own locking errors.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+	if (lockdep_assert_locked())
 		return 0;
 
 	chain = alloc_lock_chain();
@@ -4968,8 +4979,7 @@ static void free_zapped_rcu(struct rcu_h
 		return;
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion++;
+	lockdep_lock();
 
 	/* closed head */
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
@@ -4981,8 +4991,7 @@ static void free_zapped_rcu(struct rcu_h
 	 */
 	call_rcu_zapped(delayed_free.pf + delayed_free.index);
 
-	current->lockdep_recursion--;
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 }
 
@@ -5027,13 +5036,11 @@ static void lockdep_free_key_range_reg(v
 	init_data_structures_once();
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion++;
+	lockdep_lock();
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
 	call_rcu_zapped(pf);
-	current->lockdep_recursion--;
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	/*
@@ -5055,10 +5062,10 @@ static void lockdep_free_key_range_imm(v
 	init_data_structures_once();
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	__lockdep_free_key_range(pf, start, size);
 	__free_zapped_classes(pf);
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 }
 
@@ -5154,10 +5161,10 @@ static void lockdep_reset_lock_imm(struc
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
+	lockdep_lock();
 	__lockdep_reset_lock(pf, lock);
 	__free_zapped_classes(pf);
-	arch_spin_unlock(&lockdep_lock);
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 }
 
