Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFB4ECAAD3
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 09:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiIAJ4E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiIAJ4C (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 05:56:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5924A82875
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 02:55:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ED246224EA;
        Thu,  1 Sep 2022 09:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662026156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frNTH698AJqcsMt4E6zBkAH5f0H9LpfE3t+oVQ9k56g=;
        b=iQEXGcrzQOfKG8dBTiqDDaPuXohbpmsSijFhKDjpqwrGwf778nJmftT1GvUxZkOQy0p+NM
        9tDRtbLFruuq/kO81k5sY/WbvhpV0QU8TAhyd28VxVG2NmeMKm9b30BPjRkDi+pyRSeMne
        YHhLzFqdSbziHxxELJPV2+MtpxZoUTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662026156;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frNTH698AJqcsMt4E6zBkAH5f0H9LpfE3t+oVQ9k56g=;
        b=/oaE6GTimpXmfLAQP66J6UyBJXVmVl95cqJoURL+48wIluoHaFZBTfKAwmqjAbs4T3N1wJ
        raX/GbH+VavPJoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B630F13A89;
        Thu,  1 Sep 2022 09:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1gY2K6yBEGN2XAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 01 Sep 2022 09:55:56 +0000
Message-ID: <9d57d770-ae74-bbe6-96b4-3073fc250306@suse.cz>
Date:   Thu, 1 Sep 2022 11:55:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH 2/2] mm/sl[au]b: rearrange struct slab fields to allow
 larger rcu_head
Content-Language: en-US
To:     Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>, paulmck@kernel.org,
        rcu@vger.kernel.org
References: <20220826090912.11292-1-vbabka@suse.cz>
 <20220826090912.11292-2-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220826090912.11292-2-vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 8/26/22 11:09, Vlastimil Babka wrote:
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

Both patches now pushed to slab.git for-6.1/fit_rcu_head and for-next

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

