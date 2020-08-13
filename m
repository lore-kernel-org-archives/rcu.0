Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE21C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 13:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0125120771
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 13:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOlpMCP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMN3h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMN3g (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 09:29:36 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE9AC061757;
        Thu, 13 Aug 2020 06:29:36 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so6216880ljd.0;
        Thu, 13 Aug 2020 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BdXRMwIlDM5vuTQYsBNomaa1Aph9QEQzqvE62HFXGe0=;
        b=jOlpMCP/L6+w+xPZUX1CUt8MvmzsiP03ob79034F1laBpmsW0B3RoF58h7FYuDhNYS
         t3/YHt9nFrbPU4FUKmiuyyTrDKDTrqsUYsNNF92za/hGAeGfiIo/noVYCS6cLKHiJVCl
         OutuhFB58U3hLw7d8cSS57kXNb+RtD93cykW5FCblBdEcsvs/OyNg9PwVsrdswii8RN4
         htA0n7TVst1TFnV8k2Bo6IvSTsrynS+S2zhS+wBq39AVSjkpgfUjqd3y4InVRAAdO3G+
         bkyPMiEvsGf96b5gfHJGsQVD1tZuF+eAGplcRL9Nw2COgqDmZJ4twCe73OVPOoht5AVS
         H55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BdXRMwIlDM5vuTQYsBNomaa1Aph9QEQzqvE62HFXGe0=;
        b=HjtGXCd63Mw7PImXV6BpfJpsDsrz1hv12vcKG7XbBxGnvs/QG4a8xBVdYgbKOXFeXE
         VtGB9I/ejkZ1VXhhjx/uzdrCJu90iPQ3ia4uL5/OuOKQxRtUgxUq/YpRVXnTJII+wTIX
         NXyNgVcIc9YkkO3NK6sQDZtOkSaHYEmhw40K24xO9YnTga9s1P270Hpcy9EMF+DhhFKk
         HKvgIWqPSybrRT696u0TjM+UxMhRfzjcex1ZKsKATOUunHLw73VY4bQ+I4/2Gx0qD7FM
         YkswiyMLFezUVjFbhGvmValWa+Iwj5ZnTrNhY1V0ejkzZF3Te72s2TMfH+dMgp6O+beV
         mvGg==
X-Gm-Message-State: AOAM531UtGlJ5YvbWT709hFImYICO+nmPSQIT78kSMPQ2rycK1me8I6M
        R+S7YGHvLjo0oF8rwBSwr8Q=
X-Google-Smtp-Source: ABdhPJwalruxWhZlBSLd5XhzKRV/sbZ7GqxKU+1yw+nX9tMBKm6jxlpn750Ko2X6s+FKJqJH05c8Cg==
X-Received: by 2002:a05:651c:106a:: with SMTP id y10mr2102200ljm.296.1597325374667;
        Thu, 13 Aug 2020 06:29:34 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id u28sm1103642ljd.39.2020.08.13.06.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 06:29:33 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 13 Aug 2020 15:29:31 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813132931.GA26290@pc636>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813095840.GA25268@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Michal.

> > On Wed 12-08-20 02:13:25, Thomas Gleixner wrote:
> > [...]
> > > I can understand your rationale and what you are trying to solve. So, if
> > > we can actually have a distinct GFP variant:
> > > 
> > >   GFP_I_ABSOLUTELY_HAVE_TO_DO_THAT_AND_I_KNOW_IT_CAN_FAIL_EARLY
> > 
> > Even if we cannot make the zone->lock raw I would prefer to not
> > introduce a new gfp flag. Well we can do an alias for easier grepping
> > #define GFP_RT_SAFE	0
> > 
> > that would imply nowait semantic and would exclude waking up kswapd as
> > well. If we can make wake up safe under RT then the alias would reflect
> > that without any code changes.
> > 
> > The second, and the more important part, would be to bail out anytime
> > the page allocator is to take a lock which is not allowed in the current
> > RT context. Something like 
> > 	
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 67a0774e080b..3ef3ac82d110 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -237,6 +237,9 @@ struct vm_area_struct;
> >   * that subsystems start with one of these combinations and then set/clear
> >   * %__GFP_FOO flags as necessary.
> >   *
> > + * %GFP_RT_SAFE users can not sleep and they are running under RT atomic context
> > + * e.g. under raw_spin_lock. Failure of an allocation is to be expected.
> > + *
> >   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
> >   * watermark is applied to allow access to "atomic reserves"
> >   *
> > @@ -293,6 +296,7 @@ struct vm_area_struct;
> >   * version does not attempt reclaim/compaction at all and is by default used
> >   * in page fault path, while the non-light is used by khugepaged.
> >   */
> > +#define GFP_RT_SAFE	0
> >  #define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
> >  #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
> >  #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index e028b87ce294..268ae872cc2a 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2824,6 +2824,13 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
> >  {
> >  	int i, alloced = 0;
> >  
> > +	/*
> > +	 * Hard atomic contexts are not supported by the allocator for
> > +	 * anything but pcp requests
> > +	 */
> > +	if (!preemtable())
> > +		return 0;
> > +
> >  	spin_lock(&zone->lock);
> >  	for (i = 0; i < count; ++i) {
> >  		struct page *page = __rmqueue(zone, order, migratetype,
> > @@ -3371,6 +3378,13 @@ struct page *rmqueue(struct zone *preferred_zone,
> >  		goto out;
> >  	}
> >  
> > +	/*
> > +	 * Hard atomic contexts are not supported by the allocator for high
> > +	 * order requests
> > +	 */
> > +	if (WARN_ON_ONCE(!preemtable()))
> > +		reurn NULL;
> > +
> >  	/*
> >  	 * We most definitely don't want callers attempting to
> >  	 * allocate greater than order-1 page units with __GFP_NOFAIL.
> > @@ -4523,6 +4537,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >  				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
> >  		gfp_mask &= ~__GFP_ATOMIC;
> >  
> > +	/* Hard atomic contexts support is very limited to the fast path */
> > +	if (!preemtable()) {
> > +		WARN_ON_ONCE(gfp_mask != GFP_RT_SAFE);
> > +		return NULL;
> > +	}
> > +
> >  retry_cpuset:
> >  	compaction_retries = 0;
> >  	no_progress_loops = 0;
> > 
> > What do you think?
> >  
> > > which is easy to grep for then having the page allocator go down to the
> > > point where zone lock gets involved is not the end of the world for
> > > RT in theory - unless that damned reality tells otherwise. :)
> > > 
> > > The page allocator allocations should also have a limit on the number of
> > > pages and eventually also page order (need to stare at the code or let
> > > Michal educate me that the order does not matter).
> > 
> > In practice anything but order 0 is out of question because we need
> > zone->lock for that currently. Maybe we can introduce pcp lists for
> > higher orders in the future - I have a vague recollection Mel was
> > playing with that some time ago.
> > 
> > > To make it consistent the same GFP_ variant should allow the slab
> > > allocator go to the point where the slab cache is exhausted.
> > > 
> > > Having a distinct and clearly defined GFP_ variant is really key to
> > > chase down offenders and to make reviewers double check upfront why this
> > > is absolutely required.
> > 
> > Having a high level and recognizable gfp mask is OK but I would really
> > like not to introduce a dedicated flag. The page allocator should be
> > able to recognize the context which cannot be handled. 
> >
> Sorry for jumping in. We can rely on preemptable() for sure, if CONFIG_PREEMPT_RT
> is enabled, something like below:
> 
> if (IS_ENABLED_RT && preemptebale())
> 
I was a bit out of focus and did not mention about one thing. Identifying the context
type using preemtable() primitives looks a bit not suitable, IMHO. GFP_* flags are
not supposed to identify a context type, because it is not possible for all cases.
But that i

Also, to bail out based on a context's type will not allow to get a page from atomic
contexts, what we try to achieve :)

Whereas, i mean, we do have possibility to do lock-less per-cpu-list allocation without
touching any zone lock.

if (gfp_mask == 0) {
   check_pcp_lists();
      if (page)
          return page;

    bail out here without doing farther logic, like pre-fetching.
    return NULL;
}

For example consider our case:
kfree_rcu()-> raw_spin_lock() -> page_alloc-> preemtable() -> false

--
Vlad Rezki
