Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725EF72626;
	Wed, 23 Jul 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288138; cv=none; b=jQJZi3k9sKS0BT9DeWNyg3B+92HLddQCOMW2+msbzYowUJyKnMOotLzUyeiBde+Omq/KGkWqGCgzgB18CzZ+mb3f0wQkEK76o2KRNjhaW/x9DSWBlmwyElmXSnmvFMdFp47s49hqbAHDrAcIO0vH59C/HNM8qyqn+gf1zCxmScs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288138; c=relaxed/simple;
	bh=0Wrm2nxAS+9Eny20S2WW+KNXRRSIRc2ZHcJ0yB0Upt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tyj4fkHLs97M+TujYyPFsLHJdSiXP/UpB/6bsWEVh1wm26Vs6cDXG7+R5KDEFF/mXezTjZqzTB4CTjXTl4+oWkeqXXLglYdAA0gzfX6fMsTJyJHgg4LwHGT7knZMPazsrGloqtKJjm/nm7n+p+YVG/zQXsDg7KTc9cpHUUCUXY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSjlNz++; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSjlNz++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE14C4CEE7;
	Wed, 23 Jul 2025 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753288138;
	bh=0Wrm2nxAS+9Eny20S2WW+KNXRRSIRc2ZHcJ0yB0Upt0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=oSjlNz++axaXqwc297axNikqwbG7dy6j8InYuff7RNNxUYWNRzl2Wstf38YG9SPwR
	 /I2ScR9mErW9ypf2j6WutUsM1loghRjmkeOue+LSAuKD/kBbxBgvjrKqD2zNarrC3a
	 /viVfKmoqULxOQZ/GMPBBbJF0kfvU7bHmz9zOMytQKUC8q0sqLMqRVW8fcY02huwuK
	 aIoUhqrv6FoY2e94tyP/czhxObwS+k/s06Z8a2bptHTY8VORpSfvR97g4Qi2IoRhou
	 5sja05GfICHK+inri8RzvHeLW9MBBKeZtvipNCpQI/t7u++RXXL0wg8sydgERk5Ibs
	 gmWUYIc8qQfpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8E0BECE0AD1; Wed, 23 Jul 2025 09:28:57 -0700 (PDT)
Date: Wed, 23 Jul 2025 09:28:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 2/4] srcu: Add srcu_read_lock_fast_notrace() and
 srcu_read_unlock_fast_notrace()
Message-ID: <807686da-42af-4196-bd8e-b763f073f104@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
 <20250721162433.10454-2-paulmck@kernel.org>
 <20250722221100.GA377047@joelbox2>
 <4ac56245-3185-414d-9ee1-2c4b4c0a9d5b@paulmck-laptop>
 <4a93cf9d-f609-4819-b902-9ddce71fa821@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a93cf9d-f609-4819-b902-9ddce71fa821@efficios.com>

On Wed, Jul 23, 2025 at 11:23:33AM -0400, Mathieu Desnoyers wrote:
> On 2025-07-22 18:34, Paul E. McKenney wrote:
> > On Tue, Jul 22, 2025 at 06:11:00PM -0400, Joel Fernandes wrote:
> > > On Mon, Jul 21, 2025 at 09:24:31AM -0700, Paul E. McKenney wrote:
> > > > This commit adds no-trace variants of the srcu_read_lock_fast() and
> > > > srcu_read_unlock_fast() functions for tracing use.
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > ---
> > > >   include/linux/srcu.h | 25 +++++++++++++++++++++++++
> > > >   1 file changed, 25 insertions(+)
> > > > 
> > > > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > > > index 478c73d067f7d..7a692bf8f99b9 100644
> > > > --- a/include/linux/srcu.h
> > > > +++ b/include/linux/srcu.h
> > > > @@ -282,6 +282,20 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
> > > >   	return retval;
> > > >   }
> > > > +/*
> > > > + * Used by tracing, cannot be traced and cannot call lockdep.
> > > > + * See srcu_read_lock_fast() for more information.
> > > > + */
> > > > +static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
> > > > +	__acquires(ssp)
> > > 
> > > Should these also be marked with 'notrace' attribute?
> > > 
> > > I am not sure what the precedent is, I do see a few examples of 'notrace' and
> > > 'inline' in the same function signature though.
> > 
> > Heh!!!
> > 
> > There are six instance of static-inline notrace functions, and eight
> > instances of static-inline non-notrace functions whose names contain
> > "_notrace", not counting the srcu_read_lock_fast_notrace() and
> > srcu_read_unlock_fast() functions currently under review.
> > 
> > My guess is that I should add "notrace" to handle the possible case
> > where the compiler declines to inline this function.  I will do this
> > on the next rebase unless I hear otherwise.
> > 
> > Steven, Mathieu, thoughts?
> 
> AFAIR, the always_inline gcc attribute takes care of making sure the
> notrace is not needed in addition.
> 
> So I suspect that kernel APIs need to abide by the following rules
> to be usable by instrumentation code:
> 
> - if it's a function call, have a notrace attribute.
> - if it's an inline (which the compiler may decide to implement as a
>   function call), have a notrace attribute.
> - if it's an __always_inline, then there is no way the compiler can
>   possibly make it a function call, so the notrace would be useless
>   there.
> 
> So you may want to choose for either:
> 
> - inline notrace, or
> - __always_inline
> 
> Depending on how much freedom you want to grant the compiler with
> respect to its inlining practices.

In this case, I will (uncharacteristically) grant the compiler some
freedom.  And so notrace it is!  ;-)

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > > Other than that one nit:
> > > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > 
> > > thanks,
> > > 
> > >   - Joel
> > > 
> > > 
> > > > +{
> > > > +	struct srcu_ctr __percpu *retval;
> > > > +
> > > > +	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
> > > > +	retval = __srcu_read_lock_fast(ssp);
> > > > +	return retval;
> > > > +}
> > > > +
> > > >   /**
> > > >    * srcu_down_read_fast - register a new reader for an SRCU-protected structure.
> > > >    * @ssp: srcu_struct in which to register the new reader.
> > > > @@ -394,6 +408,17 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
> > > >   	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
> > > >   }
> > > > +/*
> > > > + * Used by tracing, cannot be traced and cannot call lockdep.
> > > > + * See srcu_read_unlock_fast() for more information.
> > > > + */
> > > > +static inline void srcu_read_unlock_fast_notrace(struct srcu_struct *ssp,
> > > > +						 struct srcu_ctr __percpu *scp) __releases(ssp)
> > > > +{
> > > > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
> > > > +	__srcu_read_unlock_fast(ssp, scp);
> > > > +}
> > > > +
> > > >   /**
> > > >    * srcu_up_read_fast - unregister a old reader from an SRCU-protected structure.
> > > >    * @ssp: srcu_struct in which to unregister the old reader.
> > > > -- 
> > > > 2.40.1
> > > > 
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
