Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427454;
	b=ySYDk6U5zQkdpaLeykAGmeTHPuxsyvkaWmsHP6vT4IzImANILzIr+ckt8uKzLdF9E+uu
	 2Q2RsYaKZhCNBODYCXX3XA3q6BpS5iHNerTlhN1yGpEaPjdNwAAxjB2d+/gCH2xWlWQrJ
	 JdqJtBmHrWatR+ODK2HFXAddQO7AyhGnab1hAvHsX8JLtTZzTKZksaPW/t2s+gN0WeN6t
	 NLUniz+VtrLVHXfoG62KKBOLLWbiI7yTa8+hNh5M0MeXlZNl/TpboHl/EA0mbzWzbnx3d
	 f74xmgmKi+8T+GqZjqiZYODhOVh8dgJKya6YzjVrLbuSyz/XE7tAxLs3VK/mJ3Jav6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427454;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=IjpkERfNP71opUwd7iwJLtfA4j3auwkVI/QEm5CZuS0=;
	b=3WGmkvlFni8IoSDjg9tiWFaoxbpsUD3EAl3aO+GW09zMfLznKkMRtaz3cBsTNYNODZLa
	 jEU9H7H+97CPRPrUTO1H8b2DFlHjSFZdOLKZTGMWuvs7W0hKh+bc4WCNqE6ogCSnM/J66
	 n1RP3QyBMkGzz419itOEmLTMc0m+OGp84DRHAM8QCN6hyGwddE23ZX48TYQcuPvTsnNsx
	 4QKrG/oMXgfN3wUXlKllBkihUdR8gndobMe4r5F9isGGneJkeGfgM419BIG54dyAQCGG8
	 c2AGQTH2K+nrHXSpG2DTTWCtsy7AdZr9EBvSL1L5ixn3M3Rer/zE76pkl/IUv8NGFOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRyt2swb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF5606A31C;
	Wed, 11 Nov 2026 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRyt2swb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D191F00A05;
	Wed, 11 Nov 2026 20:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427454;
	bh=IjpkERfNP71opUwd7iwJLtfA4j3auwkVI/QEm5CZuS0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=PRyt2swbTNF10pRUkBwqDsWyVSct3rpfGJ+QP4Ko7DpXcXd76oZ0QhwGYKmxkdNBL
	 Fll3ZPVm5szN7m8IkeS71HruEOeXdUWxOwHfRgEHQRlj0pp2ugNcTKuMGk/eb6oHDv
	 gwSLpfRSXSOGcRTKhs5z4SNz+c/Yg5ZVRKhgulqmqBp6HJDSOt70ZSdtbLJyHYwkBx
	 YTRKPiIkX7/x0D1jYHlyrUVeoz11cr6PhfxEotLoMjNJVDrsHsQu51AS7vpScGIXpG
	 TknGfweZTwSUJlHaCnlW0zSGg7E7whkavbz+jIm6L4laCGp4oUE9/IGMndz8LI88pE
	 3Zd1RDf2iguyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6AD45CE08D1; Wed, 11 Nov 2026 12:04:14 -0800 (PST)
Date: Wed, 11 Nov 2026 12:04:14 -0800
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
Subject: Re: [PATCH v2 4/7] srcu: Add irqsave variants of the atomic SRCU
 readers
Message-ID: <31ba97d2-f02e-4c43-a9a6-5ed49263c511@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
 <20261111145949.70845-5-mathieu.desnoyers@efficios.com>
 <0f5b9d22-353a-4e30-91e1-aeea47461583@paulmck-laptop>
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
In-Reply-To: <0f5b9d22-353a-4e30-91e1-aeea47461583@paulmck-laptop>

On Wed, Nov 11, 2026 at 11:58:21AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 11, 2026 at 09:59:46AM -0500, Mathieu Desnoyers wrote:
> > synchronize_srcu_atomic() may be invoked with interrupts disabled, for
> > example under a raw spinlock. Its kerneldoc then requires every reader
> > of that srcu_struct to disable interrupts too. srcu_read_lock_atomic()
> > only disables preemption, so such a reader has to disable interrupts
> > itself around it.
> > 
> > Add srcu_read_lock_atomic_irqsave() and
> > srcu_read_unlock_atomic_irqrestore(). They disable interrupts instead
> > of preemption, and keep the interrupt state in a flags argument, so
> > they are macros. Both forms share the rest of the reader through
> > __srcu_read_lock_atomic() and __srcu_read_unlock_atomic().
> > 
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> (Smoke tests passed as well.)

Aside from this in the console output:

rcu_torture_nmi_cleanup: nmi_readers set but no reader ever ran in NMI, so NMI readers went untested (no PMU, or NMIs unavailable here).

Looking into it.

							Thanx, Paul

> > ---
> >  include/linux/srcu.h | 100 ++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 75 insertions(+), 25 deletions(-)
> > 
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index e3b541ceb8dd..11e9ad914a71 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -357,31 +357,15 @@ static inline int srcu_read_lock(struct srcu_struct *ssp)
> >  	return retval;
> >  }
> >  
> > -/**
> > - * srcu_read_lock_atomic - register a new reader promising an atomic section
> > - * @ssp: srcu_struct in which to register the new reader.
> > - *
> > - * As srcu_read_lock(), but the caller promises that the read-side
> > - * critical section never sleeps and never blocks on anything which
> > - * may itself depend on memory allocation to make progress. Preemption
> > - * is disabled for the duration, which both enforces that promise (any
> > - * sleepable call in the section will splat on every configuration)
> > - * and bounds the section so that the update side may spin rather
> > - * than sleep when waiting for readers: see synchronize_srcu_atomic().
> > - *
> > - * The lock and matching srcu_read_unlock_atomic() must be invoked on
> > - * the same CPU, from the same context; passing the return value to
> > - * another task is not permitted for this flavor.
> > - *
> > - * This function is NMI-safe, in a manner similar to
> > - * srcu_read_lock_nmisafe().
> > +/*
> > + * Register an atomic-section reader.  The caller has disabled preemption,
> > + * or interrupts.
> >   */
> > -static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
> > +static inline int __srcu_read_lock_atomic(struct srcu_struct *ssp)
> >  	__acquires_shared(ssp)
> >  {
> >  	int retval;
> >  
> > -	preempt_disable();
> >  	/*
> >  	 * Arm might_sleep() to catch even a *potentially* sleeping call
> >  	 * in the section, not just an actual schedule: the atomic-domain
> > @@ -406,6 +390,50 @@ static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
> >  	return retval;
> >  }
> >  
> > +/**
> > + * srcu_read_lock_atomic - register a new reader promising an atomic section
> > + * @ssp: srcu_struct in which to register the new reader.
> > + *
> > + * As srcu_read_lock(), but the caller promises that the read-side
> > + * critical section never sleeps and never blocks on anything which
> > + * may itself depend on memory allocation to make progress. Preemption
> > + * is disabled for the duration, which both enforces that promise (any
> > + * sleepable call in the section will splat on every configuration)
> > + * and bounds the section so that the update side may spin rather
> > + * than sleep when waiting for readers: see synchronize_srcu_atomic().
> > + *
> > + * The lock and matching srcu_read_unlock_atomic() must be invoked on
> > + * the same CPU, from the same context; passing the return value to
> > + * another task is not permitted for this flavor.
> > + *
> > + * This function is NMI-safe, in a manner similar to
> > + * srcu_read_lock_nmisafe().
> > + */
> > +static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
> > +	__acquires_shared(ssp)
> > +{
> > +	preempt_disable();
> > +	return __srcu_read_lock_atomic(ssp);
> > +}
> > +
> > +/**
> > + * srcu_read_lock_atomic_irqsave - register an atomic reader, interrupts off
> > + * @ssp: srcu_struct in which to register the new reader.
> > + * @flags: interrupt state to restore at srcu_read_unlock_atomic_irqrestore().
> > + *
> > + * As srcu_read_lock_atomic(), but with interrupts disabled for the
> > + * duration instead of preemption.  Use it when synchronize_srcu_atomic()
> > + * may be invoked with interrupts disabled for this srcu_struct: its
> > + * readers must then disable interrupts too.
> > + *
> > + * Returns the index to pass to srcu_read_unlock_atomic_irqrestore().
> > + */
> > +#define srcu_read_lock_atomic_irqsave(ssp, flags)			\
> > +({									\
> > +	local_irq_save(flags);						\
> > +	__srcu_read_lock_atomic((ssp));					\
> > +})
> > +
> >  /**
> >   * srcu_read_lock_fast - register a new reader for an SRCU-protected structure.
> >   * @ssp: srcu_struct in which to register the new reader.
> > @@ -598,12 +626,11 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
> >  	__srcu_read_unlock(ssp, idx);
> >  }
> >  
> > -/**
> > - * srcu_read_unlock_atomic - unregister an atomic-section reader
> > - * @ssp: srcu_struct from which to unregister the old reader.
> > - * @idx: return value from corresponding srcu_read_lock_atomic().
> > +/*
> > + * Unregister an atomic-section reader.  The caller then enables preemption,
> > + * or interrupts, again.
> >   */
> > -static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
> > +static inline void __srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
> >  	__releases_shared(ssp)
> >  {
> >  	WARN_ON_ONCE(idx & ~0x1);
> > @@ -612,9 +639,32 @@ static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
> >  	__srcu_read_unlock_nmisafe(ssp, idx);
> >  	if (in_task())
> >  		non_block_end();
> > +}
> > +
> > +/**
> > + * srcu_read_unlock_atomic - unregister an atomic-section reader
> > + * @ssp: srcu_struct from which to unregister the old reader.
> > + * @idx: return value from corresponding srcu_read_lock_atomic().
> > + */
> > +static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
> > +	__releases_shared(ssp)
> > +{
> > +	__srcu_read_unlock_atomic(ssp, idx);
> >  	preempt_enable();
> >  }
> >  
> > +/**
> > + * srcu_read_unlock_atomic_irqrestore - unregister an irqsave atomic reader
> > + * @ssp: srcu_struct from which to unregister the old reader.
> > + * @idx: return value from corresponding srcu_read_lock_atomic_irqsave().
> > + * @flags: interrupt state saved by srcu_read_lock_atomic_irqsave().
> > + */
> > +#define srcu_read_unlock_atomic_irqrestore(ssp, idx, flags)		\
> > +do {									\
> > +	__srcu_read_unlock_atomic((ssp), (idx));			\
> > +	local_irq_restore(flags);					\
> > +} while (0)
> > +
> >  /**
> >   * srcu_read_unlock_fast - unregister a old reader from an SRCU-protected structure.
> >   * @ssp: srcu_struct in which to unregister the old reader.
> > -- 
> > 2.47.3
> > 
