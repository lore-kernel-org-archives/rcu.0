Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15713D53C;
	Wed, 27 May 2026 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923113; cv=none; b=jCGTb+OctszQuI3NzlpdmYMDGaCxxmnt0rX1ujV5dp2hM6aoYsIfrVSIvrudWn4ew24fjKtFM7KCwesAe0nxVqxOKhlEDhRykPIwruEY1922MPHG8rYW7QRqGVwPqmgAgmF8vZIbM0mbDdyON9rCaICHjGdKbIOqKh10wac2TKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923113; c=relaxed/simple;
	bh=+bSi6RvLWcU8hB+qAFRARbEHr5afurGR1hNLevMA1oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R98jIPxbZH2w3uhCJ6AIMjzFCjujNmksFm8oclmov8/9qWMTzoRBXkNUbMQxKPUwyHh9aFH01qx2vY0gSQVcha4ZsEVIo79m0mJkabc4dXjxT0fDEjHyhqsRriINTATy7NHWQAQgJ/wplWL/XGgPGjDq7fI4M0wgqPQ4vU0q40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXEF3KHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXEF3KHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92661F000E9;
	Wed, 27 May 2026 23:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779923111;
	bh=v1052YXN6z3OPembUaYKNmPfRVkf98frkCkbOnv14z0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=QXEF3KHUexDCfc8EzrjgxzhN+ECDQJeV9R7vZGIt7melVBoqrIwZmyFzBw1nQOPJb
	 0aA8QTenAKjQOtEYrjj8h4HfyBTwzEhOG2KwESROkZaxZNpB0XUMUwvx5lJXcWKfrJ
	 DBvF1/cjbHk0Nzv+TKKDY9ERY07zhHm8zxV0h8e7d3lTC2Zt5sBS0KPICbH3Kw/FWG
	 XTkPJlJa/Tiw0f97t0VGySaxuqGlJDqL2NkS/m6f4Fcg8gor/fSOb2kyLtREZeelO6
	 PDBhpRbKXkXyVXWa8/nTCWPiUjFOwub+1sQLktS0F55E8KpUxwCI+UBKdkca0DFO9w
	 U9m5LbXHbE06Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D7F0CE10CD; Wed, 27 May 2026 16:05:11 -0700 (PDT)
Date: Wed, 27 May 2026 16:05:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, peterz@infradead.org, fujita.tomonori@gmail.com,
	tamird@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v5 4/4] MAINTAINERS: add Rust SRCU files to SRCU entry
Message-ID: <84db121d-07aa-4cbe-a7a2-8489d9d5af43@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260527174120.510447-1-work@onurozkan.dev>
 <20260527174120.510447-5-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527174120.510447-5-work@onurozkan.dev>

On Wed, May 27, 2026 at 08:40:45PM +0300, Onur Özkan wrote:
> Include Rust side implementation files to the SRCU maintainer
> entry.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0b307b2108c..7739a435f258 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24624,6 +24624,7 @@ SLEEPABLE READ-COPY UPDATE (SRCU)
>  M:	Lai Jiangshan <jiangshanlai@gmail.com>
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
>  M:	Josh Triplett <josh@joshtriplett.org>
> +M:	Onur Özkan <work@onurozkan.dev> (RUST)
>  R:	Steven Rostedt <rostedt@goodmis.org>
>  R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  L:	rcu@vger.kernel.org
> @@ -24632,6 +24633,8 @@ W:	http://www.rdrop.com/users/paulmck/RCU/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
>  F:	include/linux/srcu*.h
>  F:	kernel/rcu/srcu*.c
> +F:	rust/helpers/srcu.c
> +F:	rust/kernel/sync/srcu.rs
>  
>  SMACK SECURITY MODULE
>  M:	Casey Schaufler <casey@schaufler-ca.com>
> -- 
> 2.51.2
> 
