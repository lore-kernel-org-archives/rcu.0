Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C492EE5FD;
	Fri,  6 Feb 2026 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770380669; cv=none; b=gZ97O/5m+YsT3LK99jrZWC+09UXfSR98nA3ch6mWPvlt04vrRdVZC06vILe6KdQnhxFp1n7/yQ2jhJ8y7Ob9i8kXWIrPRvnYgGd+jUkdF6HXZBdJjV+wiYynTTm7jcUINgmdzfGpQAYMAafu5dKAxcpGXyfj92RJnwmjxXR9BL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770380669; c=relaxed/simple;
	bh=rEj8825XpIjLqz10xvZxk8okcCuq9IEOjeV0yzx7rG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KN9K1yKh4wDds+SnLtSslx+mGCW7tcj5o9gBKSOWRGqfJSwivMdymSLTpRl359PKXbPiIAPUi5cKAiKt2AgdZBfhZHScknaSZLH5u9E60/5gsHFyz25vLcVt0kBjyAnrRg3aN38arsXQOWKwg1wZ4936ULuawO6WWAR+N8q3e8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW+q6pql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW+q6pql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9A1C116C6;
	Fri,  6 Feb 2026 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770380669;
	bh=rEj8825XpIjLqz10xvZxk8okcCuq9IEOjeV0yzx7rG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SW+q6pqlOtbtzBq78J3jdhFMf6Ph2Sc+gZOy2XrqSAb/JkBQ3uH3EkRsULTp4lrBB
	 rK/NElU/XWtGLGNrIGs9BFgubtLpmPtSCJDQxYjniONn1O11ChU3OoeDx2L85Ss929
	 NoANkYGsU8FlVkxnqA1SYr7H2yHfEuzbiqoENd8CtGI9KMXaeVivU2I9qFE6D9RwmW
	 7Owffc2vN0O7bPPv7Inz07gBrc2Tn6Ly91QmCO/vNOP4ptjYwoyqdmDNKWu4ssMtdd
	 IZEZcE2xeJPst/hiOOVd7+Yg/+VxFVJkhCryR5GhRxEy5A94YpJYD8qaNbmY4I9UOs
	 mXv8EZtgZreEw==
From: Thomas Gleixner <tglx@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan
 Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi
 Yan <ziy@nvidia.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo
 Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 Qiliang Yuan <realwujing@gmail.com>, Qiliang Yuan
 <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH RFC 03/12] genirq: Implement dynamic migration for
 Managed IRQs
In-Reply-To: <20260206-feature-dynamic_isolcpus_dhei-v1-3-00a711eb0c74@gmail.com>
References: <20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com>
 <20260206-feature-dynamic_isolcpus_dhei-v1-3-00a711eb0c74@gmail.com>
Date: Fri, 06 Feb 2026 13:24:25 +0100
Message-ID: <871piy12me.ffs@tglx>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 06 2026 at 02:04, Qiliang Yuan wrote:

s/Managed IRQs/managed interrupts/ in $subject

> Support dynamic reconfiguration of CPU isolation by making the managed
> interrupts responsive to housekeeping mask changes at runtime.
>
> 1. Register a housekeeping notifier in the genirq subsystem to listen
>    for HK_TYPE_MANAGED_IRQ updates.
> 2. Iterate through all active interrupts when a mask update occurs.
> 3. Re-apply affinity for managed interrupts to ensure they honor the
>    newly configured housekeeping mask.
> 4. Use irq_set_affinity_locked() to trigger migration away from newly
>    isolated CPUs or towards newly designated housekeeping CPUs.

Please don't explain implementation details in the change log. They can
be seen from the patch. Explain the why and the concept of the change

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>

So you developed that together with your alter ego? Pick one please.

> +#ifdef CONFIG_SMP
> +static int irq_housekeeping_reconfigure(struct notifier_block *nb,
> +					unsigned long action, void *data)
> +{
> +	struct housekeeping_update *upd = data;
> +	struct irq_desc *desc;

Move desc into the loop

> +	unsigned int irq;
> +
> +	if (action != HK_UPDATE_MASK || upd->type != HK_TYPE_MANAGED_IRQ)
> +		return NOTIFY_OK;
> +
> +	irq_lock_sparse();
> +	for_each_active_irq(irq) {
> +		struct irq_data *id;

id is really not a intuitive name. Most code here uses 'irqd'.

> +		desc = irq_to_desc(irq);
> +		if (!desc)
> +			continue;
> +
> +		scoped_guard(raw_spinlock_irqsave, &desc->lock) {

raw_spinlock_irq. There is nothing to save here as this is preemptible
thread context, no?

You can simplify all of the above by using:

	scoped_irqdesc_get_and_lock(irq, 0) {
        	struct irq_data *irqd = irq_desc_get_irq_data(scoped_irqdesc);

                ....

> +			id = irq_desc_get_irq_data(desc);
> +			if (!irqd_affinity_is_managed(id) || !desc->action ||
> +			    !irq_data_get_irq_chip(id))

No line break required. You have 100 characters.

> +				continue;

Thanks,

        tglx
