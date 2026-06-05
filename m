Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD340626E;
	Fri,  5 Jun 2026 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641391; cv=none; b=KE4GwjzlRYpHb/Jyjf49A1+xxCYLSjju581s7XRQyxBfC01HsfYMywkndqLEFB49rAWIMSc+vy7BgYiNuTFygFXl8bGTplmF1YrQBsYrFF6PD8BCzNozBLExG+BnpUCHXidwAgB/M9T54gue7GGElGm3uHQhQirvvYEAFVTlYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641391; c=relaxed/simple;
	bh=miqHdEu3z8HReD0dUe181194Bz7kAcuHHqvQQoIbHhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7nWIZaGcMkqpMkjMNCoD2KbTreuC3jDOsSou5LpY2nBBKS7fnO0ibxA25QvOohWG/btwhZYYYnWBv72zd8hcEHbqtduDyH2Dc1MFx0cjWWOWdpzx5coSuDsC9DDoq2F10rzbGH2RIIMQsraDVLXlDH+TkVvvf1nbY7q/ptasZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=r5lGvjK/; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="r5lGvjK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780641379; x=1780900579;
	bh=qveSfLeksZ7hInrBILIxW8PXrRlvzzBrxL1I60tCo6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=r5lGvjK/CKx5k+BzTZV4NYh8goaTmtEtH5zB2FTM8I1MOcryzz2l9dqTuytPlSxP+
	 LrlUvMAGKshIxzfY9unBTFA0DCuYdzkozidhYWYvCvufpSQ4TecgJh6cH+qlae9ANm
	 TdOhM9ySbZpyPw7DRVTusphrmxfgC0uzWWyf89wNzjugBZvbac1+hhIQSANc197GvR
	 3TuFFmULOqyXTPGHTmbBvrpVZUizgE+Mrzpp0cdQm56W1vq/gkISa3bdle5C0+KFqT
	 b/t/zkfe74NunCVGE2xEvEICc+Rxw0E0QOfeMBe9tsFhnuk4lgpanfdXTu/YyjDOms
	 47lCuYyjQR5wQ==
X-Pm-Submission-Id: 4gWsCM0fSYz1DFSR
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
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
Subject: Re: [PATCH v9 1/4] rust: helpers: add SRCU helpers
Date: Fri,  5 Jun 2026 09:32:28 +0300
Message-ID: <20260605063613.81637-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <5d82d96f-5dbb-46bd-b34b-25411be157ce@paulmck-laptop>
References: <20260529134004.396743-1-work@onurozkan.dev> <20260529134004.396743-2-work@onurozkan.dev> <5d82d96f-5dbb-46bd-b34b-25411be157ce@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Jun 2026 11:40:59 -0700=0D
"Paul E. McKenney" <paulmck@kernel.org> wrote:=0D
=0D
> On Fri, May 29, 2026 at 04:39:51PM +0300, Onur =C3=96zkan wrote:=0D
> > Add helper wrappers for SRCU functions that are exposed to Rust=0D
> > through generated bindings.=0D
> > =0D
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> > =0D
> > ---=0D
> >  include/linux/srcu.h   | 29 ++++++++++++++++++++---------=0D
> >  kernel/rcu/srcutiny.c  | 10 +++++-----=0D
> >  kernel/rcu/srcutree.c  |  9 +++++----=0D
> >  rust/helpers/helpers.c |  1 +=0D
> >  rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++=0D
> >  5 files changed, 61 insertions(+), 18 deletions(-)=0D
> >  create mode 100644 rust/helpers/srcu.c=0D
> =0D
> On the next version, please split the rust/helpers changes into a=0D
> separate patch.  It looks like the simplification to SRCU adds code=0D
> rather than deleting it?=0D
> =0D
=0D
Well, it's mostly renaming (e.g. init_srcu_struct -> init_srcu_struct_gener=
ic)=0D
and moving code around (moving init_srcu_struct outside CONFIG_DEBUG_LOCK_A=
LLOC=0D
guard). The actual "added" code lines are around 10 lines or something.=0D
=0D
> But let me see if I understand the structure.=0D
> =0D
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h=0D
> > index 81b1938512d5..a028a5b5ebef 100644=0D
> > --- a/include/linux/srcu.h=0D
> > +++ b/include/linux/srcu.h=0D
> > @@ -25,20 +25,19 @@ context_lock_struct(srcu_struct, __reentrant_ctx_lo=
ck);=0D
> >  =0D
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC=0D
> >  =0D
> > -int __init_srcu_struct(struct srcu_struct *ssp, const char *name, stru=
ct lock_class_key *key);=0D
> > +int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name=
,=0D
> > +				     struct lock_class_key *key);=0D
> > +static inline int __init_srcu_struct(struct srcu_struct *ssp, const ch=
ar *name,=0D
> > +				     struct lock_class_key *key)=0D
> > +{=0D
> > +	return init_srcu_struct_lockdep(ssp, name, key);=0D
> > +}=0D
> =0D
> __init_srcu_struct() invokes init_srcu_struct_lockdep()...=0D
> =0D
> >  #ifndef CONFIG_TINY_SRCU=0D
> >  int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name,=
 struct lock_class_key *key);=0D
> >  int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char=
 *name,=0D
> >  				   struct lock_class_key *key);=0D
> >  #endif // #ifndef CONFIG_TINY_SRCU=0D
> >  =0D
> > -#define init_srcu_struct(ssp) \=0D
> > -({ \=0D
> > -	static struct lock_class_key __srcu_key; \=0D
> > -	\=0D
> > -	__init_srcu_struct((ssp), #ssp, &__srcu_key); \=0D
> > -})=0D
> =0D
> init_srcu_struct() invokes __init_srcu_struct()...  (moved)=0D
> =0D
> >  #define init_srcu_struct_fast(ssp) \=0D
> >  ({ \=0D
> >  	static struct lock_class_key __srcu_key; \=0D
> > @@ -56,7 +55,12 @@ int __init_srcu_struct_fast_updown(struct srcu_struc=
t *ssp, const char *name,=0D
> >  #define __SRCU_DEP_MAP_INIT(srcu_name)	.dep_map =3D { .name =3D #srcu_=
name },=0D
> >  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */=0D
> >  =0D
> > -int init_srcu_struct(struct srcu_struct *ssp);=0D
> > +int init_srcu_struct_generic(struct srcu_struct *ssp);=0D
> > +static inline int __init_srcu_struct(struct srcu_struct *ssp, const ch=
ar *name,=0D
> > +				     struct lock_class_key *key)=0D
> > +{=0D
> > +	return init_srcu_struct_generic(ssp);=0D
> > +}=0D
> =0D
> __init_srcu_struct() invokes init_srcu_struct_generic()...=0D
> =0D
> >  #ifndef CONFIG_TINY_SRCU=0D
> >  int init_srcu_struct_fast(struct srcu_struct *ssp);=0D
> >  int init_srcu_struct_fast_updown(struct srcu_struct *ssp);=0D
> > @@ -65,6 +69,13 @@ int init_srcu_struct_fast_updown(struct srcu_struct =
*ssp);=0D
> >  #define __SRCU_DEP_MAP_INIT(srcu_name)=0D
> >  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */=0D
> >  =0D
> > +#define init_srcu_struct(ssp) \=0D
> > +({ \=0D
> > +	static struct lock_class_key __srcu_key; \=0D
> > +	\=0D
> > +	__init_srcu_struct((ssp), #ssp, &__srcu_key); \=0D
> > +})=0D
> =0D
> ...and here is where it moved to.=0D
> =0D
> > +=0D
> >  /* Values for SRCU Tree srcu_data ->srcu_reader_flavor, but also used =
by rcutorture. */=0D
> >  #define SRCU_READ_FLAVOR_NORMAL		0x1		// srcu_read_lock().=0D
> >  #define SRCU_READ_FLAVOR_NMI		0x2		// srcu_read_lock_nmisafe().=0D
> > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c=0D
> > index a2e2d516e51b..780a95e8cad7 100644=0D
> > --- a/kernel/rcu/srcutiny.c=0D
> > +++ b/kernel/rcu/srcutiny.c=0D
> > @@ -48,15 +48,15 @@ static int init_srcu_struct_fields(struct srcu_stru=
ct *ssp)=0D
> >  =0D
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC=0D
> >  =0D
> > -int __init_srcu_struct(struct srcu_struct *ssp, const char *name,=0D
> > -		       struct lock_class_key *key)=0D
> > +int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name=
,=0D
> > +		     struct lock_class_key *key)=0D
> >  {=0D
> >  	/* Don't re-initialize a lock while it is held. */=0D
> >  	debug_check_no_locks_freed((void *)ssp, sizeof(*ssp));=0D
> >  	lockdep_init_map(&ssp->dep_map, name, key, 0);=0D
> >  	return init_srcu_struct_fields(ssp);=0D
> >  }=0D
> > -EXPORT_SYMBOL_GPL(__init_srcu_struct);=0D
> > +EXPORT_SYMBOL_GPL(init_srcu_struct_lockdep);=0D
> =0D
> init_srcu_struct_lockdep() invokes init_srcu_struct_fields()...=0D
> =0D
> >  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */=0D
> >  =0D
> > @@ -68,11 +68,11 @@ EXPORT_SYMBOL_GPL(__init_srcu_struct);=0D
> >   * to any other function.  Each srcu_struct represents a separate doma=
in=0D
> >   * of SRCU protection.=0D
> >   */=0D
> > -int init_srcu_struct(struct srcu_struct *ssp)=0D
> > +int init_srcu_struct_generic(struct srcu_struct *ssp)=0D
> >  {=0D
> >  	return init_srcu_struct_fields(ssp);=0D
> >  }=0D
> > -EXPORT_SYMBOL_GPL(init_srcu_struct);=0D
> > +EXPORT_SYMBOL_GPL(init_srcu_struct_generic);=0D
> =0D
> init_srcu_struct_generic() invokes init_srcu_struct_fields()...=0D
> =0D
> >  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */=0D
> >  =0D
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c=0D
> > index 0d01cd8c4b4a..45154630c54e 100644=0D
> > --- a/kernel/rcu/srcutree.c=0D
> > +++ b/kernel/rcu/srcutree.c=0D
> > @@ -266,12 +266,13 @@ __init_srcu_struct_common(struct srcu_struct *ssp=
, const char *name, struct lock=0D
> >  	return init_srcu_struct_fields(ssp, false);=0D
> >  }=0D
> >  =0D
> > -int __init_srcu_struct(struct srcu_struct *ssp, const char *name, stru=
ct lock_class_key *key)=0D
> > +int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name=
,=0D
> > +			     struct lock_class_key *key)=0D
> >  {=0D
> >  	ssp->srcu_reader_flavor =3D 0;=0D
> >  	return __init_srcu_struct_common(ssp, name, key);=0D
> >  }=0D
> > -EXPORT_SYMBOL_GPL(__init_srcu_struct);=0D
> > +EXPORT_SYMBOL_GPL(init_srcu_struct_lockdep);=0D
> =0D
> init_srcu_struct_lockdep() invokes __init_srcu_struct_common()...=0D
> =0D
> >  int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name,=
 struct lock_class_key *key)=0D
> >  {=0D
> > @@ -301,12 +302,12 @@ EXPORT_SYMBOL_GPL(__init_srcu_struct_fast_updown)=
;=0D
> >   * to any other function.  Each srcu_struct represents a separate doma=
in=0D
> >   * of SRCU protection.=0D
> >   */=0D
> > -int init_srcu_struct(struct srcu_struct *ssp)=0D
> > +int init_srcu_struct_generic(struct srcu_struct *ssp)=0D
> >  {=0D
> >  	ssp->srcu_reader_flavor =3D 0;=0D
> >  	return init_srcu_struct_fields(ssp, false);=0D
> >  }=0D
> > -EXPORT_SYMBOL_GPL(init_srcu_struct);=0D
> > +EXPORT_SYMBOL_GPL(init_srcu_struct_generic);=0D
> =0D
> init_srcu_struct_generic() invokes init_srcu_struct_fields()...=0D
> =0D
> This gets me the structure shown in the attached PDF.  Did I get it=0D
> right?=0D
> =0D
=0D
Yes, it looks right.=0D
=0D
> I am surprised not to see any changes involving cleanup_srcu_struct().=0D
> What did I miss?=0D
> =0D
=0D
Do you mean changing cleanup_srcu_struct() on the C side? As I mentioned=0D
previously [1], I would prefer to keep the current approach for now and=0D
see what others think. If we receive complaints from other people, we can=0D
then consider proposing an alternative approach which would likely involve=
=0D
changing (or simply adding) C code.=0D
=0D
Personally, I prefer the current approach because it doesn't add any=0D
complexity. The problem is already documented and it's highly unlikely=0D
that we will ever hit it in practice. It's fairly easy to catch those=0D
kind of mistakes (leaking the guard explicitly with mem::forget) on=0D
review.=0D
=0D
Even if we add a dedicated cleanup function on the C side, leaking an=0D
SRCU guard should still not be allowed and should be treated as a=0D
"bad code" and should require a follow-up patch. Adding a special C=0D
function that changes counters just switches "don't leak an SRCU guard"=0D
problem into "don't call $the_special_cleanup function anywhere else".=0D
=0D
[1]: https://lore.kernel.org/all/20260531191107.35357-1-work@onurozkan.dev=
=0D
=0D
> And again, please put the following in a later patch to allow separate=0D
> evaluation of the restructuring.=0D
> =0D
=0D
Sure thing. I will split them in the next version.=0D
=0D
Thanks,=0D
Onur=0D
=0D
> 							Thanx, Paul=0D
> =0D
> >  /**=0D
> >   * init_srcu_struct_fast - initialize a fast-reader sleep-RCU structur=
e=0D
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
> > -- =0D
> > 2.51.2=0D
> > =0D
