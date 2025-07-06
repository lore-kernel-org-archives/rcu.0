Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8143C2F;
	Sun,  6 Jul 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751821277; cv=none; b=j+MQ4rwmE284IXqJRkH2HGK9cPTegCh15VnS9crI1u/r2a1T2iThzFv2EKd2/06KXgYUCsXnm3puW2KB48h0GpUc7R2lg1MPIWUvjJWIQEcW47Mu0uzQodF3AMbA4HRC1Y4ZDrkdt9aksgwwLalXDJb1c+8agWh4dq5CbUREatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751821277; c=relaxed/simple;
	bh=i7FjqQB9e86KPDAjZ6ecIlH1DvkdwOFhgxZF87a9aYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stt0DuX2v65u1YkDy2yPyg6hrpK2z+h9/rt6AGTH5/I4KE/kj8wx4Kpi6op8LWz+D2WjEDTidITYqlC69hIfs970Ysw0WL2Q3prmNOsK1Pr1HgNaVPkvG+tA9xKBmMhM6ooZCPTcU+qIBjY+uCa60eEa0zcHDenGs4LKrfBbi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nljP5jVa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nljP5jVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550FBC4CEED;
	Sun,  6 Jul 2025 17:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751821276;
	bh=i7FjqQB9e86KPDAjZ6ecIlH1DvkdwOFhgxZF87a9aYU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nljP5jVaRdXI9qxFnCM0VRIwzcK/bkCR/yXiXvXd9seiBwcwYRX+GDYhsy5ne4Ul+
	 ZedkZzMb3tArHWB4L/OwMXEPdACOgFqg3VmYGZBwe7OWzOoJXi1GlVvrCd38wkA9Yq
	 EIm4v6v0lPberWLe1DRfvpPq3GTGJOQ/i5Vu5fjqeBkQ9iFSkP9O8XT6tUOocjZB8z
	 L0BP4FrqijHX2s5M20rmQh2eG2+9RAMyawIup7qDR49aysOA2md8lEHk6BHiX2lVmo
	 QQOLniNeXaYj4uPUcVsSzm+G4dIsB0XwblRwiodxM+RLZGUHjkk+yiAiyZ9hzZ8R+t
	 6hEzdY0uKd/9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F06C5CE09E9; Sun,  6 Jul 2025 10:01:15 -0700 (PDT)
Date: Sun, 6 Jul 2025 10:01:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrea Righi <arighi@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] smp: Document preemption and stop_machine() mutual
 exclusion
Message-ID: <dbdd31b5-e341-4191-835a-eb473a21b0ab@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250705172328.4114289-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705172328.4114289-1-joelagnelf@nvidia.com>

On Sat, Jul 05, 2025 at 01:23:27PM -0400, Joel Fernandes wrote:
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
> Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> v1->v2: Reworded a bit more (minor nit).
> 
>  kernel/cpu.c |  4 ++++
>  kernel/smp.c | 12 ++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index a59e009e0be4..a8ce1395dd2c 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1310,6 +1310,10 @@ static int takedown_cpu(unsigned int cpu)
>  
>  	/*
>  	 * So now all preempt/rcu users must observe !cpu_active().
> +	 *
> +	 * stop_machine() waits for all CPUs to enable preemption. This lets
> +	 * take_cpu_down() atomically update CPU masks and flush last IPI
> +	 * before new IPIs can be attempted to be sent.
>  	 */
>  	err = stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));
>  	if (err) {
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 974f3a3962e8..842691467f9e 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -93,6 +93,9 @@ int smpcfd_dying_cpu(unsigned int cpu)
>  	 * explicitly (without waiting for the IPIs to arrive), to
>  	 * ensure that the outgoing CPU doesn't go offline with work
>  	 * still pending.
> +	 *
> +	 * This runs in stop_machine's atomic context with interrupts disabled,
> +	 * thus CPU offlining and IPI flushing happen together atomically.
>  	 */
>  	__flush_smp_call_function_queue(false);
>  	irq_work_run();
> @@ -418,6 +421,10 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
>   */
>  static int generic_exec_single(int cpu, call_single_data_t *csd)
>  {
> +	/*
> +	 * Preemption must be disabled by caller to mutually exclude with
> +	 * stop_machine() atomically updating CPU masks and flushing IPIs.
> +	 */
>  	if (cpu == smp_processor_id()) {
>  		smp_call_func_t func = csd->func;
>  		void *info = csd->info;
> @@ -640,6 +647,11 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
>  	/*
>  	 * prevent preemption and reschedule on another processor,
>  	 * as well as CPU removal
> +	 *
> +	 * get_cpu() disables preemption, ensuring mutual exclusion with
> +	 * stop_machine() where CPU offlining and last IPI flushing happen
> +	 * atomically versus this code. This guarantees here that the cpu_online()
> +	 * check and IPI sending are safe without losing IPIs due to offlining.
>  	 */
>  	this_cpu = get_cpu();
>  
> -- 
> 2.43.0
> 
