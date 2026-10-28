Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201035;
	b=OuMLf2QdMu9wiwUOn9qmm+nImIzRYeRBVGSBumdHSqJrVrBYwr6GGm7fvca0fEf2luHD
	 CBhpNbFvdvckDxwofzLVBlHvSYdmduwf0W1LK9mPkVoou13de+xnNOnPCYXhBvTvsvz3b
	 jl1qG8KkLMi5+jCsuW3uHB0jngWYz8mHjUY8tMSXbg73Jnr85plAR8A3CksBUNZDwtvje
	 XrrWijPuz+KJT/i2AbPop3ZP1FZA170dqVGlEprdOv8xqSSNJIYP0N+nVHfyI0oJmJfSD
	 qUDSbRdESepkDEJl8gGDXlC70GrbAQkzMIanBls5j+94xOHbZM001nj1GTnsvZkUJTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201035;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QoAi1anA30nDGqKRjbCzfsCZ7EvAt6aSj8TnMwEh3bM=;
	b=fuxHUXWV5s8MorMPcHfxg9N4gIMacLFmpXTpPvP0ZiVzauSHOg9yjuZEPyo1eQ9g5NvS
	 Da3y+rUNBZ5q1uAMbl7sj3o5id4bb0cZgqc3yhjpkEdhpenYWM6l5G8yHVZIFijEL8cyE
	 xiOpK1AUp98nMc9uBdONwL3sa588PG+8cs1WsgRedWUskriaYgW/7QssPkzIPWIQ7fA7R
	 +6LVG8Z/KIe+xvCUl2ztvzgkRiPpPWovwJSUblOCeeZVFB1zC21nGHrB2UUoWLX2Ip/mQ
	 EFeHZqTm9uFX6NueTkQOLKyYC7G/zFi26SmIeFq/Cty92G4J+vQvqS1bn/XT8ovu2GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QogTgp/f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4E606AB31;
	Wed, 28 Oct 2026 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QogTgp/f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1811F031E2;
	Wed, 28 Oct 2026 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793201034;
	bh=QoAi1anA30nDGqKRjbCzfsCZ7EvAt6aSj8TnMwEh3bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QogTgp/fyqrvv5e9CqlhTtGIq+W8x6/uxNE2xmzsUGwM/UVDak56B0zQhzPTw/XIx
	 2vW39ozxc2ZgxP3Xo/kYwlWCg95EeMGtonvOtzWrQ2DQMsRq1Wbd8osUOqjAjodSSk
	 bBv5sIEW+uMTV7S2TnA49X+RBu+dCjJAd8MuIdsk39QNfZU6PKF9zcUMqky3UxfM9a
	 tJtnlXxiNNLZI5LO0QR8saDVGrIcbvm2EPXkdTqPU525Z6mKKUPnZzmeZz1NwAmejb
	 51VSD7zVbK4RDOWqC+ermR6/GuWVtwEHvLSfYDS4oDkpMwvM4M0F8or7hIZE6ORgCY
	 UpIpC2upTbHwg==
Date: Wed, 28 Oct 2026 15:23:52 +0000
From: Harry Yoo <harry@kernel.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: vbabka@kernel.org, urezki@gmail.com, paulmck@kernel.org, 
	qiang.zhang@linux.dev, akpm@linux-foundation.org, hao.li@linux.dev, cl@gentwo.org, 
	rientjes@google.com, roman.gushchin@linux.dev, linux-mm@kvack.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, zhanxusheng@xiaomi.com
Subject: Re: [PATCH 1/2] mm/slab: restore the rcutree. prefix of the
 kvfree_rcu parameters
Message-ID: <auIRU802S4Z4yAmo@thinkstation>
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>

On Wed, Oct 28, 2026 at 09:46:46PM +0800, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> The move of kvfree_rcu() to mm/slab_common.c dropped the "rcutree."
> MODULE_PARAM_PREFIX, so rcu_min_cached_objs and
> rcu_delay_page_cache_fill_msec became slab_common.* and the documented
> rcutree.* names are silently ignored.  Restore the prefix; the
> slab_common.* names, never documented, stop working.
> 
> Fixes: bbe658d65802 ("mm/slab: Move kvfree_rcu() into SLAB")

We should add:

Cc: stable@vger.kernel.org

This is a functional regression and in MM we don't automatically
backport fixes to -stable unless without this tag.

> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  mm/slab_common.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 01c64ef661e7..3729aa7a6156 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1373,6 +1373,10 @@ void __init kvfree_rcu_init(void)
>   * per-CPU. Object size is equal to one page. This value
>   * can be changed at boot time.
>   */
> +/* These used to be rcutree parameters; keep their documented names. */
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX "rcutree."

This should be moved to before "This rcu parameter is
runtime-read-only ..." part?

And perhaps let's rephrase the comment, something like:

/* Keep the prefix inherited from RCU */

With that adjusted, otherwise looks good to me, so:
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
