Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765511D63E4;
	Sat, 30 May 2026 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167683; cv=none; b=AJ371lElDnS+TpwkCUINpTQbqTLipHj5Du9ITc2PfyiW0uZ/2+7qKdarnCNatafmWd+AEWqXjlKmaG95hUiHU7uZcPeH+OKbN43gzM7Py8jJWwo3Sp0pUSPZWUvwzkyB07NbnSs669pyLAlzSRa5x4fCDYDYt7r3SeVq8S7i2P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167683; c=relaxed/simple;
	bh=FGEb+1vUz7rPQYzzQuptZwf/1Q/x9HXeNn4ZQeEVhyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+Ku3StTg9rOqieIrk3/QE62EsPcGETSncqaULwrtg/MSyZ/4/wIQyaY0R3IPiiCC1+YbNs+7+ndcXI/W6BCTlj4rrdF3qJ2Eh2VyuNIp+iZKs00jR9+RNIoMz/Qmla/jXP3+yIgXFGAjkrAmbzi9gF07ihowGRdqMjrtUqnHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6mKnKBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6mKnKBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5084D1F00893;
	Sat, 30 May 2026 19:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780167682;
	bh=1TV+OOZUfgLYvwoLTf2e6cMcP3wAL/18je6JVpiHPSs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Y6mKnKBXhj2UzgP7vEQQ0A6nxU6IgDIxJb6w17RAmOr9GSBIl3na3MDsLuHAJQwwp
	 gGmKb9wUBjs/fhTrRrMrd2dSWNYI6w3eULGqm80Ghgu+RGRjJuPzBUrUK0zLXh5+sg
	 f1L9a7L+4aPnBAE/R5kIemZdnF8l0FO/VcpQjESwRGoKa2XtTqprqYc0Op1rWIPDzA
	 9lcfemw7URbrb/DSeXrvu+bdbxajmEJy2wT7Va+sEeufgw9E/vmVgBB/mnUGUFwDCa
	 NcqKnB4IZ+X0/hu7aH6VZWy6Dzb2xCZWXh6gYaNqSJ/vhPGUOPHzuRpChjJpYVb+Cc
	 UfZFRJXHh6ZBQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 02160CE0486; Sat, 30 May 2026 12:01:21 -0700 (PDT)
Date: Sat, 30 May 2026 12:01:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org,
	fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v8 1/4] rust: helpers: add SRCU helpers
Message-ID: <dbcfbe88-0103-41e1-8650-4c559112547d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260529114449.112066-1-work@onurozkan.dev>
 <20260529114449.112066-2-work@onurozkan.dev>
 <DIV55HYTKCM3.23VXO47N90C9G@garyguo.net>
 <20260529120759.145202-1-work@onurozkan.dev>
 <DIV5JADSFZEM.3DV46U1BI4EYS@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DIV5JADSFZEM.3DV46U1BI4EYS@garyguo.net>

On Fri, May 29, 2026 at 01:16:17PM +0100, Gary Guo wrote:
> On Fri May 29, 2026 at 1:07 PM BST, Onur Özkan wrote:
> > On Fri, 29 May 2026 12:58:17 +0100
> > Gary Guo <gary@garyguo.net> wrote:
> >
> >> On Fri May 29, 2026 at 12:43 PM BST, Onur Özkan wrote:
> >> > Add helper wrappers for SRCU functions that are exposed to Rust
> >> > through generated bindings.
> >> >
> >> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> >> > Signed-off-by: Onur Özkan <work@onurozkan.dev>
> >> > ---
> >> >  include/linux/srcu.h   |  5 +++++
> >> >  rust/helpers/helpers.c |  1 +
> >> >  rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++
> >> >  3 files changed, 36 insertions(+)
> >> >  create mode 100644 rust/helpers/srcu.c
> >> >
> >> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> >> > index 81b1938512d5..790a4ef713c0 100644
> >> > --- a/include/linux/srcu.h
> >> > +++ b/include/linux/srcu.h
> >> > @@ -57,6 +57,11 @@ int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
> >> >  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> >> >  
> >> >  int init_srcu_struct(struct srcu_struct *ssp);
> >> > +static inline int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
> >> > +				     struct lock_class_key *key)
> >> > +{
> >> > +	return init_srcu_struct(ssp);
> >> > +}
> >> 
> >> 
> >> This looks like a different strategy than, say, how mutex handles lockdep. IMO
> >> the way that mutex handles this is more clear.
> >
> > Initially it was the same strategy, this one was suggested by Paul [1] and it
> > didn't sound like a bad idea to me. Also, in previous revisions, Boqun once
> > said:
> 
> I'm talking about changing how this is handled in SRCU side, not helper side.
> 
> >
> > 	"Having a "#ifdef" in a function body is generally considered as bad code
> > 	(I know we have some of these in rust helpers, but helpers are a bit
> > 	special and maybe we should clean them up). So could you move this
> > 	function into include/linux/srcutiny.h and include/linux/srcutree.h?"
> 
> mutex.h doesn't use ifdef inside function body, it just define two static inline
> functions with the same signature in different ifdef branches.

True, but SRCU has the added complication of having different !SMP (Tiny)
and SMP (Tree) implementations.  On the other hand, it is quite possible
that I missed a trick when setting up this part of SRCU.  Please feel
free to send a patch that simplifies it.

							Thanx, Paul

> Best,
> Gary
> 
> >
> > So putting them together, I decided to follow Paul's suggestion.
> >
> > [1]: https://lore.kernel.org/all/05906890-cf06-414c-a625-02f9d7150d57@paulmck-laptop
> >
> >> 
> >> If we follow the way mutex is handles this, the `init_srcu_struct` would always
> >> create lock class key and forward to `__init_srcu_struct`, and
> >> `__init_srcu_struct` is an inline function that either calls
> >> `init_srcu_struct_lockdep` with all args, or discard name/key and forward to
> >> `init_srcu_struct_mutex`.
> >> 
> >> This is beneficial because the usage flows one way. You don't have in one config
> >> `init_srcu_struct` call `__init_srcu_struct` and have the opposite in another
> >> config, which I think can be quite confusing.
> 
