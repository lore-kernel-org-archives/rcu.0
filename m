Return-Path: <SRS0=eHFP=4M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A383FC35671
	for <rcu@archiver.kernel.org>; Mon, 24 Feb 2020 11:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650962072D
	for <rcu@archiver.kernel.org>; Mon, 24 Feb 2020 11:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvm6sgg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgBXLp6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:45:58 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:32956 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgBXLp5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 Feb 2020 06:45:57 -0500
Received: by mail-qv1-f65.google.com with SMTP id ek2so4013457qvb.0;
        Mon, 24 Feb 2020 03:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=douxAEkK6BgAwJDpbpeewaOaL5uLGiIahJTWDXODF8k=;
        b=nvm6sgg/P1gDejbOFNA3rj23FXdLgAYxO49x6Solfi1hOmAN5DFbBRti4VxvvdoF3R
         croib9jV2Hkg3B00QKVsRnBhkWFDzZFD1c7ypa3gbgVTxTAFyPiDtOEtBSj/mhNkQl1P
         d88XAB+6yBVGK/fG4SFlRMa8IGWCMkPzVwz02iUpowHdrBdT8BbA0zly4yxUbyzLXaJo
         X7uFud3Q2r7g79rUdzDvBtNuVNEwVcH3Lqno5llQJVrlBykJ37z8syeUALhNHnuU14ii
         Vrt3bQHMLxjli9V5soGidVnoYwHkgd6yjZkM0tWsf2Wz/dOGhuo0FE9kgjJpjqiBHLdD
         lceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=douxAEkK6BgAwJDpbpeewaOaL5uLGiIahJTWDXODF8k=;
        b=SIG0pbjNLip1mcrdR8vJIfgOgHaUzUgDVkH1+nYJyvMW+D77Tm4jVJGN0sjBmXEDSs
         4YxUV4LQTXPPUOoIx5jDs1DxO6HNrPkCmUfgVVYn0IvuG5P7RXsZTrPfg8iwWZQV4Q93
         MXaolc+eTlw4784oJdrn35iSdH3VromCFp5Kp+N7fWb797XA9GmyZtVX/aeIBAAYotUf
         lNxbygQnVnrmYe/wtPrVznlgwxvboV1VPGR1PrIHgqO1XFDA7in+iGS+awchHGnbfqWG
         DtHVhyM5LBxfN72vV04VBuiJiT+MF8y8rkWI189IsmtcA3mxOLjz9vSYApNN74cUNdEq
         z51Q==
X-Gm-Message-State: APjAAAXdhMyjSBGnSTq3fiVyFBF6PU4l7hyhy0VArJSYFmRBN8aOqnVp
        Ka80c1ocXTVTYrWHSo5w/5Q=
X-Google-Smtp-Source: APXvYqzVsGd2kvMCRZgprzzU0peIMbOowtBCz61TdeSMM6fVbm5calARIsmjL6C4h/8MWeTbevVC9A==
X-Received: by 2002:ad4:5421:: with SMTP id g1mr42606827qvt.57.1582544756451;
        Mon, 24 Feb 2020 03:45:56 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c204sm798357qke.2.2020.02.24.03.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 03:45:55 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 01C4F21AD2;
        Mon, 24 Feb 2020 06:45:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 24 Feb 2020 06:45:55 -0500
X-ME-Sender: <xms:cbdTXijsrHKFNJohHqWQo1_CTe8EHHfP9QWeZuBazmuItwDt67n4Xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:cbdTXu37zqMnDoKnjKpbF9C2sTQp1qCarlMAzB9mkkYhzLTjSoeAcQ>
    <xmx:cbdTXhZg0bTZky2JvPsE0QboNOlNkkiWQ3HLHQHTWMYIWaW8HHPKew>
    <xmx:cbdTXuiQTL-ubQU8rPmFBS13M77M__uYuA-sZiOgyNPESOJvqF90Cw>
    <xmx:crdTXvetUJflDtx5mAomevvZeKi2Zf-4fyJq3jwdJ2XJkwxI_oWuLx5GD-w>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5EC643060BD1;
        Mon, 24 Feb 2020 06:45:53 -0500 (EST)
Date:   Mon, 24 Feb 2020 19:45:51 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 1/2] rcu: Support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200224114551.GE110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200215000031.GA14315@paulmck-ThinkPad-P72>
 <20200215000053.14456-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215000053.14456-1-paulmck@kernel.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On Fri, Feb 14, 2020 at 04:00:52PM -0800, paulmck@kernel.org wrote:
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> 
> The kfree_rcu() logic can be improved further by using kfree_bulk()
> interface along with "basic batching support" introduced earlier.
> 
> The are at least two advantages of using "bulk" interface:
> - in case of large number of kfree_rcu() requests kfree_bulk()
>   reduces the per-object overhead caused by calling kfree()
>   per-object.
> 
> - reduces the number of cache-misses due to "pointer chasing"
>   between objects which can be far spread between each other.
> 
> This approach defines a new kfree_rcu_bulk_data structure that
> stores pointers in an array with a specific size. Number of entries
> in that array depends on PAGE_SIZE making kfree_rcu_bulk_data
> structure to be exactly one page.
> 
> Since it deals with "block-chain" technique there is an extra
> need in dynamic allocation when a new block is required. Memory
> is allocated with GFP_NOWAIT | __GFP_NOWARN flags, i.e. that
> allows to skip direct reclaim under low memory condition to
> prevent stalling and fails silently under high memory pressure.
> 
> The "emergency path" gets maintained when a system is run out of
> memory. In that case objects are linked into regular list.
> 
> The "rcuperf" was run to analyze this change in terms of memory
> consumption and kfree_bulk() throughput.
> 
> 1) Testing on the Intel(R) Xeon(R) W-2135 CPU @ 3.70GHz, 12xCPUs
> with following parameters:
> 
> kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1 kfree_vary_obj_size=1
> dev.2020.01.10a branch
> 
> Default / CONFIG_SLAB
> 53607352517 ns, loops: 200000, batches: 1885, memory footprint: 1248MB
> 53529637912 ns, loops: 200000, batches: 1921, memory footprint: 1193MB
> 53570175705 ns, loops: 200000, batches: 1929, memory footprint: 1250MB
> 
> Patch / CONFIG_SLAB
> 23981587315 ns, loops: 200000, batches: 810, memory footprint: 1219MB
> 23879375281 ns, loops: 200000, batches: 822, memory footprint: 1190MB
> 24086841707 ns, loops: 200000, batches: 794, memory footprint: 1380MB
> 
> Default / CONFIG_SLUB
> 51291025022 ns, loops: 200000, batches: 1713, memory footprint: 741MB
> 51278911477 ns, loops: 200000, batches: 1671, memory footprint: 719MB
> 51256183045 ns, loops: 200000, batches: 1719, memory footprint: 647MB
> 
> Patch / CONFIG_SLUB
> 50709919132 ns, loops: 200000, batches: 1618, memory footprint: 456MB
> 50736297452 ns, loops: 200000, batches: 1633, memory footprint: 507MB
> 50660403893 ns, loops: 200000, batches: 1628, memory footprint: 429MB
> 
> in case of CONFIG_SLAB there is double increase in performance and
> slightly higher memory usage. As for CONFIG_SLUB, the performance
> figures are better together with lower memory usage.
> 
> 2) Testing on the HiKey-960, arm64, 8xCPUs with below parameters:
> 
> CONFIG_SLAB=y
> kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1
> 
> 102898760401 ns, loops: 200000, batches: 5822, memory footprint: 158MB
> 89947009882  ns, loops: 200000, batches: 6715, memory footprint: 115MB
> 
> rcuperf shows approximately ~12% better throughput in case of
> using "bulk" interface. The "drain logic" or its RCU callback
> does the work faster that leads to better throughput.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree.c | 204 ++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 169 insertions(+), 35 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d91c915..51a3aa8 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2689,22 +2689,47 @@ EXPORT_SYMBOL_GPL(call_rcu);
>  #define KFREE_DRAIN_JIFFIES (HZ / 50)
>  #define KFREE_N_BATCHES 2
>  
> +/*
> + * This macro defines how many entries the "records" array
> + * will contain. It is based on the fact that the size of
> + * kfree_rcu_bulk_data structure becomes exactly one page.
> + */
> +#define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 3)
> +

Why use the "magic" number "3" here? Could we just define struct
kfree_rcu_bulk_data as:

struct kfree_rcu_bulk_data {
	struct kfree_rcu_bulk_data *next;
	struct rcu_head *head_free_debug;
	unsigned long nr_records;
	void *records[];
}

?

And the the above macro becomes:

#define KFREE_BULK_MAX_ENTR ((PAGE_SIZE - sizeof(struct kfree_rcu_bulk_data)) / sizeof(void *))

Regards,
Boqun

> +/**
> + * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
> + * @nr_records: Number of active pointers in the array
> + * @records: Array of the kfree_rcu() pointers
> + * @next: Next bulk object in the block chain
> + * @head_free_debug: For debug, when CONFIG_DEBUG_OBJECTS_RCU_HEAD is set
> + */
> +struct kfree_rcu_bulk_data {
> +	unsigned long nr_records;
> +	void *records[KFREE_BULK_MAX_ENTR];
> +	struct kfree_rcu_bulk_data *next;
> +	struct rcu_head *head_free_debug;
> +};
> +
>  /**
>   * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
>   * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
>   * @head_free: List of kfree_rcu() objects waiting for a grace period
> + * @bhead_free: Bulk-List of kfree_rcu() objects waiting for a grace period
>   * @krcp: Pointer to @kfree_rcu_cpu structure
>   */
>  
>  struct kfree_rcu_cpu_work {
>  	struct rcu_work rcu_work;
>  	struct rcu_head *head_free;
> +	struct kfree_rcu_bulk_data *bhead_free;
>  	struct kfree_rcu_cpu *krcp;
>  };
>  
>  /**
>   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
>   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> + * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
> + * @bcached: Keeps at most one object for later reuse when build chain blocks
>   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
>   * @lock: Synchronize access to this structure
>   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> @@ -2718,6 +2743,8 @@ struct kfree_rcu_cpu_work {
>   */
>  struct kfree_rcu_cpu {
>  	struct rcu_head *head;
> +	struct kfree_rcu_bulk_data *bhead;
> +	struct kfree_rcu_bulk_data *bcached;
>  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>  	spinlock_t lock;
>  	struct delayed_work monitor_work;
> @@ -2727,14 +2754,24 @@ struct kfree_rcu_cpu {
>  
>  static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
>  
> +static __always_inline void
> +debug_rcu_head_unqueue_bulk(struct rcu_head *head)
> +{
> +#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> +	for (; head; head = head->next)
> +		debug_rcu_head_unqueue(head);
> +#endif
> +}
> +
>  /*
>   * This function is invoked in workqueue context after a grace period.
> - * It frees all the objects queued on ->head_free.
> + * It frees all the objects queued on ->bhead_free or ->head_free.
>   */
>  static void kfree_rcu_work(struct work_struct *work)
>  {
>  	unsigned long flags;
>  	struct rcu_head *head, *next;
> +	struct kfree_rcu_bulk_data *bhead, *bnext;
>  	struct kfree_rcu_cpu *krcp;
>  	struct kfree_rcu_cpu_work *krwp;
>  
> @@ -2744,22 +2781,41 @@ static void kfree_rcu_work(struct work_struct *work)
>  	spin_lock_irqsave(&krcp->lock, flags);
>  	head = krwp->head_free;
>  	krwp->head_free = NULL;
> +	bhead = krwp->bhead_free;
> +	krwp->bhead_free = NULL;
>  	spin_unlock_irqrestore(&krcp->lock, flags);
>  
> -	// List "head" is now private, so traverse locklessly.
> +	/* "bhead" is now private, so traverse locklessly. */
> +	for (; bhead; bhead = bnext) {
> +		bnext = bhead->next;
> +
> +		debug_rcu_head_unqueue_bulk(bhead->head_free_debug);
> +
> +		rcu_lock_acquire(&rcu_callback_map);
> +		kfree_bulk(bhead->nr_records, bhead->records);
> +		rcu_lock_release(&rcu_callback_map);
> +
> +		if (cmpxchg(&krcp->bcached, NULL, bhead))
> +			free_page((unsigned long) bhead);
> +
> +		cond_resched_tasks_rcu_qs();
> +	}
> +
> +	/*
> +	 * Emergency case only. It can happen under low memory
> +	 * condition when an allocation gets failed, so the "bulk"
> +	 * path can not be temporary maintained.
> +	 */
>  	for (; head; head = next) {
>  		unsigned long offset = (unsigned long)head->func;
>  
>  		next = head->next;
> -		// Potentially optimize with kfree_bulk in future.
>  		debug_rcu_head_unqueue(head);
>  		rcu_lock_acquire(&rcu_callback_map);
>  		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
>  
> -		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset))) {
> -			/* Could be optimized with kfree_bulk() in future. */
> +		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
>  			kfree((void *)head - offset);
> -		}
>  
>  		rcu_lock_release(&rcu_callback_map);
>  		cond_resched_tasks_rcu_qs();
> @@ -2774,26 +2830,48 @@ static void kfree_rcu_work(struct work_struct *work)
>   */
>  static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>  {
> +	struct kfree_rcu_cpu_work *krwp;
> +	bool queued = false;
>  	int i;
> -	struct kfree_rcu_cpu_work *krwp = NULL;
>  
>  	lockdep_assert_held(&krcp->lock);
> -	for (i = 0; i < KFREE_N_BATCHES; i++)
> -		if (!krcp->krw_arr[i].head_free) {
> -			krwp = &(krcp->krw_arr[i]);
> -			break;
> -		}
>  
> -	// If a previous RCU batch is in progress, we cannot immediately
> -	// queue another one, so return false to tell caller to retry.
> -	if (!krwp)
> -		return false;
> +	for (i = 0; i < KFREE_N_BATCHES; i++) {
> +		krwp = &(krcp->krw_arr[i]);
>  
> -	krwp->head_free = krcp->head;
> -	krcp->head = NULL;
> -	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
> -	queue_rcu_work(system_wq, &krwp->rcu_work);
> -	return true;
> +		/*
> +		 * Try to detach bhead or head and attach it over any
> +		 * available corresponding free channel. It can be that
> +		 * a previous RCU batch is in progress, it means that
> +		 * immediately to queue another one is not possible so
> +		 * return false to tell caller to retry.
> +		 */
> +		if ((krcp->bhead && !krwp->bhead_free) ||
> +				(krcp->head && !krwp->head_free)) {
> +			/* Channel 1. */
> +			if (!krwp->bhead_free) {
> +				krwp->bhead_free = krcp->bhead;
> +				krcp->bhead = NULL;
> +			}
> +
> +			/* Channel 2. */
> +			if (!krwp->head_free) {
> +				krwp->head_free = krcp->head;
> +				krcp->head = NULL;
> +			}
> +
> +			/*
> +			 * One work is per one batch, so there are two "free channels",
> +			 * "bhead_free" and "head_free" the batch can handle. It can be
> +			 * that the work is in the pending state when two channels have
> +			 * been detached following each other, one by one.
> +			 */
> +			queue_rcu_work(system_wq, &krwp->rcu_work);
> +			queued = true;
> +		}
> +	}
> +
> +	return queued;
>  }
>  
>  static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> @@ -2830,19 +2908,65 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  		spin_unlock_irqrestore(&krcp->lock, flags);
>  }
>  
> +static inline bool
> +kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> +	struct rcu_head *head, rcu_callback_t func)
> +{
> +	struct kfree_rcu_bulk_data *bnode;
> +
> +	if (unlikely(!krcp->initialized))
> +		return false;
> +
> +	lockdep_assert_held(&krcp->lock);
> +
> +	/* Check if a new block is required. */
> +	if (!krcp->bhead ||
> +			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
> +		bnode = xchg(&krcp->bcached, NULL);
> +		if (!bnode) {
> +			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
> +
> +			bnode = (struct kfree_rcu_bulk_data *)
> +				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +		}
> +
> +		/* Switch to emergency path. */
> +		if (unlikely(!bnode))
> +			return false;
> +
> +		/* Initialize the new block. */
> +		bnode->nr_records = 0;
> +		bnode->next = krcp->bhead;
> +		bnode->head_free_debug = NULL;
> +
> +		/* Attach it to the head. */
> +		krcp->bhead = bnode;
> +	}
> +
> +#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> +	head->func = func;
> +	head->next = krcp->bhead->head_free_debug;
> +	krcp->bhead->head_free_debug = head;
> +#endif
> +
> +	/* Finally insert. */
> +	krcp->bhead->records[krcp->bhead->nr_records++] =
> +		(void *) head - (unsigned long) func;
> +
> +	return true;
> +}
> +
>  /*
> - * Queue a request for lazy invocation of kfree() after a grace period.
> + * Queue a request for lazy invocation of kfree_bulk()/kfree() after a grace
> + * period. Please note there are two paths are maintained, one is the main one
> + * that uses kfree_bulk() interface and second one is emergency one, that is
> + * used only when the main path can not be maintained temporary, due to memory
> + * pressure.
>   *
>   * Each kfree_call_rcu() request is added to a batch. The batch will be drained
> - * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch
> - * will be kfree'd in workqueue context. This allows us to:
> - *
> - * 1.	Batch requests together to reduce the number of grace periods during
> - *	heavy kfree_rcu() load.
> - *
> - * 2.	It makes it possible to use kfree_bulk() on a large number of
> - *	kfree_rcu() requests thus reducing cache misses and the per-object
> - *	overhead of kfree().
> + * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
> + * be free'd in workqueue context. This allows us to: batch requests together to
> + * reduce the number of grace periods during heavy kfree_rcu() load.
>   */
>  void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> @@ -2861,9 +2985,16 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  			  __func__, head);
>  		goto unlock_return;
>  	}
> -	head->func = func;
> -	head->next = krcp->head;
> -	krcp->head = head;
> +
> +	/*
> +	 * Under high memory pressure GFP_NOWAIT can fail,
> +	 * in that case the emergency path is maintained.
> +	 */
> +	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
> +		head->func = func;
> +		head->next = krcp->head;
> +		krcp->head = head;
> +	}
>  
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> @@ -3769,8 +3900,11 @@ static void __init kfree_rcu_batch_init(void)
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		spin_lock_init(&krcp->lock);
> -		for (i = 0; i < KFREE_N_BATCHES; i++)
> +		for (i = 0; i < KFREE_N_BATCHES; i++) {
> +			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>  			krcp->krw_arr[i].krcp = krcp;
> +		}
> +
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
>  		krcp->initialized = true;
>  	}
> -- 
> 2.9.5
> 
