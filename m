Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C406A489895;
	Wed, 14 Oct 2026 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792022302; cv=none; b=HUVx7pFzklAdaFfOSUGAdMfVjj+6MTNudwTgVZE71bwqp02lH3/s0ldIz8wK6F2EE4cjpbTUd1BlgjRizgMGh8VNjBbhfZhvvs4wGqtNIsnNGKv7sb5o8uOWaH3CV9Kv5YeY3fU/Gao3K8VGguX7qz+GmrI0JLOkQ19eSGE3+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792022302; c=relaxed/simple;
	bh=66ZjcTOK+I5gPHC6fEFP+ZPOOSBNjOrBGwEhdUWqiMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMDjCm+IG7voEUAmqjTAkhSfeFiOwRWVGQoV7q/v+7HEuLFTRmoZ1nYzuWbVFnaoASQSFPWQYis1ElzK0N50BAWR+swKEs/bFrR95PQauni2RpuQIA2Xvx8SbjKSbUxXLiX9Vvhe2ZTW5SzEqbQNc8jUN5lcx5PdLQCCc2rWnJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A33F829G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A33F829G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586C21F000C4;
	Wed, 14 Oct 2026 23:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792022301;
	bh=+GQVMGiuWpacm/yY0sBxB5nCl27MVCd9qUh4v9ttBgk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=A33F829G1+QLV10Te1Z6d1QN9JhJOT1c2SfcOsQMGrXRuySms+ECpjPP3jgIVNZWW
	 wXzpMwlnGnABcjByC/5q2ak3l7LtlWB/Kk4zhLSpELzhfw3KIznYeP+JebZNVPS3Gj
	 VzAynwu4+DgjvNYfuBM06NIISVCpmeQtFCYG8nCtRhW3pG2gBZ+vaYkiZ/J5MYZfe/
	 9zr/BnKL+/q2zYszZOy9E57e0i1a2VNJEvcvHo9B0I6IC7xwt7X4fUZahpm2GMZUyV
	 AhcfTUf7luW5eVXHibhev+oj4jQ4PdPvQ+/vHwCP1MBj4lJOq/RYE3okkDWKaW+Kpj
	 Lrv+ihhwo+g8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 16F3DCE0C55; Wed, 14 Oct 2026 16:58:21 -0700 (PDT)
Date: Wed, 14 Oct 2026 16:58:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH 1/5] include/linux/rculist_nulls: add
 hlist_nulls_add_behind_rcu()
Message-ID: <7037ee68-5dcb-46ed-a73f-ed6ea58915f4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261012205447.2717801-1-max.kellermann@ionos.com>
 <20261012205447.2717801-2-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012205447.2717801-2-max.kellermann@ionos.com>

On Mon, Oct 12, 2026 at 10:54:43PM +0200, Max Kellermann wrote:
> Move some code from hlist_nulls_add_tail_rcu() to the new function
> hlist_nulls_add_behind_rcu() for callers that already know the last
> node of an `hlist_nulls` list, to allow constant-time appends.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

I am assuming that this commit should take the same path as the rest
of them.  So:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/rculist_nulls.h | 36 +++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> index a97c3bcb1656..054e477dd093 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -115,6 +115,33 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
>  		WRITE_ONCE(first->pprev, &n->next);
>  }
>  
> +/**
> + * hlist_nulls_add_behind_rcu - append after the last list entry
> + * @n: the new element to add to the hash list.
> + * @last: the last element in the list.
> + *
> + * Adds the specified element after @last while permitting racing RCU
> + * traversals.  @last must be the last list entry, with its next
> + * pointer holding the terminating nulls marker.
> + *
> + * The caller must take whatever precautions are necessary
> + * (such as holding appropriate locks) to avoid racing
> + * with another list-mutation primitive, such as hlist_nulls_add_head_rcu()
> + * or hlist_nulls_del_rcu(), running on this same list.
> + * However, it is perfectly legal to run concurrently with
> + * the _rcu list-traversal primitives, such as
> + * hlist_nulls_for_each_entry_rcu(), used to prevent memory-consistency
> + * problems on Alpha CPUs.  Regardless of the type of CPU, the
> + * list-traversal primitive must be guarded by rcu_read_lock().
> + */
> +static inline void hlist_nulls_add_behind_rcu(struct hlist_nulls_node *n,
> +					      struct hlist_nulls_node *last)
> +{
> +	WRITE_ONCE(n->next, last->next);
> +	WRITE_ONCE(n->pprev, &last->next);
> +	rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
> +}
> +
>  /**
>   * hlist_nulls_add_tail_rcu
>   * @n: the element to add to the hash list.
> @@ -143,13 +170,10 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
>  	for (i = h->first; !is_a_nulls(i); i = i->next)
>  		last = i;
>  
> -	if (last) {
> -		WRITE_ONCE(n->next, last->next);
> -		WRITE_ONCE(n->pprev, &last->next);
> -		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
> -	} else {
> +	if (last)
> +		hlist_nulls_add_behind_rcu(n, last);
> +	else
>  		hlist_nulls_add_head_rcu(n, h);
> -	}
>  }
>  
>  /* after that hlist_nulls_del will work */
> -- 
> 2.47.3
> 
> 
