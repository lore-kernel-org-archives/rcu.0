Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8824887E;
	Mon, 11 May 2026 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519532; cv=none; b=X2C0pZbNNlZ5CANJ5G+gbSNV4gNrt/SORStOO8QA41Mg6ve5Qboge9o1WOFls2PmMlWfGYVDoQeofGYoHRFlFfLbvK5gDqmAbfEuV6RKw7lsIRc1stVCzN6Ux8S7b8+0Cif1d5t3St8+TT8BlgNKY/xb5H8moK2TZ5EqfZhp/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519532; c=relaxed/simple;
	bh=ukgKXmaqX2Dzg50fJN6zN/XQQEM7s2uzSuUbfmxoKJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUkhFqR4H1VqfW1Ad+kluRVqYScUENzMmXMmlRqcRSI9BcfJV9kUp/VIXLPI6U1tpLNyX7C+es/DWBMUWJxQPigq6hpxlLChZ9x2A6puV3tBhtxm/T+Zm2/LcvAnHujcLNbNwmFeUNKgY9nRC3hOyD1oOBgroi5858zlpUAmac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=TtnM9l/+; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="TtnM9l/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1778519520; x=1778778720;
	bh=ykhXu0h9b17SPJb8LfhQy3mDHA0xibSXJcBfk9YZ//g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TtnM9l/+0hvbjWRtS+3tbFqYm1nOjCMW/O09i8hod4did3f9Hf2rRmOaSIzlkjEm3
	 aJANZD2JurpIwq2iMBMK5Zqa2ggDI6I4YgWDo3T3NNRBLmTjmoamT70nvj/pEDbE6J
	 HudwKrrFoFvocZ4p2yxPa67p+sgsf646os1GK0sxitZqR+k+Jq76akmuSOARdyauwZ
	 aEu57SUZ6+sQ3ezP8gWe2chRiRRdFckO65kM4DLUJLDxJdMRkXo0lrLF6tbhNzoH22
	 o6phjGq9JivflIIjoh5q+69f+WEDvduJYyslcH1gMwtzpfx/VWAbjOBXjJaA3CYKge
	 tInE1CkYFtpdA==
X-Pm-Submission-Id: 4gDmVM6TYYz2Scpy
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Gary Guo <gary@garyguo.net>
Cc: rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
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
Subject: Re: [PATCH v2 2/3] rust: sync: add SRCU abstraction
Date: Mon, 11 May 2026 20:11:26 +0300
Message-ID: <20260511171154.154280-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DI9ADEUBBUD2.22OR0R12PKVQL@garyguo.net>
References: <20260502162833.34334-1-work@onurozkan.dev> <20260502162833.34334-3-work@onurozkan.dev> <DI8DUMY6GAM6.24VYS1478B7L8@garyguo.net> <20260503034008.36917-1-work@onurozkan.dev> <DI9ADEUBBUD2.22OR0R12PKVQL@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 03 May 2026 20:25:03 +0100=0D
Gary Guo <gary@garyguo.net> wrote:=0D
=0D
> On Sun May 3, 2026 at 4:39 AM BST, Onur =C3=96zkan wrote:=0D
> >> > +/// Sleepable read-copy update primitive.=0D
> >> > +///=0D
> >> > +/// SRCU readers may sleep while holding the read-side guard.=0D
> >> > +///=0D
> >> > +/// The destructor may sleep.=0D
> >> > +///=0D
> >> > +/// # Invariants=0D
> >> > +///=0D
> >> > +/// This represents a valid `struct srcu_struct` initialized by the=
 C SRCU API=0D
> >> > +/// and it remains pinned and valid until the pinned destructor run=
s.=0D
> >> > +#[repr(transparent)]=0D
> >> > +#[pin_data(PinnedDrop)]=0D
> >> > +pub struct Srcu {=0D
> >> > +    #[pin]=0D
> >> > +    inner: Opaque<bindings::srcu_struct>,=0D
> >> > +}=0D
> >> > +=0D
> >> > +impl Srcu {=0D
> >> > +    /// Creates a new SRCU instance.=0D
> >> > +    #[inline]=0D
> >> > +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>=
) -> impl PinInit<Self, Error> {=0D
> >> > +        try_pin_init!(Self {=0D
> >> > +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu=
_struct| {=0D
> >> > +                // SAFETY: `ptr` points to valid uninitialised memo=
ry for a `srcu_struct`.=0D
> >> > +                to_result(unsafe {=0D
> >> > +                    bindings::init_srcu_struct_with_key(ptr, name.a=
s_char_ptr(), key.as_ptr())=0D
> >> > +                })=0D
> >> > +            }),=0D
> >> > +        })=0D
> >> > +    }=0D
> >> > +=0D
> >> > +    /// Enters an SRCU read-side critical section.=0D
> >> > +    ///=0D
> >> > +    /// # Safety=0D
> >> > +    ///=0D
> >> > +    /// The returned [`Guard`] must not be leaked. Leaking it with =
[`core::mem::forget`]=0D
> >> > +    /// leaves the SRCU read-side critical section active.=0D
> >> =0D
> >> I generally would prefer if we could use guard-like API instead of for=
cing a=0D
> >> callback.=0D
> >=0D
> > Me too and developers can still do that. I think the safety contract he=
re is=0D
> > very simple to handle. It's essentially this:=0D
> >=0D
> > 	// SAFETY: Guard is not leaked.=0D
> > 	let _guard =3D unsafe { x.read_lock() };=0D
> >=0D
> > To me it's very simple and straightforward for both the developer and t=
he=0D
> > reviewer. It doesn't add any overhead to the implementation and it ensu=
res=0D
> > that the developer (and later the reviewer) is aware of the potential i=
ssue.=0D
> >=0D
> > Of course, there's also the safe option if the developer is happy with=
=0D
> > closure-based API:=0D
> >=0D
> > 	x.with_read_lock(|_guard| {=0D
> > 		...=0D
> > 	});=0D
> >=0D
> > So it allows you to use the guard-based approach directly with the requ=
irement=0D
> > of a safety comment and also provides a safe API for developers who don=
't want=0D
> > to deal with that. I am not sure if you fall into the third category, w=
hich is=0D
> > "I don't like writing safety comments and I don't like the closure-base=
d=0D
> > approach" :)=0D
> =0D
> We have been avoiding using callback-based API if there's an alternativel=
y way=0D
> to achieve this. There has been quite a very precedents with this:=0D
> =0D
> - spin_lock_irqsave requires taking and releasing in correct order, which=
 is=0D
>   easy to solve with a callback approach. The same logic reasoning can be=
 used=0D
>   to provide an unsafe API + safe callback API, but Boqun & Lyude reworke=
d the=0D
>   spinlock IRQ design so we don't need that anymore.=0D
> =0D
> - `Task::current` API could easily be replaced callback-based approach, b=
ut we=0D
>   used a macro to achieve without unsafe.=0D
> =0D
> The API here is not inherently impossible to use guard API. It's not safe=
 today=0D
> because a very specific detail. The callback-API is the "path of least=0D
> resistence" approach, but it's not the optimal one.=0D
> =0D
> >=0D
> >> =0D
> >> I suppose the only reason that this is unsafe is the "just leak it" co=
ndition=0D
> >> when cleaning up SRCU struct, which skips cleaning up delayed work, wh=
ich could=0D
> >> call into `process_srcu`, which accesses `srcu_struct`. This however i=
s *not*=0D
> >> leaked, because it's controlled by the user. Only the auxillary data a=
llocated=0D
> >> by SRCU is leaked. So UAF is going to happen.=0D
> >> =0D
> >> So in some aspect, the leak caused by `srcu_readers_active(ssp)` can c=
ause more=0D
> >> damage compared to just continuing cleanup despite active users? I thi=
nk this=0D
> >> could be changed in one of these ways:=0D
> >> * Have SRCU allocate all memory instead, and user-side would just have=
 a=0D
> >>   `struct srcu_struct*`; then leaking would be safe. This is probably =
a bit=0D
> >>   difficult to change because it affects many users.=0D
> >=0D
> > We could do the same on the Rust side only. Basically instead of embedd=
ing=0D
> > srcu_struct in Rust srcu, allocate it separately and store its pointer.=
 Then,=0D
> > if cleanup hits the active reader case, we could leak that allocation s=
o any=0D
> > remaining srcu work does not hit UAF. I was aware of this option but I =
would=0D
> > prefer to avoid it because it adds an extra allocation for every Rust s=
rcu.=0D
> >=0D
> >> * Continue to flush delayed work and stop the timer, and then leak bef=
ore the=0D
> >>   actual kfree happens.=0D
> >=0D
> > Can you say more? I didn't understand this particular solution.=0D
> =0D
> I was thinking that doing this _might_ be sufficient. I have to admit tha=
t I've=0D
> not very familar with the internal implementation of SRCU to make it an=0D
> assertion though.=0D
> =0D
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c=0D
> index 0d01cd8c4b4a..5d75a4dbb6e5 100644=0D
> --- a/kernel/rcu/srcutree.c=0D
> +++ b/kernel/rcu/srcutree.c=0D
> @@ -717,8 +717,6 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)=0D
>  	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);=0D
>  	if (WARN_ON(!delay))=0D
>  		return; /* Just leak it! */=0D
> -	if (WARN_ON(srcu_readers_active(ssp)))=0D
> -		return; /* Just leak it! */=0D
>  	/* Wait for irq_work to finish first as it may queue a new work. */=0D
>  	irq_work_sync(&sup->irq_work);=0D
>  	flush_delayed_work(&sup->work);=0D
> =0D
> But after taking another look, I am not even sure if this is needed. A qu=
ick=0D
> glance of the code it appears that __srcu_read_unlock doesn't do anything=
 apart=0D
> from adjusting the counter, and the SRCU grace period and thus the timers=
 won't=0D
> actually start unless there's a pending grace period, which won't start u=
nless=0D
> there's a call_srcu or sychronize_srcu. And we *know* that none of them w=
ould=0D
> happen, as the lifetime guarantees that nothing accesses the `Srcu` struc=
t when=0D
> `drop` starts, and inside drop we have already invoked `srcu_barrier()`.=
=0D
> =0D
> So I think, even if we hit the "Just leak it" scenario, we can still safe=
ly=0D
> deallocate the backing storage of `srcu_struct` and nothing should break?=
=0D
> =0D
> >=0D
> >> * Trigger a `BUG` when the leak condition is hit for Rust users.=0D
> >=0D
> > We need an atomic counter to detect the leak and I thought that would b=
e too=0D
> > much overhead for this abstraction. Basically each lock and drop will c=
all an=0D
> > atomic operation so.=0D
> =0D
> You could just check if srcu_sup is NULL after calling `cleanup_srcu_stru=
ct`.=0D
> =0D
> Best,=0D
> Gary=0D
> =0D
> >=0D
> >> * Declare the `WARN_ON` to be a sufficient protection and say this can=
 be=0D
> >>   considered safe. Kinda similar to the strategy we take to the=0D
> >>   sleep-inside-atomic context issue.=0D
> >=0D
> > I think this is a rather weak precaution.=0D
> >=0D
> =0D
=0D
Alright, here is the alternative approach I just figured and I think this m=
akes=0D
the most sense compared to the ones we discussed in this series:=0D
	=0D
	#[pinned_drop]=0D
	impl PinnedDrop for Srcu {=0D
		fn drop(self: Pin<&mut Self>) {=0D
			let ptr =3D self.inner.get();=0D
=0D
			// `cleanup_srcu_struct()` may return early if readers are still active.=
 Because `Srcu`=0D
			// owns the embedded `srcu_struct`, returning from `drop` in that state =
could free memory=0D
			// that is still referenced by the C side.=0D
			//=0D
			// Wait for all readers to complete first. If any `Guard` was leaked, `s=
ynchronize_srcu()`=0D
			// will sleep forever.=0D
			//=0D
			// SAFETY: By the type invariants, `self` contains a valid and pinned `s=
truct srcu_struct`.=0D
			unsafe { bindings::synchronize_srcu(ptr) };=0D
=0D
			// ...=0D
=0D
(the code snippet above is copied from [1])=0D
=0D
As explained in the doc comments, we avoid the potential UAFs by sleeping=0D
forever which is considered non-unsafe, right? Alice said during today's=0D
call that "sleeping is not good, but it is not unsafe". If that's the case,=
=0D
I think this fixes the overall problem and we can make read_unlock safe aga=
in.=0D
=0D
What do you think? I will hold the next version until we reach a common poi=
nt.=0D
=0D
[1]: https://github.com/onur-ozkan/linux/commit/28d9739f03=0D
=0D
- Onur=0D
