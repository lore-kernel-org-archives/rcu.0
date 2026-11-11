Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426947;
	b=0H9Ve8OTzz06ro/r2bjZI2Th9PfQ2gQBBu5+nW4NMvuX7p1lQJKhKi6HdUZJ5MlbBfdQ
	 ocVSkt0mrzMAcnwbG0xCYcv1E3u9PGLCqpF9C/wQpo970rN3b/OfVbrsbKQeKUqFzIydf
	 Sm4y1dL822WEaQ0xqKMsnThqIjVMCggHQtPtZhUeMUtQEaAVhpMWho6lEBz4scZJwvjWP
	 yA+wD8fnUZqgxo72JZC2XJ1b9G8x8sxX5XV/8UFQAYPxysKIfaO/ocAMTR4BH0BM7aYuy
	 npzz4mrXOGUN69kx+jimOL/2rw9h/0VLGbCzB9ZQOBA5VpIs75cpRHhGjHDnPHKT4EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426947;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=6bNA0Ukkyhny+gh/+wuX405ug+L/ynF/BbCiaYwvDfA=;
	b=oBTIA7q/Ib7jFawSYAc9uqGE3QZv8sFYoXmxbZnSALQ3ftqCHQ1x+tRg7iG78jd12o7A
	 HsgS8E+s9v8TNEq1ak4EqK4PPvEVITf88zpaXIOxVMIKDS3Zb/Z4F3kGz8jNRPnFCYkqg
	 95w/rt/43HBFr0+tbpzkLakC//Z3ZXCzJB8CcnFLUsaaREMFl0XL2zOzGKNvnVaad9Ozk
	 0vpHRiJNDwxK8E16YvAtXsMmdzdTbuxB4/eDXu+J8WxFIoNYtZqTABv6q2IwBnfQe7ohe
	 wa8envT4K/ljBQelIcShYsxzU8scGCdpAozhv2eTebqtdgrw9PQX02h59vgc6RBkoXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y73Tp/YG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0A606A896;
	Wed, 11 Nov 2026 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y73Tp/YG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F248E1F00A0F;
	Wed, 11 Nov 2026 19:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426947;
	bh=6bNA0Ukkyhny+gh/+wuX405ug+L/ynF/BbCiaYwvDfA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Y73Tp/YGXVsxKQeevziCAcCtO+w1VUwIAd/ibVxGoCbwS664AciSkWl0CV2ZYse1t
	 tbmeHdpUxD6AaRoKfIqpcQuIikQELdmTD5sGVJhIEi3+tGyhr/c9MCd5/K6aYz0mJH
	 7tfx8KmIRNEynz4VH38ldMVxWT4pxGYAKJQix8gxNoZHCBv49Pp5JgqlxtJ4a5oIQk
	 4md+u9jWPmh2PYYxoxLdFAIFXgQoB+zqlbDWbZ4HR0zJnAqeoewhrI8fd+NrEbqe8P
	 OwQv0lXcPVoLtX4/IcBQ6FXO49+iToAzMgnet0SudONA+lZ+fjQZFjR1gYLo2ggg9+
	 r54tTnPsKfLUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B8A9ECE08D1; Wed, 11 Nov 2026 11:55:46 -0800 (PST)
Date: Wed, 11 Nov 2026 11:55:46 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 3/7] srcu: Make atomic SRCU readers NMI-safe
Message-ID: <39f69863-032d-41b8-8d64-22eed2b62223@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-4-mathieu.desnoyers@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111145949.70845-4-mathieu.desnoyers@efficios.com>

On Wed, Nov 11, 2026 at 09:59:45AM -0500, Mathieu Desnoyers wrote:
> Atomic SRCU readers count themselves with __srcu_read_lock(), whose
> this_cpu_inc() is not NMI-safe on every architecture. With
> CONFIG_PROVE_RCU, which lockdep enables, __srcu_check_read_flavor() also
> warns when an atomic reader runs in NMI. So an NMI handler cannot use
> atomic SRCU, while a tracer or a BPF program may need to read a
> structure that atomic SRCU protects.
> 
> Count atomic readers with __srcu_read_lock_nmisafe() and
> __srcu_read_unlock_nmisafe() instead. They use NMI-safe increments on
> the architectures that need them, and keep the full barriers that
> synchronize_srcu_atomic() pairs with. The __srcu_read_lock_fast()
> helpers have no such barriers: they rely on a grace period that calls
> synchronize_rcu(), which synchronize_srcu_atomic() cannot do while it
> spins.
> 
> Also accept the atomic flavor in NMI in __srcu_check_read_flavor().
> Annotate an atomic reader in NMI as a trylock for lockdep, as
> srcu_read_lock_nmisafe() does. An NMI can interrupt lockdep itself, and
> lockdep then reports any other acquisition of a lock that a grace
> period has used.
> 
> On the architectures that need NMI-safe counters, every atomic reader
> now pays an atomic increment at lock and at unlock.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/srcu.h  | 18 ++++++++++++++----
>  kernel/rcu/srcutree.c |  3 ++-
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index d4dcaeb83e2b..e3b541ceb8dd 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -93,7 +93,7 @@ int init_srcu_struct_atomic(struct srcu_struct *ssp);
>  //					0x04		// SRCU-lite is no longer with us.
>  #define SRCU_READ_FLAVOR_FAST		0x04		// srcu_read_lock_fast(), also NMI-safe.
>  #define SRCU_READ_FLAVOR_FAST_UPDOWN	0x08		// srcu_read_lock_fast_updown().
> -#define SRCU_READ_FLAVOR_ATOMIC		0x10		// srcu_read_lock_atomic().
> +#define SRCU_READ_FLAVOR_ATOMIC		0x10		// srcu_read_lock_atomic(), also NMI-safe.
>  #define SRCU_READ_FLAVOR_ALL		(SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
>  					 SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_FAST_UPDOWN | \
>  					 SRCU_READ_FLAVOR_ATOMIC)
> @@ -372,6 +372,9 @@ static inline int srcu_read_lock(struct srcu_struct *ssp)
>   * The lock and matching srcu_read_unlock_atomic() must be invoked on
>   * the same CPU, from the same context; passing the return value to
>   * another task is not permitted for this flavor.
> + *
> + * This function is NMI-safe, in a manner similar to
> + * srcu_read_lock_nmisafe().
>   */
>  static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
>  	__acquires_shared(ssp)
> @@ -391,8 +394,15 @@ static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
>  	if (in_task())
>  		non_block_start();
>  	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
> -	retval = __srcu_read_lock(ssp);
> -	srcu_lock_acquire(&ssp->dep_map);
> +	retval = __srcu_read_lock_nmisafe(ssp);
> +	/*
> +	 * An NMI may interrupt lockdep itself.  Annotate it as a trylock
> +	 * there, as srcu_read_lock_nmisafe() does.
> +	 */
> +	if (in_nmi())
> +		rcu_try_lock_acquire(&ssp->dep_map);
> +	else
> +		srcu_lock_acquire(&ssp->dep_map);
>  	return retval;
>  }
>  
> @@ -599,7 +609,7 @@ static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
>  	WARN_ON_ONCE(idx & ~0x1);
>  	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
>  	srcu_lock_release(&ssp->dep_map);
> -	__srcu_read_unlock(ssp, idx);
> +	__srcu_read_unlock_nmisafe(ssp, idx);
>  	if (in_task())
>  		non_block_end();
>  	preempt_enable();
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 8075da4b1bb5..8fa366861dcc 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -828,7 +828,8 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
>  
>  	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
>  	WARN_ON_ONCE(read_flavor != SRCU_READ_FLAVOR_NMI &&
> -		     read_flavor != SRCU_READ_FLAVOR_FAST && in_nmi());
> +		     read_flavor != SRCU_READ_FLAVOR_FAST &&
> +		     read_flavor != SRCU_READ_FLAVOR_ATOMIC && in_nmi());
>  	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
>  
>  	sdp = raw_cpu_ptr(ssp->sda);
> -- 
> 2.47.3
> 
