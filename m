Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFC378822
	for <rcu@vger.kernel.org>; Thu, 28 May 2026 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956441; cv=none; b=moUutDLyXSCXiypHuwBFNQbb8kGuNdtfgTDBWfdY+Ru42TdXoteT/Psgw/UKO7kQN/vJpv0YQLSCINqM4PfbX/vzQ2ravuL+fEFLKJnzFu82KUJYkGe+XWVhs7PiPvf9bzeBoXTi5amJkKFIOYrKS51gmVMvbbgYWt0XkOKUl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956441; c=relaxed/simple;
	bh=67xLME/jrqvDN+6o0vE0p8K4JnPPiwDhkF3zcWvoMDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9NEvSqgS+myxF9WeabtDimcLZSr1mqoYjBtA0DhAoRQrTDidZ5elJZIpu6Fe5ZJTxoRq9fLqn7W9Zek6be7a5PJoh6BdMJL3fqcdF1ia4VH2GURaQYOGhLL8UnhpuwnW+UnjsqB5Wvgu3P5R0hqSS6HuUSlxC38vCgdfLSNrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=tk7TWDIN; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="tk7TWDIN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779956434; x=1780215634;
	bh=El77Hs0w/tnGS3/Zfzv8VmSeAqqh1AD94Dk/chXGtlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=tk7TWDINt3nXUJqg3lk3QOPs7BOCIVQruT3h0r2WbqPaD1fGc5xk2HWeOOk4JkdDH
	 gYZy4NpeAucc5chY9jB4IVNJtOcoQqzHmD+AvL548YYnkSLQtk48nc/ioK6tOCsxhv
	 6vLzxX9pOYBT/xyxXAtARLQyYA8B7K107R9UQpK4ghZgZnrMFfu1NB5B1DvfANCQkY
	 H2e8ZaHvoxuPTfLihZ1NRhj5H6d68onNKN9Kz0SGUmbHFMkyiWOPojjuY4MOLXhR6v
	 GFyCP/+67J8cLfFjYD03/cp5q/HmcMMO5VesQ+OfhoE7Lku/MsYNRHE9HpzyAJcmrG
	 X4dI59j/syNjw==
X-Pm-Submission-Id: 4gQzvG5StDz1DF6l
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
Date: Thu, 28 May 2026 11:20:10 +0300
Message-ID: <20260528082025.44414-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260528062810.256212-4-work@onurozkan.dev>
References: <20260528062810.256212-1-work@onurozkan.dev> <20260528062810.256212-4-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 May 2026 09:27:35 +0300=0D
Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
=0D
> Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_struct.=
=0D
> Provide FFI helpers and a safe wrapper with a guard-based API for read-si=
de=0D
> critical sections.=0D
> =0D
> Cleanup is handled via `PinnedDrop`, which explicitly drains pending grac=
e=0D
> periods and callbacks via `synchronize_srcu` and `srcu_barrier` before=0D
> executing `cleanup_srcu_struct` to guarantee memory safety e.g. when ther=
e=0D
> are leaked guards (via `mem::forget($guard)`).=0D
> =0D
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> ---=0D
>  rust/kernel/sync.rs      |   2 +=0D
>  rust/kernel/sync/srcu.rs | 166 +++++++++++++++++++++++++++++++++++++++=0D
>  2 files changed, 168 insertions(+)=0D
>  create mode 100644 rust/kernel/sync/srcu.rs=0D
> =0D
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs=0D
> index 993dbf2caa0e..0d6a5f1300c3 100644=0D
> --- a/rust/kernel/sync.rs=0D
> +++ b/rust/kernel/sync.rs=0D
> @@ -21,6 +21,7 @@=0D
>  pub mod rcu;=0D
>  mod refcount;=0D
>  mod set_once;=0D
> +pub mod srcu;=0D
>  =0D
>  pub use arc::{Arc, ArcBorrow, UniqueArc};=0D
>  pub use completion::Completion;=0D
> @@ -31,6 +32,7 @@=0D
>  pub use locked_by::LockedBy;=0D
>  pub use refcount::Refcount;=0D
>  pub use set_once::SetOnce;=0D
> +pub use srcu::Srcu;=0D
>  =0D
>  /// Represents a lockdep class.=0D
>  ///=0D
> diff --git a/rust/kernel/sync/srcu.rs b/rust/kernel/sync/srcu.rs=0D
> new file mode 100644=0D
> index 000000000000..343f00d070c7=0D
> --- /dev/null=0D
> +++ b/rust/kernel/sync/srcu.rs=0D
> @@ -0,0 +1,166 @@=0D
> +// SPDX-License-Identifier: GPL-2.0=0D
> +=0D
> +//! Sleepable read-copy update (SRCU) support.=0D
> +//!=0D
> +//! C header: [`include/linux/srcu.h`](srctree/include/linux/srcu.h)=0D
> +=0D
> +use crate::{=0D
> +    bindings,=0D
> +    error::to_result,=0D
> +    prelude::*,=0D
> +    sync::LockClassKey,=0D
> +    types::{=0D
> +        NotThreadSafe,=0D
> +        Opaque, //=0D
> +    },=0D
> +};=0D
> +=0D
> +use pin_init::pin_data;=0D
> +=0D
> +/// Creates an [`Srcu`] initialiser with the given name and a newly-crea=
ted lock class.=0D
> +#[doc(hidden)]=0D
> +#[macro_export]=0D
> +macro_rules! new_srcu {=0D
> +    ($($name:literal)?) =3D> {=0D
> +        $crate::sync::Srcu::new($crate::optional_name!($($name)?), $crat=
e::static_lock_class!())=0D
> +    };=0D
> +}=0D
> +pub use new_srcu;=0D
> +=0D
> +/// Sleepable read-copy update primitive.=0D
> +///=0D
> +/// SRCU readers may sleep while holding the read-side guard.=0D
> +///=0D
> +/// The destructor waits for active readers and callbacks, so it may sle=
ep.=0D
> +/// If a read-side guard has been leaked, dropping an [`Srcu`] may never=
 return.=0D
> +///=0D
> +/// # Invariants=0D
> +///=0D
> +/// This represents a valid `struct srcu_struct` initialized by the C SR=
CU API=0D
> +/// and it remains pinned and valid until the pinned destructor runs.=0D
> +#[repr(transparent)]=0D
> +#[pin_data(PinnedDrop)]=0D
> +pub struct Srcu {=0D
> +    #[pin]=0D
> +    inner: Opaque<bindings::srcu_struct>,=0D
> +}=0D
> +=0D
> +impl Srcu {=0D
> +    /// Creates a new SRCU instance.=0D
> +    #[inline]=0D
> +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> =
impl PinInit<Self, Error> {=0D
> +        try_pin_init!(Self {=0D
> +            // INVARIANT: On success, the C initializer creates a valid =
`srcu_struct` and=0D
> +            // it remains pinned until `PinnedDrop` runs.=0D
> +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu_stru=
ct| {=0D
> +                // SAFETY: `ptr` points to valid uninitialised memory fo=
r a `srcu_struct`.=0D
> +                to_result(unsafe {=0D
> +                    bindings::init_srcu_struct_with_key(ptr, name.as_cha=
r_ptr(), key.as_ptr())=0D
> +                })=0D
> +            }),=0D
> +        })=0D
> +    }=0D
> +=0D
> +    /// Enters an SRCU read-side critical section.=0D
> +    ///=0D
> +    /// Leaking the returned [`Guard`] leaves the SRCU read-side critica=
l=0D
> +    /// section active and makes `drop` sleep forever.=0D
> +    #[inline]=0D
> +    pub fn read_lock(&self) -> Guard<'_> {=0D
> +        // SAFETY: By the type invariants, `self` contains a valid `stru=
ct srcu_struct`.=0D
> +        let idx =3D unsafe { bindings::srcu_read_lock(self.inner.get()) =
};=0D
> +=0D
> +        // INVARIANT: `idx` was returned by `srcu_read_lock()` for this =
`Srcu`.=0D
> +        Guard {=0D
> +            srcu: self,=0D
> +            idx,=0D
> +            _not_send: NotThreadSafe,=0D
> +        }=0D
> +    }=0D
> +=0D
> +    /// Waits until all pre-existing SRCU readers have completed.=0D
> +    #[inline]=0D
> +    pub fn synchronize(&self) {=0D
> +        // SAFETY: By the type invariants, `self` contains a valid `stru=
ct srcu_struct`.=0D
> +        unsafe { bindings::synchronize_srcu(self.inner.get()) };=0D
> +    }=0D
> +=0D
> +    /// Waits until all pre-existing SRCU readers have completed, expedi=
ted.=0D
> +    ///=0D
> +    /// This requests a lower-latency grace period than [`Srcu::synchron=
ize`] typically=0D
> +    /// at the cost of higher system-wide overhead. Prefer [`Srcu::synch=
ronize`] by default=0D
> +    /// and use this variant only when reducing reset or teardown latenc=
y is more important=0D
> +    /// than the extra cost.=0D
> +    #[inline]=0D
> +    pub fn synchronize_expedited(&self) {=0D
> +        // SAFETY: By the type invariants, `self` contains a valid `stru=
ct srcu_struct`.=0D
> +        unsafe { bindings::synchronize_srcu_expedited(self.inner.get()) =
};=0D
> +    }=0D
> +}=0D
> +=0D
> +#[pinned_drop]=0D
> +impl PinnedDrop for Srcu {=0D
> +    fn drop(self: Pin<&mut Self>) {=0D
> +        let ptr =3D self.inner.get();=0D
> +=0D
> +        // SAFETY: By the type invariants, `self` contains a valid and p=
inned `struct srcu_struct`=0D
> +        // and `srcu_readers_active()` only checks the active reader cou=
nt.=0D
> +        if unsafe { bindings::srcu_readers_active(ptr) } {=0D
> +            crate::pr_warn!(=0D
> +                "Leaked `Guard` detected while dropping SRCU; drop will =
block forever.\n"=0D
> +            );=0D
> +        }=0D
> +=0D
> +        // `cleanup_srcu_struct()` may return early if readers are still=
 active. Because `Srcu`=0D
> +        // owns the embedded `srcu_struct`, returning from `drop` in tha=
t state could free memory=0D
> +        // that is still referenced by the C side.=0D
> +        //=0D
> +        // Wait for all readers to complete first. If any `Guard` was le=
aked, `synchronize_srcu()`=0D
> +        // will sleep forever.=0D
> +        //=0D
> +        // SAFETY: By the type invariants, `self` contains a valid and p=
inned `struct srcu_struct`.=0D
> +        unsafe { bindings::synchronize_srcu(ptr) };=0D
=0D
Sashiko got a good point here which is calling synchronize_srcu() only if t=
here=0D
are active readers. That's a nice low-effort improvement we can have in the=
 next=0D
version.=0D
=0D
Onur=0D
=0D
> +=0D
> +        // Ensure all SRCU callbacks have been finished before freeing.=
=0D
> +        // SAFETY: By the type invariants, `self` contains a valid and p=
inned `struct srcu_struct`.=0D
> +        unsafe { bindings::srcu_barrier(ptr) };=0D
> +=0D
> +        // SAFETY: By the type invariants, `self` contains a valid and p=
inned `struct srcu_struct`.=0D
> +        unsafe { bindings::cleanup_srcu_struct(ptr) };=0D
> +    }=0D
> +}=0D
> +=0D
> +// SAFETY: `srcu_struct` may be shared and used across threads.=0D
> +unsafe impl Send for Srcu {}=0D
> +// SAFETY: `srcu_struct` may be shared and used concurrently.=0D
> +unsafe impl Sync for Srcu {}=0D
> +=0D
> +/// Guard for an active SRCU read-side critical section on a particular =
[`Srcu`].=0D
> +///=0D
> +/// Leaking this guard with [`core::mem::forget`] leaves the SRCU read-s=
ide=0D
> +/// critical section active and makes dropping the associated [`Srcu`] s=
leep forever.=0D
> +///=0D
> +/// # Invariants=0D
> +///=0D
> +/// `idx` is the index returned by `srcu_read_lock()` for `srcu`.=0D
> +#[must_use =3D "if unused, the lock will be immediately unlocked"]=0D
> +pub struct Guard<'a> {=0D
> +    srcu: &'a Srcu,=0D
> +    idx: i32,=0D
> +    _not_send: NotThreadSafe,=0D
> +}=0D
> +=0D
> +impl Guard<'_> {=0D
> +    /// Explicitly releases the SRCU read-side critical section.=0D
> +    #[inline]=0D
> +    pub fn unlock(self) {}=0D
> +}=0D
> +=0D
> +impl Drop for Guard<'_> {=0D
> +    #[inline]=0D
> +    fn drop(&mut self) {=0D
> +        // SAFETY: `Guard` is only constructible through `Srcu::read_loc=
k()`,=0D
> +        // which returns a valid index for the SRCU instance.=0D
> +        unsafe { bindings::srcu_read_unlock(self.srcu.inner.get(), self.=
idx) };=0D
> +    }=0D
> +}=0D
> -- =0D
> 2.51.2=0D
> =0D
