Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51063793C3;
	Thu, 24 Sep 2026 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266662; cv=none; b=WHxGTc8SxpexuiJHhfKSuSaMLFG9b7MQdm9GoMnVpT4Zpjb/Z+KHi0s193B4T/TRzGbOkl8tH60eZ0dHpKj8aKfCikPnuQTtZDKNIsBCcvnaaAoZaFiMjY2rdHuECFLr8jqDKQvzMzEGhn32c5TheVetZYkDzaSe+y9Sx8TeKSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266662; c=relaxed/simple;
	bh=54j6jm9bBfedLrJ77nc05dsO/9GGqZr7GBq9pImLWco=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Gu0EdhhNBun9PSEizzNj0ldcGrLv+oAzXgXu9HrrcLgxbC240TfxZF7J02wnDcdtRkWLnXSd65S4fq/FhbIg/km04RDrZ2o9AXQEbYTMk9YnOdGpq+OqcDtzv/ahKAJw4q1/IHYOR3NbMMHnHXS1y+AFRJfxvnvAIuZ/hlAJQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwE+7vle; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwE+7vle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375811F00893;
	Thu, 24 Sep 2026 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266660;
	bh=/vir7cOOalrm3uAtBCr/uUQaicGXlCKvmJG7+GwiX1g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iwE+7vleCFfMnAijc6nhK/b+R0CA8Ynie7k007PULFTJSSXletRWl3GgzUiPQUtKd
	 l7wYcPCT3oOc/WzZlXp9MaV4eOcDUqmfrZ2L5sl2V2N/PiNG6TaOcMk5q7vFNAaXMq
	 v6LwPMgkO+jU2Avkw9xKX3IMLz2PgfKt6r3KHZJiQHjk+npatXy2gKRMxij0z/WXym
	 5wRrjm3GavyMYYh+/H2SEnPcjEKL6+jQBohI0ZWGQ6qMWyo/549lo2PxPZiqMvgjV+
	 nBwIimYQdYDvDcQwTHqObEbK4cK04/yG+3iIF/gAgGFD19AOyoW8NJyIVn15iJYoiF
	 VrVTgi/AD/4+w==
Content-Type: multipart/mixed; boundary="===============3199754947234595145=="
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6469f266e0c06de407583746d4f533a03a002fa8d7871124196b0bb568fe38fa@mail.kernel.org>
In-Reply-To: <179017148080.466588.9116221556625712980.stgit@devnote2>
References: <179017148080.466588.9116221556625712980.stgit@devnote2>
Subject: Re: [PATCH] kprobes: Make optprobe optimizer multi-generational and asynchronous
From: bot+bpf-ci@kernel.org
To: mhiramat@kernel.org,josef@toxicpanda.com,paulmck@kernel.org,frederic@kernel.org,ast@kernel.org,rostedt@goodmis.org
Cc: boqun@kernel.org,mhiramat@kernel.org,mark.rutland@arm.com,peterz@infradead.org,tglx@kernel.org,daniel@iogearbox.net,andrii@kernel.org,puranjay@kernel.org,rcu@vger.kernel.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 16:17:38 +0000 (UTC)

--===============3199754947234595145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 6337da5cab9e..1e25980303c4 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c

[ ... ]

> @@ -530,50 +553,78 @@ static DECLARE_COMPLETION(optimizer_completion);
>
>  #define OPTIMIZE_DELAY 5
>
> +static bool optprobe_has_queued_probes(void)
> +{
> +	struct optprobe_generation *gen = &optprobe_gens[optprobe_cur_gen];
> +
> +	return !list_empty(&gen->optimizing_list) ||
> +	       !list_empty(&gen->unoptimizing_list);
> +}

Does this logic need to check gen->freeing_list as well?

optprobe_dispatch_generation() returns early when this is false:

    if (!optprobe_can_fire() || !optprobe_has_queued_probes())
        return;

But ops can reach cur_gen->freeing_list without leaving anything on the
other two lists. unoptimize_kprobe(ap, true) on an op queued for
unoptimization does:

    force_unoptimize_kprobe(op);
    list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);

This is reached from add_new_kprobe() when a probe with a post_handler
is registered at the same address, and from __arm_kprobe() for an
overlapping optprobe. kill_optimized_kprobe() also list_move()s an
unused, queued op there.

If that op was the only entry on cur_gen->unoptimizing_list, the kick
issued when it was queued produces a kprobe_optimizer() pass that
dispatches nothing. optprobe_optimizer_busy() is then false and nothing
kicks again. The op stays on freeing_list until some unrelated probe is
queued, possibly indefinitely.

While the op sits on freeing_list:

- kprobe_queued(ap) stays true, so a later __disarm_kprobe() skips
  arch_disarm_kprobe(). The int3 then stays in the text after the
  probes at that address are disabled or unregistered.

- The unused aggregator stays in kprobe_table and is not freed.

- wait_for_kprobe_optimizer() returns immediately because
  optprobe_optimizer_busy() is false. This contradicts the commit
  message, which says flushing "waits asynchronously for all in-flight
  and queued generations to drain".

- Registering again at that address goes through reuse_unused_kprobe()
  -> optimize_kprobe(). That sets KPROBE_FLAG_OPTIMIZED again (the
  force path cleared it) and hits WARN_ON_ONCE(!list_empty(&op->list)),
  leaving OPTIMIZED set with no jump installed.

Should optprobe_has_queued_probes() also check
!list_empty(&gen->freeing_list), so that dispatch and the flush loop
account for these ops?

[ ... ]

> @@ -622,67 +675,119 @@ static void do_free_cleaned_kprobes(void)
>
>  static void kick_kprobe_optimizer(void);
>
> +static void optprobe_generation_rcu_cb(struct rcu_head *rcu)
> +{
> +	struct optprobe_generation *gen;
> +
> +	gen = container_of(rcu, struct optprobe_generation, rcu);
> +	WRITE_ONCE(gen->ready, true);
> +	wake_up(&kprobe_optimizer_wait);
> +}
> +
> +static void optprobe_finalize_generation(struct optprobe_generation *gen)
> +{
> +	lockdep_assert_held(&kprobe_mutex);
> +
> +	scoped_guard(cpus_read_lock) {
> +		guard(mutex)(&text_mutex);
> +
> +		/* Optimization never be done when disarmed */
> +		if (!kprobes_all_disarmed && kprobes_allow_optimization &&
> +		    !list_empty(&gen->optimizing_list))
> +			arch_optimize_kprobes(&gen->optimizing_list);
> +	}
> +
> +	/* Free cleaned kprobes after quiescence period */
> +	do_free_cleaned_kprobes(&gen->freeing_list);
> +
> +	gen->in_flight = false;
> +	WRITE_ONCE(gen->ready, false);
> +}
> +
> +static void optprobe_dispatch_generation(void)
> +{
> +	struct optprobe_generation *gen;
> +
> +	lockdep_assert_held(&kprobe_mutex);
> +
> +	if (!optprobe_can_fire() || !optprobe_has_queued_probes())
> +		return;
> +
> +	gen = &optprobe_gens[optprobe_cur_gen];
> +
> +	scoped_guard(cpus_read_lock) {
> +		guard(mutex)(&text_mutex);
> +
> +		/*
> +		 * Unoptimize kprobes and collect cleaned (unused and disarmed)
> +		 * kprobes before waiting for quiescence period.
> +		 */
> +		do_unoptimize_kprobes(&gen->unoptimizing_list, &gen->freeing_list);
> +	}
> +
> +	/* Advance cur_gen to the next generation slot */
> +	optprobe_cur_gen = (optprobe_cur_gen + 1) % OPTPROBE_GEN_MAX;
> +
> +	gen->in_flight = true;
> +	WRITE_ONCE(gen->ready, false);
> +
> +	call_rcu_tasks(&gen->rcu, optprobe_generation_rcu_cb);
> +}

Now that kprobe_mutex is dropped during the Tasks RCU grace period, can
an aggregator probe that was unoptimized but is still in use be freed
while a task is still preempted inside its detour buffer?

When an op on the unoptimizing list is not unused (for example, it is
disabled but its child probe is still registered, as after
disable_kprobe() through __disable_trace_kprobe()),
do_unoptimize_kprobes() takes the else branch:

    } else {
        list_del_init(&op->list);
    }

After optprobe_dispatch_generation() returns, the op is on no generation
list, and nothing ties its lifetime to the pending call_rcu_tasks()
grace period. kprobe_optimizer() then drops kprobe_mutex, so unregister
can run during the grace period:

  unregister_kprobes()
    __unregister_kprobe_top(p)
      /* list_is_singular(&ap->list) && kprobe_disarmed(ap) is true,
         since kprobe_disarmed() is kprobe_disabled(p) &&
         list_empty(&op->list) */
      hlist_del_rcu(&ap->hlist);
    synchronize_rcu();
    __unregister_kprobe_bottom(p)
      free_aggr_kprobe(ap)
        arch_remove_optimized_kprobe(op);  /* frees the detour slot */
        kfree(op);

Sequence with CONFIG_OPTPROBES=y and CONFIG_PREEMPTION=y:

1. Task T enters op->optinsn.insn, through the jump or through
   setup_detour_execution(), and is preempted there. The x86 template
   runs with IRQs enabled, and optimized_callback() reads op->kp.flags
   before preempt_disable(). T can also be preempted in the copied
   instructions.

2. disable_kprobe(child) calls unoptimize_kprobe(ap, false), which
   queues ap on cur_gen->unoptimizing_list.

3. kprobe_optimizer() calls optprobe_dispatch_generation().
   arch_unoptimize_kprobes() runs, then the list_del_init() above, then
   call_rcu_tasks(), and kprobe_mutex is released.

4. unregister_kprobe(child) runs hlist_del_rcu(), then
   synchronize_rcu(), then free_aggr_kprobe(), which does kfree(op).

5. T resumes in the freed or dirty detour slot. If it was preempted in
   the template, it then calls optimized_callback(op, regs), and
   kprobe_disabled(&op->kp) reads freed memory.

synchronize_rcu() does not wait for a task preempted outside
rcu_read_lock(). The detour slot is freed with dirty=1 and can be
reclaimed and reused through collect_garbage_slots(), which also uses
only synchronize_rcu(). kill_kprobe() -> kill_optimized_kprobe() ->
arch_remove_optimized_kprobe() during module unload has the same window.

In the parent commit, kprobe_optimizer() held kprobe_mutex across
synchronize_rcu_tasks(), so step 4 could not start until every such task
had passed a voluntary context switch. The commit message says these
grace periods can last seconds to minutes, which makes this window wide.

Should ops that were unoptimized but are still in use stay attached to
the in-flight generation until optprobe_finalize_generation() runs? Or
should the unregister and kill paths treat such an op as not yet
disarmed until its generation has finished?

[ ... ]

> @@ -707,12 +812,11 @@ static void wait_for_kprobe_optimizer_locked(void)
>  {
>  	lockdep_assert_held(&kprobe_mutex);
>
> -	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
> +	while (optprobe_optimizer_busy()) {
>  		init_completion(&optimizer_completion);
> -		/*
> -		 * Set state to OPTIMIZER_ST_FLUSHING and wake up the thread if it's
> -		 * idle. If it's already kicked, it will see the state change.
> -		 */
> +		optprobe_flush_requested = true;
> +
> +		/* Wake up optimizer thread */
>  		if (atomic_xchg_acquire(&optimizer_state,
>  			OPTIMIZER_ST_FLUSHING) != OPTIMIZER_ST_FLUSHING)
>  			wake_up(&kprobe_optimizer_wait);

Andrea Parri raised a concern on 2026-09-24 about a race condition in
this code (https://lore.kernel.org/all/arTuBodyGqQ0mErI@andreayoga.localdomain/).

The flusher drops kprobe_mutex while it sleeps, and the sysctl handler
and the debugfs "enabled" file do not otherwise serialize against each
other. A second flusher can then run init_completion() on the wait queue
the first one is sleeping on: the first waiter is dropped from the
queue, and complete_all() wakes only the second one. Andrea notes that
with this patch the window is wider, since kprobe_mutex is released
while the Tasks RCU grace period runs and optprobe_optimizer_busy()
stays true until the generation is finalized.

Andrea suggests replacing the completion with a counter of optimizer
passes bumped at the end of each pass and signalled with
wake_up_var_locked().

Should this race be addressed before the patch is applied?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36019837684
--===============3199754947234595145==--
