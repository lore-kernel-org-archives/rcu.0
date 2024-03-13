Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCFDA41
	for <rcu@vger.kernel.org>; Wed, 13 Mar 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340856; cv=none; b=hW5c7HviJJi/mkmhV76duUN7OOdsqGWa42reMygrsCKjdBVeH7S0spqKYhardVVwQCy5cj8xAZ910eU2yvxYepw37K/PByVMeB5ucfddoApe/XMdRhrhd64Qgfa/Wz8si/XnsmUqEfOl3VQ1H9snp90J8DYnDX5jAZsTTbrw2Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340856; c=relaxed/simple;
	bh=YSUjV/yHnDAZVgS3+ncJxNIQukG94Jfh316n+Q5XKik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIPx9acXoNewiSf3j04yDWHDuNIdWHIM+P+bXRwEaVjIwHeel/QhAONrxBbudlBopoO6AQCVcGRHys+Xych2G/n/g7eR2GjpYtVDTyx6lb7FLkwxzbF5Ewbs16jGzFPT/8yVybVEs/nUzaht3OfUm61jxLk60DJmQz9/oRXFX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=eX0ymyI5; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eX0ymyI5"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-690db6edb2bso15943056d6.2
        for <rcu@vger.kernel.org>; Wed, 13 Mar 2024 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710340853; x=1710945653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwH7Po5mYA7bjttrElAdnD+M7EOKKFjEG6xtlrYwvBg=;
        b=eX0ymyI5DeWKmGnbShb/DyQZD97bIJeXOh5GC86/Eaz6rVpzyksM13x2hLZsB7DsfX
         ZX8KT02phUVaAfGVTcGJEE37I1eUPVFZ9Iqa0heQxzgWbVfAOpoo82bwoQPpTCWwSQ3h
         FW4NnlrqntxdhWvhgT4R899DzEDYx5jhjbMgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710340853; x=1710945653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwH7Po5mYA7bjttrElAdnD+M7EOKKFjEG6xtlrYwvBg=;
        b=Hy7duYkeZG1QV+2j25/H9uZ1SX4gPK3hjc2UVEXv8cek/c/RC6AfGs6DHf1c5tXV9i
         BnLcfNGMhUs8mZqxApBIPevjBkfuGj3opCFLsr3xOV3lPVh9rkr+KK2pRYU2ILc14fqi
         awegMzNtXuM3GaINC0EzZi3zR1yVed5FUAlw7R3X5JqfYNE/3WmboCJ7VE4ZSyqpTE+D
         1rDwkRkm0lh7dtSCKnGBoYemJsY+LM+rqWUamuDhBx2USSBzZKcVcJ+f8n8XnPiJ4FZ7
         SmFXaen42VuU69DVkTj3SvC76+BJ6G9sfeH1BhV0o1UMzo3TkpcP2BZ0eBmsn+cWdZOH
         lnxw==
X-Gm-Message-State: AOJu0Yw/PI5Gyw+qY/d5+eE4oOV4eHmU9iaf5RuDfl8k2YEJ20ctKXBK
	41NAxJe64cwF9RxdSsLWxk5hCUr0/vDKwL+UkFwcvqqbimXHrtNxFjNyujAcQc0=
X-Google-Smtp-Source: AGHT+IEAg+gYeWjVfARG1jte7Q1+PT2yH9Z+ZORju1u6/8TtwosWFHanvuMw8bwEDA1gsoId9YYe9A==
X-Received: by 2002:a0c:c445:0:b0:690:de2a:3f1f with SMTP id t5-20020a0cc445000000b00690de2a3f1fmr18603qvi.32.1710340852927;
        Wed, 13 Mar 2024 07:40:52 -0700 (PDT)
Received: from [10.5.0.2] ([91.196.69.182])
        by smtp.gmail.com with ESMTPSA id c2-20020a0ceb42000000b00690cba72427sm3560137qvq.33.2024.03.13.07.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 07:40:52 -0700 (PDT)
Message-ID: <aa221e99-bf08-4d36-aef1-07ffc5e71516@joelfernandes.org>
Date: Wed, 13 Mar 2024 10:40:50 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads
 are in use
Content-Language: en-US
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, paulmck@kernel.org,
 frederic@kernel.org, josh@joshtriplett.org, boqun.feng@gmail.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang1211@gmail.com
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 neeraj.upadhyay@kernel.org
References: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Neeraj,

On 3/13/2024 4:32 AM, Neeraj Upadhyay wrote:
> When all wait heads are in use, which can happen when
> rcu_sr_normal_gp_cleanup_work()'s callback processing
> is slow, any new synchronize_rcu() user's rcu_synchronize
> node's processing is deferred to future GP periods. This
> can result in long list of synchronize_rcu() invocations
> waiting for full grace period processing, which can delay
> freeing of memory. Mitigate this problem by using first
> node in the list as wait tail when all wait heads are in use.
> While methods to speed up callback processing would be needed
> to recover from this situation, allowing new nodes to complete
> their grace period can help prevent delays due to a fixed
> number of wait head nodes.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> ---
>  kernel/rcu/tree.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9fbb5ab57c84..bdccce1ed62f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1470,14 +1470,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>   * for this new grace period. Given that there are a fixed
>   * number of wait nodes, if all wait nodes are in use
>   * (which can happen when kworker callback processing
> - * is delayed) and additional grace period is requested.
> - * This means, a system is slow in processing callbacks.
> - *
> - * TODO: If a slow processing is detected, a first node
> - * in the llist should be used as a wait-tail for this
> - * grace period, therefore users which should wait due
> - * to a slow process are handled by _this_ grace period
> - * and not next.
> + * is delayed), first node in the llist is used as wait
> + * tail for this grace period. This means, the first node
> + * has to go through additional grace periods before it is
> + * part of the wait callbacks. This should be ok, as
> + * the system is slow in processing callbacks anyway.
>   *
>   * Below is an illustration of how the done and wait
>   * tail pointers move from one set of rcu_synchronize nodes
> @@ -1725,15 +1722,17 @@ static bool rcu_sr_normal_gp_init(void)
>  		return start_new_poll;
>  
>  	wait_head = rcu_sr_get_wait_head();
> -	if (!wait_head) {
> -		// Kick another GP to retry.
> +	if (wait_head) {
> +		/* Inject a wait-dummy-node. */
> +		llist_add(wait_head, &rcu_state.srs_next);
> +	} else {
> +		// Kick another GP for first node.
>  		start_new_poll = true;
> -		return start_new_poll;
> +		if (first == rcu_state.srs_done_tail)

small nit:
Does done_tail access here need smp_load_acquire() or READ_ONCE() to match the
other users?

Also if you don't mind could you please rebase your patch on top of mine [1] ? I
think it will otherwise trigger this warning in my patch:

WARN_ON_ONCE(!rcu);

Because I always assume there to be at least 2 wait heads at clean up time.

[1] https://lore.kernel.org/all/20240308224439.281349-1-joel@joelfernandes.org/

Thanks!

 - Joel


> +			return start_new_poll;
> +		wait_head = first;
>  	}
>  
> -	/* Inject a wait-dummy-node. */
> -	llist_add(wait_head, &rcu_state.srs_next);
> -
>  	/*
>  	 * A waiting list of rcu_synchronize nodes should be empty on
>  	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
