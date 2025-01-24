Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C020ED
	for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737723400; cv=none; b=P4tuj9xk3WuCrZdkN53G/xA3x4KLhE1BO1326kqR2fRWiOQ3ODZwvdTjRgZK593PR6rfbCOHEvsW6vf4FERO8TVOKw++CnA4SwbehR0516nlRR4tlAzGkvIJLJw4crm26LnlLQWTxKuEcIGK1HcFi24fSunVXrVLvYdYtoDixyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737723400; c=relaxed/simple;
	bh=X4gmp3jnQOQdUvQbRXhgrYHE4xDX5ho8pLDy5bwsr0o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRpzXAdFy+JmAR1NKCztBbRTlW91IWi7YP3Qg+BWThok7uD45iL6TRfU2bMrpsCNEoHx/3uWA43O9ansD+s4JmiLK9ag68vgNYcrlgmBsh4GowZvRJaTE4E4RJzjbiFVFxQAX1GSkluQJGSvmvrFd3VvV1y8i9KuCVZ3PczWhl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI0eU3NX; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI0eU3NX"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30761be8fcfso21413101fa.0
        for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 04:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737723396; x=1738328196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffiUIbby5SM+vRlIpszlMWepbHRFMbgQXIPuWvddjHY=;
        b=FI0eU3NXYRGRB6vCY6hVmiT1rWtjSM2E6wSXPGAz4kTZhjS8CEnDYAiEonYdo19IC2
         utrnrlk39Wd0EXAoHmqzPq7VL3ZP689Kr+1Jkj0UkYpVkUhfqL9nGEYMBn8d5AbyhN6I
         hsyfjZerpR7jS0+HxtJ2Bxw55ycLBF8ozhfdggYv7VSfnvMKsC1kNVnhWpxIzG5Fdg0A
         8NElxKtPUwn7WtrwJSXEk0vv2qx0IvfGGD2qhy4JJjEeEa/CkgUuPJkSiacXXjCzXznF
         uKq9NNLvsDdYnqtCfSmPwdWj4VOvXlMSEkfPPt0zvuhp7h+V1SYhlelq5h+EFKVSyHVa
         +T8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737723396; x=1738328196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffiUIbby5SM+vRlIpszlMWepbHRFMbgQXIPuWvddjHY=;
        b=hjXnjzcZzcO/bwvFLVUvTIuSnEhXkWlL1OqmW1Mfq6vFsoh3FJ7bimMP/CzmJezSDa
         vzg1CTHd/dI/qn0LHRUcP1iTSJehi8t62y4I1krUb0OYxMIszJKSnMcY3PPQidSlrX/E
         Gz9JGy3Fy5LlUoZ8/crVhbUpcUpkGP3IMeXw4PoLuTetuXL2FAo5q74wZmYGLhmvpclW
         z6TirpOBa8HeQNsWPSZF+MSTX2e+aZ4D/Y8d7rYs517hBiAzWSNPRJ3j6nADMT6m2ydb
         P8htt1rwnatRy6/aPr4OukiBCuE1OTVxWhqwMHHssijY+Fd7YGnh14NqJyzUTolVf4Rk
         jesg==
X-Forwarded-Encrypted: i=1; AJvYcCVfoU6Dy3z+DPu51ULLzAXUo9SvqOkYssPZ1s8ThHGKOe3WuVBRC0BZCQ2ALpY0rvbzbgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3y+jGivq7qFP2Epj8fcUbE/ERvXchuZkzvnr9MAEHkMU1jf0
	ASRoUaJTnFlAPG2wRK3f8EvFJpLZymiWJCXjswdehYteIJckh0nOkM+iHkGZ
X-Gm-Gg: ASbGncuKXVVQmd0acuMrKWAXZWhZm3TBPJjGZNkWQUeE92ffZ13W9+3NklnVAssWoUv
	hzJT4s0pjGbfhEeh8+6DPutcmvTVeadQP/weFZ2zBiKRTCHmOQNXr5DdM5V5PKteiYrL0oQwGKZ
	DgxzTXHKP78uXWYju5L/OkfhVHF2xdAvYJHNf5nf7mEHBC3e6YGVMKse+IvCGuThU6xi/4aHCGv
	HSJ6YrX5oVvUmYtyDKw1gAEurMARJJ1W7+iT0wu9ZyqR359hBl2h+XC43qS0xC/RX+8w72wHGAq
	jSQX1qPm5/qrD0O4DMXEyhyepNSS+30uPB4=
X-Google-Smtp-Source: AGHT+IGg3T9NUCkzvWLFDsluO50pZAd6aryGE3Fy33x8NtfqXUFatNTFFo8JZTz95JS7+Y9lLJh8pg==
X-Received: by 2002:a05:651c:1141:b0:300:1f2c:e3d1 with SMTP id 38308e7fff4ca-3072cb66741mr123966891fa.23.1737723395985;
        Fri, 24 Jan 2025 04:56:35 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076bc18cdcsm3620871fa.83.2025.01.24.04.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:56:35 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 24 Jan 2025 13:56:32 +0100
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
Subject: Re: [PATCH RFC 1/4] slab, rcu: move TINY_RCU variant of kvfree_rcu()
 to SLAB
Message-ID: <Z5OOAPQcoIP_HwYS@pc636>
References: <20250123-slub-tiny-kfree_rcu-v1-0-0e386ef1541a@suse.cz>
 <20250123-slub-tiny-kfree_rcu-v1-1-0e386ef1541a@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123-slub-tiny-kfree_rcu-v1-1-0e386ef1541a@suse.cz>

On Thu, Jan 23, 2025 at 11:37:18AM +0100, Vlastimil Babka wrote:
> Following the move of TREE_RCU implementation, let's move also the
> TINY_RCU one for consistency and subsequent refactoring.
> 
> For simplicity, remove the separate inline __kvfree_call_rcu() as
> TINY_RCU is not meant for high-performance hardware anyway.
> 
> Declare kvfree_call_rcu() in rcupdate.h to avoid header dependency
> issues.
> 
> Also move the kvfree_rcu_barrier() declaration to slab.h
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/rcupdate.h |  5 +++++
>  include/linux/rcutiny.h  | 36 ------------------------------------
>  include/linux/rcutree.h  |  3 ---
>  include/linux/slab.h     | 14 ++++++++++++++
>  kernel/rcu/tiny.c        | 11 -----------
>  mm/slab_common.c         | 20 ++++++++++++++++++--
>  6 files changed, 37 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 48e5c03df1dd83c246a61d0fcc8aa638adcd7654..3f70d1c8144426f40553c8c589f07097ece8a706 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1082,6 +1082,11 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>  #define kfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
>  #define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
>  
> +/*
> + * In mm/slab_common.c, no suitable header to include here.
> + */
> +void kvfree_call_rcu(struct rcu_head *head, void *ptr);
> +
>  #define kvfree_rcu_arg_2(ptr, rhf)					\
>  do {									\
>  	typeof (ptr) ___p = (ptr);					\
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index fe42315f667fc5be7f2ed8eae6ea0c7193030846..f519cd6802286710bdd56588b5ff3d07bcd30b92 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -90,41 +90,6 @@ static inline void synchronize_rcu_expedited(void)
>  	synchronize_rcu();
>  }
>  
> -/*
> - * Add one more declaration of kvfree() here. It is
> - * not so straight forward to just include <linux/mm.h>
> - * where it is defined due to getting many compile
> - * errors caused by that include.
> - */
> -extern void kvfree(const void *addr);
> -
> -static inline void __kvfree_call_rcu(struct rcu_head *head, void *ptr)
> -{
> -	if (head) {
> -		call_rcu(head, (rcu_callback_t) ((void *) head - ptr));
> -		return;
> -	}
> -
> -	// kvfree_rcu(one_arg) call.
> -	might_sleep();
> -	synchronize_rcu();
> -	kvfree(ptr);
> -}
> -
> -static inline void kvfree_rcu_barrier(void)
> -{
> -	rcu_barrier();
> -}
> -
> -#ifdef CONFIG_KASAN_GENERIC
> -void kvfree_call_rcu(struct rcu_head *head, void *ptr);
> -#else
> -static inline void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> -{
> -	__kvfree_call_rcu(head, ptr);
> -}
> -#endif
> -
>  void rcu_qs(void);
>  
>  static inline void rcu_softirq_qs(void)
> @@ -164,7 +129,6 @@ static inline void rcu_end_inkernel_boot(void) { }
>  static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
>  static inline bool rcu_is_watching(void) { return true; }
>  static inline void rcu_momentary_eqs(void) { }
> -static inline void kfree_rcu_scheduler_running(void) { }
>  
>  /* Avoid RCU read-side critical sections leaking across. */
>  static inline void rcu_all_qs(void) { barrier(); }
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 27d86d9127817e50f8d4dd79e1990d70a02435bb..dbe77b5fe06ec89a393b5444d6c479ced346a37b 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -34,12 +34,9 @@ static inline void rcu_virt_note_context_switch(void)
>  }
>  
>  void synchronize_rcu_expedited(void);
> -void kvfree_call_rcu(struct rcu_head *head, void *ptr);
> -void kvfree_rcu_barrier(void);
>  
>  void rcu_barrier(void);
>  void rcu_momentary_eqs(void);
> -void kfree_rcu_scheduler_running(void);
>  
>  struct rcu_gp_oldstate {
>  	unsigned long rgos_norm;
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 09eedaecf1205672bb2e7c8cd57ae8fccebc2737..bcc62e5656c35c6a3f4caf26fb33d7447dead39a 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -16,6 +16,7 @@
>  #include <linux/gfp.h>
>  #include <linux/overflow.h>
>  #include <linux/types.h>
> +#include <linux/rcupdate.h>
>  #include <linux/workqueue.h>
>  #include <linux/percpu-refcount.h>
>  #include <linux/cleanup.h>
> @@ -1082,6 +1083,19 @@ extern void kvfree_sensitive(const void *addr, size_t len);
>  
>  unsigned int kmem_cache_size(struct kmem_cache *s);
>  
> +#ifdef CONFIG_TINY_RCU
> +static inline void kvfree_rcu_barrier(void)
> +{
> +	rcu_barrier();
> +}
> +
> +static inline void kfree_rcu_scheduler_running(void) { }
> +#else
> +void kvfree_rcu_barrier(void);
> +
> +void kfree_rcu_scheduler_running(void);
> +#endif
> +
>  /**
>   * kmalloc_size_roundup - Report allocation bucket size for the given size
>   *
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index b3b3ce34df6310f7bddba40b2be1bdf6c9f00232..0ec27093d0e14a4b1060ea08932c4ac13f9b0f26 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -246,17 +246,6 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
>  }
>  EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
>  
> -#ifdef CONFIG_KASAN_GENERIC
> -void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> -{
> -	if (head)
> -		kasan_record_aux_stack_noalloc(ptr);
> -
> -	__kvfree_call_rcu(head, ptr);
> -}
> -EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> -#endif
> -
>  void __init rcu_init(void)
>  {
>  	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 69f2d19010dedaa3e5b303ab9803c8cdd40152fa..330cdd8ebc5380090ee784c58e8ca1d1a52b3758 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1861,7 +1861,23 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  	return true;
>  }
>  
> -#if !defined(CONFIG_TINY_RCU)
> +#ifdef CONFIG_TINY_RCU
> +
> +void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> +{
> +	if (head) {
> +		kasan_record_aux_stack_noalloc(ptr);
> +		call_rcu(head, (rcu_callback_t) ((void *) head - ptr));
> +		return;
> +	}
> +
> +	// kvfree_rcu(one_arg) call.
> +	might_sleep();
> +	synchronize_rcu();
> +	kvfree(ptr);
> +}
> +
> +#else /* !CONFIG_TINY_RCU */
>  
>  static enum hrtimer_restart
>  schedule_page_work_fn(struct hrtimer *t)
> @@ -2071,7 +2087,7 @@ void kvfree_rcu_barrier(void)
>  }
>  EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>  
> -#endif /* #if !defined(CONFIG_TINY_RCU) */
> +#endif /* !CONFIG_TINY_RCU */
>  
>  static unsigned long
>  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> 
> -- 
> 2.48.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
