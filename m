Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0D3A7F78;
	Tue, 15 Sep 2026 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481874; cv=none; b=PrUNqXJOCBEPgh+yAWiyg7hT1txY4XoDjrb/GWoZGaXm0U2PvLnf59zCyHpVzcedYLrQPOoMtVwZZdfYrbkk9XtQOqbShtCI9pubH9WyZlpWMOLwE2lrc05qQwI/gCykG2sv53HiF6633S+IOrEQ+x2QBsVURr7mSEwC6s7rYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481874; c=relaxed/simple;
	bh=bAv/jawgsgoDR/nuMstD4maCPcjrUePRcJZSumxoefA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lS3NA5sC/NRF2wI8UKCvZtRTfw5jNL/Gzm3kMRVksjvSSVdj2kqY3SNkOidPBFn/ZyZ749ta3DohupiS7lguI60qqatvuUJj0r1YLdpCVbMYF+/A6DN7RCuOrqnyoHPCzPZd+2BwPmn6lKmZqqn8wJYnbaPak5IX+AhhAxosnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcJKS+kV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcJKS+kV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615571F000FF;
	Tue, 15 Sep 2026 14:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789481872;
	bh=dlifTzsU870ATuTg2IJn/IPrNft0aFbK+vPgKDTS1dk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NcJKS+kV0GgjRC3ooOQJBaPV2jeb6Y3d7UL4KriHUw2PKdKGn7mKEA7SMmMWfIlqt
	 bc5DtxknhNCYHW85dgnR0O1wnuoYHGcJ4C0AiZgmu+fz+2klekeelQG3tQy3kn6mb+
	 Bxu2osCJ/9PVurBc5hIFiJw9HG5D0gNBBXFktBxTe2x/6bGUzUrFRDlIdugN52I3XS
	 6ljxmdn9PqqOpms/XSTRgW4rIXZ4KadYi1RlA823W0VzXI7FxNHwHs5eMtMxi15qv5
	 /tajIopVGIHRQEKBrIrFfINbf3r5PbFrdZhzKSzVcNP89nB8SMq97bnqwcqNM7l/MA
	 5l0+g0xX/gTig==
Content-Type: multipart/mixed; boundary="===============7591369071524205309=="
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <08596bcdd997ab7122dafdb363cf80caaf038378f32ccb89fbca114c2fd9110a@mail.kernel.org>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-5-0ad30c4c5ee7@toxicpanda.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-5-0ad30c4c5ee7@toxicpanda.com>
Subject: Re: [PATCH RFC v3 05/13] ftrace: Mark modules hosting direct-call trampolines for Tasks RCU
From: bot+bpf-ci@kernel.org
To: josef@toxicpanda.com,paulmck@kernel.org,frederic@kernel.org,neeraj.upadhyay@kernel.org,joelagnelf@nvidia.com,boqun@kernel.org,tglx@kernel.org,peterz@infradead.org,rostedt@goodmis.org,mhiramat@kernel.org,mark.rutland@arm.com,jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,x86@kernel.org,catalin.marinas@arm.com,will@kernel.org,puranjay@kernel.org,xukuohai@huaweicloud.com,paulmck@kernel.org,frederic@kernel.org,neeraj.upadhyay@kernel.org,joelagnelf@nvidia.com,boqun@kernel.org,tglx@kernel.org,peterz@infradead.org,rostedt@goodmis.org,mhiramat@kernel.org,mark.rutland@arm.com,jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,x86@kernel.org,catalin.marinas@arm.com,will@kernel.org,puranjay@kernel.org,xukuohai@huaweicloud.com
Cc: luto@kernel.org,josh@joshtriplett.org,urezki@gmail.com,mathieu.desnoyers@efficios.com,jiangshanlai@gmail.com,qiang.zhang@linux.dev,jgross@suse.com,mcgrof@kernel.org,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,rcu@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-arm-kernel@lists.infradead.org,xen-devel@lists.xenproject.org,luto@kernel.org,josh@joshtriplett.org,urezki@gmail.com,mathieu.desnoyers@efficios.com,jiangshanlai@gmail.com,qiang.zhang@linux.dev,jgross@suse.com,mcgrof@kernel.org,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,rcu@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-arm-kernel@lists.infradead.org,xen-devel@lists.xenproject.org,josef@toxicpanda.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 14:17:49 +0000 (UTC)

--===============7591369071524205309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea5..28488687cb01f 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -521,6 +521,13 @@ struct module {
>  	unsigned int num_ftrace_callsites;
>  	unsigned long *ftrace_callsites;
>  #endif
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +	/*
> +	 * An ftrace direct-call trampoline lives in this module's text; see
> +	 * rcu_tasks_trampoline_text().  Sticky once set.
> +	 */
> +	bool ftrace_direct_tramp;
> +#endif

This isn't a bug, but could the field and ftrace_direct_mark_module()'s
body be gated on CONFIG_TASKS_RCU_TRAMPOLINE_READERS instead? The only
reader of module::ftrace_direct_tramp is rcu_tasks_trampoline_text(),
which lives inside kernel/rcu/tasks.h's CONFIG_TASKS_RCU_TRAMPOLINE_READERS
block:

kernel/rcu/tasks.h:rcu_tasks_trampoline_text() {
#ifdef CONFIG_MODULES
    scoped_guard(rcu) {
        struct module *mod = __module_text_address(ip);

        if (mod) {
            ret = kprobe_in_optimized_region(ip);
#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
            ret = ret || READ_ONCE(mod->ftrace_direct_tramp);
#endif
        }
    }
#endif
}

On every configuration that does not select HAVE_RCU_TRAMPOLINE_READERS
the per-module bool and the four ftrace_direct_mark_module() call sites
that write it have no consumer.

> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 8667684628500..ec54a27e47fae 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h

[ ... ]

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 53d5db60bfa56..efc4a518658a3 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c

[ ... ]

> @@ -6090,6 +6113,17 @@ static void reset_direct(struct ftrace_ops *ops, unsigned long addr)
>   * and save the parameters of the function being traced, and restore them
>   * (or inject new ones if needed), before returning.
>   *
> + * Nothing but Tasks RCU keeps the trampoline at @addr alive while a task is
> + * executing it or is preempted in something it called.  On architectures that
> + * select HAVE_RCU_TRAMPOLINE_READERS, Tasks RCU only waits for such a task if
> + * it is a Tasks Trace RCU reader, so the trampoline must enter one
> + * (rcu_read_lock_trace() or its assembly equivalent, see
> + * samples/ftrace/ftrace-direct.h) before calling out and leave it before
> + * returning, as the ftrace and BPF trampolines do.  The few instructions

This isn't a bug, but would it read better to point at the sample header
only once it exists in the tree, or to word the ftrace/BPF trampoline
part as what the series establishes rather than as current state? The new
kernel-doc paragraph points readers at samples/ftrace/ftrace-direct.h,
which does not exist at this commit (it is added later in the series by
'samples: ftrace: Make the direct-call trampolines Tasks Trace readers'),
and states in the present tense that the ftrace and BPF trampolines
already take the reader, which also only becomes true in later commits of
the series (bpf/x86/arm64 reader patches). Anyone reading or bisecting at
this commit gets a dangling reference and a claim the tree does not yet
satisfy.

> + * before and after are covered by the irq-exit check: automatically for
> + * trampolines outside kernel and module text (e.g. BPF images), and via
> + * ftrace_direct_mark_module() for trampolines in module text.
> + *
>   * Returns:
>   *  0 on success
>   *  -EINVAL  - The @ops object was already registered with this call or

[ ... ]

commit ef57b52d2606546f6d483b113fc2202c13863c2c
Author: Josef Bacik <josef@toxicpanda.com>

>     ftrace: Mark modules hosting direct-call trampolines for Tasks RCU
>
>     An out-of-line direct trampoline registered with register_ftrace_direct()
>     is kept alive only by Tasks RCU while a task executes it or is preempted
>     in something it called; ftrace_shutdown()'s synchronize_rcu_tasks() is
>     what stops rmmod freeing it under such a task.  Where Tasks RCU is built
>     on reader-marked trampolines, such a trampoline must be a Tasks Trace
>     reader across its call-out like the ftrace and BPF trampolines are, so
>     document that in register_ftrace_direct().
>
>     That still leaves the few instructions before the reader is entered and
>     after it is left.  For BPF images those are in dynamically allocated
>     text that rcu_tasks_trampoline_text() already treats as unmarked
>     trampoline text, but the in-tree samples (and any similar user) place
>     their trampolines in module .text.  Add a sticky
>     module::ftrace_direct_tramp flag, set by every register/modify path when
>     the direct address is module text, and have rcu_tasks_trampoline_text()
>     treat a task interrupted anywhere in such a module as a potential
>     holdout.  Other modules' text is unaffected.
>
>     Assisted-by: LLM
>     Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This looks like a bug fix for reader-marked trampoline support. Should
this include:

  Fixes: 00bd9b746f5e ("rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines")

The bug was introduced in commit 00bd9b746f5e which added
rcu_tasks_trampoline_text() but failed to properly handle module .text
containing direct trampolines. The function returned false for module
text addresses, meaning such trampolines were not protected by Tasks RCU,
potentially allowing module text to be freed while still executing.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34975311706
--===============7591369071524205309==--
