Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAFB1487FF;
	Wed, 25 Sep 2024 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246162; cv=none; b=MGaGPpmfRaULA11PCR/w2JRP5GhHl8vr0p5XTfwOz6FcwNW3htG7/tjVyFrc//DqfAbNQEA7ossGoaSrfzeWxgX6lTAnIBPS4iZM3fi561vfBhf0L+RHrFgDNavV1RIlswy4NAFm1Kt/IHBwWhTJuKAK2KEi94nHq1FjLu0uPhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246162; c=relaxed/simple;
	bh=DgyGr6egxcOB39s5l6IEt9vFBGg3lOzqWSScvDkVdx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ti7Xh4KeD/DkNAFr/zjgZnqYS98fFBPe3qFhG5CsGW11HulqK6D9Ji9Xne2Mdpf/IuIaGzEW5YKBD9nO+su45hMBWp/a5ogII7+kq/c0geyakVffCul5f09JQzcZzw1Uv0cPYs+uAnno1oM6Wm/2AgT5eNxPUPWskFScOrP89hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Q6apTrqm; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Q6apTrqm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727246152;
	bh=DgyGr6egxcOB39s5l6IEt9vFBGg3lOzqWSScvDkVdx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q6apTrqmCbkPOJxFrRCMYZqmm2X0FA2Eryzt90uZzGARNknLJHHkfLBzijizaDW2m
	 ocPI3aTcKEv4X12+W2dAgNhs6KTFfDtLzpaA9drN6EV13LgL5LB1aI9fApYlH81+5b
	 nZdvgVRXs7vDm/bI9ddaiSgx4IMRs1G/RGZwTBQ18Bx4xqjQv+h78wPglzW6r0XqfE
	 nIMFqSYN8kRGMeHnKOSYouMUZvtpZo7qkv0Wd3MeeFRpd2046rNuLkAulNsw4SArQ9
	 O73p+k+uP44jAYiLM6umRC7/JJamqSyCKcf48FCPJNfvyCtTFC1vSO8QLkMUyf8ZSz
	 KCqCtf4LRyl3Q==
Received: from [172.24.0.4] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XD6S01yS9z1Lkh;
	Wed, 25 Sep 2024 02:35:44 -0400 (EDT)
Message-ID: <48ae741e-98aa-49d9-b677-6c4f8fd1bcb0@efficios.com>
Date: Wed, 25 Sep 2024 08:35:04 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] hpref: Hazard Pointers with Reference Counter
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
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
 <e4721439-8cad-4134-8c07-84b6ecc69573@huaweicloud.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <e4721439-8cad-4134-8c07-84b6ecc69573@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-25 07:57, Jonas Oberhauser wrote:
> Hi Mathieu,
> 
> interesting idea. Conceptually it looks good.
> 
> There's another approach of using hazard pointer to optimize shared 
> reference counting (to make it lock-free in common cases).
> 
> https://github.com/cmuparlay/concurrent_deferred_rc
> 
> It doesn't go as far as what you're doing, but they also use the hazard 
> pointer to protect the refcount (like you do in the promote function).

Thanks for the reference. Indeed, one use-case of this HP+refcount
scheme would be to implement something that resembles C++ shared
pointers. I'm glad to see I'm not alone in seeing potential in this
approach.

> I haven't read your code in detail but it seems to me you have an ABA 
> bug: as I explained elsewhere, you could read the same pointer after ABA 
> but you don't synchronize with the newer store that gave you node2, 
> leaving you to speculatively read stale values through *ctx->hp.
> (I am assuming here that ctx->hp is essentially an out parameter used to 
> let the caller know which node got protected).

You are of course absolutely right. The following change should fix it:

  	cmm_barrier();
-	node2 = uatomic_load(node_p, CMM_RELAXED);	/* Load A */
+	node2 = rcu_dereference(*node_p);	/* Load A */

Please let me know if I'm missing anything.

Thanks,

Mathieu


> 
> Have fun,
>    jonas
> 
>> +/*
>> + * hpref_hp_get: Obtain a reference to a stable object, protected either
>> + *               by hazard pointer (fast-path) or using reference
>> + *               counter as fall-back.
>> + */
>> +static inline
>> +bool hpref_hp_get(struct hpref_node **node_p, struct hpref_ctx *ctx)
>> +{
>> +    int cpu = rseq_current_cpu_raw();
>> +    struct hpref_percpu_slots *cpu_slots = 
>> rseq_percpu_ptr(hpref_percpu_slots, cpu);
>> +    struct hpref_slot *slot = 
>> &cpu_slots->slots[cpu_slots->current_slot];
>> +    bool use_refcount = false;
>> +    struct hpref_node *node, *node2;
>> +    unsigned int next_slot;
>> +
>> +retry:
>> +    node = uatomic_load(node_p, CMM_RELAXED);
>> +    if (!node)
>> +        return false;
>> +    /* Use rseq to try setting current slot hp. Store B. */
>> +    if (rseq_load_cbne_store__ptr(RSEQ_MO_RELAXED, RSEQ_PERCPU_CPU_ID,
>> +                (intptr_t *) &slot->node, (intptr_t) NULL,
>> +                (intptr_t) node, cpu)) {
>> +        slot = &cpu_slots->slots[HPREF_EMERGENCY_SLOT];
>> +        use_refcount = true;
>> +        /*
>> +         * This may busy-wait for another reader using the
>> +         * emergency slot to transition to refcount.
>> +         */
>> +        caa_cpu_relax();
>> +        goto retry;
>> +    }
>> +    /* Memory ordering: Store B before Load A. */
>> +    cmm_smp_mb();
>> +    node2 = uatomic_load(node_p, CMM_RELAXED);    /* Load A */
>> +    if (node != node2) {
>> +        uatomic_store(&slot->node, NULL, CMM_RELAXED);
>> +        if (!node2)
>> +            return false;
>> +        goto retry;
>> +    }
>> +    ctx->type = HPREF_TYPE_HP;
>> +    ctx->hp = node;
>                     ^---- here
> 
>> +    ctx->slot = slot;
>> +    if (use_refcount) {
>> +        hpref_promote_hp_to_ref(ctx);
>> +        return true;
>> +    }
>> +    /*
>> +     * Increment current slot (racy increment is OK because it is
>> +     * just a position hint). Skip the emergency slot.
>> +     */
>> +    next_slot = uatomic_load(&cpu_slots->current_slot, CMM_RELAXED) + 1;
>> +    if (next_slot >= HPREF_EMERGENCY_SLOT)
>> +        next_slot = 0;
>> +    uatomic_store(&cpu_slots->current_slot, next_slot, CMM_RELAXED);
>> +    return true;
>> +}
>> +
>> +static inline
>> +void hpref_put(struct hpref_ctx *ctx)
>> +{
>> +    if (ctx->type == HPREF_TYPE_REF) {
>> +        urcu_ref_put(&ctx->hp->refcount, hpref_release);
>> +    } else {
>> +        /* Release HP. */
>> +        uatomic_store(&ctx->slot->node, NULL, CMM_RELEASE);
>> +    }
>> +    ctx->hp = NULL;
>> +}
>> +
>> +/*
>> + * hpref_set_pointer: Store pointer @node to @ptr, with RCU publication
>> + *                    guarantees.
>> + */
>> +static inline
>> +void hpref_set_pointer(struct hpref_node **ptr, struct hpref_node *node)
>> +{
>> +    if (__builtin_constant_p(node) && node == NULL)
>> +        uatomic_store(ptr, NULL, CMM_RELAXED);
>> +    else
>> +        uatomic_store(ptr, node, CMM_RELEASE);
>> +}
>> +
>> +/*
>> + * Return the content of the hpref context hazard pointer field.
>> + */
>> +static inline
>> +struct hpref_node *hpref_ctx_pointer(struct hpref_ctx *ctx)
>> +{
>> +    return ctx->hp;
>> +}
>> +
>> +#ifdef __cplusplus
>> +}
>> +#endif
>> +
>> +#endif /* _URCU_HPREF_H */
>> diff --git a/src/Makefile.am b/src/Makefile.am
>> index b555c818..7312c9f7 100644
>> --- a/src/Makefile.am
>> +++ b/src/Makefile.am
>> @@ -19,7 +19,8 @@ RCULFHASH = rculfhash.c rculfhash-mm-order.c 
>> rculfhash-mm-chunk.c \
>>   lib_LTLIBRARIES = liburcu-common.la \
>>           liburcu.la liburcu-qsbr.la \
>>           liburcu-mb.la liburcu-bp.la \
>> -        liburcu-memb.la liburcu-cds.la
>> +        liburcu-memb.la liburcu-cds.la \
>> +        liburcu-hpref.la
>>   #
>>   # liburcu-common contains wait-free queues (needed by call_rcu) as well
>> @@ -50,6 +51,9 @@ liburcu_cds_la_SOURCES = rculfqueue.c rculfstack.c 
>> lfstack.c \
>>       workqueue.c workqueue.h $(RCULFHASH) $(COMPAT)
>>   liburcu_cds_la_LIBADD = liburcu-common.la
>> +liburcu_hpref_la_SOURCES = hpref.c
>> +liburcu_hpref_la_LIBADD = -lrseq
>> +
>>   pkgconfigdir = $(libdir)/pkgconfig
>>   pkgconfig_DATA = liburcu-cds.pc liburcu.pc liburcu-bp.pc 
>> liburcu-qsbr.pc \
>>       liburcu-mb.pc liburcu-memb.pc
>> diff --git a/src/hpref.c b/src/hpref.c
>> new file mode 100644
>> index 00000000..f63530f5
>> --- /dev/null
>> +++ b/src/hpref.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers 
>> <mathieu.desnoyers@efficios.com>
>> +//
>> +// SPDX-License-Identifier: LGPL-2.1-or-later
>> +
>> +/*
>> + * HPREF: Hazard pointers with reference counters
>> + */
>> +
>> +#define _LGPL_SOURCE
>> +#include <urcu/hpref.h>
>> +#include <rseq/mempool.h>    /* Per-CPU memory */
>> +
>> +static struct rseq_mempool *mempool;
>> +struct hpref_percpu_slots *hpref_percpu_slots;
>> +
>> +void hpref_release(struct urcu_ref *ref)
>> +{
>> +    struct hpref_node *node = caa_container_of(ref, struct 
>> hpref_node, refcount);
>> +
>> +    node->release(node);
>> +}
>> +
>> +/*
>> + * hpref_synchronize: Wait for any reader possessing a hazard pointer to
>> + *                    @node to clear its hazard pointer slot.
>> + */
>> +void hpref_synchronize(struct hpref_node *node)
>> +{
>> +    int nr_cpus = rseq_get_max_nr_cpus(), cpu;
>> +
>> +    /* Memory ordering: Store A before Load B. */
>> +    cmm_smp_mb();
>> +    /* Scan all CPUs slots. */
>> +    for (cpu = 0; cpu < nr_cpus; cpu++) {
>> +        struct hpref_percpu_slots *cpu_slots = 
>> rseq_percpu_ptr(hpref_percpu_slots, cpu);
>> +        struct hpref_slot *slot;
>> +        unsigned int i;
>> +
>> +        for (i = 0; i < HPREF_NR_PERCPU_SLOTS; i++) {
>> +            slot = &cpu_slots->slots[i];
>> +            /* Busy-wait if node is found. */
>> +            while (uatomic_load(&slot->node, CMM_ACQUIRE) == node)    
>> /* Load B */
>> +                caa_cpu_relax();
>> +        }
>> +    }
>> +}
>> +
>> +/*
>> + * hpref_synchronize_put: Wait for any reader possessing a hazard
>> + *                        pointer to clear its slot and put reference
>> + *                        count.
>> + */
>> +void hpref_synchronize_put(struct hpref_node *node)
>> +{
>> +    if (!node)
>> +        return;
>> +    hpref_synchronize(node);
>> +    urcu_ref_put(&node->refcount, hpref_release);
>> +}
>> +
>> +static __attribute__((constructor))
>> +void hpref_init(void)
>> +{
>> +    mempool = rseq_mempool_create("hpref", sizeof(struct 
>> hpref_percpu_slots), NULL);
>> +    if (!mempool)
>> +        abort();
>> +    hpref_percpu_slots = rseq_mempool_percpu_zmalloc(mempool);
>> +    if (!hpref_percpu_slots)
>> +        abort();
>> +}
>> +
>> +static __attribute__((destructor))
>> +void hpref_exit(void)
>> +{
>> +    rseq_mempool_percpu_free(hpref_percpu_slots);
>> +    if (rseq_mempool_destroy(mempool))
>> +        abort();
>> +}
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

