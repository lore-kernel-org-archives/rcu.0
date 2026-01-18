Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B8274B5C
	for <rcu@vger.kernel.org>; Sun, 18 Jan 2026 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768724922; cv=none; b=AWIppoPOgtfrDqlunJ0XqOigXf7ZAM6pDQfKkawt65pVbhx5GmM9GveDqNoRKOJejnFOWoD6i9GYsGXqWFFUCxkIXGr7rgwHhaHaZtdo5e4Tn11cJ6G+L5XJaCykWzAfQ/LvREr0PnMqAZjC+N/PN2w9fhkNFDXnxkbhU4g7Hfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768724922; c=relaxed/simple;
	bh=p6vo0grsA0IdxXr5PCpxk2UhpoPLss9zx/mtb2+dCC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+RrKKwU2IB7u+GOLniiEMkziRK4LP0/AA5tzFp66RZNMRhsnDLMmWWM+ewEBCazsBTaQLu60z1N13Jj8+gSK5rlNUod9rlzXwOgo4/85vwXjKKSF8zatdhmvSFp1+jskuoRJ06pPjWVJikHmCBn0cnz+WLiiccp/nNGduAMcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFeH4wBO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFeH4wBO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso21730035e9.2
        for <rcu@vger.kernel.org>; Sun, 18 Jan 2026 00:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768724918; x=1769329718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pUlsxyTcRs1rItG8NGkJreAcIeCMhnXiVnqEAkHu1nw=;
        b=eFeH4wBOyHcXKpx/780I1lHwezr65fBEDJkb3hBImP2s81dRCDTEHEAqAmUCs8OqrH
         IQ9xrvh+557QBhfRLrkVOXM8Bhfma3qaHTG3naN+FXWBtOxyqGaRYTJD38xnYFJjRyWt
         BZyLBZVi0UC9IUTxuW5CB07uTUo5W1M+2vogzIhJOlOW5ugxx3jf0zfFjagLEVkrMQGA
         ve62itccMl8yrrOj91/d36Ovc276dFU8NZn7ufGFyUyjJZk+vS7d0rLupueVPSSMmQkW
         +BtWYWBc7Eh6nKaf2+9JQt0eAM8DjDEP8E9n5AIW4Hdx9vLMOsenFjY1XFDUCmDARiJk
         HU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768724918; x=1769329718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUlsxyTcRs1rItG8NGkJreAcIeCMhnXiVnqEAkHu1nw=;
        b=nLis33CmDtz7chftyq0o14PL4jPmtBtTivf9tEQjPM0DUdgrHmHwAvivO82J7z2nr0
         l9wITJm7zhDL3o2vgtGwM/xsMqbrIZzD5OL6e9+Xkw3vAABaJs+ZK6ta6H+viafEYp4F
         oYo35lTwYJNz+59YkLVOu2LCg+xhFFBkCVfE9iTwV2bQXUr+pTj/datJhsudFDO4aFuy
         HZQuk1blWd3U5zXEWSqE9setBjLTYlMbnh7T+Aaa83ZU3NZc8SZxnKFckF3b4cxpYPMg
         Y4REw+x4W0M1kXce7qWOFQACmGTnGXo9ybQQavxSiDiQPNooqDqeUagoOXrmYiE3vSmw
         vb7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDASIeRyVjDUMFrZ1msFDnx0gjrJlzXxVZC16COWFPlldleEn9LDTMIwFrqj5WB4HROLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsSMO33kHDd3IKhbcR7HHoLHDT6jq1wnz7igDK9wWZByFTVDjT
	rII/xUHX3jUmsi1j5ttvVW/b7YCoRJ8v1cQWQYN8Kq9Sty06XIaOH+p3
X-Gm-Gg: AY/fxX6OqLkSmntnIqMQlnj3b33tzNHYLx37eBOIn9XJS8/Rx7C7INC+7pUODI+6rqr
	BXxbIJvAXQCFBGB5r+aU2e5OcJZUFYDB+vIBeJI7Knbwxzx/yAMMotlffLZTjI9Mor9nK4ZdA5D
	FrkZnvrgIl2YjHXFg8y5SptaGthF3qJDKiweMj/bmuUbs8U4ixI87LqOh05bRzzFUa2+dVxB4Uu
	VpvpYfLxQhWDdIO79xjavpCjFpf0zDbKW0Gzs11dKYsR3WQ4MOqXyZG9v0Z+uruUcBEn/6oB6vm
	ivGehBTcG6x9TTZWltEIJ+AJ2fBlRinrgBqtpXvYP9JdZUu97kqy2lCU8NusoJ0N63Pjj71N/JU
	3JJX/hmk/uqHyPk8Op/Zjzj6pnvLJwDVIz8P0PpYasdoID32vh9MNuwhG2nHdWbiNJLiXmBU03a
	p5Tq/Spu/L/rHY6SPuInCwSBMO0W5GNGtcffCu68yrf0S4zGGfyMRPlsyZMwcQXvHpTPyZd0m8j
	PRPRt5I4DEWJ96IJ9jN1gNNmwuaZj/s/yGrB7GYcT8jKc0yIwqsqzLF
X-Received: by 2002:a05:600c:4ec7:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-4801e30a126mr82540695e9.5.1768724918023;
        Sun, 18 Jan 2026 00:28:38 -0800 (PST)
Received: from ?IPV6:2003:df:bf2d:e300:8193:226f:9765:711d? (p200300dfbf2de3008193226f9765711d.dip0.t-ipconnect.de. [2003:df:bf2d:e300:8193:226f:9765:711d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c197sm132430585e9.1.2026.01.18.00.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 00:28:37 -0800 (PST)
Message-ID: <56d1cc0e-df60-4e2b-bfa9-b29ec48a76b6@gmail.com>
Date: Sun, 18 Jan 2026 09:28:35 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] rust: sync: rcu: Add RCU protected pointer
To: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>
References: <20260117122243.24404-1-boqun.feng@gmail.com>
 <20260117122243.24404-6-boqun.feng@gmail.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20260117122243.24404-6-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.01.26 13:22, Boqun Feng wrote:
> RCU protected pointers are an atomic pointer that can be loaded and
> dereferenced by mulitple RCU readers, but only one updater/writer can
> change the value (following a read-copy-update pattern usually).
> 
> This is useful in the case where data is read-mostly. The rationale of
> this patch is to provide a proof of concept on how RCU should be exposed
> to the Rust world, and it also serves as an example for atomic usage.
> 
> Similar mechanisms like ArcSwap [1] are already widely used.
> 
> Provide a `Rcu<P>` type with an atomic pointer implementation. `P` has
> to be a `ForeignOwnable`, which means the ownership of a object can be
> represented by a pointer-size value.
> 
> `Rcu::dereference()` requires a RCU Guard, which means dereferencing is
> only valid under RCU read lock protection.
> 
> `Rcu::copy_update()` is the operation for updaters, it requries a
> `Pin<&mut Self>` for exclusive accesses, since RCU updaters are normally
> exclusive with each other.
> 
> A lot of RCU functionalities including asynchronously free (call_rcu()
> and kfree_rcu()) are still missing, and will be the future work.
> 
> Also, we still need language changes like field projection [2] to
> provide better ergonomic.
> 
> Acknowledgment: this work is based on a lot of productive discussions
> and hard work from others, these are the ones I can remember (sorry if I
> forgot your contribution):
> 
> * Wedson started the work on RCU field projection and Benno followed it
>   up and had been working on it as a more general language feature.
>   Also, Gary's field-projection repo [3] has been used as an example for
>   related discussions.
> 
> * During Kangrejos 2023 [4], Gary, Benno and Alice provided a lot of
>   feedbacks on the talk from Paul and me: "If you want to use RCU in
>   Rust for Linux kernel..."
> 
> * During a recent discussion among Benno, Paul and me, Benno suggested
>   using `Pin<&mut>` to guarantee the exclusive access on updater
>   operations.
> 
> Link: https://crates.io/crates/arc-swap [1]
> Link: https://rust-lang.zulipchat.com/#narrow/channel/213817-t-lang/topic/Field.20Projections/near/474648059 [2]
> Link: https://github.com/nbdd0121/field-projection [3]
> Link: https://kangrejos.com/2023 [4]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/rcu.rs | 326 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 325 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index a32bef6e490b..28bbccaa2e5e 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
> @@ -4,7 +4,23 @@
>  //!
>  //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
>  
> -use crate::{bindings, types::NotThreadSafe};
> +use crate::bindings;
> +use crate::{
> +    sync::atomic::{
> +        Atomic,
> +        Relaxed,
> +        Release, //
> +    },
> +    types::{
> +        ForeignOwnable,
> +        NotThreadSafe, //
> +    },
> +};
> +use core::{
> +    marker::PhantomData,
> +    pin::Pin,
> +    ptr::NonNull, //
> +};
>  
>  /// Evidence that the RCU read side lock is held on the current thread/CPU.
>  ///
> @@ -50,3 +66,311 @@ fn drop(&mut self) {
>  pub fn read_lock() -> Guard {
>      Guard::new()
>  }
> +
> +use crate::types::Opaque;
> +
> +/// A temporary `UnsafePinned` [1] that provides a way to opt-out typical alias rules for mutable
> +/// references.
> +///
> +/// # Invariants
> +///
> +/// `self.0` is always properly initialized.
> +///
> +/// [1]: https://doc.rust-lang.org/std/pin/struct.UnsafePinned.html
> +struct UnsafePinned<T>(Opaque<T>);
> +
> +impl<T> UnsafePinned<T> {
> +    const fn new(value: T) -> Self {
> +        // INVARIANTS: `value` is initialized.
> +        Self(Opaque::new(value))
> +    }
> +
> +    const fn get(&self) -> *mut T {
> +        self.0.get()
> +    }
> +}
> +
> +// SAFETY: `UnsafePinned` is safe to transfer between execution contexts as long as `T` is `Send`.
> +unsafe impl<T: Send> Send for UnsafePinned<T> {}
> +// SAFETY: `UnsafePinned` is safe to shared between execution contexts as long as `T` is `Sync`.
> +unsafe impl<T: Sync> Sync for UnsafePinned<T> {}
> +
> +/// An RCU protected pointer, the pointed object is protected by RCU.
> +///
> +/// # Invariants
> +///
> +/// Either the pointer is null, or it points to a return value of
> +/// [`ForeignOwnable::into_foreign()`] and the atomic variable exclusively owns the pointer.
> +pub struct Rcu<P: ForeignOwnable>(
> +    UnsafePinned<Atomic<*mut crate::ffi::c_void>>,
> +    PhantomData<P>,
> +);
> +
> +/// A pointer that has been unpublished, but hasn't waited for a grace period yet.
> +///
> +/// The pointed object may still have an existing RCU reader. Therefore a grace period is needed to
> +/// free the object.
> +///
> +/// # Invariants
> +///
> +/// The pointer has to be a return value of [`ForeignOwnable::into_foreign`] and [`Self`]
> +/// exclusively owns the pointer.
> +pub struct RcuOld<P: ForeignOwnable>(NonNull<crate::ffi::c_void>, PhantomData<P>);
> +
> +impl<P: ForeignOwnable> Drop for RcuOld<P> {
> +    fn drop(&mut self) {
> +        // SAFETY: As long as called in a sleepable context, which should be checked by klint,
> +        // `synchronize_rcu()` is safe to call.
> +        unsafe {
> +            bindings::synchronize_rcu();
> +        }
> +
> +        // SAFETY: `self.0` is a return value of `P::into_foreign()`, so it's safe to call
> +        // `from_foreign()` on it. Plus, the above `synchronize_rcu()` guarantees no existing
> +        // `ForeignOwnable::borrow()` anymore.
> +        let p: P = unsafe { P::from_foreign(self.0.as_ptr()) };
> +        drop(p);
> +    }
> +}
> +
> +impl<P: ForeignOwnable> Rcu<P> {
> +    /// Creates a new RCU pointer.
> +    pub fn new(p: P) -> Self {
> +        // INVARIANTS: The return value of `p.into_foreign()` is directly stored in the atomic
> +        // variable.
> +        Self(
> +            UnsafePinned::new(Atomic::new(p.into_foreign())),
> +            PhantomData,
> +        )
> +    }
> +
> +    fn as_atomic(&self) -> &Atomic<*mut crate::ffi::c_void> {
> +        // SAFETY: Per type invariants of `UnsafePinned`, `self.0.get()` points to an initialized
> +        // `&Atomic`.
> +        unsafe { &*self.0.get() }
> +    }
> +
> +    fn as_atomic_mut_pinned(self: Pin<&mut Self>) -> &Atomic<*mut crate::ffi::c_void> {
> +        self.into_ref().get_ref().as_atomic()
> +    }
> +
> +    /// Dereferences the protected object.
> +    ///
> +    /// Returns `Some(b)`, where `b` is a reference-like borrowed type, if the pointer is not null,
> +    /// otherwise returns `None`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// # use kernel::alloc::{flags, KBox};
> +    /// use kernel::sync::rcu::{self, Rcu};
> +    ///
> +    /// let x = Rcu::new(KBox::new(100i32, flags::GFP_KERNEL)?);
> +    ///
> +    /// let g = rcu::read_lock();
> +    /// // Read in under RCU read lock protection.
> +    /// let v = x.dereference(&g);
> +    ///
> +    /// assert_eq!(v, Some(&100i32));
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    ///
> +    /// Note the borrowed access can outlive the reference of the [`Rcu<P>`], this is because as
> +    /// long as the RCU read lock is held, the pointed object should remain valid.
> +    ///
> +    /// In the following case, the main thread is responsible for the ownership of `shared`, i.e. it
> +    /// will drop it eventually, and a work item can temporarily access the `shared` via `cloned`,
> +    /// but the use of the dereferenced object doesn't depend on `cloned`'s existence.
> +    ///
> +    /// ```rust
> +    /// # use kernel::alloc::{flags, KBox};
> +    /// # use kernel::workqueue::system;
> +    /// # use kernel::sync::{Arc, atomic::{Atomic, Acquire, Release}};
> +    /// use kernel::sync::rcu::{self, Rcu};
> +    ///
> +    /// struct Config {
> +    ///     a: i32,
> +    ///     b: i32,
> +    ///     c: i32,
> +    /// }
> +    ///
> +    /// let config = KBox::new(Config { a: 1, b: 2, c: 3 }, flags::GFP_KERNEL)?;
> +    ///
> +    /// let shared = Arc::new(Rcu::new(config), flags::GFP_KERNEL)?;
> +    /// let cloned = shared.clone();
> +    ///
> +    /// // Use atomic to simulate a special refcounting.
> +    /// static FLAG: Atomic<i32> = Atomic::new(0);
> +    ///
> +    /// system().try_spawn(flags::GFP_KERNEL, move || {
> +    ///     let g = rcu::read_lock();
> +    ///     let v = cloned.dereference(&g).unwrap();
> +    ///     drop(cloned); // release reference to `shared`.
> +    ///     FLAG.store(1, Release);
> +    ///
> +    ///     // but still need to access `v`.
> +    ///     assert_eq!(v.a, 1);
> +    ///     drop(g);
> +    /// });
> +    ///
> +    /// // Wait until `cloned` dropped.
> +    /// while FLAG.load(Acquire) == 0 {
> +    ///     // SAFETY: Sleep should be safe.
> +    ///     unsafe { kernel::bindings::schedule(); }
> +    /// }
> +    ///
> +    /// drop(shared);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn dereference<'rcu>(&self, _rcu_guard: &'rcu Guard) -> Option<P::Borrowed<'rcu>> {
> +        // Ordering: Address dependency pairs with the `store(Release)` in copy_update().
> +        let ptr = self.as_atomic().load(Relaxed);
> +
> +        if !ptr.is_null() {
> +            // SAFETY:


Would it be an option to take an early return here and with this drop
one indentation level of the larger `SAFETY` comment?

if ptr.is_null() {
   return None;
}

// SAFETY:
...
Some(unsafe { P::borrow(ptr) })

Same for `Drop for Rcu<P>` below.


> +            // - Since `ptr` is not null, so it has to be a return value of `P::into_foreign()`.
> +            // - The returned `Borrowed<'rcu>` cannot outlive the RCU Guar, this guarantees the

Guar -> Guard

> +            //   return value will only be used under RCU read lock, and the RCU read lock prevents
> +            //   the pass of a grace period that the drop of `RcuOld` or `Rcu` is waiting for,
> +            //   therefore no `from_foreign()` will be called for `ptr` as long as `Borrowed` exists.
> +            //
> +            //      CPU 0                                       CPU 1
> +            //      =====                                       =====
> +            //      { `x` is a reference to Rcu<Box<i32>> }
> +            //      let g = rcu::read_lock();
> +            //
> +            //      if let Some(b) = x.dereference(&g) {
> +            //      // drop(g); cannot be done, since `b` is still alive.
> +            //
> +            //                                              if let Some(old) = x.replace(...) {
> +            //                                                  // `x` is null now.
> +            //          println!("{}", b);
> +            //      }
> +            //                                                  drop(old):
> +            //                                                    synchronize_rcu();
> +            //      drop(g);
> +            //                                                    // a grace period passed.
> +            //                                                    // No `Borrowed` exists now.
> +            //                                                    from_foreign(...);
> +            //                                              }
> +            Some(unsafe { P::borrow(ptr) })
> +        } else {
> +            None
> +        }
> +    }
> +
> +    /// Read, copy and update the pointer with new value.
> +    ///
> +    /// Returns `None` if the pointer's old value is null, otherwise returns `Some(old)`, where old
> +    /// is a [`RcuOld`] which can be used to free the old object eventually.
> +    ///
> +    /// The `Pin<&mut Self>` is needed because this function needs the exclusive access to
> +    /// [`Rcu<P>`], otherwise two `copy_update()`s may get the same old object and double free.
> +    /// Using `Pin<&mut Self>` provides the exclusive access that C side requires with the type
> +    /// system checking.
> +    ///
> +    /// Also this has to be `Pin` because a `&mut Self` may allow users to `swap()` safely, that
> +    /// will break the atomicity. A [`Rcu<P>`] should be structurally pinned in the struct that
> +    /// contains it.
> +    ///
> +    /// Note that `Pin<&mut Self>` cannot assume noalias on `self.0` here because of `self.0` is an
> +    /// [`UnsafePinned`].
> +    ///
> +    /// [`UnsafePinned`]: https://doc.rust-lang.org/std/pin/struct.UnsafePinned.html
> +    pub fn copy_update<F>(self: Pin<&mut Self>, f: F) -> Option<RcuOld<P>>
> +    where
> +        F: FnOnce(Option<P::Borrowed<'_>>) -> Option<P>,
> +    {
> +        let inner = self.as_atomic_mut_pinned();
> +
> +        // step 1: COPY, or more generally, initializing `new` based on `old`.
> +        // Ordering: Address dependency pairs with the `store(Release)` in copy_update().
> +        let old_ptr = NonNull::new(inner.load(Relaxed));
> +
> +        let old = old_ptr.map(|nonnull| {
> +            // SAFETY: Per type invariants `old_ptr` has to be a value return by a previous
> +            // `into_foreign()`, and the exclusive reference `self` guarantees that `from_foreign()`
> +            // has not been called.
> +            unsafe { P::borrow(nonnull.as_ptr()) }
> +        });
> +
> +        let new = f(old);
> +
> +        // step 2: UPDATE.
> +        if let Some(new) = new {
> +            let new_ptr = new.into_foreign();
> +            // Ordering: Pairs with the address dependency in `dereference()` and
> +            // `copy_update()`.
> +            // INVARIANTS: `new.into_foreign()` is directly store into the atomic variable.
> +            inner.store(new_ptr, Release);
> +        } else {
> +            // Ordering: Setting to a null pointer doesn't need to be Release.
> +            // INVARIANTS: The atomic variable is set to be null.
> +            inner.store(core::ptr::null_mut(), Relaxed);
> +        }
> +
> +        // INVARIANTS: The exclusive reference guarantess that the ownership of a previous
> +        // `into_foreign()` transferred to the `RcuOld`.
> +        Some(RcuOld(old_ptr?, PhantomData))
> +    }
> +
> +    /// Replaces the pointer with new value.
> +    ///
> +    /// Returns `None` if the pointer's old value is null, otherwise returns `Some(old)`, where old
> +    /// is a [`RcuOld`] which can be used to free the old object eventually.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use core::pin::pin;
> +    /// # use kernel::alloc::{flags, KBox};
> +    /// use kernel::sync::rcu::{self, Rcu};
> +    ///
> +    /// let mut x = pin!(Rcu::new(KBox::new(100i32, flags::GFP_KERNEL)?));
> +    /// let q = KBox::new(101i32, flags::GFP_KERNEL)?;
> +    ///
> +    /// // Read in under RCU read lock protection.
> +    /// let g = rcu::read_lock();
> +    /// let v = x.dereference(&g);
> +    ///
> +    /// // Replace with a new object.
> +    /// let old = x.as_mut().replace(q);
> +    ///
> +    /// assert!(old.is_some());
> +    ///
> +    /// // `v` should still read the old value.
> +    /// assert_eq!(v, Some(&100i32));
> +    ///
> +    /// // New readers should get the new value.
> +    /// assert_eq!(x.dereference(&g), Some(&101i32));
> +    ///
> +    /// drop(g);
> +    ///
> +    /// // Can free the object outside the read-side critical section.
> +    /// drop(old);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn replace(self: Pin<&mut Self>, new: P) -> Option<RcuOld<P>> {
> +        self.copy_update(|_| Some(new))
> +    }
> +}
> +
> +impl<P: ForeignOwnable> Drop for Rcu<P> {
> +    fn drop(&mut self) {
> +        let ptr = self.as_atomic().load(Relaxed);
> +        if !ptr.is_null() {
> +            // SAFETY: As long as called in a sleepable context, which should be checked by klint,
> +            // `synchronize_rcu()` is safe to call.
> +            unsafe {
> +                bindings::synchronize_rcu();
> +            }
> +
> +            // SAFETY: `self.0` is a return value of `P::into_foreign()`, so it's safe to call
> +            // `from_foreign()` on it. Plus, the above `synchronize_rcu()` guarantees no existing
> +            // `ForeignOwnable::borrow()` anymore.
> +            drop(unsafe { P::from_foreign(ptr) });
> +        }
> +    }
> +}


Best regards

Dirk
