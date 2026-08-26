Received: from mta1.migadu.com (out-239.mta1.migadu.com [95.215.58.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DE1306498
	for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787714782; cv=none; b=Esid1MW84OwijZbhuX7ghltnDiEyOKvjTIibdM7bo/d7ly7slnp9dFWubATfw4kd8MDD/gqpVCt+S4yYErhCI2SlXArSipBVKn6wt2g9AZ9rBWvUJcM/hPVTnbcDqpDptQGqhNcFJejHSX4SPKwIJ3o4x7xJ9foIzDNexLaTQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787714782; c=relaxed/simple;
	bh=BoOEeC1UgkAdtAXh0gBc2XLf7OBg9w6rgGaafjYXKno=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=HwiGui6Xo5O5EU7FTU8TgR3mtJtNhwncY0OdpybEaIAW2mi/Jgq/6I66qLuf/QFnlRN305e/Px6JrZIS8Qs4671cc2AGrLpAhNFx3lv5SGZwQgwdLkpGiAQ4H9LsulX2OD2i57OllVEfd7q7eoDEKN1mTmQyAWO8yjqsc5+D6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OkNMMC5l; arc=none smtp.client-ip=95.215.58.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OkNMMC5l"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BoOEeC1UgkAdtAXh0gBc2XLf7OBg9w6rgGaafjYXKno=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787714778; v=1; x=1788319578;
 b=OkNMMC5lMdXzApYz/qaKAxgtogsGBr8mR75ZkS7c/iDkY+BUUiPvSVRAQGfuYH6freICC5Ic
 5wcJmg7cO6Actoz/Tm6xDGKTdh9kSTJJMNQJ3FjLn1n8uA5rL0PNOkZ41U8lUuH9jZ9wb0hTHav
 VKzB7x4inGcPzuH48wvbNBXw=
X-Envelope-To: rcu@vger.kernel.org
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by smtp.migadu.com with ESMTPS id 94384c40a50ac1d2;
	Wed, 26 Aug 2026 03:26:18 +0000
X-Mizu-Trace-ID: 94384c40a50ac1d2
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 03:26:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <ef7c880f59eedf0cd2f2b26842016bbbc2b68a06@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] srcu: Add try_synchronize_srcu() for callers which can
 prove readers absent
To: paulmck@kernel.org, "David Woodhouse" <dwmw2@infradead.org>
Cc: "Kunwu Chan" <kunwu.chan@gmail.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Josh Triplett" <josh@joshtriplett.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joel@joelfernandes.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Sean
 Christopherson" <seanjc@google.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>, rcu@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <42ba6de7-3281-42c9-8d7b-f7dc62c10f62@paulmck-laptop>
References: <20260821032210.792451-1-kunwu.chan@linux.dev>
 <d26ec36e92e8f5aa244e2a22de5d167d14b36597.camel@infradead.org>
 <42ba6de7-3281-42c9-8d7b-f7dc62c10f62@paulmck-laptop>

Hi Paul,

I'd be interested in helping with one of these. Are there any items
that are not already being worked on and would be useful for me to
take on? I'm particularly interested in the Tree
`synchronize_srcu_atomic()` fastpath, if that part is still open.

Thanks,
Kunwu


August 26, 2026 at 7:49 AM, "Paul E. McKenney" <paulmck@kernel.org mailto=
:paulmck@kernel.org?to=3D%22Paul%20E.%20McKenney%22%20%3Cpaulmck%40kernel=
.org%3E > wrote:


>=20
>=20On Fri, Aug 21, 2026 at 12:53:22PM +0100, David Woodhouse wrote:
>=20
>=20>=20
>=20> On Fri, 2026-08-21 at 11:22 +0800, Kunwu Chan wrote:
> >=20
>=20[ . . . ]
>=20
>=20>=20
>=20> When applying this to current rcu/dev, the patch also needs to acco=
unt
> >  for the additional bool is_atomic argument to
> >  check_init_srcu_struct(). Please rebase accordingly.
> >=20=20
>=20>  Ooh, shiny, I hadn't spotted that the atomic thing had landed. May=
be I
> >  should retract my 'if we get that' above... but let's see how it
> >  survives.
> >=20
>=20It is starting to shape up. Here is what is left, that I know of, any=
way:
>=20
>=20o A bit more work to get rcutorture to put up with atomic SRCU.
>=20
>=20o Tree synchronize_srcu_atomic() fastpath.
>=20
>=20o Disable preemption.
>=20
>=20o Reorganize commits to fix the Tiny hunks that got applied
>  in Tree commits, and likely other similar issues.
>=20
>=20o More work on error checking for use of banned primitives
>  with atomic SRCU.
>=20
>=20o Update documentation.
>=20
>=20Not that it matters, but atomic Tiny SRCU seems to be doing quite wel=
l.
>=20
>=20>=20
>=20> I also have more than just this patch to rebase onto rcu/dev =E2=80=
=94 unlike
> >  some, I'm not just hacking RCU for the fun of it; I get my jollies
> >  elsewhere :)
> >=20=20
>=20>  Btw, the current commit c68271c3f83a message says "no index flip, =
no
> >  grace-period sequence update" but that isn't true of the implementat=
ion
> >  any more, is it? In fact, it *always* does those things, and doesn't
> >  take the try-path optimisation by counting both epochs, that I'm doi=
ng
> >  here?
> >=20
>=20The current "dev" branch is here:
>=20
>=20dc5bf5c8fb26 ("fixup! srcutree: Add an atomic Tree SRCU").
>=20
>=20Tree SRCU always does an index flip, though a single index flip can
> serve multiple concurrent calls to synchronze_srcu_atomic().
>=20
>=20Tiny SRCU has the fast path, but must advance the index anyway for th=
e
> benefit of get_state_synchronize_srcu() and friends. It just bumps it
> in one shot.
>=20
>=20Tree SRCU will also have to bump the index, but will be able to
> do so manually, without doing all the grace-period processing.
>=20
>=20>=20
>=20> Thanks for the careful review.
> >=20
>=20What David said! ;-)
>=20
>=20 Thanx, Paul
>
