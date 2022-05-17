Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4553C433F5
	for <rcu@archiver.kernel.org>; Tue, 17 May 2022 09:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiEQJKT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 May 2022 05:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244383AbiEQJKB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 May 2022 05:10:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CA621828
        for <rcu@vger.kernel.org>; Tue, 17 May 2022 02:07:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f4so17344608lfu.12
        for <rcu@vger.kernel.org>; Tue, 17 May 2022 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kaTYXWB1t3Xe2cNGIQTBcsKHVsxqeCMXqLuAYp8CCzw=;
        b=KPuxZlkbiOS63r7Zog6XXRF4ai/IYKrT48D5aEJ85Vfl+vCKMJG1Wb/vpNnz869JCr
         q6Idzx0JnN/CLIo4UdGYyXnuRNqSL+xpSEd6TqhSDmHNiPPdh7KtcEh36Yx4udCrBN6o
         4ihEunBK/4hj/acjHX0WbSdA29A1wQrtJp7/VA1ZOi6fw+/1c8axhS/GKnR35Xi91I6v
         gBhb4mGRaAb+ElvdmJfoD0MbbocEN26bnKMHpPSONSRsJH7sGGjPK/84FtTbEuEI9hVl
         3ayQsH9//Xz21/7nkr6odav9Cg8juqkdWAt7UaoW86CVcyp8Ao+2BSi90pvgJOR0aWmK
         7Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kaTYXWB1t3Xe2cNGIQTBcsKHVsxqeCMXqLuAYp8CCzw=;
        b=FVpxs5jRS5S5ESdynTy/+wMZ68UqzJ82sRpwezcRfkSq3Gy0ZUfXH54bydD/iJLxKf
         Kj2QFRsL3eh3Ty6fh5uUKuF4hwtrbVEAQw+azNxb9R9EKetD91kdeLifjxTvcMedXqER
         JVY55ADWOeOuld7aMvdewpc0k3mbgu7fHDNnsu92xey3pTzL9n85Zsx8Ed1mlge44Tm8
         S9LKFIv7q0t9/1jyuWgAd5ExMtk02G9nzWeBt1IK7rs8+rC2MQ7KsOlFeEsCw84VdFjV
         DDsb69TAVtXc2lBUA7vE8g2d+1hFV77EEhE61y1uhSMCIYHD9rpik4LCcd5yrpQP/qSX
         MjOw==
X-Gm-Message-State: AOAM532zjlgyC++08JrV2zs3WAz6Ul5WRXF8RjoiY51ftQLtpJxqsfxY
        43NN0uQ7ks1Bdwvk8BZNk2A=
X-Google-Smtp-Source: ABdhPJwWG4LjGf8hN6Ayv7G3d0fgKTrmjr1iZWI8n/8zCk/vA2LCdBX7UPghMKhBXz28Y+rIbDHoTQ==
X-Received: by 2002:ac2:5601:0:b0:472:11a6:8287 with SMTP id v1-20020ac25601000000b0047211a68287mr16030264lfd.440.1652778464488;
        Tue, 17 May 2022 02:07:44 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id q4-20020a056512210400b0047255d21140sm1528745lfr.111.2022.05.17.02.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 02:07:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 17 May 2022 11:07:42 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Message-ID: <YoNl3o+JvDas5xxF@pc638.lan>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512030442.2530552-2-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Some extra but not overlapping comments with already mentioned in this
email thread:

> Implement timer-based RCU callback batching. The batch is flushed
> whenever a certain amount of time has passed, or the batch on a
> particular CPU grows too big. Also memory pressure can flush it.
> 
> Locking is avoided to reduce lock contention when queuing and dequeuing
> happens on different CPUs of a per-cpu list, such as when shrinker
> context is running on different CPU. Also not having to use locks keeps
> the per-CPU structure size small.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/rcupdate.h |   6 ++
>  kernel/rcu/Kconfig       |   8 +++
>  kernel/rcu/Makefile      |   1 +
>  kernel/rcu/lazy.c        | 145 +++++++++++++++++++++++++++++++++++++++
>  kernel/rcu/rcu.h         |   5 ++
>  kernel/rcu/tree.c        |   2 +
>  6 files changed, 167 insertions(+)
>  create mode 100644 kernel/rcu/lazy.c
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 88b42eb46406..d0a6c4f5172c 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -82,6 +82,12 @@ static inline int rcu_preempt_depth(void)
>  
>  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>  
> +#ifdef CONFIG_RCU_LAZY
> +void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func);
> +#else
> +#define call_rcu_lazy(head, func) call_rcu(head, func)
> +#endif
> +
>  /* Internal to kernel */
>  void rcu_init(void);
>  extern int rcu_scheduler_active __read_mostly;
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index bf8e341e75b4..c09715079829 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -241,4 +241,12 @@ config TASKS_TRACE_RCU_READ_MB
>  	  Say N here if you hate read-side memory barriers.
>  	  Take the default if you are unsure.
>  
> +config RCU_LAZY
> +	bool "RCU callback lazy invocation functionality"
> +	depends on RCU_NOCB_CPU
> +	default y
> +	help
> +	  To save power, batch RCU callbacks and flush after delay, memory
> +          pressure or callback list growing too big.
> +
>  endmenu # "RCU Subsystem"
> diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
> index 0cfb009a99b9..8968b330d6e0 100644
> --- a/kernel/rcu/Makefile
> +++ b/kernel/rcu/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_RCU_REF_SCALE_TEST) += refscale.o
>  obj-$(CONFIG_TREE_RCU) += tree.o
>  obj-$(CONFIG_TINY_RCU) += tiny.o
>  obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
> +obj-$(CONFIG_RCU_LAZY) += lazy.o
> diff --git a/kernel/rcu/lazy.c b/kernel/rcu/lazy.c
> new file mode 100644
> index 000000000000..55e406cfc528
> --- /dev/null
> +++ b/kernel/rcu/lazy.c
> @@ -0,0 +1,145 @@
> +/*
> + * Lockless lazy-RCU implementation.
> + */
> +#include <linux/rcupdate.h>
> +#include <linux/shrinker.h>
> +#include <linux/workqueue.h>
> +#include "rcu.h"
> +
> +// How much to batch before flushing?
> +#define MAX_LAZY_BATCH		2048
> +
> +// How much to wait before flushing?
> +#define MAX_LAZY_JIFFIES	10000
> +
> +// We cast lazy_rcu_head to rcu_head and back. This keeps the API simple while
> +// allowing us to use lockless list node in the head. Also, we use BUILD_BUG_ON
> +// later to ensure that rcu_head and lazy_rcu_head are of the same size.
> +struct lazy_rcu_head {
> +	struct llist_node llist_node;
> +	void (*func)(struct callback_head *head);
> +} __attribute__((aligned(sizeof(void *))));
> +
> +struct rcu_lazy_pcp {
> +	struct llist_head head;
> +	struct delayed_work work;
> +	atomic_t count;
> +};
> +DEFINE_PER_CPU(struct rcu_lazy_pcp, rcu_lazy_pcp_ins);
> +
> +// Lockless flush of CPU, can be called concurrently.
> +static void lazy_rcu_flush_cpu(struct rcu_lazy_pcp *rlp)
> +{
> +	struct llist_node *node = llist_del_all(&rlp->head);
> +	struct lazy_rcu_head *cursor, *temp;
> +
> +	if (!node)
> +		return;
> +
> +	llist_for_each_entry_safe(cursor, temp, node, llist_node) {
> +		struct rcu_head *rh = (struct rcu_head *)cursor;
> +		debug_rcu_head_unqueue(rh);
> +		call_rcu(rh, rh->func);
> +		atomic_dec(&rlp->count);
> +	}
> +}
> +
> +void call_rcu_lazy(struct rcu_head *head_rcu, rcu_callback_t func)
> +{
> +	struct lazy_rcu_head *head = (struct lazy_rcu_head *)head_rcu;
> +	struct rcu_lazy_pcp *rlp;
> +
> +	preempt_disable();
> +        rlp = this_cpu_ptr(&rcu_lazy_pcp_ins);
> +	preempt_enable();
>
Can we get rid of such explicit disabling/enabling preemption?

> +
> +	if (debug_rcu_head_queue((void *)head)) {
> +		// Probable double call_rcu(), just leak.
> +		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> +				__func__, head);
> +
> +		// Mark as success and leave.
> +		return;
> +	}
> +
> +	// Queue to per-cpu llist
> +	head->func = func;
> +	llist_add(&head->llist_node, &rlp->head);
> +
> +	// Flush queue if too big
> +	if (atomic_inc_return(&rlp->count) >= MAX_LAZY_BATCH) {
> +		lazy_rcu_flush_cpu(rlp);
>
Can we just schedule the work instead of drawn from the caller context?
For example it can be a hard-irq context.

> +	} else {
> +		if (!delayed_work_pending(&rlp->work)) {
> +			schedule_delayed_work(&rlp->work, MAX_LAZY_JIFFIES);
> +		}
> +	}
> +}
EXPORT_SYMBOL_GPL()? to be able to use in kernel modules.

> +
> +static unsigned long
> +lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> +{
> +	unsigned long count = 0;
> +	int cpu;
> +
> +	/* Snapshot count of all CPUs */
> +	for_each_possible_cpu(cpu) {
> +		struct rcu_lazy_pcp *rlp = per_cpu_ptr(&rcu_lazy_pcp_ins, cpu);
> +
> +		count += atomic_read(&rlp->count);
> +	}
> +
> +	return count;
> +}
> +
> +static unsigned long
> +lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> +{
> +	int cpu, freed = 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct rcu_lazy_pcp *rlp = per_cpu_ptr(&rcu_lazy_pcp_ins, cpu);
> +		unsigned long count;
> +
> +		count = atomic_read(&rlp->count);
> +		lazy_rcu_flush_cpu(rlp);
> +		sc->nr_to_scan -= count;
> +		freed += count;
> +		if (sc->nr_to_scan <= 0)
> +			break;
> +	}
> +
> +	return freed == 0 ? SHRINK_STOP : freed;
> +}
> +
> +/*
> + * This function is invoked after MAX_LAZY_JIFFIES timeout.
> + */
> +static void lazy_work(struct work_struct *work)
> +{
> +	struct rcu_lazy_pcp *rlp = container_of(work, struct rcu_lazy_pcp, work.work);
> +
> +	lazy_rcu_flush_cpu(rlp);
> +}
> +
> +static struct shrinker lazy_rcu_shrinker = {
> +	.count_objects = lazy_rcu_shrink_count,
> +	.scan_objects = lazy_rcu_shrink_scan,
> +	.batch = 0,
> +	.seeks = DEFAULT_SEEKS,
> +};
> +
> +void __init rcu_lazy_init(void)
> +{
> +	int cpu;
> +
> +	BUILD_BUG_ON(sizeof(struct lazy_rcu_head) != sizeof(struct rcu_head));
> +
> +	for_each_possible_cpu(cpu) {
> +		struct rcu_lazy_pcp *rlp = per_cpu_ptr(&rcu_lazy_pcp_ins, cpu);
> +		INIT_DELAYED_WORK(&rlp->work, lazy_work);
> +	}
> +
> +	if (register_shrinker(&lazy_rcu_shrinker))
> +		pr_err("Failed to register lazy_rcu shrinker!\n");
> +}
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 24b5f2c2de87..a5f4b44f395f 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -561,4 +561,9 @@ void show_rcu_tasks_trace_gp_kthread(void);
>  static inline void show_rcu_tasks_trace_gp_kthread(void) {}
>  #endif
>  
> +#ifdef CONFIG_RCU_LAZY
> +void rcu_lazy_init(void);
> +#else
> +static inline void rcu_lazy_init(void) {}
> +#endif
>  #endif /* __LINUX_RCU_H */
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a4c25a6283b0..ebdf6f7c9023 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4775,6 +4775,8 @@ void __init rcu_init(void)
>  		qovld_calc = DEFAULT_RCU_QOVLD_MULT * qhimark;
>  	else
>  		qovld_calc = qovld;
> +
> +	rcu_lazy_init();
>  }
>  
>  #include "tree_stall.h"
> -- 
> 2.36.0.550.gb090851708-goog
> 
