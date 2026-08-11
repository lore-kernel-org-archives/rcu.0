Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1144229D9;
	Tue, 11 Aug 2026 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441624; cv=none; b=fJTHitweQ3jI+NXC+CfIQ5Qn+4Wjw9Kt0jrrpHsv8s0Gcyg4F6hCHOU9tb2VKdSXQIWYUxyojhDBEPuhuxZmQLkcKDwiicICUyD80Za56xF1UflTNCtljhv8DqIvAH61dMZxUNHL08EB+bapQymz/OFWnK1h7IQQunSg5MqMzfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441624; c=relaxed/simple;
	bh=SMTYumGGj/OlPrilnAWOxWy4+DP0GwV+EuPjKPGpFWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UEKeBcqWr5Au2Km0wSPJklozq3ZA6+L07L61u9PwX63T9DeQ0Ny6eMUNBnBpg0CR4EsFk+IVmjkPmufuC7WL/Ap3tE04oApLOynsYC7fTnz6lY0XUDOcarIkh0cFUbwsTUILuQrYVTkMSarR3TbNc/tQk8sGcj35RPHX5Vzsaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BCR9Oqdt; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BCR9Oqdt"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hK6GP0vQxzKvtK;
	Tue, 11 Aug 2026 11:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786441613; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMTYumGGj/OlPrilnAWOxWy4+DP0GwV+EuPjKPGpFWM=;
	b=BCR9OqdtTaUXm0vE502KFCqwdcDiSiT4Q+ezpZNXBa3pic7Y338q7lcYh+jWKnxTfw9qV/
	x6yuHxdxMUf+Tj7N14LMsqHOehJ2RXbAvULtS3YPpPD1EpJiFiYDIkgwZs1/dJFIuOPtbd
	CT7KOPGgqu59ScY1c46eJE2Ae96PY2MuHASAdC2K6lkSzYYMtxbfD/56/uyFlbyCHMg+dK
	JN38DN8gpJycQ8hkEOfkKVJSvxOy/KooMu38oHAwFjv/0Wv0T//XhoBdKN4/MdQPdn4Lxd
	leEW/lsl1OzNdC53/t8PLiK8CImfAet0rJeDPkR/ef3tOgt/5TYyJqa2sCvBxg==
Message-ID: <43fe1fd5e88ac7dda08f522346cfa39ec58006bc.camel@mailbox.org>
Subject: Re: [PATCH v9 4/5] rust: Add dma_fence abstractions
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Gary Guo <gary@garyguo.net>, Philipp Stanner <phasta@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Daniel Almeida	
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=
 <work@onurozkan.dev>, Sumit Semwal	 <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Lyude Paul
 <lyude@redhat.com>, "Paul E. McKenney"	 <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett	 <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt	 <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Asahi Lina <lina+kernel@asahilina.net>, Burak
 Emir <bqe@google.com>, Lorenzo Stoakes <ljs@kernel.org>, FUJITA Tomonori	
 <fujita.tomonori@gmail.com>, Eliot Courtney <ecourtney@nvidia.com>, Mirko
 Adzic	 <adzicmirko97@gmail.com>, Timur Tabi <ttabi@nvidia.com>, Daniel del
 Castillo	 <delcastillodelarosadaniel@gmail.com>, Boris Brezillon	
 <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Date: Tue, 11 Aug 2026 11:46:36 +0200
In-Reply-To: <DKHWVRYDD28C.3H5R8CKLZ3035@garyguo.net>
References: <20260805145949.938505-2-phasta@kernel.org>
	 <20260805145949.938505-6-phasta@kernel.org>
	 <DKHWVRYDD28C.3H5R8CKLZ3035@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 2e84bd00eabb74370c6
X-MBO-RS-META: cmorqhb7w3gby9wj56qptq968e5d46eh

On Thu, 2026-08-06 at 14:56 +0100, Gary Guo wrote:
> On Wed Aug 5, 2026 at 3:59 PM BST, Philipp Stanner wrote:
> >=20

[=E2=80=A6]

(feel free to crop huge mails like this)


> > +/// Error type for fence callback registration.
> > +///
> > +/// Generic over `T` so that `AlreadySignaled` can return the callback=
 to the
> > +/// caller, allowing it to reclaim any resources owned by the callback=
 (e.g.,
> > +/// a fence handle that needs to be signaled).
> > +#[derive(Debug)]
> > +pub enum CallbackError<T =3D ()> {
>=20
> What is this `=3D ()` used for?

A relic, can remove.

>=20
> > +=C2=A0=C2=A0=C2=A0 /// The fence was already signaled. The callback is=
 returned so the caller
> > +=C2=A0=C2=A0=C2=A0 /// can extract owned resources without losing them=
.
> > +=C2=A0=C2=A0=C2=A0 AlreadySignaled(T),
> > +=C2=A0=C2=A0=C2=A0 /// Some other error occurred during registration.
> > +=C2=A0=C2=A0=C2=A0 Other(Error),
> > +}
> > +
> > +impl<T> From<CallbackError<T>> for Error {
>=20
> #[inline]
>=20
> > +=C2=A0=C2=A0=C2=A0 fn from(err: CallbackError<T>) -> Self {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 match err {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Cal=
lbackError::AlreadySignaled(_) =3D> ENOENT,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Cal=
lbackError::Other(e) =3D> e,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > +impl<T> From<AllocError> for CallbackError<T> {
>=20
> #[inline]
>=20
> > +=C2=A0=C2=A0=C2=A0 fn from(e: AllocError) -> Self {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CallbackError::Other(Error:=
:from(e))
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> >=20

[=E2=80=A6]

> > +pub trait FenceCallback: Send + 'static {
> > +=C2=A0=C2=A0=C2=A0 /// Called when the fence is signaled.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// This is called from the fence signaling path, w=
hich may be in interrupt
> > +=C2=A0=C2=A0=C2=A0 /// context or with locks held, which is why `self`=
 is only borrowed, so that
> > +=C2=A0=C2=A0=C2=A0 /// it cannot drop. Implementations must not sleep =
or perform
> > +=C2=A0=C2=A0=C2=A0 /// long-running operations.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// An implementation likely wants to inform itself=
 (e.g., through a work item)
> > +=C2=A0=C2=A0=C2=A0 /// within this callback that the associated [`Fenc=
eCallbackRegistration`]
> > +=C2=A0=C2=A0=C2=A0 /// can now be dropped.
> > +=C2=A0=C2=A0=C2=A0 fn called(&mut self);
>=20
> The name feels a bit awkward to me. I think this should either look like =
an
> action on the callback, in which case "call" or describe an event on the =
fence,
> i.e. "on_signal" or "signaled". Naming it "called" is very weird because =
it's
> not a event that is triggered when something is "called".

on_signal() sounds good.

>=20
> > +}
> > +
> >=20

[=E2=80=A6]

> > +#[pinned_drop]
> > +impl<T: FenceCallback> PinnedDrop for FenceCallbackRegistration<T> {
> > +=C2=A0=C2=A0=C2=A0 fn drop(self: Pin<&mut Self>) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Always call dma_fence_re=
move_callback, even if `callback` has already
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // been taken by `dma_fence=
_callback`.=C2=A0 This is necessary for
>=20
> Is this still up-to-date? You're not taking callback anymore in
> `dma_fence_callback`.

The comment is outdated, but the race prevention is still necessary.
I'll update the text.

>=20
> >=20

[=E2=80=A6]

> > +impl Deref for FenceGuard {
> > +=C2=A0=C2=A0=C2=A0 type Target =3D *mut bindings::dma_fence;
>=20
> Why not store and return `&Fence`?

Sounds good, although it would be cool if the FenceGuard directly
derefs to the raw pointer, since the need for accessing the latter with
the lock held is the reason the guard exists.

>=20
> > +
> >=20

[=E2=80=A6]

>=20
> #[inline] here and many more below.

I do not understand the Rust policy regarding inline at all. When do
you need it and when not?

>=20
> > +=C2=A0=C2=A0=C2=A0 fn lock(&self) -> FenceGuard {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let mut guard =3D FenceGuar=
d {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inn=
er: self.as_raw(),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fla=
gs: 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `fence` is valid=
 because `self` is valid. `flag_ptr` is
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // merely a pointer to an i=
nteger, whose lifetime is tied to the guard
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // object.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::dma_fenc=
e_lock_irqsave(guard.inner, &raw mut guard.flags) };
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 /// Get the fence's sequence number.
> > +=C2=A0=C2=A0=C2=A0 pub fn seqno(&self) -> u64 {

inline?

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Valid because `s=
elf` is valid.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*self.as_raw()).s=
eqno }
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::dma_fence {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.inner.get()
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 /// Create a [`Fence`] from a raw C [`bindings::dma=
_fence`].
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// # Safety
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// `ptr` must point to an initialized fence that i=
s embedded into a [`Fence`].
> > +=C2=A0=C2=A0=C2=A0 pub unsafe fn from_raw<'a>(ptr: *mut bindings::dma_=
fence) -> &'a Self {

inline?

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Safe as per the =
function's overall safety requirements.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { &*ptr.cast() }
> > +=C2=A0=C2=A0=C2=A0 }
> > +}

In C, we spent literally decades to get it out of people's heads to use
the inline keyword, because "the compiler knows better than you". It
should only be used for code in headers (and I even think that there
should not be code in headers).

What is the Rust equivalent?


> > +
> >=20

[=E2=80=A6]

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `fence` is valid=
 because `self` is valid. The lock must be
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // held, which we acquired =
directly above.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if !unsafe { bindings::dma_=
fence_test_signaled_flag(*fence.deref()) } {
>=20
> These `*fence.deref()` are quite weird as consequence of `FenceGuard` des=
ign.
> If `FenceGuard` just derefs to `&Fence` then this can be `fence.as_raw()`=
.

True; it's good to fix this.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
let Err(err) =3D res {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `fence` is valid because `self` is valid. =
The fence
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 // must not have been signaled yet, which we check di=
rectly above.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::dma_fence_set_error(*fence.deref()=
, err.to_errno()) };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // =
SAFETY: `fence` is valid because `self` is valid. The lock must
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // =
be held, which we acquired above.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uns=
afe { bindings::dma_fence_signal_locked(*fence.deref()) };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `self.data` is v=
alid because `self` is valid.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let fctx =3D unsafe { self.=
data.as_ref().fctx };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let _ =3D fctx.nr_of_unsign=
aled_fences.fetch_sub(1, Relaxed);
>=20
> Drop impl of `self` here will neededlessly take lock again before checkin=
g it's
> signaled already and unlock.

Yes, I know.
So? What could we do about it?

We need to take the lock when signaling, and we need to take it when
dropping to check if everyone was kind and did indeed signal before.

What you describe is a lock-relock on the same CPU, and it is unlikely
that there are contenders (only contender right now could be
Fence::is_signaled(), which is nothing upcoming users will poll
intensively).

tl;dr I don't see a problem with that

>=20
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> >=20

[=E2=80=A6]

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `call_rcu()` is =
always safe to be called. `rcu_head_ptr` was
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // created validly above. T=
he module must perform a `synchronize_rcu()`
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // or `rcu_barrier()` call =
to guard against module unload.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::call_rcu=
(rcu_head_ptr, Some(drop_driver_fence_data::<T>)) };
>=20
> I thought at some point it was mentioned that we want a fast path
>=20
> =C2=A0=C2=A0=C2=A0 if !mem::needs_drop::<...>() {
> =C2=A0=C2=A0=C2=A0 }

True. Added it.

>=20
> ?
>=20
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +


Regarding all your nits and comments I skipped above, I agree with them
for the most part and will address them in v10.


P.
