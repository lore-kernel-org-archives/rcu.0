Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A53E2764;
	Wed, 20 May 2026 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285589; cv=none; b=J34h0bdBncfGhbqQ+82DnVqJR87WzpyIunKu6J0+vlv97q3c9TjZhr2RHYMOVe7TYMYTrianyJ/yGXsMVODAg6/5A64X9jx06kVvQaRxFb81qNz/8gZMEqUEJShpUcU6eV3pILsDjAGkrGpsT6F0z6stytCmWTY/SzGFPX7ZTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285589; c=relaxed/simple;
	bh=2pGSacfZAIqQprf1Lf6i8EJO5A34sYZYKccrsCtmGLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpqOgosIzL8Q2qVUJHecHPoDsOA53DqHL9WwoDei6t2YNWLgYvLp0lcdqridDY1Rjvn+rOMZfrjz66LVHBUtUu2V2ONdu/8cVuIM7Y+Yo+yEV/90POFu3Y/wVsndxUaFHiItSc0TE5PPWq6ySFx/FrbI+Pf+HkuhdRmgO5kW4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1UotxEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1UotxEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7DC1F000E9;
	Wed, 20 May 2026 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779285586;
	bh=+01xROXyws5N5mI8/Iz3HZAtwQAchJYV8+RRZQTxSNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n1UotxEoSLaRztUzY84QT4fE/79WysYzlXgD8VBLApRvVf8hZdmn44UPhsiffvt6Q
	 ZddisGYunR7cj9wxDscdXsr1qf5S54Bz4GpyE41sLOlTUrWFeR1gl24K6bIPiShjme
	 vx51n7Va2p4l0Ce3jSU6k9vvA6E+UNfNeJtiFYxzZcs7gQFYtrxrwdQie0oVnuY0fO
	 RdSHxTj9ZHJVq9yDDB3tMLYZVjK9MP0TlLWmjzlVnDpsdozq9FfwWd43o5bJoZN5an
	 r/ZzQ0USTaRP2NTCQpyNtc2BzO8HeFPyVtYHLsEhvY3LvEDdQOszlCpvMnlpzayaZq
	 ota61yaAW/NpQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2DD6EF40075;
	Wed, 20 May 2026 09:59:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 20 May 2026 09:59:45 -0400
X-ME-Sender: <xms:Ub4Nai4fL2kbtsjB4rF9kCXS3CqcK4R86MpkC66wjA4rhn0k6NLjBQ>
    <xme:Ub4Nak-Q6hrVRZrC-toNMdoR4O3nt9qpZlnrZ4PbOoAJMYE0wCcZGe6yzSjABAE5d
    EzDlWB7wsV8Gtq3zAD2oBn5BEVobRCz6GpP_9aiYJCgtk0Zo6WqpQ>
X-ME-Received: <xmr:Ub4NaqjIxsIGGsubjNpodJlNiMW6IivXGIQW8ld5MDunXbmpFxCF4n-HapzR9-qD7ky7Bcq73EQAGETxPKt2AKiwlFvJMJMP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhgrshhtrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhih
    sehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtoh
    hnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhs
    shesuhhmihgthhdrvgguuhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ub4Naq7erFK8gvLF93DX2pYwJyiEGzDFwC7XMfcKpplOY0VFD1SIQQ>
    <xmx:Ub4NavYq6wYhu_AFcGWqQPE5xpOuErW8lTb212t0sDONaUXzdWfXjw>
    <xmx:Ub4NavcFMxGAA_u2I46GS6Phn5KqyUeWwcS8eBngrQjhCBXQjIzyOw>
    <xmx:Ub4Nak5JURKfUsJQaOdTz_T2ETsI_Vi5oyS16kzrUcnF1EEYKLWLSg>
    <xmx:Ub4NajWQOl9jc4r4i0byq0h-L1EAA279Pe3BM1hCHtsAY4qCq_x1twRg>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 09:59:44 -0400 (EDT)
Date: Wed, 20 May 2026 06:59:43 -0700
From: Boqun Feng <boqun@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	"Joel Fernandes (NVIDIA)" <joel@joelfernandes.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Tamir Duberstein <tamird@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v1] rust: rcu: Add abstraction for call_rcu()
Message-ID: <ag2-T9i2nFHjiYLm@tardis.local>
References: <20260520131725.266014-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520131725.266014-2-phasta@kernel.org>

Hi Philipp,

On Wed, May 20, 2026 at 03:17:26PM +0200, Philipp Stanner wrote:
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

Thanks for the patch! Do you have have any reference usage of this new
API, maybe contains how RCU readers will read the data?

Compared to Alice's RcuBox proposal:

	https://lore.kernel.org/rust-for-linux/20260116-rcu-box-v1-1-38ebfbcd53f0@google.com/

I do have a design question: is support data type like Arc<CallBack<T>>
or Pin<VBox<Callback<T>> in the plan of this API? If so, how would that
be like? A separate new() and submit() function or a separate data type?
If not, what's the main difference between Callback API and RcuBox?

Regards,
Boqun

> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  rust/helpers/rcu.c      |  1 +
>  rust/kernel/sync.rs     |  1 +
>  rust/kernel/sync/rcu.rs | 89 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
> index 481274c05857..c9cfc99c93d5 100644
> --- a/rust/helpers/rcu.c
> +++ b/rust/helpers/rcu.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/types.h> /* for callback_head */
>  #include <linux/rcupdate.h>
>  
>  __rust_helper void rust_helper_rcu_read_lock(void)
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 993dbf2caa0e..1ddca3847b19 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -31,6 +31,7 @@
>  pub use locked_by::LockedBy;
>  pub use refcount::Refcount;
>  pub use set_once::SetOnce;
> +pub use rcu::Callback;
>  
>  /// Represents a lockdep class.
>  ///
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index a32bef6e490b..caf71fa46f5e 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
> @@ -4,7 +4,15 @@
>  //!
>  //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
>  
> -use crate::{bindings, types::NotThreadSafe};
> +use crate::{
> +    bindings,
> +    prelude::*,
> +    types::{
> +        NotThreadSafe,
> +        Opaque,
> +    },
> +    alloc::Flags,
> +};
>  
>  /// Evidence that the RCU read side lock is held on the current thread/CPU.
>  ///
> @@ -50,3 +58,82 @@ fn drop(&mut self) {
>  pub fn read_lock() -> Guard {
>      Guard::new()
>  }
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
> -- 
> 2.49.0
> 
