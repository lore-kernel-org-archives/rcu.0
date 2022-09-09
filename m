Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD3DC6FA82
	for <rcu@archiver.kernel.org>; Fri,  9 Sep 2022 14:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiIIOcy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIIOcx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Sep 2022 10:32:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA79EE50A
        for <rcu@vger.kernel.org>; Fri,  9 Sep 2022 07:32:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m3so1707162pjo.1
        for <rcu@vger.kernel.org>; Fri, 09 Sep 2022 07:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=oKFW/Ajat0ZxKiKl+LZ3YxI8+tdzSkE0lYrOyOZ67DU=;
        b=GXEhmQYX/QrFMhZymwdtv4fGYIWmZMtObRc/jsFtBymgQ+UkgvakMYD+vESKs+JG2J
         kVDk1cBbPGaMwoSCOCP5BzYhhK3z14eL7er11pHuVjwPPdIk+GAVODxJm+D35JI7l/kw
         ZspoFi3IXQ6MjQhgA/VC1pBrxHL8kZ1o1n+Xuwu3TwUecvDtbIgybA07scXBkY6TT9ov
         RWyCyI29l+yP6bgJzZah4VlEfGb7t/7XYCqOkHr0gKnwJd8CULkZR2iR9PrPFmPwJ836
         Op0f6InGeXzOxOCiVy9aWEqyVdU7kff12X5VVVu24QRlo1jfsjf/cbiwrAf529KClcEL
         xx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oKFW/Ajat0ZxKiKl+LZ3YxI8+tdzSkE0lYrOyOZ67DU=;
        b=UZlZc5L2GpfBKlPRY5w43EuPxbN4Lv7nRJsKYPpM6ZNLfRBdPSZkNyPCdo7LwkgBBc
         HMeMUlXQZLIe/bVvQSLH1yUYamJOIU2nBuwi7Vs1uUmc63GL8e7Lmy2zw3inYN0agBCz
         GVY6l681GzSr1upntwp/LpQo44CphORaJ6F68yeigv3vFMSUO5lHjluzCTO1ZqiOXFTV
         nYQzqEfwxMsLMFyl4E/bdUvfKUo78vgEPPmTKg+skRon9nxKrM1UoPO/Z0N7Xc87oPMa
         3QXddKad24NJTEm+DgLWylEpiKfYebVzgMZEP/FjONZdBXTSfaybiy0XPCKA8lFjPhkv
         sYBQ==
X-Gm-Message-State: ACgBeo3zUBGQQASBVTR1njk/vnWHLQIZwgKJwGsnNuDG2zF3AoN3UI3J
        TRCKl730V5FUJdhkA46Ru2Q=
X-Google-Smtp-Source: AA6agR4NVyX08LllvaDJgu2wHElZyMoIZhQRQLff57keJ0avMKFSlFtJq1OyDU8Glqu7qZn13oWqoA==
X-Received: by 2002:a17:902:b483:b0:170:a89f:32b3 with SMTP id y3-20020a170902b48300b00170a89f32b3mr14220110plr.149.1662733972263;
        Fri, 09 Sep 2022 07:32:52 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id cl18-20020a17090af69200b001fe39bda429sm481316pjb.38.2022.09.09.07.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:32:51 -0700 (PDT)
Date:   Fri, 9 Sep 2022 23:32:45 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Joel Fernandes <joel@joelfernandes.org>,
        linux-mm@kvack.org, rcu@vger.kernel.org, paulmck@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [mm/sl[au]b] 3c4cafa313: canonical_address#:#[##]
Message-ID: <YxtOjYB9DvR4Fkdp@hyeyoo>
References: <20220906074548.GA72649@inn2.lkp.intel.com>
 <208c1757-5edd-fd42-67d4-1940cc43b50f@intel.com>
 <YxdfpTDdfBt6VIpo@hyeyoo>
 <416149c0-1e18-0e00-d116-dd3738957556@suse.cz>
 <aec59f53-0e53-1736-5932-25407125d4d4@suse.cz>
 <Yxsd625lvTS6IWc+@hyeyoo>
 <3d178109-5981-f4ee-8fe5-4f1d0c557ed2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d178109-5981-f4ee-8fe5-4f1d0c557ed2@suse.cz>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 09, 2022 at 03:44:19PM +0200, Vlastimil Babka wrote:
> On 9/9/22 13:05, Hyeonggon Yoo wrote:
> >> ----8<----
> >> From d6f9fbb33b908eb8162cc1f6ce7f7c970d0f285f Mon Sep 17 00:00:00 2001
> >> From: Vlastimil Babka <vbabka@suse.cz>
> >> Date: Fri, 9 Sep 2022 12:03:10 +0200
> >> Subject: [PATCH 2/3] mm/migrate: make isolate_movable_page() skip slab pages
> >> 
> >> In the next commit we want to rearrange struct slab fields to allow a
> >> larger rcu_head. Afterwards, the page->mapping field will overlap
> >> with SLUB's "struct list_head slab_list", where the value of prev
> >> pointer can become LIST_POISON2, which is 0x122 + POISON_POINTER_DELTA.
> >> Unfortunately the bit 1 being set can confuse PageMovable() to be a
> >> false positive and cause a GPF as reported by lkp [1].
> >> 
> >> To fix this, make isolate_movable_page() skip pages with the PageSlab
> >> flag set. This is a bit tricky as we need to add memory barriers to SLAB
> >> and SLUB's page allocation and freeing, and their counterparts to
> >> isolate_movable_page().
> > 
> > Hello, I just took a quick grasp,
> > Is this approach okay with folio_test_anon()?
> 
> Not if used on a completely random page as compaction scanners can, but
> relies on those being first tested for PageLRU or coming from a page table
> lookup etc.
> Not ideal huh. Well I could improve also by switching 'next' and 'slabs'
> field and relying on the fact that the value of LIST_POISON2 doesn't include
> 0x1, just 0x2.

What about swapping counters and freelist?
freelist should be always aligned.  


diff --git a/mm/slab.h b/mm/slab.h
index 2c248864ea91..7d4762a39065 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -27,17 +27,7 @@ struct slab {
 	struct kmem_cache *slab_cache;
 	union {
 		struct {
-			union {
-				struct list_head slab_list;
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-				struct {
-					struct slab *next;
-					int slabs;	/* Nr of slabs left */
-				};
-#endif
-			};
 			/* Double-word boundary */
-			void *freelist;		/* first free object */
 			union {
 				unsigned long counters;
 				struct {
@@ -46,6 +36,16 @@ struct slab {
 					unsigned frozen:1;
 				};
 			};
+			void *freelist;		/* first free object */
+			union {
+				struct list_head slab_list;
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+				struct {
+					struct slab *next;
+					int slabs;	/* Nr of slabs left */
+				};
+#endif
+			};
 		};
 		struct rcu_head rcu_head;
 	};
@@ -81,10 +81,14 @@ SLAB_MATCH(_refcount, __page_refcount);
 #ifdef CONFIG_MEMCG
 SLAB_MATCH(memcg_data, memcg_data);
 #endif
+#ifdef CONFIG_SLUB
+SLAB_MATCH(mapping, freelist);
+#endif
+
 #undef SLAB_MATCH
 static_assert(sizeof(struct slab) <= sizeof(struct page));
 #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && defined(CONFIG_SLUB)
-static_assert(IS_ALIGNED(offsetof(struct slab, freelist), 16));
+static_assert(IS_ALIGNED(offsetof(struct slab, counters), 16));
 #endif
 
 /**
diff --git a/mm/slub.c b/mm/slub.c
index 2f9cb6e67de3..0c9595c63e33 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -487,9 +487,9 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab
 #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
     defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
 	if (s->flags & __CMPXCHG_DOUBLE) {
-		if (cmpxchg_double(&slab->freelist, &slab->counters,
-				   freelist_old, counters_old,
-				   freelist_new, counters_new))
+		if (cmpxchg_double(&slab->counters, &slab->freelist,
+				   counters_old, freelist_old,
+				   counters_new, freelist_new))
 			return true;
 	} else
 #endif
@@ -526,9 +526,9 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
 #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
     defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
 	if (s->flags & __CMPXCHG_DOUBLE) {
-		if (cmpxchg_double(&slab->freelist, &slab->counters,
-				   freelist_old, counters_old,
-				   freelist_new, counters_new))
+		if (cmpxchg_double(&slab->counters, &slab->freelist,
+				   counters_old, freelist_old,
+				   counters_new, freelist_new))
 			return true;
 	} else
 #endif

-- 
Thanks,
Hyeonggon
