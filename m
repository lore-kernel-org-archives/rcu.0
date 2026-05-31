Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0C34AB03;
	Sun, 31 May 2026 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780250776; cv=none; b=JqBhuEgAeGTBlojGh3sBrugoEH64r1F0zfI+nQMPgVedXZD63JwDDRU/lNfxhY7on0n6ND8NHZpsaJRkFSp2FM1lhpLOYIzj85+143IauddmKLgm9xdfzXJ7pAWirUFpAtU0dkudPtibl4cvcsZgIGv9YO6hzIoooWqXntklv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780250776; c=relaxed/simple;
	bh=UiGCAIOBhK1J1FdcO4NDqBjMWCYnC4VCw6i+K8bT+EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHFmCigyCdEgQBSxWLQygzLJVyOEDE/cMTrifCacJnnzr1ScnsZ9s+2nnrWD9G8r+mj7HtcmC1d8+0doIhzIkxjDFCRH9OaJTYfQw40WloJiTicyFQUdKSjzI+RAvV6y0N0gG29UemPgy2IKY2mLF+Kdjzip5IK3a4PpHDwq1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwCEnwf0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwCEnwf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401C51F00893;
	Sun, 31 May 2026 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780250774;
	bh=fyU3R3L64OKDO30dO6nTtLiFskTjhbQ7p+HA7/xAxLM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=PwCEnwf0pQZZhPLp7OIHZZYQa5FSVn/1SjXeGeypplZ1Vb/8gYIrRzNdX/RDdGEts
	 BPl9QHsCm1cvDnp97HfFuvaqfdjLMyNEFv4o3YZMt7ZDW59XWxcpueY+UIxpYpURwX
	 amtD4G2vHirt/LFmEpb6yVlQF8PsVmTF4a51mO3FbVm8xzekkRq96V+9ZCxgaPoVjZ
	 nlhvFEx+UEPU32XT7WMgCyzAdeJacmBCaxTgy5pNe4iXbDVRF6eIwPBEFB+UocSY+c
	 43CdPZYi8Hm0S/s4ruCPy7Bsuyu/kHmFujamsTwhiNr1XKq72F8PTpetjNu7M7hTRb
	 9dwKYQLnNCBfA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1657ECE04B5; Sun, 31 May 2026 11:06:14 -0700 (PDT)
Date: Sun, 31 May 2026 11:06:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org,
	fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
Message-ID: <3ef86db1-edc4-4e50-8614-2dd7270540b4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260528062810.256212-1-work@onurozkan.dev>
 <20260528062810.256212-4-work@onurozkan.dev>
 <20260528082025.44414-1-work@onurozkan.dev>
 <20260528083518.66203-1-work@onurozkan.dev>
 <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net>
 <b4f6d3e8-3a08-409e-89ae-ba5d612bae30@paulmck-laptop>
 <20260530062730.38077-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260530062730.38077-1-work@onurozkan.dev>

On Sat, May 30, 2026 at 09:27:29AM +0300, Onur Özkan wrote:
> On Fri, 29 May 2026 08:36:16 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Thu, May 28, 2026 at 01:23:39PM +0100, Gary Guo wrote:
> > > On Thu May 28, 2026 at 9:35 AM BST, Onur Özkan wrote:
> > > > On Thu, 28 May 2026 11:20:10 +0300
> > > > Onur Özkan <work@onurozkan.dev> wrote:
> > > >
> > > >> On Thu, 28 May 2026 09:27:35 +0300
> > > >> Onur Özkan <work@onurozkan.dev> wrote:
> > > >> 
> > > >> > Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_struct.
> > > >> > Provide FFI helpers and a safe wrapper with a guard-based API for read-side
> > > >> > critical sections.
> > > >> > 
> > > >> > Cleanup is handled via `PinnedDrop`, which explicitly drains pending grace
> > > >> > periods and callbacks via `synchronize_srcu` and `srcu_barrier` before
> > > >> > executing `cleanup_srcu_struct` to guarantee memory safety e.g. when there
> > > >> > are leaked guards (via `mem::forget($guard)`).
> > > >> > 
> > > >> > Signed-off-by: Onur Özkan <work@onurozkan.dev>
> > > >> > ---
> > > >> >  rust/kernel/sync.rs      |   2 +
> > > >> >  rust/kernel/sync/srcu.rs | 166 +++++++++++++++++++++++++++++++++++++++
> > > >> >  2 files changed, 168 insertions(+)
> > > >> >  create mode 100644 rust/kernel/sync/srcu.rs
> > > >> > 
> > > >> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > > >> > index 993dbf2caa0e..0d6a5f1300c3 100644
> > > >> > --- a/rust/kernel/sync.rs
> > > >> > +++ b/rust/kernel/sync.rs
> > > >> > @@ -21,6 +21,7 @@
> > > >> >  pub mod rcu;
> > > >> >  mod refcount;
> > > >> >  mod set_once;
> > > >> > +pub mod srcu;
> > > >> >  
> > > >> >  pub use arc::{Arc, ArcBorrow, UniqueArc};
> > > >> >  pub use completion::Completion;
> > > >> > @@ -31,6 +32,7 @@
> > > >> >  pub use locked_by::LockedBy;
> > > >> >  pub use refcount::Refcount;
> > > >> >  pub use set_once::SetOnce;
> > > >> > +pub use srcu::Srcu;
> > > >> >  
> > > >> >  /// Represents a lockdep class.
> > > >> >  ///
> > > >> > diff --git a/rust/kernel/sync/srcu.rs b/rust/kernel/sync/srcu.rs
> > > >> > new file mode 100644
> > > >> > index 000000000000..343f00d070c7
> > > >> > --- /dev/null
> > > >> > +++ b/rust/kernel/sync/srcu.rs
> > > >> > @@ -0,0 +1,166 @@
> > > >> > +// SPDX-License-Identifier: GPL-2.0
> > > >> > +
> > > >> > +//! Sleepable read-copy update (SRCU) support.
> > > >> > +//!
> > > >> > +//! C header: [`include/linux/srcu.h`](srctree/include/linux/srcu.h)
> > > >> > +
> > > >> > +use crate::{
> > > >> > +    bindings,
> > > >> > +    error::to_result,
> > > >> > +    prelude::*,
> > > >> > +    sync::LockClassKey,
> > > >> > +    types::{
> > > >> > +        NotThreadSafe,
> > > >> > +        Opaque, //
> > > >> > +    },
> > > >> > +};
> > > >> > +
> > > >> > +use pin_init::pin_data;
> > > >> > +
> > > >> > +/// Creates an [`Srcu`] initialiser with the given name and a newly-created lock class.
> > > >> > +#[doc(hidden)]
> > > >> > +#[macro_export]
> > > >> > +macro_rules! new_srcu {
> > > >> > +    ($($name:literal)?) => {
> > > >> > +        $crate::sync::Srcu::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
> > > >> > +    };
> > > >> > +}
> > > >> > +pub use new_srcu;
> > > >> > +
> > > >> > +/// Sleepable read-copy update primitive.
> > > >> > +///
> > > >> > +/// SRCU readers may sleep while holding the read-side guard.
> > > >> > +///
> > > >> > +/// The destructor waits for active readers and callbacks, so it may sleep.
> > > >> > +/// If a read-side guard has been leaked, dropping an [`Srcu`] may never return.
> > > >> > +///
> > > >> > +/// # Invariants
> > > >> > +///
> > > >> > +/// This represents a valid `struct srcu_struct` initialized by the C SRCU API
> > > >> > +/// and it remains pinned and valid until the pinned destructor runs.
> > > >> > +#[repr(transparent)]
> > > >> > +#[pin_data(PinnedDrop)]
> > > >> > +pub struct Srcu {
> > > >> > +    #[pin]
> > > >> > +    inner: Opaque<bindings::srcu_struct>,
> > > >> > +}
> > > >> > +
> > > >> > +impl Srcu {
> > > >> > +    /// Creates a new SRCU instance.
> > > >> > +    #[inline]
> > > >> > +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self, Error> {
> > > >> > +        try_pin_init!(Self {
> > > >> > +            // INVARIANT: On success, the C initializer creates a valid `srcu_struct` and
> > > >> > +            // it remains pinned until `PinnedDrop` runs.
> > > >> > +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu_struct| {
> > > >> > +                // SAFETY: `ptr` points to valid uninitialised memory for a `srcu_struct`.
> > > >> > +                to_result(unsafe {
> > > >> > +                    bindings::init_srcu_struct_with_key(ptr, name.as_char_ptr(), key.as_ptr())
> > > >> > +                })
> > > >> > +            }),
> > > >> > +        })
> > > >> > +    }
> > > >> > +
> > > >> > +    /// Enters an SRCU read-side critical section.
> > > >> > +    ///
> > > >> > +    /// Leaking the returned [`Guard`] leaves the SRCU read-side critical
> > > >> > +    /// section active and makes `drop` sleep forever.
> > > >> > +    #[inline]
> > > >> > +    pub fn read_lock(&self) -> Guard<'_> {
> > > >> > +        // SAFETY: By the type invariants, `self` contains a valid `struct srcu_struct`.
> > > >> > +        let idx = unsafe { bindings::srcu_read_lock(self.inner.get()) };
> > > >> > +
> > > >> > +        // INVARIANT: `idx` was returned by `srcu_read_lock()` for this `Srcu`.
> > > >> > +        Guard {
> > > >> > +            srcu: self,
> > > >> > +            idx,
> > > >> > +            _not_send: NotThreadSafe,
> > > >> > +        }
> > > >> > +    }
> > > >> > +
> > > >> > +    /// Waits until all pre-existing SRCU readers have completed.
> > > >> > +    #[inline]
> > > >> > +    pub fn synchronize(&self) {
> > > >> > +        // SAFETY: By the type invariants, `self` contains a valid `struct srcu_struct`.
> > > >> > +        unsafe { bindings::synchronize_srcu(self.inner.get()) };
> > > >> > +    }
> > > >> > +
> > > >> > +    /// Waits until all pre-existing SRCU readers have completed, expedited.
> > > >> > +    ///
> > > >> > +    /// This requests a lower-latency grace period than [`Srcu::synchronize`] typically
> > > >> > +    /// at the cost of higher system-wide overhead. Prefer [`Srcu::synchronize`] by default
> > > >> > +    /// and use this variant only when reducing reset or teardown latency is more important
> > > >> > +    /// than the extra cost.
> > > >> > +    #[inline]
> > > >> > +    pub fn synchronize_expedited(&self) {
> > > >> > +        // SAFETY: By the type invariants, `self` contains a valid `struct srcu_struct`.
> > > >> > +        unsafe { bindings::synchronize_srcu_expedited(self.inner.get()) };
> > > >> > +    }
> > > >> > +}
> > > >> > +
> > > >> > +#[pinned_drop]
> > > >> > +impl PinnedDrop for Srcu {
> > > >> > +    fn drop(self: Pin<&mut Self>) {
> > > >> > +        let ptr = self.inner.get();
> > > >> > +
> > > >> > +        // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`
> > > >> > +        // and `srcu_readers_active()` only checks the active reader count.
> > > >> > +        if unsafe { bindings::srcu_readers_active(ptr) } {
> > > >> > +            crate::pr_warn!(
> > > >> > +                "Leaked `Guard` detected while dropping SRCU; drop will block forever.\n"
> > > >> > +            );
> > > 
> > > I think this could be a `warn_on` similar to how cleanup_srcu_struct handle the
> > > condition.
> > > 
> > > >> > +        }
> > > >> > +
> > > >> > +        // `cleanup_srcu_struct()` may return early if readers are still active. Because `Srcu`
> > > >> > +        // owns the embedded `srcu_struct`, returning from `drop` in that state could free memory
> > > >> > +        // that is still referenced by the C side.
> > > >> > +        //
> > > >> > +        // Wait for all readers to complete first. If any `Guard` was leaked, `synchronize_srcu()`
> > > >> > +        // will sleep forever.
> > > >> > +        //
> > > >> > +        // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`.
> > > >> > +        unsafe { bindings::synchronize_srcu(ptr) };
> > > >> 
> > > >> Sashiko got a good point here which is calling synchronize_srcu() only if there
> > > >> are active readers. That's a nice low-effort improvement we can have in the next
> > > >> version.
> > > >> 
> > > >> Onur
> > > >
> > > > Actually, now I am now thinking about whether we can come up with a better
> > > > approach when we detect leaked guards. Initially I came up with the
> > > > synchronize_srcu() solution because it would handle leaked guards automatically
> > > > without requiring any additional checks. But now that we can actually detect
> > > > whether guards are leaked the question becomes:
> > > >
> > > > 	"Is there a better option than effectively sleeping forever when leaked
> > > > 	 guards are detected?"
> > > >
> > > > I have no plans for tomorrow other than finalizing this series including the
> > > > question above.
> > > 
> > > The best solution is to proceed cleanups anyway, given Rust rules ensure that
> > > these are actual leaks and not just srcu read-side critical section that failed
> > > to synchronize with the destruction of SRCU.
> > > 
> > > This obviously require changes to the SRCU code though.
> > 
> > Right now, the C-language SRCU code would splat and leak the srcu_struct
> > structure.  Of course, we *could* provide something that zeroed the
> > reader counts to avoid the splat and leak, but yikes!  Or is there a
> > way to make such a function available *only* to the Rust code associated
> > with cleanup_srcu_struct(), and not to other C/Rust code?
> 
> Anyone can use them if they want from `bindings::` once it's exposed to Rust.

Is there a Rust-language counterpart to checkpatch.pl that could warn
when it sees patches adding calls to this function?

							Thanx, Paul

> Regards,
> Onur
> 
> > 							Thanx, Paul
> 
