Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969803E4C84;
	Wed,  5 Aug 2026 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917360; cv=none; b=sJTiU3rSMgwVoJesNAR2V2iKmKd42w/MbQumTG0DVtSVmY9TorD/MdvsI3Po2de8Iy4zKNkiXOB47DShEHuoxI3qayGIkCvti5qDwQgaIoArxb1GF7fsq6sGCUpQEbSyvvE9tt/vez1OrtGCBaJ4bJCvsU3hKXq4VEuGFSX8N3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917360; c=relaxed/simple;
	bh=iP0f1d9wWStUnMJKkHnRLwlEbP/zpsn2MFzyddhcWJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eTp5e3pU3T4hMiMNP4fol8fp2+p+7UNzgTmpGufdujjADmxf/321pe/JtV60DYGqUnbSOC0yiHdzsssMDKSmpe99aoPVfKQV2s6eeBVKr5d1f6ANucXudj9DJ3n8BrWJbVvnB5Wz3ZsyLhDNGiKjzuGqu2up08yp1EA5UaQn6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hJ/yOiaV; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hJ/yOiaV"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hFNN04DnBzKv86;
	Wed, 05 Aug 2026 10:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785917328; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrlFduEWAgWIfi3DgMhEIBvdE+4/Ld539E20papiktk=;
	b=hJ/yOiaVTpzhfyA+N/6cBu2fooNa1obdlFAYRUspH7TTQQlSv1x5hRUJpL1Ugaco9X1M4T
	UwmeCNX4d6j8qhcWday1o1qo2rHwTAviC2KY17ZiffXKjbuwx+mDviMlTZL8XEOetPae+2
	i4BW0vBGypb/pyghB46rIjOQcU2p2yIkoUJr/kapQfbV1ctp0iGlpFVQSwPdMZIGAhElh5
	pMkznWfRv3Ox16N24ny1VTIr1rqolr1OauyxA8+zhmM34KR4SkEf7RDPReBy6uprhRNQeu
	WoY/d9ifR2GxlhpsT6lZ2dY2dka9fr3POn+yijQVXesZ9ohL9E/voh1figz0NQ==
Message-ID: <2b7a79c30005c736649acf06d0a5a424727008ab.camel@mailbox.org>
Subject: Re: [PATCH v8 4/5] rust: Add dma_fence abstractions
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Daniel Almeida <daniel.almeida@collabora.com>, Philipp Stanner
	 <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein	 <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	 <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Lyude Paul <lyude@redhat.com>, "Paul E.
 McKenney"	 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett	 <josh@joshtriplett.org>, Uladzislau
 Rezki <urezki@gmail.com>, Steven Rostedt	 <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,  Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Greg
 Kroah-Hartman	 <gregkh@linuxfoundation.org>, Asahi Lina
 <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>, Lorenzo Stoakes
 <ljs@kernel.org>, FUJITA Tomonori	 <fujita.tomonori@gmail.com>, Eliot
 Courtney <ecourtney@nvidia.com>, Mirko Adzic	 <adzicmirko97@gmail.com>,
 Timur Tabi <ttabi@nvidia.com>, Daniel del Castillo	
 <delcastillodelarosadaniel@gmail.com>, Boris Brezillon	
 <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	rcu@vger.kernel.org
Date: Wed, 05 Aug 2026 10:08:32 +0200
In-Reply-To: <47334F7F-BA84-4A4F-A222-9F81619C055A@collabora.com>
References: <20260731080411.848772-2-phasta@kernel.org>
	 <20260731080411.848772-6-phasta@kernel.org>
	 <47334F7F-BA84-4A4F-A222-9F81619C055A@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 4e2476250cf535966dd
X-MBO-RS-META: fyhtaapxm3nptxgt3aewjzjdpuqfwpj4

On Tue, 2026-08-04 at 14:54 -0300, Daniel Almeida wrote:
>=20
> Hi Phillip :)
>=20
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>

Hi, thx for the test

I address your major feedback below; minor points like renaming I will
address in the next revision.

>=20
> > On 31 Jul 2026, at 05:04, Philipp Stanner <phasta@kernel.org> wrote:
> >=20

[=E2=80=A6]

> > An additional issue discovered during the review process of this code i=
s
> > that there is (currently) no mechanism in Rust to prevent someone from
> > circumventing the DriverFence's FenceContext-reference's lifetime by
> > "forgetting" the fence, e.g. with core::mem::forget(). Since this
> > apparently can also happen with recfounting cycles, it's quite likely
> > that it would enable UAF bugs on the FenceContext. Print warnings if
> > this or other misuse of the fence API happens.
>=20
> I think cycles are fine, if anything they make things live longer than in=
tended
> (possibly leaking them forever), but at no point they lead to UAFs. And f=
or the
> mem::forget() point, there seems to be precedent in other patches pointin=
g to
> unsafe constructors, where the safety requirement is basically "don't
> mem::forget() this".
>=20
> In fact, if you mem::forget() in the previous Arc approach, it seems like=
 you leak
> the context, while mem::forget() on the current solution does seem to all=
ow UAF
> by ending the borrow as you said yourself:
>=20
> =C2=A0 let ctx =3D .... // FenceContext in some driver queue structure
> =C2=A0 let fence =3D ctx.fence_alloc(...).new_fence() // DriverFence<'_, =
T> // borrows ctx
> =C2=A0 mem::forget(fence); // ends the borrow
> =C2=A0 drop(ctx); // DriverFenceData contains a dangling &FenceContext, a=
nd that allocation is managed by C
>=20
> versus:
>=20
> =C2=A0 let ctx: Arc<FenceCtx<...>> =3D ...;=C2=A0 // same as above, assum=
e refcount=3D=3D1
> =C2=A0 let fence =3D ctx.new_fence_allocation(..).new_fence(); // ctx ref=
count=3D=3D2
> =C2=A0 mem::forget(fence); // ctx refcount=3D=3D2
> =C2=A0 drop(ctx) //ctx refcount=3D=3D1
>=20
> I noticed that you added a counter to catch the first case, but that assu=
mes that
> signaled fences won=E2=80=99t reach into the context anymore, IIUC? More =
on that below.

Answering on that further down below

>=20
> >=20

[=E2=80=A6]

>=20
> SPDX is being used here,
>=20
> > +
> > +/*
> > + * Copyright (C) 2025, 2026 Red Hat Inc.:
> > + *=C2=A0=C2=A0 Author: Philipp Stanner <pstanner@redhat.com>
> > + */
>=20
> So perhaps SPDX-CopyrightText should be used here?

What does that look like? I think I never saw it anywhere.

>=20
> > +
> >=20

[=E2=80=A6]

>=20
> > +=C2=A0=C2=A0=C2=A0 // happening.
> > +=C2=A0=C2=A0=C2=A0 //
> > +=C2=A0=C2=A0=C2=A0 // However, we cannot fully guarantee in Rust that =
`DriverFence`s will not
> > +=C2=A0=C2=A0=C2=A0 // be forgotten, e.g., through refcounting. This co=
uld circumvent the
> > +=C2=A0=C2=A0=C2=A0 // lifetime which intends to enforce that all fence=
s disappear before their
> > +=C2=A0=C2=A0=C2=A0 // context.
> > +=C2=A0=C2=A0=C2=A0 nr_of_unsignaled_fences: Atomic<u64>,
>=20
> Why are we tracking the number of unsignaled fences, specifically? Is it =
not
> possible for the C side (which controls the actual allocation) to reach b=
ack
> into the Rust side via the callbacks even after the context drops, regard=
less
> of their signaled status?

Tracking the number was agreed on as a compromise to move the
abstraction forward. It only exists for a warning-print.

The signaled status is absolutely decisive for preventing that both the
DriverFence::data and FenceContext cannot be reached anymore by both C
*and* Rust code consuming a Fence.

The reason is that the fence backend ops can reach the DriverFence and
the FenceContext. Only signalling the fence decouples them, and then
you still have to wait for an RCU grace period to be sure that all
accessors are gone. This is what the C backend forces on us, but it
also applies for someone doing (future implementations of)
Fence::get_driver_name() or Fence::is_signaled().

>=20
> And in any case, even side stepping this signaled vs unsignaled dilemma t=
hat
> this counter is trying to check, the end result seems to be "sorry, you m=
isused
> the API and now a UAF is possible". In this specific sense, it doesn't so=
und
> that much better than what we are trying to move away from in C.
>=20
> The more I think about this borrow design, the more I believe a simple re=
fcount
> would be way safer. I mean, this field would go away to begin with, IIUC,=
 and
> that=E2=80=99s not even considering the point above.

Refcounting does not solve the fundamental issue. A dma_fence must
always correctly represent the state of the associated job on the GPU.
If you forget a fence, you might deadlock. If you signal a fence for a
job that is still running on the GPU, you might get unnoticed memory
corruptions.

Refcounting the fctx was also my solution, but was objected to by
various parties (IIRC at least Boris and Danilo) who argue that the
life time is the proper solution. If I understood correctly the major
objection is that the refcount enables the device resources in
FenceContext::data to arbitrarily outlive its device, which is
something Danilo is very concerned about.


Anyways, as we discussed in the call, and as also my code comment in
FenceContext::drop() highlights, this atomic is only there for printing
a warning, because the proper solution we actually want is to have the
FenceContext signal all forgotten fences when it drops. *Then* you are
really completely safe, because then the forgotten fences get decoupled
from the fence context. So no UAF, although a driver that forgets
fences would still be broken.

The reason why (IIRC) Alice proposed doing the counter + warning and a
TODO entry is to move forward faster with the fence implementation,
which I understood is also in Tyr's interest (regarding this unlikely
bug).

The reason why it is not solved right now is that you need a data
structure in FenceContext that keeps track of unsignaled fences.
Entries in that data structure then have to be pre-allocated. And you
have to remove entries from the data structure *whenever a fence
signals*.

The only good data structure we have in Rust currently is XArray, which
we cannot use because:
 * it uses `usize` as an index, but dma_fence seqno is u64, so this
   could become a problem for Tyr, supporting 32-bit architectures.
 * We'd need to wait for Andreas' reservation mechanism for XArray.
 * XArray is not a good data structure for ever-increasing seqnos like
   the u64 of dma_fence. It quickly performance-degrades because it
   preserves index order, resulting in like a dozen pointer
   indirections for large indices.


So I had investigated using a List, but the list would force you then
to shove another refcounting mechanism (ListArc) on top of the stored
fences, and Rust's list implementation is really not trivial to be
used. At least not for me. Getting this right would take time.

Note that with the JobQueue design we're aiming at right now,
DriverFence and FenceContext would all be owned by JobQueue, so the
driver couldn't ever forget a DriverFence whithout also forgetting the
FenceContext. Hence, for the forseeable future, no one will encounter
that bug.

So, long story short, this is a solvable TODO, but we need a good data
structure for it. Preferably a hash table? Or the list implementation
needs to be improved so that it can take an ARef<Fence> instead of a
ListArc<Fence>. But someone needs to do that work.


Please tell me whether you agree with proceeding like this and make
FenceContext::drop() completely waterproof later, or whether you want
to suggest to do that now =E2=80=93 but then I'd need help with the data
structures.

>=20
>=20
> >=20

[=E2=80=A6]

> > +=C2=A0=C2=A0=C2=A0 /// The `data` you pass here must not perform any o=
perations that are illegal
> > +=C2=A0=C2=A0=C2=A0 /// in atomic context in its [`Drop`] implementatio=
n.
> > +=C2=A0=C2=A0=C2=A0 pub fn fence_alloc(&self, data: T::FenceDataType) -=
> Result<DriverFenceAllocation<'_, T>> {
>=20
> ^ In the same spirit as the last iteration, can we please rename this?
>=20
> We don=E2=80=99t need to shorten methods and types IMHO. We can just say
> =E2=80=9Cnew_allocation=E2=80=9D or a some other variation without =E2=80=
=9Calloc=E2=80=9D.

Well, the name IMO needs to reflect that this method creates some fency
object. So just "new_allocation" is not good I think because you want
to see *what* is being allocated.

new_fence_allocation() maybe?

>=20
> >=20

[=E2=80=A6]

> > +/// The receiving counterpart of a [`DriverFence`].
> > +///
> > +/// The Rust DMA fence implementation has a dualistic design: [`Driver=
Fence`]s
> > +/// are the producer-side, intended to be always owned by only one par=
ty. That
> > +/// party has the monopoly on signalling the fence.
> > +///
> > +/// A [`Fence`] is the counterpart for consumers. Thus, [`Fence`]s are=
 always
> > +/// refcounted and can shared with an arbitrary number of parties, inc=
luding
> > +/// userspace. Hereby, a [`Fence`] can only be used for actions such a=
s checking
> > +/// the fence's status or for registering callbacks on it.
> > +///
> > +/// Once the associated [`DriverFence`] signals, all
> > +/// [`FenceCallbackRegistration`]s registered on the [`Fence`] will be=
 executed.
> > +///
> > +/// A [`Fence`] can arbitrarily outlive its [`DriverFence`] and the
> > +/// [`FenceContext`]. Signalling a [`DriverFence`] decouples it from i=
ts
> > +/// [`Fence`]s.
> > +#[repr(transparent)]
> > +pub struct Fence {
> > +=C2=A0=C2=A0=C2=A0 /// The actual dma_fence passed to C.
> > +=C2=A0=C2=A0=C2=A0 inner: Opaque<bindings::dma_fence>,
> > +}
> > +
> > +/// Guard helper for locking within this module.
>=20
> Is this new? Needs a bit more documentation.

It is new, yes. Changelog mentions it.

>=20
> OTOH I think we shouldn=E2=80=99t come up with a new guard type. IIRC fro=
m
> Lyude=E2=80=99s et al previous work, there=E2=80=99s already a way to bui=
ld a Rust lock
> from a C lock (Lock::from_raw()). In fact, I think this whole implementat=
ion
> can boil down to:
>=20
> pub fn lock(&self) -> SpinLockIrqGuard<=E2=80=98_, ()> {
> =C2=A0 let ptr =3D unsafe {bindings::dma_fence_spinlock(=E2=80=A6)};
> =C2=A0 unsafe { SpinLockIrq::<()>::from_raw(ptr)}.lock()
> }
>=20
> This has a few advantages:=20
>=20
> a) doesn=E2=80=99t introduce its own guard type, instead reusing somethin=
g that was
> previously tested,
>=20
> b) you get the right behavior with the included NotThreadSafe token.
>=20
> c) the guard is now borrowed. Your guard is owned, which can easily lead =
to UB
> because the lifetime is detached from the &self that originated it.

This little helper is only used internally, and where it is used other
code bits have to operate on the rawpointer with other unsafe blocks.
At other places we use the fence rawpointer without taking the lock. So
I'm not sure whether this will ever be clean.


The only reason I added it was that I by now had 3 places where I do
unsafe { } lock and unlock.

Lyude's code is not yet merged.


[=E2=80=A6]

>=20
> > +///
> > +/// let mut fctx =3D KBox::pin_init(FenceContext::new(0, driver_name, =
timeline_name, fctx_data), GFP_KERNEL)?;
>=20
> Missing rustfmt?=20

I do run rustfmt. It doesn't do anything about this line.



P.
