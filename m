Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3991DDC33;
	Thu, 16 Jan 2025 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068226; cv=none; b=ScJp/cIifKO1jk8/XLZ6UhOOVqgx+3WqIDJ1wsVPKAR/759SZbHbOcKVgWK28QW7r6mLxdClIkgh2ocZMaXad4QwJ2bGLJ/j9JKv0j/YhZ0SYWNce5/7X6U9VPORuyzWbe1QbvCZRqZbQ6ln041hgsPfvW03QIshy7DZD5mkwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068226; c=relaxed/simple;
	bh=D6gkUcvbWkemaSiWJRQKVU3zJjh5680QzuxwzfWBGMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhfcioGDaGqGNLM7WmaesxpYxaA1Lru5PpMZSLwfr5RXmwT3GpOhH1vMPslZHjfvA9VIPNP2jALL201SfNtU7DYhTX3WAwkVX2vfzRakhY4X7XMSx1tzWPH6/nS4XoZSBtAG9deE1LScY+P4ta6oEWgsbTy2Z5fBYphh/8U7wj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKSvRbc7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKSvRbc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C43C4CED6;
	Thu, 16 Jan 2025 22:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737068225;
	bh=D6gkUcvbWkemaSiWJRQKVU3zJjh5680QzuxwzfWBGMg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mKSvRbc7jz1jL5PB7Lt3P2lS3rvEPPfxQG7CplpIbciL4edBiqX2rtPmOOY0pP0Kc
	 utS4/KeG32n0SwAxEnK0dMJ212n6yRrFpRU0Ea8x7vS0frRcaFczw6JaTjs3njkIKj
	 NYYnSuIh/iWXEUa2G2KKoPuyyIPa//dZqKhnk1y/+PXFU99IoyNV9ZqnDWQi1XIh9O
	 KxKpi+IZQn8OHzle3ES7wVWI40av9HpIqdMP6c0NXXlsRBSNPW7Ai3dH8+hpXfT6UL
	 h2jkdRjPXGH22TlSQr3SScRRzyqbF+wa5yibLYX1bjD/nWK0d/xIrEPldSq7r1j68H
	 UZsvpLKnPNzmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4B03FCE1D3A; Thu, 16 Jan 2025 14:57:05 -0800 (PST)
Date: Thu, 16 Jan 2025 14:57:05 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH rcu 2/7] docs: Improve discussion of this_cpu_ptr(), add
 raw_cpu_ptr()
Message-ID: <bb593aba-7f0c-4f14-abc9-2e6414630490@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
 <20250116200239.3782374-2-paulmck@kernel.org>
 <Z4lz2CC7SLgSp90y@casper.infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4lz2CC7SLgSp90y@casper.infradead.org>

On Thu, Jan 16, 2025 at 09:02:16PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 16, 2025 at 12:02:34PM -0800, Paul E. McKenney wrote:
> > +The special cases where it makes sense do obtain a per-CPU pointer in
> 
> s/do/to/
> 
> > +preemptible code are addressed by raw_cpu_ptr(), but please note that such
> 
> s/please note that //

Good eyes, thank you!  I am a bit sorry to see the "please note that"
go, but I suppose fewer words is a good thing.

I will fix these on my next rebase and repost.

							Thanx, Paul

> > +use cases need to handle cases where two different CPUs are accessing
> > +the same per cpu variable, which might well be that of a third CPU.
> > +These use cases are typically performance optimizations.  For example,
> > +SRCU implements a pair of counters as a pair of per-CPU variables,
> > +and rcu_read_lock_nmisafe() uses raw_cpu_ptr() to get a pointer to some
> > +CPU's counter, and uses atomic_inc_long() to handle migration between
> > +the raw_cpu_ptr() and the atomic_inc_long().
