Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950361AF0A0;
	Mon,  4 Nov 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720868; cv=none; b=UIeQU4ayn5w1xCRl4y8Rsra0uNQ/YpjRFA7VYeMWEtxcF6okjGOUoclUSxoKgBqx4ZB6EgnDfBZVfT96cA8NAdu1dTja1FCAVcrdmfOX976fhFecUHC7lAri1owzNM5JJ1/j6otzL66Z/D71uBQTQl2s7OoNsQMNbdWXMeEuKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720868; c=relaxed/simple;
	bh=psPIY7Sng851pKS/3767nhrEFkWBcdFak70DiKUQAaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hchIjp76GMCyJmYpRxM1UPdp/a5JNGWILTUwskDOWBlgoVSudNSztau4OQ1v83TfrpRqXndMdsNhEOzFdQE3jQK9czywxqwdq0tUCS1Ox6Iq9A3H9i+ivmJtGz5yFkgEbNKZd5cHSHNv1uK0xF6Q55+kgtY0KltZk0miqzAa5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eX6aRPOy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eX6aRPOy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xA1XZPA7ROpkAWO42tjuiUPyY5dJ4CkrP0Yv74uKLYE=; b=eX6aRPOyNRtCJ8XY4us2x8FSBC
	fJZCOC+0l8fNsbvxB3DAkntZ5h0qHqfI8Qr47zKwMMhwzCOwARnKGtyVYHyJZvvX/YsmquFfisqYw
	h9VWHztKViX9J7KJYjSM9qTuXbLyHXk+u5DN53x0uhMhydwM2pIMjG6w06iiNuz+9emYKT+MO3JFq
	0wnHlEc7JnbTU3YJsax6FxzyJxFpm2sf5XSnJsW/YgshQRTQRBDGzTK67rf7KoOeKALEG1ryudurQ
	JYrFo0+/BDVsuP8P0chDrEgDC+0NEMHnZ608/J5ma0YHZ2nO9qXRmdjvoZBJjiOIX2m2Zos+kqWnC
	IsLDgQ1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7vYM-0000000BJRc-2PoW;
	Mon, 04 Nov 2024 11:47:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3837C300324; Mon,  4 Nov 2024 12:47:26 +0100 (CET)
Date: Mon, 4 Nov 2024 12:47:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	kasan-dev <kasan-dev@googlegroups.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Waiman Long <longman@redhat.com>, dvyukov@google.com,
	vincenzo.frascino@arm.com, paulmck@kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, rcu@vger.kernel.org
Subject: Re: [syzbot] [mm?] WARNING: locking bug in __rmqueue_pcplist
Message-ID: <20241104114726.GD24862@noisy.programming.kicks-ass.net>
References: <67275485.050a0220.3c8d68.0a37.GAE@google.com>
 <ee48b6e9-3f7a-49aa-ae5b-058b5ada2172@suse.cz>
 <b9a674c1-860c-4448-aeb2-bf07a78c6fbf@suse.cz>
 <20241104114506.GC24862@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104114506.GC24862@noisy.programming.kicks-ass.net>

On Mon, Nov 04, 2024 at 12:45:06PM +0100, Peter Zijlstra wrote:
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 6310a180278b..ac9f6682bb2f 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -521,12 +521,12 @@ size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
>  			sizeof(struct kasan_free_meta) : 0);
>  }
>  
> -static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
> +void kasan_record_aux_stack(void *addr)
>  {
>  	struct slab *slab = kasan_addr_to_slab(addr);
>  	struct kmem_cache *cache;
>  	struct kasan_alloc_meta *alloc_meta;
> -	void *object;
> +	void *object

Clearly I'm still struggling to type ... *sigh*
