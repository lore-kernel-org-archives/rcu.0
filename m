Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505FF3B7751;
	Fri, 29 May 2026 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056500; cv=none; b=O/kjro+qdplZWESq/51HFqEGt5hCxEK4jWb94SzbUU/M2OXfggoIgjvX+nIXSBLzirFqwnEGzzhW80kY9Cq+rAbo6yJEQKRmMcB/qkOEoWgTuaF6Gf9+UQGrvZBoGTLlnJaXbieexwS3G09xess1yXZ1y1F/78DtCk3e4qf9YrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056500; c=relaxed/simple;
	bh=DjPQXqAeCtfJv38KRmbut/V3qoUdekYn8aGZYm2g9Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXnVRzwJw9lqJWLOsgrzkvh+6DiRLRUy0zwELqEeC/WNonCSlj2dCJfJCxgvTfM0oQ+/T7lG5EGOQFtmTCPR1t8KJI6ZFgN1fAAFKZow33+vveq8PHCv2Ns3Fz2/JsOWs9XwUAx4AcV6RjoDozm7aHL3P3ohJLP8fjGkUPz4Xdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=WqtK9dOF; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="WqtK9dOF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780056484; x=1780315684;
	bh=9/MNNGjo77nb27A2iNHgOPWpAodznO05aX/2yzxcW3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WqtK9dOFftVcscYX4jN7wQX79jvx1d9xSbjQi1nPY3z+QJPSwe/CshQ+Sxj9LKIUm
	 slvjsKvcgM72B3nAnHe4Es7mU4cZrJQlwqIfGVhS6VFmtIXKKshtaJqpsGbl8KYxbK
	 KEH6fi8Rd7LuyxGwW+qLgRoLn0xxUgH7Fav2FUinwKxHhTRAb0R/883EgdnbIVlwhn
	 tv6Tfdo+HZ3qjDpmIpQjWvfwmfm2b/cltrN9q50+/EcIc4O/oZI+ERdlCPh6lYI/wu
	 NKenvvQDseYLjthvQOA8ID1ijIhCqv0ltvyHzHoEyE4DQn7dtU8fxxPc4ULDqRxGZV
	 Gmb8ltKRa7qJA==
X-Pm-Submission-Id: 4gRhvN5QmYz1DFG3
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Gary Guo <gary@garyguo.net>
Cc: rcu@vger.kernel.org,
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
	paulmck@kernel.org,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v8 1/4] rust: helpers: add SRCU helpers
Date: Fri, 29 May 2026 15:07:57 +0300
Message-ID: <20260529120759.145202-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DIV55HYTKCM3.23VXO47N90C9G@garyguo.net>
References: <20260529114449.112066-1-work@onurozkan.dev> <20260529114449.112066-2-work@onurozkan.dev> <DIV55HYTKCM3.23VXO47N90C9G@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 12:58:17 +0100=0D
Gary Guo <gary@garyguo.net> wrote:=0D
=0D
> On Fri May 29, 2026 at 12:43 PM BST, Onur =C3=96zkan wrote:=0D
> > Add helper wrappers for SRCU functions that are exposed to Rust=0D
> > through generated bindings.=0D
> >=0D
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>=0D
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> > ---=0D
> >  include/linux/srcu.h   |  5 +++++=0D
> >  rust/helpers/helpers.c |  1 +=0D
> >  rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++=0D
> >  3 files changed, 36 insertions(+)=0D
> >  create mode 100644 rust/helpers/srcu.c=0D
> >=0D
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h=0D
> > index 81b1938512d5..790a4ef713c0 100644=0D
> > --- a/include/linux/srcu.h=0D
> > +++ b/include/linux/srcu.h=0D
> > @@ -57,6 +57,11 @@ int __init_srcu_struct_fast_updown(struct srcu_struc=
t *ssp, const char *name,=0D
> >  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */=0D
> >  =0D
> >  int init_srcu_struct(struct srcu_struct *ssp);=0D
> > +static inline int __init_srcu_struct(struct srcu_struct *ssp, const ch=
ar *name,=0D
> > +				     struct lock_class_key *key)=0D
> > +{=0D
> > +	return init_srcu_struct(ssp);=0D
> > +}=0D
> =0D
> =0D
> This looks like a different strategy than, say, how mutex handles lockdep=
. IMO=0D
> the way that mutex handles this is more clear.=0D
=0D
Initially it was the same strategy, this one was suggested by Paul [1] and =
it=0D
didn't sound like a bad idea to me. Also, in previous revisions, Boqun once=
=0D
said:=0D
=0D
	"Having a "#ifdef" in a function body is generally considered as bad code=
=0D
	(I know we have some of these in rust helpers, but helpers are a bit=0D
	special and maybe we should clean them up). So could you move this=0D
	function into include/linux/srcutiny.h and include/linux/srcutree.h?"=0D
=0D
So putting them together, I decided to follow Paul's suggestion.=0D
=0D
[1]: https://lore.kernel.org/all/05906890-cf06-414c-a625-02f9d7150d57@paulm=
ck-laptop=0D
=0D
> =0D
> If we follow the way mutex is handles this, the `init_srcu_struct` would =
always=0D
> create lock class key and forward to `__init_srcu_struct`, and=0D
> `__init_srcu_struct` is an inline function that either calls=0D
> `init_srcu_struct_lockdep` with all args, or discard name/key and forward=
 to=0D
> `init_srcu_struct_mutex`.=0D
> =0D
> This is beneficial because the usage flows one way. You don't have in one=
 config=0D
> `init_srcu_struct` call `__init_srcu_struct` and have the opposite in ano=
ther=0D
> config, which I think can be quite confusing.=0D
> =0D
> Best,=0D
> Gary=0D
> =0D
> >  #ifndef CONFIG_TINY_SRCU=0D
> >  int init_srcu_struct_fast(struct srcu_struct *ssp);=0D
> >  int init_srcu_struct_fast_updown(struct srcu_struct *ssp);=0D
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c=0D
> > index 625921e27dfb..f3562d3b3888 100644=0D
> > --- a/rust/helpers/helpers.c=0D
> > +++ b/rust/helpers/helpers.c=0D
> > @@ -88,6 +88,7 @@=0D
> >  #include "signal.c"=0D
> >  #include "slab.c"=0D
> >  #include "spinlock.c"=0D
> > +#include "srcu.c"=0D
> >  #include "sync.c"=0D
> >  #include "task.c"=0D
> >  #include "time.c"=0D
> > diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c=0D
> > new file mode 100644=0D
> > index 000000000000..225b3bf9334a=0D
> > --- /dev/null=0D
> > +++ b/rust/helpers/srcu.c=0D
> > @@ -0,0 +1,30 @@=0D
> > +// SPDX-License-Identifier: GPL-2.0=0D
> > +=0D
> > +#include <linux/srcu.h>=0D
> > +=0D
> > +__rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_st=
ruct *ssp,=0D
> > +							const char *name,=0D
> > +							struct lock_class_key *key)=0D
> > +{=0D
> > +	return __init_srcu_struct(ssp, name, key);=0D
> > +}=0D
> > +=0D
> > +__rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)=
=0D
> > +{=0D
> > +	return srcu_read_lock(ssp);=0D
> > +}=0D
> > +=0D
> > +__rust_helper void rust_helper_srcu_read_unlock(struct srcu_struct *ss=
p, int idx)=0D
> > +{=0D
> > +	srcu_read_unlock(ssp, idx);=0D
> > +}=0D
> > +=0D
> > +__rust_helper void rust_helper_srcu_barrier(struct srcu_struct *ssp)=0D
> > +{=0D
> > +	srcu_barrier(ssp);=0D
> > +}=0D
> > +=0D
> > +__rust_helper void rust_helper_synchronize_srcu_expedited(struct srcu_=
struct *ssp)=0D
> > +{=0D
> > +	synchronize_srcu_expedited(ssp);=0D
> > +}=0D
> =0D
> =0D
