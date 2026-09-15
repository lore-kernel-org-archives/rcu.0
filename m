Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771D3B0AED;
	Tue, 15 Sep 2026 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481878; cv=none; b=m17/Qa5hc3Hh85VJBX6MvileRRby2A0maRDAEzsvxLaXu38wy0uHVKUI2t42gkMQpC0gkNJLB+Nfhk5GHAPNyzNChu6F+Lo9lG07Rsklzm78Ak1Wz7C7+aU87QlCh6jqNnOmw20llqe1m7smJMDOdhZbNCQsSgYZPH6tuP5cePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481878; c=relaxed/simple;
	bh=jKmKjY2sjPRLjEh0wzQXbnulhf+a/ZQFsEMtVhHBMBs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=o4mc5vVj35SdQ7X5u6e+3Gl9BfOaezaAHnZeaiA1+GQ4P+DVRjh8DNV/IBxSc7nofUObsuFdH8mMt4qepwwx9FaxP/rUDAoBdC9E9techUuRH4HCLXZt2lILMF/KLEdhApYdlakdX5Y5bagWWq4FnLs/ERQxY024GgRn0Vlkd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8QviNNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8QviNNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F7A1F00893;
	Tue, 15 Sep 2026 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789481877;
	bh=37WI6Bj/Ggz3/9zO2SR1BHA0D09BihoVO8j7O418CP4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=L8QviNNrTmMpIqQxxWm+1VskqSUHJhnuf0/rYUwn4D42ISdoJmFjdazUlkGx8ggjD
	 X9a5oqOjNa/CDI0U1C0R5QjHTXlgPr/67Rld+0Hyr0uJ/7kc3460S3rv7/jkol6ScQ
	 +IDquEBZlfhgOQp6PB69iJ4aD7kdmPXVcZA+RIUuxHxgEsToRDVkNmvLsX0odMc+Rw
	 nuEvkdqjxbWUYQZihz9u2BVhArW2qXa3JsNJNFwxqYCKBT6wR0d7kywT/XE6mpf1b3
	 xzVVYFhiewYfFNfuT8Uq0rEA4UxyGjpPPEsrojRib0d1ehB27wSNo+4fQ7hHW5u7Gn
	 OzxzjqzdwP2cg==
Content-Type: multipart/mixed; boundary="===============0488351286812016447=="
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <99771250491ac7c5568e688eacca866676565a40f18f1189b8937472f4aba91e@mail.kernel.org>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-13-0ad30c4c5ee7@toxicpanda.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-13-0ad30c4c5ee7@toxicpanda.com>
Subject: Re: [PATCH RFC v3 13/13] x86, arm64: Build Tasks RCU on Tasks Trace readers in trampolines
From: bot+bpf-ci@kernel.org
To: josef@toxicpanda.com,paulmck@kernel.org,frederic@kernel.org,neeraj.upadhyay@kernel.org,joelagnelf@nvidia.com,boqun@kernel.org,tglx@kernel.org,peterz@infradead.org,rostedt@goodmis.org,mhiramat@kernel.org,mark.rutland@arm.com,jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,x86@kernel.org,catalin.marinas@arm.com,will@kernel.org,puranjay@kernel.org,xukuohai@huaweicloud.com,paulmck@kernel.org,frederic@kernel.org,neeraj.upadhyay@kernel.org,joelagnelf@nvidia.com,boqun@kernel.org,tglx@kernel.org,peterz@infradead.org,rostedt@goodmis.org,mhiramat@kernel.org,mark.rutland@arm.com,jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,x86@kernel.org,catalin.marinas@arm.com,will@kernel.org,puranjay@kernel.org,xukuohai@huaweicloud.com
Cc: luto@kernel.org,josh@joshtriplett.org,urezki@gmail.com,mathieu.desnoyers@efficios.com,jiangshanlai@gmail.com,qiang.zhang@linux.dev,jgross@suse.com,mcgrof@kernel.org,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,rcu@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-arm-kernel@lists.infradead.org,xen-devel@lists.xenproject.org,luto@kernel.org,josh@joshtriplett.org,urezki@gmail.com,mathieu.desnoyers@efficios.com,jiangshanlai@gmail.com,qiang.zhang@linux.dev,jgross@suse.com,mcgrof@kernel.org,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,rcu@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-arm-kernel@lists.infradead.org,xen-devel@lists.xenproject.org,josef@toxicpanda.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 14:17:53 +0000 (UTC)

--===============0488351286812016447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 8101fe6229d57..34b81512cc5f3 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -2756,6 +2756,26 @@ synchronize_rcu(), and rcu_barrier(), respectively. In
>  three APIs are therefore implemented by separate functions that check
>  for voluntary context switches.
>
> +Architectures that select ``CONFIG_HAVE_RCU_TRAMPOLINE_READERS`` keep the
> +same three APIs but implement the grace period differently
> +(``CONFIG_TASKS_RCU_TRAMPOLINE_READERS``).  There, every trampoline whose
> +lifetime Tasks RCU guards enters a Tasks Trace RCU read-side critical
> +section (rcu_read_lock_trace() or its assembly equivalent) before calling
> +out and leaves it before returning, so a task anywhere inside such a
> +call-out is an ordinary Tasks Trace reader whether or not it is
> +preempted.  The few trampoline instructions outside that reader can only
> +be occupied by a task that was interrupted there, so the grace period
> +additionally waits for each CPU to pass through a context switch, and the
> +irq-exit preemption path, the only switch that can catch a task inside
> +such text (rcu_tasks_trampoline_text()), briefly makes such a task a
> +holdout until it is next seen elsewhere.  On such kernels an involuntary
> +context switch outside trampoline text *is* a Tasks-RCU quiescent state,
> +a Tasks RCU grace period no longer depends on how long any task runs
> +without sleeping, cond_resched_tasks_rcu_qs() is unnecessary, and the
> +obligation moves to the trampolines: anything that relies on
> +synchronize_rcu_tasks() to protect code a task may be preempted in must
> +take the Tasks Trace reader (see register_ftrace_direct()).
                                                               ^^^^^

Does this paragraph describe the complete set of options? The series
itself includes kernel/kprobes.c:kprobe_optimizer(), which relies on
synchronize_rcu_tasks() to protect instructions a task may be preempted
in, but instead of taking a Tasks Trace reader it registers an address
predicate and calls rcu_tasks_wait_irq_preempted(kprobe_in_optimized_region)
before synchronize_rcu_tasks().

kernel/kprobes.c:526-539 documents that alternative: "kprobe_optimizer()
relies on synchronize_rcu_tasks() to wait for tasks that ... the
quiescent-state check asks this instead."

Since this paragraph is the single place in Documentation/RCU that
describes the new contract for HAVE_RCU_TRAMPOLINE_READERS architectures,
a subsystem author reading it would conclude there is one way to comply
and would get no pointer to rcu_tasks_wait_irq_preempted() or
rcu_tasks_trampoline_text() for code that cannot take a reader.

Could the paragraph mention the rcu_tasks_wait_irq_preempted() escape
hatch, or soften to "must take the Tasks Trace reader or otherwise make
its text known to the quiescent-state check"?

> diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
> index 4b30f701225fd..7082686cbd66d 100644
> --- a/Documentation/RCU/checklist.rst
> +++ b/Documentation/RCU/checklist.rst
> @@ -252,7 +252,12 @@ over a rather long period of time, but improvements are always welcome!
>  	a.	If the updater uses synchronize_rcu_tasks() or
>  		call_rcu_tasks(), then the readers must refrain from
>  		executing voluntary context switches, that is, from
> -		blocking.
> +		blocking.  On architectures that select
> +		CONFIG_HAVE_RCU_TRAMPOLINE_READERS a reader must in
> +		addition be a Tasks Trace RCU reader (that is what the
> +		trampolines there do around their call-outs); an
> +		arbitrary stretch of preemptible kernel code is not
> +		protected.
                        ^^^^^^^^^

Same question here. This text also states the obligation in absolute
terms ("a reader must in addition be a Tasks Trace RCU reader"), with
no mention of the rcu_tasks_wait_irq_preempted() alternative that
kprobe_optimizer() uses.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34975311706
--===============0488351286812016447==--
