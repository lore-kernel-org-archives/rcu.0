Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A9443E4D;
	Mon, 21 Sep 2026 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022793; cv=none; b=kUvngZ0/mUD3B26JrAJn8907lrQiQtmULzr3dyUFh6O64yMmdYtU9o8bS0oU7QjMWQAAhLHBb3FwFrEpZahJGp7dz3QpKfavVyD7UjCs2REttX6HeYsFrWbkisf2JszLmzRdA0UJePisK+4hxyJ3fuJ8iZR2j8vimsEOpaWxa/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022793; c=relaxed/simple;
	bh=0fdKB9PAcynG6lJAxLQKGsgOil3bAwtzKMvCfgwUNV4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Gq2M3WoQOMZQ64HCZjKpIQk5iFLgiI71liM5vq2ZeDivcMTHfRIL/JSGJjbnjH0b+Zig6OP894ZpWyJqATT7PhFtfDgb+ExDUtoHs/dGCChaLSM+Cd17X5OEX+5N7tRvuqOXQHG1mhw1iw7miG/hvk7Xu+mpWraGBWjAIzrrahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLR44ior; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLR44ior"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD321F00893;
	Mon, 21 Sep 2026 20:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790022792;
	bh=G3wZAHrS9GY67mCZyx8VEqrkePghHjOS8VY49GJJTUs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NLR44iorerMogJ9WL+kP0ybLIYpCGjtn7zZb0U/yyGyfuT7Ur03mJRlUsO6qSHR/W
	 H5JxabNbOwA/eU+m0e68VvHoz7yJ+X1+wQO0/W2HG4drNfmIdPDXaTeV9WXg4lD8fI
	 tR814Mk5nJ1rA7MHi//kouCiFseT1A/YRZxZ8rN1ciJiutOMa+X90H3MlAaS8xIfy7
	 gqaL9iqe5KiuAUFn4w/jPQ8BkAbg9A33xjf/N6NShvAVr9krqDxFVxMQs6AFuPQym9
	 9hGN84J/GVdjBULwNfHVBlL4XfDDTbixEXp5AKSQnKYXrEkIojuvrSIiImpEvw9WKr
	 ljSn31jYRM5rQ==
Content-Type: multipart/mixed; boundary="===============3493552065283249613=="
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a506bc149f7e65052077174c484b77a550eb6d06060fc33a81f5b21ae552aa5@mail.kernel.org>
In-Reply-To: <20260921191407.1742386-2-puranjay@kernel.org>
References: <20260921191407.1742386-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: Add bpf_call_rcu() kfunc
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org,rcu@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,harry@kernel.org,paulmck@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 20:33:10 +0000 (UTC)

--===============3493552065283249613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 501c7ce35cba9..8a01dd4058a03 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -4805,6 +4805,80 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
>  	return bpf_task_work_schedule(task, tw, map__const_map, callback, aux, TWA_RESUME);
>  }
>
> +typedef int (*bpf_rcu_callback_t)(struct bpf_map *map, void *key, void *value);
> +
> +/* Actual type for struct bpf_rcu_head */
> +struct bpf_rcu_head_kern {
> +	struct rcu_head rcu;
> +	bpf_callback_t callback_fn;
> +	struct bpf_map *map;
> +	struct bpf_prog *prog;
> +	u32 armed;
> +} __aligned(8);

In v4, Mykyta Yatsenko raised a concern about embedding struct rcu_head
inline: "I tried to fully embed structure back when implementing
bpf_task_work, Alexei rejected that approach, because some of the
structures (irq_work) I used are not in our control and might change."

On Sept 18 you replied: "Yeah, you are right. I will change it to be
heap-allocated like bpf_task_work." But v5 still embeds the structure
inline.

The commit message justifies this: "Embedding struct rcu_head ties part of
a uapi struct to a definition outside of BPF, which is acceptable here only
because it is two pointers, a callback and its argument, with no room to
grow."

Could you clarify the resolution? struct rcu_head is still not under BPF
control, and if it expands in the future, the 64-byte uapi allocation
becomes too small and breaks userspace ABI.

Reference: https://lore.kernel.org/bpf/210f1bfa-e6ae-4d1e-a920-a6c8c9b4269f@gmail.com/

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d62c0f74cff5e..64db47964ff9f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10955,6 +10971,40 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
>  	return 0;
>  }
>
> +static int set_rcu_callback_state(struct bpf_verifier_env *env,
> +				  struct bpf_func_state *caller,
> +				  struct bpf_func_state *callee,
> +				  int insn_idx)
> +{
> +	struct bpf_map *map_ptr = caller->regs[BPF_REG_2].map_ptr;
> +	u32 map_uid = caller->regs[BPF_REG_2].map_uid;
> +
> +	/*
> +	 * callback_fn(struct bpf_map *map, void *key, void *value);
> +	 */
> +	callee->regs[BPF_REG_1].type = CONST_PTR_TO_MAP;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
> +	callee->regs[BPF_REG_1].map_ptr = map_ptr;
> +	callee->regs[BPF_REG_1].map_uid = map_uid;
> +
> +	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
> +	callee->regs[BPF_REG_2].map_ptr = map_ptr;
> +	callee->regs[BPF_REG_2].map_uid = map_uid;
> +
> +	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
> +	callee->regs[BPF_REG_3].map_ptr = map_ptr;
> +	callee->regs[BPF_REG_3].map_uid = map_uid;
> +
> +	/* unused */
> +	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
> +	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
> +	callee->in_async_callback_fn = true;
> +	callee->callback_ret_range = retval_range(S32_MIN, S32_MAX);
> +	return 0;
> +}
> +

This isn't a bug, but set_rcu_callback_state() differs from
set_task_work_schedule_callback_state() only in reading the map from
BPF_REG_2 instead of BPF_REG_3 - would a shared helper parameterised by
the map register reduce the maintenance burden of these ~30 nearly
identical lines?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35644498619
--===============3493552065283249613==--
