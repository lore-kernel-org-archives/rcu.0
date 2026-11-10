Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335641;
	b=48S1OPiAVGlnBIxFqdN9qkl5Cn8+bWl+17ED0JzuLi2z8uqbBDbpYfChHrg7rGnQT1sB
	 5D0nf+yeRAh//e67ki5FqEkhMhSie3scg928oJUpjAJS713iyO49XrL1NjfXFbw88QNSm
	 T+jCTuP7FB1j8b8yzORwYYBnpyJs/iZUkIpY8wqG3bRfPQ3d3Lp6KcUOvqXWAuxuQG3U3
	 6FAMe5d1He+wlLFFFgM3MDiLq7gXmuDJJkM+TpUCo8RIk4jbGNwQpXCSGvIuxSGfB4V/h
	 iRNkfFO/wg6DnaQe4tl53esaQAbKrgPl5nKFF5NG05S6scQk3kVYG/i76FYuYCe0u9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335641;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Jg5A0iY77qVWbqkVY2Nzm1SMa2Mda71LdXppl8oQAGE=;
	b=fVgHXt/HtYBccp9T54edNqitqra2RUzwa+/Qj68WaTyDTYra4vbViYoYXlmiZtrq9Xy1
	 u6nuxb1i2OzmdG1Y19X0WNRNUjk5JfKxmmZaKCAlBoi8mhondng7E2lHBps0+BkKXjA5p
	 PArklmoF/y8RebFgPSA2ztzSTHrPLgBNDhW0IWXcubtrR4Fy3X0PctpmRn4XLf81TWq2y
	 sg+8imw1e5wWCwCbWr+JUW2UvS5dRt+TMj07Ze4gS8G2oFpoay9otv/prAFP13V5U3H3k
	 sX8TUnnW/mojTbLT5gECQ4EQMyVsf979iZmFIkc+heUYBNbFvFdIgYWKfUiJeKxUkfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J4VKYkxG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F5606A320;
	Tue, 10 Nov 2026 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J4VKYkxG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6581F0089F;
	Tue, 10 Nov 2026 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335640;
	bh=Jg5A0iY77qVWbqkVY2Nzm1SMa2Mda71LdXppl8oQAGE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=J4VKYkxGUz5OIifsV7YW4V1irx7HRPZ242aaxR2fWIx8uVvgOCAxycvBfp6wSvek5
	 uUoM24ys6VCYVdBdOXhRXwYb0pYdowiw+3XXSsndylxyIx7rKqDnmmQw6fvAD/vGos
	 bkzw4V60MCiFTd1DMLdZZHgVQBXeZz3L670dmVMXGfetVdPzkjGLmUbkodIX/v6cqh
	 lJvsmBHIXqQLvVm9DmmGFPuwWK1mpJbr2IOqNNfSTpCAl5+PRM6X/OrPjt/VEgcLrX
	 ymOm4mbaiL4G19xEWofnTkQGz4ZRVj+Flt6Fj1WuGAYkQ+ypjGqI5oz23P5LRUTdMO
	 F9SslIzC6jZGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4FD42CE0AD8; Tue, 10 Nov 2026 10:34:00 -0800 (PST)
Date: Tue, 10 Nov 2026 10:34:00 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dan Carpenter <dan@cryspen.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcuscale: Constify struct rcu_scale_ops
Message-ID: <b6f19ac5-1336-43f4-8bb3-a891984adb19@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3f546f8e102ef271e7d5ac6d8b6a1f44d0fb20cb.1794085327.git.christophe.jaillet@wanadoo.fr>
 <20261108230623.GA3148953@joelbox>
 <2727df26-9f09-48c9-90b5-2d1416c3b2b1@wanadoo.fr>
 <730e60cb-30fd-43a3-8152-543b4ba5878e@paulmck-laptop>
 <avKmc-690MOAGJc5@stanley.mountain>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avKmc-690MOAGJc5@stanley.mountain>

On Tue, Nov 10, 2026 at 08:06:59AM +0300, Dan Carpenter wrote:
> On Mon, Nov 09, 2026 at 10:44:16AM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 09, 2026 at 06:32:15PM +0100, Christophe JAILLET wrote:
> > > Le 09/11/2026 à 00:06, Joel Fernandes a écrit :
> > > > On Sat, Nov 07, 2026 at 10:02:25PM +0100, Christophe JAILLET wrote:
> > > > > 'struct rcu_scale_ops' is not modified in this driver.
> > > > > 
> > > > > Constifying these structures moves some data to a read-only section, so
> > > > > increases overall security, especially when the structure holds some
> > > > > function pointers.
> > > > > 
> > > > > On a x86_64, with allmodconfig:
> > > > > Before:
> > > > > ======
> > > > >     text	   data	    bss	    dec	    hex	filename
> > > > >    45585	  24946	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
> > > > > 
> > > > > After:
> > > > > =====
> > > > >     text	   data	    bss	    dec	    hex	filename
> > > > >    46545	  23986	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
> > > > > 
> > > > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > > ---
> > > > > Compile tested only.
> > > > 
> > > > rcuscale is a test kernel module, is it worth adding boilerplate for
> > > > non-production code sighting security reasons?
> > > 
> > > Oups, now I better understand Bradley Morgan comments.
> > > 
> > > I didn't notice it was a test module.
> > > My patch makes no more sense, as it is not hardening runtime, so feel free
> > > to just drop it.
> > > 
> > > Sorry for the noise and not seeing it by myself.
> > 
> > Although the header comment does say "Read-Copy Update module-based
> > scalability-test facility", maybe there is something that should be
> > done to more clearly mark code that is not to be used in production.
> > And maybe to inform the LLM review bots of this.
> > 
> > But this is bigger than just RCU.
> 
> Christophe has been constify things for years and years.  There is
> an argument to be made that it's just the right thing to do whether
> this is test code or not.  Someone might copy and paste it, for
> example.
> 
> Of course, everyone is overloaded with AI.  I feel like normal cleanup
> patches are more likely to get NAKed because everyone is just totally
> overwhelmed.

Fair enough, though rcutorture.c (in the same directory as rcuscale.c)
*does* write to its counterpart to this structure.  The point being that
this is an optimization-like thing rather than a prohibition-like thing.

So we might want some way to differentiate between these two cases.

							Thanx, Paul
