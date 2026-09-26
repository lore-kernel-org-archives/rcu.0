Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAB31E85B;
	Sat, 26 Sep 2026 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790389058; cv=none; b=hjP30Sb0rE1jKW9gzpGS5O6OpTLAG5aRie6qclCFiHUhF9F5ez4YsuC4hVYwVAMTW470T2v8OsdjmqE3CauoIozIdl+9IWMXSrdcuZZhIBlEv0kfls7FhmqDAnfFXmxipYXhnhGy9gZrDAkiHDOfC+hSEjVEx21nqPK/GW2uC6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790389058; c=relaxed/simple;
	bh=dYkjEner+58VSjRwN0zs8mwtkctjjCt6e+dPyFlMj80=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WU3fQKI4Jq4ceoEyg72S4Dw8lYlcVF+lZc/TeZJemhyHTXFKc1ve29PHxQTtLUABHgo1jVONmisMlDLTu4Js4p5LF1DozBY4C5CUoyAN8Tk3UKjqTmXNg93NVPf7wsVYtRYDsK5FariQ423cTyohcAY5GjuuxnMMBhtZClYr6no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqHIiKFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqHIiKFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8016D1F000FF;
	Sat, 26 Sep 2026 02:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790389056;
	bh=ps+oS/5gQqK+NmJA68Mxz4+l0q54PE+5qHL7AWHAnAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IqHIiKFm9l2a0fqUsXNGp6IeHUhq+lcCM7frCzSD1tlB1UNwXAiseUhw7HtTqyQgf
	 gn5SswmAQ3G8SZdpGofsob70Rc0+ayWNYwKNBf29504lBuWQcLznojwBP65Lbi1PLm
	 n5odsrc5dScuGMRo5ZiIe3PjTLxIkc5ywQ+NXekPYon0prRD1JttxY3TFiP/tD99OC
	 9FPNQfZMP4oUwtFmvty5YjmMApBUHDvmHCKmKWFQgdXZnjmnrwhwclzXW6JhxehaPD
	 EHQ61QJIwjog1pHvkwUYOaweaaHQzkMaClXc4v1N2X6ZV9+eiIIB9ax+gNeQFPh34o
	 8QSMrIdIFyQpA==
Date: Sat, 26 Sep 2026 11:17:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: josef@toxicpanda.com, paulmck@kernel.org, frederic@kernel.org,
 ast@kernel.org, rostedt@goodmis.org, boqun@kernel.org,
 mark.rutland@arm.com, peterz@infradead.org, tglx@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, puranjay@kernel.org,
 rcu@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH] kprobes: Make optprobe optimizer multi-generational and
 asynchronous
Message-Id: <20260926111729.f580fa6a8eaac448649fc8e3@kernel.org>
In-Reply-To: <6469f266e0c06de407583746d4f533a03a002fa8d7871124196b0bb568fe38fa@mail.kernel.org>
References: <179017148080.466588.9116221556625712980.stgit@devnote2>
	<6469f266e0c06de407583746d4f533a03a002fa8d7871124196b0bb568fe38fa@mail.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 16:17:38 +0000 (UTC)
bot+bpf-ci@kernel.org wrote:

> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 6337da5cab9e..1e25980303c4 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> 
> [ ... ]
> 
> > @@ -530,50 +553,78 @@ static DECLARE_COMPLETION(optimizer_completion);
> >
> >  #define OPTIMIZE_DELAY 5
> >
> > +static bool optprobe_has_queued_probes(void)
> > +{
> > +	struct optprobe_generation *gen = &optprobe_gens[optprobe_cur_gen];
> > +
> > +	return !list_empty(&gen->optimizing_list) ||
> > +	       !list_empty(&gen->unoptimizing_list);
> > +}
> 
> Does this logic need to check gen->freeing_list as well?

Ah, indeed. It should check the freeing_list too.

[ ... ]
> 
> > @@ -622,67 +675,119 @@ static void do_free_cleaned_kprobes(void)
> >
> >  static void kick_kprobe_optimizer(void);
> >
> > +static void optprobe_generation_rcu_cb(struct rcu_head *rcu)
> > +{
> > +	struct optprobe_generation *gen;
> > +
> > +	gen = container_of(rcu, struct optprobe_generation, rcu);
> > +	WRITE_ONCE(gen->ready, true);
> > +	wake_up(&kprobe_optimizer_wait);
> > +}
> > +
> > +static void optprobe_finalize_generation(struct optprobe_generation *gen)
> > +{
> > +	lockdep_assert_held(&kprobe_mutex);
> > +
> > +	scoped_guard(cpus_read_lock) {
> > +		guard(mutex)(&text_mutex);
> > +
> > +		/* Optimization never be done when disarmed */
> > +		if (!kprobes_all_disarmed && kprobes_allow_optimization &&
> > +		    !list_empty(&gen->optimizing_list))
> > +			arch_optimize_kprobes(&gen->optimizing_list);
> > +	}
> > +
> > +	/* Free cleaned kprobes after quiescence period */
> > +	do_free_cleaned_kprobes(&gen->freeing_list);
> > +
> > +	gen->in_flight = false;
> > +	WRITE_ONCE(gen->ready, false);
> > +}
> > +
> > +static void optprobe_dispatch_generation(void)
> > +{
> > +	struct optprobe_generation *gen;
> > +
> > +	lockdep_assert_held(&kprobe_mutex);
> > +
> > +	if (!optprobe_can_fire() || !optprobe_has_queued_probes())
> > +		return;
> > +
> > +	gen = &optprobe_gens[optprobe_cur_gen];
> > +
> > +	scoped_guard(cpus_read_lock) {
> > +		guard(mutex)(&text_mutex);
> > +
> > +		/*
> > +		 * Unoptimize kprobes and collect cleaned (unused and disarmed)
> > +		 * kprobes before waiting for quiescence period.
> > +		 */
> > +		do_unoptimize_kprobes(&gen->unoptimizing_list, &gen->freeing_list);
> > +	}
> > +
> > +	/* Advance cur_gen to the next generation slot */
> > +	optprobe_cur_gen = (optprobe_cur_gen + 1) % OPTPROBE_GEN_MAX;
> > +
> > +	gen->in_flight = true;
> > +	WRITE_ONCE(gen->ready, false);
> > +
> > +	call_rcu_tasks(&gen->rcu, optprobe_generation_rcu_cb);
> > +}
> 
> Now that kprobe_mutex is dropped during the Tasks RCU grace period, can
> an aggregator probe that was unoptimized but is still in use be freed
> while a task is still preempted inside its detour buffer?

Good catch! Yes, we need to keep tracking the unoptimized but not
freed kprobes until finalize it.

[ ... ]
> 
> > @@ -707,12 +812,11 @@ static void wait_for_kprobe_optimizer_locked(void)
> >  {
> >  	lockdep_assert_held(&kprobe_mutex);
> >
> > -	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
> > +	while (optprobe_optimizer_busy()) {
> >  		init_completion(&optimizer_completion);
> > -		/*
> > -		 * Set state to OPTIMIZER_ST_FLUSHING and wake up the thread if it's
> > -		 * idle. If it's already kicked, it will see the state change.
> > -		 */
> > +		optprobe_flush_requested = true;
> > +
> > +		/* Wake up optimizer thread */
> >  		if (atomic_xchg_acquire(&optimizer_state,
> >  			OPTIMIZER_ST_FLUSHING) != OPTIMIZER_ST_FLUSHING)
> >  			wake_up(&kprobe_optimizer_wait);
> 
> Andrea Parri raised a concern on 2026-09-24 about a race condition in
> this code (https://lore.kernel.org/all/arTuBodyGqQ0mErI@andreayoga.localdomain/).

Yes, so I pick his patch at first and rebase this on it.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
