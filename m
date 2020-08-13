Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1D9C433E3
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A78206A4
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 09:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8hKs/8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMJ6s (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMJ6q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 05:58:46 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42B5C061757;
        Thu, 13 Aug 2020 02:58:45 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k13so2733490lfo.0;
        Thu, 13 Aug 2020 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UyyZZE/2hrI5pOfNwgwq2kKxJCRXXA9GaoM4CUdPbWE=;
        b=c8hKs/8hkf2jlLMx0WeO2/5GuDxqu/gz/W0NzFQoCPFOu4e1T9fu6sb92SeNYwzBSl
         xggYJ+ivOFmVs7j6uHkuWs2dJP+uzgWHHlxopt9NiqvpwHgWuFvVZex96OvQrdqO5z0B
         +LI23MRb4y1glgWJEIYXSnoneKIrp7n5llO4wSkSA62yHc0Z2aCOOyrHm45IUFxgC4CP
         fch7DzAHjc7QfsFsknW0ifXdBardqVqcF5XPqcUop7rrijW3elzer/DfW90qRYemuzNS
         jXkbr3inhiD/SOqegoMK6qan6sZnUxcNhDiMqc5YnF0ts5oVVm2MLcwOV0v9IZX0SmFF
         rwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UyyZZE/2hrI5pOfNwgwq2kKxJCRXXA9GaoM4CUdPbWE=;
        b=AersgUssqlo25kjy8iwr4bjeHLe6iLZdgaEv5ThK9Vh80XsT+K308t4nU+nJNKiaEQ
         XSMTvJ65T/YqcFjUUeT4b5r40rZ+GZTeYIfOkdETx9oKSskqiq57DvGiA7cQgkUN9sxL
         mxO12rbVEIN045ncSh5L/YnkolIEpLSKCTODjJZD5P+W/in50BeZCceR7qWpLzOYQqBY
         VJ2l7j7OOILgL8RRp45nECOwNI3C6CdBFTpU0dWSAsuD8ua82VztT4oheetay/Z9k9SD
         kwomSXm+mwYaBhJLSHM4GEQLXKQ1/MFJymgJZGd7pyAhiteK0JIGMCCGIAyCAzq4zuLw
         eDmQ==
X-Gm-Message-State: AOAM532cda4zHu7sROL30WKQjfyfj2SGYyg3jyVVvdEq/w0/6fzUL4hB
        hSLNqhFtSGYbJ3UMDSDoWxw=
X-Google-Smtp-Source: ABdhPJydSxOq14pRCC7Z1xGIoLHsTQL8sgZTHIB1VWhJ2SA/bS6uvom/XmEPWazXYm35FgdTMMDIJA==
X-Received: by 2002:a19:710:: with SMTP id 16mr1777646lfh.171.1597312723157;
        Thu, 13 Aug 2020 02:58:43 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y13sm991374ljd.19.2020.08.13.02.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 02:58:42 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 13 Aug 2020 11:58:40 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813095840.GA25268@pc636>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813075027.GD9477@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 09:50:27AM +0200, Michal Hocko wrote:
> On Wed 12-08-20 02:13:25, Thomas Gleixner wrote:
> [...]
> > I can understand your rationale and what you are trying to solve. So, if
> > we can actually have a distinct GFP variant:
> > 
> >   GFP_I_ABSOLUTELY_HAVE_TO_DO_THAT_AND_I_KNOW_IT_CAN_FAIL_EARLY
> 
> Even if we cannot make the zone->lock raw I would prefer to not
> introduce a new gfp flag. Well we can do an alias for easier grepping
> #define GFP_RT_SAFE	0
> 
> that would imply nowait semantic and would exclude waking up kswapd as
> well. If we can make wake up safe under RT then the alias would reflect
> that without any code changes.
> 
> The second, and the more important part, would be to bail out anytime
> the page allocator is to take a lock which is not allowed in the current
> RT context. Something like 
> 	
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 67a0774e080b..3ef3ac82d110 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -237,6 +237,9 @@ struct vm_area_struct;
>   * that subsystems start with one of these combinations and then set/clear
>   * %__GFP_FOO flags as necessary.
>   *
> + * %GFP_RT_SAFE users can not sleep and they are running under RT atomic context
> + * e.g. under raw_spin_lock. Failure of an allocation is to be expected.
> + *
>   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
>   * watermark is applied to allow access to "atomic reserves"
>   *
> @@ -293,6 +296,7 @@ struct vm_area_struct;
>   * version does not attempt reclaim/compaction at all and is by default used
>   * in page fault path, while the non-light is used by khugepaged.
>   */
> +#define GFP_RT_SAFE	0
>  #define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
>  #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
>  #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e028b87ce294..268ae872cc2a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2824,6 +2824,13 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  {
>  	int i, alloced = 0;
>  
> +	/*
> +	 * Hard atomic contexts are not supported by the allocator for
> +	 * anything but pcp requests
> +	 */
> +	if (!preemtable())
> +		return 0;
> +
>  	spin_lock(&zone->lock);
>  	for (i = 0; i < count; ++i) {
>  		struct page *page = __rmqueue(zone, order, migratetype,
> @@ -3371,6 +3378,13 @@ struct page *rmqueue(struct zone *preferred_zone,
>  		goto out;
>  	}
>  
> +	/*
> +	 * Hard atomic contexts are not supported by the allocator for high
> +	 * order requests
> +	 */
> +	if (WARN_ON_ONCE(!preemtable()))
> +		reurn NULL;
> +
>  	/*
>  	 * We most definitely don't want callers attempting to
>  	 * allocate greater than order-1 page units with __GFP_NOFAIL.
> @@ -4523,6 +4537,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
>  		gfp_mask &= ~__GFP_ATOMIC;
>  
> +	/* Hard atomic contexts support is very limited to the fast path */
> +	if (!preemtable()) {
> +		WARN_ON_ONCE(gfp_mask != GFP_RT_SAFE);
> +		return NULL;
> +	}
> +
>  retry_cpuset:
>  	compaction_retries = 0;
>  	no_progress_loops = 0;
> 
> What do you think?
>  
> > which is easy to grep for then having the page allocator go down to the
> > point where zone lock gets involved is not the end of the world for
> > RT in theory - unless that damned reality tells otherwise. :)
> > 
> > The page allocator allocations should also have a limit on the number of
> > pages and eventually also page order (need to stare at the code or let
> > Michal educate me that the order does not matter).
> 
> In practice anything but order 0 is out of question because we need
> zone->lock for that currently. Maybe we can introduce pcp lists for
> higher orders in the future - I have a vague recollection Mel was
> playing with that some time ago.
> 
> > To make it consistent the same GFP_ variant should allow the slab
> > allocator go to the point where the slab cache is exhausted.
> > 
> > Having a distinct and clearly defined GFP_ variant is really key to
> > chase down offenders and to make reviewers double check upfront why this
> > is absolutely required.
> 
> Having a high level and recognizable gfp mask is OK but I would really
> like not to introduce a dedicated flag. The page allocator should be
> able to recognize the context which cannot be handled. 
>
Sorry for jumping in. We can rely on preemptable() for sure, if CONFIG_PREEMPT_RT
is enabled, something like below:

if (IS_ENABLED_RT && preemptebale())

Also i have a question about pcp-lists. Can we introduce and use all allowed 
MIGRATE_PCPTYPES? If called with GFP_RT_SAFE? If not please elaborate.
According to my tests it really helps when it comes to: succeed(return the page) or NULL.
Because on of the list of below types:
 MIGRATE_UNMOVABLE,
 MIGRATE_MOVABLE,
 MIGRATE_RECLAIMABLE,

can have a page making allocation succeed.

Thanks!

--
Vlad Rezki
