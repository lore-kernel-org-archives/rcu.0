Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9721B1A3
	for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737720668; cv=none; b=Z4QKjmPD3AQued05M0JG5Lppb+veUU/K/0ZblBYiTzKVLkThcw8UxVJkacr3T0/lN6rEs2Olb9lrN5XgvbExcxfI2YpX27lnH5fKkkCJ0gaEtJVbbfFIttSNgCoNsakAlsZgR6HhIuOma38sl3mdxltywN/BhwuS0HwGJAAgxBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737720668; c=relaxed/simple;
	bh=wa0BpRoNtBGneYJwjqp4gCnPBTpkXVWnRBjcR1M70XI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3Sanvc92t2T9Z2BD+k2DsJ5Igz3caipgE6hDx1+KtZVszLvdSM8WsJ1rfM3UTjJzjAHYY+TOISypRB3HcXpElmfqdV1oIgz7htnVxmA5Uwu2wxdyUxf9ZSipA17S+gtO/FJzVJ/cOXTLmDpsXpQ8vFpk4mxlS3Kh44tShjhHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVnUihPv; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVnUihPv"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30613037309so20217761fa.3
        for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 04:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737720665; x=1738325465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CCFWsVUlTlzlODRazwy3FhP7ZwvGV/2uZu6VlfdPVtE=;
        b=TVnUihPvjBXTLqKV+kkbCIhbd9MM9jdOKyj1+Rsm4NVqCnHfK1dF11MVkf/P4GcUiq
         Rmp/41ZVV8IxdWmk+p5tVD4pyRUBgQO22hxOcT+R5I5jwJoiPEz6dK6OIzjpd2iXq68+
         EYOFbF7DWYALAbQ7knoRORylDVtXKbJvFos/FAhx4ueq24khPNxw2DNzg+rbTIz3Parg
         b3MAOqQ5T0CLnTjBptdIoRHfv+1KDl1AxDmaJT5ToLi6QmdUlTIisvyU1U/Df6XEpbHg
         UBnjcJUd5H1k2IIGwrmGDxqG19qrwyyBpKl9ip8iVgKMtpZLvubIkosQ0QLT+qWztmtw
         /DNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737720665; x=1738325465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCFWsVUlTlzlODRazwy3FhP7ZwvGV/2uZu6VlfdPVtE=;
        b=uiM/iReFn1AKyrRVPY4681VPu1VM4+SJz4qxIpV1Ux4UUBEOLaiZzarxrXLraEcG6h
         4PkrLhjOtglnbGqsomcHK4Dtkv4pr3nGpprttJxwXJeotRb4EtYFLWCtF8C3vHMsOR5e
         C85+o+8hhqxJ9ygc3/eFnhS/Gdoy72xsBHh6ZybSXUMypqSOjGEwQVG3AQA1MgdAEjwa
         je/f5F3LNPZ+F5aXXRxpAKAYEfAQ0r4hYsPjDyjVkuojM30SJP21pw8XLD9Rd6meersP
         akBCBhSm4Fy+v3Q6JH0hq+gn5m02Bnn/VEu9//qiO0e4KhaO2R3+atgnxpWGNWF5cYHV
         1T5A==
X-Forwarded-Encrypted: i=1; AJvYcCUE9JtBQdNHJSJXSLXfHLfozIlxD5cwLzMbZc2A+k9+XguTosfn+DfqDSeI9d1hBrB/2Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxglykfqoq53DSv+KlDF65c64BPs+QvJCiXc2pHk0MgPilDMdqR
	xH5GWooqirU57P2oPlJ1GS7b8OIO8u6kiIeZQQ4t45BQteC49Hq5
X-Gm-Gg: ASbGnctiULufJaKZNLjemo+KV7HqbGFGsiW1EMsLRP82dE3fOMDaCKZWCPlX7KhvBfA
	8XLxxFETOeAx6/jm61mhBvjG69BS52Mx4Wv1dAGUSmUQW8se0AtGvI0CLDLETV+bokw+JeaUTvR
	v41yZgfS6nasAI1YplmFDo28sxEgoIwUDGquLlG/CdYZevKQ6gc05w0BEzhbQ5FBYXlxmRQCyxr
	X0VGWVdhVYdvXkQGr9NJpTPh+T1ERgmNzJpnAt6l95G9SP8eA8qK0v3xLRUBNsTu4nWWSjUsTVm
	6vfY4TdiFf+9HyZZdjZgOdKAYn3DkSN4Ndc=
X-Google-Smtp-Source: AGHT+IH20V+H9mL+BtrdGoQx/Z+iCvWoXKL/MKk3o1LRlvkK6XuwLhntzsnscxycRabVdx8Z6pXUbg==
X-Received: by 2002:a05:6512:aca:b0:53e:37e4:1457 with SMTP id 2adb3069b0e04-5439c280723mr11508144e87.33.1737720664827;
        Fri, 24 Jan 2025 04:11:04 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c836848bsm271613e87.126.2025.01.24.04.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:11:04 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 24 Jan 2025 13:11:01 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] slab: don't batch kvfree_rcu() with SLUB_TINY
Message-ID: <Z5ODVa3osRqNFlX6@pc636>
References: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>
 <20250123-slub-tiny-kfree_rcu-v1-4-0e386ef1541a@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123-slub-tiny-kfree_rcu-v1-4-0e386ef1541a@suse.cz>

On Thu, Jan 23, 2025 at 11:37:21AM +0100, Vlastimil Babka wrote:
> kvfree_rcu() is batched for better performance except on TINY_RCU, which
> is a simple implementation for small UP systems. Similarly SLUB_TINY is
> an option intended for small systems, whether or not used together with
> TINY_RCU. In case SLUB_TINY is used with !TINY_RCU, it makes arguably
> sense to not do the batching and limit the memory footprint. It's also
> suboptimal to have RCU-specific #ifdefs in slab code.
> 
> With that, add CONFIG_KFREE_RCU_BATCHED to determine whether batching
> kvfree_rcu() implementation is used. It is not set by a user prompt, but
> enabled by default and disabled in case TINY_RCU or SLUB_TINY are
> enabled.
> 
> Use the new config for #ifdef's in slab code and extend their scope to
> cover all code used by the batched kvfree_rcu(). For example there's no
> need to perform kvfree_rcu_init() if the batching is disabled.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h |  2 +-
>  mm/Kconfig           |  4 ++++
>  mm/slab_common.c     | 45 +++++++++++++++++++++++++--------------------
>  3 files changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index bcc62e5656c35c6a3f4caf26fb33d7447dead39a..9faf33734a8eee2425b90e679c0457ab459422a3 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -1083,7 +1083,7 @@ extern void kvfree_sensitive(const void *addr, size_t len);
>  
>  unsigned int kmem_cache_size(struct kmem_cache *s);
>  
> -#ifdef CONFIG_TINY_RCU
> +#ifndef CONFIG_KFREE_RCU_BATCHED
>  static inline void kvfree_rcu_barrier(void)
>  {
>  	rcu_barrier();
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 84000b01680869801a10f56f06d0c43d6521a8d2..e513308a4aed640ee556ecb5793c7f3f195bbcae 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -242,6 +242,10 @@ menu "Slab allocator options"
>  config SLUB
>  	def_bool y
>  
> +config KFREE_RCU_BATCHED
> +	def_bool y
> +	depends on !SLUB_TINY && !TINY_RCU
> +
>  config SLUB_TINY
>  	bool "Configure for minimal memory footprint"
>  	depends on EXPERT
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f13d2c901daf1419993620459fbd5845eecb85f1..9f6d66313afc6684bdc0f32908fe01c83c60f283 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1284,6 +1284,28 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
>  EXPORT_TRACEPOINT_SYMBOL(kfree);
>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
>  
> +#ifndef CONFIG_KFREE_RCU_BATCHED
> +
> +void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> +{
> +	if (head) {
> +		kasan_record_aux_stack_noalloc(ptr);
> +		call_rcu(head, kvfree_rcu_cb);
> +		return;
> +	}
> +
> +	// kvfree_rcu(one_arg) call.
> +	might_sleep();
> +	synchronize_rcu();
> +	kvfree(ptr);
> +}
> +
> +void __init kvfree_rcu_init(void)
> +{
> +}
> +
> +#else /* CONFIG_KFREE_RCU_BATCHED */
> +
>  /*
>   * This rcu parameter is runtime-read-only. It reflects
>   * a minimum allowed number of objects which can be cached
> @@ -1858,24 +1880,6 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  	return true;
>  }
>  
> -#ifdef CONFIG_TINY_RCU
> -
> -void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> -{
> -	if (head) {
> -		kasan_record_aux_stack_noalloc(ptr);
> -		call_rcu(head, kvfree_rcu_cb);
> -		return;
> -	}
> -
> -	// kvfree_rcu(one_arg) call.
> -	might_sleep();
> -	synchronize_rcu();
> -	kvfree(ptr);
> -}
> -
> -#else /* !CONFIG_TINY_RCU */
> -
>  static enum hrtimer_restart
>  schedule_page_work_fn(struct hrtimer *t)
>  {
> @@ -2084,8 +2088,6 @@ void kvfree_rcu_barrier(void)
>  }
>  EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>  
> -#endif /* !CONFIG_TINY_RCU */
> -
>  static unsigned long
>  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  {
> @@ -2175,3 +2177,6 @@ void __init kvfree_rcu_init(void)
>  
>  	shrinker_register(kfree_rcu_shrinker);
>  }
> +
> +#endif /* CONFIG_KFREE_RCU_BATCHED */
> +
> 
> -- 
> 2.48.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

A small nit: CONFIG_KVFREE_RCU_BATCHED?

--
Uladzislau Rezki
