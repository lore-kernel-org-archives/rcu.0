Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4E48C3EF;
	Thu, 27 Aug 2026 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853523; cv=none; b=PYTRD7kXS42iE+ZB2FE/6DoIfhC83S7rz1MXQoPgal27mAUMG/JT9q6jaL6J4tKg5VLRrgIBRQ5Esuk407bFMs4uwzIHtXxoq467ZBZb7LOScCCT7S/GSzj/i8rIhZhi+nZFIJhpfif49M2Dx/9Ups0IVP8fnx1iRlooRpIzByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853523; c=relaxed/simple;
	bh=uxPNHXRJeIxxq9wsFgY5J7jo9C6N6ctAc7uy7DAdfyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvdLxIdcYTT4oGo1C+CH1sqPQ8IOn+wejIVMjCpZIGVmuclwccQMQMYpi5e3t/jbQfWGajnTmRTk1s1IR1wCqQWv/9SWCK/d92zqS5Uvren9DfstDe4T0oso8zZjoeEFY1UGHG7gpKKRt7nAsr0i8pLnShVokFEVXrXcpiFsk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7OLt49Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7OLt49Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC21B1F000E9;
	Thu, 27 Aug 2026 17:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787853520;
	bh=JxlJpDQyQFzHEq4tuOreXaxxV5u5t+RTGSliu4umBE8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=S7OLt49YZeiVVdQw9iTWDVyJIr4WGoWnCYZo/8ffdVwRk/CiD3d/nhY1EDacv2PEk
	 Xp3SxjZ9N7kcHbLJyODO9RXgCvitUuCdEaEs35qKeHNdeaVmKAxO/LX2SbXrK09s6F
	 fiqSlGmOHwc2PiZrUbRODRd4plRaPVgQxJaUStg4qeOU6iAivSuFiaWB3VNwsVGeLV
	 mpikoTL5H1EO6SDHQikzQdDH84FwdKmUVrJB2aGrp2hHEIeh2rCuoRk5vCeQThzQZL
	 olUf1SwHi5f4X41KLV0hUxjCWklDONegKLq4lc7FVE1/16MvMCeaCTjVML1geeWA/A
	 B4fwVWwdYhjRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 84FD3CE1496; Thu, 27 Aug 2026 10:58:40 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:58:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Longlong Xia <xialonglong2025@163.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang@linux.dev,
	vineeth@bitbyteword.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	xialonglong@kylinos.cn
Subject: Re: [PATCH v2] rcu: fix shrink budget underflow in
 lazy_rcu_shrink_scan
Message-ID: <cab37470-6e76-4163-9a9a-155e74cfb728@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260826082150.3311391-1-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826082150.3311391-1-xialonglong2025@163.com>

On Wed, Aug 26, 2026 at 04:21:50PM +0800, Longlong Xia wrote:
> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> The lazy RCU shrinker decremented sc->nr_to_scan (unsigned long)
> and then tested the result with <= 0.  When a single CPU's lazy
> callback count exceeds the remaining budget, the subtraction wraps
> to a large positive value and the <= 0 comparison, which is
> equivalent to == 0 for an unsigned type, never fires again.  The
> scan loop then iterates through every nocb CPU instead of honouring
> the reclaim budget.
> 
> Accumulate into count and stop once count >= nr_to_scan.
> 
> Fixes: c945b4da7a448 ("rcu: Shrinker for lazy rcu")
> Assisted-by: Zcode:GLM-5.2
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

OK, I should have read ahead.

This one looks even more plausible, and quite a bit simpler.  I have
replaced your v1 with this patch.

Frederic, thoughts?

							Thanx, Paul

> ---
> Changes in v2:
> - Rework to accumulate into count directly and compare count >= nr_to_scan
>   instead of decrementing nr_to_scan, matching the kfree_rcu_shrink_scan()
>   fix reworked per Hao Li's suggestion.
> 
> Link: https://lore.kernel.org/all/20260824133142.2293426-1-xialonglong2025@163.com/
> ---
>  kernel/rcu/tree_nocb.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 19bb42672baf..b6cfee4e5039 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1332,9 +1332,8 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		rcu_nocb_try_flush_bypass(rdp, jiffies);
>  		rcu_nocb_unlock_irqrestore(rdp, flags);
>  		wake_nocb_gp(rdp);
> -		sc->nr_to_scan -= _count;
>  		count += _count;
> -		if (sc->nr_to_scan <= 0)
> +		if (count >= sc->nr_to_scan)
>  			break;
>  	}
>  
> -- 
> 2.43.0
> 
