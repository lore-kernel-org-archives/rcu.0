Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0AE2D063B;
	Tue,  9 Sep 2025 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409289; cv=none; b=bENLLS/DrsPMS4Kglt0MT14hxw6H2SZfyDJOdx9vBGnDN3OBmBnyo75IpA8zkwqlqN/rkpbLfaYh3ZtyQlrBgtfH6ZiyWRKC0ogBLq8LCfwgFKS5ZHYFiM76naYB7ZtIG1yED0ha3Y/rQ9FTXulgpgqbq/XaacGU8mhJCuQXk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409289; c=relaxed/simple;
	bh=zqg5XObHZJ1WhqCdurwjJ3PX7RaCmmcurJQvtEyZEFE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFzJEyhuBaBjWL68xo51S/6YVfK4qsl9zVe8gpgV8cEvulzwBy5+y1n5c+zQIoi9ai7hESb3hI2vhgq29Ub2kJJIQLD5gn99ib/MeVqAiIVrmUidkI7GewES0a4w1cu5Dum9F7hUUSjWX45Ole+cvL/JvaSQel7Pijj/uSDAjI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr34zK0p; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr34zK0p"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f6507bd53so5763841e87.3;
        Tue, 09 Sep 2025 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409286; x=1758014086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/RxmiKOX9ZqvhLioBhgvr1KVktvLZ6CG0rToqxQ3c5A=;
        b=nr34zK0p1AZrxa0MbYLiKj6zcKmCCAW7gBttDDe7c3izwH/Gbu5zuXfWfgnx8kAJQ5
         Ib9nBu8IYz0MrnPpuWglPexVk7jo8xRgmjDIuesoAPKoh+GPc4MENwp5f1y47d2QZoqV
         7COhzcgvd8F4a76/iJZuDdL4au/eTplXFvz3rHLDahwHh3c4qtdSUBuyrwotAAbOCDcg
         XCwNWA1nuhLmLV5Aqb5A7cWOe6QNdMpFfdyc7sTnUTYvL+b3uuUJWuRNyOmwn++5VyEU
         nXMOTzEBvmubZ28J0dwJaYgEzJr+hwBay2GF597CiOjtp8ysyNxsiGaKRY9WrOSeOxen
         Gg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409286; x=1758014086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RxmiKOX9ZqvhLioBhgvr1KVktvLZ6CG0rToqxQ3c5A=;
        b=G8RGIg/jsRljx96LRFfhf451nImWSOvM1bSAWEIUhnxBcfMh+qtt1vdEzxoA+A7Oty
         ye5KdMJIkKwXDGWhiirSkhlFMrGB5uBpvHmXfYHvQejxfanpKYTz5g4xEAVCWG31dapK
         YSVUjVlNL7JqdQk4c2TNlKYnbvaxifOXuGKmkwDqe54LlQ5LowhLW+jnGmcaBAT4axGn
         TE7mjzBnex5+mmZDvQ+xnOQLmH8acCkFikr9mtZPVQU26zXbZbcGvSZTbFNHqYISs66M
         QYdngq8tOlxvZNq++NNJI3qUYMyqKSdIdiG9PjIJexSoXTZZrIrgEKUYW2p6bwO+3agL
         p89Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRUOQpMYSmr/sg4TXqWWHOO5oKAnb6E17PGLbNRwGirH1PJmIJdaOpNhM7Roa7J3jsjJY9IZA2lYIpsU4=@vger.kernel.org, AJvYcCVVW3hhsFirqYzoDeMmoTxB0G/GWRTHA8w9JxWyFqwVao08K4NufHe/GUoeBxcUjMZG9CfO@vger.kernel.org
X-Gm-Message-State: AOJu0YyRrNLHVE+n+I2rVQxJAP95+aUTGevRUyFo4Safhp7rzJU/YH54
	SbADmTaBgddXcEmknMZ49snmJMCOTmCElXfDN/HmuAO3y4eQgdKridcw
X-Gm-Gg: ASbGncvW91JFnkupGe9JSztU1+EBdAAtPBD+eSxDwYSOs2YLO8xmtEQdOboJjBV/iRK
	IM2ZvUAJ+UAljLRgERVt125od+i0CsQwpq5ZRSKbGl3uOqJcqGxrUqzeLchkrLyQbAZ3EMZMk1x
	Vt0+X5/u8VBR9CfzynYYZy36omc5V2ZK4q68SHK/qm/WLU23W3H2B/KHV3wHqzx+19Ei77oDOdg
	q6AieeDDDdGBIvaBIzO0bhhtqOpa/8E8PANfBjcTtr5VSjm0c568GoComs+jD93l6L+q0Jby4OR
	znYD0oSEk0pCge8Rs2FYFe0uuYa5zBq9gWJkBrNpI/8eJ/AxwJRBUQMOOEs0vWLue/LPoRhAkZt
	dy2Kp65ParAY/yCvz+KEWZ9mb6jy0Vupn2Q8nRrz0kxoCRyJxdKXCXNlQXuQ2
X-Google-Smtp-Source: AGHT+IFf6hq4f3MPnoPFO1ztcKAg+1ws4rmkr3VqrlRe2DP1k8mBc6kVk8q2eX06JVy1oqjj8YH2sQ==
X-Received: by 2002:a05:6512:10d6:b0:568:993c:f047 with SMTP id 2adb3069b0e04-568993cfb7bmr498526e87.42.1757409285803;
        Tue, 09 Sep 2025 02:14:45 -0700 (PDT)
Received: from pc636 (host-95-203-28-174.mobileonline.telia.com. [95.203.28.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56817f72e64sm384445e87.104.2025.09.09.02.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:14:45 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 9 Sep 2025 11:14:43 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v7 04/21] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <aL_wAxNv5ifF2IRD@pc636>
References: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
 <20250903-slub-percpu-caches-v7-4-71c114cdefef@suse.cz>
 <aL7FFpIMmXtzzSL1@pc638.lan>
 <6f8274da-a010-4bb3-b3d6-690481b5ace0@suse.cz>
 <aL_uhPtztx7Ef0T2@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL_uhPtztx7Ef0T2@pc636>

On Tue, Sep 09, 2025 at 11:08:20AM +0200, Uladzislau Rezki wrote:
> On Mon, Sep 08, 2025 at 02:45:11PM +0200, Vlastimil Babka wrote:
> > On 9/8/25 13:59, Uladzislau Rezki wrote:
> > > On Wed, Sep 03, 2025 at 02:59:46PM +0200, Vlastimil Babka wrote:
> > >> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
> > >> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> > >> addition to main and spare sheaves.
> > >> 
> > >> kfree_rcu() operations will try to put objects on this sheaf. Once full,
> > >> the sheaf is detached and submitted to call_rcu() with a handler that
> > >> will try to put it in the barn, or flush to slab pages using bulk free,
> > >> when the barn is full. Then a new empty sheaf must be obtained to put
> > >> more objects there.
> > >> 
> > >> It's possible that no free sheaves are available to use for a new
> > >> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
> > >> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> > >> kfree_rcu() implementation.
> > >> 
> > >> Expected advantages:
> > >> - batching the kfree_rcu() operations, that could eventually replace the
> > >>   existing batching
> > >> - sheaves can be reused for allocations via barn instead of being
> > >>   flushed to slabs, which is more efficient
> > >>   - this includes cases where only some cpus are allowed to process rcu
> > >>     callbacks (Android)
> > >> 
> > >> Possible disadvantage:
> > >> - objects might be waiting for more than their grace period (it is
> > >>   determined by the last object freed into the sheaf), increasing memory
> > >>   usage - but the existing batching does that too.
> > >> 
> > >> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> > >> implementation favors smaller memory footprint over performance.
> > >> 
> > >> Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
> > >> count how many kfree_rcu() used the rcu_free sheaf successfully and how
> > >> many had to fall back to the existing implementation.
> > >> 
> > >> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > >> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > >> ---
> > >>  mm/slab.h        |   2 +
> > >>  mm/slab_common.c |  24 +++++++
> > >>  mm/slub.c        | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >>  3 files changed, 216 insertions(+), 2 deletions(-)
> > >> 
> > >> diff --git a/mm/slab.h b/mm/slab.h
> > >> index 206987ce44a4d053ebe3b5e50784d2dd23822cd1..f1866f2d9b211bb0d7f24644b80ef4b50a7c3d24 100644
> > >> --- a/mm/slab.h
> > >> +++ b/mm/slab.h
> > >> @@ -435,6 +435,8 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
> > >>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
> > >>  }
> > >>  
> > >> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> > >> +
> > >>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
> > >>  			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
> > >>  			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
> > >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> > >> index e2b197e47866c30acdbd1fee4159f262a751c5a7..2d806e02568532a1000fd3912db6978e945dcfa8 100644
> > >> --- a/mm/slab_common.c
> > >> +++ b/mm/slab_common.c
> > >> @@ -1608,6 +1608,27 @@ static void kfree_rcu_work(struct work_struct *work)
> > >>  		kvfree_rcu_list(head);
> > >>  }
> > >>  
> > >> +static bool kfree_rcu_sheaf(void *obj)
> > >> +{
> > >> +	struct kmem_cache *s;
> > >> +	struct folio *folio;
> > >> +	struct slab *slab;
> > >> +
> > >> +	if (is_vmalloc_addr(obj))
> > >> +		return false;
> > >> +
> > >> +	folio = virt_to_folio(obj);
> > >> +	if (unlikely(!folio_test_slab(folio)))
> > >> +		return false;
> > >> +
> > >> +	slab = folio_slab(folio);
> > >> +	s = slab->slab_cache;
> > >> +	if (s->cpu_sheaves)
> > >> +		return __kfree_rcu_sheaf(s, obj);
> > >> +
> > >> +	return false;
> > >> +}
> > >> +
> > >>  static bool
> > >>  need_offload_krc(struct kfree_rcu_cpu *krcp)
> > >>  {
> > >> @@ -1952,6 +1973,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> > >>  	if (!head)
> > >>  		might_sleep();
> > >>  
> > >> +	if (kfree_rcu_sheaf(ptr))
> > >> +		return;
> > >> +
> > > Uh.. I have some concerns about this.
> > > 
> > > This patch introduces a new path which is a collision to the
> > > existing kvfree_rcu() logic. It implements some batching which
> > > we already have.
> > 
> > Yes but for caches with sheaves it's better to recycle the whole sheaf (as
> > described), which is so different from the existing batching scheme that I'm
> > not sure if there's a sensible way to combine them.
> > 
> > > - kvfree_rcu_barrier() does not know about "sheaf" path. Am i missing
> > >   something? How do you guarantee that kvfree_rcu_barrier() flushes
> > >   sheafs? If it is part of kvfree_rcu() it has to care about this.
> > 
> > Hm good point, thanks. I've taken care of handling flushing related to
> > kfree_rcu() sheaves in kmem_cache_destroy(), but forgot that
> > kvfree_rcu_barrier() can be also used outside of that - we have one user in
> > codetag_unload_module() currently.
> > 
> > > - we do not allocate in kvfree_rcu() path because of PREEMMPT_RT, i.e.
> > >   kvfree_rcu() is supposed it can be called from the non-sleeping contexts.
> > 
> > Hm I could not find where that distinction is in the code, can you give a
> > hint please. In __kfree_rcu_sheaf() I do only have a GFP_NOWAIT attempt.
> > 
> For PREEMPT_RT a regular spin-lock is an rt-mutex which can sleep. We
> made kvfree_rcu() to make it possible to invoke it from non-sleep contexts:
> 
> CONFIG_PREEMPT_RT
> 
> preempt_disable() or something similar;
>  kvfree_rcu();
>   GFP_NOWAIT - lock rt-mutex
> 
> If GFP_NOWAIT semantic does not access any spin-locks then we are safe
> or if it uses raw_spin_locks.
> 
And this is valid only for double argument, single argument you can
invoke from sleeping context only, then you can allocate.

--
Uladzislau Rezki
