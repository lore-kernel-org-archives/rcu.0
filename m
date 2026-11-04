Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780245;
	b=MZ5zPuRVAw8UlhDh7El9LtYziT/9cpv/jM29/pHzpDc4Fbt7VkT1D0vihw9jowAtA0lf
	 uINaVxie/60tLoCft6crfDx8eJjKQ9rzYhiFBctBxdI389dvvA+qqEsHigDRDfJzR4Im3
	 +W2EnsrXenQVDu96fMmaCcwrhsG5jxViuhEcqgLeLepyUiexOv2uWAKCFAajXI23CqgVC
	 iVEYGVaBptMft7VWVtB76Zcp7oC0CJlXE8nQFMeBDOhkGvTv7zQ3qaf2d7QJ27p1RP+x/
	 DNs/CYYlCHKJnjxz5ixLVai6OYW46Tyl5PhtjZS0Wlp+byR+SDW/QB92rC4YIf0xAaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780245;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sSlKHe6xc24svxDkA3PbRnbZQ2Hd6+8PIRLhRVLtkNA=;
	b=NJjStKTfNipFDJDq9fcE+TM9ePfob4byx0sOhoaydsiRmE61jGgl2o+vZiabY7gKhvVM
	 XMXyM7+oE2EzpVdskh0vtqJuDnIje5SNT1VCFLF3Itx7wkJ1mBMlqyNKMjwsve34kyfy4
	 cToYQTla0WuAS9fks65FGBVWUqPZWSNDbZMqXDrCSVTH8Jcovi55Bs+eDJUYkD4auXXMp
	 bxBU4aOpgqDkhLn9O84sRvUg5msTli+eCH3cNfn+Jyl3CzYmCb2oqSeMLayT9mQroNBUQ
	 Lb+FxqDIWy3mwSAMm7YFus2gL7D0odQzcWoy+7m0Gvznb4q9Hik/S1wcUr6zTtUQgfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXTYrDSE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7CA606A326;
	Wed,  4 Nov 2026 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXTYrDSE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2DB1F000C1;
	Wed,  4 Nov 2026 08:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793780244;
	bh=sSlKHe6xc24svxDkA3PbRnbZQ2Hd6+8PIRLhRVLtkNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bXTYrDSE8v1k4UTrZsaWqhHJsS3KHpcVQ9MpNm3mcEPTD8vb2ex7rANe82ae4M8i/
	 U+Ge7YFlUWCEP+xm3yD8oGT2QLL60w+3jeGfHcyFOzeMowbYgPtorwLeFSLQWRoFeh
	 vKaFxSbDESgRLNr8rWHYeENa5CsIt+x0S+Hw+SDaqHy4nHKjSi9n+hqfwW6di2LYzU
	 xbQjrqsjQGFpGz4zHt46mCInYTWrKSrUysrH238MZo9pFr/I/LN3RKu+vLVtg/E+W3
	 mC/OYkkJrUji6ca7e4xgedrR5Lj2PqIbcDkFwq3tn2lxiWWhI7rbo/Goy/r3fDxpLJ
	 5OQ3BzFslQzPQ==
Message-ID: <634f37c7-6096-49db-8cfc-7c5421631322@kernel.org>
Date: Wed, 4 Nov 2026 09:17:19 +0100
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/slab: restore the rcutree. prefix of the
 kvfree_rcu parameters
Content-Language: en-US
To: Harry Yoo <harry@kernel.org>, Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: urezki@gmail.com, paulmck@kernel.org, qiang.zhang@linux.dev,
 akpm@linux-foundation.org, hao.li@linux.dev, cl@gentwo.org,
 rientjes@google.com, roman.gushchin@linux.dev, linux-mm@kvack.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org, zhanxusheng@xiaomi.com
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
 <auIRU802S4Z4yAmo@thinkstation> <auiedkWD41Ok95TT@thinkstation>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <auiedkWD41Ok95TT@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 15:33, Harry Yoo wrote:
> I adjusted my feedback. End result:
> 
> mm/slab: restore the rcutree. prefix of the kvfree_rcu parameters
> 
> The move of kvfree_rcu() to mm/slab_common.c dropped the "rcutree."
> MODULE_PARAM_PREFIX, so rcu_min_cached_objs and
> rcu_delay_page_cache_fill_msec became slab_common.* and the documented
> rcutree.* names are silently ignored.  Restore the prefix; the
> slab_common.* names, never documented, stop working.
> 
> Fixes: bbe658d65802 ("mm/slab: Move kvfree_rcu() into SLAB")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
> Link: https://patch.msgid.link/20261028134647.3176080-1-zhanxusheng1024@gmail.com
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/slab_common.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 01c64ef661e7..41dea01a8c1f 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1367,6 +1367,10 @@ void __init kvfree_rcu_init(void)
>  
>  #else /* CONFIG_KVFREE_RCU_BATCHED */
>  
> +/* Keep the prefix inherited from RCU */
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX "rcutree."
> +
>  /*
>   * This rcu parameter is runtime-read-only. It reflects
>   * a minimum allowed number of objects which can be cached

