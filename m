Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423274;
	b=DrFa/veV332uDilcYZDT3xKZeXTuL6Z3O7BI3eFZsyRuMU7jgY4BB3rG281hpmqLFegl
	 jbWYcuXSsMB7VAhxycys6h4FBZnqOkSRwK1jPGmJCEC4C1Rzq7CdkBlCG0FXedOpJ8iN5
	 3Wm40KTiAbVhZ1zCr2+3Zb4C/BD0EgvDfpzuPcOufEwF046vK0Zg25yIUS5R/slvdElGL
	 MrnlBGP6mtK2t2R35Hz+xPZ+Q0hAj9dHkNMshe+b3oJH9NQ+5oX4whil/MNkQXd3LyUny
	 iE/OtNO9buU+7+rEpv3Rb/2vrjdsXB7t8FdyaC8w3nSWhScvU3ycJN2MJxX/kpexUZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423274;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=FVxFGqq89xMyF/vdamPirocFodVGnPMoC6/DXGJ4Mag=;
	b=KDMswic5AKNiEliHaW6oDkZvKzc62kocCXtXjS+/eK/viChru/SXoUwSlvyLIqTS6vP8
	 jjk7Vg6qW1f/NenauCeS8EaUZtR84SfKbwgiz2RX78SzUesO1tq4Uvig5CtIlIeFEo2+Y
	 DQIl2CF7KG7DzoHfUfv68QyZfECnqIPsiJ+9hnW0BZdLqa7SUIIqfIz43ke1TTsHzHNJb
	 ffUIn+egEkdN2u+Tctd/1ihvUgsZIfSMFoPasj5r9lM+rXtf/nKiefZIVDvTxVCWH0B3E
	 b389z5aUJl4ZBmr87+gi7JP+xKXXtZhRVMVmjttqyQRUJyJl+Zv2WO08YFTdra7mxhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6HwPNGH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE02606A324;
	Wed, 11 Nov 2026 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6HwPNGH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CF21F00A05;
	Wed, 11 Nov 2026 18:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423274;
	bh=FVxFGqq89xMyF/vdamPirocFodVGnPMoC6/DXGJ4Mag=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=P6HwPNGHPKQk0TtZzrv2StI85lnycBf5LdceDAtSorXc0mmq4d+8csHVd843866nL
	 MOBbHQ0Ug/PjRdNH2bnXvKRVVNHFYUF/IoGfch7RyV16XyRoW0Nco6pn5Kp64RVdJB
	 GRaj7MgH/33MG+SpHDX7Maw9LgqN2i9uIZms1ZzUvvsN1PsskoO8h5S+bkLH0aFeVo
	 EZz9OeOcy1CzAVEjGCEVRkm9okEeQpywBtXPB8UVPyu5vADISVOhcPOOTcpdiXQLey
	 dVV82/P5Wgyk/9jr3W2tDTUmOEeAhj5Au85Zf+BPQqvTwizfbugE/XcuTI9F6Kuf2r
	 pJNaf18qVJ9gA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 38A80CE08D1; Wed, 11 Nov 2026 10:54:34 -0800 (PST)
Date: Wed, 11 Nov 2026 10:54:34 -0800
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
Subject: Re: [PATCH v2 2/7] srcu: Rule for using synchronize_srcu_atomic()
 from interrupt handlers
Message-ID: <19e47958-99a2-4ec7-8a6d-b23b63c78eb8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-3-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261111145949.70845-3-mathieu.desnoyers@efficios.com>

On Wed, Nov 11, 2026 at 09:59:44AM -0500, Mathieu Desnoyers wrote:
> This is about the update side.  A user that calls
> synchronize_srcu_atomic() from an interrupt handler must disable
> interrupts around all its calls on that srcu_struct, task context
> included.  Document this rule, and warn when it is broken.  The rules
> for readers are unchanged.
> 
> synchronize_srcu_atomic() spins rather than sleeps, so it may be called
> from atomic context, interrupt handlers included.  Its callers on one
> srcu_struct exclude each other with ->srcu_atomic_gp_flag.  One of them
> drives the grace period.  The others spin until a grace period ends.
> 
> The flag owner disables only preemption.  So an interrupt can arrive on
> its CPU while it holds the flag.  If that interrupt handler calls
> synchronize_srcu_atomic() on the same srcu_struct, it spins forever:
> 
>   CPU 0, task                        CPU 0, hardirq
>   synchronize_srcu_atomic()
>     takes ->srcu_atomic_gp_flag
>                                      synchronize_srcu_atomic()
>                                        spins until a grace period ends
>                                        it never ends: its driver is the
>                                        task this interrupt interrupted
> 
> Nothing reports it.  lockdep cannot, because lock_sync() records no
> interrupt state.
> 
> synchronize_srcu_atomic() cannot disable interrupts itself.  A reader
> that disables only preemption may wait for an IPI to the waiter's CPU.
> That IPI never runs while the waiter spins with interrupts disabled.
> The kernel-doc already lets the caller choose the waiter's context.
> It then asks the readers to run in that context, or a stricter one.
> 
> So the caller disables interrupts.  The existing reader rule then
> requires the readers of that srcu_struct to disable interrupts too.
> 
> Also store the owner's CPU number plus one in the flag, instead of 1.
> A waiter that finds its own CPU as the owner warns once, rather than
> hanging silently.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Nice!!!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/srcutree.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2b0e2b2d2c18..8075da4b1bb5 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -2108,6 +2108,13 @@ static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
>   * and srcu_read_unlock_atomic() must be invoked from that same context,
>   * or one that is even more strict.
>   *
> + * If synchronize_srcu_atomic() is invoked from an interrupt handler for
> + * a given srcu_struct structure, then for that structure, all calls to
> + * synchronize_srcu_atomic() must be invoked with interrupts disabled,
> + * including those from task context.  Its callers take turns to drive a
> + * grace period, and the others spin until it ends.  An interrupt handler
> + * that calls it on the CPU of an interrupted caller would spin forever.
> + *
>   * If synchronize_srcu_atomic() is invoked on a given srcu_struct
>   * structure, then none of call_srcu(), synchronize_srcu(),
>   * synchronize_srcu_expedited(), start_poll_synchronize_srcu(),
> @@ -2144,7 +2151,13 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
>  	srcu_state = get_state_synchronize_srcu(ssp);
>  	preempt_disable();
>  	while (atomic_read(&sup->srcu_atomic_gp_flag) ||
> -	       atomic_xchg(&sup->srcu_atomic_gp_flag, 1)) {
> +	       atomic_cmpxchg(&sup->srcu_atomic_gp_flag, 0,
> +			      smp_processor_id() + 1)) {
> +		// The flag holds its owner's CPU number plus one.  An owner on
> +		// this CPU is a caller that this one interrupted.  It cannot
> +		// release the flag, so this caller would spin forever.
> +		WARN_ON_ONCE(atomic_read(&sup->srcu_atomic_gp_flag) ==
> +			     smp_processor_id() + 1);
>  		preempt_enable();
>  		if (poll_state_synchronize_srcu(ssp, srcu_state))
>  			return;
> -- 
> 2.47.3
> 
