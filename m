Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B7DC6FA82
	for <rcu@archiver.kernel.org>; Sat, 10 Sep 2022 03:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiIJDeg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Sep 2022 23:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIJDee (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Sep 2022 23:34:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24206170
        for <rcu@vger.kernel.org>; Fri,  9 Sep 2022 20:34:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q3so3139016pjg.3
        for <rcu@vger.kernel.org>; Fri, 09 Sep 2022 20:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=p0QNUFOLOI50ZkSvLH1895huJeLBDMNKF4NIGcRoK6g=;
        b=RnEIyM4+ZpJe9pV9DBbrlTLVFA5AJFJ1C7jixHi9UfJftJpb9X+eYRD9Zyle1XNn0l
         pCJ04dF/MPbfjGVo1cvjTsFWJKupq1AIPFO4UyilPul6IjFfVtuvh+KeOqJM+qJLMq9S
         UFcHngPzNk9G3yFqNe5WxoZGSbb3WI6Vp45zYHSEZi4dKulhIJ/JOscybPKjiv5CxB8T
         CoofL/71z0WyGgisn9jZbDmeqKh1aJHSjgo2BMrqL18lnuzbiIXA0UcxWBMmSIcMJk5/
         eZXM+QJNIX0UwynsFO+AMtUgYBDaKBwJ+8jYEASON2RL0LFod11HDP7CfODqKDAXJA/c
         5KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=p0QNUFOLOI50ZkSvLH1895huJeLBDMNKF4NIGcRoK6g=;
        b=efHUe8TgAs1T4Ist2vv1B2SxwYfipHhY7wQ6DkKF1oxOArRUUBBQAaL3+SO29uNyqb
         yKBJH1GCD0T0EypEpI0e/gIfwwGqp95khdLum/GNrsLYKimoWmwNhVzg2vuwbfSRArdp
         9rcKqZsP7B3pbNvAhUFZOaGq00bKL1yBJa2zYyoReOQxPBklzQPgmMGf3bT6b81ArliJ
         syEL4H/7HTzHE7258xj+COzfqOSUUm/Yc0otGWc0Vr6EvztZ7cVahZvcT4XvFQBa+XyQ
         UgGQtro2ZgP/2BEg6rwS3XK79iezKlXH/tYt/Q0fQ+aZIMRgiR3oJFWlGtnm7guOlIWn
         THzA==
X-Gm-Message-State: ACgBeo1SGQ4xRu2kGrBvWUHY573mN7fd3ZVFZRtm2PO5EWDJXTVhMNzb
        I47mujwUlfIKQ66eSgUYWEk=
X-Google-Smtp-Source: AA6agR7ZijQOqgeXzkJsboboOYWWFC2VPnopCsCU0ps1u/dw8O+m6PfNHbPkRxQMd9ajhduQa8Iv5A==
X-Received: by 2002:a17:902:da81:b0:178:1d8b:6cb4 with SMTP id j1-20020a170902da8100b001781d8b6cb4mr791687plx.43.1662780871253;
        Fri, 09 Sep 2022 20:34:31 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id p17-20020aa79e91000000b0053639773ad8sm516822pfq.119.2022.09.09.20.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 20:34:30 -0700 (PDT)
Date:   Sat, 10 Sep 2022 12:34:25 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Joel Fernandes <joel@joelfernandes.org>,
        linux-mm@kvack.org, rcu@vger.kernel.org, paulmck@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [mm/sl[au]b] 3c4cafa313: canonical_address#:#[##]
Message-ID: <YxwFwY+YZeLBcOI9@hyeyoo>
References: <20220906074548.GA72649@inn2.lkp.intel.com>
 <208c1757-5edd-fd42-67d4-1940cc43b50f@intel.com>
 <YxdfpTDdfBt6VIpo@hyeyoo>
 <416149c0-1e18-0e00-d116-dd3738957556@suse.cz>
 <aec59f53-0e53-1736-5932-25407125d4d4@suse.cz>
 <Yxsd625lvTS6IWc+@hyeyoo>
 <3d178109-5981-f4ee-8fe5-4f1d0c557ed2@suse.cz>
 <YxtOjYB9DvR4Fkdp@hyeyoo>
 <cf7404ac-0838-7985-cdd0-524d540ad42a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7404ac-0838-7985-cdd0-524d540ad42a@suse.cz>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 09, 2022 at 11:16:51PM +0200, Vlastimil Babka wrote:
> On 9/9/22 16:32, Hyeonggon Yoo wrote:
> > On Fri, Sep 09, 2022 at 03:44:19PM +0200, Vlastimil Babka wrote:
> >> On 9/9/22 13:05, Hyeonggon Yoo wrote:
> >> >> ----8<----
> >> >> From d6f9fbb33b908eb8162cc1f6ce7f7c970d0f285f Mon Sep 17 00:00:00 2001
> >> >> From: Vlastimil Babka <vbabka@suse.cz>
> >> >> Date: Fri, 9 Sep 2022 12:03:10 +0200
> >> >> Subject: [PATCH 2/3] mm/migrate: make isolate_movable_page() skip slab pages
> >> >> 
> >> >> In the next commit we want to rearrange struct slab fields to allow a
> >> >> larger rcu_head. Afterwards, the page->mapping field will overlap
> >> >> with SLUB's "struct list_head slab_list", where the value of prev
> >> >> pointer can become LIST_POISON2, which is 0x122 + POISON_POINTER_DELTA.
> >> >> Unfortunately the bit 1 being set can confuse PageMovable() to be a
> >> >> false positive and cause a GPF as reported by lkp [1].
> >> >> 
> >> >> To fix this, make isolate_movable_page() skip pages with the PageSlab
> >> >> flag set. This is a bit tricky as we need to add memory barriers to SLAB
> >> >> and SLUB's page allocation and freeing, and their counterparts to
> >> >> isolate_movable_page().
> >> > 
> >> > Hello, I just took a quick grasp,
> >> > Is this approach okay with folio_test_anon()?
> >> 
> >> Not if used on a completely random page as compaction scanners can, but
> >> relies on those being first tested for PageLRU or coming from a page table
> >> lookup etc.
> >> Not ideal huh. Well I could improve also by switching 'next' and 'slabs'
> >> field and relying on the fact that the value of LIST_POISON2 doesn't include
> >> 0x1, just 0x2.
> > 
> > What about swapping counters and freelist?
> > freelist should be always aligned.  
> 
> Great suggestion, thanks!
> 
> Had to deal with SLAB too as there was list_head.prev also aliasing
> page->mapping. Wanted to use freelist as well, but turns out it's not
> aligned, so had to use s_mem instead.
> 
> The patch that isolate_movable_page() skip slab pages was thus dropped. The
> result is in slab.git below and if nothing blows up, will restore it to -next
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=for-6.1/fit_rcu_head

Looks fine to me, Thanks!

> 
> 
> 
> 
> 

-- 
Thanks,
Hyeonggon
