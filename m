Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB09BECAAD3
	for <rcu@archiver.kernel.org>; Wed, 14 Sep 2022 06:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiINGd7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Sep 2022 02:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiINGd6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Sep 2022 02:33:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC75696EC
        for <rcu@vger.kernel.org>; Tue, 13 Sep 2022 23:33:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so8467604pjk.4
        for <rcu@vger.kernel.org>; Tue, 13 Sep 2022 23:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Snq77pgWGuBdhSsfi8MS1XPk8bTI55UIIEAHYPZaB1Y=;
        b=aHOWylDRjar56CZgOKRun2pNmDxLm7upcYLBzSAj46O4d+0lTwTQsK41EDexvCujaB
         dultCKuPSlmmGBHNThsRee8oRof/okF4pRN4c7I/P9l9GKGhOddsegSuQ6LBGw6o523V
         gtoY5e6iJpktzqZAM5BReGyBGlkxUChLAu0FwtE5QMRrYaRRqZz5El+SAJdsP3nMHib+
         92Fdk4DZw8JfSYpRRUDG/wav25olLCJEw8Jq4JsIb7TW40etbI2G0MNvVlwAXHiUxMS2
         u06FKKVoTYqSX6WpzOY7k2lCZL9MmhxwIXzCNrIJXd9eDXyRekTK8/agon0BKcNBfVYu
         fw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Snq77pgWGuBdhSsfi8MS1XPk8bTI55UIIEAHYPZaB1Y=;
        b=14iiLr0wplet2TYO8zFx3r0tqf6fXrbfGkrB0/ZtEGzyxTupMmpO2IhGjwFRFu/0GU
         6ex4VQrH20eCfvWE0xFx8Q/+zTI9ALMhBwVN0RxBh/03Su1OhkoC6zvhZVKf8pPJlvpw
         C3vbuL7q9c1j8DT18aFhVRB4fIgz3wTG/T7LZfXx67uQRfjdsSzK3iYIYQC5A52OXDkx
         UD5NZEovVxpYVRWZ4SXG36gWVEs0xLLKLScTefqwSi5QRZHMKdmjNkgDXRLg7/bx9h4Z
         8AzFftrCLoeWe5eo6g3AB/JyZJ2v38oWXhiE/gbmbHhJOy8CwoEseSxn6e7NyCaXhdHJ
         XQ9Q==
X-Gm-Message-State: ACgBeo1JqkrOm+kvkDu+wJE8bez2H1EEDYRvEHDSmtROTQFSR3ZFsF53
        R10LMKRptMJwG/fftuxKS28=
X-Google-Smtp-Source: AA6agR6wz/wRqsLGA1VDFCnrcJ6RF79Yt/qicnNT11CsJOqIpgO2RVF7xPfIkEvuXilrG2DkywD5VA==
X-Received: by 2002:a17:902:9b98:b0:176:70e1:1f86 with SMTP id y24-20020a1709029b9800b0017670e11f86mr34884976plp.60.1663137237143;
        Tue, 13 Sep 2022 23:33:57 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id o9-20020a62cd09000000b0053e199aa99bsm9033475pfg.220.2022.09.13.23.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 23:33:56 -0700 (PDT)
Date:   Wed, 14 Sep 2022 15:33:50 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Joel Fernandes <joel@joelfernandes.org>,
        linux-mm@kvack.org, rcu@vger.kernel.org, paulmck@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [mm/sl[au]b] 3c4cafa313: canonical_address#:#[##]
Message-ID: <YyF1zgAC2GBdW3Bk@hyeyoo>
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

I realized that there is also relevant comment in
include/linux/mm_types.h:

>  62  * SLUB uses cmpxchg_double() to atomically update its freelist and counters.
>  63  * That requires that freelist & counters in struct slab be adjacent and
>  64  * double-word aligned. Because struct slab currently just reinterprets the
>  65  * bits of struct page, we align all struct pages to double-word boundaries,
>  66  * and ensure that 'freelist' is aligned within struct slab.
>  67  */

Also we may add a comment,
something like this?

--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -79,6 +79,9 @@ struct page {
         * WARNING: bit 0 of the first word is used for PageTail(). That
         * means the other users of this union MUST NOT use the bit to
         * avoid collision and false-positive PageTail().
+        *
+        * WARNING: lower two bits of third word is used for PAGE_MAPPING_FLAGS.
+        * using those bits can lead compaction code to general protection fault.
         */
        union {
                struct {        /* Page cache and anonymous pages */
 

-- 
Thanks,
Hyeonggon
