Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904663D903C;
	Tue, 31 Mar 2026 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949674; cv=none; b=FQI0L45jJi9w/37iYlAmR7+qVynw4MKqw7hcXiE6/xSbKBRupoCFNaDjrMTfr4rMLfGAS0iI5BjIGKbDFThKUIc1vY8LFOLbgLUpuLzmGRwqdDXuQBnVwVZGcKmKBvoAy7YQH4DxPE1GZkWBXQJ62rFRs9zL80J5fLwMXQNJ3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949674; c=relaxed/simple;
	bh=TNVBpCJN6vg8JkQHOX7FUtr9yD8HwVf8QJDF0J/CUy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAKDnGrJtMblb89xnkZpDPvGjd8LCZRhrnjlt5xyYNwh0StNmZ6ucoNpkQymRaPRSKZRyvic5nYzAfPA6EOgKIvJdHvIXF4/D479aegEsBwLudX2lWYIZkF5Mgb4bE+ecGZQnjjpk/bHZrTLbnrB2SciKtxKPWk2fAUPBSqjqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pt4Un6f0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pt4Un6f0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C10C19423;
	Tue, 31 Mar 2026 09:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774949674;
	bh=TNVBpCJN6vg8JkQHOX7FUtr9yD8HwVf8QJDF0J/CUy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pt4Un6f0Op8HHkDpNUCOcnt0nI7PmGlADhRN9a3BHHhBdXimG4XTdhMnFMNlwYd0n
	 M1KK3OQINGKqwKjlhSli3nyu3fHdGRIWVyvGQb0Wpp1XVEvLGnhEtIM9wlCNVU0J56
	 srdjODdV+zfUmZ321/7YRdXx+NhMPa1+txEL7mRSNHZWjkAB03bqthr4ezbEp2wSY3
	 ejVoz6IwnqXh/oSzej6g4dQlE4tQ9fDA4wlv0frT4FQ83qSaXAFA/LN+Xcwzu8ey5C
	 OREep0Om8Mvfyh/P5cdhESKZIGcAgni8Jyc+dOdldCXDvD0omK6hlaZqxu3W/B9zpE
	 mF9a2CE1hR70g==
Date: Tue, 31 Mar 2026 11:34:31 +0200
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
Subject: Re: [PATCH 02/15] sched/isolation: Introduce housekeeping notifier
 infrastructure
Message-ID: <acuVJ70bXAxFg-Zr@pavilion.home>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
 <20260325-dhei-v12-final-v1-2-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325-dhei-v12-final-v1-2-919cca23cadf@gmail.com>

Le Wed, Mar 25, 2026 at 05:09:33PM +0800, Qiliang Yuan a écrit :
> Subsystems currently rely on static housekeeping masks determined at
> boot. Supporting runtime reconfiguration (DHEI) requires a mechanism
> to broadcast mask changes to affected kernel components.
> 
> Implement a blocking notifier chain for housekeeping mask updates.
> 
> This infrastructure enables subsystems like genirq, workqueues, and RCU
> to react dynamically to isolation changes.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
>  include/linux/sched/isolation.h | 21 +++++++++++++++++++++
>  kernel/sched/isolation.c        | 24 ++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d8501f4709b58..9df55237d3901 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -5,6 +5,7 @@
>  #include <linux/cpuset.h>
>  #include <linux/init.h>
>  #include <linux/tick.h>
> +#include <linux/notifier.h>
>  
>  enum hk_type {
>  	HK_TYPE_DOMAIN,
> @@ -24,6 +25,13 @@ enum hk_type {
>  	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
>  };
>  
> +struct housekeeping_update {
> +	enum hk_type type;
> +	const struct cpumask *new_mask;
> +};
> +
> +#define HK_UPDATE_MASK	0x01
> +
>  #ifdef CONFIG_CPU_ISOLATION
>  DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
>  extern int housekeeping_any_cpu(enum hk_type type);
> @@ -33,6 +41,9 @@ extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
>  extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
>  extern void __init housekeeping_init(void);
>  
> +extern int housekeeping_register_notifier(struct notifier_block *nb);
> +extern int housekeeping_unregister_notifier(struct notifier_block *nb);
> +
>  #else
>  
>  static inline int housekeeping_any_cpu(enum hk_type type)
> @@ -59,6 +70,16 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
>  }
>  
>  static inline void housekeeping_init(void) { }
> +
> +static inline int housekeeping_register_notifier(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline int housekeeping_unregister_notifier(struct notifier_block *nb)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_CPU_ISOLATION */
>  
>  static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 67a5ff273ea08..e7a21023726df 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -9,6 +9,7 @@
>   */
>  #include <linux/sched/isolation.h>
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
>  #include "sched.h"
>  
>  enum hk_flags {
> @@ -18,6 +19,7 @@ enum hk_flags {
>  };
>  
>  static DEFINE_MUTEX(housekeeping_mutex);
> +static BLOCKING_NOTIFIER_HEAD(housekeeping_notifier_list);
>  DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
>  EXPORT_SYMBOL_GPL(housekeeping_overridden);
>  
> @@ -86,6 +88,28 @@ bool housekeeping_test_cpu(int cpu, enum hk_type type)
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
>  
> +int housekeeping_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&housekeeping_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(housekeeping_register_notifier);
> +
> +int housekeeping_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&housekeeping_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(housekeeping_unregister_notifier);
> +
> +static int housekeeping_update_notify(enum hk_type type, const struct cpumask *new_mask)
> +{
> +	struct housekeeping_update update = {
> +		.type = type,
> +		.new_mask = new_mask,
> +	};
> +
> +	return blocking_notifier_call_chain(&housekeeping_notifier_list, HK_UPDATE_MASK, &update);
> +}

I much prefer explicit function calls over notifiers so that we control on
which order things happen. housekeeping_update() does that for HK_TYPE_DOMAIN.

Thanks.

> +
>  void __init housekeeping_init(void)
>  {
>  	enum hk_type type;
> 
> -- 
> 2.43.0
> 

-- 
Frederic Weisbecker
SUSE Labs
