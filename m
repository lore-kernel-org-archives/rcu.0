Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B212366DA5
	for <rcu@vger.kernel.org>; Tue, 26 May 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809642; cv=none; b=FYkHpOV2hDa+VEOll21632aOxKjzAP8DrwcqG+d0Q2+K4HyqY4An1N9IhUK0wKHJ4pbwYPd0IkYYmkODZ4RFwUS8tiGXUoNQLItIK3qMiaLIuci2bVdqAhkCv/Og+GlLdCYlWFsK/6SGmVS5wUcvQObAKocgGZlUc39xPmAWJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809642; c=relaxed/simple;
	bh=3OwbdZI8P49AWki9+swobQnsczdDDE5RqN6qznYbFiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TukfCcdlJivRx4c2EPFK6WGr97RqCniAi3biJCeO/qeEBcwfjkt+vEphdNYasV84J0jl1Pf/IcBoiOiGT/5bR+nhdIWYHEJ8z2sMi2J4y20jpRBS9uwYCEsxb0/WHFH2G5XB54FpgJh6GXb7Sh9w3iPeXPf09KnvEMoCpaRVZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTD0TFOd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTD0TFOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7293D1F00A3D;
	Tue, 26 May 2026 15:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809641;
	bh=MMGwh1mU3kNcv0bSrjlbygHCOLn9YhIg6g9hkgaI/nE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nTD0TFOdfG9fBC6wDP1vQWbeTetaGUZC+8Cr965YC0r6pjU2kjOXL/VAOft8PPhK0
	 vKvRpQUKi/Elz5p0zuG7yFpVHymo7iTw1db4rReXGYdr0jh3OoYX3idp7XMX9n6wR4
	 L0JUkeR3xqRX633Mjqo65pHJxsepH92CY+C6bq6scAUwsAyGVdYyy6gzESGVd1l57I
	 KqwbCrOquV4yG+zkdJzcPRjFz/L3Ycgv0CXGoVa9U2yW/4uQRMSW0lLcCANoprO3nb
	 SGI6amV5Cw+PYgRLxY+uXAVKZciDK96vSiEhG2Hn0lk8+Kw0hvugKmxzcwGlxnhl8q
	 qKmQiu+d2vApA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id CBB74F40075;
	Tue, 26 May 2026 11:33:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 11:33:59 -0400
X-ME-Sender: <xms:Z70VapQEurZVZ-5wKkg-S90gmMVj0VPo_DVxI__mz3J7sLrogQxp7g>
    <xme:Z70Vap2BHD53rAn7pbfsrwSiINz3WdfhDK8MtSpHtPnaivoAmI580we3Jlj6_UEVG
    cdNqaPUb8VwCmRRyv1UkrMw2WXFrs4NKqfhp5k-GQjJX6TnML_E7Q>
X-ME-Received: <xmr:Z70VamhfHLtuKltGoam2weB85EiTAyuoZVL1oFVFeLu1l8HN3CimDk-kbdaFoeqJCevpoTJ7JXFtjoGGoLYr7ryOQWIPy3Oo>
X-ME-Proxy-Cause: dmFkZTGAQ2+ZzGLyqbB1NPXq6naYienZqvx+s9eL7+2K3LltTXdbni7KlpIgva2eO00E80
    wB4bP48l6b4tXrvHC1ap3sKoz29UMOk6iUktGJOuM9BUBUHEwlbk2OcYu9Fn31bRm+VKfo
    DO75WQaYQ+PONOl0uzN3Y4VH5YDGE6ehaMBBnDrzoI4RLmNd7PNd/eOqCHtuVlwtdD9sPE
    QdgxI3XeEDY2zvdAfyNDueSXyhhDwIw3dqFThnCAuwkRCM8bDanf158TDNanoNOJgqZzTW
    sYjbZhVrniJvW3qX+F+rjekmZXjKieL56A45gakVKufEBUvF4PXalR7vbiX6QBp4CcsYAm
    o30nxXxkMbAL38TFYN1a6OUY3CbJ/5bGegacFllE9WFCVGaBPGrwwMpzw6LEjY+e84ZSLC
    kwpUkplny780DxzXFQcX5GQcYOw42RJT3FUSDnBgj6GF+FqavQbVhBib3nu58nkB0md/dk
    /n4GK2iHYJwuUbz74Y66jRcC9K+bXLCWZrSxKC3OZpnoJbjIV+eLyOkuJSTWF7lf4nXXlT
    wfcwYbhb/8sxK0btcjx6FaM0ktq0+TS1rZzNjXsHx3e7BbMyXvjBg2w3Q+i6H31o2cvsrs
    S1RxspzJwSbBHSaNtiSgaCYdTh7D4B8JvHEXXzY4c36NG7fbZBQlrcm6xCtQ
X-ME-Proxy: <xmx:Z70VanbDuhZEeE_Gm5UUSaEH8wZSObmfy65K5w_lguxsR7U1_m35dQ>
    <xmx:Z70VavNKo3zc-Gne2FgpMJ9zqYY9Bf_1LJzRWIt2P1FKW5-0AchdCQ>
    <xmx:Z70VarTssjZQVFaoLakg2655bpk6N_TDpjPswJx988yisQ3KPe9Tkw>
    <xmx:Z70Vai6F9_MnYVZ0BzHDRnC8ZGYQbrkcfLXouQXr_gfJFKn2YDhb6Q>
    <xmx:Z70VamawLpfV-s2YwLaQ1gl1dUMkftK3RzCTAPlvlIuXPvkg7embRuJf>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:33:59 -0400 (EDT)
Date: Tue, 26 May 2026 08:33:58 -0700
From: Boqun Feng <boqun@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	peterz@infradead.org, fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 2/3] rust: sync: add SRCU abstraction
Message-ID: <ahW9ZhonPU2rliuH@tardis.local>
References: <20260525175706.124910-1-work@onurozkan.dev>
 <20260525175706.124910-3-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525175706.124910-3-work@onurozkan.dev>

On Mon, May 25, 2026 at 08:55:50PM +0300, Onur Özkan wrote:
> Add a Rust abstraction for sleepable RCU (SRCU), backed by C srcu_struct.
> Provide FFI helpers and a safe wrapper with a guard-based API for read-side
> critical sections.
> 
> Cleanup is handled via `PinnedDrop`, which explicitly drains pending grace
> periods and callbacks via `synchronize_srcu` and `srcu_barrier` before
> executing `cleanup_srcu_struct` to guarantee memory safety e.g. when there
> are leaked guards (via `mem::forget($guard)`).
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/helpers/srcu.c      |  10 +++
>  rust/kernel/sync.rs      |   2 +
>  rust/kernel/sync/srcu.rs | 158 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 170 insertions(+)
>  create mode 100644 rust/kernel/sync/srcu.rs
> 
> diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
> index e9f723d7f8c9..79dd24a104ef 100644
> --- a/rust/helpers/srcu.c
> +++ b/rust/helpers/srcu.c
> @@ -22,3 +22,13 @@ __rust_helper void rust_helper_srcu_read_unlock(struct srcu_struct *ssp, int idx
>  {
>  	srcu_read_unlock(ssp, idx);
>  }
> +
> +__rust_helper void rust_helper_srcu_barrier(struct srcu_struct *ssp)
> +{
> +	srcu_barrier(ssp);
> +}
> +
> +__rust_helper void rust_helper_synchronize_srcu_expedited(struct srcu_struct *ssp)
> +{
> +	synchronize_srcu_expedited(ssp);
> +}
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 993dbf2caa0e..0d6a5f1300c3 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -21,6 +21,7 @@
>  pub mod rcu;
>  mod refcount;
>  mod set_once;
> +pub mod srcu;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use completion::Completion;
> @@ -31,6 +32,7 @@
>  pub use locked_by::LockedBy;
>  pub use refcount::Refcount;
>  pub use set_once::SetOnce;
> +pub use srcu::Srcu;
>  
>  /// Represents a lockdep class.
>  ///
> diff --git a/rust/kernel/sync/srcu.rs b/rust/kernel/sync/srcu.rs
> new file mode 100644
> index 000000000000..655ecddd1320
> --- /dev/null
> +++ b/rust/kernel/sync/srcu.rs
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Sleepable read-copy update (SRCU) support.
> +//!
> +//! C header: [`include/linux/srcu.h`](srctree/include/linux/srcu.h)
> +
> +use crate::{
> +    bindings,
> +    error::to_result,
> +    prelude::*,
> +    sync::LockClassKey,
> +    types::{
> +        NotThreadSafe,
> +        Opaque, //
> +    },
> +};
> +
> +use pin_init::pin_data;
> +
> +/// Creates an [`Srcu`] initialiser with the given name and a newly-created lock class.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! new_srcu {
> +    ($($name:literal)?) => {
> +        $crate::sync::Srcu::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
> +    };
> +}
> +pub use new_srcu;
> +
> +/// Sleepable read-copy update primitive.
> +///
> +/// SRCU readers may sleep while holding the read-side guard.
> +///
> +/// The destructor waits for active readers and callbacks, so it may sleep.
> +/// If a read-side guard has been leaked, dropping an [`Srcu`] may never return.
> +///
> +/// # Invariants
> +///
> +/// This represents a valid `struct srcu_struct` initialized by the C SRCU API
> +/// and it remains pinned and valid until the pinned destructor runs.
> +#[repr(transparent)]
> +#[pin_data(PinnedDrop)]
> +pub struct Srcu {
> +    #[pin]
> +    inner: Opaque<bindings::srcu_struct>,
> +}
> +
> +impl Srcu {
> +    /// Creates a new SRCU instance.
> +    #[inline]
> +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            // INVARIANT: On success, the C initializer creates a valid `srcu_struct` and
> +            // it remains pinned until `PinnedDrop` runs.
> +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu_struct| {
> +                // SAFETY: `ptr` points to valid uninitialised memory for a `srcu_struct`.
> +                to_result(unsafe {
> +                    bindings::init_srcu_struct_with_key(ptr, name.as_char_ptr(), key.as_ptr())
> +                })
> +            }),
> +        })
> +    }
> +
> +    /// Enters an SRCU read-side critical section.
> +    ///
> +    /// Leaking the returned [`Guard`] leaves the SRCU read-side critical
> +    /// section active and makes `drop` sleep forever.
> +    #[inline]
> +    pub fn read_lock(&self) -> Guard<'_> {
> +        // SAFETY: By the type invariants, `self` contains a valid `struct srcu_struct`.
> +        let idx = unsafe { bindings::srcu_read_lock(self.inner.get()) };
> +
> +        // INVARIANT: `idx` was returned by `srcu_read_lock()` for this `Srcu`.
> +        Guard {
> +            srcu: self,
> +            idx,
> +            _not_send: NotThreadSafe,
> +        }
> +    }
> +
> +    /// Waits until all pre-existing SRCU readers have completed.
> +    #[inline]
> +    pub fn synchronize(&self) {
> +        // SAFETY: By the type invariants, `self` contains a valid `struct srcu_struct`.
> +        unsafe { bindings::synchronize_srcu(self.inner.get()) };
> +    }
> +
> +    /// Waits until all pre-existing SRCU readers have completed, expedited.
> +    ///
> +    /// This requests a lower-latency grace period than [`Srcu::synchronize`] typically
> +    /// at the cost of higher system-wide overhead. Prefer [`Srcu::synchronize`] by default
> +    /// and use this variant only when reducing reset or teardown latency is more important
> +    /// than the extra cost.
> +    #[inline]
> +    pub fn synchronize_expedited(&self) {
> +        // SAFETY: By the type invariants, `self` contains a valid `struct srcu_struct`.
> +        unsafe { bindings::synchronize_srcu_expedited(self.inner.get()) };
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for Srcu {
> +    fn drop(self: Pin<&mut Self>) {
> +        let ptr = self.inner.get();
> +
> +        // `cleanup_srcu_struct()` may return early if readers are still active. Because `Srcu`
> +        // owns the embedded `srcu_struct`, returning from `drop` in that state could free memory
> +        // that is still referenced by the C side.
> +        //
> +        // Wait for all readers to complete first. If any `Guard` was leaked, `synchronize_srcu()`
> +        // will sleep forever.
> +        //
> +        // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`.
> +        unsafe { bindings::synchronize_srcu(ptr) };

Sorry for being slow on this. But I think your approach is the right one
here. However, even though this makes Srcu safe, it's still undesired if
an Srcu::drop() blocks forever *silently*. I think we should call
srcu_active_readers() here and throw a warning if a leaked `Guard` is
detected.

The rest of the patch set looks good to me.

Regards,
Boqun

> +
> +        // Ensure all SRCU callbacks have been finished before freeing.
> +        // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`.
> +        unsafe { bindings::srcu_barrier(ptr) };
> +
> +        // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`.
> +        unsafe { bindings::cleanup_srcu_struct(ptr) };
> +    }
> +}
> +
> +// SAFETY: `srcu_struct` may be shared and used across threads.
> +unsafe impl Send for Srcu {}
> +// SAFETY: `srcu_struct` may be shared and used concurrently.
> +unsafe impl Sync for Srcu {}
> +
> +/// Guard for an active SRCU read-side critical section on a particular [`Srcu`].
> +///
> +/// Leaking this guard with [`core::mem::forget`] leaves the SRCU read-side
> +/// critical section active and makes dropping the associated [`Srcu`] sleep forever.
> +///
> +/// # Invariants
> +///
> +/// `idx` is the index returned by `srcu_read_lock()` for `srcu`.
> +#[must_use = "if unused, the lock will be immediately unlocked"]
> +pub struct Guard<'a> {
> +    srcu: &'a Srcu,
> +    idx: i32,
> +    _not_send: NotThreadSafe,
> +}
> +
> +impl Guard<'_> {
> +    /// Explicitly releases the SRCU read-side critical section.
> +    #[inline]
> +    pub fn unlock(self) {}
> +}
> +
> +impl Drop for Guard<'_> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: `Guard` is only constructible through `Srcu::read_lock()`,
> +        // which returns a valid index for the SRCU instance.
> +        unsafe { bindings::srcu_read_unlock(self.srcu.inner.get(), self.idx) };
> +    }
> +}
> -- 
> 2.51.2
> 
