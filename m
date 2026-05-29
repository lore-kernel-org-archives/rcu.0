Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296773815E8
	for <rcu@vger.kernel.org>; Fri, 29 May 2026 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037883; cv=none; b=ebSNTXfi7u1Tur5GiKY/Sf8IkaeUAYmVSOoSf0+e+lOyNWLnZWR4Cp4Fd2PxkAaO73ZLGCc49w23R+ec5sbrPsDP5LoZgwl5tEchNwtUDx5HY9h6KgEPsFTsYI7d4abC/mMpxdbexPAqsLKFqfbPaisedrQFv0aCB0sGQY++tkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037883; c=relaxed/simple;
	bh=Bfa1nOHtwvFxIGKyPcX37ZzaUMpx5lAL/3XJ6oGnaeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vB4/gNV+WIsRGkAJzZOMg6EWkoJrl2hnGD6QDa+gk6/vOVAfx6AiLxTAKmetLttnGC6ProIRJUEIR+j62Hl5WJMOgO0xi/tZdBcjdm7+wiQnuSLjhmQSZXV3ZdFFcRD57plOMGtr38tokPRonbIIh9IWStsCKFN9zqL6IV/ot04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=pgSkExiJ; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="pgSkExiJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780037872; x=1780297072;
	bh=/bW7+2bHtYC9OMYeat4EhQjViNItbOtbPfXoUnZbITs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=pgSkExiJCjn7MxTrDd/rcqPU5xBXcR0YbXBLoRbtflG7PCgj4giSNMPr7yU3d4f/v
	 Y6937EoAo/lxE6aIqXi7fErkpX8gr/Qe5TG8Qgqu/NDpYVw1EOgN7i09hOBRTGL4ZX
	 UiPVQX3v44SMk/wLx2mAYI+6Zugd7W0g7kuRgAXU56+UUUx1hbgRT/zROquQ14gD9E
	 +rqXiqkyLNqK4EZNSVIobqXeu26D09tny4SvH/u0Hyun0kN+apThELyCAB9uDGVs/v
	 3GACQcU/45ubzvjsI8wz8toAoXRgVQUPWKcZk2nNJbaneZgUg7+QvPcIcvXWu2Put5
	 LP0n2kCM+ipCg==
X-Pm-Submission-Id: 4gRZ1Q4sH0z1DDKv
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
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
Date: Fri, 29 May 2026 09:57:37 +0300
Message-ID: <20260529065744.59786-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net>
References: <20260528062810.256212-1-work@onurozkan.dev> <20260528062810.256212-4-work@onurozkan.dev> <20260528082025.44414-1-work@onurozkan.dev> <20260528083518.66203-1-work@onurozkan.dev> <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 May 2026 13:23:39 +0100=0D
Gary Guo <gary@garyguo.net> wrote:=0D
=0D
> On Thu May 28, 2026 at 9:35 AM BST, Onur =C3=96zkan wrote:=0D
> > On Thu, 28 May 2026 11:20:10 +0300=0D
> > Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
> >=0D
> >> On Thu, 28 May 2026 09:27:35 +0300=0D
> >> Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
> >> =0D
> >> > Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_st=
ruct.=0D
> >> > Provide FFI helpers and a safe wrapper with a guard-based API for re=
ad-side=0D
> >> > critical sections.=0D
> >> > =0D
> >> > Cleanup is handled via `PinnedDrop`, which explicitly drains pending=
 grace=0D
> >> > periods and callbacks via `synchronize_srcu` and `srcu_barrier` befo=
re=0D
> >> > executing `cleanup_srcu_struct` to guarantee memory safety e.g. when=
 there=0D
> >> > are leaked guards (via `mem::forget($guard)`).=0D
> >> > =0D
> >> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> >> > ---=0D
> >> >  rust/kernel/sync.rs      |   2 +=0D
> >> >  rust/kernel/sync/srcu.rs | 166 ++++++++++++++++++++++++++++++++++++=
+++=0D
> >> >  2 files changed, 168 insertions(+)=0D
> >> >  create mode 100644 rust/kernel/sync/srcu.rs=0D
> >> > =0D
> >> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs=0D
> >> > index 993dbf2caa0e..0d6a5f1300c3 100644=0D
> >> > --- a/rust/kernel/sync.rs=0D
> >> > +++ b/rust/kernel/sync.rs=0D
> >> > @@ -21,6 +21,7 @@=0D
> >> >  pub mod rcu;=0D
> >> >  mod refcount;=0D
> >> >  mod set_once;=0D
> >> > +pub mod srcu;=0D
> >> >  =0D
> >> >  pub use arc::{Arc, ArcBorrow, UniqueArc};=0D
> >> >  pub use completion::Completion;=0D
> >> > @@ -31,6 +32,7 @@=0D
> >> >  pub use locked_by::LockedBy;=0D
> >> >  pub use refcount::Refcount;=0D
> >> >  pub use set_once::SetOnce;=0D
> >> > +pub use srcu::Srcu;=0D
> >> >  =0D
> >> >  /// Represents a lockdep class.=0D
> >> >  ///=0D
> >> > diff --git a/rust/kernel/sync/srcu.rs b/rust/kernel/sync/srcu.rs=0D
> >> > new file mode 100644=0D
> >> > index 000000000000..343f00d070c7=0D
> >> > --- /dev/null=0D
> >> > +++ b/rust/kernel/sync/srcu.rs=0D
> >> > @@ -0,0 +1,166 @@=0D
> >> > +// SPDX-License-Identifier: GPL-2.0=0D
> >> > +=0D
> >> > +//! Sleepable read-copy update (SRCU) support.=0D
> >> > +//!=0D
> >> > +//! C header: [`include/linux/srcu.h`](srctree/include/linux/srcu.h=
)=0D
> >> > +=0D
> >> > +use crate::{=0D
> >> > +    bindings,=0D
> >> > +    error::to_result,=0D
> >> > +    prelude::*,=0D
> >> > +    sync::LockClassKey,=0D
> >> > +    types::{=0D
> >> > +        NotThreadSafe,=0D
> >> > +        Opaque, //=0D
> >> > +    },=0D
> >> > +};=0D
> >> > +=0D
> >> > +use pin_init::pin_data;=0D
> >> > +=0D
> >> > +/// Creates an [`Srcu`] initialiser with the given name and a newly=
-created lock class.=0D
> >> > +#[doc(hidden)]=0D
> >> > +#[macro_export]=0D
> >> > +macro_rules! new_srcu {=0D
> >> > +    ($($name:literal)?) =3D> {=0D
> >> > +        $crate::sync::Srcu::new($crate::optional_name!($($name)?), =
$crate::static_lock_class!())=0D
> >> > +    };=0D
> >> > +}=0D
> >> > +pub use new_srcu;=0D
> >> > +=0D
> >> > +/// Sleepable read-copy update primitive.=0D
> >> > +///=0D
> >> > +/// SRCU readers may sleep while holding the read-side guard.=0D
> >> > +///=0D
> >> > +/// The destructor waits for active readers and callbacks, so it ma=
y sleep.=0D
> >> > +/// If a read-side guard has been leaked, dropping an [`Srcu`] may =
never return.=0D
> >> > +///=0D
> >> > +/// # Invariants=0D
> >> > +///=0D
> >> > +/// This represents a valid `struct srcu_struct` initialized by the=
 C SRCU API=0D
> >> > +/// and it remains pinned and valid until the pinned destructor run=
s.=0D
> >> > +#[repr(transparent)]=0D
> >> > +#[pin_data(PinnedDrop)]=0D
> >> > +pub struct Srcu {=0D
> >> > +    #[pin]=0D
> >> > +    inner: Opaque<bindings::srcu_struct>,=0D
> >> > +}=0D
> >> > +=0D
> >> > +impl Srcu {=0D
> >> > +    /// Creates a new SRCU instance.=0D
> >> > +    #[inline]=0D
> >> > +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>=
) -> impl PinInit<Self, Error> {=0D
> >> > +        try_pin_init!(Self {=0D
> >> > +            // INVARIANT: On success, the C initializer creates a v=
alid `srcu_struct` and=0D
> >> > +            // it remains pinned until `PinnedDrop` runs.=0D
> >> > +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu=
_struct| {=0D
> >> > +                // SAFETY: `ptr` points to valid uninitialised memo=
ry for a `srcu_struct`.=0D
> >> > +                to_result(unsafe {=0D
> >> > +                    bindings::init_srcu_struct_with_key(ptr, name.a=
s_char_ptr(), key.as_ptr())=0D
> >> > +                })=0D
> >> > +            }),=0D
> >> > +        })=0D
> >> > +    }=0D
> >> > +=0D
> >> > +    /// Enters an SRCU read-side critical section.=0D
> >> > +    ///=0D
> >> > +    /// Leaking the returned [`Guard`] leaves the SRCU read-side cr=
itical=0D
> >> > +    /// section active and makes `drop` sleep forever.=0D
> >> > +    #[inline]=0D
> >> > +    pub fn read_lock(&self) -> Guard<'_> {=0D
> >> > +        // SAFETY: By the type invariants, `self` contains a valid =
`struct srcu_struct`.=0D
> >> > +        let idx =3D unsafe { bindings::srcu_read_lock(self.inner.ge=
t()) };=0D
> >> > +=0D
> >> > +        // INVARIANT: `idx` was returned by `srcu_read_lock()` for =
this `Srcu`.=0D
> >> > +        Guard {=0D
> >> > +            srcu: self,=0D
> >> > +            idx,=0D
> >> > +            _not_send: NotThreadSafe,=0D
> >> > +        }=0D
> >> > +    }=0D
> >> > +=0D
> >> > +    /// Waits until all pre-existing SRCU readers have completed.=0D
> >> > +    #[inline]=0D
> >> > +    pub fn synchronize(&self) {=0D
> >> > +        // SAFETY: By the type invariants, `self` contains a valid =
`struct srcu_struct`.=0D
> >> > +        unsafe { bindings::synchronize_srcu(self.inner.get()) };=0D
> >> > +    }=0D
> >> > +=0D
> >> > +    /// Waits until all pre-existing SRCU readers have completed, e=
xpedited.=0D
> >> > +    ///=0D
> >> > +    /// This requests a lower-latency grace period than [`Srcu::syn=
chronize`] typically=0D
> >> > +    /// at the cost of higher system-wide overhead. Prefer [`Srcu::=
synchronize`] by default=0D
> >> > +    /// and use this variant only when reducing reset or teardown l=
atency is more important=0D
> >> > +    /// than the extra cost.=0D
> >> > +    #[inline]=0D
> >> > +    pub fn synchronize_expedited(&self) {=0D
> >> > +        // SAFETY: By the type invariants, `self` contains a valid =
`struct srcu_struct`.=0D
> >> > +        unsafe { bindings::synchronize_srcu_expedited(self.inner.ge=
t()) };=0D
> >> > +    }=0D
> >> > +}=0D
> >> > +=0D
> >> > +#[pinned_drop]=0D
> >> > +impl PinnedDrop for Srcu {=0D
> >> > +    fn drop(self: Pin<&mut Self>) {=0D
> >> > +        let ptr =3D self.inner.get();=0D
> >> > +=0D
> >> > +        // SAFETY: By the type invariants, `self` contains a valid =
and pinned `struct srcu_struct`=0D
> >> > +        // and `srcu_readers_active()` only checks the active reade=
r count.=0D
> >> > +        if unsafe { bindings::srcu_readers_active(ptr) } {=0D
> >> > +            crate::pr_warn!(=0D
> >> > +                "Leaked `Guard` detected while dropping SRCU; drop =
will block forever.\n"=0D
> >> > +            );=0D
> =0D
> I think this could be a `warn_on` similar to how cleanup_srcu_struct hand=
le the=0D
> condition.=0D
=0D
We also call cleanup_srcu_struct below. The idea was to provide additional=
=0D
information, we don't need to call warn_on twice.=0D
=0D
> =0D
> >> > +        }=0D
> >> > +=0D
> >> > +        // `cleanup_srcu_struct()` may return early if readers are =
still active. Because `Srcu`=0D
> >> > +        // owns the embedded `srcu_struct`, returning from `drop` i=
n that state could free memory=0D
> >> > +        // that is still referenced by the C side.=0D
> >> > +        //=0D
> >> > +        // Wait for all readers to complete first. If any `Guard` w=
as leaked, `synchronize_srcu()`=0D
> >> > +        // will sleep forever.=0D
> >> > +        //=0D
> >> > +        // SAFETY: By the type invariants, `self` contains a valid =
and pinned `struct srcu_struct`.=0D
> >> > +        unsafe { bindings::synchronize_srcu(ptr) };=0D
> >> =0D
> >> Sashiko got a good point here which is calling synchronize_srcu() only=
 if there=0D
> >> are active readers. That's a nice low-effort improvement we can have i=
n the next=0D
> >> version.=0D
> >> =0D
> >> Onur=0D
> >=0D
> > Actually, now I am now thinking about whether we can come up with a bet=
ter=0D
> > approach when we detect leaked guards. Initially I came up with the=0D
> > synchronize_srcu() solution because it would handle leaked guards autom=
atically=0D
> > without requiring any additional checks. But now that we can actually d=
etect=0D
> > whether guards are leaked the question becomes:=0D
> >=0D
> > 	"Is there a better option than effectively sleeping forever when leake=
d=0D
> > 	 guards are detected?"=0D
> >=0D
> > I have no plans for tomorrow other than finalizing this series includin=
g the=0D
> > question above.=0D
> =0D
> The best solution is to proceed cleanups anyway, given Rust rules ensure =
that=0D
> these are actual leaks and not just srcu read-side critical section that =
failed=0D
> to synchronize with the destruction of SRCU.=0D
> =0D
> This obviously require changes to the SRCU code though.=0D
=0D
=0D
The issue is difficult to fix purely from the C side. Once drop returns Rus=
t=0D
is free to destroy srcu_struct. If srcu still has pending callback associat=
ed=0D
with that srcu_struct, for example from a future call_srcu() wrapper then=0D
returning from drop while readers are active can turn into a UAF. There is =
also=0D
no way to handle callbacks in a reasonable way in cleanup logic while there=
 are=0D
active readers.=0D
=0D
I mean in theory this could be fixed in the C code, but that would require =
to=0D
re-write srcu cores/semantics for this special case. The $clean_something h=
elper=0D
would need know that the active readers are abandoned and will never unlock=
 and=0D
it would also need to decide what to do with the pending callbacks, which i=
s=0D
also a big problem (as gp will never complete, callbacks will never run).=0D
=0D
It's also worth to note that calling mem::forget on the srcu guard is WRONG=
=0D
CODE and very easy to catch on review (by us and also Sashiko/any LLM). So=
=0D
finding a solution that doesn't add too much complexity should be a key=0D
consideration here. With that in mind, keeping the synchronize_srcu() not r=
eally=0D
a bad solution. Sleeping forever is a bad failure mode, but it is better th=
an a=0D
potential UAF and either case requires sending a fix patch for the leaked g=
uard=0D
anyway.=0D
=0D
- Onur=0D
=0D
> =0D
> Best,=0D
> Gary=0D
> =0D
