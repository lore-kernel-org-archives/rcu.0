Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FFF126C03;
	Thu, 14 Nov 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603471; cv=none; b=XHoNUk4KTxlfEx+9RKSvyqy5Ba6V67nlDRbWQ/m9u9fJo23pGPc0fEJkpXXGtJLkHQOh1NY3iD7A5cjj+31gHAenwpbLyVB0smswV4udsPapY70PrJGxfUMEs5c5KesITiEKr74ud1LNl4QVyNFWs1FfZ9nY+wdzV6wdsS6cLXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603471; c=relaxed/simple;
	bh=wj1oFk9KGavjsrDS+FpIbkVK4MwqL9xKf904n7vFnwM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7WyMSQYnxHxnTQm86aTYoKhqehCOofqJRPbxfnmN1THBeuU8fLX0z8BBN4hpygqmDEVCVccgioDHH7wHQZu+fTihJjWcY07Ly11YnfMsIxawhTiIbhViIEMuLQt5TH6AFKP1pzyhnzMKwHSaRoOhouct2VM81VzrV2bV5qMxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1z0VYWy; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1z0VYWy"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so959014e87.2;
        Thu, 14 Nov 2024 08:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731603467; x=1732208267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3E8KoyGXHwNoJ3biinuum5PL8wDFoLA6D0OgiN4eob8=;
        b=K1z0VYWyNlluKNqV6j/BLUM9jKCoX69jUpaocB2IcQn57+RVqCPAn4/4iPSSZI6I+y
         dSsrap7GHVkEbvLZkQ1/8qdopIKpf8aatj21PbgASgqtq+WuYAQXgo22/squqst3BEeW
         F0CZ8FeyH0JZruqNV/K3FStonIBlzrjDUm7j7L0v8zGmMuvtZe7AEnLS4r+F+jTlloJ5
         d/8krSM81IoVWUo9HYx5CmGZkEB7pmoWIgOlQfzICz4C7LCG80RMoQHcrZnBlM9rccsw
         yf9DBVoOIi08GKWBAriDXNXvhhUeeiMbPs5WBUtmL5KtG86gwBb2QxZVo7TZrjdhpvUJ
         T6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731603467; x=1732208267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3E8KoyGXHwNoJ3biinuum5PL8wDFoLA6D0OgiN4eob8=;
        b=OTf5kJdHnbnQ8EjkU58Qg9Bm2SGm/aNBrxh1duurXZmA+I50jP5x8y4GqecaRF5u7Z
         QEc6eCNxGBDSwLfw5RA4Z7AEF67FI6n0+XO3U/TxtRJ87vZ3rL1gPmf0dQlV0TgV5Cez
         3TV2JVhSyEik2VI2rPVo0o2AHCHbEE7gSVv4EmYyetBeCSlyTkwSdSFvPFjkxiS9e4lq
         klGQlR8lNNsotI9+N9D4Wa7z5N34EMLrMhLCDz9bAXptnMln8HbjDDd3Ofmj2wEA1umk
         7AQULxTkryCDRBAS1DYVdOPaV/UuF4CSfLBBNfFKQVpcPGVrnkWFtLCnUH/kOfdEt7jR
         OXOw==
X-Forwarded-Encrypted: i=1; AJvYcCVWaqh0iDa8rskonAxmGY3pX0UFl9zxJCDZKI6ntOZD1F6JEsO+Uy7Kc0uYGCTOpZtEtU4F2g+sawP9ukU=@vger.kernel.org, AJvYcCXq/ht+cv42ry/cwOAz/YLDM6dM11UdWgSjR9fYLyDQKJm56Av5BYLOANhr0LjmYLp2aoU7@vger.kernel.org
X-Gm-Message-State: AOJu0YwIp2JANRn9XsF7siuJZ7I+ugJGflOoU8M3TwY2k7jUbYy8NkoS
	K87r/2vjSU3RheZak/nMhuB46Z4ZzecGhWCTH8g4zCyq4iupX951
X-Google-Smtp-Source: AGHT+IERlzVRllFSvMo2kIMW15bEw0UKyUPG8/FpBsB+MFpT1AAY9B81Xgd6tQkLcA12hc2IPAH/oQ==
X-Received: by 2002:a05:6512:3043:b0:53d:a321:db74 with SMTP id 2adb3069b0e04-53da5c7b50dmr1568868e87.50.1731603467118;
        Thu, 14 Nov 2024 08:57:47 -0800 (PST)
Received: from pc636 (host-95-203-27-13.mobileonline.telia.com. [95.203.27.13])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da64f29f0sm246264e87.39.2024.11.14.08.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:57:45 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 14 Nov 2024 17:57:42 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC 2/6] mm/slub: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <ZzYsBu_rJWSAcAYf@pc636>
References: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
 <20241112-slub-percpu-caches-v1-2-ddc0bdc27e05@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-slub-percpu-caches-v1-2-ddc0bdc27e05@suse.cz>

On Tue, Nov 12, 2024 at 05:38:46PM +0100, Vlastimil Babka wrote:
> Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
> For caches where sheafs are initialized, on each cpu maintain a rcu_free
> sheaf in addition to main and spare sheaves.
> 
> kfree_rcu() operations will try to put objects on this sheaf. Once full,
> the sheaf is detached and submitted to call_rcu() with a handler that
> will try to put in on the barn, or flush to slab pages using bulk free,
> when the barn is full. Then a new empty sheaf must be obtained to put
> more objects there.
> 
> It's possible that no free sheafs are available to use for a new
> rcu_free sheaf, and the allocation in kfree_rcu() context can only use
> GFP_NOWAIT and thus may fail. In that case, fall back to the existing
> kfree_rcu() machinery.
> 
> Because some intended users will need to perform additonal cleanups
> after the grace period and thus have custom rcu_call() callbacks today,
> add the possibility to specify a kfree_rcu() specific destructor.
> Because of the fall back possibility, the destructor now needs be
> invoked also from within RCU, so add __kvfree_rcu() that RCU can use
> instead of kvfree().
> 
> Expected advantages:
> - batching the kfree_rcu() operations, that could eventually replace the
>   batching done in RCU itself
> - sheafs can be reused via barn instead of being flushed to slabs, which
>   is more effective
>   - this includes cases where only some cpus are allowed to process rcu
>     callbacks (Android)
> 
> Possible disadvantage:
> - objects might be waiting for more than their grace period (it is
>   determined by the last object freed into the sheaf), increasing memory
>   usage - but that might be true for the batching done by RCU as well?
> 
> RFC LIMITATIONS: - only tree rcu is converted, not tiny
> - the rcu fallback might resort to kfree_bulk(), not kvfree(). Instead
>   of adding a variant of kfree_bulk() with destructors, is there an easy
>   way to disable the kfree_bulk() path in the fallback case?
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h |  15 +++++
>  kernel/rcu/tree.c    |   8 ++-
>  mm/slab.h            |  25 +++++++
>  mm/slab_common.c     |   3 +
>  mm/slub.c            | 182 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 227 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index b13fb1c1f03c14a5b45bc6a64a2096883aef9f83..23904321992ad2eeb9389d0883cf4d5d5d71d896 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -343,6 +343,21 @@ struct kmem_cache_args {
>  	 * %0 means no sheaves will be created
>  	 */
>  	unsigned int sheaf_capacity;
> +	/**
> +	 * @sheaf_rcu_dtor: A destructor for objects freed by kfree_rcu()
> +	 *
> +	 * Only valid when non-zero @sheaf_capacity is specified. When freeing
> +	 * objects by kfree_rcu() in a cache with sheaves, the objects are put
> +	 * to a special percpu sheaf. When that sheaf is full, it's passed to
> +	 * call_rcu() and after a grace period the sheaf can be reused for new
> +	 * allocations. In case a cleanup is necessary after the grace period
> +	 * and before reusal, a pointer to such function can be given as
> +	 * @sheaf_rcu_dtor and will be called on each object in the rcu sheaf
> +	 * after the grace period passes and before the sheaf's reuse.
> +	 *
> +	 * %NULL means no destructor is called.
> +	 */
> +	void (*sheaf_rcu_dtor)(void *obj);
>  };
>  
>  struct kmem_cache *__kmem_cache_create_args(const char *name,
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b1f883fcd9185a5e22c10102d1024c40688f57fb..42c994fdf9960bfed8d8bd697de90af72c1f4f58 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -65,6 +65,7 @@
>  #include <linux/kasan.h>
>  #include <linux/context_tracking.h>
>  #include "../time/tick-internal.h"
> +#include "../../mm/slab.h"
>  
>  #include "tree.h"
>  #include "rcu.h"
> @@ -3420,7 +3421,7 @@ kvfree_rcu_list(struct rcu_head *head)
>  		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
>  
>  		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
> -			kvfree(ptr);
> +			__kvfree_rcu(ptr);
>  
>  		rcu_lock_release(&rcu_callback_map);
>  		cond_resched_tasks_rcu_qs();
> @@ -3797,6 +3798,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	if (!head)
>  		might_sleep();
>  
> +	if (kfree_rcu_sheaf(ptr))
> +		return;
> +
>
This change crosses all effort which has been done in order to improve kvfree_rcu :)

For example:
  performance, app launch improvements for Android devices;
  memory consumption optimizations to minimize LMK triggering;
  batching to speed-up offloading;
  etc.

So we have done a lot of work there. We were thinking about moving all
functionality from "kernel/rcu" to "mm/". As a first step i can do that,
i.e. move kvfree_rcu() as is. After that we can switch to second step.

Sounds good for you or not?

--
Uladzislau Rezki
