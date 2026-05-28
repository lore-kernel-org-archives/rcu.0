Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B8233921
	for <rcu@vger.kernel.org>; Thu, 28 May 2026 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957330; cv=none; b=eUf2YY+ecBJ72DM6n3Y+tExnitYhCk1ChOlEUF+uvwDJ8gwaSRgZeqLORW56PdHaCKW8yMXabjzAtmglQPE1sf96HGAKyYYvFpRfTuxjxVG6gDktTJF5DptOFcs8U1S+ihQmds6tasDqzjmVwvR7Ehebt6qeHfmDVhL9Ds1ExAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957330; c=relaxed/simple;
	bh=JR+aANfsMzjm1rp2oQn8bJaI5JZtGBSVJoA8bsDp+nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVO1M6zmImho8BEzrsoAejlX7TKyauHaqVDEBHMZFZtPYpzNfhmz6i09OxT9KkhSwL5rCBXwR/gARoMhmnKguHVTPmtdczB1b03CpNQF4n1TXK2VMxHt7T+aaDFDvHnu6nL3plaGbDAe1pNovxjqNqbdCF7ykCCCWQPoI+9X75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Y+dFCKg4; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Y+dFCKg4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779957323; x=1780216523;
	bh=W/YOhaU+B5cefnv85Y54hlzEnmfrXLys8pCxEx2wXfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Y+dFCKg4bXdcAnVUE4i7F390LhDLUbUlJWCI0zA3KdrohfKWfPPxr3vE0a6eLUpVt
	 n+y7rdpXbC1JElBSN4buIlk5hDGZcGfKXwGDGiIf+O4Ys6nERs1BCRathkGG4mnZnF
	 3OJ8ZyRi3fs2FL2AMI3OgyXoqk9mNEv4Yc91+PXkz3GN5xB0x02d/GgdVaF6gOL+o1
	 4f4HlTDt2Zk9Y3DcCbzodU+9iiXHfUD4zNrqsz/6dIVAaiqGomEF839PcqqH2RgQfl
	 +sHlg8hyvNZ0t7GpUH+3ibrQOnSgdF2FddmD8Etph8aC5PBwEjgG1YKZV9sT994Aks
	 ZbFw2sduPl+pQ==
X-Pm-Submission-Id: 4gR0DR3rrfz2ScNP
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
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
	paulmck@kernel.org,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
Date: Thu, 28 May 2026 11:35:15 +0300
Message-ID: <20260528083518.66203-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260528082025.44414-1-work@onurozkan.dev>
References: <20260528062810.256212-1-work@onurozkan.dev> <20260528062810.256212-4-work@onurozkan.dev> <20260528082025.44414-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 May 2026 11:20:10 +0300=0D
Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
=0D
> On Thu, 28 May 2026 09:27:35 +0300=0D
> Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
> =0D
> > Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_struc=
t.=0D
> > Provide FFI helpers and a safe wrapper with a guard-based API for read-=
side=0D
> > critical sections.=0D
> > =0D
> > Cleanup is handled via `PinnedDrop`, which explicitly drains pending gr=
ace=0D
> > periods and callbacks via `synchronize_srcu` and `srcu_barrier` before=
=0D
> > executing `cleanup_srcu_struct` to guarantee memory safety e.g. when th=
ere=0D
> > are leaked guards (via `mem::forget($guard)`).=0D
> > =0D
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> > ---=0D
> >  rust/kernel/sync.rs      |   2 +=0D
> >  rust/kernel/sync/srcu.rs | 166 +++++++++++++++++++++++++++++++++++++++=
=0D
> >  2 files changed, 168 insertions(+)=0D
> >  create mode 100644 rust/kernel/sync/srcu.rs=0D
> > =0D
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
> > index 000000000000..343f00d070c7=0D
> > --- /dev/null=0D
> > +++ b/rust/kernel/sync/srcu.rs=0D
> > @@ -0,0 +1,166 @@=0D
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
> > +#[doc(hidden)]=0D
> > +#[macro_export]=0D
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
> > +/// The destructor waits for active readers and callbacks, so it may s=
leep.=0D
> > +/// If a read-side guard has been leaked, dropping an [`Srcu`] may nev=
er return.=0D
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
> > +            // INVARIANT: On success, the C initializer creates a vali=
d `srcu_struct` and=0D
> > +            // it remains pinned until `PinnedDrop` runs.=0D
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
> > +    /// Leaking the returned [`Guard`] leaves the SRCU read-side criti=
cal=0D
> > +    /// section active and makes `drop` sleep forever.=0D
> > +    #[inline]=0D
> > +    pub fn read_lock(&self) -> Guard<'_> {=0D
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
> > +        // SAFETY: By the type invariants, `self` contains a valid and=
 pinned `struct srcu_struct`=0D
> > +        // and `srcu_readers_active()` only checks the active reader c=
ount.=0D
> > +        if unsafe { bindings::srcu_readers_active(ptr) } {=0D
> > +            crate::pr_warn!(=0D
> > +                "Leaked `Guard` detected while dropping SRCU; drop wil=
l block forever.\n"=0D
> > +            );=0D
> > +        }=0D
> > +=0D
> > +        // `cleanup_srcu_struct()` may return early if readers are sti=
ll active. Because `Srcu`=0D
> > +        // owns the embedded `srcu_struct`, returning from `drop` in t=
hat state could free memory=0D
> > +        // that is still referenced by the C side.=0D
> > +        //=0D
> > +        // Wait for all readers to complete first. If any `Guard` was =
leaked, `synchronize_srcu()`=0D
> > +        // will sleep forever.=0D
> > +        //=0D
> > +        // SAFETY: By the type invariants, `self` contains a valid and=
 pinned `struct srcu_struct`.=0D
> > +        unsafe { bindings::synchronize_srcu(ptr) };=0D
> =0D
> Sashiko got a good point here which is calling synchronize_srcu() only if=
 there=0D
> are active readers. That's a nice low-effort improvement we can have in t=
he next=0D
> version.=0D
> =0D
> Onur=0D
=0D
Actually, now I am now thinking about whether we can come up with a better=
=0D
approach when we detect leaked guards. Initially I came up with the=0D
synchronize_srcu() solution because it would handle leaked guards automatic=
ally=0D
without requiring any additional checks. But now that we can actually detec=
t=0D
whether guards are leaked the question becomes:=0D
=0D
	"Is there a better option than effectively sleeping forever when leaked=0D
	 guards are detected?"=0D
=0D
I have no plans for tomorrow other than finalizing this series including th=
e=0D
question above.=0D
=0D
Onur=0D
=0D
> =0D
> > +=0D
> > +        // Ensure all SRCU callbacks have been finished before freeing=
.=0D
> > +        // SAFETY: By the type invariants, `self` contains a valid and=
 pinned `struct srcu_struct`.=0D
> > +        unsafe { bindings::srcu_barrier(ptr) };=0D
> > +=0D
> > +        // SAFETY: By the type invariants, `self` contains a valid and=
 pinned `struct srcu_struct`.=0D
> > +        unsafe { bindings::cleanup_srcu_struct(ptr) };=0D
> > +    }=0D
> > +}=0D
> > +=0D
> > +// SAFETY: `srcu_struct` may be shared and used across threads.=0D
> > +unsafe impl Send for Srcu {}=0D
> > +// SAFETY: `srcu_struct` may be shared and used concurrently.=0D
> > +unsafe impl Sync for Srcu {}=0D
> > +=0D
> > +/// Guard for an active SRCU read-side critical section on a particula=
r [`Srcu`].=0D
> > +///=0D
> > +/// Leaking this guard with [`core::mem::forget`] leaves the SRCU read=
-side=0D
> > +/// critical section active and makes dropping the associated [`Srcu`]=
 sleep forever.=0D
> > +///=0D
> > +/// # Invariants=0D
> > +///=0D
> > +/// `idx` is the index returned by `srcu_read_lock()` for `srcu`.=0D
> > +#[must_use =3D "if unused, the lock will be immediately unlocked"]=0D
> > +pub struct Guard<'a> {=0D
> > +    srcu: &'a Srcu,=0D
> > +    idx: i32,=0D
> > +    _not_send: NotThreadSafe,=0D
> > +}=0D
> > +=0D
> > +impl Guard<'_> {=0D
> > +    /// Explicitly releases the SRCU read-side critical section.=0D
> > +    #[inline]=0D
> > +    pub fn unlock(self) {}=0D
> > +}=0D
> > +=0D
> > +impl Drop for Guard<'_> {=0D
> > +    #[inline]=0D
> > +    fn drop(&mut self) {=0D
> > +        // SAFETY: `Guard` is only constructible through `Srcu::read_l=
ock()`,=0D
> > +        // which returns a valid index for the SRCU instance.=0D
> > +        unsafe { bindings::srcu_read_unlock(self.srcu.inner.get(), sel=
f.idx) };=0D
> > +    }=0D
> > +}=0D
> > -- =0D
> > 2.51.2=0D
> > =0D
