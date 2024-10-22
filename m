Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6519EED0;
	Tue, 22 Oct 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607245; cv=none; b=Zrz6nBxpPeBsKN920gtARkxi/VFlyucXfwDfABzjnUYNhJnmwxhf977Vt46wOu92HOMQ9erHO/R6lIdlTH32N/7TDE4nz4U0hOB7Yz8sTgWiHS7f0JqX7o1KyzrcWISn9H2CGaE6dr5Qp86MlKf/V2R6CnB/Ct5rhKKpgLREHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607245; c=relaxed/simple;
	bh=UEzxQKazHQzzgN/QaewQk4OjdU31YaelViawpzg3wzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMDHukBz79tRJ/Pv5U/tddncJKomuUoizH3+zV/hPrE6cfRcQZVmB8l0wSHo+DbMNo67Pg82NRYPv1ZM5S6ZKj7fRlz7dH+PqmygWXjdQz46+6U4sdaxR8jYX0/wWl2ppVz9vISg2wSSo1s2rkYcg0OwkiQllya6jOs6u9e570Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh9/1XWb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh9/1XWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF97C4CEC3;
	Tue, 22 Oct 2024 14:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729607245;
	bh=UEzxQKazHQzzgN/QaewQk4OjdU31YaelViawpzg3wzU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Yh9/1XWbwLz1jZm4243VP+bgX+VFBonpMjZeAHYZBjvQRZDRAr73mXE+wcWSVPrqL
	 GEGcj6N8h8acagwUtNbYYffVxeZUOTcb1iKZsdg8PYoDxOsvBrRmOyA99I8oQ5cycQ
	 L8pRw7efpXh+U+QNiiXE2BRmH1CGTD2WZR1HOp0sT5QLXUbW2RKc03J6Eh3AaS3g6w
	 iOmmBgceJN5HzJLAxxH19mqqZAZwRS6PCSW3RbUhAfuOkBCuaxPnencbOjpth458yI
	 s41Nk73SxzgtxWJPpjtqCS4dSmV2sbFrRMycD2QSDWz06p2Za5bOljsxxX2RDd1kVC
	 2UN24NWQpyzLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C56DCCE0A48; Tue, 22 Oct 2024 07:27:24 -0700 (PDT)
Date: Tue, 22 Oct 2024 07:27:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, andrii@kernel.org
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <2067a019-7a85-4b9f-b162-b2cbcdd006ec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <CAEf4BzZU4ysQznVEctzijCUyuwN0TQXsxg_C16v3mmhUOzspjQ@mail.gmail.com>
 <5fbd5ff1-8cb8-425f-be5f-7ed9fe4edf1c@paulmck-laptop>
 <CAEf4BzbX5UtS=+Np5t68n8oRE2O2qGg5iDcikNFpvCTPBZU8kg@mail.gmail.com>
 <22a02204-8d14-41ae-af40-dfea79dec09d@paulmck-laptop>
 <20241022070717.GZ16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022070717.GZ16066@noisy.programming.kicks-ass.net>

On Tue, Oct 22, 2024 at 09:07:17AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 21, 2024 at 08:30:43PM -0700, Paul E. McKenney wrote:
> > Thoughts?
> 
> Thanks Paul!
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thank you, Peter!  I will apply this on my next rebase.

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > commit 4433b7d3785d8d2a700f5ed5ca234c64bc63180e
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Mon Oct 21 15:09:39 2024 -0700
> > 
> >     srcu: Guarantee non-negative return value from srcu_read_lock()
> >     
> >     For almost 20 years, the int return value from srcu_read_lock() has
> >     been always either zero or one.  This commit therefore documents the
> >     fact that it will be non-negative, and does the same for the underlying
> >     __srcu_read_lock().
> >     
> >     [ paulmck: Apply Andrii Nakryiko feedback. ]
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > 
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index bab1dae3f69e6..512a8c54ba5ba 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -238,13 +238,14 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
> >   * a mutex that is held elsewhere while calling synchronize_srcu() or
> >   * synchronize_srcu_expedited().
> >   *
> > - * The return value from srcu_read_lock() must be passed unaltered
> > - * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
> > - * the matching srcu_read_unlock() must occur in the same context, for
> > - * example, it is illegal to invoke srcu_read_unlock() in an irq handler
> > - * if the matching srcu_read_lock() was invoked in process context.  Or,
> > - * for that matter to invoke srcu_read_unlock() from one task and the
> > - * matching srcu_read_lock() from another.
> > + * The return value from srcu_read_lock() is guaranteed to be
> > + * non-negative.  This value must be passed unaltered to the matching
> > + * srcu_read_unlock().  Note that srcu_read_lock() and the matching
> > + * srcu_read_unlock() must occur in the same context, for example, it is
> > + * illegal to invoke srcu_read_unlock() in an irq handler if the matching
> > + * srcu_read_lock() was invoked in process context.  Or, for that matter to
> > + * invoke srcu_read_unlock() from one task and the matching srcu_read_lock()
> > + * from another.
> >   */
> >  static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
> >  {
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 07147efcb64d3..ae17c214e0de5 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -738,7 +738,8 @@ EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
> >  /*
> >   * Counts the new reader in the appropriate per-CPU element of the
> >   * srcu_struct.
> > - * Returns an index that must be passed to the matching srcu_read_unlock().
> > + * Returns a guaranteed non-negative index that must be passed to the
> > + * matching __srcu_read_unlock().
> >   */
> >  int __srcu_read_lock(struct srcu_struct *ssp)
> >  {
