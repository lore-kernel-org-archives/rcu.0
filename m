Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADC245012
	for <rcu@vger.kernel.org>; Sun,  3 May 2026 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777779622; cv=none; b=BuUkP0NaNWbvIBdcce2ycMT/5wYUh8RPulM+xYKtgXVwTvm3dWoKrO/6esik86mNEVt9oHBJm022DgIJyOuX90GD2tBd8gHlu6N+WMrOpGxZmjiNTkg7ta2DT6zucv+8HDMbckeRiBPhjtaQIuLQ7/uYybNDQoqWOX4zHry2fyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777779622; c=relaxed/simple;
	bh=Z0bBtwyRq3vbhQOx0/Y0aV5EvafF5A2BFhJzXhbzY6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmyHnmui2j3ZFCkdx0zHgRPWYm2NhpFXSl+fI8QLzvH69sUnud6Q38XLga8eii7iRRg8GQdqoIZ1FMGToL9SlDVSKDEC9RG4HIhrwTqK21Cm6o6239A9OHYM8gK3se4+DoW4aPtQ2urln0ucdEcycSlRI3x2iu7dDiXQWxkc/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=tfq97gnG; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="tfq97gnG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1777779616; x=1778038816;
	bh=hCOcBvyVPsLCavIwSEc395QyLKmsax/SoNv485FioJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=tfq97gnGK1kMQznoJHotRua9qo9+a5mGLetRQ+ecvxQ9MWcCRB65+I/7dt4mmo0Rw
	 6MM9WFppXTv9PzeraTHZVHmXcEoz3JWQprLxsOFcysEzx0Q30fxzW4vCIkm2Y7i+TZ
	 TiIRxh/HX4gGHJDy6qyt5y84LODEgth8i15jcxV7T+FxTYetGU0ytoonqphLlu3YVg
	 ixK8L5307/dYba8U57rS50uwL8c9vELJMen+8G+lEsNVD2WwYJlEx3PfrJx/vD6qsn
	 I4A98DF6QKlAcq9Bmag64jDf4oxhrV0UtM+XzuiOjOdDuv8vj6feUkmrSjcoAGhd3K
	 xAxa/W3Vp5ZNA==
X-Pm-Submission-Id: 4g7VsQ1tdYz2ScXG
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
Subject: Re: [PATCH v2 2/3] rust: sync: add SRCU abstraction
Date: Sun,  3 May 2026 06:39:40 +0300
Message-ID: <20260503034008.36917-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DI8DUMY6GAM6.24VYS1478B7L8@garyguo.net>
References: <20260502162833.34334-1-work@onurozkan.dev> <20260502162833.34334-3-work@onurozkan.dev> <DI8DUMY6GAM6.24VYS1478B7L8@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 02 May 2026 18:55:56 +0100=0D
Gary Guo <gary@garyguo.net> wrote:=0D
=0D
> On Sat May 2, 2026 at 5:27 PM BST, Onur =C3=96zkan wrote:=0D
> > Add a Rust abstraction for sleepable RCU.=0D
> >=0D
> > Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_struc=
t.=0D
> > Provide FFI helpers and a safe wrapper with a guard-based API for read-=
side=0D
> > critical sections.=0D
> >=0D
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> > ---=0D
> >  rust/kernel/sync.rs      |   2 +=0D
> >  rust/kernel/sync/srcu.rs | 152 +++++++++++++++++++++++++++++++++++++++=
=0D
> >  2 files changed, 154 insertions(+)=0D
> >  create mode 100644 rust/kernel/sync/srcu.rs=0D
> >=0D
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs=0D
> > index 993dbf2caa0e..0d6a5f1300c3 100644=0D
> > --- a/rust/kernel/sync.rs=0D
> > +++ b/rust/kernel/sync.rs=0D
> > @@ -21,6 +21,7 @@=0D
> >  pub mod rcu;=0D
> >  mod refcount;=0D
> >  mod set_once;=0D
> > +pub mod srcu;=0D
> >  =0D
> >  pub use arc::{Arc, ArcBorrow, UniqueArc};=0D
> >  pub use completion::Completion;=0D
> > @@ -31,6 +32,7 @@=0D
> >  pub use locked_by::LockedBy;=0D
> >  pub use refcount::Refcount;=0D
> >  pub use set_once::SetOnce;=0D
> > +pub use srcu::Srcu;=0D
> >  =0D
> >  /// Represents a lockdep class.=0D
> >  ///=0D
> > diff --git a/rust/kernel/sync/srcu.rs b/rust/kernel/sync/srcu.rs=0D
> > new file mode 100644=0D
> > index 000000000000..7bd713e96375=0D
> > --- /dev/null=0D
> > +++ b/rust/kernel/sync/srcu.rs=0D
> > @@ -0,0 +1,152 @@=0D
> > +// SPDX-License-Identifier: GPL-2.0=0D
> > +=0D
> > +//! Sleepable read-copy update (SRCU) support.=0D
> > +//!=0D
> > +//! C header: [`include/linux/srcu.h`](srctree/include/linux/srcu.h)=0D
> > +=0D
> > +use crate::{=0D
> > +    bindings,=0D
> > +    error::to_result,=0D
> > +    prelude::*,=0D
> > +    sync::LockClassKey,=0D
> > +    types::{=0D
> > +        NotThreadSafe,=0D
> > +        Opaque, //=0D
> > +    },=0D
> > +};=0D
> > +=0D
> > +use pin_init::pin_data;=0D
> > +=0D
> > +/// Creates an [`Srcu`] initialiser with the given name and a newly-cr=
eated lock class.=0D
> > +#[macro_export]=0D
> =0D
> #[doc(hidden)]=0D
> =0D
> Given this is a new macro, let's not encourage user from using it from cr=
ate=0D
> root.=0D
> =0D
> > +macro_rules! new_srcu {=0D
> > +    ($($name:literal)?) =3D> {=0D
> > +        $crate::sync::Srcu::new($crate::optional_name!($($name)?), $cr=
ate::static_lock_class!())=0D
> > +    };=0D
> > +}=0D
> > +pub use new_srcu;=0D
> > +=0D
> > +/// Sleepable read-copy update primitive.=0D
> > +///=0D
> > +/// SRCU readers may sleep while holding the read-side guard.=0D
> > +///=0D
> > +/// The destructor may sleep.=0D
> > +///=0D
> > +/// # Invariants=0D
> > +///=0D
> > +/// This represents a valid `struct srcu_struct` initialized by the C =
SRCU API=0D
> > +/// and it remains pinned and valid until the pinned destructor runs.=
=0D
> > +#[repr(transparent)]=0D
> > +#[pin_data(PinnedDrop)]=0D
> > +pub struct Srcu {=0D
> > +    #[pin]=0D
> > +    inner: Opaque<bindings::srcu_struct>,=0D
> > +}=0D
> > +=0D
> > +impl Srcu {=0D
> > +    /// Creates a new SRCU instance.=0D
> > +    #[inline]=0D
> > +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -=
> impl PinInit<Self, Error> {=0D
> > +        try_pin_init!(Self {=0D
> > +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu_st=
ruct| {=0D
> > +                // SAFETY: `ptr` points to valid uninitialised memory =
for a `srcu_struct`.=0D
> > +                to_result(unsafe {=0D
> > +                    bindings::init_srcu_struct_with_key(ptr, name.as_c=
har_ptr(), key.as_ptr())=0D
> > +                })=0D
> > +            }),=0D
> > +        })=0D
> > +    }=0D
> > +=0D
> > +    /// Enters an SRCU read-side critical section.=0D
> > +    ///=0D
> > +    /// # Safety=0D
> > +    ///=0D
> > +    /// The returned [`Guard`] must not be leaked. Leaking it with [`c=
ore::mem::forget`]=0D
> > +    /// leaves the SRCU read-side critical section active.=0D
> =0D
> I generally would prefer if we could use guard-like API instead of forcin=
g a=0D
> callback.=0D
=0D
Me too and developers can still do that. I think the safety contract here i=
s=0D
very simple to handle. It's essentially this:=0D
=0D
	// SAFETY: Guard is not leaked.=0D
	let _guard =3D unsafe { x.read_lock() };=0D
=0D
To me it's very simple and straightforward for both the developer and the=0D
reviewer. It doesn't add any overhead to the implementation and it ensures=
=0D
that the developer (and later the reviewer) is aware of the potential issue=
.=0D
=0D
Of course, there's also the safe option if the developer is happy with=0D
closure-based API:=0D
=0D
	x.with_read_lock(|_guard| {=0D
		...=0D
	});=0D
=0D
So it allows you to use the guard-based approach directly with the requirem=
ent=0D
of a safety comment and also provides a safe API for developers who don't w=
ant=0D
to deal with that. I am not sure if you fall into the third category, which=
 is=0D
"I don't like writing safety comments and I don't like the closure-based=0D
approach" :)=0D
=0D
> =0D
> I suppose the only reason that this is unsafe is the "just leak it" condi=
tion=0D
> when cleaning up SRCU struct, which skips cleaning up delayed work, which=
 could=0D
> call into `process_srcu`, which accesses `srcu_struct`. This however is *=
not*=0D
> leaked, because it's controlled by the user. Only the auxillary data allo=
cated=0D
> by SRCU is leaked. So UAF is going to happen.=0D
> =0D
> So in some aspect, the leak caused by `srcu_readers_active(ssp)` can caus=
e more=0D
> damage compared to just continuing cleanup despite active users? I think =
this=0D
> could be changed in one of these ways:=0D
> * Have SRCU allocate all memory instead, and user-side would just have a=
=0D
>   `struct srcu_struct*`; then leaking would be safe. This is probably a b=
it=0D
>   difficult to change because it affects many users.=0D
=0D
We could do the same on the Rust side only. Basically instead of embedding=
=0D
srcu_struct in Rust srcu, allocate it separately and store its pointer. The=
n,=0D
if cleanup hits the active reader case, we could leak that allocation so an=
y=0D
remaining srcu work does not hit UAF. I was aware of this option but I woul=
d=0D
prefer to avoid it because it adds an extra allocation for every Rust srcu.=
=0D
=0D
> * Continue to flush delayed work and stop the timer, and then leak before=
 the=0D
>   actual kfree happens.=0D
=0D
Can you say more? I didn't understand this particular solution.=0D
=0D
> * Trigger a `BUG` when the leak condition is hit for Rust users.=0D
=0D
We need an atomic counter to detect the leak and I thought that would be to=
o=0D
much overhead for this abstraction. Basically each lock and drop will call =
an=0D
atomic operation so.=0D
=0D
> * Declare the `WARN_ON` to be a sufficient protection and say this can be=
=0D
>   considered safe. Kinda similar to the strategy we take to the=0D
>   sleep-inside-atomic context issue.=0D
=0D
I think this is a rather weak precaution.=0D
=0D
> =0D
> > +    #[inline]=0D
> > +    pub unsafe fn read_lock(&self) -> Guard<'_> {=0D
> > +        // SAFETY: By the type invariants, `self` contains a valid `st=
ruct srcu_struct`.=0D
> > +        let idx =3D unsafe { bindings::srcu_read_lock(self.inner.get()=
) };=0D
> > +=0D
> > +        // INVARIANT: `idx` was returned by `srcu_read_lock()` for thi=
s `Srcu`.=0D
> > +        Guard {=0D
> > +            srcu: self,=0D
> > +            idx,=0D
> > +            _not_send: NotThreadSafe,=0D
> > +        }=0D
> > +    }=0D
> > +=0D
> > +    /// Runs `f` in an SRCU read-side critical section.=0D
> > +    #[inline]=0D
> > +    pub fn with_read_lock<T>(&self, f: impl FnOnce(&Guard<'_>) -> T) -=
> T {=0D
> > +        // SAFETY: The guard is owned within this function and is not =
leaked.=0D
> > +        let guard =3D unsafe { self.read_lock() };=0D
> > +=0D
> > +        f(&guard)=0D
> > +    }=0D
> > +=0D
> > +    /// Waits until all pre-existing SRCU readers have completed.=0D
> > +    #[inline]=0D
> > +    pub fn synchronize(&self) {=0D
> > +        // SAFETY: By the type invariants, `self` contains a valid `st=
ruct srcu_struct`.=0D
> > +        unsafe { bindings::synchronize_srcu(self.inner.get()) };=0D
> > +    }=0D
> > +=0D
> > +    /// Waits until all pre-existing SRCU readers have completed, expe=
dited.=0D
> > +    ///=0D
> > +    /// This requests a lower-latency grace period than [`Srcu::synchr=
onize`] typically=0D
> > +    /// at the cost of higher system-wide overhead. Prefer [`Srcu::syn=
chronize`] by default=0D
> > +    /// and use this variant only when reducing reset or teardown late=
ncy is more important=0D
> > +    /// than the extra cost.=0D
> > +    #[inline]=0D
> > +    pub fn synchronize_expedited(&self) {=0D
> > +        // SAFETY: By the type invariants, `self` contains a valid `st=
ruct srcu_struct`.=0D
> > +        unsafe { bindings::synchronize_srcu_expedited(self.inner.get()=
) };=0D
> > +    }=0D
> > +}=0D
> > +=0D
> > +#[pinned_drop]=0D
> > +impl PinnedDrop for Srcu {=0D
> > +    fn drop(self: Pin<&mut Self>) {=0D
> > +        let ptr =3D self.inner.get();=0D
> > +=0D
> =0D
> This needs a comment on why this is invoked. Something like:=0D
> =0D
>     // Ensure all SRCU callbacks have been finished before freeing.=0D
> =0D
> Best,=0D
> Gary=0D
> =0D
> > +        // SAFETY: By the type invariants, `self` contains a valid and=
 pinned `struct srcu_struct`.=0D
> > +        unsafe { bindings::srcu_barrier(ptr) };=0D
> > +        // SAFETY: Same as above.=0D
> > +        unsafe { bindings::cleanup_srcu_struct(ptr) };=0D
> > +    }=0D
> > +}=0D
> > +=0D
> > +// SAFETY: `srcu_struct` may be shared and used across threads.=0D
> > +unsafe impl Send for Srcu {}=0D
> > +// SAFETY: `srcu_struct` may be shared and used concurrently.=0D
> > +unsafe impl Sync for Srcu {}=0D
