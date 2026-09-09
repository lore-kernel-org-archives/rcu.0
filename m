Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35683D73;
	Wed,  9 Sep 2026 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912677; cv=none; b=VsRVMcg7fjtc23cyvO3Ht4caZ9AL86gGolcAJ5QtVMpzVV2Gbu9uUiZEFk8ppawpIiTLS9x18httCyOYnFxn0WbdMyB3WgrdWoKF/QopOvyW4s2L966MIrIcLHeeRnkutBfE/6M4pJ7EBeN/QvpeekJiQOaUZJCXKXF4cs8aopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912677; c=relaxed/simple;
	bh=dJa9HUkaBal+up+nWV85PUu4RjYdWZg1/9F76Cc/Xlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl/E/KFpLGU0Z6wzdvpyo2jDWOonHyAorB/EtfB9SaRiqOeaX5mIgw/V9nl+V2W19EGsj3a6acyzCPcoGvHaAaeJQ+jyLa3Bplu26PO+DHIW1KBsuAA1nICpWLyKXubkFOCAo5+3OnNhFONqo6FUFm2zFtygKg1XAmlXEAwgatw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4hFyZrK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4hFyZrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D521F00A3A;
	Wed,  9 Sep 2026 00:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788912676;
	bh=hDDl+iv7M1Xn+bEModfYMSZRSlYzD3+cA6nxyMkR0LU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=K4hFyZrK2WfJtpw2EzC5cV3aE6WZfC65dXbw3k7TKGl22Kr2U0fVzJnGrxOwkdv0O
	 SnUhNY3EiOTmSHJh0hRLZLOy9QSPnYzCVUPhESevvjdtAx1tXkeAIQgduBNbLxVqay
	 LmLAfkSh0wgpjyRn9lzrhHBYtMZaBIzr6LNMyxU4StIIVUbM/OCKR2KqEs/9cJa9Ao
	 wKarPZYmaVd5yfq68j28/gySbFZ1IHtstjFQX2gstnowLpjmKH9zfDdmuR82fjBXeo
	 ooDVo2ApUIAQff1Cxp2fECBRRuu+SsjQ+dtqFzHQbWSupq8mMNhf6CWxSH0jxNmUAB
	 zdHbdBFrhnJ3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 06908CE18F4; Tue,  8 Sep 2026 17:11:16 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:11:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] srcu: Restrict atomic-SRCU non_block annotation to
 task context
Message-ID: <c055e8d7-806f-4028-b780-653133cca8ee@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-14-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907075829.2073224-14-kunwu.chan@linux.dev>

On Mon, Sep 07, 2026 at 03:58:29PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> srcu_read_lock_atomic() and srcu_read_unlock_atomic() arm and disarm
> might_sleep() checks via non_block_start()/non_block_end(), skipping
> hardirq so the update does not land on the interrupted task's
> ->non_block_count.
> 
> Inline softirqs run on the interrupted task's stack as well, so a
> timer callback running atomic-SRCU readers races with the interrupted
> task's own ->non_block_count updates, as KCSAN reports:
> 
> 	BUG: KCSAN: data-race in srcu_torture_read_lock / srcu_torture_read_unlock
> 
> 	write to 0xffffa00f818ea418 of 4 bytes by interrupt on cpu 0:
> 		srcu_torture_read_lock+0x422/0x470
> 		rcutorture_one_extend+0xdc/0x600
> 		rcu_torture_one_read+0xd1/0x330
> 		rcu_torture_timer+0x75/0x140
> 		call_timer_fn+0xe6/0x2f0
> 		...
> 		run_timer_softirq+0xb7/0x130
> 		handle_softirqs+0xfc/0x3f0
> 		__irq_exit_rcu+0x8e/0x100
> 
> Use in_task() so the annotation is applied only in task context; it
> is redundant elsewhere because might_sleep() already warns about
> sleeping from atomic context.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Again, good catch!  In theory, this should be squashed into the original,
but I don't know of many people bisecting with KCSAN.  I might need to
squash it later (of course with attribution), but at least for the time
being, queued for testing and further review.

							Thanx, Paul

> ---
>  include/linux/srcu.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 0de21155abc1..403fbe57ab15 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -346,11 +346,13 @@ static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
>  	/*
>  	 * Arm might_sleep() to catch even a *potentially* sleeping call
>  	 * in the section, not just an actual schedule: the atomic-domain
> -	 * promise must hold on every path, contended or not. In hardirq
> -	 * the annotation would land on the interrupted task; it is also
> +	 * promise must hold on every path, contended or not. In hardirq,
> +	 * softirq, or NMI the annotation would land on the interrupted
> +	 * task, and can also result in data races against that task's
> +	 * own non_block_start()/non_block_end() invocations; it is also
>  	 * redundant there, so skip it.
>  	 */
> -	if (!in_hardirq())
> +	if (in_task())
>  		non_block_start();
>  	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
>  	retval = __srcu_read_lock(ssp);
> @@ -562,7 +564,7 @@ static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
>  	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
>  	srcu_lock_release(&ssp->dep_map);
>  	__srcu_read_unlock(ssp, idx);
> -	if (!in_hardirq())
> +	if (in_task())
>  		non_block_end();
>  	preempt_enable();
>  }
> -- 
> 2.43.0
> 
