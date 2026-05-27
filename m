Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67D837AA74;
	Wed, 27 May 2026 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923065; cv=none; b=IoiNQ944ISIM2xxioB/lSBAhf2rYaJEH/jp/Vf1uqAIRa4diaSf3CcMAsxUZOrgAEXHaljefv1054cjpFblSHyVNZk4BgZK+sCQr4OfAA0YBCc9eeTLGXCTDxILyjcEgPqpyCimMYNmzdaVn1zl/uQ86QW+pYyfAlp5FEtgyjWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923065; c=relaxed/simple;
	bh=tQk6OjFqe2+nu/geqwaOg8sQIHtrwTElLWcxXSN8Aao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcO6cgrySrS2hh287haR/pxY5Q4X93dZRWTZYYY4Qch51OA0arDbPq4qg6Z9LqadQ75639AOjgp4eiQNUjjj67kD/wrOzrt/FJsyo4Er/IemO8nwAovHnxvhAI25KaprSabMHCV90g6laW2sxHx4dJO41QNTMtrc62l/hdj5Kh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zlj3gOIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zlj3gOIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F3A1F000E9;
	Wed, 27 May 2026 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779923064;
	bh=2ChBHa+BoJ8ao9YwCXxCg7JozSuAkaranfmYAvbamg8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Zlj3gOIN/AMK/Q8dma33x3bMDDpVs6/SbxIH0b8DBr42aLNh0bLBhvaHysYz7+7pJ
	 dZOj5Fu8iKFnzz0lgxxAMa8xDVFsJBe+Iram3YBkyaxhzrZaC71s3eE6vh4qhRJY3J
	 ithCeDnn55DjElHnn23qjjQbeEGjDmP1QwYaZIELIfBN6kxfKpUtpi2Jo4fPKoZ8MR
	 54fZU3tzMRIuLP1k5cdd9ZeD132zcrJxEiwbzG6e1AFcr5PUNBLWsTmWbukXTlQmyY
	 Jylb+1YXm0Nk41ZL9Cr6DqIZsoiG/QsfQpDwkjKbMWy/xtToKjkYyGnKNfItzSrNo+
	 yPu9PNjrTgH0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 063E0CE10CD; Wed, 27 May 2026 16:04:24 -0700 (PDT)
Date: Wed, 27 May 2026 16:04:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojeda@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org,
	fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v5 2/4] srcu: expose srcu_readers_active()
Message-ID: <64996cd8-2cbc-44bf-a9b6-3683cf7b6f2c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260527174120.510447-1-work@onurozkan.dev>
 <20260527174120.510447-3-work@onurozkan.dev>
 <ahdH6uMgAwd9KTAU@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahdH6uMgAwd9KTAU@tardis.local>

On Wed, May 27, 2026 at 12:37:14PM -0700, Boqun Feng wrote:
> On Wed, May 27, 2026 at 08:40:43PM +0300, Onur Özkan wrote:
> > Move srcu_readers_active() from kernel/rcu/srcutree.c into
> > include/linux/srcu.h so it can be reused by Rust SRCU helpers.
> > 
> > Provide a CONFIG_TINY_SRCU implementation in the header as well
> > so the helper is available regardless of the selected SRCU backend.
> > 
> > This is needed by rust/helpers/srcu.c which now adds
> > rust_helper_srcu_readers_active() as a wrapper around the SRCU helper
> > for Rust callers.
> > 
> > Signed-off-by: Onur Özkan <work@onurozkan.dev>
> > ---
> >  include/linux/srcu.h  | 29 +++++++++++++++++++++++++++++
> >  kernel/rcu/srcutiny.c |  2 +-
> >  kernel/rcu/srcutree.c | 25 -------------------------
> >  rust/helpers/srcu.c   |  5 +++++
> >  4 files changed, 35 insertions(+), 26 deletions(-)
> > 
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 81b1938512d5..5ca35efb4536 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -92,6 +92,35 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
> >  void cleanup_srcu_struct(struct srcu_struct *ssp);
> >  void synchronize_srcu(struct srcu_struct *ssp);
> >  
> > +/**
> > + * srcu_readers_active - returns true if there are readers, and false otherwise
> > + * @ssp: which srcu_struct to count active readers (holding srcu_read_lock).
> > + *
> > + * Note that this is not an atomic primitive, and can therefore suffer
> > + * severe errors when invoked on an active srcu_struct. That said, it can be
> > + * useful as an error check at cleanup time.
> > + */
> > +static inline bool srcu_readers_active(struct srcu_struct *ssp)
> > +{
> > +#ifdef CONFIG_TINY_SRCU
> 
> Having a "#ifdef" in a function body is generally considered as bad code
> (I know we have some of these in rust helpers, but helpers are a bit
> special and maybe we should clean them up). So could you move this
> function into include/linux/srcutiny.h and include/linux/srcutree.h?

What Boqun said, please!

							Thanx, Paul

> Thanks!
> 
> Regards,
> Boqun
> 
> > +	return READ_ONCE(ssp->srcu_lock_nesting[0]) || READ_ONCE(ssp->srcu_lock_nesting[1]);
> > +#else
> > +	int cpu;
> > +	unsigned long sum = 0;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> > +
> > +		sum += atomic_long_read(&sdp->srcu_ctrs[0].srcu_locks);
> > +		sum += atomic_long_read(&sdp->srcu_ctrs[1].srcu_locks);
> > +		sum -= atomic_long_read(&sdp->srcu_ctrs[0].srcu_unlocks);
> > +		sum -= atomic_long_read(&sdp->srcu_ctrs[1].srcu_unlocks);
> > +	}
> > +
> > +	return sum;
> > +#endif
> > +}
> > +
> >  #define SRCU_GET_STATE_COMPLETED 0x1
> >  
> >  /**
> > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > index a2e2d516e51b..5dc26af604bf 100644
> > --- a/kernel/rcu/srcutiny.c
> > +++ b/kernel/rcu/srcutiny.c
> > @@ -85,7 +85,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
> >   */
> >  void cleanup_srcu_struct(struct srcu_struct *ssp)
> >  {
> > -	WARN_ON(ssp->srcu_lock_nesting[0] || ssp->srcu_lock_nesting[1]);
> > +	WARN_ON(srcu_readers_active(ssp));
> >  	irq_work_sync(&ssp->srcu_irq_work);
> >  	flush_work(&ssp->srcu_work);
> >  	WARN_ON(ssp->srcu_gp_running);
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 0d01cd8c4b4a..b1e97ba2e53f 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -598,31 +598,6 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
> >  	return srcu_readers_lock_idx(ssp, idx, did_gp, unlocks);
> >  }
> >  
> > -/**
> > - * srcu_readers_active - returns true if there are readers. and false
> > - *                       otherwise
> > - * @ssp: which srcu_struct to count active readers (holding srcu_read_lock).
> > - *
> > - * Note that this is not an atomic primitive, and can therefore suffer
> > - * severe errors when invoked on an active srcu_struct.  That said, it
> > - * can be useful as an error check at cleanup time.
> > - */
> > -static bool srcu_readers_active(struct srcu_struct *ssp)
> > -{
> > -	int cpu;
> > -	unsigned long sum = 0;
> > -
> > -	for_each_possible_cpu(cpu) {
> > -		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> > -
> > -		sum += atomic_long_read(&sdp->srcu_ctrs[0].srcu_locks);
> > -		sum += atomic_long_read(&sdp->srcu_ctrs[1].srcu_locks);
> > -		sum -= atomic_long_read(&sdp->srcu_ctrs[0].srcu_unlocks);
> > -		sum -= atomic_long_read(&sdp->srcu_ctrs[1].srcu_unlocks);
> > -	}
> > -	return sum;
> > -}
> > -
> >  /*
> >   * We use an adaptive strategy for synchronize_srcu() and especially for
> >   * synchronize_srcu_expedited().  We spin for a fixed time period
> > diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
> > index 79dd24a104ef..fa4b5879dda5 100644
> > --- a/rust/helpers/srcu.c
> > +++ b/rust/helpers/srcu.c
> > @@ -13,6 +13,11 @@ __rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_struct *ssp,
> >  #endif /* CONFIG_DEBUG_LOCK_ALLOC */
> >  }
> >  
> > +__rust_helper bool rust_helper_srcu_readers_active(struct srcu_struct *ssp)
> > +{
> > +	return srcu_readers_active(ssp);
> > +}
> > +
> >  __rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)
> >  {
> >  	return srcu_read_lock(ssp);
> > -- 
> > 2.51.2
> > 
