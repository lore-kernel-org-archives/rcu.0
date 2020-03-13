Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD585C10DCE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 09:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B702073E
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 09:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sh9MXIhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgCMJdb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:33:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgCMJda (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 05:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8pIGnk90C/eQbLnJ8p/15sfKmAvXSjOcwPwug3juja8=; b=sh9MXIhMbMo/jyATdPSOXudhHQ
        RAfYggc+QFxGmSCG2DbiXet21j7htLbmuakEwuPEsVTrSWNMYhaGSrcoj5Gh8nUzspgVTa98SicQE
        XrAh1FHucHldANEXZEBGVBcjaZ4V0k0BxPhJIrxY/LEzXu2QtCdS9ubYgedFZZPkAvfvazWmagsZD
        o4yMRmLzCdzVEvMW+yA08A+Ax85RnlHOEdwKaocMuWVvTWZ3s53c1CtKfxMwEo9bCqAOcCHnpQ3Vj
        jKU/B0Yj1ZS2obQDcjp4cTEqsZwhq4hAVyfNLzZPbG6DkhpbVf/jKE+Sn5JLB4N+VVosLcINBIkMZ
        7bbuTV0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCgh6-0005WP-67; Fri, 13 Mar 2020 09:33:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D01153011E0;
        Fri, 13 Mar 2020 10:33:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9759A214344F4; Fri, 13 Mar 2020 10:33:25 +0100 (CET)
Date:   Fri, 13 Mar 2020 10:33:25 +0100
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
Message-ID: <20200313093325.GW12561@hirez.programming.kicks-ass.net>
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

Thanks!

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 32406ef0d6a2..5142a6b11bf5 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1719,9 +1719,11 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
>  	this.class = class;
>  
>  	raw_local_irq_save(flags);
> +	current->lockdep_recursion = 1;
>  	arch_spin_lock(&lockdep_lock);
>  	ret = __lockdep_count_forward_deps(&this);
>  	arch_spin_unlock(&lockdep_lock);
> +	current->lockdep_recursion = 0;
>  	raw_local_irq_restore(flags);
>  
>  	return ret;
> @@ -1746,9 +1748,11 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
>  	this.class = class;
>  
>  	raw_local_irq_save(flags);
> +	current->lockdep_recursion = 1;
>  	arch_spin_lock(&lockdep_lock);
>  	ret = __lockdep_count_backward_deps(&this);
>  	arch_spin_unlock(&lockdep_lock);
> +	current->lockdep_recursion = 0;
>  	raw_local_irq_restore(flags);
>  
>  	return ret;

This copies a bad pattern though; all the sites that do not check
lockdep_recursion_count first really should be using ++/-- instead. But
I just found there are indeed already a few sites that violate this.

I've taken this patch and done a general fixup on top.

---
Subject: locking/lockdep: Fix bad recursion pattern
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Mar 13 09:56:38 CET 2020

There were two patterns for lockdep_recursion:

Pattern-A:
	if (current->lockdep_recursion)
		return

	current->lockdep_recursion = 1;
	/* do stuff */
	current->lockdep_recursion = 0;

Pattern-B:
	current->lockdep_recursion++;
	/* do stuff */
	current->lockdep_recursion--;

But a third pattern has emerged:

Pattern-C:
	current->lockdep_recursion = 1;
	/* do stuff */
	current->lockdep_recursion = 0;

And while this isn't broken per-se, it is highly dangerous because it
doesn't nest properly.

Get rid of all Pattern-C instances and shore up Pattern-A with a
warning.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   74 +++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -389,6 +389,12 @@ void lockdep_on(void)
 }
 EXPORT_SYMBOL(lockdep_on);
 
+static inline void lockdep_recursion_finish(void)
+{
+	if (WARN_ON_ONCE(--current->lockdep_recursion))
+		current->lockdep_recursion = 0;
+}
+
 void lockdep_set_selftest_task(struct task_struct *task)
 {
 	lockdep_selftest_task_struct = task;
@@ -1719,11 +1725,11 @@ unsigned long lockdep_count_forward_deps
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_forward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -1748,11 +1754,11 @@ unsigned long lockdep_count_backward_dep
 	this.class = class;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_backward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -3433,9 +3439,9 @@ void lockdep_hardirqs_on(unsigned long i
 	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
 		return;
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__trace_hardirqs_on_caller(ip);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 }
 NOKPROBE_SYMBOL(lockdep_hardirqs_on);
 
@@ -3491,7 +3497,7 @@ void trace_softirqs_on(unsigned long ip)
 		return;
 	}
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	/*
 	 * We'll do an OFF -> ON transition:
 	 */
@@ -3506,7 +3512,7 @@ void trace_softirqs_on(unsigned long ip)
 	 */
 	if (curr->hardirqs_enabled)
 		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 }
 
 /*
@@ -3759,9 +3765,9 @@ void lockdep_init_map(struct lockdep_map
 			return;
 
 		raw_local_irq_save(flags);
-		current->lockdep_recursion = 1;
+		current->lockdep_recursion++;
 		register_lock_class(lock, subclass, 1);
-		current->lockdep_recursion = 0;
+		lockdep_recursion_finish();
 		raw_local_irq_restore(flags);
 	}
 }
@@ -4441,11 +4447,11 @@ void lock_set_class(struct lockdep_map *
 		return;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	check_flags(flags);
 	if (__lock_set_class(lock, name, key, subclass, ip))
 		check_chain_key(current);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_set_class);
@@ -4458,11 +4464,11 @@ void lock_downgrade(struct lockdep_map *
 		return;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	check_flags(flags);
 	if (__lock_downgrade(lock, ip))
 		check_chain_key(current);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_downgrade);
@@ -4483,11 +4489,11 @@ void lock_acquire(struct lockdep_map *lo
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_acquire);
@@ -4501,11 +4507,11 @@ void lock_release(struct lockdep_map *lo
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	trace_lock_release(lock, ip);
 	if (__lock_release(lock, ip))
 		check_chain_key(current);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_release);
@@ -4521,9 +4527,9 @@ int lock_is_held_type(const struct lockd
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	ret = __lock_is_held(lock, read);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -4542,9 +4548,9 @@ struct pin_cookie lock_pin_lock(struct l
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	cookie = __lock_pin_lock(lock);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 
 	return cookie;
@@ -4561,9 +4567,9 @@ void lock_repin_lock(struct lockdep_map
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__lock_repin_lock(lock, cookie);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_repin_lock);
@@ -4578,9 +4584,9 @@ void lock_unpin_lock(struct lockdep_map
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__lock_unpin_lock(lock, cookie);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_unpin_lock);
@@ -4716,10 +4722,10 @@ void lock_contended(struct lockdep_map *
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	trace_lock_contended(lock, ip);
 	__lock_contended(lock, ip);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_contended);
@@ -4736,9 +4742,9 @@ void lock_acquired(struct lockdep_map *l
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	__lock_acquired(lock, ip);
-	current->lockdep_recursion = 0;
+	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_acquired);
@@ -4963,7 +4969,7 @@ static void free_zapped_rcu(struct rcu_h
 
 	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 
 	/* closed head */
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
@@ -4975,7 +4981,7 @@ static void free_zapped_rcu(struct rcu_h
 	 */
 	call_rcu_zapped(delayed_free.pf + delayed_free.index);
 
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 }
@@ -5022,11 +5028,11 @@ static void lockdep_free_key_range_reg(v
 
 	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion = 1;
+	current->lockdep_recursion++;
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
 	call_rcu_zapped(pf);
-	current->lockdep_recursion = 0;
+	current->lockdep_recursion--;
 	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 
