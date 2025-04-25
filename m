Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1961F8ADD;
	Fri, 25 Apr 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745602538; cv=none; b=dFaVU5YaJ6Khb285sQH4WdtVEfN1IvCs7p2/t8NvKciEHiJIrVCaUKzL0kfMaqzQbSBl7TInCGkgDY9BDjWUC/mDg3I9zh9MDK/AzAa8wlEW6w34i61OfO4HQD/wa+svhuQoFMqSUStjjiiTlaY4do4cfmmF9QjilbxPQg8+lIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745602538; c=relaxed/simple;
	bh=Q8NWzs/q2LxS5qzSWu8/lgiyqEiHtsmncNcVNqsQQRA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZVNva8untHTO4g0N17yVDUOxvmQbl99axyNlZ6TL8SUYFRs5MFVS7WCfzjVrc9yHfZNZ9BGIup2TVtQj8KLoloM1JOET5n3mOknZuAkQudTjwfvfxHNjxdLd2CZ/JP90IWsk7AprSTH1xVDUOLeKkaG9LQbFwvTEsmyVvXVIx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=KzT12XIN; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="KzT12XIN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1745602536;
	bh=Q8NWzs/q2LxS5qzSWu8/lgiyqEiHtsmncNcVNqsQQRA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KzT12XINGKfXBZrHKdEmZSd8wj/2BDFrWS8aEEs6WKaiWLLfGXLPHmBELy/b4hozn
	 DAIYJflavzjBVdrtiAvVX0izzYe3wqgRC+tLZ5DKnEApUwcCFtEKjZXPAtqUEac4Nv
	 fxa4JL9fBJG1ZvkDGF4ADgwX/XRkkqqEqt7GY/M0=
Received: by gentwo.org (Postfix, from userid 1003)
	id 9D0C340ECB; Fri, 25 Apr 2025 10:35:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 9C4E0401D1;
	Fri, 25 Apr 2025 10:35:36 -0700 (PDT)
Date: Fri, 25 Apr 2025 10:35:36 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Suren Baghdasaryan <surenb@google.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
    maple-tree@lists.infradead.org
Subject: Re: [PATCH v4 9/9] mm, slub: skip percpu sheaves for remote object
 freeing
In-Reply-To: <20250425-slub-percpu-caches-v4-9-8a636982b4a4@suse.cz>
Message-ID: <c60ae681-6027-0626-8d4e-5833982bf1f0@gentwo.org>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz> <20250425-slub-percpu-caches-v4-9-8a636982b4a4@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Apr 2025, Vlastimil Babka wrote:

> @@ -5924,8 +5948,15 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
>  		return;
>
> -	if (!s->cpu_sheaves || !free_to_pcs(s, object))
> -		do_slab_free(s, slab, object, object, 1, addr);
> +	if (s->cpu_sheaves) {
> +		if (likely(!IS_ENABLED(CONFIG_NUMA) ||
> +			   slab_nid(slab) == numa_node_id())) {

Ah. ok this removes remote object freeing to the pcs.

numa_mem_id() is needed to support memory less numa nodes.

> +			free_to_pcs(s, object);
> +			return;
> +		}
> +	}
> +
> +	do_slab_free(s, slab, object, object, 1, addr);
>  }
>
>  #ifdef CONFIG_MEMCG
>
>
