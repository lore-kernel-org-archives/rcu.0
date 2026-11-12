Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444328;
	b=SX0sLqsPzkXT1Hg4f+zMLE8De8y2L+JeRqw3JyPL8P6OFEa8Hu+6DtHsDNMnbK1plE0y
	 3ROxH8/WVOP0uk7uof/WEFzLOc34woBPLaLuhFsV182vE12X18M9PQhLtqCMEHpWSoobN
	 b34ZvX+yk0km/vNzcOXCxs9vaZ5EIAnF/ToNalTYSBqPE35hTzuvzpjifQlzH5mMCDccu
	 Ox/TZxcU15zK64LKGnUZwq6M/Xkb/zWgKWP6Sw6HeB4i8WANcAl65Acxk6LZotXRePTJw
	 Z9S4NrHsWlbovD10o3n2yJxel1Gi9wORc4/RJDvZr8fiXijo/2uGBY/lUunqUmm4o8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444328;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=/9/b7fpxXybSpCPhzGmeCmyKWhnWmULZFd9jZs6GAL8=;
	b=j3XE4vADzTm3yiqPfI1LlmbybSscj73luBwoQ2/UDlHITLgTIUc5UVTNRsDpVPOrRD7r
	 3eeQJmMWqwd4raBjhYmhvrVZA0OdTJQZJsJ0lAeNz2GP35+tt04CO8s/MYiqe+Rg+LRuC
	 4OJaFjBW5m2MszCnMZW8nmVWdzpfQuYpDUkyQCg5sqcR7tTRZAckJLi4VfJBcOu1+9IdH
	 H9TBuOqbo0CNC8VM6b4kTJaeCKoZj2g+fFj7DBcSxLSeCtkiCHrpu90gVq7bK5Y2209Cc
	 bCBJkMSQJPgJLnTrfJnugjPOxd6FtDugA2JSgH7Y9tPy3DsqYE5o9kNo1gVK7Ckx/tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9HOEMoi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50123606A31C;
	Thu, 12 Nov 2026 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9HOEMoi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5C51F00A05;
	Thu, 12 Nov 2026 00:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444327;
	bh=/9/b7fpxXybSpCPhzGmeCmyKWhnWmULZFd9jZs6GAL8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=g9HOEMoiLFmV0fvgqewSJFUQq1YBNtBhDKGVxlry0Db6KrH0BiZB5Whk9KaUHq4Oz
	 GsLtRNBYD+mwr4BH/I29JXeToTSqUAo2bh8kRZgdsMVC/9MgL62aP+WKLS8LLhVvd6
	 jhjxG9RyWVsvfjz+94HH4kI34lvswyDlfME6TRUlYtrsZBn9ioQjN8dRHYmS+9UvS0
	 iITMNA/eNVzu32Mad8fZ7UwuwcasBSjCGxIoju+Gh2rlGkflZD1RgSjRdF2oQXlJar
	 juGsQej+afyzqbcBOrdwhB8v/xg4fMjsxGQuCcoHpgvV8jHBuUkq+2CzuLOV1SDwNY
	 6blonGzzPPy7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94015CE08D0; Wed, 11 Nov 2026 16:45:27 -0800 (PST)
Date: Wed, 11 Nov 2026 16:45:27 -0800
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
Subject: Re: [PATCH v2 6/7] rcutorture: Test the irqsave forms of atomic SRCU
 readers
Message-ID: <8e1c9b39-84fa-484e-8e08-ad543d8d94f5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-7-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261111145949.70845-7-mathieu.desnoyers@efficios.com>

On Wed, Nov 11, 2026 at 09:59:48AM -0500, Mathieu Desnoyers wrote:
> Nothing tests srcu_read_lock_atomic_irqsave() and
> srcu_read_unlock_atomic_irqrestore(). Testing them in the normal readers
> has two obstacles. rcutorture_one_extend() ends the readers of a CPU in
> any order, but each irqrestore restores the state its own irqsave saw.
> A reader extension may also enable interrupts or bottom halves within
> a reader, which an irqsave reader forbids.
> 
> Add an atomic_irqsave module parameter. With it, the atomic readers of
> each CPU alternate between the plain and the irqsave forms. A per-CPU
> count tracks the irqsave readers: the first one saves the interrupt
> state, and only the last one restores it. The others restore the
> current state, with interrupts disabled. The irqsave readers run only
> for a torture type without reader extensions: every srcu type but
> busted_srcud. The parameter also stops readers from ending under
> ->pi_lock, which would enable interrupts under a raw spinlock.
> 
> An irqsave reader checks that interrupts are still disabled when it
> ends.
> 
> Add an atomic-srcu-irqsave run of SRCU-P to torture.sh.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Again, much improved, thank you!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

There may come a time when fault isolation requires testing *only*
atomic SRCU _irqsave(), but let's avoid complicating things unless and
until that actually happens.

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c                       | 80 +++++++++++++++++--
>  .../selftests/rcutorture/bin/torture.sh       |  6 ++
>  2 files changed, 81 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 9889293c968b..2ec461414263 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -61,6 +61,8 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@
>  #define RCUTORTURE_RDR_MASK_1	(0xff << RCUTORTURE_RDR_SHIFT_1)
>  #define RCUTORTURE_RDR_SHIFT_2	16	// Put SRCU index in upper bits.
>  #define RCUTORTURE_RDR_MASK_2	(0xff << RCUTORTURE_RDR_SHIFT_2)
> +#define SRCU_TORTURE_IRQSAVE	0x80	// In an SRCU reader index (MASK_1 or _2):
> +					//  the atomic reader disabled interrupts.
>  #define RCUTORTURE_RDR_BH	0x01	// Extend readers by disabling bh.
>  #define RCUTORTURE_RDR_IRQ	0x02	//  ... disabling interrupts.
>  #define RCUTORTURE_RDR_PREEMPT	0x04	//  ... disabling preemption.
> @@ -134,6 +136,8 @@ torture_param(int, preempt_interval, MSEC_PER_SEC, "Interval between preemptions
>  torture_param(int, read_exit_delay, 13, "Delay between read-then-exit episodes (s)");
>  torture_param(int, read_exit_burst, 16, "# of read-then-exit bursts per episode, zero to disable");
>  torture_param(int, reader_flavor, SRCU_READ_FLAVOR_NORMAL, "Reader flavors to use, one per bit.");
> +torture_param(bool, atomic_irqsave, false,
> +	      "Atomic SRCU readers alternate per CPU with irqsave readers");
>  torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
>  torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
>  torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
> @@ -732,6 +736,69 @@ static void srcu_torture_init_forbidden_apis(void)
>  	cur_ops->start_gp_poll = NULL;
>  }
>  
> +/*
> + * With atomic_irqsave, every other atomic SRCU reader of a CPU disables
> + * interrupts instead of preemption.  rcutorture_one_extend() may end the
> + * readers of a CPU in any order, so the first one saves the interrupt state
> + * and the last one restores it.  No extension may enable interrupts or bottom
> + * halves within such a reader.  So the irqsave readers run only for a torture
> + * type without extendables: every srcu type but busted_srcud.  No reader may
> + * end under ->pi_lock.
> + */
> +static bool srcu_torture_irqsave_on;
> +
> +struct srcu_torture_irqsave {
> +	unsigned int count;	// Picks the form of the next reader.
> +	int depth;		// Readers of this CPU that disabled interrupts.
> +	unsigned long flags;	// Interrupt state before the first one.
> +};
> +
> +static DEFINE_PER_CPU(struct srcu_torture_irqsave, srcu_torture_irqsave);
> +
> +static void srcu_torture_init_irqsave(void)
> +{
> +	if (!atomic_irqsave || !(reader_flavor & SRCU_READ_FLAVOR_ATOMIC) ||
> +	    cur_ops->extendables)
> +		return;
> +	srcu_torture_irqsave_on = true;
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
> +	if (!srcu_torture_irqsave_on || in_nmi() ||
> +	    !(this_cpu_inc_return(srcu_torture_irqsave.count) & 0x1))
> +		return srcu_read_lock_atomic(srcu_ctlp);
> +	idx = srcu_read_lock_atomic_irqsave(srcu_ctlp, flags);
> +	stip = this_cpu_ptr(&srcu_torture_irqsave);
> +	if (!stip->depth++)
> +		stip->flags = flags;
> +	return idx | SRCU_TORTURE_IRQSAVE;
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
> @@ -751,6 +818,7 @@ static void srcu_torture_init(void)
>  		srcu_ctlp = &srcu_ctla;
>  		VERBOSE_TOROUT_STRING("srcu_torture_init atomic SRCU");
>  		srcu_torture_init_forbidden_apis();
> +		srcu_torture_init_irqsave();
>  	}
>  }
>  
> @@ -790,9 +858,9 @@ static int srcu_torture_read_lock(void)
>  		ret += idx << 3;
>  	}
>  	if (reader_flavor & SRCU_READ_FLAVOR_ATOMIC) {
> -		idx = srcu_read_lock_atomic(srcu_ctlp);
> -		WARN_ON_ONCE(idx & ~0x1);
> -		ret += idx << 4;
> +		idx = srcu_torture_read_lock_atomic();
> +		WARN_ON_ONCE(idx & ~(0x1 | SRCU_TORTURE_IRQSAVE));
> +		ret += ((idx & 0x1) << 4) | (idx & SRCU_TORTURE_IRQSAVE);
>  	}
>  	return ret;
>  }
> @@ -832,9 +900,10 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
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
> @@ -1019,6 +1088,7 @@ static void srcud_torture_init(void)
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
