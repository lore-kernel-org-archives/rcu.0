Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1CB3C13E3;
	Tue, 22 Sep 2026 03:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790047345; cv=none; b=lq1kMSa+ONSdN0o9vsNEOHfvJ3/i/W25WiwE6YQvNTCm6jOmARc4fkjlxXf+KPUHzsj0nuaZrkKPkjG8nrYRgqZZzn6FR2EobHQ9LZDH085QMf+oIoxXSXdrgGuI2lLsDwZKsACt/lWWP28WB3ypFZtnRehwjDtVHK4ljoX6DpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790047345; c=relaxed/simple;
	bh=AOEeReOZrTGC8dpC36mO1gniSWlVrWU83gIlEV7bCsk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Q2Wo7jWUj6vhQvyWzVwKOEFBqOkQi64U/gGT7Tnm4fRcsXw/l+Cv+E3K+x3rsu+jXjjjCFaDZMtqommKUfwZwvMNMy+V5iG702v/KEcSD+M0jhNye+FAyTjkgoWKZPELqKDOFKUPn18xYp28sim39AhAxKxLTSj5ht573yhhA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaG01oy7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaG01oy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3971F000FF;
	Tue, 22 Sep 2026 03:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790047343;
	bh=chwp6w9U3FXx9HLMVXQesUWvyCF8tGEQzW9vmTXezC4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FaG01oy7Dp1NuIp3NAOKPXeN3uw8XNWovuKFxTeJs2szrVkgfj8DAu+/UoJIaPf8n
	 JvUu4k6T62ZfVfKVTecEneuDaR09v6aEksgw+khUW7dPISh7y4IM73FOSNGTdCLaKC
	 YwlVxhcD244lTyTYLoHPCBx4TX8CVf6O3BLRRktWXCg7ywuM+y8kL/t3WomZq1GzzP
	 dbUmMyLYiCTwIafSoU4MNbLVMWgp5adoCwWQUt2AyQ+pRHICuUX4+sjYMuZTC990V9
	 yjvIKuf0JrBQvC+ZgpywVyHJU9+cZNBUxXnxpKExgRbUV17hBYOYdPDcQZy4wErvxc
	 vE23KyR3tfhmw==
Content-Type: multipart/mixed; boundary="===============2423834593094065684=="
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <592fd2894ad5ea9edd7bed019d13ebc0eb584faeaa456edd20fa638b636651da@mail.kernel.org>
In-Reply-To: <20260922-b4-rcu-tasks-preempt-qs-v5-3-410f57770bad@toxicpanda.com>
References: <20260922-b4-rcu-tasks-preempt-qs-v5-3-410f57770bad@toxicpanda.com>
Subject: Re: [PATCH v5 03/13] kprobes: Expose the optprobe jump window to Tasks RCU
From: bot+bpf-ci@kernel.org
To: josef@toxicpanda.com,paulmck@kernel.org,frederic@kernel.org,ast@kernel.org,rostedt@goodmis.org
Cc: boqun@kernel.org,mhiramat@kernel.org,mark.rutland@arm.com,peterz@infradead.org,tglx@kernel.org,daniel@iogearbox.net,andrii@kernel.org,puranjay@kernel.org,rcu@vger.kernel.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,josef@toxicpanda.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 03:22:21 +0000 (UTC)

--===============2423834593094065684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index e6de7ae55bda..74cc48c04417 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h

[ ... ]

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 6337da5cab9e..e460fba83e4a 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -511,6 +511,48 @@ static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
>  	return NULL;
>  }
>
> +/*
> + * True while kprobe_optimizer() is waiting for its Tasks RCU grace period.
> + * Only in that window can an interruption inside an optprobe's jump region
> + * matter to it, so kprobe_in_optimized_region() does no work otherwise.
> + */
> +static bool kprobe_optimizer_waiting;
> +
> +/**
> + * kprobe_in_optimized_region - Could @addr be inside bytes a jump-optimized
> + *	kprobe replaces?
> + * @addr: kernel text address, typically an interrupted instruction pointer
> + *
> + * kprobe_optimizer() relies on synchronize_rcu_tasks() to wait for tasks that
> + * were interrupted on an instruction boundary inside the region about to be
> + * overwritten by the optimized jump.  Where Tasks RCU is built on
> + * reader-marked trampolines that region has no reader, so the irq-exit
> + * quiescent-state check asks this instead (see rcu_tasks_trampoline_text()).
> + * This is the lockless, conservative form of get_optimized_kprobe(): it does
> + * not care whether the kprobe found is, or ever will be, optimized.  May be
> + * called from any context with preemption disabled; the kprobe hash is
> + * RCU-protected and every free path waits for a grace period after unhashing.
> + *
> + * The hash walk only runs while the optimizer is actually waiting.  A task
> + * that was preempted in such a region before the flag went up is invisible
> + * to that check, so the optimizer first waits those out by their recorded
> + * preemption IP (rcu_tasks_wait_irq_preempted(), whose leading
> + * synchronize_rcu() also publishes the flag to every check in flight).
> + */
> +bool kprobe_in_optimized_region(unsigned long addr)
> +{
> +	int i;
> +
> +	if (!READ_ONCE(kprobe_optimizer_waiting))
> +		return false;
> +
> +	for (i = 1; i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
> +		if (get_kprobe((kprobe_opcode_t *)addr - i))
> +			return true;
> +	return false;
> +}
> +NOKPROBE_SYMBOL(kprobe_in_optimized_region);

This isn't a bug, but could the explanation of the kprobe_optimizer_waiting
window live in one place? The flag comment (lines above), the
kprobe_in_optimized_region() kernel-doc, and the Step 2 comment in
kprobe_optimizer() (see below) each describe the same mechanism. A later
change has to keep three copies in sync.

This isn't a bug, but would a name tied to the pending-optimization window
read better at the rcu_tasks_trampoline_text() call site? As written,
'in_optimized_region' suggests an already-optimized probe and hides that
the answer is false whenever the optimizer is not waiting. Something like
kprobe_in_pending_jump_region() or kprobe_optimizer_pending_at() might be
clearer.

The kernel-doc has to explain what the name doesn't convey: "does not care
whether the kprobe found is, or ever will be, optimized" and "The hash walk
only runs while the optimizer is actually waiting."

> +
>  /* Optimization staging list, protected by 'kprobe_mutex' */
>  static LIST_HEAD(optimizing_list);
>  static LIST_HEAD(unoptimizing_list);
> @@ -644,8 +686,16 @@ static void kprobe_optimizer(void)
>  		 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
>  		 * Note that on non-preemptive kernel, this is transparently converted
>  		 * to synchronoze_sched() to wait for all interrupts to have completed.
> +		 * kprobe_optimizer_waiting lets a reader-marked-trampoline Tasks RCU
> +		 * recognise tasks interrupted in such a region while we wait, and
> +		 * rcu_tasks_wait_irq_preempted() (a no-op elsewhere) first waits
> +		 * out any that were preempted there before we said so; see
> +		 * kprobe_in_optimized_region().
>  		 */
> +		WRITE_ONCE(kprobe_optimizer_waiting, true);
> +		rcu_tasks_wait_irq_preempted(kprobe_in_optimized_region);
>  		synchronize_rcu_tasks();
> +		WRITE_ONCE(kprobe_optimizer_waiting, false);

This third description of the same mechanism adds to the maintenance burden
mentioned above.

[ ... ]

> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index f03be742be48..eb1388dd8a61 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1005,7 +1005,9 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
>   *    trampolines, kprobe slots and other dynamically allocated text; this
>   *    deliberately does not ask is_ftrace_trampoline() and friends, since
>   *    text being torn down may already be unregistered there);
> - *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text().
> + *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text();
> + *  - the bytes after a kprobe that a pending jump optimization is about to
> + *    overwrite, the one synchronize_rcu_tasks() user with no trampoline.
>   *
>   * A false positive only makes the task a holdout until its next quiescent
>   * event.  Called with interrupts disabled from the irq-exit path.
> @@ -1013,8 +1015,11 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
>  bool rcu_tasks_trampoline_text(unsigned long ip)
>  {
>  	if (core_kernel_text(ip))
> -		return arch_rcu_tasks_trampoline_text(ip);
> -	return !is_module_text_address(ip);
> +		return arch_rcu_tasks_trampoline_text(ip) ||
> +		       kprobe_in_optimized_region(ip);
> +	if (is_module_text_address(ip))
> +		return kprobe_in_optimized_region(ip);
> +	return true;
>  }
>  NOKPROBE_SYMBOL(rcu_tasks_trampoline_text);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35680506278
--===============2423834593094065684==--
