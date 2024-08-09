Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908221870;
	Fri,  9 Aug 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220806; cv=none; b=BkruhaAIRNT8LYRa12CB6OeN86ZKt1srAFUeyxYmXaMb+IfGCswVbSTryDzvv3/2+JKrYco2rXvYRpoLak2hNIeecYPqKsbW1wc4Oz0iepiBu6YJ+4GNeFW0flK5ELV1kVINWZCB/zVbOrE+P8UqS7KdTCri7iiV6HeptMT/0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220806; c=relaxed/simple;
	bh=AaNlEszEaeLcL217zCzVxN0zEN2kVBXz/z6HnHGoi80=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1+ayGukMqXDPVJ60Xk4Tls4bXJIx0qtyKlkQ/9HAh7GTH7NT+VqRQowjphgQnJG9QDcDCV/9GZBIadpbv6rwnLiMA4B0QuN6OgzaawosBgKao65KreJuhy5HogVhzQPcjz5uB7OJ0MZm/X4SdcltPpCt6zZUmWGBbN4YlZFOfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJHDNjNo; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJHDNjNo"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f0271b0ae9so22825321fa.1;
        Fri, 09 Aug 2024 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723220802; x=1723825602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8GhuZXBHrLQFERoBhWAzGEBHzpGEHA+J+lL0pNJNCos=;
        b=LJHDNjNohMBn5PDrOj2KFiMyyiGSf0oLhJ5eelXyXh6FIXzsAYG5+nRANYvEn7uH0c
         CL9+4koH82PQx3/Dvh5MHxd6gPgfkpwo17lF4PAU/GMxZTrA3u097BuUQSFretTJ784k
         saAUMT/y9Rm8ccqHCvtWgzo8HtsavjmE+WlfLgmm2Pf7baVl9O1DVWkclKmb6R/P+9Wr
         eFCUi2PB9E/8PL5b8ZKbZcxguiI74I430PwUwNdp8L/cjjzzD6FWyhTP1DS+vQhqlGsh
         cJtQ+xQ//5XZxMfqHFLqGfWKPt2eatDcArsr0cWD8XkJsrGP0ojDv142QdmKtcVIUTD3
         GoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723220802; x=1723825602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GhuZXBHrLQFERoBhWAzGEBHzpGEHA+J+lL0pNJNCos=;
        b=jeXc5gat1YlSCFOMyFLRdJQnOlTsnti4vO2g0ccsnWOU+yf8amYTVoJ80diYEq391t
         O/k9jLMjfc4XeAeNa7pgWp0Q9DkKVQuep1z/ln+a2BpTxAz0oW2zoNb5/QaX6ShUPNaz
         rsixfFXJq7KnHFY70C5qwkdVknfRxzx+lfTINdbZMvJHpiC19TRmnSyE0VBIRmZiidml
         55wDla1op+amOg2p7zZ0uvN9jaI0MpbKE0HJwtM1uFtLi0r5jwm7pW1wOOro4pW4iwZl
         gohpQdUhww+Vg1zB0b/NCflBxgBVL63o7bST097WJ2eOGFYYq9TgwsDM09KR53wLII0A
         baFA==
X-Forwarded-Encrypted: i=1; AJvYcCVdRok810ovNlj7ajEL+Xxj1qvHVCzm5k1XS7Lh2A7csK0TX+Yk1gmkLj5J7yUExOSdsRjQSKcbJ5b+FNyrtE4gnwuSGG9euueHFMnWkOL2esOmOhYIp/aCquUxgIokgtVQ
X-Gm-Message-State: AOJu0YyUjErxTuERG9Vn6NtIa4GReHexma67JPlKcVwkqWr9RDR03+lI
	Of6oJbYXHBMhh0ZB6HnybylhQfq2w+ME3/SKRrZ/HN10QkyozYfx
X-Google-Smtp-Source: AGHT+IHIcKoF3Ie/2OsybzOIBFmvl+sf2xsm7hrxBYfGa1D+ay/Ymjy0D/SiESw+BOi2PbJsSYyuEw==
X-Received: by 2002:a2e:a581:0:b0:2ec:500c:b2e0 with SMTP id 38308e7fff4ca-2f1a6d1d1e9mr19917041fa.22.1723220801209;
        Fri, 09 Aug 2024 09:26:41 -0700 (PDT)
Received: from pc636 (host-90-233-216-8.mobileonline.telia.com. [90.233.216.8])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e26038bsm25892501fa.117.2024.08.09.09.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:26:40 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 9 Aug 2024 18:26:36 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2 5/7] rcu/kvfree: Add kvfree_rcu_barrier() API
Message-ID: <ZrZDPLN9CRvRrbMy@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-5-ea79102f428c@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-5-ea79102f428c@suse.cz>

Hello, Vlastimil!

> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> 
> Add a kvfree_rcu_barrier() function. It waits until all
> in-flight pointers are freed over RCU machinery. It does
> not wait any GP completion and it is within its right to
> return immediately if there are no outstanding pointers.
> 
> This function is useful when there is a need to guarantee
> that a memory is fully freed before destroying memory caches.
> For example, during unloading a kernel module.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/rcutiny.h |   5 +++
>  include/linux/rcutree.h |   1 +
>  kernel/rcu/tree.c       | 103 ++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 101 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index d9ac7b136aea..522123050ff8 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -111,6 +111,11 @@ static inline void __kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	kvfree(ptr);
>  }
>  
> +static inline void kvfree_rcu_barrier(void)
> +{
> +	rcu_barrier();
> +}
> +
>  #ifdef CONFIG_KASAN_GENERIC
>  void kvfree_call_rcu(struct rcu_head *head, void *ptr);
>  #else
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 254244202ea9..58e7db80f3a8 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -35,6 +35,7 @@ static inline void rcu_virt_note_context_switch(void)
>  
>  void synchronize_rcu_expedited(void);
>  void kvfree_call_rcu(struct rcu_head *head, void *ptr);
> +void kvfree_rcu_barrier(void);
>  
>  void rcu_barrier(void);
>  void rcu_momentary_dyntick_idle(void);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e641cc681901..ebcfed9b570e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3584,18 +3584,15 @@ kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
>  }
>  
>  /*
> - * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
> + * Return: %true if a work is queued, %false otherwise.
>   */
> -static void kfree_rcu_monitor(struct work_struct *work)
> +static bool
> +kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
>  {
> -	struct kfree_rcu_cpu *krcp = container_of(work,
> -		struct kfree_rcu_cpu, monitor_work.work);
>  	unsigned long flags;
> +	bool queued = false;
>  	int i, j;
>  
> -	// Drain ready for reclaim.
> -	kvfree_rcu_drain_ready(krcp);
> -
>  	raw_spin_lock_irqsave(&krcp->lock, flags);
>  
>  	// Attempt to start a new batch.
> @@ -3634,11 +3631,27 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			// be that the work is in the pending state when
>  			// channels have been detached following by each
>  			// other.
> -			queue_rcu_work(system_wq, &krwp->rcu_work);
> +			queued = queue_rcu_work(system_wq, &krwp->rcu_work);
>  		}
>  	}
>  
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +	return queued;
> +}
> +
> +/*
> + * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
> + */
> +static void kfree_rcu_monitor(struct work_struct *work)
> +{
> +	struct kfree_rcu_cpu *krcp = container_of(work,
> +		struct kfree_rcu_cpu, monitor_work.work);
> +
> +	// Drain ready for reclaim.
> +	kvfree_rcu_drain_ready(krcp);
> +
> +	// Queue a batch for a rest.
> +	kvfree_rcu_queue_batch(krcp);
>  
>  	// If there is nothing to detach, it means that our job is
>  	// successfully done here. In case of having at least one
> @@ -3859,6 +3872,80 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
>  
> +/**
> + * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
> + *
> + * Note that a single argument of kvfree_rcu() call has a slow path that
> + * triggers synchronize_rcu() following by freeing a pointer. It is done
> + * before the return from the function. Therefore for any single-argument
> + * call that will result in a kfree() to a cache that is to be destroyed
> + * during module exit, it is developer's responsibility to ensure that all
> + * such calls have returned before the call to kmem_cache_destroy().
> + */
> +void kvfree_rcu_barrier(void)
> +{
> +	struct kfree_rcu_cpu_work *krwp;
> +	struct kfree_rcu_cpu *krcp;
> +	bool queued;
> +	int i, cpu;
> +
> +	/*
> +	 * Firstly we detach objects and queue them over an RCU-batch
> +	 * for all CPUs. Finally queued works are flushed for each CPU.
> +	 *
> +	 * Please note. If there are outstanding batches for a particular
> +	 * CPU, those have to be finished first following by queuing a new.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		krcp = per_cpu_ptr(&krc, cpu);
> +
> +		/*
> +		 * Check if this CPU has any objects which have been queued for a
> +		 * new GP completion. If not(means nothing to detach), we are done
> +		 * with it. If any batch is pending/running for this "krcp", below
> +		 * per-cpu flush_rcu_work() waits its completion(see last step).
> +		 */
> +		if (!need_offload_krc(krcp))
> +			continue;
> +
> +		while (1) {
> +			/*
> +			 * If we are not able to queue a new RCU work it means:
> +			 * - batches for this CPU are still in flight which should
> +			 *   be flushed first and then repeat;
> +			 * - no objects to detach, because of concurrency.
> +			 */
> +			queued = kvfree_rcu_queue_batch(krcp);
> +
> +			/*
> +			 * Bail out, if there is no need to offload this "krcp"
> +			 * anymore. As noted earlier it can run concurrently.
> +			 */
> +			if (queued || !need_offload_krc(krcp))
> +				break;
> +
> +			/* There are ongoing batches. */
> +			for (i = 0; i < KFREE_N_BATCHES; i++) {
> +				krwp = &(krcp->krw_arr[i]);
> +				flush_rcu_work(&krwp->rcu_work);
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * Now we guarantee that all objects are flushed.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		krcp = per_cpu_ptr(&krc, cpu);
> +
> +		for (i = 0; i < KFREE_N_BATCHES; i++) {
> +			krwp = &(krcp->krw_arr[i]);
> +			flush_rcu_work(&krwp->rcu_work);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
> +
>  static unsigned long
>  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  {
> 
> -- 
> 2.46.0
> 
I need to send out a v2. What is a best way? Please let me know. I have not
checked where this series already landed.

Thank you!

--
Uladzislau Rezki
