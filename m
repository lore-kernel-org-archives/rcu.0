Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B9C1547FF;
	Wed, 25 Sep 2024 05:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727243902; cv=none; b=nD//mZv+lh2/5wYU8GjQBgzgSIBLQilhHwxN5jgmAaRWzPnHLLxkVPqNVJmcPtkoEok7dJ/AHFNKmd9PO7641qEPDkaQ3yL9aZh6VyjMVhepBd85FNCp1BGdqNpVcfQThwjS5KMtW21yC6lTONnQCzdOUj/7SfEcDGTNsH1cC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727243902; c=relaxed/simple;
	bh=Tvh6Pi/X5aMcnSJiLOQ+KmmeM8XHH6g5mn+r7R3lqG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSnGC/Xqyub9/u0Ix7IPEFCc1osv1+IVCS/0rOYXZ16/67hdVimdHi+Tgp0YwUhB0hG8N1X6J2+YUlwClMr0WfmgflxSmBHrOmiPgerHHN03azmlElon11jQX52OW6nQD/lpilfP8dqzYjFU6M3izMKljbzBs5wOzcKn7VMmzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XD59r0ygtz9v7Hq;
	Wed, 25 Sep 2024 13:38:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A2C63140604;
	Wed, 25 Sep 2024 13:58:00 +0800 (CST)
Received: from [10.45.145.184] (unknown [10.45.145.184])
	by APP1 (Coremail) with SMTP id LxC2BwAnuC9ZpvNmFYKXAQ--.24203S2;
	Wed, 25 Sep 2024 06:57:59 +0100 (CET)
Message-ID: <e4721439-8cad-4134-8c07-84b6ecc69573@huaweicloud.com>
Date: Wed, 25 Sep 2024 07:57:43 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] hpref: Hazard Pointers with Reference Counter
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Alan Stern
 <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev
References: <20240921164210.256278-1-mathieu.desnoyers@efficios.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20240921164210.256278-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwAnuC9ZpvNmFYKXAQ--.24203S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1UGw4xJr15CFy8KryUJrb_yoWxZFyxpF
	W3urs3tFZrJF4I9a10van8uayv9F1F9a18W348Jry3Z39rJ34UJ3WUtrWUAa1fCrykXw4a
	vw4Y9FZrJF9rtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYyUDJUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/

Hi Mathieu,

interesting idea. Conceptually it looks good.

There's another approach of using hazard pointer to optimize shared 
reference counting (to make it lock-free in common cases).

https://github.com/cmuparlay/concurrent_deferred_rc

It doesn't go as far as what you're doing, but they also use the hazard 
pointer to protect the refcount (like you do in the promote function).

I haven't read your code in detail but it seems to me you have an ABA 
bug: as I explained elsewhere, you could read the same pointer after ABA 
but you don't synchronize with the newer store that gave you node2, 
leaving you to speculatively read stale values through *ctx->hp.
(I am assuming here that ctx->hp is essentially an out parameter used to 
let the caller know which node got protected).

Have fun,
   jonas

> +/*
> + * hpref_hp_get: Obtain a reference to a stable object, protected either
> + *               by hazard pointer (fast-path) or using reference
> + *               counter as fall-back.
> + */
> +static inline
> +bool hpref_hp_get(struct hpref_node **node_p, struct hpref_ctx *ctx)
> +{
> +	int cpu = rseq_current_cpu_raw();
> +	struct hpref_percpu_slots *cpu_slots = rseq_percpu_ptr(hpref_percpu_slots, cpu);
> +	struct hpref_slot *slot = &cpu_slots->slots[cpu_slots->current_slot];
> +	bool use_refcount = false;
> +	struct hpref_node *node, *node2;
> +	unsigned int next_slot;
> +
> +retry:
> +	node = uatomic_load(node_p, CMM_RELAXED);
> +	if (!node)
> +		return false;
> +	/* Use rseq to try setting current slot hp. Store B. */
> +	if (rseq_load_cbne_store__ptr(RSEQ_MO_RELAXED, RSEQ_PERCPU_CPU_ID,
> +				(intptr_t *) &slot->node, (intptr_t) NULL,
> +				(intptr_t) node, cpu)) {
> +		slot = &cpu_slots->slots[HPREF_EMERGENCY_SLOT];
> +		use_refcount = true;
> +		/*
> +		 * This may busy-wait for another reader using the
> +		 * emergency slot to transition to refcount.
> +		 */
> +		caa_cpu_relax();
> +		goto retry;
> +	}
> +	/* Memory ordering: Store B before Load A. */
> +	cmm_smp_mb();
> +	node2 = uatomic_load(node_p, CMM_RELAXED);	/* Load A */
> +	if (node != node2) {
> +		uatomic_store(&slot->node, NULL, CMM_RELAXED);
> +		if (!node2)
> +			return false;
> +		goto retry;
> +	}
> +	ctx->type = HPREF_TYPE_HP;
> +	ctx->hp = node;
                    ^---- here

> +	ctx->slot = slot;
> +	if (use_refcount) {
> +		hpref_promote_hp_to_ref(ctx);
> +		return true;
> +	}
> +	/*
> +	 * Increment current slot (racy increment is OK because it is
> +	 * just a position hint). Skip the emergency slot.
> +	 */
> +	next_slot = uatomic_load(&cpu_slots->current_slot, CMM_RELAXED) + 1;
> +	if (next_slot >= HPREF_EMERGENCY_SLOT)
> +		next_slot = 0;
> +	uatomic_store(&cpu_slots->current_slot, next_slot, CMM_RELAXED);
> +	return true;
> +}
> +
> +static inline
> +void hpref_put(struct hpref_ctx *ctx)
> +{
> +	if (ctx->type == HPREF_TYPE_REF) {
> +		urcu_ref_put(&ctx->hp->refcount, hpref_release);
> +	} else {
> +		/* Release HP. */
> +		uatomic_store(&ctx->slot->node, NULL, CMM_RELEASE);
> +	}
> +	ctx->hp = NULL;
> +}
> +
> +/*
> + * hpref_set_pointer: Store pointer @node to @ptr, with RCU publication
> + *                    guarantees.
> + */
> +static inline
> +void hpref_set_pointer(struct hpref_node **ptr, struct hpref_node *node)
> +{
> +	if (__builtin_constant_p(node) && node == NULL)
> +		uatomic_store(ptr, NULL, CMM_RELAXED);
> +	else
> +		uatomic_store(ptr, node, CMM_RELEASE);
> +}
> +
> +/*
> + * Return the content of the hpref context hazard pointer field.
> + */
> +static inline
> +struct hpref_node *hpref_ctx_pointer(struct hpref_ctx *ctx)
> +{
> +	return ctx->hp;
> +}
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* _URCU_HPREF_H */
> diff --git a/src/Makefile.am b/src/Makefile.am
> index b555c818..7312c9f7 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -19,7 +19,8 @@ RCULFHASH = rculfhash.c rculfhash-mm-order.c rculfhash-mm-chunk.c \
>   lib_LTLIBRARIES = liburcu-common.la \
>   		liburcu.la liburcu-qsbr.la \
>   		liburcu-mb.la liburcu-bp.la \
> -		liburcu-memb.la liburcu-cds.la
> +		liburcu-memb.la liburcu-cds.la \
> +		liburcu-hpref.la
>   
>   #
>   # liburcu-common contains wait-free queues (needed by call_rcu) as well
> @@ -50,6 +51,9 @@ liburcu_cds_la_SOURCES = rculfqueue.c rculfstack.c lfstack.c \
>   	workqueue.c workqueue.h $(RCULFHASH) $(COMPAT)
>   liburcu_cds_la_LIBADD = liburcu-common.la
>   
> +liburcu_hpref_la_SOURCES = hpref.c
> +liburcu_hpref_la_LIBADD = -lrseq
> +
>   pkgconfigdir = $(libdir)/pkgconfig
>   pkgconfig_DATA = liburcu-cds.pc liburcu.pc liburcu-bp.pc liburcu-qsbr.pc \
>   	liburcu-mb.pc liburcu-memb.pc
> diff --git a/src/hpref.c b/src/hpref.c
> new file mode 100644
> index 00000000..f63530f5
> --- /dev/null
> +++ b/src/hpref.c
> @@ -0,0 +1,78 @@
> +// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> +//
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +
> +/*
> + * HPREF: Hazard pointers with reference counters
> + */
> +
> +#define _LGPL_SOURCE
> +#include <urcu/hpref.h>
> +#include <rseq/mempool.h>	/* Per-CPU memory */
> +
> +static struct rseq_mempool *mempool;
> +struct hpref_percpu_slots *hpref_percpu_slots;
> +
> +void hpref_release(struct urcu_ref *ref)
> +{
> +	struct hpref_node *node = caa_container_of(ref, struct hpref_node, refcount);
> +
> +	node->release(node);
> +}
> +
> +/*
> + * hpref_synchronize: Wait for any reader possessing a hazard pointer to
> + *                    @node to clear its hazard pointer slot.
> + */
> +void hpref_synchronize(struct hpref_node *node)
> +{
> +	int nr_cpus = rseq_get_max_nr_cpus(), cpu;
> +
> +	/* Memory ordering: Store A before Load B. */
> +	cmm_smp_mb();
> +	/* Scan all CPUs slots. */
> +	for (cpu = 0; cpu < nr_cpus; cpu++) {
> +		struct hpref_percpu_slots *cpu_slots = rseq_percpu_ptr(hpref_percpu_slots, cpu);
> +		struct hpref_slot *slot;
> +		unsigned int i;
> +
> +		for (i = 0; i < HPREF_NR_PERCPU_SLOTS; i++) {
> +			slot = &cpu_slots->slots[i];
> +			/* Busy-wait if node is found. */
> +			while (uatomic_load(&slot->node, CMM_ACQUIRE) == node)	/* Load B */
> +				caa_cpu_relax();
> +		}
> +	}
> +}
> +
> +/*
> + * hpref_synchronize_put: Wait for any reader possessing a hazard
> + *                        pointer to clear its slot and put reference
> + *                        count.
> + */
> +void hpref_synchronize_put(struct hpref_node *node)
> +{
> +	if (!node)
> +		return;
> +	hpref_synchronize(node);
> +	urcu_ref_put(&node->refcount, hpref_release);
> +}
> +
> +static __attribute__((constructor))
> +void hpref_init(void)
> +{
> +	mempool = rseq_mempool_create("hpref", sizeof(struct hpref_percpu_slots), NULL);
> +	if (!mempool)
> +		abort();
> +	hpref_percpu_slots = rseq_mempool_percpu_zmalloc(mempool);
> +	if (!hpref_percpu_slots)
> +		abort();
> +}
> +
> +static __attribute__((destructor))
> +void hpref_exit(void)
> +{
> +	rseq_mempool_percpu_free(hpref_percpu_slots);
> +	if (rseq_mempool_destroy(mempool))
> +		abort();
> +}

