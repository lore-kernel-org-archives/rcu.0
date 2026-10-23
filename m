Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792722170;
	b=LfHWiBPfMJTcJKEZIkSWIhK5BDQzlhEg3PDum0hlxin7H7AWeL/pbu1s5beWkxMolyan
	 VAu8jZs9sn7uIK6tLpe4pLJvnSKczL4+kk0nmDca+qEe0/n/aaVTdmTRk9bO+Y4mV/FY5
	 NetrF6QL6xVc6B8GkMWuPyu3X2x1oxAeL4ZUYO30oYRPlC6ZvTQRxagi2Vpo+u6udKVDY
	 gJz77pSvmHgbj2cyB4+OgXX3eqeiEh3QjcUTxbSeBVX8nl4lAc0/vrTIAHeWc5Hw8e9ne
	 6C5Tqxf6abmhq6UwGsyJ3Sv5/1YasDac1Pj92hWNVTwdiYfaja/GylAOdyy1AKDo1rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792722170;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=0RtgteZDA1WFIsT9Xr9286F2HyITudCx49JvOlwvwPA=;
	b=yW/Rzjtcsyxn4+xSdAj6frYVTMub74pWTQHkqhxv4SozJZEOs/qvH8AC1tIdrlWqVsFI
	 fPZa01CEudIwIxBT2R/iiYBgEzRjSERHgIKR6PdIfbD0bdQKj+krPA4sZyZc5T+u6U3mU
	 VqSusDzZpUK6zFIoXeoFrpNhLJzD8AxknEJi3YQ/f6/8JwM8lavwpJG5/OeA3M8gkd50v
	 nccYwQAEiO0LRsOiVKjY1alYFDabSlx9GX4Ghb44keXmNZ/gEcHd5pQwKoEp/whZPW3S5
	 i7H3/bBFIxofoKmNbnvPoGKN8CS9VkWyJ2ngUVvZZt70E7l+mGrGcx0B2W1Ik7CVRMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MenH73TQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0FC606A319;
	Fri, 23 Oct 2026 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MenH73TQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778361F01825;
	Fri, 23 Oct 2026 02:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792722169;
	bh=0RtgteZDA1WFIsT9Xr9286F2HyITudCx49JvOlwvwPA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=MenH73TQm1wKYaiES8UVLqHTnTcaGldSuXAjWd3BWajSz2+wQiCulzs94pfOtjmcK
	 szkYrukq4PAqfOfuuHuZwglnBntMsio4a50BC6hc4OxKU4oW2oegCXpl3cUgd3bSYd
	 VsKysDQl/or1/ZRqeu3nqtsCzhRkqzA7XEHsE4Rn6gCFqbJrA/BF+f3BjfhrCFiwMF
	 jhdL1ezSlurkcZTsUlBk5TpsXNZ/u9v0nhj85NcIfnJLsdQJAWbs5MqWvSvO0rgKJO
	 BWBmyOTxb1nJDmh5o/IjwO0Pz7e2lrn3DSBqP7y1mqmsyFZQNsZoPTfeHPK4dT/S7H
	 E9NpTHyX3tW1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 34B2BCE0A7E; Thu, 22 Oct 2026 19:22:49 -0700 (PDT)
Date: Thu, 22 Oct 2026 19:22:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 07/21] srcutree: Disable preemption across
 synchronize_srcu_atomic()
Message-ID: <586297c0-3036-46ce-b06f-19064415c5e8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
 <20261007205924.1983367-7-paulmck@kernel.org>
 <20261023001955.GA4134349@joelbox>
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
In-Reply-To: <20261023001955.GA4134349@joelbox>

On Thu, Oct 22, 2026 at 08:19:55PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On Wed, Oct 07, 2026 at 01:59:10PM -0700, Paul E. McKenney wrote:
> > Because synchronize_srcu_atomic() cannot sleep, if a pair of them run
> > concurrently pinned to the same CPU, it is possible that one will spin
> > uselessly waiting for the other while at the same time preventing that
> > other from running.  This commit therefore disables preemption to prevent
> > this failure mode.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/srcutree.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 7ff45e992c011..672fb41345c91 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -2123,11 +2123,14 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
> >  
> >  	// Perhaps others will do our work for us.
> >  	srcu_state = get_state_synchronize_srcu(ssp);
> > +	preempt_disable();
> 
> Should this be upgraded to local_irq_disable()?
> 
> 
> >  	while (atomic_read(&sup->srcu_atomic_gp_flag) ||
> >  	       atomic_xchg(&sup->srcu_atomic_gp_flag, 1)) {
> > +		preempt_enable();
> >  		if (poll_state_synchronize_srcu(ssp, srcu_state))
> >  			return;
> 
> Otherwise, it is possible that an interrupt handler comes in here while the
> srcu_atomic_gp_flag is already acquired and then spins forever?

If there is a call to synchronize_srcu_atomic() for a given srcu_struct
in an interrupt handler, then all calls to synchronize_srcu_atomic()
for that same srcu_struct must have interrupts disabled.  In addition,
all SRCU read-side critical sections for that same srcu_struct must also
have interrupts disabled.  The rule is that the SRCU readers must run
in at least as restrictive a context as the updaters.  So promoting
that preempt_disable() to local_irq_disable() might instead actually
make user usage errors harder to debug.

I believe that Kunwu's lockdep commits enforce some of these constraints,
but maybe not all of them.

> If we disabled IRQs as well, along with preempt, that might add other
> problems, though, such as a reader calling smp_call_function waiting for the
> IPI handler to run on this CPU which is spinning with interrupts disabled.

Agreed, that could be another problem.

And of course guest OSes have even more fun!

							Thanx, Paul

> thanks,
> 
> Joel Fernandes
> 
> 
> 
> 
> 
> >  		cpu_relax();
> > +		preempt_disable();
> >  	}
> >  
> >  	// One last check for others doing our work for us under the lock.
> > @@ -2135,6 +2138,7 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
> >  	if (poll_state_synchronize_srcu(ssp, srcu_state)) {
> >  		raw_spin_unlock_irq_rcu_node(sup);
> >  		atomic_set(&sup->srcu_atomic_gp_flag, 0);
> > +		preempt_enable();
> >  		return;
> >  	}
> >  
> > @@ -2152,6 +2156,7 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
> >  	}
> >  	ASSERT_EXCLUSIVE_WRITER(sup->srcu_atomic_gp_flag);
> >  	atomic_set_release(&sup->srcu_atomic_gp_flag, 0);
> > +	preempt_enable();
> >  	non_block_end();
> >  }
> >  EXPORT_SYMBOL_GPL(synchronize_srcu_atomic);
> > -- 
> > 2.40.1
> > 
