Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DF233944;
	Sat, 30 May 2026 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167866; cv=none; b=RJN41dv3V+3yu0FRXlO8Jp0aILfnGjHgwYnpAwhPGw85OlbRMK4mfOUDUJeL0TDuDzKGyq1P2AW/DFU53rf7EPMaVEt6xvSIQJg1dJuAfUheZsnYd2p2F5o5+rJ+yYelvkLV9ijaMABRScmwJ34tjuTkMea32GKE/RZCQ28LVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167866; c=relaxed/simple;
	bh=/T7UrSU5XCpZvw2C38x2jiVi8ogoTB6rNVHoeLNhCgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEgn5EXhUjs6ghK8/tiMj22vpBE7qTMPS9hf9V7kYo7Q6wlTU8VkDbNvf7liNjfPlbKbn5jMVKQXURNaGqcYXfkEDRY8iSAk+dxQZB/RbCUvgej/ea1cZm2qsAJqtP3ftLubWHWu+VpfnEVh2ntaRZKENLflWAm4tr7YJeo/zCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=EvuLNOXj; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="EvuLNOXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780167860; x=1780427060;
	bh=rdkfGcD4WFq4qnJGm76D2aHxb8DVkQ+0+svroCGwR+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EvuLNOXj9OQ5ISV9XHCDHHBKluke/xz4jMA/Ky+5Eq8BF1RdLdbZ9Phu4/XKnKtG2
	 gaH2WTiaDYCLCM5bsgV8RZ7p1NyVENE7zM4HVfRHjL8We5mOSMUhCdSRhqKQkw/5ta
	 6DbYEcUs7Jg83qK7auzCn5NtWdGxwgGEc+R2IWTQ9CCXWU8Ldso0NZrUELJgzAtmUf
	 4ie7UvAt7T5ECIoqdXygsWzK7hy468Xv0wEhfAo3IoqwUl6IHjTNmGgw3MJWXqk1C2
	 H8IGxU+uZrJxgkiPXlrmvQkzQjJHg1AMIJNYE+Ib1kSdWdAOtDvJNtWA+6+toxiCmW
	 C+kYZDpsPInZg==
X-Pm-Submission-Id: 4gSV5C5tXkz1DDL0
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	fujita.tomonori@gmail.com,
	tamird@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v8 1/4] rust: helpers: add SRCU helpers
Date: Sat, 30 May 2026 22:04:10 +0300
Message-ID: <20260530190413.15079-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <dbcfbe88-0103-41e1-8650-4c559112547d@paulmck-laptop>
References: <20260529114449.112066-1-work@onurozkan.dev> <20260529114449.112066-2-work@onurozkan.dev> <DIV55HYTKCM3.23VXO47N90C9G@garyguo.net> <20260529120759.145202-1-work@onurozkan.dev> <DIV5JADSFZEM.3DV46U1BI4EYS@garyguo.net> <dbcfbe88-0103-41e1-8650-4c559112547d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 May 2026 12:01:21 -0700=0D
"Paul E. McKenney" <paulmck@kernel.org> wrote:=0D
=0D
> On Fri, May 29, 2026 at 01:16:17PM +0100, Gary Guo wrote:=0D
> > On Fri May 29, 2026 at 1:07 PM BST, Onur =C3=96zkan wrote:=0D
> > > On Fri, 29 May 2026 12:58:17 +0100=0D
> > > Gary Guo <gary@garyguo.net> wrote:=0D
> > >=0D
> > >> On Fri May 29, 2026 at 12:43 PM BST, Onur =C3=96zkan wrote:=0D
> > >> > Add helper wrappers for SRCU functions that are exposed to Rust=0D
> > >> > through generated bindings.=0D
> > >> >=0D
> > >> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>=0D
> > >> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> > >> > ---=0D
> > >> >  include/linux/srcu.h   |  5 +++++=0D
> > >> >  rust/helpers/helpers.c |  1 +=0D
> > >> >  rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++=0D
> > >> >  3 files changed, 36 insertions(+)=0D
> > >> >  create mode 100644 rust/helpers/srcu.c=0D
> > >> >=0D
> > >> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h=0D
> > >> > index 81b1938512d5..790a4ef713c0 100644=0D
> > >> > --- a/include/linux/srcu.h=0D
> > >> > +++ b/include/linux/srcu.h=0D
> > >> > @@ -57,6 +57,11 @@ int __init_srcu_struct_fast_updown(struct srcu_=
struct *ssp, const char *name,=0D
> > >> >  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */=0D
> > >> >  =0D
> > >> >  int init_srcu_struct(struct srcu_struct *ssp);=0D
> > >> > +static inline int __init_srcu_struct(struct srcu_struct *ssp, con=
st char *name,=0D
> > >> > +				     struct lock_class_key *key)=0D
> > >> > +{=0D
> > >> > +	return init_srcu_struct(ssp);=0D
> > >> > +}=0D
> > >> =0D
> > >> =0D
> > >> This looks like a different strategy than, say, how mutex handles lo=
ckdep. IMO=0D
> > >> the way that mutex handles this is more clear.=0D
> > >=0D
> > > Initially it was the same strategy, this one was suggested by Paul [1=
] and it=0D
> > > didn't sound like a bad idea to me. Also, in previous revisions, Boqu=
n once=0D
> > > said:=0D
> > =0D
> > I'm talking about changing how this is handled in SRCU side, not helper=
 side.=0D
> > =0D
> > >=0D
> > > 	"Having a "#ifdef" in a function body is generally considered as bad=
 code=0D
> > > 	(I know we have some of these in rust helpers, but helpers are a bit=
=0D
> > > 	special and maybe we should clean them up). So could you move this=0D
> > > 	function into include/linux/srcutiny.h and include/linux/srcutree.h?=
"=0D
> > =0D
> > mutex.h doesn't use ifdef inside function body, it just define two stat=
ic inline=0D
> > functions with the same signature in different ifdef branches.=0D
> =0D
> True, but SRCU has the added complication of having different !SMP (Tiny)=
=0D
> and SMP (Tree) implementations.  On the other hand, it is quite possible=
=0D
> that I missed a trick when setting up this part of SRCU.  Please feel=0D
> free to send a patch that simplifies it.=0D
=0D
It's on the list [1].=0D
=0D
Thanks,=0D
Onur=0D
=0D
[1]: https://lore.kernel.org/all/20260529134004.396743-2-work@onurozkan.dev=
=0D
=0D
> =0D
> 							Thanx, Paul=0D
> =0D
> > Best,=0D
> > Gary=0D
> > =0D
> > >=0D
> > > So putting them together, I decided to follow Paul's suggestion.=0D
> > >=0D
> > > [1]: https://lore.kernel.org/all/05906890-cf06-414c-a625-02f9d7150d57=
@paulmck-laptop=0D
> > >=0D
> > >> =0D
> > >> If we follow the way mutex is handles this, the `init_srcu_struct` w=
ould always=0D
> > >> create lock class key and forward to `__init_srcu_struct`, and=0D
> > >> `__init_srcu_struct` is an inline function that either calls=0D
> > >> `init_srcu_struct_lockdep` with all args, or discard name/key and fo=
rward to=0D
> > >> `init_srcu_struct_mutex`.=0D
> > >> =0D
> > >> This is beneficial because the usage flows one way. You don't have i=
n one config=0D
> > >> `init_srcu_struct` call `__init_srcu_struct` and have the opposite i=
n another=0D
> > >> config, which I think can be quite confusing.=0D
> > =0D
