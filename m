Return-Path: <SRS0=9J+a=7C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F91C433E0
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 13:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA54120748
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 13:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RW2QbuLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgETN2o (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 May 2020 09:28:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42792 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETN2o (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 May 2020 09:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6NkSTATdc+EBN2bxaA8ZPvbxxQ8lXoj7UgY/0mXcj9k=; b=RW2QbuLn9NBBL5Ykp3VpYkYVK0
        2QNe8a4ubFLEZvO+Xg4Zz+fE/zYWHk6ltL6wsg/Q6fSJuiylDg5wEP/mGW5UFVVwFJPXK9uGxpkOs
        p1KwU6uUjytXoEbpFBIEN9k8jkh3NUFBXNP9cNFlOtYjdnmJrxxlrBNfsCmR/xi2eiwqknezBEx4h
        3xfZ9PUg5TWi1rF6keaONy8Bylcx/xJf/CcA1/knUU/zBe43ZTuzP1D/Gw5v80xebfPZWhoWXw2l2
        /AhcxfIcq8G996Rw56IGeY3uiKUh5Sb+Sw0/meDSw4qdNJvTiq4VktmzQn7cF4u0bgswUaDh1jfkz
        deF2yhmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbOlK-0001KT-Ry; Wed, 20 May 2020 13:27:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C0826303DA0;
        Wed, 20 May 2020 15:27:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FEB029DB5053; Wed, 20 May 2020 15:27:55 +0200 (CEST)
Date:   Wed, 20 May 2020 15:27:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/8] srcu: Use local_lock() for per-CPU struct srcu_data
 access
Message-ID: <20200520132755.GM317569@hirez.programming.kicks-ass.net>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520120608.mwros5jurmidxxfv@linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 20, 2020 at 02:06:08PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-05-20 12:24:07 [+0200], Peter Zijlstra wrote:

> > Would it perhaps make sense to stick the local_lock in struct srcu_data ?
> 
> In that case we would need something for pointer stability before the
> lock is acquired.

Maybe I need sleep; but I think this will work.

 &x->foo = x + foo-offset

 this_cpu_ptr(x) = x + cpu-offset

 &this_cpu_ptr(x)->foo = (x + cpu-offset) + foo-offset
                       = (x + foo-offset) + cpu-offset
		       = this_cpu_ptr(&x->foo)

---
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -13,6 +13,7 @@
 
 #include <linux/rcu_node_tree.h>
 #include <linux/completion.h>
+#include <linux/locallock.h>
 
 struct srcu_node;
 struct srcu_struct;
@@ -22,6 +23,8 @@ struct srcu_struct;
  * to rcu_node.
  */
 struct srcu_data {
+	struct local_lock llock;
+
 	/* Read-side state. */
 	unsigned long srcu_lock_count[2];	/* Locks per CPU. */
 	unsigned long srcu_unlock_count[2];	/* Unlocks per CPU. */
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -778,13 +778,13 @@ static bool srcu_might_be_idle(struct sr
 	unsigned long tlast;
 
 	/* If the local srcu_data structure has callbacks, not idle.  */
-	local_irq_save(flags);
+	local_lock_irqsave(&ssp->sda->llock, flags);
 	sdp = this_cpu_ptr(ssp->sda);
 	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&ssp->sda->llock, flags);
 		return false; /* Callbacks already present, so not idle. */
 	}
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&ssp->sda->llock, flags);
 
 	/*
 	 * No local callbacks, so probabalistically probe global state.
@@ -864,7 +864,7 @@ static void __call_srcu(struct srcu_stru
 	}
 	rhp->func = func;
 	idx = srcu_read_lock(ssp);
-	local_irq_save(flags);
+	local_lock_irqsave(&ssp->sda->llock, flags);
 	sdp = this_cpu_ptr(ssp->sda);
 	spin_lock_rcu_node(sdp);
 	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
@@ -880,7 +880,8 @@ static void __call_srcu(struct srcu_stru
 		sdp->srcu_gp_seq_needed_exp = s;
 		needexp = true;
 	}
-	spin_unlock_irqrestore_rcu_node(sdp, flags);
+	spin_unlock_rcu_node(sdp);
+	local_unlock_irqrestore(&ssp->sda->llock, flags);
 	if (needgp)
 		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
 	else if (needexp)
