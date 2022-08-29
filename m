Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B5DC0502E
	for <rcu@archiver.kernel.org>; Mon, 29 Aug 2022 02:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiH2Cur (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 28 Aug 2022 22:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiH2Cup (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 28 Aug 2022 22:50:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79694655C
        for <rcu@vger.kernel.org>; Sun, 28 Aug 2022 19:50:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y1so4815197plb.2
        for <rcu@vger.kernel.org>; Sun, 28 Aug 2022 19:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=tsmy5sh6WL8XJwWoXwRw3rEiyOF19XX/aRCTHG9jdAY=;
        b=bnlIDtIVyiZn9NNgIHSzokf7T3l2PS+fvyGfCdUt2DPQblKcVt0TxBOcg8H99fFlMY
         SkamRyyHeQGyn5W0AKCtd8w+tq+ijMdzzk/M5H4ts7/EbCl+ge34eP8rWiSlr71tBXyO
         IL1oVgzIm7I3sUlprfLjl5BTo4KXJpY9GIzBSoi6YmG7ABqjOQI4GmhV0fxabWNtc9r/
         dpPMpO7Dk4sxPQJRREI9dV/wWeCBkC8kFQB+r948FZ2lvHa6V3WUx8A7f9EXQ+PcsVAB
         gOS2jakpBNT78duVht3AQGtzZ3xpCXzO7usSnSU/MUEo2kQooK7vjZj7YpCbuIH8+HaM
         tYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tsmy5sh6WL8XJwWoXwRw3rEiyOF19XX/aRCTHG9jdAY=;
        b=k0tEV6lsc96QxG8rR6PGMOn1+cF+UrTQo2z+XmWs/u4KRZj8flSsI8z2fPGlcOPgl5
         clqLnXwYhN/IYz/DxvTcSZDx2ItqENrmAZJ6rYqc/LeTQ3ARZyMRWV5dYl5h/o4Z7MiN
         ZojWjbzMus06vzVeEpaKflkL+WpVhwo2FSz/BwY/p9RhgBfayCluSfKrzcA8LuBIJr0c
         lJETRWmjed4EZbarF2aU9yxvWejWnlXuvsuy+yXienuVljeqFRlFwEFSk3UdCbm8f8eZ
         ykZSnUFYWMeCiN9qJAz2AoT17CvKLqbxPwuJgoSdx71bGl8QfOlp4NWx4fLUmHGU/IKt
         e5pw==
X-Gm-Message-State: ACgBeo2gmTtN8tKOYU1gLcpmwCd1/iROHJxUsl7eGYWKEFKWwpAR+U4t
        U0vT9cHoFDRYxQ16nNjpRU0=
X-Google-Smtp-Source: AA6agR6nu0k7Ba1SCC1e/EIMxOW7k9DHP90Fz+135H7E/ynH+wKqFQZz7MMpeM5vAK5bbrVDWRSebQ==
X-Received: by 2002:a17:902:e844:b0:16f:9d2:f4ff with SMTP id t4-20020a170902e84400b0016f09d2f4ffmr14578167plg.27.1661741443758;
        Sun, 28 Aug 2022 19:50:43 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b00172de80fec4sm6073520pll.69.2022.08.28.19.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 19:50:42 -0700 (PDT)
Date:   Mon, 29 Aug 2022 11:50:37 +0900
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
Subject: Re: [RFC PATCH 1/2] mm/slub: perform free consistency checks before
 call_rcu
Message-ID: <YwwpfVvsqEGUW96P@hyeyoo>
References: <20220826090912.11292-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826090912.11292-1-vbabka@suse.cz>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 26, 2022 at 11:09:11AM +0200, Vlastimil Babka wrote:
> For SLAB_TYPESAFE_BY_RCU caches we use call_rcu to perform empty slab
> freeing. The rcu callback rcu_free_slab() calls __free_slab() that
> currently includes checking the slab consistency for caches with
> SLAB_CONSISTENCY_CHECKS flags. This check needs the slab->objects field
> to be intact.
> 
> Because in the next patch we want to allow rcu_head in struct slab to
> become larger in debug configurations and thus potentially overwrite
> more fields through a union than slab_list, we want to limit the fields
> used in rcu_free_slab().  Thus move the consistency checks to
> free_slab() before call_rcu(). This can be done safely even for
> SLAB_TYPESAFE_BY_RCU caches where accesses to the objects can still
> occur after freeing them.
> 
> As a result, only the slab->slab_cache field has to be physically
> separate from rcu_head for the freeing callback to work. We also save
> some cycles in the rcu callback for caches with consistency checks
> enabled.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..d86be1b0d09f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2036,14 +2036,6 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>  	int order = folio_order(folio);
>  	int pages = 1 << order;
>  
> -	if (kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS)) {
> -		void *p;
> -
> -		slab_pad_check(s, slab);
> -		for_each_object(p, s, slab_address(slab), slab->objects)
> -			check_object(s, slab, p, SLUB_RED_INACTIVE);
> -	}
> -
>  	__slab_clear_pfmemalloc(slab);
>  	__folio_clear_slab(folio);
>  	folio->mapping = NULL;
> @@ -2062,9 +2054,17 @@ static void rcu_free_slab(struct rcu_head *h)
>  
>  static void free_slab(struct kmem_cache *s, struct slab *slab)
>  {
> -	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU)) {
> +	if (kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS)) {
> +		void *p;
> +
> +		slab_pad_check(s, slab);
> +		for_each_object(p, s, slab_address(slab), slab->objects)
> +			check_object(s, slab, p, SLUB_RED_INACTIVE);
> +	}
> +
> +	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU))
>  		call_rcu(&slab->rcu_head, rcu_free_slab);
> -	} else
> +	else
>  		__free_slab(s, slab);
>  }

So this allows corrupting 'counters' with patch 2.

The code looks still safe to me as we do only
redzone checking for SLAB_TYPESAFE_RCU caches.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> -- 
> 2.37.2
> 

-- 
Thanks,
Hyeonggon
