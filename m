Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA65C6FA8A
	for <rcu@archiver.kernel.org>; Fri,  9 Sep 2022 11:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIILFY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Sep 2022 07:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIILFX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Sep 2022 07:05:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4533DF3C
        for <rcu@vger.kernel.org>; Fri,  9 Sep 2022 04:05:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q9so1228856pgq.6
        for <rcu@vger.kernel.org>; Fri, 09 Sep 2022 04:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=PN/fmpcjwf0jdqhZYOdl9olfIHH59vPDBLMDPHdgdeI=;
        b=CQzvhobjzTzyfCdxy/zsUlw6KAqXALkEopmYtbDFNqsls2ARAGmr71CcNNkIk61dca
         M7q6uuKMvhY5xmmk5Hm0EltYqnCZxyXGmzb/KiQMzY1UpZDABMcxzvhlGC1SjRRe4gqg
         V9APdFhQwd0QH3tMqYOcMfden6BScKCnlWj0q2qUaJgCxlP/tH4vKH/6ADb+XuzPF33q
         43VJHCjmic0+ArdN91O+tLFCWHF4CmR9v8QtxeyYPiDUCm7wxna6ju+ckvqoHTtnCp0W
         RtKZFxbqW5xr7jBIfhaeGVq4fpU7kMqw2YdXGHk022ziNj44KIWbUyL9X5WfE9sz9ixS
         q1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PN/fmpcjwf0jdqhZYOdl9olfIHH59vPDBLMDPHdgdeI=;
        b=TGQGH3gBqg8hNIyipRALYWBGfhQGxXsd+gb2uzKI/v4Dapqyik0xXI6bGr1iQujm/Q
         4RWA/Fd+7tojDbFForhVsbrwdpHWOgN/H9hM2x3Xn1NtiXEx9+az44HtrF69T2inLFUK
         koQlhzbxE+3vwwERck0Y62oT1fdMEG/23750zdJ+Gxu4380pwWfCHvG8eCtOdnF489Bp
         EeW2Pwrs71AkzZIQgwi2ofTK4PG6TpRwSE+H9mBkwl2nh7r5Z3E2vbvHLTIGYmYTEXjL
         b3OgbcXYCgy9tckaP/hWKO0WRFsp6aljSqLdgyDL51tfKGwqAu5CmYH2Nz5wI0bHMx/A
         NrwQ==
X-Gm-Message-State: ACgBeo2kUBWlazre+oHZHqno1HxLfgym/zSwamk5uh78444B7vLoWHia
        7Y5C9PqcVG61OlJQar3PIG8=
X-Google-Smtp-Source: AA6agR58ZQaqzYA3rsU9xY8Ye8MKkkfghgOU5HeGJNV/gNOr9PQytgp5dOXow1gJWAun4QdkglqPaQ==
X-Received: by 2002:a63:fe54:0:b0:42b:d11d:1490 with SMTP id x20-20020a63fe54000000b0042bd11d1490mr12184556pgj.51.1662721521452;
        Fri, 09 Sep 2022 04:05:21 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902c94a00b001768517f99esm175804pla.244.2022.09.09.04.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 04:05:19 -0700 (PDT)
Date:   Fri, 9 Sep 2022 20:05:15 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Joel Fernandes <joel@joelfernandes.org>,
        linux-mm@kvack.org, rcu@vger.kernel.org, paulmck@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [mm/sl[au]b] 3c4cafa313: canonical_address#:#[##]
Message-ID: <Yxsd625lvTS6IWc+@hyeyoo>
References: <20220906074548.GA72649@inn2.lkp.intel.com>
 <208c1757-5edd-fd42-67d4-1940cc43b50f@intel.com>
 <YxdfpTDdfBt6VIpo@hyeyoo>
 <416149c0-1e18-0e00-d116-dd3738957556@suse.cz>
 <aec59f53-0e53-1736-5932-25407125d4d4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aec59f53-0e53-1736-5932-25407125d4d4@suse.cz>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 09, 2022 at 12:21:32PM +0200, Vlastimil Babka wrote:
> 
> On 9/6/22 17:11, Vlastimil Babka wrote:
> > On 9/6/22 16:56, Hyeonggon Yoo wrote:
> >> On Tue, Sep 06, 2022 at 03:51:01PM +0800, kernel test robot wrote:
> >>> Greeting,
> >>>
> >>> FYI, we noticed the following commit (built with gcc-11):
> >>>
> >>> commit: 3c4cafa313d978b31a1d5dc17c323074b19a1d63 ("mm/sl[au]b: rearrange
> >>> struct slab fields to allow larger rcu_head")
> >>> git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git
> >>> for-6.1/fit_rcu_head
> >>>
> >>> in testcase: fio-basic
> >>> version: fio-x86_64-3.15-1_20220903
> >>> with following parameters:
> >>>
> >>>     disk: 2pmem
> >>>     fs: xfs
> >>>     runtime: 200s
> >>>     nr_task: 50%
> >>>     time_based: tb
> >>>     rw: randrw
> >>>     bs: 2M
> >>>     ioengine: mmap
> >>>     test_size: 200G
> >>>     cpufreq_governor: performance
> >>>
> >>> test-description: Fio is a tool that will spawn a number of threads or
> >>> processes doing a particular type of I/O action as specified by the user.
> >>> test-url:https://github.com/axboe/fio
> >>>
> >>>
> >>> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @
> >>> 2.10GHz (Cascade Lake) with 512G memory
> >>>
> >>> caused below changes (please refer to attached dmesg/kmsg for entire
> >>> log/backtrace):
> >>>
> >>>
> >>> [  304.700893][   C40] perf: interrupt took too long (12747 > 12477),
> >>> lowering kernel.perf_event_max_sample_rate to 15000
> >>> [  305.015834][   C40] perf: interrupt took too long (15947 > 15933),
> >>> lowering kernel.perf_event_max_sample_rate to 12000
> >>> [  305.954702][   C40] perf: interrupt took too long (19968 > 19933),
> >>> lowering kernel.perf_event_max_sample_rate to 10000
> >>> [  309.554949][   C31] perf: interrupt took too long (25118 > 24960),
> >>> lowering kernel.perf_event_max_sample_rate to 7000
> >>> [  315.068744][   C95] sched: RT throttling activated
> >>> [  317.121806][  T590] general protection fault, probably for
> >>> non-canonical address 0xdead000000000120: 0000 [#1] SMP NOPTI
> >>> [  317.133291][  T590] CPU: 61 PID: 590 Comm: kcompactd0 Tainted: G
> >>> S                 6.0.0-rc2-00002-g3c4cafa313d9 #1
> >>> [  317.144084][  T590] Hardware name: Intel Corporation
> >>> S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> >>> [ 317.155668][ T590] RIP: 0010:isolate_movable_page (mm/migrate.c:103)
> >>> [ 317.162016][ T590] Code: ba 28 00 0f 82 88 00 00 00 48 89 ef e8 e2 3a
> >>> f8 ff 84 c0 74 74 48 8b 45 00 a9 00 00 04 00 75 69 48 8b 45 18 44 89 e6
> >>> 48 89 ef <48> 8b 40 fe ff d0 0f 1f 00 84 c0 74 52 48 8b 45 00 a9 00 00 04 00
> >>> All code
> >>> ========
> >>>     0:    ba 28 00 0f 82           mov    $0x820f0028,%edx
> >>>     5:    88 00                    mov    %al,(%rax)
> >>>     7:    00 00                    add    %al,(%rax)
> >>>     9:    48 89 ef                 mov    %rbp,%rdi
> >>>     c:    e8 e2 3a f8 ff           callq  0xfffffffffff83af3
> >>>    11:    84 c0                    test   %al,%al
> >>>    13:    74 74                    je     0x89
> >>>    15:    48 8b 45 00              mov    0x0(%rbp),%rax
> >>>    19:    a9 00 00 04 00           test   $0x40000,%eax
> >>>    1e:    75 69                    jne    0x89
> >>>    20:    48 8b 45 18              mov    0x18(%rbp),%rax
> >>>    24:    44 89 e6                 mov    %r12d,%esi
> >>>    27:    48 89 ef                 mov    %rbp,%rdi
> >>>    2a:*    48 8b 40 fe              mov    -0x2(%rax),%rax        <--
> >>> trapping instruction
> >>>    2e:    ff d0                    callq  *%rax
> >>>    30:    0f 1f 00                 nopl   (%rax)
> >>>    33:    84 c0                    test   %al,%al
> >>>    35:    74 52                    je     0x89
> >>>    37:    48 8b 45 00              mov    0x0(%rbp),%rax
> >>>    3b:    a9 00 00 04 00           test   $0x40000,%eax
> >>>
> >>> Code starting with the faulting instruction
> >>> ===========================================
> >>>     0:    48 8b 40 fe              mov    -0x2(%rax),%rax
> >>>     4:    ff d0                    callq  *%rax
> >>>     6:    0f 1f 00                 nopl   (%rax)
> >>>     9:    84 c0                    test   %al,%al
> >>>     b:    74 52                    je     0x5f
> >>>     d:    48 8b 45 00              mov    0x0(%rbp),%rax
> >>>    11:    a9 00 00 04 00           test   $0x40000,%eax
> >>> [  317.182354][  T590] RSP: 0018:ffffc9000e1d3c78 EFLAGS: 00010246
> >>> [  317.188668][  T590] RAX: dead000000000122 RBX: ffffea0004031034 RCX:
> >>> 000000000000000c
> >>> [  317.196890][  T590] RDX: dead000000000101 RSI: 000000000000000c RDI:
> >>> ffffea0004031000
> >>> [  317.205273][  T590] RBP: ffffea0004031000 R08: 0000000004031000 R09:
> >>> 0000000000000004
> >>> [  317.213752][  T590] R10: 00000000000066b6 R11: 0000000000000004 R12:
> >>> 000000000000000c
> >>> [  317.222384][  T590] R13: ffffea0004031000 R14: 0000000000100c40 R15:
> >>> ffffc9000e1d3df0
> >>> [  317.230679][  T590] FS:  0000000000000000(0000)
> >>> GS:ffff88c04ff40000(0000) knlGS:0000000000000000
> >>> [  317.239896][  T590] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> [  317.247098][  T590] CR2: 0000000000451c00 CR3: 0000008064ca4002 CR4:
> >>> 00000000007706e0
> >>> [  317.255788][  T590] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> >>> 0000000000000000
> >>> [  317.264256][  T590] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> >>> 0000000000000400
> >>> [  317.272772][  T590] PKRU: 55555554
> >>> [  317.276783][  T590] Call Trace:
> >>> [  317.280932][  T590]  <TASK>
> >>> [ 317.284315][ T590] isolate_migratepages_block (mm/compaction.c:982)
> >>> [ 317.290702][ T590] isolate_migratepages (mm/compaction.c:1960)
> >>> [ 317.296278][ T590] compact_zone (mm/compaction.c:2393)
> >>> [ 317.301202][ T590] proactive_compact_node (mm/compaction.c:2661
> >>> (discriminator 2))
> >> Hmm... Let's debug.
> >>
> >> FYI, simply echo 1 > /proc/sys/vm/compact_memory invokes same bug on my test
> >> environment.
> >>
> >> the 'mops' is invalid address in mm/migrate.c:103.
> >>
> >> Hmm, why is this slab page confused as movable page?
> >> -> Because page->'mapping' and slab->slabs field has same offset.
> >>
> >> I think this is invoked because lowest two bits of slab->slabs is not 0.
> >>
> >> Vlastimil, any thoughts?
> > 
> > Yeah, slabs->slabs could do that, and the remedy would be to exchange it
> > with the slab->next field.
> > However the report points to the value dead000000000122 which is
> > LIST_POISON2, which unfortunately contains the lower bit after 4c6080cd6f8b
> > ("lib/list: tweak LIST_POISON2 for better code generation on x86_64")
> > 
> > Probably the simplest fix would be to check for PageSlab() before
> > __PageMovable().
> 
> So I've done with the patch below, that I added to the for-6.1/fit_rcu_head
> branch in slab.git. It's not very nice though with all the new membarriers.
> I hope it's at least correct...
> 
> > But heads up for Joel - if your rcu_head debugging info series (didn't
> > check) has something like a counter in the 3rd 64bit word, where bit 1 can
> > thus be set, it can cause the same issue fooling the __PageMovable() check.
> 
> ----8<----
> From d6f9fbb33b908eb8162cc1f6ce7f7c970d0f285f Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Fri, 9 Sep 2022 12:03:10 +0200
> Subject: [PATCH 2/3] mm/migrate: make isolate_movable_page() skip slab pages
> 
> In the next commit we want to rearrange struct slab fields to allow a
> larger rcu_head. Afterwards, the page->mapping field will overlap
> with SLUB's "struct list_head slab_list", where the value of prev
> pointer can become LIST_POISON2, which is 0x122 + POISON_POINTER_DELTA.
> Unfortunately the bit 1 being set can confuse PageMovable() to be a
> false positive and cause a GPF as reported by lkp [1].
> 
> To fix this, make isolate_movable_page() skip pages with the PageSlab
> flag set. This is a bit tricky as we need to add memory barriers to SLAB
> and SLUB's page allocation and freeing, and their counterparts to
> isolate_movable_page().

Hello, I just took a quick grasp,
Is this approach okay with folio_test_anon()?

> 
> [1] https://lore.kernel.org/all/208c1757-5edd-fd42-67d4-1940cc43b50f@intel.com/
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/compaction.c |  2 +-
>  mm/migrate.c    | 12 +++++++++++-
>  mm/slab.c       |  6 +++++-
>  mm/slub.c       |  6 +++++-
>  4 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 640fa76228dd..b697c207beec 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -972,7 +972,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			 * __PageMovable can return false positive so we need
>  			 * to verify it under page_lock.
>  			 */
> -			if (unlikely(__PageMovable(page)) &&
> +			if (unlikely(!PageSlab(page) && __PageMovable(page)) &&
>  					!PageIsolated(page)) {
>  				if (locked) {
>  					unlock_page_lruvec_irqrestore(locked, flags);
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6a1597c92261..7f661b45d431 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -78,7 +78,7 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	 * assumes anybody doesn't touch PG_lock of newly allocated page
>  	 * so unconditionally grabbing the lock ruins page's owner side.
>  	 */
> -	if (unlikely(!__PageMovable(page)))
> +	if (unlikely(!__PageMovable(page) || PageSlab(page)))
>  		goto out_putpage;
>  	/*
>  	 * As movable pages are not isolated from LRU lists, concurrent
> @@ -94,9 +94,19 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	if (unlikely(!trylock_page(page)))
>  		goto out_putpage;
>  
> +	if (unlikely(PageSlab(page)))
> +		goto out_no_isolated;
> +	/* Pairs with smp_wmb() in slab freeing, e.g. SLUB's __free_slab() */
> +	smp_rmb();
> +
>  	if (!PageMovable(page) || PageIsolated(page))
>  		goto out_no_isolated;
>  
> +	/* Pairs with smp_wmb() in slab allocation, e.g. SLUB's alloc_slab_page() */
> +	smp_rmb();
> +	if (unlikely(PageSlab(page)))
> +		goto out_no_isolated;
> +
>  	mops = page_movable_ops(page);
>  	VM_BUG_ON_PAGE(!mops, page);
>  
> diff --git a/mm/slab.c b/mm/slab.c
> index 10e96137b44f..25e9a6ef4f74 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1370,6 +1370,8 @@ static struct slab *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>  
>  	account_slab(slab, cachep->gfporder, cachep, flags);
>  	__folio_set_slab(folio);
> +	/* Make the flag visible before any changes to folio->mapping */
> +	smp_wmb();
>  	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
>  	if (sk_memalloc_socks() && page_is_pfmemalloc(folio_page(folio, 0)))
>  		slab_set_pfmemalloc(slab);
> @@ -1387,9 +1389,11 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
>  
>  	BUG_ON(!folio_test_slab(folio));
>  	__slab_clear_pfmemalloc(slab);
> -	__folio_clear_slab(folio);
>  	page_mapcount_reset(folio_page(folio, 0));
>  	folio->mapping = NULL;
> +	/* Make the mapping reset visible before clearing the flag */
> +	smp_wmb();
> +	__folio_clear_slab(folio);
>  
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += 1 << order;
> diff --git a/mm/slub.c b/mm/slub.c
> index d86be1b0d09f..2f9cb6e67de3 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1830,6 +1830,8 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
>  
>  	slab = folio_slab(folio);
>  	__folio_set_slab(folio);
> +	/* Make the flag visible before any changes to folio->mapping */
> +	smp_wmb();
>  	if (page_is_pfmemalloc(folio_page(folio, 0)))
>  		slab_set_pfmemalloc(slab);
>  
> @@ -2037,8 +2039,10 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>  	int pages = 1 << order;
>  
>  	__slab_clear_pfmemalloc(slab);
> -	__folio_clear_slab(folio);
>  	folio->mapping = NULL;
> +	/* Make the mapping reset visible before clearing the flag */
> +	smp_wmb();
> +	__folio_clear_slab(folio);
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += pages;
>  	unaccount_slab(slab, order, s);
> -- 
> 2.37.3
> 
> 
> 

-- 
Thanks,
Hyeonggon
