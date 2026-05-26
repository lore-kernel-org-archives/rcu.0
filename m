Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509C3AEF3B;
	Tue, 26 May 2026 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811812; cv=none; b=EpwhuxT3QXBMfOM7Fil2jdYB1RYi2GQi+UDRIIs38cZB283yDtU3WNqA37CSmk8mPixh5YdX77icwIpcY1d9PgynlljtkG6UEVXJNrO0ZhlxVWcbxnZNbFj3xhfFfNh5juFVeM1W8gdpJv6KXG8Gcrzuc82s5MPloFVK8D2A6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811812; c=relaxed/simple;
	bh=M0Xyd3KlMjS35BSfV3e9NgAoCLfMlXrMMTaiwYzmB8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1zUzPyaOuxGZsxwPk5utFPZYAX1whY1hLuWc3/twlzaVqLmdLrhwLhWoeUBtxlyQZ8wjBEWKJpNxRBMyKdNmCJo0Th/SSQ6Y4W/9mhVMeMhizT9aRhgSqDYBUKMOA3XqoyVscptZHkydy0RZbhac5C+j50/vrbfUteEB/1Vo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjM8T/8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjM8T/8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261A31F000E9;
	Tue, 26 May 2026 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811811;
	bh=4+k6ndhTqZczxlv27FivWH0quTKkJFUBHwpZyGtkADI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DjM8T/8fa1+QglN+Cnlm5qyTrke+LL8L1Mx/ezhF3l8kzyEcPErrVk9FJSNQWT3az
	 mHrvps/u4JSkxumTP8mDBijXp6Salx2tuqWYqEf5wWATlcUsfAP6CvbIlc3s/BGQmm
	 D9qXZSEYQMdYEq0nGs/R9ycgKeOyl34n/vnm/YAl12l3hFQ1/be974s/Vby/lcrczb
	 8W1wST5G7gRnz8D1K5bs0sOCuIXbtFbpO9r7FVu7T3tuUO1RMnnH7lHgc4hnweQ+Mr
	 XqV1hawHxor/Sw215UQdpzYGCbWPaHKu7327zXuM28yIdeg56tH3X8eDGIaDodFnLL
	 zOVM1KSvH6N6w==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7AB45F4008C;
	Tue, 26 May 2026 12:10:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 26 May 2026 12:10:09 -0400
X-ME-Sender: <xms:4cUVakW2BfraWVeu16DAq3gWWCjZxiDLD5U0CNoEPuFwtsoBm95xxg>
    <xme:4cUVamDfpsaP4A8VxJcSs7AtRA1a2dlywAfWLJZyqMicC8jG14GdbrWoy-HLS-Y45
    OOtOrxbUDiPNSKUFZ2pYIC1QvrTvoka92SRX1l3GxjMyhko2H6V>
X-ME-Received: <xmr:4cUVaoUXjswKhhGYn55h_wpe8ZRtms3Xhjg5Li8AJCcctiR2fY9uSyx0X1ESAiwazxviTS6xIdG5iJSOHyetZmRd8Rsq6M1C>
X-ME-Proxy-Cause: dmFkZTGyiv9jH28GEGpBTU51eMSPvU5uQfMq01WyuvrQSzaZDz7Jz+4yRYak/3G5mudi7l
    PfVTIDBdscnYLK+bo0tOLBAVCyy51twaFisgUVpb6+uNKE9XbK8qqu6TmiFLq+dcSYZ9AG
    zkxr+oq825TnxGQ5ZvH9qtFf3TTsAa1yE29VWUVQGMl1Z+fkaAhj1T/j/VAfQC4r/k7yo8
    24mQWx+TiqSrvJ4SQWhY+vvG1jyfd7qKAFjwODNO8HFDxJex3DOVJFhh7oikBzN+2AImfI
    xanYKBpIuaiJMhlXIE7EVVWWH7wmkkO+U94eLJPvY6ZpALovGjXqgmgQPX4jowd2Zgksti
    6fN9IQfh+n5PeTAmcAnaXreKj56yofEySmO8rZz/9K0I/IoNl6YqST1tDsb7U1+KWayQCE
    3LRN93fgk7WhaifNPLnmicVFjeLjQiYrwOoE/FjsOvwGWjOK00S1M4WIRWfApM4Utv4IYj
    sn7rJLAwourgIkis7nmBvfhQ9PHb3ROQZMhdc8lzairGZAb7WlkCzBdtIDz/xitA1154Oi
    7mYMOXFql+JB+EbD1iASx/EztTq27fGOtgdXDSRiWzm/YvqfkMJT6vE30Z6o+TiTYsOQA3
    koCBDrn97OzNtg8N1+YoHb1J7/FL5+jaWoDcvdoZFlYa/q5ZmLrTQQlaS32Q
X-ME-Proxy: <xmx:4cUVak8agjC0moN7zzLFq3FaNhtRzMi-PfBuduhw-OgoVLC2Sp32bw>
    <xmx:4cUVaumFoHhaSUUlBrI35I6sdM7uxAIez8LQQaZ-RV30YwHSodukSw>
    <xmx:4cUVavKL0gZwFKgofaTYTFmBeoTHMS_yEq85SgrFLKnj0-QZu7G1oQ>
    <xmx:4cUVakprSjriceDAHL-YbBoaibbhMTlMLw8_7RPDwk6geH6Ew4MoEA>
    <xmx:4cUVasSJWwa0U-BmlLf5qlpOJM7EJnI8Gultahbi3UsIkvAhEI4Y02_A>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 12:10:08 -0400 (EDT)
Date: Tue, 26 May 2026 09:10:07 -0700
From: Boqun Feng <boqun@kernel.org>
To: phasta@kernel.org
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
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
	"Joel Fernandes (NVIDIA)" <joel@joelfernandes.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Tamir Duberstein <tamird@kernel.org>,	rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,	rcu@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v1] rust: rcu: Add abstraction for call_rcu()
Message-ID: <ahXF39fwE5helcj6@tardis.local>
References: <20260520131725.266014-2-phasta@kernel.org>
 <ag2-T9i2nFHjiYLm@tardis.local>
 <857ba45ce62f7f209a3a764aeb2cd27dc067870d.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <857ba45ce62f7f209a3a764aeb2cd27dc067870d.camel@mailbox.org>

On Thu, May 21, 2026 at 09:25:28AM +0200, Philipp Stanner wrote:
> [+cc Boris]
> 
> On Wed, 2026-05-20 at 06:59 -0700, Boqun Feng wrote:
> > Hi Philipp,
> 
> Hi Boqun; hope you're doing well
> 
> > 
> > On Wed, May 20, 2026 at 03:17:26PM +0200, Philipp Stanner wrote:
> > > call_rcu() can be expected to be needed by a great variety of users.
> > > This functionality is almost always used for deallocating resources
> > > after all accessors are gone. Hence, it appears reasonable to implement
> > > the abstractions in such a way that the user merely passes data, which
> > > is later (after a grace period) dropped.
> > > 
> > > In the rare cases where the user needs special action to take place,
> > > this could be achieved through implementing a custom drop() method.
> > > 
> > > Implement a first minimal abstraction for call_rcu().
> > > 
> > 
> > Thanks for the patch! Do you have have any reference usage of this new
> > API, maybe contains how RCU readers will read the data?
> 
> Read the data? This design does not intend to have any readers.
> 

Please understand that from the perspective of an RCU maintainer, I
would like to examine how the current design would work with a more
general case, otherwise it's going to be a maintenance nightmare.

> I want it as some sort of trash-bin container that does nothing but
> defer a drop(). Intended user will be this section here:
> 
> https://gitlab.freedesktop.org/pstanner/linux-drm-work/-/merge_requests/1/diffs#5ef8add7e1b3375ce9a0b47595b531244bf98dce_0_611
> 

The fact that you need a "defer" means that there are readers, right?

You don't need to worry about here because the readers are in the
callback of fences.

> 
> > 
> > Compared to Alice's RcuBox proposal:
> > 
> > 	https://lore.kernel.org/rust-for-linux/20260116-rcu-box-v1-1-38ebfbcd53f0@google.com/
> > 
> > I do have a design question: is support data type like Arc<CallBack<T>>
> > or Pin<VBox<Callback<T>> in the plan of this API? If so, how would that
> > be like? A separate new() and submit() function or a separate data type?
> 
> I wasn't aware of Alice's proposal. Let me try whether I can make it
> work for my purposes.
> 
> The idea behind my code here would be to have some minimalist RCU
> wrapper that merely defers dropping data. So it's a fire-and-forget
> mechanism that would not support Arc: take over ownership of the data,
> have it be unaccessible, and drop it after a grace period.
> 

Maybe then name this data structure `RcuDeferDropBox<T>` or something?
Because if the design goal is not to support a general RCU usage (with
readers), than it probably shouldn't take the rcu::Callback name.

Or maybe keep the `Callback<T>`, but only implement `new()` (with a
return type as `impl PinInit<Callback<T>>` and the rcu_head accessor of
it. Then based on it you can implement the `RcuDeferDropBox<T>`, in this
way, we could both support your usage and move towards a full-featured
RCU implementation. Thoughts?

Plus, I think Alice's patch here [1] would also benefit from having a
basic rcu::Callback (to replace `PollCondVarBoxInner`).

[1]: https://lore.kernel.org/rust-for-linux/20260523-upgrade-poll-v4-1-f5b4c747eac2@google.com/

Regards,
Boqun

> Reason is that call_rcu() is most commonly needed for delaying a free()
> operation.
> 
> Alice's idea seems more generic.
> 
> But I agree that large allocations, aka VBox, should be supported.
> 
> 
> P.
> 
> > If not, what's the main difference between Callback API and RcuBox?
> > 
> > Regards,
> > Boqun
> > 
> > > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > > ---
> > >  rust/helpers/rcu.c      |  1 +
> > >  rust/kernel/sync.rs     |  1 +
> > >  rust/kernel/sync/rcu.rs | 89 ++++++++++++++++++++++++++++++++++++++++-
> > >  3 files changed, 90 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
> > > index 481274c05857..c9cfc99c93d5 100644
> > > --- a/rust/helpers/rcu.c
> > > +++ b/rust/helpers/rcu.c
> > > @@ -1,5 +1,6 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  
> > > +#include <linux/types.h> /* for callback_head */
> > >  #include <linux/rcupdate.h>
> > >  
> > >  __rust_helper void rust_helper_rcu_read_lock(void)
> > > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > > index 993dbf2caa0e..1ddca3847b19 100644
> > > --- a/rust/kernel/sync.rs
> > > +++ b/rust/kernel/sync.rs
> > > @@ -31,6 +31,7 @@
> > >  pub use locked_by::LockedBy;
> > >  pub use refcount::Refcount;
> > >  pub use set_once::SetOnce;
> > > +pub use rcu::Callback;
> > >  
> > >  /// Represents a lockdep class.
> > >  ///
> > > diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> > > index a32bef6e490b..caf71fa46f5e 100644
> > > --- a/rust/kernel/sync/rcu.rs
> > > +++ b/rust/kernel/sync/rcu.rs
> > > @@ -4,7 +4,15 @@
> > >  //!
> > >  //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
> > >  
> > > -use crate::{bindings, types::NotThreadSafe};
> > > +use crate::{
> > > +    bindings,
> > > +    prelude::*,
> > > +    types::{
> > > +        NotThreadSafe,
> > > +        Opaque,
> > > +    },
> > > +    alloc::Flags,
> > > +};
> > >  
> > >  /// Evidence that the RCU read side lock is held on the current thread/CPU.
> > >  ///
> > > @@ -50,3 +58,82 @@ fn drop(&mut self) {
> > >  pub fn read_lock() -> Guard {
> > >      Guard::new()
> > >  }
> > > +
> > > +
> > > +/// An RCU callback object. Carries the user's data to drop() it once a grace period ellapsed.
> > > +///
> > > +/// This object serves to implement C's `call_rcu()` method. Since it is almost
> > > +/// always used to free a resource once a grace period ellapsed, the only thing
> > > +/// this implementation does is drop the user's data. In the rare cases in which
> > > +/// the user needs more action to take place, said actions need to be implemented
> > > +/// on the user's data via the [`Drop`] trait.
> > > +///
> > > +/// # Examples
> > > +///
> > > +/// ```
> > > +/// use kernel::sync::rcu::Callback;
> > > +///
> > > +/// struct Foo {};
> > > +///
> > > +/// impl Drop for Foo {
> > > +///     fn drop(&mut self) {
> > > +///         pr_info!("rcu::Foo Dropping.\n");
> > > +///     }
> > > +/// }
> > > +///
> > > +/// let data = Foo {};
> > > +///
> > > +/// let cb = Callback::new(data, GFP_KERNEL)?;
> > > +/// cb.submit();
> > > +///
> > > +/// Ok::<(), Error>(())
> > > +/// ```
> > > +#[repr(C)]
> > > +#[pin_data]
> > > +pub struct Callback<T: Send + 'static> {
> > > +    /// The RCU head. Only used (and initialized) by the C backend.
> > > +    #[pin]
> > > +    inner: Opaque<bindings::callback_head>,
> > > +    /// The user's data. This should implement [`Drop`] if the user wants specific
> > > +    /// actions, besides mere deallocation, to happen.
> > > +    #[pin]
> > > +    data: T,
> > > +}
> > > +
> > > +impl<T: Send + 'static> Callback<T> {
> > > +    /// Create a new callback.
> > > +    pub fn new(data: impl PinInit<T>, flags: Flags) -> Result<Pin<KBox<Self>>> {
> > > +        let cb = try_pin_init!(Self {
> > > +            inner: Opaque::uninit(), // Only needed for the C backend, who will initialize it.
> > > +            data <- data,
> > > +        });
> > > +
> > > +        KBox::pin_init(cb, flags)
> > > +    }
> > > +
> > > +    extern "C" fn callback(rcu_head: *mut bindings::callback_head) {
> > > +        let cb_ptr = rcu_head as *mut Self;
> > > +
> > > +        // SAFETY: All [`Callback`] objects in this module are always created
> > > +        // as `Pin<KBox<Self>>`. `Pin` is a transparent container. The action
> > > +        // below merely serves re-creating the KBox so that it can drop properly.
> > > +        let _cb = unsafe { KBox::from_raw(cb_ptr) };
> > > +
> > > +        // Self::data drops, ensuring the desired cleanup operation.
> > > +    }
> > > +
> > > +    fn as_raw(&self) -> *mut bindings::callback_head {
> > > +        self.inner.get()
> > > +    }
> > > +
> > > +    /// Arm a [`Callback`]. One grace period after this function was called,
> > > +    /// the callback object will be dropped.
> > > +    pub fn submit(self: Pin<KBox<Self>>) {
> > > +        // SAFETY: The memory is not moved by this code or the C backend.
> > > +        let cb = unsafe { Pin::into_inner_unchecked(self) };
> > > +        let ptr = KBox::into_raw(cb);
> > > +        // SAFETY: `ptr` was just created validly above. `Self::callback` relies
> > > +        // on the RCU module / code never being unloaded.
> > > +        unsafe { bindings::call_rcu((*ptr).as_raw(), Some(Self::callback)) };
> > > +    }
> > > +}
> > > -- 
> > > 2.49.0
> > > 
> 
> 
