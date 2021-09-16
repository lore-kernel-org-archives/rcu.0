Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574E4C433EF
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 07:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32934611C4
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 07:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhIPHex (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Sep 2021 03:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhIPHes (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Sep 2021 03:34:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFF9C061574;
        Thu, 16 Sep 2021 00:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qHNfLeTTuZfnzd/uOTUee6pz65BnA4uqgnZYqxCX4kc=; b=T+sd67wdt5VX5+wVY5Mccg9dNT
        OCXYNY5erNoRRPVT/7d5Q2+vQ9gvB4tgF3ocjJkJrBfuRaFZn+SHu131lQydh3vQhIhKIo5Uujjg0
        8ZUQwGeY3MKVlhSlw//R/GELWGf2+PVJYBF0B6ZToof39eLtKSIOXw3VlfWJWLWz2cEYtlVKf59k/
        Jx0kmwTivkRbWFpat/8t9Q7unC1wrB7M7RE70W0SLZUCW8AfFTV5ZphXnCPn1wjLXPhGM5bzwfRF/
        TpPoDVl4JRvv7h4xqmtQuhN7BjFjAsSYOYo2dAh4D63SE6B1MjB8uUGJn0+QZs/2V1hVBA6WvB/xE
        SePvrSFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQlqc-00GQ0M-3m; Thu, 16 Sep 2021 07:30:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5740F30021A;
        Thu, 16 Sep 2021 09:30:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 444DD200A5E23; Thu, 16 Sep 2021 09:30:17 +0200 (CEST)
Date:   Thu, 16 Sep 2021 09:30:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH rcu 11/14] rcu: Make rcu_normal_after_boot writable again
Message-ID: <YULyiT+RbAgHxO7u@hirez.programming.kicks-ass.net>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
 <20210915233343.3906738-11-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915233343.3906738-11-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 15, 2021 at 04:33:40PM -0700, Paul E. McKenney wrote:
> From: Juri Lelli <juri.lelli@redhat.com>
> 
> Certain configurations (e.g., systems that make heavy use of netns)
> need to use synchronize_rcu_expedited() to service RCU grace periods
> even after boot.
> 
> Even though synchronize_rcu_expedited() has been traditionally
> considered harmful for RT for the heavy use of IPIs, it is perfectly
> usable under certain conditions (e.g. nohz_full).
> 
> Make rcupdate.rcu_normal_after_boot= again writeable on RT (if NO_HZ_
> FULL is defined), but keep its default value to 1 (enabled) to avoid
> regressions. Users who need synchronize_rcu_expedited() will boot with
> rcupdate.rcu_normal_after_ boot=0 in the kernel cmdline.
> 
> Reflect the change in synchronize_rcu_expedited_wait() by removing the
> WARN related to CONFIG_PREEMPT_RT.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree_exp.h | 1 -
>  kernel/rcu/update.c   | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 2796084ef85a..d9e4f8eb9ae2 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -512,7 +512,6 @@ static void synchronize_rcu_expedited_wait(void)
>  		j = READ_ONCE(jiffies_till_first_fqs);
>  		if (synchronize_rcu_expedited_wait_once(j + HZ))
>  			return;
> -		WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT));
>  	}
>  
>  	for (;;) {

Urgh... I really don't like this. That would force RT applications to
always use NOHZ_FULL which isn't always possible or desired.

WTH does that netns crud need expedited so much?
