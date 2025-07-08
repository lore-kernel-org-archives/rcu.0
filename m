Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74B62980DA;
	Tue,  8 Jul 2025 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959277; cv=none; b=ECMInt1QqyDSoTwsiKgLvLOSJYsxG/JLxXHThrtKkT8iRb5XVF3AjNIe1B8erJR0GTFrbrR9FfaWxUVW1oW7sjOHShBcjfSL5HWRQRJPLvy4yVXaua2T+g6CD9f/xlqqnFpb9ZR4Uju/NViw++se2N4gh2w8sUVsAluNq0r1EXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959277; c=relaxed/simple;
	bh=UHCOYHNPoZf25UtXIMPCDpCcmsRruYyj8nmPoMUh2BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoA5pLdMHsz96/kwaju3ZhPpZ4IwJDO4wx2VUUvKt0Y2rpgNpr18wybv8u13LOigHYX8yjCFg8otaX98PeeocK2LCVxj2dO9DLeKzFRtmx2Ex6t+k4vMCorpfBhNqrAI/c6NqasTmd45aKEbSqVm3BhemojU65OtCentAl9s04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ex2GEMu2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ex2GEMu2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hyNk8T+NIRKoZL/bKe0KxXnT09IJXMM64RdILDI3WnI=; b=Ex2GEMu28ml8x7dI24mLBD9ZHb
	QYqiRwz9MtfI62Fx23jOi9ZcjkVNrT0IICPW2qVC27kzzUr1cp4Zz/wJQPVuR/BNxEyjaa1uMhxmp
	jLrGYj+XXrhFW0a/Q6ZYoBDYuRmNAIIrvI6zP5zGIXTYgd0TE93niK/iBNXwHtM5Rkc1Mh/8unQNl
	8U1d6KvJt98R4Eis448MmOftdGgCUKxc8bI/GuA9RPmBlsoTWMGRFGxe4xHpHNFUNl6m5FOYcjYE8
	Nw1Gp1NXIHJEaXaz5qtr3TQHG0NRwiPxuZJoqzB8f+mRYRTf55YfDMEwZgrIhw7Wvetha/+qByxy4
	DZzjpI7A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ2dd-00000008hhn-2Tc5;
	Tue, 08 Jul 2025 07:21:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 153BC30065D; Tue, 08 Jul 2025 09:21:12 +0200 (CEST)
Date: Tue, 8 Jul 2025 09:21:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Andrea Righi <arighi@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] smp: Document preemption and stop_machine() mutual
 exclusion
Message-ID: <20250708072112.GA1613376@noisy.programming.kicks-ass.net>
References: <20250705172328.4114289-1-joelagnelf@nvidia.com>
 <20250707075050.GB1613200@noisy.programming.kicks-ass.net>
 <20250707141952.GA3640857@joelbox2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707141952.GA3640857@joelbox2>

On Mon, Jul 07, 2025 at 10:19:52AM -0400, Joel Fernandes wrote:

> From: Joel Fernandes <joelagnelf@nvidia.com>
> Subject: [PATCH] smp: Document preemption and stop_machine() mutual exclusion
> 
> Recently while revising RCU's cpu online checks, there was some discussion
> around how IPIs synchronize with hotplug.
> 
> Add comments explaining how preemption disable creates mutual exclusion with
> CPU hotplug's stop_machine mechanism. The key insight is that stop_machine()
> atomically updates CPU masks and flushes IPIs with interrupts disabled, and
> cannot proceed while any CPU (including the IPI sender) has preemption
> disabled.
> 
> Cc: Andrea Righi <arighi@nvidia.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: rcu@vger.kernel.org
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
> I am leaving in Paul's Ack but Paul please let me know if there is a concern!
> 
>  kernel/smp.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 974f3a3962e8..957959031063 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -93,6 +93,9 @@ int smpcfd_dying_cpu(unsigned int cpu)
>  	 * explicitly (without waiting for the IPIs to arrive), to
>  	 * ensure that the outgoing CPU doesn't go offline with work
>  	 * still pending.
> +	 *
> +	 * This runs with interrupts disabled inside the stopper task invoked
> +	 * by stop_machine(), ensuring CPU offlining and IPI flushing are atomic.

So below you use 'mutual exclusion', which I prefer over 'atomic' as
used here.

>  	 */
>  	__flush_smp_call_function_queue(false);
>  	irq_work_run();
> @@ -418,6 +421,10 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
>   */
>  static int generic_exec_single(int cpu, call_single_data_t *csd)
>  {
> +	/*
> +	 * Preemption already disabled here so stopper cannot run on this CPU,
> +	 * ensuring mutual exclusion with CPU offlining and last IPI flush.
> +	 */
>  	if (cpu == smp_processor_id()) {
>  		smp_call_func_t func = csd->func;
>  		void *info = csd->info;
> @@ -638,8 +645,10 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
>  	int err;
>  
>  	/*
> -	 * prevent preemption and reschedule on another processor,
> -	 * as well as CPU removal
> +	 * Prevent preemption and reschedule on another processor, as well as
> +	 * CPU removal.

>          Also preempt_disable() prevents stopper from running on
> +	 * this CPU, thus providing atomicity between the cpu_online() check
> +	 * and IPI sending ensuring IPI is not missed by CPU going offline.

That first sentence already covers this, no? 'prevents preemption' ->
stopper task cannot run, 'CPU removal' -> no CPU_DYING (because no
stopper). Also that 'atomicy' vs 'mutual exclusion' thing.


>  	 */
>  	this_cpu = get_cpu();
>  
> -- 
> 2.34.1
> 
