Return-Path: <SRS0=by5p=DO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC26C4363D
	for <rcu@archiver.kernel.org>; Wed,  7 Oct 2020 11:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8F820870
	for <rcu@archiver.kernel.org>; Wed,  7 Oct 2020 11:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7Xj6RZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgJGLCy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 7 Oct 2020 07:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgJGLCv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 7 Oct 2020 07:02:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07288C061755;
        Wed,  7 Oct 2020 04:02:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a23so737089ljp.5;
        Wed, 07 Oct 2020 04:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CbjONhvllNSyW702K8bZjURMem2CyW8UYU/jLhqWZTM=;
        b=L7Xj6RZJ7dh8W0ZgTwJU6Go5ids6sTbDmO5IN+gOOeP6Uo6dtXAFmpVFdEmHpOHy2x
         +gsylc2e4ZjS0grEqCwE2GOkMKlXg8MWbUHrAwjm2/IwJmqQX5Gfy9Ib9GyIo9/VRBiG
         P4eKkh4ELpYGD5B0Xuy3kgvIW2SdgCYIwHmHEb1ba2hVqy1aA2YHRBmDlOQybAQcL2qX
         NClVuojhQ9jtB3da3+98+TsL+xgJmFMF/zQSIwgi2OPCLwHYrPLCwug7Du53qguNwlxR
         PznpTCphf4twLxgDtmOeB51DmVLtlRHyHCAKjjfHxQd/HvSeKEdw1HNWF020nbOdw/Z3
         Tv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CbjONhvllNSyW702K8bZjURMem2CyW8UYU/jLhqWZTM=;
        b=Jd6YXd81Rq+F1XAqxju5cdlr38w/aza2N9sSUefTN6GOW4+4koHQCctSjSJcwZkPNY
         dQFzMFeqsuii/3u+g0rSFw1hzBEgkieb7I/BbUKsgPNm2veUEqccezw55HeWX5ltwxOB
         /E0nSmbcXXkDmKMivx8WMz53PipyuF6t8w2GErkCq6fED6eAN7OnK/yBhW2XzvH1N3yo
         KC9MUpTe+VZry6wZxjP729L/lWxvp9hHYxTq7rlyXdC2NTFEo1CjudnOeh2vK4T86YAS
         m+eS1f/UwfQ6ynbiuY1wWHc9492Dfvna5DIfb2NsaniNxGpNe3M59xTJEuBuOdmz/hw0
         FmpA==
X-Gm-Message-State: AOAM533mnYlOagTQ2MlbjuO6HddvFeyexbqNVJS8SNWfjNDPL4pHZ117
        pq6Fn7AgEdiTcPNT6Ifmex8=
X-Google-Smtp-Source: ABdhPJw4UGU50WDP3vXA+Lj1oesoBXm6iHEH1ydOe3ByylMClE6FKl9qDPMlB81iUxeAmqpXWblhFQ==
X-Received: by 2002:a2e:88cb:: with SMTP id a11mr1059943ljk.304.1602068569184;
        Wed, 07 Oct 2020 04:02:49 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s17sm282520lfp.292.2020.10.07.04.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 04:02:48 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 7 Oct 2020 13:02:46 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
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
Message-ID: <20201007110246.GA25550@pc636>
References: <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002071123.GB20872@dhcp22.suse.cz>
 <20201002085014.GC3227@techsingularity.net>
 <20201002090507.GB4555@dhcp22.suse.cz>
 <20201005150801.GC17959@pc636>
 <20201005154100.GF4555@dhcp22.suse.cz>
 <20201006222529.GA23612@pc636>
 <20201007100234.GI29020@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007100234.GI29020@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 07, 2020 at 12:02:34PM +0200, Michal Hocko wrote:
> On Wed 07-10-20 00:25:29, Uladzislau Rezki wrote:
> > On Mon, Oct 05, 2020 at 05:41:00PM +0200, Michal Hocko wrote:
> > > On Mon 05-10-20 17:08:01, Uladzislau Rezki wrote:
> > > > On Fri, Oct 02, 2020 at 11:05:07AM +0200, Michal Hocko wrote:
> > > > > On Fri 02-10-20 09:50:14, Mel Gorman wrote:
> > > > > > On Fri, Oct 02, 2020 at 09:11:23AM +0200, Michal Hocko wrote:
> > > > > > > On Thu 01-10-20 21:26:26, Uladzislau Rezki wrote:
> > > > > > > > > 
> > > > > > > > > No, I meant going back to idea of new gfp flag, but adjust the implementation in
> > > > > > > > > the allocator (different from what you posted in previous version) so that it
> > > > > > > > > only looks at the flag after it tries to allocate from pcplist and finds out
> > > > > > > > > it's empty. So, no inventing of new page allocator entry points or checks such
> > > > > > > > > as the one you wrote above, but adding the new gfp flag in a way that it doesn't
> > > > > > > > > affect existing fast paths.
> > > > > > > > >
> > > > > > > > OK. Now i see. Please have a look below at the patch, so we fully understand
> > > > > > > > each other. If that is something that is close to your view or not:
> > > > > > > > 
> > > > > > > > <snip>
> > > > > > > > t a/include/linux/gfp.h b/include/linux/gfp.h
> > > > > > > > index c603237e006c..7e613560a502 100644
> > > > > > > > --- a/include/linux/gfp.h
> > > > > > > > +++ b/include/linux/gfp.h
> > > > > > > > @@ -39,8 +39,9 @@ struct vm_area_struct;
> > > > > > > >  #define ___GFP_HARDWALL                0x100000u
> > > > > > > >  #define ___GFP_THISNODE                0x200000u
> > > > > > > >  #define ___GFP_ACCOUNT         0x400000u
> > > > > > > > +#define ___GFP_NO_LOCKS                0x800000u
> > > > > > > 
> > > > > > > Even if a new gfp flag gains a sufficient traction and support I am
> > > > > > > _strongly_ opposed against consuming another flag for that. Bit space is
> > > > > > > limited. 
> > > > > > 
> > > > > > That is definitely true. I'm not happy with the GFP flag at all, the
> > > > > > comment is at best a damage limiting move. It still would be better for
> > > > > > a memory pool to be reserved and sized for critical allocations.
> > > > > 
> > > > > Completely agreed. The only existing usecase is so special cased that a
> > > > > dedicated pool is not only easier to maintain but it should be also much
> > > > > better tuned for the specific workload. Something not really feasible
> > > > > with the allocator.
> > > > > 
> > > > > > > Besides that we certainly do not want to allow craziness like
> > > > > > > __GFP_NO_LOCK | __GFP_RECLAIM (and similar), do we?
> > > > > > 
> > > > > > That would deserve to be taken to a dumpster and set on fire. The flag
> > > > > > combination could be checked in the allocator but the allocator path fast
> > > > > > paths are bad enough already.
> > > > > 
> > > > > If a new allocation/gfp mode is absolutely necessary then I believe that
> > > > > the most reasoanble way forward would be
> > > > > #define GFP_NO_LOCK	((__force gfp_t)0)
> > > > > 
> > > > Agree. Even though i see that some code should be adjusted for it. There are
> > > > a few users of the __get_free_page(0); So, need to double check it:
> > > 
> > > Yes, I believe I have pointed that out in the previous discussion.
> > > 
> > OK. I spent more time on it. A passed gfp_mask can be adjusted on the entry,
> > that adjustment depends on the gfp_allowed_mask. It can be changed in run-time.
> > 
> > For example during early boot it excludes: __GFP_RECLAIM|__GFP_IO|__GFP_FS flags,
> > what is GFP_KERNEL. So, GFP_KERNEL is adjusted on entry and becomes 0 during early
> > boot phase.
> 
> Honestly I am not sure how much is GFP_BOOT_MASK still needed. The
> remaining user of gfp_allowed_mask mask should be only hibernation and I
> believe this should be removed in long term. Not as trivial because
> scope API cannot be used for that as it needs a global flag but this is
> a gross hack that should be implemented differently. It is waiting on my
> todo list but never got around to that.
> 
> > How to distinguish it:
> > 
> > <snip>
> > +       /*
> > +        * gfp_mask can become zero because gfp_allowed_mask changes in run-time.
> > +        */
> > +       if (!gfp_mask)
> > +               alloc_flags |= ALLOC_NO_LOCKS;
> > +
> >         gfp_mask &= gfp_allowed_mask;
> >         alloc_mask = gfp_mask;
> >         if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
> > <snip>
> > 
> > > > 
> > > > Apart of that. There is a post_alloc_hook(), that gets called from the prep_new_page().
> > > > If "debug page alloc enabled", it maps a page for debug purposes invoking kernel_map_pages().
> > > > __kernel_map_pages() is ARCH specific. For example, powerpc variant uses sleep-able locks
> > > > what can be easily converted to raw variant. 
> > > 
> > > Yes, there are likely more surprises like that. I am not sure about
> > > kasan, page owner (which depens on the stack unwinder) and others which
> > > hook into this path.
> > >
> > I have checked kasan_alloc_pages(), kernel_poison_pages() both are OK,
> > at least i did not find any locking there. As for set_page_owner(), it
> > requires more attention, since it uses arch specific unwind logic. Though,
> > i spent some time on it and so far have not noticed anything.
> 
> stack depod depends on a lock IIRC. Anyway, this is just showing how
> this is going to grow in complexity and make future additions harder.
> A niche usecase is inducing an additional complexity for future
> maintenance.
> 
I agree regarding maintenance costs. That is what is hard to avoid.

--
Vlad Rezki
