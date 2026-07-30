Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A490392C36;
	Thu, 30 Jul 2026 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445164; cv=none; b=WqIiABs1e6b0Tre8/8JTnwc92Y7wWMSHlMG17bHh+kCGhGozxJpf8YksE068/sgb+WW80GlRDHbEDxgSUBKZGmiGDOvicvfrKDcfrX4rfEx08mY9mOW+8D5HyWJRGbm9PXwuR52A/ajfUYM8Jx5zWDRbom6D0ISJUwgQCNLGuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445164; c=relaxed/simple;
	bh=ybxBfnkIwp1ZqafLSKc5G1hdXeWMpst9lXuUUF17yYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIDDJZjds9idp3zFM8lFYlFcdQKbKB+p7wWHY8AXihROarWKixLjtDgSVBPF+uCqTt95VQHwFq7Bwr9gdYmdM0UQa9fYWV860G1uYPEFz03AvPw33fI7YpbVouMPvM5+T3wkhnEgbb/j1UDAH6EkNdiKrcKisl0dgYHY5UUHAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4VDYtZs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4VDYtZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0D61F000E9;
	Thu, 30 Jul 2026 20:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785445163;
	bh=TdKteJ2Ppi5Qmu1+gV5giVne/pmuTopgGWMGEUu1j1E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=b4VDYtZs2WOhpYQMRq2262d6mVq2UU9G8CF/txykgF8rdH8yJTgx1YwDdpOkrEday
	 glvAEialobwOZKV/W+Lc/MpBeUy/EGRUS7A7m7Ima9Mv2qQkNO3TECwfbKry0tH0BR
	 Z7ONFGjUj/Qe+9QCT4VlMOG2DBGYl2xeEBVpygf8e99q6bgm0B/2llfy01A9uSNeff
	 6AGdSjk/iieBUKz5PYINHFGz+5qPDKy55GQ7N0iGtXJFMo5P8nkH5HYMVk7fTlCMvs
	 mUt6rkh7jL8DzFdCLnQF2Yofr836IcAdVNVW+1zEjPx5IFR4B64gk4+KlW+RBXD7Uh
	 Cg8eRYY8WGFKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A053FCE0B67; Thu, 30 Jul 2026 13:59:22 -0700 (PDT)
Date: Thu, 30 Jul 2026 13:59:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: stop exporting kvfree_rcu_barrier[_on_cache]()
Message-ID: <d2cd0e92-930f-44e4-96e5-67b751419a1c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260730-unexport-barriers-v1-1-852f6641abe9@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-unexport-barriers-v1-1-852f6641abe9@kernel.org>

On Thu, Jul 30, 2026 at 04:32:46PM +0200, Vlastimil Babka (SUSE) wrote:
> No module code calls these functions directly. Seems it was always the
> case. Remove the exports.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

Which reminds me...  Are you guys interested in taking the kfree_rcu()
test code from kernel/rcu/rcuscale.c?  See for example the kfree_rcu_test
module parameter.

							Thanx, Paul

> ---
> Based on slab/for-7.3/kfree_rcu_nolock
> ---
>  mm/slab_common.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 6750dfa27367..cd155ffc2762 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1329,14 +1329,12 @@ void kvfree_rcu_barrier(void)
>  	deferred_work_barrier();
>  	rcu_barrier();
>  }
> -EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>  
>  void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
>  {
>  	deferred_work_barrier();
>  	rcu_barrier();
>  }
> -EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
>  
>  void __init kvfree_rcu_init(void)
>  {
> @@ -2163,7 +2161,6 @@ void kvfree_rcu_barrier(void)
>  	flush_all_rcu_sheaves();
>  	__kvfree_rcu_barrier();
>  }
> -EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>  
>  /**
>   * kvfree_rcu_barrier_on_cache - Wait for in-flight kvfree_rcu() calls on a
> @@ -2186,7 +2183,6 @@ void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
>  	rcu_barrier();
>  	__kvfree_rcu_barrier();
>  }
> -EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
>  
>  static unsigned long
>  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> 
> ---
> base-commit: b01f6ed9ff0c4581fc669044fa5b82a93b4ef144
> change-id: 20260730-unexport-barriers-439b3f69f791
> 
> 
