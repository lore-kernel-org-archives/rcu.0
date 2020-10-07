Return-Path: <SRS0=by5p=DO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306DDC4363C
	for <rcu@archiver.kernel.org>; Wed,  7 Oct 2020 10:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2012076C
	for <rcu@archiver.kernel.org>; Wed,  7 Oct 2020 10:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QObC2YgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgJGKCh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 7 Oct 2020 06:02:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:60598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgJGKCh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 7 Oct 2020 06:02:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602064955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UPWqCqBP0H3c92qI4BRuEyuQQ1xCSXfo5lceHHY4dKQ=;
        b=QObC2YgWk4+bgZxmWEB/Ji5HZ03yKj8O4M2uoTVHuQ/gCJ8d9PsJA1l8vvvLN95PDhDLQC
        cQdCerPmbh+6M+Mz/v8nLQFEkaoWGDoJU/vdr0CcPl/ClAY9lzNKKdNB6tH7xdT0i+dBac
        o4REn0RJ7hTSnup/SMaUosJbEnY/KHY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2817FAD1B;
        Wed,  7 Oct 2020 10:02:35 +0000 (UTC)
Date:   Wed, 7 Oct 2020 12:02:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201007100234.GI29020@dhcp22.suse.cz>
References: <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002071123.GB20872@dhcp22.suse.cz>
 <20201002085014.GC3227@techsingularity.net>
 <20201002090507.GB4555@dhcp22.suse.cz>
 <20201005150801.GC17959@pc636>
 <20201005154100.GF4555@dhcp22.suse.cz>
 <20201006222529.GA23612@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006222529.GA23612@pc636>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 07-10-20 00:25:29, Uladzislau Rezki wrote:
> On Mon, Oct 05, 2020 at 05:41:00PM +0200, Michal Hocko wrote:
> > On Mon 05-10-20 17:08:01, Uladzislau Rezki wrote:
> > > On Fri, Oct 02, 2020 at 11:05:07AM +0200, Michal Hocko wrote:
> > > > On Fri 02-10-20 09:50:14, Mel Gorman wrote:
> > > > > On Fri, Oct 02, 2020 at 09:11:23AM +0200, Michal Hocko wrote:
> > > > > > On Thu 01-10-20 21:26:26, Uladzislau Rezki wrote:
> > > > > > > > 
> > > > > > > > No, I meant going back to idea of new gfp flag, but adjust the implementation in
> > > > > > > > the allocator (different from what you posted in previous version) so that it
> > > > > > > > only looks at the flag after it tries to allocate from pcplist and finds out
> > > > > > > > it's empty. So, no inventing of new page allocator entry points or checks such
> > > > > > > > as the one you wrote above, but adding the new gfp flag in a way that it doesn't
> > > > > > > > affect existing fast paths.
> > > > > > > >
> > > > > > > OK. Now i see. Please have a look below at the patch, so we fully understand
> > > > > > > each other. If that is something that is close to your view or not:
> > > > > > > 
> > > > > > > <snip>
> > > > > > > t a/include/linux/gfp.h b/include/linux/gfp.h
> > > > > > > index c603237e006c..7e613560a502 100644
> > > > > > > --- a/include/linux/gfp.h
> > > > > > > +++ b/include/linux/gfp.h
> > > > > > > @@ -39,8 +39,9 @@ struct vm_area_struct;
> > > > > > >  #define ___GFP_HARDWALL                0x100000u
> > > > > > >  #define ___GFP_THISNODE                0x200000u
> > > > > > >  #define ___GFP_ACCOUNT         0x400000u
> > > > > > > +#define ___GFP_NO_LOCKS                0x800000u
> > > > > > 
> > > > > > Even if a new gfp flag gains a sufficient traction and support I am
> > > > > > _strongly_ opposed against consuming another flag for that. Bit space is
> > > > > > limited. 
> > > > > 
> > > > > That is definitely true. I'm not happy with the GFP flag at all, the
> > > > > comment is at best a damage limiting move. It still would be better for
> > > > > a memory pool to be reserved and sized for critical allocations.
> > > > 
> > > > Completely agreed. The only existing usecase is so special cased that a
> > > > dedicated pool is not only easier to maintain but it should be also much
> > > > better tuned for the specific workload. Something not really feasible
> > > > with the allocator.
> > > > 
> > > > > > Besides that we certainly do not want to allow craziness like
> > > > > > __GFP_NO_LOCK | __GFP_RECLAIM (and similar), do we?
> > > > > 
> > > > > That would deserve to be taken to a dumpster and set on fire. The flag
> > > > > combination could be checked in the allocator but the allocator path fast
> > > > > paths are bad enough already.
> > > > 
> > > > If a new allocation/gfp mode is absolutely necessary then I believe that
> > > > the most reasoanble way forward would be
> > > > #define GFP_NO_LOCK	((__force gfp_t)0)
> > > > 
> > > Agree. Even though i see that some code should be adjusted for it. There are
> > > a few users of the __get_free_page(0); So, need to double check it:
> > 
> > Yes, I believe I have pointed that out in the previous discussion.
> > 
> OK. I spent more time on it. A passed gfp_mask can be adjusted on the entry,
> that adjustment depends on the gfp_allowed_mask. It can be changed in run-time.
> 
> For example during early boot it excludes: __GFP_RECLAIM|__GFP_IO|__GFP_FS flags,
> what is GFP_KERNEL. So, GFP_KERNEL is adjusted on entry and becomes 0 during early
> boot phase.

Honestly I am not sure how much is GFP_BOOT_MASK still needed. The
remaining user of gfp_allowed_mask mask should be only hibernation and I
believe this should be removed in long term. Not as trivial because
scope API cannot be used for that as it needs a global flag but this is
a gross hack that should be implemented differently. It is waiting on my
todo list but never got around to that.

> How to distinguish it:
> 
> <snip>
> +       /*
> +        * gfp_mask can become zero because gfp_allowed_mask changes in run-time.
> +        */
> +       if (!gfp_mask)
> +               alloc_flags |= ALLOC_NO_LOCKS;
> +
>         gfp_mask &= gfp_allowed_mask;
>         alloc_mask = gfp_mask;
>         if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
> <snip>
> 
> > > 
> > > Apart of that. There is a post_alloc_hook(), that gets called from the prep_new_page().
> > > If "debug page alloc enabled", it maps a page for debug purposes invoking kernel_map_pages().
> > > __kernel_map_pages() is ARCH specific. For example, powerpc variant uses sleep-able locks
> > > what can be easily converted to raw variant. 
> > 
> > Yes, there are likely more surprises like that. I am not sure about
> > kasan, page owner (which depens on the stack unwinder) and others which
> > hook into this path.
> >
> I have checked kasan_alloc_pages(), kernel_poison_pages() both are OK,
> at least i did not find any locking there. As for set_page_owner(), it
> requires more attention, since it uses arch specific unwind logic. Though,
> i spent some time on it and so far have not noticed anything.

stack depod depends on a lock IIRC. Anyway, this is just showing how
this is going to grow in complexity and make future additions harder.
A niche usecase is inducing an additional complexity for future
maintenance.

-- 
Michal Hocko
SUSE Labs
