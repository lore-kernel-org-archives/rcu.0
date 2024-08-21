Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327E1B2ED6;
	Wed, 21 Aug 2024 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263454; cv=none; b=gpimcBRO7QZNe4xl/Jgroq+tQw2VNGDRSKfedxbTQh3EiGjKOH3YugRScGMMgZ3vbfeBEOrYuO1uPppn4h+wDXPf35PKPAoEfUvZ1lkY4FXxq74gCqJBxEm1HiGRNvOyZ/tmc57bSdvulcK06Y7koW9WX76jtJ5yf8XLiG0U1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263454; c=relaxed/simple;
	bh=qHS98yZK7pOa9HMPDhX8404fTMZFYKpPmf0nKxyOas4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NM7N6nY4YWJFRdXIKLdfqw3Mshq/k9QkS/jm/VE632jlSEJv+4Tl/L+zDM/T55K+cDlWvT5dZAnlfw2b87Bv5ayXz32qfg6dHYZg5aZ3tgC5vtWnloNi4Op39AkJDLIPi+AZRugfQphSq/Y9NIf2UiYHDhSiELgxUhEn6Mz9/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jKJafOFc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5FOA5WbW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R0BXNZcg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MmVqWpam; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jKJafOFc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5FOA5WbW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R0BXNZcg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MmVqWpam"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 06286200BB;
	Wed, 21 Aug 2024 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724263450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtYw6DaP9betKmzEf9g6mISWKsVME29y3aCfMqgdfFM=;
	b=jKJafOFcTLdxl6AaXOhu50+kshzfGtgBxSumvKx3A9oYuuL8dSOx864Po2+pstl3QrJWBN
	uBLLAYQB1QWQ/2ES8X2GWSpQ2tfJ05cMHeWb2m9qAdLNQiT1P+jxfsCAKz4jDtIuhEz5uZ
	7AFW285hzSC5CRMZLOG4YgNPdsueSKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724263450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtYw6DaP9betKmzEf9g6mISWKsVME29y3aCfMqgdfFM=;
	b=5FOA5WbWfdqXLzfVVVgqR3N0Gizl15elZtQPLWdxuK6TWjl8nC452UBtF4ML/npiI2W0r+
	dcPk1dl9+O6iPfAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R0BXNZcg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MmVqWpam
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724263449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtYw6DaP9betKmzEf9g6mISWKsVME29y3aCfMqgdfFM=;
	b=R0BXNZcgqwOMxErWhpRrRazNwXpaMZpspzjC2zOKnsLIsIQeIBJx3cCgt8T60OYBZIyb/+
	6etWJxa+k3pxvQoLzPg1LTvbu8lq9WzEG/6f58S3032fp4jJUvbLtUkJJRGYtBK2zuPCgP
	fqWu0V0zALS99n+VmWoRcftFbjluarM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724263449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtYw6DaP9betKmzEf9g6mISWKsVME29y3aCfMqgdfFM=;
	b=MmVqWpam5eeb/IXRTV2pcgZa/GE/cEsfep1+IkWWeqXm0Kkw8YOLiBJkKeFEm7VZAijuV+
	5y7f9xXIlLhb9YDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABF59139C2;
	Wed, 21 Aug 2024 18:04:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NQb5JxgsxmaYeAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 21 Aug 2024 18:04:08 +0000
Message-ID: <1cc13276-43fe-4c2d-8055-0a1a8a7ee156@suse.cz>
Date: Wed, 21 Aug 2024 20:06:08 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu/kvfree: Add kvfree_rcu_barrier() API
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
References: <20240820155935.1167988-1-urezki@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20240820155935.1167988-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 06286200BB
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,joelfernandes.org,kernel.org,sony.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,monitor_work.work:url,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 8/20/24 5:59 PM, Uladzislau Rezki (Sony) wrote:
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

Thanks Ulad, replaced the patch in slab/for-next

> ---
>  include/linux/rcutiny.h |   5 ++
>  include/linux/rcutree.h |   1 +
>  kernel/rcu/tree.c       | 109 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 107 insertions(+), 8 deletions(-)
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
> index e641cc681901..be00aac5f4e7 100644
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
> @@ -3859,6 +3872,86 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
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
> +		/*
> +		 * A monitor work can drain ready to reclaim objects
> +		 * directly. Wait its completion if running or pending.
> +		 */
> +		cancel_delayed_work_sync(&krcp->monitor_work);
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
