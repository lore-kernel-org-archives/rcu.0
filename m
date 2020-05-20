Return-Path: <SRS0=9J+a=7C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2D2C433DF
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 10:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168BA207ED
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 10:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="faG8a+VJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgETK3D (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 May 2020 06:29:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52856 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETK3D (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 May 2020 06:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pcnkdhzo7iybmY/3WHM6a4StwuJiDWWOYzMSkFwQnZk=; b=faG8a+VJtLLWswqGM9/4fhymDn
        ufqqw9OgQjgXYtTDE7nAqGEUdCbbE2Mt/fpp63fk46qu6qX+ljtb8wZ7wboqp/1JE6Q1rPogvGY7E
        aH+OHEZuBDWr0kx9FKcShW4Vdal8XB6MiwHbYBbwZSSOkSED9YHFeU/e8ovIYSim6E5QyJ6n1ICMI
        p52jeQShZ7j88YNZ4qqNCH0opOnYjNi5QkG/GSkh8Tupe7O2bax+HUl83cRkhQyjEGQvKlwawZFwR
        LZ6V1P4+spyRr73FS1hNVmp+QPPDGfrmUQOOTKLfjuTtJpy2VWT6Evp/B1+rON9sujijy0f9drG/r
        dI/lIRoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbLtW-0005Q2-Jj; Wed, 20 May 2020 10:24:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4543300478;
        Wed, 20 May 2020 12:24:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06F5325D60CB3; Wed, 20 May 2020 12:24:08 +0200 (CEST)
Date:   Wed, 20 May 2020 12:24:07 +0200
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
Message-ID: <20200520102407.GF317569@hirez.programming.kicks-ass.net>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519201912.1564477-4-bigeasy@linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, May 19, 2020 at 10:19:07PM +0200, Sebastian Andrzej Siewior wrote:

> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0c71505f0e19c..8d2b5f75145d7 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -25,6 +25,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/srcu.h>
> +#include <linux/locallock.h>
>  
>  #include "rcu.h"
>  #include "rcu_segcblist.h"
> @@ -735,6 +736,7 @@ static void srcu_flip(struct srcu_struct *ssp)
>  	smp_mb(); /* D */  /* Pairs with C. */
>  }
>  
> +static DEFINE_LOCAL_LOCK(sda_lock);
>  /*
>   * If SRCU is likely idle, return true, otherwise return false.
>   *
> @@ -765,13 +767,13 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
>  	unsigned long tlast;
>  
>  	/* If the local srcu_data structure has callbacks, not idle.  */
> -	local_irq_save(flags);
> +	local_lock_irqsave(sda_lock, flags);
>  	sdp = this_cpu_ptr(ssp->sda);
>  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
> -		local_irq_restore(flags);
> +		local_unlock_irqrestore(sda_lock, flags);
>  		return false; /* Callbacks already present, so not idle. */
>  	}
> -	local_irq_restore(flags);
> +	local_unlock_irqrestore(sda_lock, flags);

Would it perhaps make sense to stick the local_lock in struct srcu_data ?
