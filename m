Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9B325B084;
	Sat, 30 May 2026 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780122465; cv=none; b=RtGPsSklxFoI2cRgHSFKeMcb0kxPD2HJ1nPPJi6XURwUHdetJ7J7pjAfOOU1bZWEqjEGb3r+fFG32WvsuftNXH+m43rdMlBC6jxWh5ZcAyu5Neg2k5yrDhdpV7y6mvBEbkmdjYDvKHTtrPW4rp3owenk1Gh5EUTjocB3rMfY0OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780122465; c=relaxed/simple;
	bh=yMAHVCFmmUiFAK92xcvyI4Ulktoa4C5f8gjeqX9lvHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocyIGDmTIAsjc2nC3yod2zG999vo/MBZxMen05OQj7Z6B0ZTl0qYtVTHUR80NIRq+a72qg7FLN05OumOr2a8rAeD+g6HCcOu7aPVZ0nWcclX00W4t2pZT2zOirURRsBXXJnRQNG+h1zRzdPm+xkLUy2Kpri88bZEppIs7q8JQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=uSdFtXWo; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="uSdFtXWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780122457; x=1780381657;
	bh=/7KVO7NNVVZLhgs7uHvMHpbUVIAm88VHLPbRqmbLeB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uSdFtXWoivbUdLoiYfJ/GPnIDXI7SH9SlBfvWTnv7lSb1wxwGyd/JekhNUyQkT3OR
	 BlJvLEwHtfjtgdK0RYGqLC8HleOMKn21/XthOOiucKZLhMov5X0z2x/vkL8hK/6hNC
	 REqMrSzDP6JKJl86VO5Zg2dvNThDOQDOs06xaSHIv0jjSM4EzkgqXkXEk1MxT23F9l
	 1n6du1eIzrmPRo5U3SBdYLg5cgSxhEwOAgvHsWVpAG4IphXH0O9ws4MnPpuoEfqnaU
	 G6A72IWk/PI6xgJLMoQ6eJqJyAI48Ja/FjZMoeQAAGrLZZS8Qvj/gehPz1+Endw5gZ
	 Ok/b8jFInRXog==
X-Pm-Submission-Id: 4gS9J35k6Bz1DF6h
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
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
Date: Sat, 30 May 2026 09:27:29 +0300
Message-ID: <20260530062730.38077-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <b4f6d3e8-3a08-409e-89ae-ba5d612bae30@paulmck-laptop>
References: <20260528062810.256212-1-work@onurozkan.dev> <20260528062810.256212-4-work@onurozkan.dev> <20260528082025.44414-1-work@onurozkan.dev> <20260528083518.66203-1-work@onurozkan.dev> <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net> <b4f6d3e8-3a08-409e-89ae-ba5d612bae30@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 08:36:16 -0700=0D
"Paul E. McKenney" <paulmck@kernel.org> wrote:=0D
=0D
> On Thu, May 28, 2026 at 01:23:39PM +0100, Gary Guo wrote:=0D
> > On Thu May 28, 2026 at 9:35 AM BST, Onur =C3=96zkan wrote:=0D
> > > On Thu, 28 May 2026 11:20:10 +0300=0D
> > > Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
> > >=0D
> > >> On Thu, 28 May 2026 09:27:35 +0300=0D
> > >> Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
> > >> =0D
> > >> > Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_=
struct.=0D
> > >> > Provide FFI helpers and a safe wrapper with a guard-based API for =
read-side=0D
> > >> > critical sections.=0D
> > >> > =0D
> > >> > Cleanup is handled via `PinnedDrop`, which explicitly drains pendi=
ng grace=0D
> > >> > periods and callbacks via `synchronize_srcu` and `srcu_barrier` be=
fore=0D
> > >> > executing `cleanup_srcu_struct` to guarantee memory safety e.g. wh=
en there=0D
> > >> > are leaked guards (via `mem::forget($guard)`).=0D
> > >> > =0D
> > >> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> > >> > ---=0D
> > >> >  rust/kernel/sync.rs      |   2 +=0D
> > >> >  rust/kernel/sync/srcu.rs | 166 ++++++++++++++++++++++++++++++++++=
+++++=0D
> > >> >  2 files changed, 168 insertions(+)=0D
> > >> >  create mode 100644 rust/kernel/sync/srcu.rs=0D
> > >> > =0D
> > >> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs=0D
> > >> > index 993dbf2caa0e..0d6a5f1300c3 100644=0D
> > >> > --- a/rust/kernel/sync.rs=0D
> > >> > +++ b/rust/kernel/sync.rs=0D
> > >> > @@ -21,6 +21,7 @@=0D
> > >> >  pub mod rcu;=0D
> > >> >  mod refcount;=0D
> > >> >  mod set_once;=0D
> > >> > +pub mod srcu;=0D
> > >> >  =0D
> > >> >  pub use arc::{Arc, ArcBorrow, UniqueArc};=0D
> > >> >  pub use completion::Completion;=0D
> > >> > @@ -31,6 +32,7 @@=0D
> > >> >  pub use locked_by::LockedBy;=0D
> > >> >  pub use refcount::Refcount;=0D
> > >> >  pub use set_once::SetOnce;=0D
> > >> > +pub use srcu::Srcu;=0D
> > >> >  =0D
> > >> >  /// Represents a lockdep class.=0D
> > >> >  ///=0D
> > >> > diff --git a/rust/kernel/sync/srcu.rs b/rust/kernel/sync/srcu.rs=0D
> > >> > new file mode 100644=0D
> > >> > index 000000000000..343f00d070c7=0D
> > >> > --- /dev/null=0D
> > >> > +++ b/rust/kernel/sync/srcu.rs=0D
> > >> > @@ -0,0 +1,166 @@=0D
> > >> > +// SPDX-License-Identifier: GPL-2.0=0D
> > >> > +=0D
> > >> > +//! Sleepable read-copy update (SRCU) support.=0D
> > >> > +//!=0D
> > >> > +//! C header: [`include/linux/srcu.h`](srctree/include/linux/srcu=
.h)=0D
> > >> > +=0D
> > >> > +use crate::{=0D
> > >> > +    bindings,=0D
> > >> > +    error::to_result,=0D
> > >> > +    prelude::*,=0D
> > >> > +    sync::LockClassKey,=0D
> > >> > +    types::{=0D
> > >> > +        NotThreadSafe,=0D
> > >> > +        Opaque, //=0D
> > >> > +    },=0D
> > >> > +};=0D
> > >> > +=0D
> > >> > +use pin_init::pin_data;=0D
> > >> > +=0D
> > >> > +/// Creates an [`Srcu`] initialiser with the given name and a new=
ly-created lock class.=0D
> > >> > +#[doc(hidden)]=0D
> > >> > +#[macro_export]=0D
> > >> > +macro_rules! new_srcu {=0D
> > >> > +    ($($name:literal)?) =3D> {=0D
> > >> > +        $crate::sync::Srcu::new($crate::optional_name!($($name)?)=
, $crate::static_lock_class!())=0D
> > >> > +    };=0D
> > >> > +}=0D
> > >> > +pub use new_srcu;=0D
> > >> > +=0D
> > >> > +/// Sleepable read-copy update primitive.=0D
> > >> > +///=0D
> > >> > +/// SRCU readers may sleep while holding the read-side guard.=0D
> > >> > +///=0D
> > >> > +/// The destructor waits for active readers and callbacks, so it =
may sleep.=0D
> > >> > +/// If a read-side guard has been leaked, dropping an [`Srcu`] ma=
y never return.=0D
> > >> > +///=0D
> > >> > +/// # Invariants=0D
> > >> > +///=0D
> > >> > +/// This represents a valid `struct srcu_struct` initialized by t=
he C SRCU API=0D
> > >> > +/// and it remains pinned and valid until the pinned destructor r=
uns.=0D
> > >> > +#[repr(transparent)]=0D
> > >> > +#[pin_data(PinnedDrop)]=0D
> > >> > +pub struct Srcu {=0D
> > >> > +    #[pin]=0D
> > >> > +    inner: Opaque<bindings::srcu_struct>,=0D
> > >> > +}=0D
> > >> > +=0D
> > >> > +impl Srcu {=0D
> > >> > +    /// Creates a new SRCU instance.=0D
> > >> > +    #[inline]=0D
> > >> > +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKe=
y>) -> impl PinInit<Self, Error> {=0D
> > >> > +        try_pin_init!(Self {=0D
> > >> > +            // INVARIANT: On success, the C initializer creates a=
 valid `srcu_struct` and=0D
> > >> > +            // it remains pinned until `PinnedDrop` runs.=0D
> > >> > +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::sr=
cu_struct| {=0D
> > >> > +                // SAFETY: `ptr` points to valid uninitialised me=
mory for a `srcu_struct`.=0D
> > >> > +                to_result(unsafe {=0D
> > >> > +                    bindings::init_srcu_struct_with_key(ptr, name=
.as_char_ptr(), key.as_ptr())=0D
> > >> > +                })=0D
> > >> > +            }),=0D
> > >> > +        })=0D
> > >> > +    }=0D
> > >> > +=0D
> > >> > +    /// Enters an SRCU read-side critical section.=0D
> > >> > +    ///=0D
> > >> > +    /// Leaking the returned [`Guard`] leaves the SRCU read-side =
critical=0D
> > >> > +    /// section active and makes `drop` sleep forever.=0D
> > >> > +    #[inline]=0D
> > >> > +    pub fn read_lock(&self) -> Guard<'_> {=0D
> > >> > +        // SAFETY: By the type invariants, `self` contains a vali=
d `struct srcu_struct`.=0D
> > >> > +        let idx =3D unsafe { bindings::srcu_read_lock(self.inner.=
get()) };=0D
> > >> > +=0D
> > >> > +        // INVARIANT: `idx` was returned by `srcu_read_lock()` fo=
r this `Srcu`.=0D
> > >> > +        Guard {=0D
> > >> > +            srcu: self,=0D
> > >> > +            idx,=0D
> > >> > +            _not_send: NotThreadSafe,=0D
> > >> > +        }=0D
> > >> > +    }=0D
> > >> > +=0D
> > >> > +    /// Waits until all pre-existing SRCU readers have completed.=
=0D
> > >> > +    #[inline]=0D
> > >> > +    pub fn synchronize(&self) {=0D
> > >> > +        // SAFETY: By the type invariants, `self` contains a vali=
d `struct srcu_struct`.=0D
> > >> > +        unsafe { bindings::synchronize_srcu(self.inner.get()) };=
=0D
> > >> > +    }=0D
> > >> > +=0D
> > >> > +    /// Waits until all pre-existing SRCU readers have completed,=
 expedited.=0D
> > >> > +    ///=0D
> > >> > +    /// This requests a lower-latency grace period than [`Srcu::s=
ynchronize`] typically=0D
> > >> > +    /// at the cost of higher system-wide overhead. Prefer [`Srcu=
::synchronize`] by default=0D
> > >> > +    /// and use this variant only when reducing reset or teardown=
 latency is more important=0D
> > >> > +    /// than the extra cost.=0D
> > >> > +    #[inline]=0D
> > >> > +    pub fn synchronize_expedited(&self) {=0D
> > >> > +        // SAFETY: By the type invariants, `self` contains a vali=
d `struct srcu_struct`.=0D
> > >> > +        unsafe { bindings::synchronize_srcu_expedited(self.inner.=
get()) };=0D
> > >> > +    }=0D
> > >> > +}=0D
> > >> > +=0D
> > >> > +#[pinned_drop]=0D
> > >> > +impl PinnedDrop for Srcu {=0D
> > >> > +    fn drop(self: Pin<&mut Self>) {=0D
> > >> > +        let ptr =3D self.inner.get();=0D
> > >> > +=0D
> > >> > +        // SAFETY: By the type invariants, `self` contains a vali=
d and pinned `struct srcu_struct`=0D
> > >> > +        // and `srcu_readers_active()` only checks the active rea=
der count.=0D
> > >> > +        if unsafe { bindings::srcu_readers_active(ptr) } {=0D
> > >> > +            crate::pr_warn!(=0D
> > >> > +                "Leaked `Guard` detected while dropping SRCU; dro=
p will block forever.\n"=0D
> > >> > +            );=0D
> > =0D
> > I think this could be a `warn_on` similar to how cleanup_srcu_struct ha=
ndle the=0D
> > condition.=0D
> > =0D
> > >> > +        }=0D
> > >> > +=0D
> > >> > +        // `cleanup_srcu_struct()` may return early if readers ar=
e still active. Because `Srcu`=0D
> > >> > +        // owns the embedded `srcu_struct`, returning from `drop`=
 in that state could free memory=0D
> > >> > +        // that is still referenced by the C side.=0D
> > >> > +        //=0D
> > >> > +        // Wait for all readers to complete first. If any `Guard`=
 was leaked, `synchronize_srcu()`=0D
> > >> > +        // will sleep forever.=0D
> > >> > +        //=0D
> > >> > +        // SAFETY: By the type invariants, `self` contains a vali=
d and pinned `struct srcu_struct`.=0D
> > >> > +        unsafe { bindings::synchronize_srcu(ptr) };=0D
> > >> =0D
> > >> Sashiko got a good point here which is calling synchronize_srcu() on=
ly if there=0D
> > >> are active readers. That's a nice low-effort improvement we can have=
 in the next=0D
> > >> version.=0D
> > >> =0D
> > >> Onur=0D
> > >=0D
> > > Actually, now I am now thinking about whether we can come up with a b=
etter=0D
> > > approach when we detect leaked guards. Initially I came up with the=0D
> > > synchronize_srcu() solution because it would handle leaked guards aut=
omatically=0D
> > > without requiring any additional checks. But now that we can actually=
 detect=0D
> > > whether guards are leaked the question becomes:=0D
> > >=0D
> > > 	"Is there a better option than effectively sleeping forever when lea=
ked=0D
> > > 	 guards are detected?"=0D
> > >=0D
> > > I have no plans for tomorrow other than finalizing this series includ=
ing the=0D
> > > question above.=0D
> > =0D
> > The best solution is to proceed cleanups anyway, given Rust rules ensur=
e that=0D
> > these are actual leaks and not just srcu read-side critical section tha=
t failed=0D
> > to synchronize with the destruction of SRCU.=0D
> > =0D
> > This obviously require changes to the SRCU code though.=0D
> =0D
> Right now, the C-language SRCU code would splat and leak the srcu_struct=
=0D
> structure.  Of course, we *could* provide something that zeroed the=0D
> reader counts to avoid the splat and leak, but yikes!  Or is there a=0D
> way to make such a function available *only* to the Rust code associated=
=0D
> with cleanup_srcu_struct(), and not to other C/Rust code?=0D
> =0D
=0D
=0D
Anyone can use them if they want from `bindings::` once it's exposed to Rus=
t.=0D
=0D
Regards,=0D
Onur=0D
=0D
> 							Thanx, Paul=0D
