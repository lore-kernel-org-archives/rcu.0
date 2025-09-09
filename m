Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D1275B1C;
	Tue,  9 Sep 2025 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408907; cv=none; b=P0H6EUXmyFLcu6SqX0p9TJpSAkNSsODkWUH00tRgnJwlcE3nv0Div36w7V1oUYqPDOhQvpCsmqm9OrnI2JMYhvH3Fqt3Jmqb6+mwLv3qvCq5inHDPo1VZPppS2lohryjBnYBcdgqsBSb9iHq4xUcBe3t7ZGi+zE2ZVAzNMVb9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408907; c=relaxed/simple;
	bh=XzFNPRuR50tjfJ2GSCD7tgo/xB72FBuDGkn1WlX5hWs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH9qG4ykGarpMK/ez/s3aR6va5pTOWlhur3Fo9TFKMfepvlN/TJnWznYwfJ4juNvpQqPrORQO58iUs65VxtYfRkSzxg3XjTwZSzDKJNkYZ6Hf3wgyBI+QnaRf5VdJLZhKomMpAi0CBrC+8wTDhhtro4THmxRVXbwkUUiNqZxjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iikrhaVG; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iikrhaVG"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f68d7a98aso6312816e87.3;
        Tue, 09 Sep 2025 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408903; x=1758013703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m15/6HK6IXoWcPOIkEnGT9WR5ix6JXTW5qiMEnkeKfY=;
        b=iikrhaVGTgeKPAnY0HRagkWadiTd71GQB+6dFYJeYTXltNy/KC6P3uFNioSvMGIIAH
         JlCpvJNuiGwE0Ziy4MCYVMwoMq6xRj2/UVmfWUSbfJKXBuYpKTJdHCR1DYVFSlVM1Ru4
         yPyyOarCm6vGjkJly51Slb/fc5tv4usW7NBpcBKQuRa62mQkJOsZcZ06B5Von+q9+Fi2
         /j6g6CRlwmutZo2YJ2m/Beg9uTwLHg95ETDNasRBgwUDkc+48l91E6m/zeRTKby3PfDT
         kiM6yLu7dl12xvpWljv6ZYA1kyAVZah14OgUeUGJeyT28/b6uBAO/uy5Ke7qvzpdym49
         q1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408903; x=1758013703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m15/6HK6IXoWcPOIkEnGT9WR5ix6JXTW5qiMEnkeKfY=;
        b=eWvj6oJzlEw7gfc+gHBj1douPjt/NzwFh/wWN9M9e4gOxYXw73MFJh3Wu0E7pzBEDH
         IHv2RcPWsZ/91QOMCW+TI4rvq2H5jID6Tbv40D/SJ53E/X66t7AaSVxXXUk8qJ3gbjeb
         o2YuHxP4GM9ChfE6/lqW/trMIClJ2Ei6l+cXhuiz+hDLu0/ePngvCpEAF3H4ZGe0SNPZ
         lduBg69qvW6cuWv2IGjo8SQtOMSwfV5qQJ4dc2X3JQPGAyYNiayt++XbrrD4wrNRizId
         0/B0puNCLFqOzG53nZJEkR9/q8DwcmW3jGXjK6bH4nwYlGIPfDqRUtUZWwcxWK48B8lx
         bqgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxC6Qq8jWjopr+gcATtNv6rgfpbPij+45KfZJx4G0rHa8r8FAmqHcvB7rbxjJuUi0oRqEn@vger.kernel.org, AJvYcCVcCC/fqzNkp3RGPAr8/bISD4gZzshICoNDRCkZjVmBs1x+JVjORUllXPEdD4kdyx1qgMwetwUOGk15u+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvd9w7vCbmwexrkBztzGGyfJVzsYaDXJ/Q2mNZdItoH1PTjrW/
	o7e683n2C2i748Qc5A7qKyqEkPwIam48csx6t9iahbTBqca2hm5usCd5
X-Gm-Gg: ASbGncv8FWzc13aC/PNXAi1UlL59gVwxnmlEB9BkGaukjEEyNKezTVw0OG45JgD0dqB
	WYcewX61zOl3Zh4/zrgYovgI9dHAv6ipYja8K94sgMiRncaPaWz7PtaiTAZ55TaZnN+8F96cCmb
	NrNnKupxq5JTlf++qbeKmPK9RKQ7NZi+c1UAeAdby+OvhFRV4H33/uPXQJIBzUNDT43QAeMsQwl
	/WWP0iVjeqYwidpI7bdMBzeSzsWfRD/lva/fYjOql+O/Wt92PfnKGGzrXosOHSgmxR/4y+wBHei
	MiDcrFXz2i3q7Ft+5rDOFHaqIzhz77Vo62Zt/DiRvH//m/zapMcsyOn2BrsxSWrU+1Jqf3Khej/
	axtJlgUsSbmC0v52Kr/jW33lQFp+itZdHGvfp2r3oizeVJ6q3fVWTzPLvoeHqFkmIW43lNuw=
X-Google-Smtp-Source: AGHT+IEnyV5ZBqivGAbEdD2OGowTdG9/z5D2YczrchhVQjLP1DvK2+GKpP7bXLYhTGA7oyfnNfxlPw==
X-Received: by 2002:a05:6512:63c5:20b0:563:3ac3:1ec1 with SMTP id 2adb3069b0e04-5633ac31f71mr2335880e87.54.1757408902875;
        Tue, 09 Sep 2025 02:08:22 -0700 (PDT)
Received: from pc636 (host-95-203-28-174.mobileonline.telia.com. [95.203.28.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c4246f2sm390317e87.26.2025.09.09.02.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:08:22 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 9 Sep 2025 11:08:20 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <aL_uhPtztx7Ef0T2@pc636>
References: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
 <20250903-slub-percpu-caches-v7-4-71c114cdefef@suse.cz>
 <aL7FFpIMmXtzzSL1@pc638.lan>
 <6f8274da-a010-4bb3-b3d6-690481b5ace0@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f8274da-a010-4bb3-b3d6-690481b5ace0@suse.cz>

On Mon, Sep 08, 2025 at 02:45:11PM +0200, Vlastimil Babka wrote:
> On 9/8/25 13:59, Uladzislau Rezki wrote:
> > On Wed, Sep 03, 2025 at 02:59:46PM +0200, Vlastimil Babka wrote:
> >> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
> >> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> >> addition to main and spare sheaves.
> >> 
> >> kfree_rcu() operations will try to put objects on this sheaf. Once full,
> >> the sheaf is detached and submitted to call_rcu() with a handler that
> >> will try to put it in the barn, or flush to slab pages using bulk free,
> >> when the barn is full. Then a new empty sheaf must be obtained to put
> >> more objects there.
> >> 
> >> It's possible that no free sheaves are available to use for a new
> >> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
> >> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> >> kfree_rcu() implementation.
> >> 
> >> Expected advantages:
> >> - batching the kfree_rcu() operations, that could eventually replace the
> >>   existing batching
> >> - sheaves can be reused for allocations via barn instead of being
> >>   flushed to slabs, which is more efficient
> >>   - this includes cases where only some cpus are allowed to process rcu
> >>     callbacks (Android)
> >> 
> >> Possible disadvantage:
> >> - objects might be waiting for more than their grace period (it is
> >>   determined by the last object freed into the sheaf), increasing memory
> >>   usage - but the existing batching does that too.
> >> 
> >> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> >> implementation favors smaller memory footprint over performance.
> >> 
> >> Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
> >> count how many kfree_rcu() used the rcu_free sheaf successfully and how
> >> many had to fall back to the existing implementation.
> >> 
> >> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> >> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/slab.h        |   2 +
> >>  mm/slab_common.c |  24 +++++++
> >>  mm/slub.c        | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  3 files changed, 216 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/mm/slab.h b/mm/slab.h
> >> index 206987ce44a4d053ebe3b5e50784d2dd23822cd1..f1866f2d9b211bb0d7f24644b80ef4b50a7c3d24 100644
> >> --- a/mm/slab.h
> >> +++ b/mm/slab.h
> >> @@ -435,6 +435,8 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
> >>  	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
> >>  }
> >>  
> >> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> >> +
> >>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
> >>  			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
> >>  			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index e2b197e47866c30acdbd1fee4159f262a751c5a7..2d806e02568532a1000fd3912db6978e945dcfa8 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -1608,6 +1608,27 @@ static void kfree_rcu_work(struct work_struct *work)
> >>  		kvfree_rcu_list(head);
> >>  }
> >>  
> >> +static bool kfree_rcu_sheaf(void *obj)
> >> +{
> >> +	struct kmem_cache *s;
> >> +	struct folio *folio;
> >> +	struct slab *slab;
> >> +
> >> +	if (is_vmalloc_addr(obj))
> >> +		return false;
> >> +
> >> +	folio = virt_to_folio(obj);
> >> +	if (unlikely(!folio_test_slab(folio)))
> >> +		return false;
> >> +
> >> +	slab = folio_slab(folio);
> >> +	s = slab->slab_cache;
> >> +	if (s->cpu_sheaves)
> >> +		return __kfree_rcu_sheaf(s, obj);
> >> +
> >> +	return false;
> >> +}
> >> +
> >>  static bool
> >>  need_offload_krc(struct kfree_rcu_cpu *krcp)
> >>  {
> >> @@ -1952,6 +1973,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> >>  	if (!head)
> >>  		might_sleep();
> >>  
> >> +	if (kfree_rcu_sheaf(ptr))
> >> +		return;
> >> +
> > Uh.. I have some concerns about this.
> > 
> > This patch introduces a new path which is a collision to the
> > existing kvfree_rcu() logic. It implements some batching which
> > we already have.
> 
> Yes but for caches with sheaves it's better to recycle the whole sheaf (as
> described), which is so different from the existing batching scheme that I'm
> not sure if there's a sensible way to combine them.
> 
> > - kvfree_rcu_barrier() does not know about "sheaf" path. Am i missing
> >   something? How do you guarantee that kvfree_rcu_barrier() flushes
> >   sheafs? If it is part of kvfree_rcu() it has to care about this.
> 
> Hm good point, thanks. I've taken care of handling flushing related to
> kfree_rcu() sheaves in kmem_cache_destroy(), but forgot that
> kvfree_rcu_barrier() can be also used outside of that - we have one user in
> codetag_unload_module() currently.
> 
> > - we do not allocate in kvfree_rcu() path because of PREEMMPT_RT, i.e.
> >   kvfree_rcu() is supposed it can be called from the non-sleeping contexts.
> 
> Hm I could not find where that distinction is in the code, can you give a
> hint please. In __kfree_rcu_sheaf() I do only have a GFP_NOWAIT attempt.
> 
For PREEMPT_RT a regular spin-lock is an rt-mutex which can sleep. We
made kvfree_rcu() to make it possible to invoke it from non-sleep contexts:

CONFIG_PREEMPT_RT

preempt_disable() or something similar;
 kvfree_rcu();
  GFP_NOWAIT - lock rt-mutex

If GFP_NOWAIT semantic does not access any spin-locks then we are safe
or if it uses raw_spin_locks.

> > - call_rcu() can be slow, therefore we do not use it in the kvfree_rcu().
> 
> If call_rcu() is called once per 32 kfree_rcu() filling up the rcu sheaf, is
> it still too slow?
>
You do not know where in a queue this callback lands, in the beginning,
in the end, etc. It is part of generic list which is processed one by
one. It can contain thousands of callbacks.

If performance is not needed then it is not an issue. But in
kvfree_rcu() we do not use it, because of we want to offload
fast.

--
Uladzislau Rezki
