Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5481FC0502A
	for <rcu@archiver.kernel.org>; Mon, 29 Aug 2022 02:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiH2Cyg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 28 Aug 2022 22:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiH2Cyf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 28 Aug 2022 22:54:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DA23D592
        for <rcu@vger.kernel.org>; Sun, 28 Aug 2022 19:54:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v4so6497397pgi.10
        for <rcu@vger.kernel.org>; Sun, 28 Aug 2022 19:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=W5LxLoKuyys0IItMw+GbT9k3jlPXKZl4pMaWjkBJqco=;
        b=hiZhgaVKa47sMDhAlXnKCxaXA/MXNjidZqHQKioNHQ9dCa1N5OdHNNJbFKQY6Awk/E
         Xu6a/J1KT5C2SwXgUWXZfFh5lDY9OuJdUfh+nRCDxCe393QG4Md06M5SxCPsGrwDPY6q
         PlOsjPywiZ0QIrLi0PuW+7VeROrsvjaFR43RJ4U/XoK2UZlyfriPV5OhSzcquBJWfVXd
         Y5CKDIQBSdmKDlLIfvVBlvxu7ikls9Krdinz6PiwANVi5+uVCKcsds73Me8gUQUFJW09
         ir7pS5N43DN81NmUlXV9kAy6tRP2Pj2xFos+DiWChPorPrI6zrDhFa4mjTnrWpTZRmsb
         HXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=W5LxLoKuyys0IItMw+GbT9k3jlPXKZl4pMaWjkBJqco=;
        b=R+HzFwQ0thIOCXZQkOwQXfP29ofPacAvdSVAoG3i9cZGJGe0PNw+2jv/JvOlz0jRwl
         TK6pcw7t8bn/+YDaoc22mu1qOsF6jXckHUanKIcUVgH80kWOSrIsNVgSFx2Co3Hv3IfZ
         //m59UZUQa1PhrIUAU2ptTMKeaz4ndxVtNvfrZ916JEl6gcxvoX1BRPPCFBRJ4T8bIqn
         u9tceOKC1LHKIG9u72uVvl6UhmlX4b7xmKH4t4kmwTZ6ob9i/+ipSsI2g0cIoF8DWZ6A
         x5mYiP08bNciIt6MeGVwWvFO6V+vMQV/VqIE/HFkpGCqACDMV0tKKaMgWfyJ26ZyVnUe
         +N3Q==
X-Gm-Message-State: ACgBeo02wSeR/nTuc983i003hLedEDuIhKN3udWTlSBny5IydNKbM3Pw
        RPbi2T2O/KI64i6d7n5xxT4=
X-Google-Smtp-Source: AA6agR5cIY03YvMSX8LlmRSbW1BDQnh/iwbmjhntMpLAFAr2IKvHO/tCbnU/27Q1SnpoRlEd2/ARWA==
X-Received: by 2002:a62:188f:0:b0:536:ee23:e3ed with SMTP id 137-20020a62188f000000b00536ee23e3edmr14535658pfy.33.1661741674211;
        Sun, 28 Aug 2022 19:54:34 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090a400500b001fabaeb1245sm5468303pjc.24.2022.08.28.19.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 19:54:33 -0700 (PDT)
Date:   Mon, 29 Aug 2022 11:54:27 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>, paulmck@kernel.org,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm/sl[au]b: rearrange struct slab fields to
 allow larger rcu_head
Message-ID: <YwwqY8ScFiqMi0fD@hyeyoo>
References: <20220826090912.11292-1-vbabka@suse.cz>
 <20220826090912.11292-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826090912.11292-2-vbabka@suse.cz>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 26, 2022 at 11:09:12AM +0200, Vlastimil Babka wrote:
> Joel reports [1] that increasing the rcu_head size for debugging
> purposes used to work before struct slab was split from struct page, but
> now runs into the various SLAB_MATCH() sanity checks of the layout.
> 
> This is because the rcu_head in struct page is in union with large
> sub-structures and has space to grow without exceeding their size, while
> in struct slab (for SLAB and SLUB) it's in union only with a list_head.
> 
> On closer inspection (and after the previous patch) we can put all
> fields except slab_cache to a union with rcu_head, as slab_cache is
> sufficient for the rcu freeing callbacks to work and the rest can be
> overwritten by rcu_head without causing issues.
> 
> This is only somewhat complicated by the need to keep SLUB's
> freelist+counters aligned for cmpxchg_double. As a result the fields
> need to be reordered so that slab_cache is first (after page flags) and
> the union with rcu_head follows. For consistency, do that for SLAB as
> well, although not necessary there.
> 
> As a result, the rcu_head field in struct page and struct slab is no
> longer at the same offset, but that doesn't matter as there is no
> casting that would rely on that in the slab freeing callbacks, so we can
> just drop the respective SLAB_MATCH() check.
> 
> Also we need to update the SLAB_MATCH() for compound_head to reflect the
> new ordering.
> 
> While at it, also add a static_assert to check the alignment needed for
> cmpxchg_double so mistakes are found sooner than a runtime GPF.
> 
> [1] https://lore.kernel.org/all/85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org/
> 
> Reported-by: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h | 54 ++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 4ec82bec15ec..2c248864ea91 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -11,37 +11,43 @@ struct slab {
>  
>  #if defined(CONFIG_SLAB)
>  
> +	struct kmem_cache *slab_cache;
>  	union {
> -		struct list_head slab_list;
> +		struct {
> +			struct list_head slab_list;
> +			void *freelist;	/* array of free object indexes */
> +			void *s_mem;	/* first object */
> +		};
>  		struct rcu_head rcu_head;
>  	};
> -	struct kmem_cache *slab_cache;
> -	void *freelist;	/* array of free object indexes */
> -	void *s_mem;	/* first object */
>  	unsigned int active;
>  
>  #elif defined(CONFIG_SLUB)
>  
> -	union {
> -		struct list_head slab_list;
> -		struct rcu_head rcu_head;
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -		struct {
> -			struct slab *next;
> -			int slabs;	/* Nr of slabs left */
> -		};
> -#endif
> -	};
>  	struct kmem_cache *slab_cache;
> -	/* Double-word boundary */
> -	void *freelist;		/* first free object */
>  	union {
> -		unsigned long counters;
>  		struct {
> -			unsigned inuse:16;
> -			unsigned objects:15;
> -			unsigned frozen:1;
> +			union {
> +				struct list_head slab_list;
> +#ifdef CONFIG_SLUB_CPU_PARTIAL
> +				struct {
> +					struct slab *next;
> +					int slabs;	/* Nr of slabs left */
> +				};
> +#endif
> +			};
> +			/* Double-word boundary */
> +			void *freelist;		/* first free object */
> +			union {
> +				unsigned long counters;
> +				struct {
> +					unsigned inuse:16;
> +					unsigned objects:15;
> +					unsigned frozen:1;
> +				};
> +			};
>  		};
> +		struct rcu_head rcu_head;
>  	};
>  	unsigned int __unused;
>  
> @@ -66,9 +72,10 @@ struct slab {
>  #define SLAB_MATCH(pg, sl)						\
>  	static_assert(offsetof(struct page, pg) == offsetof(struct slab, sl))
>  SLAB_MATCH(flags, __page_flags);
> -SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
>  #ifndef CONFIG_SLOB
> -SLAB_MATCH(rcu_head, rcu_head);
> +SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
> +#else
> +SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
>  #endif
>  SLAB_MATCH(_refcount, __page_refcount);
>  #ifdef CONFIG_MEMCG
> @@ -76,6 +83,9 @@ SLAB_MATCH(memcg_data, memcg_data);
>  #endif
>  #undef SLAB_MATCH
>  static_assert(sizeof(struct slab) <= sizeof(struct page));
> +#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && defined(CONFIG_SLUB)
> +static_assert(IS_ALIGNED(offsetof(struct slab, freelist), 16));
> +#endif
>  
>  /**
>   * folio_slab - Converts from folio to slab.
> -- 
> 2.37.2
> 

Looks sane to me.

For slab part:
Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
