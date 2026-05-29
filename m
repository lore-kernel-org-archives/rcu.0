Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793303D9DCC;
	Fri, 29 May 2026 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057773; cv=none; b=fF20lUG3G2ZRL3lrkykEsxEJ+faygUvpJkSHx67J8uYXUVzOCCdXWDcqw695V/jSHMD5uvPteLmz6h5d232WEsHRPbqId8F3zyVQZ8M4jvK2dnhtKiMwQsl+qfKKSXNaGaYZe6pBsxBKtpLYpdysH49dnEm7wbfG8zbnst9HaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057773; c=relaxed/simple;
	bh=rehO3dNQq+4wcvEOutcnEYm65d8xvwTsY9z8n6GOcrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjduUVZ5LoI6o2F4i9xYr4L75TzqR0NkSmAeOW7XhwiLy+eTmTtLWtr2mlVUOAJzrI6tR8wOXfmeJkcatTg7JSw3AwbVSjCT+x1wUEF50IdPkdH4Tvmww483CPIURDOhBGVXPrB/1c5FXqTENFPX2Wwmssje8bYLi6fOjWIv0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=n4cjspxn; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="n4cjspxn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780057764; x=1780316964;
	bh=uAhje49ilKfiRPU+5E6PUSuSI1yUq4dmhJgvySYJnlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=n4cjspxnV8HZpV6olU7xTsPpbdlS/eN0LYDxYNBQVRSnU/PJoAu6nF+um/aIf/Bps
	 Ho20neXP6WZ7gpmXStxUG5u6taN1nZX00lA29mOZYE/Zpb9El7SgLjbUoKJPAzWuUi
	 hV4+LkCgNrhrpZYXy0/Bw0hSmmYPQboBCQ/bupD88yo/l9McCYU/orMU/z01SwwDiq
	 5iS+9DTTfyIvXGOPAko7bf5tVE3tCyOL7s6oWxn68bAwCuoXYJ6Z6nNvK8e8R3+TaJ
	 pskqlXEXIVC2XLVTRWLCyCutVm8Rwcan+pOb5h8R8AHaQVF6n2lEqwj6XeyUlFmlmC
	 FckepvFdEX8fg==
X-Pm-Submission-Id: 4gRjN15nP0z2ScPq
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
Date: Fri, 29 May 2026 15:29:14 +0300
Message-ID: <20260529122920.175997-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DIV5CERB9OTK.3VBQ0NUPD1FZ2@garyguo.net>
References: <20260528062810.256212-1-work@onurozkan.dev> <20260528062810.256212-4-work@onurozkan.dev> <20260528082025.44414-1-work@onurozkan.dev> <20260528083518.66203-1-work@onurozkan.dev> <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net> <20260529065744.59786-1-work@onurozkan.dev> <DIV5CERB9OTK.3VBQ0NUPD1FZ2@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 13:07:18 +0100=0D
Gary Guo <gary@garyguo.net> wrote:=0D
=0D
> On Fri May 29, 2026 at 7:57 AM BST, Onur =C3=96zkan wrote:=0D
> >> >> > +#[pinned_drop]=0D
> >> >> > +impl PinnedDrop for Srcu {=0D
> >> >> > +    fn drop(self: Pin<&mut Self>) {=0D
> >> >> > +        let ptr =3D self.inner.get();=0D
> >> >> > +=0D
> >> >> > +        // SAFETY: By the type invariants, `self` contains a val=
id and pinned `struct srcu_struct`=0D
> >> >> > +        // and `srcu_readers_active()` only checks the active re=
ader count.=0D
> >> >> > +        if unsafe { bindings::srcu_readers_active(ptr) } {=0D
> >> >> > +            crate::pr_warn!(=0D
> >> >> > +                "Leaked `Guard` detected while dropping SRCU; dr=
op will block forever.\n"=0D
> >> >> > +            );=0D
> >> =0D
> >> I think this could be a `warn_on` similar to how cleanup_srcu_struct h=
andle the=0D
> >> condition.=0D
> >=0D
> > We also call cleanup_srcu_struct below. The idea was to provide additio=
nal=0D
> > information, we don't need to call warn_on twice.=0D
> =0D
> If the code blocks on `synchronize_srcu` then there's no call to=0D
> `cleanup_srcu_struct`.=0D
=0D
=0D
Ah right. I can do that in this case but honestly it's still more informati=
ve=0D
with the current way. It explicitly tells you what the problem is.=0D
=0D
> =0D
> >=0D
> >> =0D
> >> >> > +        }=0D
> >> >> > +=0D
> >> >> > +        // `cleanup_srcu_struct()` may return early if readers a=
re still active. Because `Srcu`=0D
> >> >> > +        // owns the embedded `srcu_struct`, returning from `drop=
` in that state could free memory=0D
> >> >> > +        // that is still referenced by the C side.=0D
> >> >> > +        //=0D
> >> >> > +        // Wait for all readers to complete first. If any `Guard=
` was leaked, `synchronize_srcu()`=0D
> >> >> > +        // will sleep forever.=0D
> >> >> > +        //=0D
> >> >> > +        // SAFETY: By the type invariants, `self` contains a val=
id and pinned `struct srcu_struct`.=0D
> >> >> > +        unsafe { bindings::synchronize_srcu(ptr) };=0D
> >> >> =0D
> >> >> Sashiko got a good point here which is calling synchronize_srcu() o=
nly if there=0D
> >> >> are active readers. That's a nice low-effort improvement we can hav=
e in the next=0D
> >> >> version.=0D
> >> >> =0D
> >> >> Onur=0D
> >> >=0D
> >> > Actually, now I am now thinking about whether we can come up with a =
better=0D
> >> > approach when we detect leaked guards. Initially I came up with the=
=0D
> >> > synchronize_srcu() solution because it would handle leaked guards au=
tomatically=0D
> >> > without requiring any additional checks. But now that we can actuall=
y detect=0D
> >> > whether guards are leaked the question becomes:=0D
> >> >=0D
> >> > 	"Is there a better option than effectively sleeping forever when le=
aked=0D
> >> > 	 guards are detected?"=0D
> >> >=0D
> >> > I have no plans for tomorrow other than finalizing this series inclu=
ding the=0D
> >> > question above.=0D
> >> =0D
> >> The best solution is to proceed cleanups anyway, given Rust rules ensu=
re that=0D
> >> these are actual leaks and not just srcu read-side critical section th=
at failed=0D
> >> to synchronize with the destruction of SRCU.=0D
> >> =0D
> >> This obviously require changes to the SRCU code though.=0D
> >=0D
> >=0D
> > The issue is difficult to fix purely from the C side. Once drop returns=
 Rust=0D
> > is free to destroy srcu_struct. If srcu still has pending callback asso=
ciated=0D
> > with that srcu_struct, for example from a future call_srcu() wrapper th=
en=0D
> > returning from drop while readers are active can turn into a UAF. There=
 is also=0D
> > no way to handle callbacks in a reasonable way in cleanup logic while t=
here are=0D
> > active readers.=0D
> =0D
> Callbacks should be flushed during the drop due to srcu_barrier. Am I mis=
sing=0D
> something?=0D
=0D
No. Callbacks can only be invoked once the grace period has completed [1], =
which=0D
can never happen while there is an active reader.=0D
=0D
[1]: https://elixir.bootlin.com/linux/v7.1-rc5/source/kernel/rcu/srcutree.c=
#L1452-L1454=0D
=0D
> =0D
> I'm pretty sure that, if we disregard potential misuses from C side, remo=
ving=0D
> all "leak it" paths would be fine and won't leak to UAF if all users are =
from=0D
> Rust side.=0D
> =0D
> To be very clear, I am not advocating to actually implement this way. I a=
gree=0D
> with your conclusion below that this is broken code and a warning + block=
ing is=0D
> good enough. This is really just my thoughts on your "is there a better o=
ption"=0D
> question, and I think it's better in ideal world, but I think blocking is=
 a=0D
> good pragmatic choice.=0D
=0D
I see. Maybe I should have phrased the question like "Is there a better opt=
ion=0D
with similar complexity" to be more clear.=0D
=0D
Onur=0D
=0D
> =0D
> Best,=0D
> Gary=0D
> =0D
> >=0D
> > I mean in theory this could be fixed in the C code, but that would requ=
ire to=0D
> > re-write srcu cores/semantics for this special case. The $clean_somethi=
ng helper=0D
> > would need know that the active readers are abandoned and will never un=
lock and=0D
> > it would also need to decide what to do with the pending callbacks, whi=
ch is=0D
> > also a big problem (as gp will never complete, callbacks will never run=
).=0D
> >=0D
> > It's also worth to note that calling mem::forget on the srcu guard is W=
RONG=0D
> > CODE and very easy to catch on review (by us and also Sashiko/any LLM).=
 So=0D
> > finding a solution that doesn't add too much complexity should be a key=
=0D
> > consideration here. With that in mind, keeping the synchronize_srcu() n=
ot really=0D
> > a bad solution. Sleeping forever is a bad failure mode, but it is bette=
r than a=0D
> > potential UAF and either case requires sending a fix patch for the leak=
ed guard=0D
> > anyway.=0D
> =0D
