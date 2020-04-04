Return-Path: <SRS0=3CeA=5U=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85453C2BA1A
	for <rcu@archiver.kernel.org>; Sat,  4 Apr 2020 19:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446E62074B
	for <rcu@archiver.kernel.org>; Sat,  4 Apr 2020 19:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kks2rrNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgDDTvc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 4 Apr 2020 15:51:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33245 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgDDTvc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 4 Apr 2020 15:51:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id c14so9573254qtp.0
        for <rcu@vger.kernel.org>; Sat, 04 Apr 2020 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JnH2YdzKei6/i4FAonkrjq4wGGtTFL+OPicU7RFsfDY=;
        b=kks2rrNp4B8vC42ruxIC+b0Hdo81tksjcDRn8BoHO7XDoK1XLqkvpQX9S67CbbUYK4
         wjrr2ZE5QRXKmXsPkPxVhuQAvi77cjCecx0elDwRtEFRLLYmd1TLBZ9dT+cmlvdTNSEl
         DDDqgRh9zTc9R1SSxvZpC8gpr/8rPL5T8kqnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JnH2YdzKei6/i4FAonkrjq4wGGtTFL+OPicU7RFsfDY=;
        b=p4SXtJFpEHe/oXuxA4N03BC3aA/CV7nuqnNjX6k9J+WKfW6LRF4mm5O4p49rNQiLAM
         hY9egYQx3+4l0/9mzpxpml/GpSh/TrO0mjpfdYiOWJjKmSs5TVuWtN9cCn/3cyJdsp2x
         wQIynJuEInlL7lDxaiH8Xk68B5eWDNxUdPIEduLk8E2mGjB7WJ+b0QO5VOCU0ceMr9M7
         nEWhScz6Vwc25HSi4XcyFjsreUYjN8n1vUzwEO0ymTRTt5IdPjiCXJesgQZe+nE4xlif
         goDS3Obkd6QgBjte6JFCPAdVPKdwx4lmHjGP+cOCNje7F2Zxwl72GPZqu5utrPEPKtZp
         qTmQ==
X-Gm-Message-State: AGi0PuY9QOWhmFQEqcok9H0y0rWsqMDUHb1r722XW1tQm1LXEj74YtBM
        NUhVuLH9QM68z3ewXAJs67CWMw==
X-Google-Smtp-Source: APiQypIiIBO6WsMnuLAP7nJvxIVmqVxHuINgTlpfFL/ItQVMd6KuF3//Knsl4k4tTcBqtt+9qg+OWA==
X-Received: by 2002:ac8:40da:: with SMTP id f26mr380755qtm.391.1586029890360;
        Sat, 04 Apr 2020 12:51:30 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y27sm9843253qky.50.2020.04.04.12.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 12:51:29 -0700 (PDT)
Date:   Sat, 4 Apr 2020 15:51:29 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Message-ID: <20200404195129.GA83565@google.com>
References: <20200403173051.4081-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403173051.4081-1-urezki@gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 03, 2020 at 07:30:51PM +0200, Uladzislau Rezki (Sony) wrote:
> Maintain an emergency pool for each CPU with some
> extra objects. There is read-only sysfs attribute,
> the name is "rcu_nr_emergency_objs". It reflects
> the size of the pool. As for now the default value
> is 3.
> 
> The pool is populated when low memory condition is
> detected. Please note it is only for headless case
> it means when the regular SLAB is not able to serve
> any request, the pool is used.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Hi Vlad,

One concern I have is this moves the problem a bit further down. My belief is
we should avoid the likelihood of even needing an rcu_head allocated for the
headless case, to begin with - than trying to do damage-control when it does
happen. The only way we would end up needing an rcu_head is if we could not
allocate an array.

So instead of adding a pool for rcu_head allocations, how do you feel about
pre-allocation of the per-cpu cache array instead, which has the same effect
as you are intending?

This has 3 benefits:
1. It scales with number of CPUs, no configuration needed.
2. It makes the first kfree_rcu() faster and less dependent on an allocation
   succeeding.
3. Much simpler code, no new structures or special handling.
4. In the future we can extend it to allocate more than 2 pages per CPU using
   the same caching mechanism.

The obvious drawback being its 2 pages per CPU but at least it scales by
number of CPUs. Something like the following (just lightly tested):

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] rcu/tree: Preallocate the per-cpu cache for kfree_rcu()

In recent changes, we have made it possible to use kfree_rcu() without
embedding an rcu_head in the object being free'd. This requires dynamic
allocation. In case dynamic allocation fails due to memory pressure, we
would end up synchronously waiting for an RCU grace period thus hurting
kfree_rcu() latency.

To make this less probable, let us pre-allocate the per-cpu cache so we
depend less on the dynamic allocation succeeding. This also has the
effect of making kfree_rcu() slightly faster at run time.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6172e6296dd7d..9fbdeb4048425 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4251,6 +4251,11 @@ static void __init kfree_rcu_batch_init(void)
 			krcp->krw_arr[i].krcp = krcp;
 		}
 
+		krcp->bkvcache[0] =  (struct kvfree_rcu_bulk_data *)
+					__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+		krcp->bkvcache[1] =  (struct kvfree_rcu_bulk_data *)
+					__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
-- 
2.26.0.292.g33ef6b2f38-goog


> ---
>  kernel/rcu/tree.c | 133 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 97 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5e26145e9ead..f9f1f935ab0b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -114,6 +114,14 @@ int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
>  int rcu_kfree_nowarn;
>  module_param(rcu_kfree_nowarn, int, 0444);
>  
> +/*
> + * For headless variant. Under memory pressure an
> + * emergency pool can be used if the regular SLAB
> + * is not able to serve some memory for us.
> + */
> +int rcu_nr_emergency_objs = 3;
> +module_param(rcu_nr_emergency_objs, int, 0444);
> +
>  /* Number of rcu_nodes at specified level. */
>  int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
>  int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
> @@ -2877,6 +2885,12 @@ struct kfree_rcu_cpu {
>  	bool initialized;
>  	// Number of objects for which GP not started
>  	int count;
> +
> +	/*
> +	 * Reserved emergency pool for headless variant.
> +	 */
> +	int nr_emergency;
> +	void **emergency;
>  };
>  
>  static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
> @@ -2892,6 +2906,27 @@ debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
>  #endif
>  }
>  
> +static inline struct kfree_rcu_cpu *
> +krc_this_cpu_lock(unsigned long *flags)
> +{
> +	struct kfree_rcu_cpu *krcp;
> +
> +	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
> +	krcp = this_cpu_ptr(&krc);
> +	if (likely(krcp->initialized))
> +		spin_lock(&krcp->lock);
> +
> +	return krcp;
> +}
> +
> +static inline void
> +krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
> +{
> +	if (likely(krcp->initialized))
> +		spin_unlock(&krcp->lock);
> +	local_irq_restore(flags);
> +}
> +
>  /*
>   * This function is invoked in workqueue context after a grace period.
>   * It frees all the objects queued on ->bhead_free or ->head_free.
> @@ -2974,6 +3009,7 @@ static void kfree_rcu_work(struct work_struct *work)
>  	 */
>  	for (; head; head = next) {
>  		unsigned long offset = (unsigned long)head->func;
> +		unsigned long flags;
>  		bool headless;
>  		void *ptr;
>  
> @@ -2991,10 +3027,23 @@ static void kfree_rcu_work(struct work_struct *work)
>  		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
>  
>  		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset))) {
> -			if (headless)
> +			if (headless) {
>  				kvfree((void *) *((unsigned long *) ptr));
>  
> -			kvfree(ptr);
> +				krcp = krc_this_cpu_lock(&flags);
> +				if (krcp->emergency) {
> +					if (krcp->nr_emergency < rcu_nr_emergency_objs) {
> +						krcp->emergency[krcp->nr_emergency++] = ptr;
> +
> +						/* Bypass freeing of it, it is in emergency pool. */
> +						ptr = NULL;
> +					}
> +				}
> +				krc_this_cpu_unlock(krcp, flags);
> +			}
> +
> +			if (ptr)
> +				kvfree(ptr);
>  		}
>  
>  		rcu_lock_release(&rcu_callback_map);
> @@ -3144,40 +3193,26 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>  	return true;
>  }
>  
> -static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
> +static inline struct rcu_head *
> +set_ptr_in_rcu_head_obj(void *ptr, unsigned long *rho)
> +{
> +	rho[0] = (unsigned long) ptr;
> +	return ((struct rcu_head *) ++rho);
> +}
> +
> +static inline struct rcu_head *
> +alloc_rcu_head_obj(void *ptr)
>  {
> -	unsigned long *ptr;
> +	unsigned long *rho;
>  
>  	/* Try hard to get the memory. */
> -	ptr = kmalloc(sizeof(unsigned long *) +
> +	rho = kmalloc(sizeof(unsigned long *) +
>  		sizeof(struct rcu_head), GFP_KERNEL |
>  			__GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL);
> -	if (!ptr)
> +	if (!rho)
>  		return NULL;
>  
> -	ptr[0] = (unsigned long) obj;
> -	return ((struct rcu_head *) ++ptr);
> -}
> -
> -static inline struct kfree_rcu_cpu *
> -krc_this_cpu_lock(unsigned long *flags)
> -{
> -	struct kfree_rcu_cpu *krcp;
> -
> -	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
> -	krcp = this_cpu_ptr(&krc);
> -	if (likely(krcp->initialized))
> -		spin_lock(&krcp->lock);
> -
> -	return krcp;
> -}
> -
> -static inline void
> -krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
> -{
> -	if (likely(krcp->initialized))
> -		spin_unlock(&krcp->lock);
> -	local_irq_restore(flags);
> +	return set_ptr_in_rcu_head_obj(ptr, rho);
>  }
>  
>  /*
> @@ -3237,15 +3272,31 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	if (!success) {
>  		/* Is headless object? */
>  		if (head == NULL) {
> -			/* Drop the lock. */
> +			/*
> +			 * Drop the lock to use more permissive
> +			 * parameters, after that take it back.
> +			 */
>  			krc_this_cpu_unlock(krcp, flags);
> +			head = alloc_rcu_head_obj(ptr);
> +			krcp = krc_this_cpu_lock(&flags);
>  
> -			head = attach_rcu_head_to_object(ptr);
> -			if (head == NULL)
> -				goto inline_return;
> +			/*
> +			 * Use emergency pool if still fails.
> +			 */
> +			if (head == NULL) {
> +				if (!krcp->nr_emergency)
> +					goto unlock_return;
>  
> -			/* Take it back. */
> -			krcp = krc_this_cpu_lock(&flags);
> +				head = set_ptr_in_rcu_head_obj(ptr,
> +					krcp->emergency[--krcp->nr_emergency]);
> +
> +				/*
> +				 * We do not need to do it. But just in case
> +				 * let's set the pulled slot to NULL to avoid
> +				 * magic issues.
> +				 */
> +				krcp->emergency[krcp->nr_emergency] = NULL;
> +			}
>  
>  			/*
>  			 * Tag the headless object. Such objects have a back-pointer
> @@ -3282,7 +3333,6 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  unlock_return:
>  	krc_this_cpu_unlock(krcp, flags);
>  
> -inline_return:
>  	/*
>  	 * High memory pressure, so inline kvfree() after
>  	 * synchronize_rcu(). We can do it from might_sleep()
> @@ -4272,6 +4322,17 @@ static void __init kfree_rcu_batch_init(void)
>  		}
>  
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> +
> +		/*
> +		 * The poll will be populated when low memory condition
> +		 * is detected. Therefore we do not fill it in here.
> +		 */
> +		krcp->emergency = kmalloc_array(rcu_nr_emergency_objs,
> +			sizeof(void *), GFP_NOWAIT);
> +
> +		if (!krcp->emergency)
> +			pr_err("Failed to create emergency pool for %d CPU!\n", cpu);
> +
>  		krcp->initialized = true;
>  	}
>  	if (register_shrinker(&kfree_rcu_shrinker))
> -- 
> 2.20.1
> 

