Return-Path: <SRS0=Nt6M=DN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C210C4363D
	for <rcu@archiver.kernel.org>; Tue,  6 Oct 2020 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2154208C7
	for <rcu@archiver.kernel.org>; Tue,  6 Oct 2020 22:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8s0q6Fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgJFWZf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgJFWZf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Oct 2020 18:25:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD415C061755;
        Tue,  6 Oct 2020 15:25:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w3so12506474ljo.5;
        Tue, 06 Oct 2020 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CwlririWHZLoZdSnClXuBylgfX10VlZNUUDjjqRPH8Y=;
        b=K8s0q6FiXm8ncAkkprgogRpRWDcz8WanTr/6863AUv99KWFKzQ6Jz3h5xQqd7VK4qy
         x28V8o9qi5J9SVkBoodsl6fhjW1GJmms5iL9zDvYiEO5p0NA/a/dD/ppCdcwYD6ChgWt
         LgCqDnOFd86/eUuE2DYbbyUR5sGkgSadXbc0VPqUnUafxWC4mNO2csDlAxFRcUeT7pj0
         rET2LItGU+dBcSQXsv9mgd4hWkPF+oErb8rpXsaOL0ZxY/T2rEHjKO1wvQo/esmMHQLK
         8T3jc5azAOvZtfeR7yJ9XBGr1CX9uf6tJuiygrvFaUOHz/g07U/1edbCOXmQ6AKzvDti
         YKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CwlririWHZLoZdSnClXuBylgfX10VlZNUUDjjqRPH8Y=;
        b=ezmEX5sT+HV1Q9xp3E8KzU0loURfGO2Uvd2YK2uefjbYr0khjFe/xwYZbFCMbM1apd
         7RiheFj9c34F8OUMvF5bRPjlv3DJ/0ZCA+7CvjT0qklb2f6eJJO+osbvYSzUyiCAfRIN
         TaOeG0/n000Hgv2mToZuhAw0+4ffygZN8CcBjWVCpdXZH+GorscH0kFMopoA8yk/CfRA
         wIe25drmmkbhHVoS4leUmXXsAqxn3OXhP9r2BRcD10UyHi/7QcN73hjI5o+zhtiwabT9
         kAJHf70iVuqWIyuo+Hxyea1Jo9nursh4iFxt1wU7sHeqKZ3/WI5NjCmUXAzO14+6bN0X
         orEQ==
X-Gm-Message-State: AOAM531CgHqKoHf+Gpi/5Z9l0y6q9YZS+3p2vmvaGkTTVNecHCS1TOtO
        r+O9ZCRzPcdgaYzWjpq18KQ=
X-Google-Smtp-Source: ABdhPJwcH6GTy52nMblWOnp5gn/2rSD5SlbUcIT54OGQFm9eNSEmZPClVuuQ+kngPYBDaLhJRLW2XQ==
X-Received: by 2002:a2e:b055:: with SMTP id d21mr64789ljl.244.1602023133000;
        Tue, 06 Oct 2020 15:25:33 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l188sm43120lfd.127.2020.10.06.15.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:25:31 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 7 Oct 2020 00:25:29 +0200
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
Message-ID: <20201006222529.GA23612@pc636>
References: <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002071123.GB20872@dhcp22.suse.cz>
 <20201002085014.GC3227@techsingularity.net>
 <20201002090507.GB4555@dhcp22.suse.cz>
 <20201005150801.GC17959@pc636>
 <20201005154100.GF4555@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005154100.GF4555@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 05, 2020 at 05:41:00PM +0200, Michal Hocko wrote:
> On Mon 05-10-20 17:08:01, Uladzislau Rezki wrote:
> > On Fri, Oct 02, 2020 at 11:05:07AM +0200, Michal Hocko wrote:
> > > On Fri 02-10-20 09:50:14, Mel Gorman wrote:
> > > > On Fri, Oct 02, 2020 at 09:11:23AM +0200, Michal Hocko wrote:
> > > > > On Thu 01-10-20 21:26:26, Uladzislau Rezki wrote:
> > > > > > > 
> > > > > > > No, I meant going back to idea of new gfp flag, but adjust the implementation in
> > > > > > > the allocator (different from what you posted in previous version) so that it
> > > > > > > only looks at the flag after it tries to allocate from pcplist and finds out
> > > > > > > it's empty. So, no inventing of new page allocator entry points or checks such
> > > > > > > as the one you wrote above, but adding the new gfp flag in a way that it doesn't
> > > > > > > affect existing fast paths.
> > > > > > >
> > > > > > OK. Now i see. Please have a look below at the patch, so we fully understand
> > > > > > each other. If that is something that is close to your view or not:
> > > > > > 
> > > > > > <snip>
> > > > > > t a/include/linux/gfp.h b/include/linux/gfp.h
> > > > > > index c603237e006c..7e613560a502 100644
> > > > > > --- a/include/linux/gfp.h
> > > > > > +++ b/include/linux/gfp.h
> > > > > > @@ -39,8 +39,9 @@ struct vm_area_struct;
> > > > > >  #define ___GFP_HARDWALL                0x100000u
> > > > > >  #define ___GFP_THISNODE                0x200000u
> > > > > >  #define ___GFP_ACCOUNT         0x400000u
> > > > > > +#define ___GFP_NO_LOCKS                0x800000u
> > > > > 
> > > > > Even if a new gfp flag gains a sufficient traction and support I am
> > > > > _strongly_ opposed against consuming another flag for that. Bit space is
> > > > > limited. 
> > > > 
> > > > That is definitely true. I'm not happy with the GFP flag at all, the
> > > > comment is at best a damage limiting move. It still would be better for
> > > > a memory pool to be reserved and sized for critical allocations.
> > > 
> > > Completely agreed. The only existing usecase is so special cased that a
> > > dedicated pool is not only easier to maintain but it should be also much
> > > better tuned for the specific workload. Something not really feasible
> > > with the allocator.
> > > 
> > > > > Besides that we certainly do not want to allow craziness like
> > > > > __GFP_NO_LOCK | __GFP_RECLAIM (and similar), do we?
> > > > 
> > > > That would deserve to be taken to a dumpster and set on fire. The flag
> > > > combination could be checked in the allocator but the allocator path fast
> > > > paths are bad enough already.
> > > 
> > > If a new allocation/gfp mode is absolutely necessary then I believe that
> > > the most reasoanble way forward would be
> > > #define GFP_NO_LOCK	((__force gfp_t)0)
> > > 
> > Agree. Even though i see that some code should be adjusted for it. There are
> > a few users of the __get_free_page(0); So, need to double check it:
> 
> Yes, I believe I have pointed that out in the previous discussion.
> 
OK. I spent more time on it. A passed gfp_mask can be adjusted on the entry,
that adjustment depends on the gfp_allowed_mask. It can be changed in run-time.

For example during early boot it excludes: __GFP_RECLAIM|__GFP_IO|__GFP_FS flags,
what is GFP_KERNEL. So, GFP_KERNEL is adjusted on entry and becomes 0 during early
boot phase.

How to distinguish it:

<snip>
+       /*
+        * gfp_mask can become zero because gfp_allowed_mask changes in run-time.
+        */
+       if (!gfp_mask)
+               alloc_flags |= ALLOC_NO_LOCKS;
+
        gfp_mask &= gfp_allowed_mask;
        alloc_mask = gfp_mask;
        if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
<snip>

> > 
> > Apart of that. There is a post_alloc_hook(), that gets called from the prep_new_page().
> > If "debug page alloc enabled", it maps a page for debug purposes invoking kernel_map_pages().
> > __kernel_map_pages() is ARCH specific. For example, powerpc variant uses sleep-able locks
> > what can be easily converted to raw variant. 
> 
> Yes, there are likely more surprises like that. I am not sure about
> kasan, page owner (which depens on the stack unwinder) and others which
> hook into this path.
>
I have checked kasan_alloc_pages(), kernel_poison_pages() both are OK,
at least i did not find any locking there. As for set_page_owner(), it
requires more attention, since it uses arch specific unwind logic. Though,
i spent some time on it and so far have not noticed anything.

--
Vlad Rezki
