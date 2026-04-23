Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693135F61E
	for <rcu@vger.kernel.org>; Thu, 23 Apr 2026 04:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918208; cv=none; b=g27gC1M0bqHLYJfiP4g/tQoNCGnyihjXIoxCBgyiMrFNDfkYu9VB58h7rVgplZ1PsV4ZxlzNr09qya5YylUxmnXJF5uKDmHLl8BrmsTZKnX3mavbyUdKCQVox4YfCxOHoFBrV+Yc9Y7DwGnVfDSbla1LcmPcKT/upAAligldxtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918208; c=relaxed/simple;
	bh=3dx4IJ1963MF+w6Alh++CaLyrT79SqePimzXb2u1qcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E17NnGCQJ8NIaFsodHrxnTkjN8GAVH6QvbzVPLkP7/2ylVquznW1kLzkmtNwfuR3P9wx0A0oXXQY4fBaDSBce5rEt57px9nMijjLMXVuAyXwB0Q1e09J9wm2nbeSZ8RM8zRkMFLIaLQ40gVyY3vQl8WwvVDaedtqmCohm+NmU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3l3ahf1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3l3ahf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64A4C2BCB2;
	Thu, 23 Apr 2026 04:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918207;
	bh=3dx4IJ1963MF+w6Alh++CaLyrT79SqePimzXb2u1qcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J3l3ahf1womxl9bIGgo6XfxMmK2aNsdFtOQqeV4idQg0x2HPg+ZZNnyOpmPAo5j02
	 yW9yuKuKjj79YdizT4NEIYPrZS+i10UO9dxn6XEy3ra57e+muo5HX+E2C95x979urP
	 PIi7YVKo1NoOMNR2zxDxHdUk6o+zGxsuw2tfOVWp/6AxrW3hv6VNVaaRkAwQirycJl
	 ifA70tf9cdzJfLiW/h/BGrvonyvLJUa1KVGrmfRiXx53Bqur/rwRS5MAVWy870WdeX
	 7TrwBomvib3VWWyqVplNGo8filVr01xx9WYujusZlXKOG9csErPzO7sOFuwXBWQui9
	 3lEzCzJPrp76w==
Date: Thu, 23 Apr 2026 13:23:25 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
Message-ID: <aemevSofweaUSx0n@hyeyoo>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
 <aejeVK0J_jHSfVhD@milan>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aejeVK0J_jHSfVhD@milan>

On Wed, Apr 22, 2026 at 04:42:28PM +0200, Uladzislau Rezki wrote:
> I think a better option is to add a separate kvfree_rcu_nmi() helper,
> or similar, and avoid complicating the generic implementation. Otherwise,
> the common path risks becoming harder to maintain.
> 
> Below is a simple implementation.

I'm happy to keep things simple as long as that doesn't mean
compromising performance.

We can discuss that.

> <patch>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index d5a70a831a2a..f6ae3795ec6c 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1402,6 +1402,14 @@ struct kfree_rcu_cpu {
>  
>  	struct llist_head bkvcache;
>  	int nr_bkv_objs;
> +
> +	/* For NMI context. */

I think "unknown context" is a better term since it includes
NMI context as well as other contexts.
(I'm also slightly moving towards the term, :D)

> +	struct llist_head drain_list;
> +	struct llist_node *pending_list;
> +
> +	struct rcu_work drain_rcu_work;
> +	struct irq_work drain_irqwork;
> +	atomic_t drain_in_progress;
>  };

[... changing the order of functions a little bit to help review ...]

>  static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> @@ -1926,6 +1934,69 @@ void __init kfree_rcu_scheduler_running(void)
>  	}
>  }
> +
> +/*
> + * Queue a request for lazy invocation.
> + * Context: For NMI contexts or unknown contexts only.
> + */
> +void
> +kvfree_call_rcu_nolock(struct rcu_head *head, void *ptr)
> +{
> +	struct kfree_rcu_cpu *krcp = this_cpu_ptr(&krc);
> +
> +	head->func = ptr;
> +	llist_add((struct llist_node *) head, &krcp->drain_list);
> +

So it inserts objects to the list,

> +	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING) {
> +		/* Only first(and only one) user rings the bell. */
> +		if (!atomic_cmpxchg(&krcp->drain_in_progress, 0, 1))
> +			irq_work_queue(&krcp->drain_irqwork);

and only the task that succeeds cmpxchg queues the IRQ work.
The IRQ work queues an RCU work which iterates over the
list of objects and frees them.

Draining will be performed a little bit more frequently
(every call_rcu_hurry() + work queue delay) compared to the ordinary
kvfree_rcu path (every 1-5 seconds)

The question is how frequent is too frequent, when it comes to
additional IRQ/RCU work invocations affecting performance.

> +static void
> +kvfree_rcu_nolock_irqwork(struct irq_work *irqwork)
> +{
> +	struct kfree_rcu_cpu *krcp =
> +		container_of(irqwork, struct kfree_rcu_cpu, drain_irqwork); > +	bool queued;
> +
> +	krcp->pending_list = llist_del_all(&krcp->drain_list);
> +	ASSERT_EXCLUSIVE_WRITER(krcp->pending_list);
> +	queued = queue_rcu_work(rcu_reclaim_wq, &krcp->drain_rcu_work);
> +	WARN_ON_ONCE(!queued);
> +}
>
> +static void
> +kvfree_rcu_nolock_work(struct work_struct *work)
> +{
> +	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
> +		struct kfree_rcu_cpu, drain_rcu_work);
> +	struct llist_node *pos, *n, *pending;
> +	bool queued;
> +
> +	pending = krcp->pending_list;
> +	krcp->pending_list = NULL;
> +	ASSERT_EXCLUSIVE_WRITER(krcp->pending_list);
> +
> +	llist_for_each_safe(pos, n, pending) {
> +		struct rcu_head *rcu = (struct rcu_head *) pos;
> +		void *ptr = (void *) rcu->func;
> +		kvfree(ptr);
> +	}

This is pretty similar to what a kvfree_rcu(two_arg) call does
in the slowpath (kvfree_rcu_list), except that we don't maintain
RCU state explicitly.

How much performance do we sacrifice compared to
letting them go through the kvfree_rcu() fastpath?

> +	atomic_set(&krcp->drain_in_progress, 0);
> +	if (!llist_empty(&krcp->drain_list)) {
> +		if (!atomic_cmpxchg(&krcp->drain_in_progress, 0, 1)) {
> +			krcp->pending_list = llist_del_all(&krcp->drain_list);
> +			ASSERT_EXCLUSIVE_WRITER(krcp->pending_list);
> +			queued = queue_rcu_work(rcu_reclaim_wq, &krcp->drain_rcu_work);
> +			WARN_ON_ONCE(!queued);
> +		}
> +	}
> +}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(kvfree_call_rcu_nolock);
> +
>  /*
>   * Queue a request for lazy invocation of the appropriate free routine
>   * after a grace period.  Please note that three paths are maintained,

-- 
Cheers,
Harry / Hyeonggon
