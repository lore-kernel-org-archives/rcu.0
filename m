Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DE3B5F63;
	Sun, 30 Aug 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788099786; cv=none; b=HSGxdmX9IVnXaAxBpFbX/efkLH9UZV3n/ChZQCnkrGjVY+j1ifuwgdDfWwC51ChgcCaWCu3WZlKyTzUEQPCQFvEV6DSbaApIAM3i8lQ68ZJ/K0DqpdmpzmnX5Nms4mM1qevuGPj2go6tnBknBR72jRRfJT0YAESUZoeRN8w+h74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788099786; c=relaxed/simple;
	bh=tSFkx6LTEwoodmn/GWSqXreyxx5xhWG5rKj78rchVq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4w3qRdR2ApxUZoVGlE0uqgYVD+hunpFYaU53ZY+WJPm//qk9LvWDGRbECd5ayk6c9/IzkLvba4643sEQYatDzLfb+ITJ1EWjTp4agh+AVggupv0XITejLqOjYdpsu0ZUfLQ6LyCSkp3FZuL0Cj5ZCqFyjp5Ziy2cTTQUpUIO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHTeeJJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHTeeJJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96A91F00A3D;
	Sun, 30 Aug 2026 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788099780;
	bh=k2CnB52Tk5cRweLryWaQrcbSePVmhdv7HPuySx6iD00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lHTeeJJtetJ10FlpfgFKQuH6khW+G77eLdx/731U/wNZL+ULKdytVS8RD5MgvsL5y
	 /XGmxrlh1K/stjh3feuQRwxo4swiK+RvVCU8at80IKz98IJkI6M8LRIZ8x15JtnCUi
	 dKEStnxbZ1OMK5QWVWnRzWx8OXk+2b/hoFNh6DGOtpPcMt91Oixi1S33IusPNaaKEF
	 3eaj8tzVDMPY0CORKNjqu5/SSqcZeOH1bmTyey63lm/egQF1HL2nhh8+CZznVsZlvd
	 q60bTKfc9/TxfGhJD5c6VN9Rcdn0C+nafz452dBreh+KKDabovfu+n/RR2wseqtqG3
	 uRZ6l9SefqqDA==
Date: Sun, 30 Aug 2026 14:22:56 +0000
From: Harry Yoo <harry@kernel.org>
To: Longlong Xia <xialonglong2025@163.com>
Cc: vbabka@kernel.org, akpm@linux-foundation.org, hao.li@linux.dev, 
	cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, paulmck@kernel.org, 
	rcu@vger.kernel.org, xialonglong@kylinos.cn
Subject: Re: [PATCH v2] mm/slab_common: fix shrink budget underflow in
 kfree_rcu_shrink_scan
Message-ID: <apQsbGJDPPyXcn8R@dev>
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

Hi Longlong, I have a few questions.

> The kfree_rcu shrinker decremented sc->nr_to_scan (unsigned long)
> and then tested the result with <= 0. When a single CPU's object
> count exceeds the remaining budget, the subtraction wraps to a large
> positive value and the <= 0 comparison, which is equivalent to == 0
> for an unsigned type, never fires again.

Since when (which commit) has it been broken?
If it has been undiscovered for a very long time, why is that so?

And how did you discover this?

> The scan loop then iterates
> through every possible CPU instead of honouring the reclaim budget.

Did you confirm this actually does happen? If so, how often does the
kernel end up iterating through every possible CPUs, very rarely or
almost always?

Would this affect the kernel's reclamation behavior in some way?

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

-- 
Cheers,
Harry / Hyeonggon
