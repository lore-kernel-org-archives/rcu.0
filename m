Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5426460D;
	Mon, 14 Jul 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513623; cv=none; b=qX0gzKDqlPa4tgcOF4BGIeIBgVnpGwMy7wBr2wc2yGrKCmBYIdORSU3X5FxyLLJsQrsRPnVe2QW81wk33fMRAjeDvi/cuiszqkklzAxIseEYlzlUKgxpfgqaq89oRfJISZwbHciS9GNR3sTy3imzEoyohtIXYDvbxxbcEraLQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513623; c=relaxed/simple;
	bh=AqnASey4JKYZpeGCfAxkeUWlZMJoEHagUbb20REZzXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMVrPGTOLGWHS01E1QfqRhfITpnXeX59ImQF0mgdBz8xf7hICIiTCcbHWkoxANTL0QU8Ur+M1IvniKk3Ed6IqRDpjBfjPFKJ5GAQ6OahiYZ55ad6+ZP9mPr9xwBe4jHWH3jiyOV3niT/qMw/D0t+ooUPbQQcwMRCK5PEUkWjvt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfQ16C8Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfQ16C8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13FCC4CEED;
	Mon, 14 Jul 2025 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752513622;
	bh=AqnASey4JKYZpeGCfAxkeUWlZMJoEHagUbb20REZzXY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jfQ16C8QFR+ZXch5FYyQ554H/PxcmG3WCgXW/yuR+oYtTecuV8tNzAZvKFaaTcu7b
	 KISwv5a1GFjRHN7mGrCDqXtfpq/S+DO7pjoOfFaeeIF4Lwe16rCO5DF9ALi2Mmpd/8
	 Td3UoTpMz75X5hfkhextcilP/AhWJX1YGlBzr19UxoJYdEysCxz5YlV5S9nDb8zwxR
	 CUYd5uk8/7U52sLSoLubiJq9CmF3CQtA528lxiD+44g8KKD9iy16GqUMDlF8hPjYNo
	 MdKGnMgaJ3dkxP0FIfrxC+k1Twl6PKk4ESJHdsMxIpnd7qcv+1bbPc48NAZARb6wcS
	 DsinKveYxCpsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 63DAACE0845; Mon, 14 Jul 2025 10:20:22 -0700 (PDT)
Date: Mon, 14 Jul 2025 10:20:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrea Righi <arighi@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] smp: Document preemption and stop_machine() mutual
 exclusion
Message-ID: <4dd2c694-bb4b-4171-b47f-e005571518ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250705172328.4114289-1-joelagnelf@nvidia.com>
 <20250707075050.GB1613200@noisy.programming.kicks-ass.net>
 <298d86df-65bc-4f7a-a361-a8382cdee296@paulmck-laptop>
 <20250708072321.GB1613376@noisy.programming.kicks-ass.net>
 <e763a7d5-5a11-47f7-a1c2-cf909e5d2a3a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e763a7d5-5a11-47f7-a1c2-cf909e5d2a3a@paulmck-laptop>

On Tue, Jul 08, 2025 at 03:52:44PM -0700, Paul E. McKenney wrote:
> On Tue, Jul 08, 2025 at 09:23:21AM +0200, Peter Zijlstra wrote:

[ . . . ]

> > Best to just re-formulate the entire comment I think. State it provides
> > exclusion vs all non-preemptible regions in the kernel -- at insane cost
> > and should not be used when humanly possible :-)
> 
> How about like this?

Hearing no objections...  ;-)

							Thanx, Paul

> ------------------------------------------------------------------------
> 
> commit 3f0626b0514ccda56d15995e5bd1d1552f828705
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jul 8 15:47:29 2025 -0700
> 
>     stop_machine: Improve kernel-doc function-header comments
>     
>     Add more detail to the kernel-doc function-header comments for
>     stop_machine(), stop_machine_cpuslocked(), and stop_core_cpuslocked().
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
> index 3132262a404dc..72820503514cc 100644
> --- a/include/linux/stop_machine.h
> +++ b/include/linux/stop_machine.h
> @@ -88,55 +88,73 @@ static inline void print_stop_info(const char *log_lvl, struct task_struct *task
>  #endif	/* CONFIG_SMP */
>  
>  /*
> - * stop_machine "Bogolock": stop the entire machine, disable
> - * interrupts.  This is a very heavy lock, which is equivalent to
> - * grabbing every spinlock (and more).  So the "read" side to such a
> - * lock is anything which disables preemption.
> + * stop_machine "Bogolock": stop the entire machine, disable interrupts.
> + * This is a very heavy lock, which is equivalent to grabbing every raw
> + * spinlock (and more).  So the "read" side to such a lock is anything
> + * which disables preemption.
>   */
>  #if defined(CONFIG_SMP) || defined(CONFIG_HOTPLUG_CPU)
>  
>  /**
>   * stop_machine: freeze the machine on all CPUs and run this function
>   * @fn: the function to run
> - * @data: the data ptr for the @fn()
> - * @cpus: the cpus to run the @fn() on (NULL = any online cpu)
> + * @data: the data ptr to pass to @fn()
> + * @cpus: the cpus to run @fn() on (NULL = run on each online CPU)
>   *
> - * Description: This causes a thread to be scheduled on every cpu,
> - * each of which disables interrupts.  The result is that no one is
> - * holding a spinlock or inside any other preempt-disabled region when
> - * @fn() runs.
> + * Description: This causes a thread to be scheduled on every CPU, which
> + * will run with interrupts disabled.  Each CPU specified by @cpus will
> + * run @fn.  While @fn is executing, there will no other CPUs holding
> + * a raw spinlock or running within any other type of preempt-disabled
> + * region of code.
>   *
> - * This can be thought of as a very heavy write lock, equivalent to
> - * grabbing every spinlock in the kernel.
> + * When @cpus specifies only a single CPU, this can be thought of as
> + * a reader-writer lock where readers disable preemption (for example,
> + * by holding a raw spinlock) and where the insanely heavy writers run
> + * @fn while also preventing any other CPU from doing any useful work.
> + * These writers can also be thought of as having implicitly grabbed every
> + * raw spinlock in the kernel.
>   *
> - * Protects against CPU hotplug.
> + * When @fn is a no-op, this can be thought of as an RCU implementation
> + * where readers again disable preemption and writers use stop_machine()
> + * in place of synchronize_rcu(), albeit with orders of magnitude more
> + * disruption than even that of synchronize_rcu_expedited().
> + *
> + * Although only one stop_machine() operation can proceed at a time,
> + * the possibility of blocking in cpus_read_lock() means that the caller
> + * cannot usefully rely on this serialization.
> + *
> + * Return: 0 if all invocations of @fn return zero.  Otherwise, the
> + * value returned by an arbitrarily chosen member of the set of calls to
> + * @fn that returned non-zero.
>   */
>  int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
>  
>  /**
>   * stop_machine_cpuslocked: freeze the machine on all CPUs and run this function
>   * @fn: the function to run
> - * @data: the data ptr for the @fn()
> - * @cpus: the cpus to run the @fn() on (NULL = any online cpu)
> + * @data: the data ptr to pass to @fn()
> + * @cpus: the cpus to run @fn() on (NULL = run on each online CPU)
> + *
> + * Same as above.  Avoids nested calls to cpus_read_lock().
>   *
> - * Same as above. Must be called from with in a cpus_read_lock() protected
> - * region. Avoids nested calls to cpus_read_lock().
> + * Context: Must be called from within a cpus_read_lock() protected region.
>   */
>  int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
>  
>  /**
>   * stop_core_cpuslocked: - stop all threads on just one core
>   * @cpu: any cpu in the targeted core
> - * @fn: the function to run
> - * @data: the data ptr for @fn()
> + * @fn: the function to run on each CPU in the core containing @cpu
> + * @data: the data ptr to pass to @fn()
>   *
> - * Same as above, but instead of every CPU, only the logical CPUs of a
> - * single core are affected.
> + * Same as above, but instead of every CPU, only the logical CPUs of the
> + * single core containing @cpu are affected.
>   *
>   * Context: Must be called from within a cpus_read_lock() protected region.
>   *
> - * Return: 0 if all executions of @fn returned 0, any non zero return
> - * value if any returned non zero.
> + * Return: 0 if all invocations of @fn return zero.  Otherwise, the
> + * value returned by an arbitrarily chosen member of the set of calls to
> + * @fn that returned non-zero.
>   */
>  int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data);
>  
