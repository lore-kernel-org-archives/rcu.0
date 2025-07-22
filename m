Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD1B10F2;
	Tue, 22 Jul 2025 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753223693; cv=none; b=mX1p0SExpaTMPvlsgeMaFXK+pfjFyaE0fgmURULhrRbGdklzVD4zxoLGNSfSVj4Nh2dzmbjXGpv9DJt1gAzxgp7rft4a7O9/7hUTnqBxHwFwKGV7Cj/zJfPGnLVXI9qsgkuXGyEoemQocqMDEfkSA8iC8MvIriWuVGi3pqIurFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753223693; c=relaxed/simple;
	bh=Uq8hZX+2RuQJ40hGZn7xqqxwN47VM+NIVZi7mlakRJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuzmfskCsQHl1AfczbKC331TjMze5J+n7HyYmktRIYEokLkUY3DAeY8oefPd1dgH5399rfL3YyN/09MmIysiCzsQDlvYt2wq/6ksF1mfrC1IRhhj4O7yZpClgPT+PnxlIsp/dsrqBgvjcpV4h01QExF4m4E84bQpGyZ9M+kFa2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqMWKcZv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqMWKcZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7353CC4CEEB;
	Tue, 22 Jul 2025 22:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753223692;
	bh=Uq8hZX+2RuQJ40hGZn7xqqxwN47VM+NIVZi7mlakRJA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BqMWKcZvvT9auQLzW4up2KAiEmdUPk2aa177lpCx2IYDoVzN8wnP7FO96sUqGZNDZ
	 PA5gTrpg9XFX67RxJg8Moj3xm5//i4MvtIB9Z+LyK8+VrGR39xlLzug3WG8CwkC9Tf
	 t2a717fH4YaZY2BvqT1VISabXja/QbJlRUc/guE+oghbxBF6YXY/IS5ipNxgC0Zpgg
	 APZg7A2wr0uJkNY8H4BkVNNofV0cPDwS0im1d9G5tBPfUYIgDOIv26KxN4zf8iiRAH
	 IQsxTTSxeZ9m132jaZy6FDT3TslzaL0JtwOfQlcL7difVzZmelHMnXYCnOUbbslH/i
	 hYEy+OEweMvSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1DA3FCE0CF0; Tue, 22 Jul 2025 15:34:52 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:34:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 2/4] srcu: Add srcu_read_lock_fast_notrace() and
 srcu_read_unlock_fast_notrace()
Message-ID: <4ac56245-3185-414d-9ee1-2c4b4c0a9d5b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
 <20250721162433.10454-2-paulmck@kernel.org>
 <20250722221100.GA377047@joelbox2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722221100.GA377047@joelbox2>

On Tue, Jul 22, 2025 at 06:11:00PM -0400, Joel Fernandes wrote:
> On Mon, Jul 21, 2025 at 09:24:31AM -0700, Paul E. McKenney wrote:
> > This commit adds no-trace variants of the srcu_read_lock_fast() and
> > srcu_read_unlock_fast() functions for tracing use.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  include/linux/srcu.h | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 478c73d067f7d..7a692bf8f99b9 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -282,6 +282,20 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
> >  	return retval;
> >  }
> >  
> > +/*
> > + * Used by tracing, cannot be traced and cannot call lockdep.
> > + * See srcu_read_lock_fast() for more information.
> > + */
> > +static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
> > +	__acquires(ssp)
> 
> Should these also be marked with 'notrace' attribute?
> 
> I am not sure what the precedent is, I do see a few examples of 'notrace' and
> 'inline' in the same function signature though.

Heh!!!

There are six instance of static-inline notrace functions, and eight
instances of static-inline non-notrace functions whose names contain
"_notrace", not counting the srcu_read_lock_fast_notrace() and
srcu_read_unlock_fast() functions currently under review.

My guess is that I should add "notrace" to handle the possible case
where the compiler declines to inline this function.  I will do this
on the next rebase unless I hear otherwise.

Steven, Mathieu, thoughts?

							Thanx, Paul

> Other than that one nit:
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> thanks,
> 
>  - Joel
> 
> 
> > +{
> > +	struct srcu_ctr __percpu *retval;
> > +
> > +	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
> > +	retval = __srcu_read_lock_fast(ssp);
> > +	return retval;
> > +}
> > +
> >  /**
> >   * srcu_down_read_fast - register a new reader for an SRCU-protected structure.
> >   * @ssp: srcu_struct in which to register the new reader.
> > @@ -394,6 +408,17 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
> >  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
> >  }
> >  
> > +/*
> > + * Used by tracing, cannot be traced and cannot call lockdep.
> > + * See srcu_read_unlock_fast() for more information.
> > + */
> > +static inline void srcu_read_unlock_fast_notrace(struct srcu_struct *ssp,
> > +						 struct srcu_ctr __percpu *scp) __releases(ssp)
> > +{
> > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
> > +	__srcu_read_unlock_fast(ssp, scp);
> > +}
> > +
> >  /**
> >   * srcu_up_read_fast - unregister a old reader from an SRCU-protected structure.
> >   * @ssp: srcu_struct in which to unregister the old reader.
> > -- 
> > 2.40.1
> > 
