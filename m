Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B79347533;
	Wed, 27 May 2026 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925008; cv=none; b=s8t1z0zM4JqpG8k7zxmPOCV8Q5J4qf+xMjsTbmFMs8WfFfg1neXkwVdkL5b1+QA60zT7ShqwuHsC84bbY2aBYkxSpVK36YXqVEnlXBHZJj3GpjxpDxKbY2Crv9fKpVoAXGsU2MazbSoSAJTGJ6tIEEtDykfku9bJqVeN6i0Ue4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925008; c=relaxed/simple;
	bh=4yQW63hRXMe6SkACoMZzIxOewa+2f6xgSvVFtdj2Xec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4AncBGgKHiJgG4Kyel05adQPLvcg+FuZp858XGfvXvjBeXnGL8X/snFKJ6Ltzu6GHdYdB5svIj7lXZPkBksELF6xq/hjSqQ2ihjgH0RRJNz5nkHRkh5WKs9a6k+7GQ+HDQMgMqN06apa7eWp8e0aIWCm8W2y0b4Yjwuq92NPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAvK7ey8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAvK7ey8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6171F000E9;
	Wed, 27 May 2026 23:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925006;
	bh=X516p6W9WrQNp6MaYpQ51XfZRX68E4m4wDRAnYYA/a8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=NAvK7ey869rKgOVMlJ43kXj9q8NpkWM2Ak1CGkmL0sSaGaE9dloszLs3W+q53wQpM
	 eRqkbBe2j/+wcu7khmr/vAvpZUCgx3yQpCNHQmhhuptltpOnpqs1hXqLU7g8PbZT5D
	 bTKjEBI28Gxi4NeNc0V8kiHPukz91HiUHCVSrkX73yvcor/34YQgPRxuKvOyQwSz8j
	 SJY4CqG8vMZTDaW9S5mMvCJwkXaYVcEBNwjpev5l5MJ4yxvLsg2bNGuSHH7VrQ6vxj
	 0/cMU3E02WYZ900XPyddzlyJ7a9Rse7FlZtxL1GviHTCJMp5vpPRNcuytFJBRPPg4s
	 4kALtAD1sm8qQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8EB02CE10CD; Wed, 27 May 2026 16:36:46 -0700 (PDT)
Date: Wed, 27 May 2026 16:36:46 -0700
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
Message-ID: <56c61a78-b6ab-4f98-aabf-f6a6a8d562dd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260527203615.163688-1-work@onurozkan.dev>
 <20260527203615.163688-5-work@onurozkan.dev>
 <ahdw348VjaX70b2x@tardis.local>
 <7bf56f66-a964-4d83-b3cd-ab1504f306d0@paulmck-laptop>
 <ahd8u-GGfpT03qsj@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahd8u-GGfpT03qsj@tardis.local>

On Wed, May 27, 2026 at 04:22:35PM -0700, Boqun Feng wrote:
> On Wed, May 27, 2026 at 04:06:11PM -0700, Paul E. McKenney wrote:
> > On Wed, May 27, 2026 at 03:31:59PM -0700, Boqun Feng wrote:
> > > On Wed, May 27, 2026 at 11:35:35PM +0300, Onur Özkan wrote:
> > > > Include Rust side implementation files to the SRCU maintainer
> > > > entry.
> > > > 
> > > > Signed-off-by: Onur Özkan <work@onurozkan.dev>
> > > 
> > > @Paul, could you help review this? Also the patch #2 since it changes
> > > the C side.
> > > 
> > > Of course, your feedbacks will be much appreciated for the whole series
> > > as well.
> > 
> > Done, though I am leaving srcu.rs to you guys, unless you have a specific
> > question for me.  ;-)
> 
> Thank you! I saw you left reviews on v5 and I just want to let you know
> that in v6 (the latest version), my comment on patch #2 had been
> resolved.

Ah, I did misfile v6, apologies!

It look like my feedback on the other patch still applies, but please
let me know if I am missing something.

							Thanx, Paul

> > > Regards,
> > > Boqun
> > > 
> > > > ---
> > > >  MAINTAINERS | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index e0b307b2108c..7739a435f258 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -24624,6 +24624,7 @@ SLEEPABLE READ-COPY UPDATE (SRCU)
> > > >  M:	Lai Jiangshan <jiangshanlai@gmail.com>
> > > >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> > > >  M:	Josh Triplett <josh@joshtriplett.org>
> > > > +M:	Onur Özkan <work@onurozkan.dev> (RUST)
> > > >  R:	Steven Rostedt <rostedt@goodmis.org>
> > > >  R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > >  L:	rcu@vger.kernel.org
> > > > @@ -24632,6 +24633,8 @@ W:	http://www.rdrop.com/users/paulmck/RCU/
> > > >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
> > > >  F:	include/linux/srcu*.h
> > > >  F:	kernel/rcu/srcu*.c
> > > > +F:	rust/helpers/srcu.c
> > > > +F:	rust/kernel/sync/srcu.rs
> > > >  
> > > >  SMACK SECURITY MODULE
> > > >  M:	Casey Schaufler <casey@schaufler-ca.com>
> > > > -- 
> > > > 2.51.2
> > > > 
