Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350001;
	b=XXVRvW3vz7YAv60KFdOXEg3T5P//1Xf+mzoWL550xrmBAb18QKv7/TOnG51GSjpqzIeb
	 xPH3ce/FVhdZlZBjaAV6uUcxLvjoRajXqF+qCh8d1qDI90ovSPe+8Dqfu43QOW4X3wR2O
	 NNidESbNlaAVyDJqRUWBWN5Av5Z4/erMRCYl5zZITaBbp/t2TpY1yaSjUxAcb8p1DmoZl
	 kEZb4sEmFi99RJpklNhsJuMO0xrfs/rVtSu/ZNarK/JEvc9NOeKzWTsqPzRJko+EhBdYj
	 3hVuwb6aQsMgEszQj4/GHVUR3qTTz1fs1Q1pPJTzo0fPHrPQdFNERxfYZQCCKxjYyOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350001;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=zopaHLECtAzs0t7Y+r9amCCO9vxys7iT8zS0YAqRjxw=;
	b=MNJS0H3px8RP14D0E9qqc1NoxnltMlkiYLl6WZPp9lqC+71o2QlJaZ67dSwHDdPJbhUh
	 h7gII7riHTn8xPJTf3vBwn+VY6nalMVGPk13Ub8aXB1wRG5JiITF6VzTIlGlB6hNAy9fS
	 gg9N2irHtzDopNNZ7AH8xa/3nUAY3/mW2wnFjxTlJJIY0ccJ2/NWRxFRqUxCtCl3GwXIM
	 4otUTkjkrCzPExYRM1EJH5G0iAi00C8JiQ5ETe+i9PcqEQbF/lQBweXyYUmR9q7a05RBS
	 U30L9eBEcyzEAsAVWYXA6mac8m/eNrqTawqn8o/ZaMWGGtguPAxIyfVKjQ/+yslHqCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fa10qCTY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA9606A31C;
	Tue, 10 Nov 2026 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fa10qCTY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CB11F008A2;
	Tue, 10 Nov 2026 22:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350001;
	bh=zopaHLECtAzs0t7Y+r9amCCO9vxys7iT8zS0YAqRjxw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=fa10qCTYXhcOaA9fVK3T2jVuMb3bAxg/1QILqPVsy2LvWQBTqlvGH/r45dI4lYRqA
	 lr5lY7byPdgxuHxkkBjIevJ4Y7cr3aLCkT74x7WQA+27GiZd9C/hIAs+vRVDNOofYo
	 4CtOo+L6MB4GcMnow8a0ZS/laco1XEcW6mh1vv28i3ZpL1jv80ZoReNagJDnrObXSQ
	 0zqeWvcgPd9k172SDS9OZpnHzm0kY9GpoPhqEmgcWBAmLE3UMDe3Jiup930ClYBmXo
	 AFBbycCFFmuN471/TgBhdIne8HfoaZ0UOSoTnLW3OJ7vzkAcNdR7Vn9mOzaFi0AyzS
	 Goh64YHoR8KEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A89DACE0AD8; Tue, 10 Nov 2026 14:33:20 -0800 (PST)
Date: Tue, 10 Nov 2026 14:33:20 -0800
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
Subject: Re: [PATCH 4/4] rcutorture: Test the irqsave forms of atomic SRCU
 readers
Message-ID: <42972bc1-721c-4bdb-8599-10f6f30cd89d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261110192844.44713-1-mathieu.desnoyers@efficios.com>
 <20261110192844.44713-5-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261110192844.44713-5-mathieu.desnoyers@efficios.com>

On Tue, Nov 10, 2026 at 02:28:44PM -0500, Mathieu Desnoyers wrote:
> Nothing tests srcu_read_lock_atomic_irqsave() and
> srcu_read_unlock_atomic_irqrestore(). Testing them in the normal readers
> has two obstacles. rcutorture_one_extend() ends the readers of a CPU in
> any order, but each irqrestore restores the state its own irqsave saw.
> It also enables interrupts and bottom halves within readers, which an
> irqsave reader forbids.
> 
> Add an atomic_irqsave module parameter. With it, half the atomic
> readers use the irqsave forms, alternating per CPU. A per-CPU count
> tracks these readers: the first one saves the interrupt state, and only
> the last one restores it. The others restore the current state, with
> interrupts disabled. The parameter also removes the bottom-half and
> interrupt reader extensions, and the reader end under ->pi_lock, which
> would enable interrupts under a raw spinlock.
> 
> An irqsave reader checks that interrupts are still disabled when it
> ends.
> 
> Add an atomic-srcu-irqsave run of SRCU-P to torture.sh.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Cute trick with the per-CPU variable for the flags value!  ;-)

A few questions and comments below.

I am pulling this series in for testing and further review, but I do
understand that it might need to be replaced by a later version.

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c                       | 74 +++++++++++++++++--
>  .../selftests/rcutorture/bin/torture.sh       |  6 ++
>  2 files changed, 75 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 3b9c08a094cd..99dde988f974 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -134,6 +134,7 @@ torture_param(int, preempt_interval, MSEC_PER_SEC, "Interval between preemptions
>  torture_param(int, read_exit_delay, 13, "Delay between read-then-exit episodes (s)");
>  torture_param(int, read_exit_burst, 16, "# of read-then-exit bursts per episode, zero to disable");
>  torture_param(int, reader_flavor, SRCU_READ_FLAVOR_NORMAL, "Reader flavors to use, one per bit.");
> +torture_param(bool, atomic_irqsave, false, "Half the atomic SRCU readers disable irqs");

What happens if there is only one reader?  Hey, you knew that this
question was coming!  ;-)

(And I see the use of ->count below.)

>  torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
>  torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
>  torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
> @@ -728,6 +729,66 @@ static void srcu_torture_init_forbidden_apis(void)
>  	cur_ops->start_gp_poll = NULL;
>  }
>  
> +/*
> + * With atomic_irqsave, half the atomic SRCU readers disable interrupts instead
> + * of preemption.  rcutorture_one_extend() may end the readers of a CPU in any
> + * order, so the first one saves the interrupt state and the last one restores
> + * it.  An extension must then neither enable interrupts nor enable bottom
> + * halves within such a reader, and no reader may end under ->pi_lock.
> + */

Good point:  SRCU does not flatten readers by default, but you really
need to for the _irqsave() case.

> +#define SRCU_TORTURE_IRQSAVE	0x20	// The reader disabled interrupts.

Is this supposed to slot into the RCUTORTURE_RDR_* bit positions?
If so, it is overwriting RCUTORTURE_RDR_RCU_1.  Or is this a trick
that you are using to make half of the readers disable interrupts?
If so, let's please make this more explicit and more obvious to someone
(like yourself) who might be reading the RCUTORTURE_RDR_* bit position
definitions some time in the future.  ;-)

Except...  The rule is that RCUTORTURE_RDR_RCU_2 cannot be set unless
RCUTORTURE_RDR_RCU_1 is also set.  So there needs to be some other way
to get the "half the readers doing _irqsave()" effect.  (And I now see
the use of ->count below.)

If this is independent of the RCUTORTURE_RDR_* bit positions, why
the 0x20?

> +struct srcu_torture_irqsave {
> +	unsigned int count;	// Picks the form of the next reader.

Like maybe this count being odd or even, for example.  ;-)

And I do see below that this is in fact the strategy.  Very good!

> +	int depth;		// Readers of this CPU that disabled interrupts.
> +	unsigned long flags;	// Interrupt state before the first one.
> +};
> +
> +static DEFINE_PER_CPU(struct srcu_torture_irqsave, srcu_torture_irqsave);
> +
> +static void srcu_torture_init_irqsave(void)
> +{
> +	if (!atomic_irqsave || !(reader_flavor & SRCU_READ_FLAVOR_ATOMIC))
> +		return;
> +	cur_ops->extendables &= ~(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH |
> +				  RCUTORTURE_RDR_IRQ);

All the "srcu*" torture types implicitly set ->extendables to zero, so
you shouldn't need this.  The exception is the "busted_srcud" torture
type, which is supposed to fail anyway.  Or is "busted_srcud" the case
that this code is trying to handle?

If so, an alternative approach would be to only do the _irqsave()
readers when ->extendables is equal to zero.  Which is admittedly still
a bit hacky.

> +	cur_ops->no_pi_lock = 1;
> +	VERBOSE_TOROUT_STRING("srcu_torture_init atomic SRCU, irqsave readers");
> +}
> +
> +static int srcu_torture_read_lock_atomic(void)
> +{
> +	struct srcu_torture_irqsave *stip;
> +	unsigned long flags;
> +	int idx;
> +
> +	if (!atomic_irqsave || in_nmi() || !(this_cpu_inc_return(srcu_torture_irqsave.count) & 0x1))

The suggestion above would add "|| cur_ops->extendables" to the above
condition.  Atomic SRCU readers are a bit heavyweight, so the extra
runtime overhead should not be a concern.

> +		return srcu_read_lock_atomic(srcu_ctlp);
> +	idx = srcu_read_lock_atomic_irqsave(srcu_ctlp, flags);
> +	stip = this_cpu_ptr(&srcu_torture_irqsave);
> +	if (!stip->depth++)
> +		stip->flags = flags;
> +	return idx | SRCU_TORTURE_IRQSAVE;

OK, so the value of 0x20 instead goes into RCUTORTURE_RDR_MASK_1 and
maybe also into RCUTORTURE_RDR_MASK_2, correct?

If so, it would be good to define SRCU_TORTURE_IRQSAVE somewhere near
the definitions of RCUTORTURE_RDR_MASK_1 and RCUTORTURE_RDR_MASK_2.

/me scratches his head trying to think why 0x20 instead of 0x2, 0x10,
or whatever...

Ah, because there are five reader flavors, which consume bits 0x1 through
0x10.  But we have been adding reader flavors at a surprisingly fast clip.
Might you therefore be willing to instead consider the value 0x80?

> +}
> +
> +static void srcu_torture_read_unlock_atomic(int idx)
> +{
> +	struct srcu_torture_irqsave *stip;
> +	unsigned long flags;
> +
> +	if (!(idx & SRCU_TORTURE_IRQSAVE)) {
> +		srcu_read_unlock_atomic(srcu_ctlp, idx);
> +		return;
> +	}
> +	idx &= ~SRCU_TORTURE_IRQSAVE;
> +	WARN_ON_ONCE(!irqs_disabled());  // Its section must be interrupts-off.
> +	stip = this_cpu_ptr(&srcu_torture_irqsave);
> +	local_save_flags(flags);  // Disabled: keep it so for the other readers.
> +	if (!WARN_ON_ONCE(stip->depth <= 0) && !--stip->depth)
> +		flags = stip->flags;
> +	srcu_read_unlock_atomic_irqrestore(srcu_ctlp, idx, flags);
> +}
> +
>  static void srcu_torture_init(void)
>  {
>  	rcu_sync_torture_init();
> @@ -747,6 +808,7 @@ static void srcu_torture_init(void)
>  		srcu_ctlp = &srcu_ctla;
>  		VERBOSE_TOROUT_STRING("srcu_torture_init atomic SRCU");
>  		srcu_torture_init_forbidden_apis();
> +		srcu_torture_init_irqsave();
>  	}
>  }
>  
> @@ -786,9 +848,9 @@ static int srcu_torture_read_lock(void)
>  		ret += idx << 3;
>  	}
>  	if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC) {
> -		idx = srcu_read_lock_atomic(srcu_ctlp);
> -		WARN_ON_ONCE(idx & ~0x1);
> -		ret += idx << 4;
> +		idx = srcu_torture_read_lock_atomic();
> +		WARN_ON_ONCE(idx & ~(0x1 | SRCU_TORTURE_IRQSAVE));
> +		ret += ((idx & 0x1) << 4) | (idx & SRCU_TORTURE_IRQSAVE);

This bit manipulation is getting a bit ornate, but that is a separate
issue and can be dealt with later.  And who knows?  This might be optimal.

>  	}
>  	return ret;
>  }
> @@ -828,9 +890,10 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
>  
>  static void srcu_torture_read_unlock(int idx)
>  {
> -	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
> +	WARN_ON_ONCE((reader_flavor && (idx & ~(reader_flavor | SRCU_TORTURE_IRQSAVE))) ||
> +		     (!reader_flavor && (idx & ~0x1)));
>  	if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC)
> -		srcu_read_unlock_atomic(srcu_ctlp, (idx & 0x10) >> 4);
> +		srcu_torture_read_unlock_atomic(((idx & 0x10) >> 4) | (idx & SRCU_TORTURE_IRQSAVE));
>  	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
>  		srcu_read_unlock_fast_updown(srcu_ctlp,
>  					     __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
> @@ -1015,6 +1078,7 @@ static void srcud_torture_init(void)
>  		WARN_ON(init_srcu_struct_atomic(&srcu_ctld));
>  		VERBOSE_TOROUT_STRING("srcud_torture_init atomic SRCU");
>  		srcu_torture_init_forbidden_apis();
> +		srcu_torture_init_irqsave();
>  	} else {
>  		WARN_ON(init_srcu_struct(&srcu_ctld));
>  	}
> diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
> index e7b578ec152f..18a03fad1038 100755
> --- a/tools/testing/selftests/rcutorture/bin/torture.sh
> +++ b/tools/testing/selftests/rcutorture/bin/torture.sh
> @@ -519,6 +519,12 @@ then
>  	torture_set "atomic-srcu" tools/testing/selftests/rcutorture/bin/kvm.sh \
>  		--allcpus --duration "$duration_rcutorture" \
>  		--configs "$configs_atomic_srcu" --trust-make
> +
> +	# Half the readers then use srcu_read_lock_atomic_irqsave().
> +	torture_bootargs="rcutorture.reader_flavor=0x10 rcutorture.atomic_irqsave=1"
> +	torture_set "atomic-srcu-irqsave" tools/testing/selftests/rcutorture/bin/kvm.sh \
> +		--allcpus --duration "$duration_rcutorture" \
> +		--configs "SRCU-P" --trust-make
>  fi
>  
>  if test "$do_locktorture" = "yes"
> -- 
> 2.47.3
> 
