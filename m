Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E543B71CE
	for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733369; cv=none; b=Y3mqrRysOhXjGylyB2h/yQrAX/5z0+2L0ttCZ5JNwT1lvtW99WRdxh/n2jRn2zVeMY/zswkPXLPRScm5fY9TlCjmVm33QOQKMqewQEZkU03NTg0Rubw3pduYpUKK29BQnAwByWwBa8AyTPvHa2jP+VkqCV9I92Dh74juqImxykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733369; c=relaxed/simple;
	bh=CsLGx21OxmzsS6r/w1wM+4tvAX2yiYA/4i9KpoVmiXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ax5kK/rSmsX7YgQBXYbd5FGVT3vpCdkhwbmwLZjZusfEkRU1DAICaQvwiYQnaeRsryQbvm7O4Tj4C4Yj12BxwmrLNn0S1zMypDzgwIjH+zbbT/1kIWXzv1tfpcRpbvSgmyA0a3+TNh4N2bid25KtSK3YLhNKHz37IFwexg5pvyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LOpMSUxA; arc=none smtp.client-ip=91.218.175.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LOpMSUxA"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CsLGx21OxmzsS6r/w1wM+4tvAX2yiYA/4i9KpoVmiXA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787733364; v=1; x=1788338164;
 b=LOpMSUxAL8iSDhdbZVVX6J01SAjeozz3Cafcnwu3M09SKms0M1jabej4gOWIObnUqZNKoNuZ
 tKBwH6dHAGscNWIbscMVnlsQW66kt745SQXFDIK2sESC5ounnw9rG36kll2/8lmOdgvRkaxb3zH
 Fhqf2vt1xAUe6ao9B1+iYDbA=
X-Envelope-To: rcu@vger.kernel.org
Received: from fedora (117.129.78.49)
	by smtp.migadu.com with ESMTPS id 7113056e3fa926fe;
	Wed, 26 Aug 2026 08:35:53 +0000
X-Mizu-Trace-ID: 7113056e3fa926fe
X-Migadu-Flow: FLOW_OUT
Date: Wed, 26 Aug 2026 16:35:43 +0800
From: Hao Li <hao.li@linux.dev>
To: Longlong Xia <xialonglong2025@163.com>
Cc: vbabka@kernel.org, harry@kernel.org, akpm@linux-foundation.org, 
	cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, paulmck@kernel.org, 
	rcu@vger.kernel.org, xialonglong@kylinos.cn
Subject: Re: [PATCH v2] mm/slab_common: fix shrink budget underflow in
 kfree_rcu_shrink_scan
Message-ID: <ao6lD5kJMotCFBDU@fedora>
References: <20260826075653.3304251-1-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826075653.3304251-1-xialonglong2025@163.com>

On Wed, Aug 26, 2026 at 03:56:53PM +0800, Longlong Xia wrote:
> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> The kfree_rcu shrinker decremented sc->nr_to_scan (unsigned long)
> and then tested the result with <= 0. When a single CPU's object
> count exceeds the remaining budget, the subtraction wraps to a large
> positive value and the <= 0 comparison, which is equivalent to == 0
> for an unsigned type, never fires again. The scan loop then iterates
> through every possible CPU instead of honouring the reclaim budget.
> 
> Accumulate into freed and stop once freed >= nr_to_scan. The shrinker
> core treats nr_to_scan as input-only, so dropping the decrement is
> safe; freed becomes unsigned long to match the return type.
> 
> Suggested-by: Hao Li <hao.li@linux.dev>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
> ---
> Changes in v2:
> - Rework per suggestion from Hao Li: accumulate into freed directly,
>   compare freed >= nr_to_scan instead of decrementing nr_to_scan, and
>   drop the per-CPU count local; promote freed to unsigned long.
> 
> Link: https://lore.kernel.org/all/20260824091838.1692153-1-xialonglong2025@163.com/
> ---
>  mm/slab_common.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 

Looks good to me. Thanks.
Reviewed-by: Hao Li <hao.li@linux.dev>

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 657fd75776ea..e227c2ef2a4e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -2162,20 +2162,17 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  static unsigned long
>  kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  {
> -	int cpu, freed = 0;
> +	int cpu;
> +	unsigned long freed = 0;
>  
>  	for_each_possible_cpu(cpu) {
> -		int count;
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
> -		count = krc_count(krcp);
> -		count += drain_page_cache(krcp);
> +		freed += krc_count(krcp);
> +		freed += drain_page_cache(krcp);
>  		kfree_rcu_monitor(&krcp->monitor_work.work);
>  
> -		sc->nr_to_scan -= count;
> -		freed += count;
> -
> -		if (sc->nr_to_scan <= 0)
> +		if (freed >= sc->nr_to_scan)
>  			break;
>  	}
>  
> -- 
> 2.43.0
> 

-- 
Thanks,
Hao
