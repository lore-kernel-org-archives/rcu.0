Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C90233953
	for <rcu@vger.kernel.org>; Fri, 29 May 2026 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058985; cv=none; b=qwAt94jN7pc+r1uh2x3plmSiQRXpZhGgmVhVzFPAWza5DYP25qp5i0L4tSMnvzMw6FQL8hvveRMxaF8E6JfAh7gsWmm4uoKASd60UgcI/EmB+hM7TfZ/suKvBdl7cXA14yJ0An0bxPu7v3Poj8HBLJAQTMXpxb9WRgH13ifyUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058985; c=relaxed/simple;
	bh=x2aKMhhkAGizTVQy6X9xcdTfSCNO/IDoliwRYbkjjkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBiya/uvGfUOzl3EwQxqAbI3Ysrs1DGnfFJw6cZ013jTbedhYXDpxcr/evPUwrMMqp8gbY+fjViX1QGQjvmqf6lubaMM1Nj32/mP6ifV3D0cwfo7xG1uCRyFMHc21fw05zjL0kFL13s9SGmLIj9FS8SWu+mr3elPkqxmopyrdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=os1TpcqG; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="os1TpcqG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780058978; x=1780318178;
	bh=0LXnDvF4BpYabS4l5GpvWwA/zPyHFVDq38Spd9+GQPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=os1TpcqGrTl/EDdwVesLJCuEuvs56da/c10fNgHcZSwZE4I+HVFrx3ldAf8jfucyN
	 JrRHFcbr5548UQCLXOXe1wa8r4G4obBmBIu6cV3KwLEaVctGnxeP60mk8SX5SCM4g5
	 fE9dZRfVmcNyAyUBy4kQyclx1b6kYpw4qEO1hDyu18he2S2PeKE/zfI+WYC/HgfLCd
	 BZVYvawcBWHKwGLz6wIuJiBN4apVgsD5H6kcxFWwOvSIn3z4nVxYAyD+QQayCzAEIu
	 BfktXio3yI+ma9Efh+Pa8DrBuhdcoAcw+dovcEDBiw5M6UzjSIa84zS2BtDvrof7s9
	 fLUjdemeNVbJw==
X-Pm-Submission-Id: 4gRjqM2y8pz2ScP3
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
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
Date: Fri, 29 May 2026 15:49:31 +0300
Message-ID: <20260529124934.205738-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DIV62C2KC8HW.1KB4JAT9SXCRX@garyguo.net>
References: <20260528062810.256212-1-work@onurozkan.dev> <20260528062810.256212-4-work@onurozkan.dev> <20260528082025.44414-1-work@onurozkan.dev> <20260528083518.66203-1-work@onurozkan.dev> <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net> <20260529065744.59786-1-work@onurozkan.dev> <DIV5CERB9OTK.3VBQ0NUPD1FZ2@garyguo.net> <20260529122920.175997-1-work@onurozkan.dev> <DIV62C2KC8HW.1KB4JAT9SXCRX@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 13:41:10 +0100=0D
Gary Guo <gary@garyguo.net> wrote:=0D
=0D
> On Fri May 29, 2026 at 1:29 PM BST, Onur =C3=96zkan wrote:=0D
> > On Fri, 29 May 2026 13:07:18 +0100=0D
> > Gary Guo <gary@garyguo.net> wrote:=0D
> >=0D
> >> On Fri May 29, 2026 at 7:57 AM BST, Onur =C3=96zkan wrote:=0D
> >> >> >> > +#[pinned_drop]=0D
> >> >> >> > +impl PinnedDrop for Srcu {=0D
> >> >> >> > +    fn drop(self: Pin<&mut Self>) {=0D
> >> >> >> > +        let ptr =3D self.inner.get();=0D
> >> >> >> > +=0D
> >> >> >> > +        // SAFETY: By the type invariants, `self` contains a =
valid and pinned `struct srcu_struct`=0D
> >> >> >> > +        // and `srcu_readers_active()` only checks the active=
 reader count.=0D
> >> >> >> > +        if unsafe { bindings::srcu_readers_active(ptr) } {=0D
> >> >> >> > +            crate::pr_warn!(=0D
> >> >> >> > +                "Leaked `Guard` detected while dropping SRCU;=
 drop will block forever.\n"=0D
> >> >> >> > +            );=0D
> >> >> =0D
> >> >> I think this could be a `warn_on` similar to how cleanup_srcu_struc=
t handle the=0D
> >> >> condition.=0D
> >> >=0D
> >> > We also call cleanup_srcu_struct below. The idea was to provide addi=
tional=0D
> >> > information, we don't need to call warn_on twice.=0D
> >> =0D
> >> If the code blocks on `synchronize_srcu` then there's no call to=0D
> >> `cleanup_srcu_struct`.=0D
> >=0D
> >=0D
> > Ah right. I can do that in this case but honestly it's still more infor=
mative=0D
> > with the current way. It explicitly tells you what the problem is.=0D
> =0D
> While the error message itself is not that informative (there's some pote=
ntial=0D
> to improve this, see=0D
> https://lore.kernel.org/all/DI1IQE7MDV4O.5B2DVIXMX2OT@garyguo.net/), the =
stack=0D
> trace produced by a `warn_on` would have all the information and is more =
useful=0D
> to troubleshoot than a `pr_warn` which doesn't tell you which `Srcu` bein=
g=0D
> dropped is causing the issue.=0D
=0D
Cool, I will use it in the next version. Thanks!=0D
=0D
> =0D
> >> >> >=0D
> >> >> > Actually, now I am now thinking about whether we can come up with=
 a better=0D
> >> >> > approach when we detect leaked guards. Initially I came up with t=
he=0D
> >> >> > synchronize_srcu() solution because it would handle leaked guards=
 automatically=0D
> >> >> > without requiring any additional checks. But now that we can actu=
ally detect=0D
> >> >> > whether guards are leaked the question becomes:=0D
> >> >> >=0D
> >> >> > 	"Is there a better option than effectively sleeping forever when=
 leaked=0D
> >> >> > 	 guards are detected?"=0D
> >> >> >=0D
> >> >> > I have no plans for tomorrow other than finalizing this series in=
cluding the=0D
> >> >> > question above.=0D
> >> >> =0D
> >> >> The best solution is to proceed cleanups anyway, given Rust rules e=
nsure that=0D
> >> >> these are actual leaks and not just srcu read-side critical section=
 that failed=0D
> >> >> to synchronize with the destruction of SRCU.=0D
> >> >> =0D
> >> >> This obviously require changes to the SRCU code though.=0D
> >> >=0D
> >> >=0D
> >> > The issue is difficult to fix purely from the C side. Once drop retu=
rns Rust=0D
> >> > is free to destroy srcu_struct. If srcu still has pending callback a=
ssociated=0D
> >> > with that srcu_struct, for example from a future call_srcu() wrapper=
 then=0D
> >> > returning from drop while readers are active can turn into a UAF. Th=
ere is also=0D
> >> > no way to handle callbacks in a reasonable way in cleanup logic whil=
e there are=0D
> >> > active readers.=0D
> >> =0D
> >> Callbacks should be flushed during the drop due to srcu_barrier. Am I =
missing=0D
> >> something?=0D
> >=0D
> > No. Callbacks can only be invoked once the grace period has completed [=
1], which=0D
> > can never happen while there is an active reader.=0D
> >=0D
> > [1]: https://elixir.bootlin.com/linux/v7.1-rc5/source/kernel/rcu/srcutr=
ee.c#L1452-L1454=0D
> =0D
> Well, then srcu_barrier will not return. When `srcu_barrier` returns all=
=0D
> in-flight SRCU callbacks must have been executed.=0D
=0D
Yes, or there weren't any callbacks posted.=0D
=0D
> =0D
> Best,=0D
> Gary=0D
> =0D
> >=0D
> >> =0D
> >> I'm pretty sure that, if we disregard potential misuses from C side, r=
emoving=0D
> >> all "leak it" paths would be fine and won't leak to UAF if all users a=
re from=0D
> >> Rust side.=0D
> >> =0D
> >> To be very clear, I am not advocating to actually implement this way. =
I agree=0D
> >> with your conclusion below that this is broken code and a warning + bl=
ocking is=0D
> >> good enough. This is really just my thoughts on your "is there a bette=
r option"=0D
> >> question, and I think it's better in ideal world, but I think blocking=
 is a=0D
> >> good pragmatic choice.=0D
> >=0D
> > I see. Maybe I should have phrased the question like "Is there a better=
 option=0D
> > with similar complexity" to be more clear.=0D
