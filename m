Return-Path: <SRS0=4XKx=DI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543A8C4727E
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 19:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1338E206B2
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 19:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H01Krlzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgJAT0b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Oct 2020 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJAT0b (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Oct 2020 15:26:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429CFC0613D0;
        Thu,  1 Oct 2020 12:26:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r24so5644851ljm.3;
        Thu, 01 Oct 2020 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xd//GxJoklja7rkzZsevPDrGh2TUw5htKpmsuONiVDY=;
        b=H01KrlzmGYj+JUETPe+wQKViCQKwUftbfUlOne4G8MhAWBYfhEZLw8dhIjULUTKBvb
         Ll4cNAEqYxhPRTHatNYXO9gxMOd8kNl3UTqmxMCPEUNdJOUaOsFMlobNqrqbi8s3n6pL
         DvvFXZFFsKPuyVM3Ou4x1mwShgA0wuQ4oHsJPQ8AZAm6n+ePAjSQqnSpcU/YYu1uXwEG
         dtvNHRaos7XoUAS9DcP5nYg93QMGEh4l2Oh3WH7thwflEEPaFLhhEfN/QjtSR8tJvoai
         YTVz6xbFQQWsITH7RntXnOahm/uDh2AckbWeM/A0my5X/G4qPPhgbKnkKF26iCYOhauc
         HOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xd//GxJoklja7rkzZsevPDrGh2TUw5htKpmsuONiVDY=;
        b=uI8EAkK9SYDEan1CWyq13KR3pyDxWHhOpxYc5DiFHO2zd+QiGf76MGu3QB5IhyNt10
         wyociKlFDnY5N3SrwPRIADNiRZ9aDylrZUDThMFU+KuSJe12ok9ZYXOjisQK4UY4butd
         ANyvJfjqshUhcze6z1DMSbMtK/qnEz3luzkN7NJzVTkIE2pVAeA/3DOaRvvpK6N7uphV
         ubCnONhxFUhmjg50azCDOcYHrcm9qx+S8QSE+M+kLLR+8IcEmP3UZjDOOgnxu2JmOTm6
         Jc7gRyfcILx4kxzndCVD0sN8Xe0ZFZvF3G8DgXCsTdchhX6b59Qrj2Rk91FaSyyZVc5w
         uyzQ==
X-Gm-Message-State: AOAM533FtYm4qU1cGzlK56mrmwuD04lRW7RWv8xfIEurtKxpGIqTN2SN
        tyCmblA87JYPEbOgFsjwSHU=
X-Google-Smtp-Source: ABdhPJzV7pYibJ/bv9c5TYTaSjvrOYPvY2jBrzs8i3PKgg7DEAwEEs9Sjad/0AETbN7jPv6TI93Odw==
X-Received: by 2002:a05:651c:1205:: with SMTP id i5mr2839746lja.47.1601580389449;
        Thu, 01 Oct 2020 12:26:29 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id i187sm671051lfd.65.2020.10.01.12.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:26:28 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 1 Oct 2020 21:26:26 +0200
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201001192626.GA29606@pc636>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> 
> No, I meant going back to idea of new gfp flag, but adjust the implementation in
> the allocator (different from what you posted in previous version) so that it
> only looks at the flag after it tries to allocate from pcplist and finds out
> it's empty. So, no inventing of new page allocator entry points or checks such
> as the one you wrote above, but adding the new gfp flag in a way that it doesn't
> affect existing fast paths.
>
OK. Now i see. Please have a look below at the patch, so we fully understand
each other. If that is something that is close to your view or not:

<snip>
t a/include/linux/gfp.h b/include/linux/gfp.h
index c603237e006c..7e613560a502 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -39,8 +39,9 @@ struct vm_area_struct;
 #define ___GFP_HARDWALL                0x100000u
 #define ___GFP_THISNODE                0x200000u
 #define ___GFP_ACCOUNT         0x400000u
+#define ___GFP_NO_LOCKS                0x800000u
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP       0x800000u
+#define ___GFP_NOLOCKDEP       0x1000000u
 #else
 #define ___GFP_NOLOCKDEP       0
 #endif
@@ -215,16 +216,22 @@ struct vm_area_struct;
  * %__GFP_COMP address compound page metadata.
  *
  * %__GFP_ZERO returns a zeroed page on success.
+ *
+ * %__GFP_NO_LOCKS order-0 allocation without sleepable-locks.
+ * It obtains a page from the per-cpu-list and considered as
+ * lock-less. No other actions are performed, thus it returns
+ * NULL if per-cpu-list is empty.
  */
 #define __GFP_NOWARN   ((__force gfp_t)___GFP_NOWARN)
 #define __GFP_COMP     ((__force gfp_t)___GFP_COMP)
 #define __GFP_ZERO     ((__force gfp_t)___GFP_ZERO)
+#define __GFP_NO_LOCKS ((__force gfp_t)___GFP_NO_LOCKS)

 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)

 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (24 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 67018d367b9f..d99af78237be 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -45,6 +45,7 @@
        {(unsigned long)__GFP_RECLAIMABLE,      "__GFP_RECLAIMABLE"},   \
        {(unsigned long)__GFP_MOVABLE,          "__GFP_MOVABLE"},       \
        {(unsigned long)__GFP_ACCOUNT,          "__GFP_ACCOUNT"},       \
+       {(unsigned long)__GFP_NO_LOCKS,         "__GFP_NO_LOCKS"},      \
        {(unsigned long)__GFP_WRITE,            "__GFP_WRITE"},         \
        {(unsigned long)__GFP_RECLAIM,          "__GFP_RECLAIM"},       \
        {(unsigned long)__GFP_DIRECT_RECLAIM,   "__GFP_DIRECT_RECLAIM"},\
diff --git a/mm/internal.h b/mm/internal.h
index 6345b08ce86c..5724fba921f9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -569,6 +569,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_NOFRAGMENT         0x0
 #endif
 #define ALLOC_KSWAPD           0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
+#define ALLOC_NO_LOCKS         0x1000 /* Lock free allocation. */
 
 enum ttu_flags;
 struct tlbflush_unmap_batch;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aff1f84bf268..19cd9794dd45 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2837,6 +2837,9 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 {
        int i, alloced = 0;
 
+       if (alloc_flags & ALLOC_NO_LOCKS)
+               return alloced;
+
        spin_lock(&zone->lock);
        for (i = 0; i < count; ++i) {
                struct page *page = __rmqueue(zone, order, migratetype,
@@ -3805,7 +3808,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
                         * grow this zone if it contains deferred pages.
                         */
                        if (static_branch_unlikely(&deferred_pages)) {
-                               if (_deferred_grow_zone(zone, order))
+                               if (!(alloc_flags & ALLOC_NO_LOCKS) &&
+                                               _deferred_grow_zone(zone, order))
                                        goto try_this_zone;
                        }
 #endif
@@ -3850,7 +3854,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
                                reserve_highatomic_pageblock(page, zone, order);

                        return page;
-               } else {
+               } else if (!(alloc_flags & ALLOC_NO_LOCKS)) {
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
                        /* Try again if zone has deferred pages */
                        if (static_branch_unlikely(&deferred_pages)) {
@@ -4846,6 +4850,9 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
        ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
                                        ac->highest_zoneidx, ac->nodemask);

+       if (gfp_mask & __GFP_NO_LOCKS)
+               *alloc_flags |= ALLOC_NO_LOCKS;
+
        return true;
 }

@@ -4886,6 +4893,10 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
        if (likely(page))
                goto out;

+       /* Bypass slow path if __GFP_NO_LOCKS. */
+       if ((gfp_mask & __GFP_NO_LOCKS))
+               goto out;
+
        /*
         * Apply scoped allocation constraints. This is mainly about GFP_NOFS
         * resp. GFP_NOIO which has to be inherited for all allocation requests
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index a50dae2c4ae9..fee3221bcf6a 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -656,6 +656,7 @@ static const struct {
        { "__GFP_RECLAIMABLE",          "RC" },
        { "__GFP_MOVABLE",              "M" },
        { "__GFP_ACCOUNT",              "AC" },
+       { "__GFP_NO_LOCKS",             "NL" },
        { "__GFP_WRITE",                "WR" },
        { "__GFP_RECLAIM",              "R" },
        { "__GFP_DIRECT_RECLAIM",       "DR" },
<snip>

If not, could you please provide some snips or any pseudo code?

Thanks Vlastimil!

--
Vlad Rezki
