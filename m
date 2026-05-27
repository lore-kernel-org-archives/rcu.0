Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A1B3C8C7C
	for <rcu@vger.kernel.org>; Wed, 27 May 2026 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867815; cv=none; b=tIgl4qo8dqXztvpJo4D+hj1U/0lwzn+Crr2802ZzhZpaNxkDNKz6OWzneO7xm4evPZsdRz1L9Bm9GeQ0Gg0PEYl1y0joq0gFeYItbWOJlI0rs9WPzuqzexIG+CaE2GkMj0HYgKratahogM6ZFyVNrdize+KF5xPm7K3yTdsEJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867815; c=relaxed/simple;
	bh=UaUmvOA1Tswj6Hbf7NCtA3aDN4C2M7GfHC7rCIGAOQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7m18UEqldBhh3P1IruFo7Fv74Xw7aX5ULJX2k4p3L7rChRt8kWMyIxSGMSjWULC3d/x95w5LEWK2LiKYsbZhnx4juJbNizBnTRluvbkkycg2aVBURM69Ee5L1t3gw3aOhx8yAOrGp31PW4CvWcCNo0Xje/p91rXMzp6wkpyGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ULGcfE5L; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ULGcfE5L"
Message-ID: <ec4f7b94-8c05-45d5-9208-7cdd824e7c33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779867802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lj29CAL2OcBsL8H88dHFOOE/gY78UMKTmSUd46LofxE=;
	b=ULGcfE5L8PVm6usyfmC4heu+oyN0wzoYe9hGGyp3fZUdlKsZYByrPJXlCXqERnUfYvrX4r
	hoQCBLziSO8ZVxD/vNeGtAKfR+9qTl1YfykT4K+INq2kGjnLapgDfi1zIQEBMnqYOVqfk9
	4tXvzm9fvFOlpyGSMOYuC3n6vBqqHnk=
Date: Wed, 27 May 2026 15:42:56 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] rust: rcu: Add abstraction for call_rcu()
To: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 "Joel Fernandes (NVIDIA)" <joel@joelfernandes.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Tamir Duberstein <tamird@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org
References: <20260520131725.266014-2-phasta@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <20260520131725.266014-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/20/26 21:17, Philipp Stanner wrote:
> call_rcu() can be expected to be needed by a great variety of users.
> This functionality is almost always used for deallocating resources
> after all accessors are gone. Hence, it appears reasonable to implement
> the abstractions in such a way that the user merely passes data, which
> is later (after a grace period) dropped.
>
> In the rare cases where the user needs special action to take place,
> this could be achieved through implementing a custom drop() method.
>
> Implement a first minimal abstraction for call_rcu().
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   rust/helpers/rcu.c      |  1 +
>   rust/kernel/sync.rs     |  1 +
>   rust/kernel/sync/rcu.rs | 89 ++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 90 insertions(+), 1 deletion(-)
>
> diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
> index 481274c05857..c9cfc99c93d5 100644
> --- a/rust/helpers/rcu.c
> +++ b/rust/helpers/rcu.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> +#include <linux/types.h> /* for callback_head */
>   #include <linux/rcupdate.h>
>   
>   __rust_helper void rust_helper_rcu_read_lock(void)
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 993dbf2caa0e..1ddca3847b19 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -31,6 +31,7 @@
>   pub use locked_by::LockedBy;
>   pub use refcount::Refcount;
>   pub use set_once::SetOnce;
> +pub use rcu::Callback;
>   
>   /// Represents a lockdep class.
>   ///
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index a32bef6e490b..caf71fa46f5e 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
> @@ -4,7 +4,15 @@
>   //!
>   //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
>   
> -use crate::{bindings, types::NotThreadSafe};
> +use crate::{
> +    bindings,
> +    prelude::*,
> +    types::{
> +        NotThreadSafe,
> +        Opaque,

Suggestion: Append `//` after the last item in each use braces to
prevent rustfmt from condensing lines, since `imports_layout =
"Vertical"` is not yet stable.

Best regards,
Alvin

> +    },
> +    alloc::Flags,
> +};
>   
>   /// Evidence that the RCU read side lock is held on the current thread/CPU.
>   ///
> @@ -50,3 +58,82 @@ fn drop(&mut self) {
>   pub fn read_lock() -> Guard {
>       Guard::new()
>   }
> +
> +
> +/// An RCU callback object. Carries the user's data to drop() it once a grace period ellapsed.
> +///
> +/// This object serves to implement C's `call_rcu()` method. Since it is almost
> +/// always used to free a resource once a grace period ellapsed, the only thing
> +/// this implementation does is drop the user's data. In the rare cases in which
> +/// the user needs more action to take place, said actions need to be implemented
> +/// on the user's data via the [`Drop`] trait.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::sync::rcu::Callback;
> +///
> +/// struct Foo {};
> +///
> +/// impl Drop for Foo {
> +///     fn drop(&mut self) {
> +///         pr_info!("rcu::Foo Dropping.\n");
> +///     }
> +/// }
> +///
> +/// let data = Foo {};
> +///
> +/// let cb = Callback::new(data, GFP_KERNEL)?;
> +/// cb.submit();
> +///
> +/// Ok::<(), Error>(())
> +/// ```
> +#[repr(C)]
> +#[pin_data]
> +pub struct Callback<T: Send + 'static> {
> +    /// The RCU head. Only used (and initialized) by the C backend.
> +    #[pin]
> +    inner: Opaque<bindings::callback_head>,
> +    /// The user's data. This should implement [`Drop`] if the user wants specific
> +    /// actions, besides mere deallocation, to happen.
> +    #[pin]
> +    data: T,
> +}
> +
> +impl<T: Send + 'static> Callback<T> {
> +    /// Create a new callback.
> +    pub fn new(data: impl PinInit<T>, flags: Flags) -> Result<Pin<KBox<Self>>> {
> +        let cb = try_pin_init!(Self {
> +            inner: Opaque::uninit(), // Only needed for the C backend, who will initialize it.
> +            data <- data,
> +        });
> +
> +        KBox::pin_init(cb, flags)
> +    }
> +
> +    extern "C" fn callback(rcu_head: *mut bindings::callback_head) {
> +        let cb_ptr = rcu_head as *mut Self;
> +
> +        // SAFETY: All [`Callback`] objects in this module are always created
> +        // as `Pin<KBox<Self>>`. `Pin` is a transparent container. The action
> +        // below merely serves re-creating the KBox so that it can drop properly.
> +        let _cb = unsafe { KBox::from_raw(cb_ptr) };
> +
> +        // Self::data drops, ensuring the desired cleanup operation.
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::callback_head {
> +        self.inner.get()
> +    }
> +
> +    /// Arm a [`Callback`]. One grace period after this function was called,
> +    /// the callback object will be dropped.
> +    pub fn submit(self: Pin<KBox<Self>>) {
> +        // SAFETY: The memory is not moved by this code or the C backend.
> +        let cb = unsafe { Pin::into_inner_unchecked(self) };
> +        let ptr = KBox::into_raw(cb);
> +        // SAFETY: `ptr` was just created validly above. `Self::callback` relies
> +        // on the RCU module / code never being unloaded.
> +        unsafe { bindings::call_rcu((*ptr).as_raw(), Some(Self::callback)) };
> +    }
> +}
