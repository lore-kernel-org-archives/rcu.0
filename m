Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101E3DDAE9;
	Mon,  6 Jul 2026 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342910; cv=none; b=pxGv7tUAi8UMEhpGnpegCW0LaH4K9FkG470XW46wezXQEvaG70uXf9YAcVU3DZvd3m1IfcMNUX7Egx+hGqwFWcS0fYD664NcGlaB/PxbVYld836apMoOHB95WcZ/7dQA66sIE5ED9aJFlzTV23km4kjQ9PBG6WlUPgOWt3RNEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342910; c=relaxed/simple;
	bh=nK3G1Pa+vqFFze0oYzH31Fg0WiDQwzkz/OX943fJCDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKtil++bLaTbK0umdJ03GMDcPaGc2+zR46MO/VM0SFEYMjhbP8OflKfsUYvchInfqkbvg1YFtFMhCGKPXl2bxnhXhxcNknddhdDeU3pWUqQppSvdKqFDDatfrdlz9oFrqXkph7hqathoYl8V1amUrA2bFH5em5ZpXLrFT4a2Y5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=BBrOxk2P; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="BBrOxk2P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1783342896; x=1783602096;
	bh=rtp7Yxdd5V9AxAC+YD7vKN1zGxk5us7sGdy1srRzlW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BBrOxk2PTxNq+glOfc66ycoJOnbFE6J/rSyj6L9UOktCYkw46EY2WUwgaNBUP6l82
	 mCED8YCbpZ/LA6vhZX722o1IV2sAIjN1EHoW6KQmV5cs268o9lXT8Bioq+IeVCMIuu
	 6HFCp9irX167vJYaSYArwt/cTW94vRX2YbQXWA0vmclKcDidnW9DWFdR7I/u6uiQig
	 O/VBdJ7RciEcCfzmcPd5oUx1EjAsZXRe98h9eCdZxxcmLDrqCbfV/AhDQ4dR8c0vKu
	 Hux8zsO0J3+rgzbSdC++OiEIztWpffpvX0byCgVyWGu7Q+tizictPmXtFPxIzi0+Tc
	 jdml+zaobFhVA==
X-Pm-Submission-Id: 4gv4Hb1w8Yz1DFT1
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>,
	boqun@kernel.org,
	rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
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
Subject: Re: [PATCH v10 4/5] rust: sync: add SRCU abstraction
Date: Mon,  6 Jul 2026 16:01:26 +0300
Message-ID: <20260706130129.1835667-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DJRHTZ6KPOFC.FEE1KH7W6SQS@garyguo.net>
References: <20260613065348.96750-1-work@onurozkan.dev> <20260613065348.96750-5-work@onurozkan.dev> <akuXpnwb_y4R7ekV@google.com> <DJRHTZ6KPOFC.FEE1KH7W6SQS@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 06 Jul 2026 13:39:47 +0100=0D
Gary Guo <gary@garyguo.net> wrote:=0D
=0D
> On Mon Jul 6, 2026 at 12:55 PM BST, Alice Ryhl wrote:=0D
> > On Sat, Jun 13, 2026 at 09:40:10AM +0300, Onur =C3=96zkan wrote:=0D
> >> +#[pinned_drop]=0D
> >> +impl PinnedDrop for Srcu {=0D
> >> +    fn drop(self: Pin<&mut Self>) {=0D
> >> +        let ptr =3D self.inner.get();=0D
> >> +=0D
> >> +        if crate::warn_on!(=0D
> >> +            // SAFETY: By the type invariants, `self` contains a vali=
d and pinned `struct srcu_struct`=0D
> >> +            // and `srcu_readers_active()` only checks the active rea=
der count.=0D
> >> +            unsafe { bindings::srcu_readers_active(ptr) }=0D
> >> +        ) {=0D
> >> +            // `cleanup_srcu_struct()` may return early if there are =
still active readers.=0D
> >> +            // This should only happen if a guard was leaked with `me=
m::forget`, which is=0D
> >> +            // "WRONG" code and may cause a UAF because Rust will fre=
e the `srcu_struct`=0D
> >> +            // while it is still referenced from the C side (e.g. by =
`call_srcu()` callbacks).=0D
> >> +            //=0D
> >> +            // Another consequence of leaking guards is that `call_sr=
cu()` callbacks will=0D
> >> +            // never run because the grace period can never complete =
due to permanently=0D
> >> +            // active readers (i.e. leaked guards).=0D
> >> +            //=0D
> >> +            // If this ever happens, that means the guard was leaked =
by mistake and the=0D
> >> +            // caller must fix the bug. Sleeping here is intentional =
and less harmful=0D
> >> +            // than risking a UAF.=0D
> >> +            //=0D
> >> +            // SAFETY: By the type invariants, `self` contains a vali=
d and pinned=0D
> >> +            // `struct srcu_struct`.=0D
> >> +            unsafe { bindings::synchronize_srcu(ptr) };=0D
> >> +        }=0D
> >> +=0D
> >> +        // Ensure all SRCU callbacks have been finished before freein=
g.=0D
> >> +        // SAFETY: By the type invariants, `self` contains a valid an=
d pinned `struct srcu_struct`.=0D
> >> +        unsafe { bindings::srcu_barrier(ptr) };=0D
> >=0D
> > Hmm. It's not entirely clear to me that synchronize_srcu() is needed=0D
> > here. If there are calls to srcu_read_lock() that do not have a matchin=
g=0D
> > unlock due to use of mem::forget(), then either there is a pending=0D
> > call_srcu() callback in the queue, in which case srcu_barrier() already=
=0D
> > sleeps forever, or there are no such callbacks in which case I don't=0D
> > think this actually leads to UAF.=0D
> >=0D
> > Thoughts?=0D
> =0D
> If srcu_readers_active returns true, then `cleanup_srcu_struct` will hit =
one of=0D
> the "leak it" code path, and the question is whether that is okay.=0D
> =0D
> My analysis in https://lore.kernel.org/all/DI9ADEUBBUD2.22OR0R12PKVQL@gar=
yguo.net/:=0D
> >=0D
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
> >=0D
> > So I think, even if we hit the "Just leak it" scenario, we can still sa=
fely=0D
> > deallocate the backing storage of `srcu_struct` and nothing should brea=
k?=0D
> =0D
> So I _think_ it is not needed, but this is quite heavily related to inter=
nals of=0D
> SRCU implementation.=0D
=0D
So when cleanup_srcu_struct() hits "leak it" path, I wanted to make sure no=
thing=0D
can access to that freed srcu_struct and the easiest and safest approach fo=
r it=0D
is calling synchronize_srcu().=0D
=0D
Callbacks are just a detail that can become problem after this leak, so rel=
ying=0D
on srcu_barrier() to handle the "leak it" case doesn't sound like a good=0D
solution to me. It does not make the active reader case safe by itself and=
=0D
honestly we don't really lose anything with calling synchronize_srcu() as a=
n=0D
additional safety guard, so I just kept it that way..=0D
=0D
Thanks,=0D
Onur=0D
=0D
> =0D
> Best,=0D
> Gary=0D
