Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EAD2F8E9B;
	Thu, 21 May 2026 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348358; cv=none; b=YVvnuc8NaDw0VPZjYVrKs5h3AX+G0ojQU59BaYKiNGOZO+4uHpy95KFavjI7MmeIXpK8bB/IhoZtntLixdhUYifV/p13EhRgdiH/mP3DuMo+gaonEtbVFIKCT4NBcAhN3qho/HkgT0bTcDY+pnLWBDIDRcFfk5IA/H8WnVWquEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348358; c=relaxed/simple;
	bh=j8lGs5auFb7AottoQSAxZ+iRQCjvGIwwSBVTtrNT328=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qs7MqjKCb2d8Iuvkh+AOYISu6Otr/ckDxHJu+4ELRUHcDHUNtcT0XHP1wQJfuIWf/t8pr6EjdQH38JdEL5dMDkt+h+LMssjJWuGuoHNnSNPj7okmavm9qYnn0b4DnRCAIjLk1lR+DFok5l5FE7yPanGmNxlWrFIH29s8Ny3kzlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NJh7iX6w; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NJh7iX6w"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gLg1R08lsz9tpM;
	Thu, 21 May 2026 09:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779348347; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPlvNepTEun9/5I6DInIQeVTGtbXFxMQkOcba0ko3fQ=;
	b=NJh7iX6ws4uhKgXeqmaUoLJe7jqTwv2cdnkgv4iyDWoQ9VIFL5l2avWtOtTjQ9nT4MD6XH
	ct7oi0XChksjlgPL3oGlZKAFUFEKP42/AWASLIYFwKXxYmsKujBYzXkmLxzR2g+VfHIkty
	iS6dOq61jUhATJxqf/RXwQlfSdlhZ9kepiJlsCktwAVKhmyqFJs8/W3wh0pP8B8muw7WOl
	QdqdaPp6n7+on5AQTNfDwCO5f9gTIF6Y/hFU1QxxRavjkdOtBx9wDE8x3gZm+xhCBHI7Zc
	QJoRYEB5tOkF7ddn3tbKuO7QbtjNMJ5/YsdmKHrAvhuPDtFYUyeynrUil4wD+A==
Message-ID: <857ba45ce62f7f209a3a764aeb2cd27dc067870d.camel@mailbox.org>
Subject: Re: [PATCH v1] rust: rcu: Add abstraction for call_rcu()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Boqun Feng <boqun@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, "Joel Fernandes (NVIDIA)"
 <joel@joelfernandes.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
 Tamir Duberstein <tamird@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Boris Brezillon
 <boris.brezillon@collabora.com>
Date: Thu, 21 May 2026 09:25:28 +0200
In-Reply-To: <ag2-T9i2nFHjiYLm@tardis.local>
References: <20260520131725.266014-2-phasta@kernel.org>
	 <ag2-T9i2nFHjiYLm@tardis.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 5p947ir4z1b45umjo6bkrzyrw9r4y5bd
X-MBO-RS-ID: 5942784de5eba64404a

[+cc Boris]

On Wed, 2026-05-20 at 06:59 -0700, Boqun Feng wrote:
> Hi Philipp,

Hi Boqun; hope you're doing well

>=20
> On Wed, May 20, 2026 at 03:17:26PM +0200, Philipp Stanner wrote:
> > call_rcu() can be expected to be needed by a great variety of users.
> > This functionality is almost always used for deallocating resources
> > after all accessors are gone. Hence, it appears reasonable to implement
> > the abstractions in such a way that the user merely passes data, which
> > is later (after a grace period) dropped.
> >=20
> > In the rare cases where the user needs special action to take place,
> > this could be achieved through implementing a custom drop() method.
> >=20
> > Implement a first minimal abstraction for call_rcu().
> >=20
>=20
> Thanks for the patch! Do you have have any reference usage of this new
> API, maybe contains how RCU readers will read the data?

Read the data? This design does not intend to have any readers.

I want it as some sort of trash-bin container that does nothing but
defer a drop(). Intended user will be this section here:

https://gitlab.freedesktop.org/pstanner/linux-drm-work/-/merge_requests/1/d=
iffs#5ef8add7e1b3375ce9a0b47595b531244bf98dce_0_611


>=20
> Compared to Alice's RcuBox proposal:
>=20
> 	https://lore.kernel.org/rust-for-linux/20260116-rcu-box-v1-1-38ebfbcd53f=
0@google.com/
>=20
> I do have a design question: is support data type like Arc<CallBack<T>>
> or Pin<VBox<Callback<T>> in the plan of this API? If so, how would that
> be like? A separate new() and submit() function or a separate data type?

I wasn't aware of Alice's proposal. Let me try whether I can make it
work for my purposes.

The idea behind my code here would be to have some minimalist RCU
wrapper that merely defers dropping data. So it's a fire-and-forget
mechanism that would not support Arc: take over ownership of the data,
have it be unaccessible, and drop it after a grace period.

Reason is that call_rcu() is most commonly needed for delaying a free()
operation.

Alice's idea seems more generic.

But I agree that large allocations, aka VBox, should be supported.


P.

> If not, what's the main difference between Callback API and RcuBox?
>=20
> Regards,
> Boqun
>=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0rust/helpers/rcu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0rust/kernel/sync.rs=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0rust/kernel/sync/rcu.rs | 89 ++++++++++++++++++++++++++++++++++++=
++++-
> > =C2=A03 files changed, 90 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
> > index 481274c05857..c9cfc99c93d5 100644
> > --- a/rust/helpers/rcu.c
> > +++ b/rust/helpers/rcu.c
> > @@ -1,5 +1,6 @@
> > =C2=A0// SPDX-License-Identifier: GPL-2.0
> > =C2=A0
> > +#include <linux/types.h> /* for callback_head */
> > =C2=A0#include <linux/rcupdate.h>
> > =C2=A0
> > =C2=A0__rust_helper void rust_helper_rcu_read_lock(void)
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index 993dbf2caa0e..1ddca3847b19 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -31,6 +31,7 @@
> > =C2=A0pub use locked_by::LockedBy;
> > =C2=A0pub use refcount::Refcount;
> > =C2=A0pub use set_once::SetOnce;
> > +pub use rcu::Callback;
> > =C2=A0
> > =C2=A0/// Represents a lockdep class.
> > =C2=A0///
> > diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> > index a32bef6e490b..caf71fa46f5e 100644
> > --- a/rust/kernel/sync/rcu.rs
> > +++ b/rust/kernel/sync/rcu.rs
> > @@ -4,7 +4,15 @@
> > =C2=A0//!
> > =C2=A0//! C header: [`include/linux/rcupdate.h`](srctree/include/linux/=
rcupdate.h)
> > =C2=A0
> > -use crate::{bindings, types::NotThreadSafe};
> > +use crate::{
> > +=C2=A0=C2=A0=C2=A0 bindings,
> > +=C2=A0=C2=A0=C2=A0 prelude::*,
> > +=C2=A0=C2=A0=C2=A0 types::{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NotThreadSafe,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opaque,
> > +=C2=A0=C2=A0=C2=A0 },
> > +=C2=A0=C2=A0=C2=A0 alloc::Flags,
> > +};
> > =C2=A0
> > =C2=A0/// Evidence that the RCU read side lock is held on the current t=
hread/CPU.
> > =C2=A0///
> > @@ -50,3 +58,82 @@ fn drop(&mut self) {
> > =C2=A0pub fn read_lock() -> Guard {
> > =C2=A0=C2=A0=C2=A0=C2=A0 Guard::new()
> > =C2=A0}
> > +
> > +
> > +/// An RCU callback object. Carries the user's data to drop() it once =
a grace period ellapsed.
> > +///
> > +/// This object serves to implement C's `call_rcu()` method. Since it =
is almost
> > +/// always used to free a resource once a grace period ellapsed, the o=
nly thing
> > +/// this implementation does is drop the user's data. In the rare case=
s in which
> > +/// the user needs more action to take place, said actions need to be =
implemented
> > +/// on the user's data via the [`Drop`] trait.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// use kernel::sync::rcu::Callback;
> > +///
> > +/// struct Foo {};
> > +///
> > +/// impl Drop for Foo {
> > +///=C2=A0=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> > +///=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info!("rcu::Foo=
 Dropping.\n");
> > +///=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +/// }
> > +///
> > +/// let data =3D Foo {};
> > +///
> > +/// let cb =3D Callback::new(data, GFP_KERNEL)?;
> > +/// cb.submit();
> > +///
> > +/// Ok::<(), Error>(())
> > +/// ```
> > +#[repr(C)]
> > +#[pin_data]
> > +pub struct Callback<T: Send + 'static> {
> > +=C2=A0=C2=A0=C2=A0 /// The RCU head. Only used (and initialized) by th=
e C backend.
> > +=C2=A0=C2=A0=C2=A0 #[pin]
> > +=C2=A0=C2=A0=C2=A0 inner: Opaque<bindings::callback_head>,
> > +=C2=A0=C2=A0=C2=A0 /// The user's data. This should implement [`Drop`]=
 if the user wants specific
> > +=C2=A0=C2=A0=C2=A0 /// actions, besides mere deallocation, to happen.
> > +=C2=A0=C2=A0=C2=A0 #[pin]
> > +=C2=A0=C2=A0=C2=A0 data: T,
> > +}
> > +
> > +impl<T: Send + 'static> Callback<T> {
> > +=C2=A0=C2=A0=C2=A0 /// Create a new callback.
> > +=C2=A0=C2=A0=C2=A0 pub fn new(data: impl PinInit<T>, flags: Flags) -> =
Result<Pin<KBox<Self>>> {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let cb =3D try_pin_init!(Se=
lf {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inn=
er: Opaque::uninit(), // Only needed for the C backend, who will initialize=
 it.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dat=
a <- data,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 });
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KBox::pin_init(cb, flags)
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 extern "C" fn callback(rcu_head: *mut bindings::cal=
lback_head) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let cb_ptr =3D rcu_head as =
*mut Self;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: All [`Callback`]=
 objects in this module are always created
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // as `Pin<KBox<Self>>`. `P=
in` is a transparent container. The action
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // below merely serves re-c=
reating the KBox so that it can drop properly.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let _cb =3D unsafe { KBox::=
from_raw(cb_ptr) };
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Self::data drops, ensuri=
ng the desired cleanup operation.
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::callback_head {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.inner.get()
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 /// Arm a [`Callback`]. One grace period after this=
 function was called,
> > +=C2=A0=C2=A0=C2=A0 /// the callback object will be dropped.
> > +=C2=A0=C2=A0=C2=A0 pub fn submit(self: Pin<KBox<Self>>) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The memory is no=
t moved by this code or the C backend.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let cb =3D unsafe { Pin::in=
to_inner_unchecked(self) };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ptr =3D KBox::into_raw(=
cb);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `ptr` was just c=
reated validly above. `Self::callback` relies
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // on the RCU module / code=
 never being unloaded.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::call_rcu=
((*ptr).as_raw(), Some(Self::callback)) };
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > --=20
> > 2.49.0
> >=20

