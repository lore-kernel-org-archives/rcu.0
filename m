Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB9391E46;
	Tue, 31 Mar 2026 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949872; cv=none; b=nWZJp+ZzOzpiE2dU2tENZTCr3RP+3Iu6zQIkJnexN0RuJNdxlNpyW93BTZnFbkYkaFK7qz4GliZD6W7vNRMJFySQfN194gkhVEpFrDGxB7cFJHpAvWcbqgGUOpxNIINEUnVoEJolYqCkBYOOvTgt6UeAXhWFZGcPR06qqfs9FzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949872; c=relaxed/simple;
	bh=qe1fsS6EN1RbtUHByWfENaECxhHVAJNyIfc33jUhTA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC9oXU4CR8dnWM5I2gc7XeF94JKSx13knn/03pxqfMp2Il1tm6F7k9DCGRuQmySAQtNavpNkgFgbyGwdnlRn15LAUeAd4/oHZhQzaCpe+S9KinUxVBvXABDIozczafCxacpptVMX1nARVLrJRX/zhkcIktYgobGhARv8nEQYRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEvHkYAB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEvHkYAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77337C19423;
	Tue, 31 Mar 2026 09:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774949872;
	bh=qe1fsS6EN1RbtUHByWfENaECxhHVAJNyIfc33jUhTA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEvHkYABu2ykhLpVPrg5c9nD/W/EmL/3D4L2PXSpINOdvkVdnHg1v0dC62gLsqnW1
	 2BP0xz9zxBJCxQ6pxS69MynZJ17yI68NiDTd3Lx3On0VxdeZ/sdFHBQRD8D2BNVSLh
	 XN+6OYhhExKyax6upW8bxPS5cEWrTPZ4P/B47rQrwGsVU3jaGezy1ygNAHEWGevxtP
	 T3cnPJZHiX3+UMq5CcawDD6IrFJb4slqra59wrOwS4sz2vvj231GGqZejpoCubSvZI
	 zVR3Mr82DUONXdQxRvksPRO6MyIQxi/J6nz1sEut/EojbUfMBn/AAl1ODuMYhxF9SX
	 yfaDoIPFsz4UA==
Date: Tue, 31 Mar 2026 11:37:49 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/15] genirq: Support dynamic migration for managed
 interrupts
Message-ID: <acuV7V_7Z7X3dhhV@pavilion.home>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
 <20260325-dhei-v12-final-v1-4-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325-dhei-v12-final-v1-4-919cca23cadf@gmail.com>

Le Wed, Mar 25, 2026 at 05:09:35PM +0800, Qiliang Yuan a écrit :
> Managed interrupts currently have their affinity determined once,
> honoring boot-time isolation settings. There is no mechanism to migrate
> them when housekeeping boundaries change at runtime.
> 
> Enable managed interrupts to respond dynamically to housekeeping updates.
> 
> This ensures that managed interrupts are migrated away from newly
> isolated CPUs or redistributed when housekeeping CPUs are added.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
>  kernel/irq/manage.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 349ae7979da0e..f2cba3d7ef624 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -2811,3 +2811,52 @@ bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
>  	return res;
>  }
>  EXPORT_SYMBOL_GPL(irq_check_status_bit);
> +
> +#ifdef CONFIG_SMP
> +static int irq_housekeeping_reconfigure(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	struct housekeeping_update *upd = data;
> +	unsigned int irq;
> +
> +	if (action != HK_UPDATE_MASK || upd->type != HK_TYPE_MANAGED_IRQ)
> +		return NOTIFY_OK;
> +
> +	irq_lock_sparse();
> +	for_each_active_irq(irq) {
> +		struct irq_data *irqd;
> +		struct irq_desc *desc;
> +
> +		desc = irq_to_desc(irq);
> +		if (!desc)
> +			continue;
> +
> +		scoped_guard(raw_spinlock_irqsave, &desc->lock) {
> +			irqd = irq_desc_get_irq_data(desc);
> +			if (!irqd_affinity_is_managed(irqd) || !desc->action ||
> +			    !irq_data_get_irq_chip(irqd))
> +				continue;
> +
> +			/*
> +			 * Re-apply existing affinity to honor the new
> +			 * housekeeping mask via __irq_set_affinity() logic.
> +			 */
> +			irq_set_affinity_locked(irqd, irq_data_get_affinity_mask(irqd), false);
> +		}
> +	}
> +	irq_unlock_sparse();
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block irq_housekeeping_nb = {
> +	.notifier_call = irq_housekeeping_reconfigure,
> +};
> +
> +static int __init irq_init_housekeeping_notifier(void)
> +{
> +	housekeeping_register_notifier(&irq_housekeeping_nb);
> +	return 0;
> +}
> +core_initcall(irq_init_housekeeping_notifier);
> +#endif

We probably want to do that for HK_TYPE_DOMAIN update on housekeeping_update().

Thanks.

> 
> -- 
> 2.43.0
> 

-- 
Frederic Weisbecker
SUSE Labs
