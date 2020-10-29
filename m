Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86432C2D0A3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 21:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E5C20838
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 21:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604006822;
	bh=8eAKef+YpREHxjGeEjN7vHMHjrf/hI/K8pj95uKY1UU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=kNWy6TbWtdTD6kBQ0Io/pAoSiHu1LBTQkof44TU8FaJHY4pJqe2lh0N+rLIgshGjI
	 FZf+RJTSNORXG7T9LhvSklBDvDEx8UQcrtXxCRoZcneASdDM6IiYcZUcZ5B7+akUhy
	 Ma7EhmXQQZM8BAJvmLhnVT2TSXKW67dWU4CDng5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgJ2V1B (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgJ2V1B (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 17:27:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B07320809;
        Thu, 29 Oct 2020 21:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604006820;
        bh=8eAKef+YpREHxjGeEjN7vHMHjrf/hI/K8pj95uKY1UU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JRquy4yJx1BaQdsQZKXgf3B/vk5/LLYdU66eXmLM1dY0a5VlcC6xjQJI0wvT7nrtD
         Xbe1MWEEtDUGHLvWcOwjTMiarr7pszU5wdR3TwDVrCDvauQBoYzBz7J3rJ0vzT88Id
         cyYXpaALEe5hCKuXA2rJRa6lK1V+o5cb7MjZfjRE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 74F6E35225DF; Thu, 29 Oct 2020 14:26:59 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:26:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH 06/16] mm/pagemap: Cleanup PREEMPT_COUNT leftovers
Message-ID: <20201029212659.GP3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201029165019.14218-6-urezki@gmail.com>
 <20201029205717.GA24578@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029205717.GA24578@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 29, 2020 at 09:57:17PM +0100, Uladzislau Rezki wrote:
> On Thu, Oct 29, 2020 at 05:50:09PM +0100, Uladzislau Rezki (Sony) wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
> > removed. Cleanup the leftovers before doing so.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  include/linux/pagemap.h | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index c77b7c31b2e4..cbfbe2bcca75 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -204,9 +204,7 @@ void release_pages(struct page **pages, int nr);
> >  static inline int __page_cache_add_speculative(struct page *page, int count)
> >  {
> >  #ifdef CONFIG_TINY_RCU
> > -# ifdef CONFIG_PREEMPT_COUNT
> > -	VM_BUG_ON(!in_atomic() && !irqs_disabled());
> > -# endif
> > +	VM_BUG_ON(preemptible())
> >  	/*
> >  	 * Preempt must be disabled here - we rely on rcu_read_lock doing
> >  	 * this for us.
> > -- 
> > 2.20.1
> > 
> Hello, Paul.
> 
> Sorry for a small mistake, it was fixed by you before, whereas i took an
> old version of the patch that is question. Please use below one instead of
> posted one:

We have all been there and done that!  ;-)

I will give this update a spin and see what happens.

							Thanx, Paul

> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Mon Sep 14 19:25:00 2020 +0200
> 
>     mm/pagemap: Cleanup PREEMPT_COUNT leftovers
>     
>     CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
>     removed. Cleanup the leftovers before doing so.
>     
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Andrew Morton <akpm@linux-foundation.org>
>     Cc: linux-mm@kvack.org
>     [ paulmck: Fix !SMP build error per kernel test robot feedback. ]
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 7de11dcd534d..b3d9d9217ea0 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -168,9 +168,7 @@ void release_pages(struct page **pages, int nr);
>  static inline int __page_cache_add_speculative(struct page *page, int count)
>  {
>  #ifdef CONFIG_TINY_RCU
> -# ifdef CONFIG_PREEMPT_COUNT
> -       VM_BUG_ON(!in_atomic() && !irqs_disabled());
> -# endif
> +       VM_BUG_ON(preemptible());
>         /*
>          * Preempt must be disabled here - we rely on rcu_read_lock doing
>          * this for us.
> 
> --
> Vlad Rezki
