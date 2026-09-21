Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05958409289;
	Mon, 21 Sep 2026 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021929; cv=none; b=ASFYnDDa71GeHGVCF8A0NbVEEQ6oedBddjTcMyTzDwy5VTPrU8SUd3ZAmp/8M+Q/bcpkkCY8e9EDGy5CmnoEE3fR9Z7X/lLxlHRHlB5iVpXfC0jshus60JE/yVNaNn+B1v2eR038xeXTQv14ZQNiHoasf+wPwBTUqjpc69jcotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021929; c=relaxed/simple;
	bh=Be41t9GnhtdKdrttGlBob35yJI02MpKBTZIK0xTJEXw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OqKumLJ4hKSaZXoaCWKyG5aEOQshi46k0QvWA8vO2U6ruYgnKRP/D0YMmCuBlsd8WOjDb9oLb9M/RxInvzhY/1AXvTGXwO/nprgUO4V47bB9yl9PJR+guWVgUuEUGNr6n57PdowgZrBOnq6IJANfgeXO41K8pJSovH49XUZRyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8662Sq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8662Sq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746BF1F000FF;
	Mon, 21 Sep 2026 20:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790021927;
	bh=ieEhb6jjY0UBH1dTCrUM3Ez15vKWo6P+jDCOL+A1+/I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g8662Sq6+M6vieBCdsrT46bpQpMP0TUgTi/3gwlLDQk6JPFNRxBodAWR52f/E0N9v
	 Dk0lOVdWTTu1opT3DIlm2LZlQKPdd32JuyQndd5DqXFzfUqdVTH4QdLqWnIyEyNw/Z
	 q0LWD+Ln22BPc1fDprE1RFZpoGnzi1taaDhInvxI0d0gsRS9WbHnzeP73+XeZGWoAk
	 hdUMTChjtgGCMWfs7TTY91KWePmS+N0lmdu9Eviaqxe2/mLe+0UFZzL+D9rsEDal1j
	 XXEkQH5Cncz/HsgnvgRAyUC1HR3Ja86c+2WrnlqDmH0VMUcfGsA3gBYmaHkUynj47g
	 FFPl5+8BwMsIg==
Content-Type: multipart/mixed; boundary="===============6412665407398203201=="
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <41b3ffb9922beb0c24d302a85752d4f82ed168fec13f6b1926e34274d9e31338@mail.kernel.org>
In-Reply-To: <20260921191407.1742386-4-puranjay@kernel.org>
References: <20260921191407.1742386-4-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v5 3/4] bpf: Add bpf_call_rcu_tasks_trace() kfunc
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org,rcu@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,harry@kernel.org,paulmck@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 20:18:45 +0000 (UTC)

--===============6412665407398203201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 8a01dd4058a03..301b35bd85c8a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4838,21 +4838,10 @@ static void bpf_rcu_run_callback(struct rcu_head *rcu)
>  	bpf_prog_put(prog);
>  }
>
> -/**
> - * bpf_call_rcu - Invoke a BPF callback after an RCU grace period
> - * @rh: struct bpf_rcu_head in a BPF map value
> - * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the values
> - * @callback: BPF subprogram, invoked as callback(map, key, value) for the value holding @rh
> - * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
> - *
> - * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held by neither a process
> - * nor bpffs, or -EBADF if the calling program is going away.
> - */
> -__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
> -			     bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
> +static int __bpf_call_rcu(struct bpf_rcu_head *rh, struct bpf_map *map, void *callback,
> +			  struct bpf_prog_aux *aux, bool trace)
>  {
>  	struct bpf_rcu_head_kern *rhk = (void *)rh;
> -	struct bpf_map *map = map__const_map;
>  	struct bpf_prog *prog;
>
>  	BUILD_BUG_ON(sizeof(struct bpf_rcu_head_kern) > sizeof(struct bpf_rcu_head));

This isn't a bug, but why does __bpf_call_rcu() take 'void *callback'
instead of keeping 'bpf_rcu_callback_t callback' like the kfunc
wrappers? The two call sites both receive a typed bpf_rcu_callback_t and
pass it into the void * parameter, which is an implicit
function-pointer-to-object-pointer conversion (accepted by gcc/clang only
because the kernel doesn't build with -Wpedantic). Keeping
'bpf_rcu_callback_t callback' would preserve type checking at the two
call sites and match the cast pattern used elsewhere in this file
(helpers.c:bpf_timer_set_callback, bpf_wq_set_callback_impl) without
costing anything.

> @@ -4872,13 +4861,50 @@ __bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
>  		return -EBADF;
>  	}
>
> -	rhk->callback_fn = (bpf_callback_t)(void *)callback;
> +	rhk->callback_fn = (bpf_callback_t)callback;
>  	rhk->map = map;
>  	rhk->prog = prog;
> -	call_rcu(&rhk->rcu, bpf_rcu_run_callback);
> +	if (trace)
> +		call_rcu_tasks_trace(&rhk->rcu, bpf_rcu_run_callback);
> +	else
> +		call_rcu(&rhk->rcu, bpf_rcu_run_callback);
>  	return 0;
>  }

This isn't a bug, but would passing the call_rcu variant (or naming the
flag 'tasks_trace') read better than a bare 'bool trace' parameter? The
only behavioural difference between the two kfuncs is which queueing
function is used, but it's carried through a 'bool trace' flag that the
reader has to trace to the bottom of the helper to interpret. The name
'trace' is also ambiguous in a BPF file where 'trace' usually means
tracing programs rather than RCU-tasks-trace.

> +/**
> + * bpf_call_rcu - Invoke a BPF callback after an RCU grace period
> + * @rh: struct bpf_rcu_head in a BPF map value
> + * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the values
> + * @callback: BPF subprogram, invoked as callback(map, key, value) for the value holding @rh
> + * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
> + *
> + * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held by neither a process
> + * nor bpffs, or -EBADF if the calling program is going away.
> + */
> +__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_map,
> +			     bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
> +{
> +	return __bpf_call_rcu(rh, map__const_map, callback, aux, false);
> +}
> +
> +/**
> + * bpf_call_rcu_tasks_trace - Invoke a BPF callback after an RCU tasks trace grace period
> + * @rh: struct bpf_rcu_head in a BPF map value
> + * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the values
> + * @callback: BPF subprogram, invoked as callback(map, key, value) for the value holding @rh
> + * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
> + *
> + * Waits for sleepable BPF programs too.  The callback itself is not sleepable either way.
> + *
> + * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held by neither a process
> + * nor bpffs, or -EBADF if the calling program is going away.
> + */
> +__bpf_kfunc int bpf_call_rcu_tasks_trace(struct bpf_rcu_head *rh, void *map__const_map,
> +					 bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
> +{
> +	return __bpf_call_rcu(rh, map__const_map, callback, aux, true);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35644498619
--===============6412665407398203201==--
