Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8B3ECAAD3
	for <rcu@archiver.kernel.org>; Wed, 14 Sep 2022 07:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiINHmv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Sep 2022 03:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiINHmr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Sep 2022 03:42:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1FA72B64
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 00:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/qL9W+SzWLNHnKvVBVn4fKxNoXgKffqZs2eqeyelFh8=; b=uAt5mZZQdAvcBIld9pMVpV65s4
        xJIiTLouljdxOZooV7ByVk48AtZqW4Ipc6N+TgwQrw1Vr05J1r6XTPjmVZiTym9dJB7rKbKtrOPQD
        +7dE31rBZXtXkWcjYA+mPuXnDj3bYngXRCGU+VixEpv03ga/O34Ce8Y8V1oT5zoXYTNkvH2YixC2v
        q3yg9RJJp6/40ex3PtSn2V31Klxlupng/kShS2pMlAMzMNBSjEYbsBVrqgEPSJRiCuDmevKwpfS2D
        Yk013Ra5oc6I4a5ew3AJc73mKMOp+Ie/rTam7/tNN2EykVL27JcBsFVH40PhqoL4wK46v1TD2uhVD
        huV2TrpA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYN2c-00Ha7M-Kb; Wed, 14 Sep 2022 07:42:38 +0000
Date:   Wed, 14 Sep 2022 08:42:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Joel Fernandes <joel@joelfernandes.org>,
        linux-mm@kvack.org, rcu@vger.kernel.org, paulmck@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [mm/sl[au]b] 3c4cafa313: canonical_address#:#[##]
Message-ID: <YyGF7rHetCp0mWhV@casper.infradead.org>
References: <20220906074548.GA72649@inn2.lkp.intel.com>
 <208c1757-5edd-fd42-67d4-1940cc43b50f@intel.com>
 <YxdfpTDdfBt6VIpo@hyeyoo>
 <416149c0-1e18-0e00-d116-dd3738957556@suse.cz>
 <aec59f53-0e53-1736-5932-25407125d4d4@suse.cz>
 <Yxsd625lvTS6IWc+@hyeyoo>
 <3d178109-5981-f4ee-8fe5-4f1d0c557ed2@suse.cz>
 <YxtOjYB9DvR4Fkdp@hyeyoo>
 <cf7404ac-0838-7985-cdd0-524d540ad42a@suse.cz>
 <YyF1zgAC2GBdW3Bk@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyF1zgAC2GBdW3Bk@hyeyoo>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 14, 2022 at 03:33:50PM +0900, Hyeonggon Yoo wrote:
> On Fri, Sep 09, 2022 at 11:16:51PM +0200, Vlastimil Babka wrote:
> > On 9/9/22 16:32, Hyeonggon Yoo wrote:
> > > On Fri, Sep 09, 2022 at 03:44:19PM +0200, Vlastimil Babka wrote:
> > >> On 9/9/22 13:05, Hyeonggon Yoo wrote:
> > >> >> ----8<----
> > >> >> From d6f9fbb33b908eb8162cc1f6ce7f7c970d0f285f Mon Sep 17 00:00:00 2001
> > >> >> From: Vlastimil Babka <vbabka@suse.cz>
> > >> >> Date: Fri, 9 Sep 2022 12:03:10 +0200
> > >> >> Subject: [PATCH 2/3] mm/migrate: make isolate_movable_page() skip slab pages
> > >> >> 
> > >> >> In the next commit we want to rearrange struct slab fields to allow a
> > >> >> larger rcu_head. Afterwards, the page->mapping field will overlap
> > >> >> with SLUB's "struct list_head slab_list", where the value of prev
> > >> >> pointer can become LIST_POISON2, which is 0x122 + POISON_POINTER_DELTA.
> > >> >> Unfortunately the bit 1 being set can confuse PageMovable() to be a
> > >> >> false positive and cause a GPF as reported by lkp [1].
> > >> >> 
> > >> >> To fix this, make isolate_movable_page() skip pages with the PageSlab
> > >> >> flag set. This is a bit tricky as we need to add memory barriers to SLAB
> > >> >> and SLUB's page allocation and freeing, and their counterparts to
> > >> >> isolate_movable_page().
> > >> > 
> > >> > Hello, I just took a quick grasp,
> > >> > Is this approach okay with folio_test_anon()?
> > >> 
> > >> Not if used on a completely random page as compaction scanners can, but
> > >> relies on those being first tested for PageLRU or coming from a page table
> > >> lookup etc.
> > >> Not ideal huh. Well I could improve also by switching 'next' and 'slabs'
> > >> field and relying on the fact that the value of LIST_POISON2 doesn't include
> > >> 0x1, just 0x2.
> > > 
> > > What about swapping counters and freelist?
> > > freelist should be always aligned.  
> > 
> > Great suggestion, thanks!
> > 
> > Had to deal with SLAB too as there was list_head.prev also aliasing
> > page->mapping. Wanted to use freelist as well, but turns out it's not
> > aligned, so had to use s_mem instead.
> > 
> > The patch that isolate_movable_page() skip slab pages was thus dropped. The
> > result is in slab.git below and if nothing blows up, will restore it to -next
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=for-6.1/fit_rcu_head
> 
> I realized that there is also relevant comment in
> include/linux/mm_types.h:
> 
> >  62  * SLUB uses cmpxchg_double() to atomically update its freelist and counters.
> >  63  * That requires that freelist & counters in struct slab be adjacent and
> >  64  * double-word aligned. Because struct slab currently just reinterprets the
> >  65  * bits of struct page, we align all struct pages to double-word boundaries,
> >  66  * and ensure that 'freelist' is aligned within struct slab.
> >  67  */
> 
> Also we may add a comment,
> something like this?
> 
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -79,6 +79,9 @@ struct page {
>          * WARNING: bit 0 of the first word is used for PageTail(). That
>          * means the other users of this union MUST NOT use the bit to
>          * avoid collision and false-positive PageTail().
> +        *
> +        * WARNING: lower two bits of third word is used for PAGE_MAPPING_FLAGS.
> +        * using those bits can lead compaction code to general protection fault.

I'm really not comfortable with adding that documentation.  I feel the
compaction code should be fixed.
