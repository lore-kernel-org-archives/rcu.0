Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E13A48F1
	for <rcu@vger.kernel.org>; Fri, 22 May 2026 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428826; cv=none; b=amaMI9ZjaEcMCggSyPVYF5F8SwbKcplMepCh8ERa89UYEDHNN0cycVL20c/fEvlx6LXrnrj5524bJOfAj/mY8OcBSV5iQS80Fxy26cwWKcIP9ULCtoH5dz1eltJLsbhrz3WLnu8eHNCvmMqeWQ7iJ9ifC6UruQOwXfT9XlSMWCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428826; c=relaxed/simple;
	bh=BKSPgYLwjJjqZShibS3Zb5LJlvqh/o5bzmlqighqbw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvH+iaUrWLcxL2XBIbJMVnNHnGhfIGwHxRt/BitLlWC7OHAAP1hWOLCYcVWOQ/lNznTWBWY2LwMjIA5MA63HfN25laOmmtSJ5RshSYMKyrTe+x4qPfRzwOzJhwfQRkMkkloYhisi1ehnK2tP9t2sGuOOu+JS5b4oimDAkL+fROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=EiwjELHE; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="EiwjELHE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779428821; x=1779688021;
	bh=WfxlNU7aToSRzVT3MSvjOtvYLtjWysePhhDTEqr3jL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EiwjELHELbkERXFR3n74wkNOdiBdPHZTN7gzNkYlvXNLmV/rc12LQUV3hAD0T83he
	 5n4AdhxvxPWnwwTdfa3KAbjBx7G+y3QXUnIxlc3z86yE7PW+4bzeON7CEn1I7QLDeH
	 Zp6ctFeUGM9fkOFxBytYWLmTkfhqoFPVaarJjZDMNkTEJHdoRsuPZjuN8Ca7fx85gz
	 Es7VOeFGBDgOa+dBgDsRc715EkFKMiw0W7zlhjsZjDlojSNkUcgR3E4kTqSgvBB59f
	 fC9cZMqT7XWLXWr0blEHIdWl1f8wjOya06Kh5dVRGIzbYPDZBXCNmYAMUJHAMaPfQy
	 G6RkYP9zNamVQ==
X-Pm-Submission-Id: 4gMDmz2rhcz2ScPH
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org,
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
Date: Fri, 22 May 2026 08:46:54 +0300
Message-ID: <20260522054658.122019-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260511171154.154280-1-work@onurozkan.dev>
References: <20260502162833.34334-1-work@onurozkan.dev> <20260502162833.34334-3-work@onurozkan.dev> <DI8DUMY6GAM6.24VYS1478B7L8@garyguo.net> <20260503034008.36917-1-work@onurozkan.dev> <DI9ADEUBBUD2.22OR0R12PKVQL@garyguo.net> <20260511171154.154280-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 20:11:26 +0300=0D
Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
=0D
> On Sun, 03 May 2026 20:25:03 +0100=0D
> Gary Guo <gary@garyguo.net> wrote:=0D
> =0D
> > On Sun May 3, 2026 at 4:39 AM BST, Onur =C3=96zkan wrote:=0D
> > >> > +/// Sleepable read-copy update primitive.=0D
> > >> > +///=0D
> > >> > +/// SRCU readers may sleep while holding the read-side guard.=0D
> > >> > +///=0D
> > >> > +/// The destructor may sleep.=0D
> > >> > +///=0D
> > >> > +/// # Invariants=0D
> > >> > +///=0D
> > >> > +/// This represents a valid `struct srcu_struct` initialized by t=
he C SRCU API=0D
> > >> > +/// and it remains pinned and valid until the pinned destructor r=
uns.=0D
> > >> > +#[repr(transparent)]=0D
> > >> > +#[pin_data(PinnedDrop)]=0D
> > >> > +pub struct Srcu {=0D
> > >> > +    #[pin]=0D
> > >> > +    inner: Opaque<bindings::srcu_struct>,=0D
> > >> > +}=0D
> > >> > +=0D
> > >> > +impl Srcu {=0D
> > >> > +    /// Creates a new SRCU instance.=0D
> > >> > +    #[inline]=0D
> > >> > +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKe=
y>) -> impl PinInit<Self, Error> {=0D
> > >> > +        try_pin_init!(Self {=0D
> > >> > +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::sr=
cu_struct| {=0D
> > >> > +                // SAFETY: `ptr` points to valid uninitialised me=
mory for a `srcu_struct`.=0D
> > >> > +                to_result(unsafe {=0D
> > >> > +                    bindings::init_srcu_struct_with_key(ptr, name=
.as_char_ptr(), key.as_ptr())=0D
> > >> > +                })=0D
> > >> > +            }),=0D
> > >> > +        })=0D
> > >> > +    }=0D
> > >> > +=0D
> > >> > +    /// Enters an SRCU read-side critical section.=0D
> > >> > +    ///=0D
> > >> > +    /// # Safety=0D
> > >> > +    ///=0D
> > >> > +    /// The returned [`Guard`] must not be leaked. Leaking it wit=
h [`core::mem::forget`]=0D
> > >> > +    /// leaves the SRCU read-side critical section active.=0D
> > >> =0D
> > >> I generally would prefer if we could use guard-like API instead of f=
orcing a=0D
> > >> callback.=0D
> > >=0D
> > > Me too and developers can still do that. I think the safety contract =
here is=0D
> > > very simple to handle. It's essentially this:=0D
> > >=0D
> > > 	// SAFETY: Guard is not leaked.=0D
> > > 	let _guard =3D unsafe { x.read_lock() };=0D
> > >=0D
> > > To me it's very simple and straightforward for both the developer and=
 the=0D
> > > reviewer. It doesn't add any overhead to the implementation and it en=
sures=0D
> > > that the developer (and later the reviewer) is aware of the potential=
 issue.=0D
> > >=0D
> > > Of course, there's also the safe option if the developer is happy wit=
h=0D
> > > closure-based API:=0D
> > >=0D
> > > 	x.with_read_lock(|_guard| {=0D
> > > 		...=0D
> > > 	});=0D
> > >=0D
> > > So it allows you to use the guard-based approach directly with the re=
quirement=0D
> > > of a safety comment and also provides a safe API for developers who d=
on't want=0D
> > > to deal with that. I am not sure if you fall into the third category,=
 which is=0D
> > > "I don't like writing safety comments and I don't like the closure-ba=
sed=0D
> > > approach" :)=0D
> > =0D
> > We have been avoiding using callback-based API if there's an alternativ=
ely way=0D
> > to achieve this. There has been quite a very precedents with this:=0D
> > =0D
> > - spin_lock_irqsave requires taking and releasing in correct order, whi=
ch is=0D
> >   easy to solve with a callback approach. The same logic reasoning can =
be used=0D
> >   to provide an unsafe API + safe callback API, but Boqun & Lyude rewor=
ked the=0D
> >   spinlock IRQ design so we don't need that anymore.=0D
> > =0D
> > - `Task::current` API could easily be replaced callback-based approach,=
 but we=0D
> >   used a macro to achieve without unsafe.=0D
> > =0D
> > The API here is not inherently impossible to use guard API. It's not sa=
fe today=0D
> > because a very specific detail. The callback-API is the "path of least=
=0D
> > resistence" approach, but it's not the optimal one.=0D
> > =0D
> > >=0D
> > >> =0D
> > >> I suppose the only reason that this is unsafe is the "just leak it" =
condition=0D
> > >> when cleaning up SRCU struct, which skips cleaning up delayed work, =
which could=0D
> > >> call into `process_srcu`, which accesses `srcu_struct`. This however=
 is *not*=0D
> > >> leaked, because it's controlled by the user. Only the auxillary data=
 allocated=0D
> > >> by SRCU is leaked. So UAF is going to happen.=0D
> > >> =0D
> > >> So in some aspect, the leak caused by `srcu_readers_active(ssp)` can=
 cause more=0D
> > >> damage compared to just continuing cleanup despite active users? I t=
hink this=0D
> > >> could be changed in one of these ways:=0D
> > >> * Have SRCU allocate all memory instead, and user-side would just ha=
ve a=0D
> > >>   `struct srcu_struct*`; then leaking would be safe. This is probabl=
y a bit=0D
> > >>   difficult to change because it affects many users.=0D
> > >=0D
> > > We could do the same on the Rust side only. Basically instead of embe=
dding=0D
> > > srcu_struct in Rust srcu, allocate it separately and store its pointe=
r. Then,=0D
> > > if cleanup hits the active reader case, we could leak that allocation=
 so any=0D
> > > remaining srcu work does not hit UAF. I was aware of this option but =
I would=0D
> > > prefer to avoid it because it adds an extra allocation for every Rust=
 srcu.=0D
> > >=0D
> > >> * Continue to flush delayed work and stop the timer, and then leak b=
efore the=0D
> > >>   actual kfree happens.=0D
> > >=0D
> > > Can you say more? I didn't understand this particular solution.=0D
> > =0D
> > I was thinking that doing this _might_ be sufficient. I have to admit t=
hat I've=0D
> > not very familar with the internal implementation of SRCU to make it an=
=0D
> > assertion though.=0D
> > =0D
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c=0D
> > index 0d01cd8c4b4a..5d75a4dbb6e5 100644=0D
> > --- a/kernel/rcu/srcutree.c=0D
> > +++ b/kernel/rcu/srcutree.c=0D
> > @@ -717,8 +717,6 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)=0D
> >  	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);=0D
> >  	if (WARN_ON(!delay))=0D
> >  		return; /* Just leak it! */=0D
> > -	if (WARN_ON(srcu_readers_active(ssp)))=0D
> > -		return; /* Just leak it! */=0D
> >  	/* Wait for irq_work to finish first as it may queue a new work. */=0D
> >  	irq_work_sync(&sup->irq_work);=0D
> >  	flush_delayed_work(&sup->work);=0D
> > =0D
> > But after taking another look, I am not even sure if this is needed. A =
quick=0D
> > glance of the code it appears that __srcu_read_unlock doesn't do anythi=
ng apart=0D
> > from adjusting the counter, and the SRCU grace period and thus the time=
rs won't=0D
> > actually start unless there's a pending grace period, which won't start=
 unless=0D
> > there's a call_srcu or sychronize_srcu. And we *know* that none of them=
 would=0D
> > happen, as the lifetime guarantees that nothing accesses the `Srcu` str=
uct when=0D
> > `drop` starts, and inside drop we have already invoked `srcu_barrier()`=
.=0D
> > =0D
> > So I think, even if we hit the "Just leak it" scenario, we can still sa=
fely=0D
> > deallocate the backing storage of `srcu_struct` and nothing should brea=
k?=0D
> > =0D
> > >=0D
> > >> * Trigger a `BUG` when the leak condition is hit for Rust users.=0D
> > >=0D
> > > We need an atomic counter to detect the leak and I thought that would=
 be too=0D
> > > much overhead for this abstraction. Basically each lock and drop will=
 call an=0D
> > > atomic operation so.=0D
> > =0D
> > You could just check if srcu_sup is NULL after calling `cleanup_srcu_st=
ruct`.=0D
> > =0D
> > Best,=0D
> > Gary=0D
> > =0D
> > >=0D
> > >> * Declare the `WARN_ON` to be a sufficient protection and say this c=
an be=0D
> > >>   considered safe. Kinda similar to the strategy we take to the=0D
> > >>   sleep-inside-atomic context issue.=0D
> > >=0D
> > > I think this is a rather weak precaution.=0D
> > >=0D
> > =0D
> =0D
> Alright, here is the alternative approach I just figured and I think this=
 makes=0D
> the most sense compared to the ones we discussed in this series:=0D
> 	=0D
> 	#[pinned_drop]=0D
> 	impl PinnedDrop for Srcu {=0D
> 		fn drop(self: Pin<&mut Self>) {=0D
> 			let ptr =3D self.inner.get();=0D
> =0D
> 			// `cleanup_srcu_struct()` may return early if readers are still activ=
e. Because `Srcu`=0D
> 			// owns the embedded `srcu_struct`, returning from `drop` in that stat=
e could free memory=0D
> 			// that is still referenced by the C side.=0D
> 			//=0D
> 			// Wait for all readers to complete first. If any `Guard` was leaked, =
`synchronize_srcu()`=0D
> 			// will sleep forever.=0D
> 			//=0D
> 			// SAFETY: By the type invariants, `self` contains a valid and pinned =
`struct srcu_struct`.=0D
> 			unsafe { bindings::synchronize_srcu(ptr) };=0D
> =0D
> 			// ...=0D
> =0D
> (the code snippet above is copied from [1])=0D
> =0D
> As explained in the doc comments, we avoid the potential UAFs by sleeping=
=0D
> forever which is considered non-unsafe, right? Alice said during today's=
=0D
> call that "sleeping is not good, but it is not unsafe". If that's the cas=
e,=0D
> I think this fixes the overall problem and we can make read_unlock safe a=
gain.=0D
> =0D
> What do you think? I will hold the next version until we reach a common p=
oint.=0D
=0D
I will be less available in the coming week and since there has been no res=
ponse=0D
to my proposal here, I included it in v3 and sent it [1].=0D
=0D
[1]: https://lore.kernel.org/all/20260522054228.114814-1-work@onurozkan.dev=
=0D
=0D
Regards,=0D
Onur=0D
=0D
> =0D
> [1]: https://github.com/onur-ozkan/linux/commit/28d9739f03=0D
> =0D
> - Onur=0D
