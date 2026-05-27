Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8722A219E8;
	Wed, 27 May 2026 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923173; cv=none; b=fJFU8xdFaFqOGudYpXrq7gkP1tz1IWelkGTqDznvtWa/VnAvYEX7JnH7+jOW1DpeSdu0xnb1lF/fW14UK6WcQ05KwsLwxCNnEGItf7T4o4jMeHEuCw8lUSDCab8zch406bjryM1cJtiSJY0/xM2e+JQN1od4CvsXHRjubNR3Nf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923173; c=relaxed/simple;
	bh=IJSQZxnVSi+ED8R4HfGiiOKxxwuN83KgbZxB94p9DRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afRBsPciBSONfYlL1n91f3h9aGDfsth5I7be35NqmmbfX6s/qo7o9dTIxTfItdx/4mfjT3g4py9bpgOjSGfWg3j0Ofe4GbJRmRPq6TZELD0BKfzUBhsGNys/CpnL2HY4qI7ITMWY+tUNs4D2nHrgPgTTco3/Nh/Hpm6p5j/OfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1/9yNb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1/9yNb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106F91F000E9;
	Wed, 27 May 2026 23:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779923172;
	bh=afkZ1SefiJ+vZLubDiCAw2l6lSkk6cgCgCsMLrM0hw0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=A1/9yNb/YjzA1O64LTIbouUe8jm7ZV75yRK23QQzTXwMFg4iUNT7aV4C9rUGrgB59
	 xOKWc30QGZi5JjHA7cBRNfL2hpZSBIjhk5tojOnZWqnSe+ZeD8rpI7VtsH6G7oL8UO
	 aH+5KnuIzof4cJg60BeMZoRnXsMPrGKe+3Xay+MFgmrt95QiwDQmKZkS5hUc+HQ07x
	 eZhCJzb6xjIpQLw8uhnsQdiu/W2LniCw8x/Rpem3bkradQ7rr0CNI1pYVxQbtwGkeX
	 QiiOvk4TgXhg24t4iBDqbmKLmZSEIVBMvESdX6yjfWS4xUhIwcwrNtAt41pD46cOLE
	 bJdxo6+7cEegg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CE911CE10CD; Wed, 27 May 2026 16:06:11 -0700 (PDT)
Date: Wed, 27 May 2026 16:06:11 -0700
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
Subject: Re: [PATCH v6 4/4] MAINTAINERS: add Rust SRCU files to SRCU entry
Message-ID: <7bf56f66-a964-4d83-b3cd-ab1504f306d0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260527203615.163688-1-work@onurozkan.dev>
 <20260527203615.163688-5-work@onurozkan.dev>
 <ahdw348VjaX70b2x@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahdw348VjaX70b2x@tardis.local>

On Wed, May 27, 2026 at 03:31:59PM -0700, Boqun Feng wrote:
> On Wed, May 27, 2026 at 11:35:35PM +0300, Onur Özkan wrote:
> > Include Rust side implementation files to the SRCU maintainer
> > entry.
> > 
> > Signed-off-by: Onur Özkan <work@onurozkan.dev>
> 
> @Paul, could you help review this? Also the patch #2 since it changes
> the C side.
> 
> Of course, your feedbacks will be much appreciated for the whole series
> as well.

Done, though I am leaving srcu.rs to you guys, unless you have a specific
question for me.  ;-)

							Thanx, Paul

> Regards,
> Boqun
> 
> > ---
> >  MAINTAINERS | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e0b307b2108c..7739a435f258 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -24624,6 +24624,7 @@ SLEEPABLE READ-COPY UPDATE (SRCU)
> >  M:	Lai Jiangshan <jiangshanlai@gmail.com>
> >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> >  M:	Josh Triplett <josh@joshtriplett.org>
> > +M:	Onur Özkan <work@onurozkan.dev> (RUST)
> >  R:	Steven Rostedt <rostedt@goodmis.org>
> >  R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >  L:	rcu@vger.kernel.org
> > @@ -24632,6 +24633,8 @@ W:	http://www.rdrop.com/users/paulmck/RCU/
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
> >  F:	include/linux/srcu*.h
> >  F:	kernel/rcu/srcu*.c
> > +F:	rust/helpers/srcu.c
> > +F:	rust/kernel/sync/srcu.rs
> >  
> >  SMACK SECURITY MODULE
> >  M:	Casey Schaufler <casey@schaufler-ca.com>
> > -- 
> > 2.51.2
> > 
