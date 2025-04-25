Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CB21922D4;
	Fri, 25 Apr 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745602313; cv=none; b=hgv4a2/t12wOOvzrMLMxMcVEpz88/tGnr9uSzAbRlh6icqx0rSkMQZo6k6YE57Mff/ZXuP/swasw1WMH43+DcI0917vVyESKMVL/VNmrURGBi7CpYmODrST9Vx75pM9nv5vIvFxzvZfSe74EElWA+bO+1+FFPjOhqJDV3NAz4t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745602313; c=relaxed/simple;
	bh=9gJmImKVC4FuwSLCJcEUR0D4hi3kC8HpgxyNxRL/kcs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FgGQt/KgdsX4F7q2qOVRYNHV18bTwCdgFyZAjT7DuMz2QO8R3CYoImAImjSP8JHfGXoztg/It7yXGf8v+CvtGCadyYCo0nZ+ZcgE/Qicn/9jhRog5e/+2gUmSOsQKPq2oJopqVahVYbHRZR2WvZb602qvcSFxA2XKpngNWCKEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=TOQ7r9lM; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="TOQ7r9lM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1745602305;
	bh=9gJmImKVC4FuwSLCJcEUR0D4hi3kC8HpgxyNxRL/kcs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=TOQ7r9lMIw0rJsRtufCdwQcxGKiHlx8AFjeTZlxEOXa6wuYW4XcDS50vGh0gxqAkK
	 XJlQsakXW4faKV6Y8jKpm9qFirmuV+ImsadlHgMf4L6brB5IjzVAAHHrPfQtTgR8LI
	 Xqticjj2qj4MJGtl+O8Pik/NvN2suB4awUm27SVw=
Received: by gentwo.org (Postfix, from userid 1003)
	id A90654027F; Fri, 25 Apr 2025 10:31:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id A8161401D1;
	Fri, 25 Apr 2025 10:31:45 -0700 (PDT)
Date: Fri, 25 Apr 2025 10:31:45 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Suren Baghdasaryan <surenb@google.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
    maple-tree@lists.infradead.org
Subject: Re: [PATCH v4 1/9] slab: add opt-in caching layer of percpu
 sheaves
In-Reply-To: <20250425-slub-percpu-caches-v4-1-8a636982b4a4@suse.cz>
Message-ID: <142aeeb5-d6d8-84ca-e7a2-ba564185c565@gentwo.org>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz> <20250425-slub-percpu-caches-v4-1-8a636982b4a4@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Apr 2025, Vlastimil Babka wrote:

> @@ -4195,7 +4793,11 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
>  	if (unlikely(object))
>  		goto out;
>
> -	object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
> +	if (s->cpu_sheaves && node == NUMA_NO_NODE)
> +		object = alloc_from_pcs(s, gfpflags);

The node to use is determined in __slab_alloc_node() only based on the
memory policy etc. NUMA_NO_NODE allocations can be redirected by memory
policies and this check disables it.


> @@ -4653,7 +5483,10 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  	memcg_slab_free_hook(s, slab, &object, 1);
>  	alloc_tagging_slab_free_hook(s, slab, &object, 1);
>
> -	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), false)))
> +	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
> +		return;
> +
> +	if (!s->cpu_sheaves || !free_to_pcs(s, object))
>  		do_slab_free(s, slab, object, object, 1, addr);
>  }

We free to pcs even if the object is remote?

