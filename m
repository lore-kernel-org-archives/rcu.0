Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F83D2FFB
	for <rcu@vger.kernel.org>; Fri, 29 May 2026 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057829; cv=none; b=avZl+7sqyA16r7QzUnoA9BNmcCEi1ovT+xTRUr4KztXNvvV/K3EoJsYVKJ6p0iCA9+Ji9Vk6BplHXDcnn3NbC9gDWkIXdfbQviq/kBv0a1iSeX+sKIHVV+Y5Rax3Zz0uF9/KpBi1FadVrxVZhfs20SYNc/wwAEPxknvT7oiax1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057829; c=relaxed/simple;
	bh=3YWG/XEThhBNbhY+I5jYNB6brXYZQmiktIHaCDq+k5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pr0XTNN30wyHDuSUEzbn0rpfqs0rl91oqAyVbza0EZvSDvvA7F49Vt3jCqbBd0QEMCysIvLpAuj3O2TFwJD1CDYA5MY6FW2Qyyr6EVlQhbqFRk/8Q0Xn897EyosBRaF4Ha48gyjyAyd9Urz+mDlhZVUCeJB5+wZ/TX6PIlGceVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Eb6puIo6; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Eb6puIo6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780057823; x=1780317023;
	bh=gO3pl4aT30adoKRKjlcgNs56IednDpwZ7K7MxewOJws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Eb6puIo64YVRLmN09iZuubFZbRYwmOno860qrsZl52o2O1bVKFsxTRAyTnDXhmeVj
	 NVT+Iabcpm00pffh4u53gAh2j4gFBil/jEm6Lch7xeo8q3jTKZPhPpjw+hG+YdZh+b
	 u/3mDDCNMYMSeuZoYhS//rHKBFRekXc6Ywo79z0j3GgrSJQWMVdSBcJgcVUPt3ts1l
	 7iG3As8cg+9hP0qzY4rcpx9cCGCkmeZOoCIr08bIwp0ePxYcck+j0YSlzFcZwPt9FM
	 GGetkIk4cYxmOVF74eHQLU9oA3wDaoxhVd8rOTZcuF8nSfMtqLpokArSaWFJgEFEEB
	 gHc1dQqpGAMNw==
X-Pm-Submission-Id: 4gRjP82SXhz1DDLL
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
Date: Fri, 29 May 2026 15:30:07 +0300
Message-ID: <20260529123018.177238-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DIV5JADSFZEM.3DV46U1BI4EYS@garyguo.net>
References: <20260529114449.112066-1-work@onurozkan.dev> <20260529114449.112066-2-work@onurozkan.dev> <DIV55HYTKCM3.23VXO47N90C9G@garyguo.net> <20260529120759.145202-1-work@onurozkan.dev> <DIV5JADSFZEM.3DV46U1BI4EYS@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 13:16:17 +0100=0D
Gary Guo <gary@garyguo.net> wrote:=0D
=0D
> On Fri May 29, 2026 at 1:07 PM BST, Onur =C3=96zkan wrote:=0D
> > On Fri, 29 May 2026 12:58:17 +0100=0D
> > Gary Guo <gary@garyguo.net> wrote:=0D
> >=0D
> >> On Fri May 29, 2026 at 12:43 PM BST, Onur =C3=96zkan wrote:=0D
> >> > Add helper wrappers for SRCU functions that are exposed to Rust=0D
> >> > through generated bindings.=0D
> >> >=0D
> >> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>=0D
> >> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> >> > ---=0D
> >> >  include/linux/srcu.h   |  5 +++++=0D
> >> >  rust/helpers/helpers.c |  1 +=0D
> >> >  rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++=0D
> >> >  3 files changed, 36 insertions(+)=0D
> >> >  create mode 100644 rust/helpers/srcu.c=0D
> >> >=0D
> >> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h=0D
> >> > index 81b1938512d5..790a4ef713c0 100644=0D
> >> > --- a/include/linux/srcu.h=0D
> >> > +++ b/include/linux/srcu.h=0D
> >> > @@ -57,6 +57,11 @@ int __init_srcu_struct_fast_updown(struct srcu_st=
ruct *ssp, const char *name,=0D
> >> >  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */=0D
> >> >  =0D
> >> >  int init_srcu_struct(struct srcu_struct *ssp);=0D
> >> > +static inline int __init_srcu_struct(struct srcu_struct *ssp, const=
 char *name,=0D
> >> > +				     struct lock_class_key *key)=0D
> >> > +{=0D
> >> > +	return init_srcu_struct(ssp);=0D
> >> > +}=0D
> >> =0D
> >> =0D
> >> This looks like a different strategy than, say, how mutex handles lock=
dep. IMO=0D
> >> the way that mutex handles this is more clear.=0D
> >=0D
> > Initially it was the same strategy, this one was suggested by Paul [1] =
and it=0D
> > didn't sound like a bad idea to me. Also, in previous revisions, Boqun =
once=0D
> > said:=0D
> =0D
> I'm talking about changing how this is handled in SRCU side, not helper s=
ide.=0D
> =0D
> >=0D
> > 	"Having a "#ifdef" in a function body is generally considered as bad c=
ode=0D
> > 	(I know we have some of these in rust helpers, but helpers are a bit=0D
> > 	special and maybe we should clean them up). So could you move this=0D
> > 	function into include/linux/srcutiny.h and include/linux/srcutree.h?"=
=0D
> =0D
> mutex.h doesn't use ifdef inside function body, it just define two static=
 inline=0D
> functions with the same signature in different ifdef branches.=0D
> =0D
=0D
I might have confused them, let me check them again.=0D
=0D
Thanks,=0D
Onur=0D
=0D
> Best,=0D
> Gary=0D
> =0D
> >=0D
> > So putting them together, I decided to follow Paul's suggestion.=0D
> >=0D
> > [1]: https://lore.kernel.org/all/05906890-cf06-414c-a625-02f9d7150d57@p=
aulmck-laptop=0D
> >=0D
> >> =0D
> >> If we follow the way mutex is handles this, the `init_srcu_struct` wou=
ld always=0D
> >> create lock class key and forward to `__init_srcu_struct`, and=0D
> >> `__init_srcu_struct` is an inline function that either calls=0D
> >> `init_srcu_struct_lockdep` with all args, or discard name/key and forw=
ard to=0D
> >> `init_srcu_struct_mutex`.=0D
> >> =0D
> >> This is beneficial because the usage flows one way. You don't have in =
one config=0D
> >> `init_srcu_struct` call `__init_srcu_struct` and have the opposite in =
another=0D
> >> config, which I think can be quite confusing.=0D
