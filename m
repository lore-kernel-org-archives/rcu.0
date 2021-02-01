Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A424C43381
	for <rcu@archiver.kernel.org>; Mon,  1 Feb 2021 11:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED84164E50
	for <rcu@archiver.kernel.org>; Mon,  1 Feb 2021 11:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhBALsu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:48:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:45872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhBALss (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 1 Feb 2021 06:48:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612180081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sYO1CC2iNSDFN8ExAzc5XfEB8fy4Idu9RVgSIIaRCuA=;
        b=NXfomLHIjrxGyvWEQV428D+njaP198puo7bpZbZJmX9JPGVK1eyJr0g4L0g/9Of+0jMdVm
        VNqEncxWOdC0WJGH6nWDTwKSl34aCjq3i18xR2QWUTSwfDD3WnEdMQH5jySOR0vGjB21Lh
        ACqeMavvowEWqMpuQAWtL5wPlhEG1JA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 122AEABD5;
        Mon,  1 Feb 2021 11:48:01 +0000 (UTC)
Date:   Mon, 1 Feb 2021 12:47:55 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: Re: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Message-ID: <YBfqa/LzVAG4+zZt@dhcp22.suse.cz>
References: <20210125132236.GJ827@dhcp22.suse.cz>
 <20210125143150.GA2282@pc638.lan>
 <20210125153943.GN827@dhcp22.suse.cz>
 <20210125162559.GA52712@pc638.lan>
 <20210128151152.GA1867@pc638.lan>
 <YBLVbZzy0KSONizm@dhcp22.suse.cz>
 <20210128153017.GA2006@pc638.lan>
 <20210128180237.GA5144@pc638.lan>
 <YBPNvbJLg56XU8co@dhcp22.suse.cz>
 <20210129163531.GA30500@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129163531.GA30500@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri 29-01-21 17:35:31, Uladzislau Rezki wrote:
> On Fri, Jan 29, 2021 at 09:56:29AM +0100, Michal Hocko wrote:
> > On Thu 28-01-21 19:02:37, Uladzislau Rezki wrote:
> > [...]
> > > >From 0bdb8ca1ae62088790e0a452c4acec3821e06989 Mon Sep 17 00:00:00 2001
> > > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > > Date: Wed, 20 Jan 2021 17:21:46 +0100
> > > Subject: [PATCH v2 1/1] kvfree_rcu: Directly allocate page for single-argument
> > >  case
> > > 
> > > Single-argument kvfree_rcu() must be invoked from sleepable contexts,
> > > so we can directly allocate pages.  Furthermmore, the fallback in case
> > > of page-allocation failure is the high-latency synchronize_rcu(), so it
> > > makes sense to do these page allocations from the fastpath, and even to
> > > permit limited sleeping within the allocator.
> > > 
> > > This commit therefore allocates if needed on the fastpath using
> > > GFP_KERNEL|__GFP_NORETRY.
> > 
> > Yes, __GFP_NORETRY as a lightweight allocation mode should be fine. It
> > is more robust than __GFP_NOWAIT on memory usage spikes.  The caller is
> > prepared to handle the failure which is likely much less disruptive than
> > OOM or potentially heavy reclaim __GFP_RETRY_MAYFAIL.
> > 
> > I cannot give you ack as I am not familiar with the code but this makes
> > sense to me.
> > 
> No problem, i can separate it. We can have a patch on top of what we have so
> far. The patch only modifies the gfp_mask passed to __get_free_pages():
> 
> >From ec2feaa9b7f55f73b3b17e9ac372151c1aab5ae0 Mon Sep 17 00:00:00 2001
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Date: Fri, 29 Jan 2021 17:16:03 +0100
> Subject: [PATCH 1/1] kvfree_rcu: replace __GFP_RETRY_MAYFAIL by __GFP_NORETRY
> 
> __GFP_RETRY_MAYFAIL is a bit heavy from reclaim process of view,
> therefore a time consuming. That is not optional and there is
> no need in doing it so hard, because we have a fallback path.
> 
> __GFP_NORETRY in its turn can perform some light-weight reclaim
> and it rather fails under high memory pressure or low memory
> condition.
> 
> In general there are four simple criterias we we would like to
> achieve:
>     a) minimize a fallback hitting;
>     b) avoid of OOM invoking;
>     c) do a light-wait page request;
>     d) avoid of dipping into the emergency reserves.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Looks good to me. Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  kernel/rcu/tree.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 70ddc339e0b7..1e862120db9e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3489,8 +3489,20 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  		bnode = get_cached_bnode(*krcp);
>  		if (!bnode && can_alloc) {
>  			krc_this_cpu_unlock(*krcp, *flags);
> +
> +			// __GFP_NORETRY - allows a light-weight direct reclaim
> +			// what is OK from minimizing of fallback hitting point of
> +			// view. Apart of that it forbids any OOM invoking what is
> +			// also beneficial since we are about to release memory soon.
> +			//
> +			// __GFP_NOMEMALLOC - prevents from consuming of all the
> +			// memory reserves. Please note we have a fallback path.
> +			//
> +			// __GFP_NOWARN - it is supposed that an allocation can
> +			// be failed under low memory or high memory pressure
> +			// scenarios.
>  			bnode = (struct kvfree_rcu_bulk_data *)
> -				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
> +				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
>  			*krcp = krc_this_cpu_lock(flags);
>  		}
>  
> -- 
> 2.20.1
> 
> --
> Vlad Rezki

-- 
Michal Hocko
SUSE Labs
