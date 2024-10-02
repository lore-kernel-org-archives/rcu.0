Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FA194A52
	for <rcu@vger.kernel.org>; Wed,  2 Oct 2024 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727856854; cv=none; b=rllRyBwOSGoMDYcUjkxAvZsF6Ik43KdSfLQS0QbhCnfr8TneWk+o1nfZR/fEWWk35TX7wAa9GU+F5DTTO5XcVi+fqlS3KjDGG3ayHKm1tICxhOE0ilCy11GIRDE8aAoZYtf36QOtelszK/oJfUhTWOzgM/Lo+QTQJVWncnud5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727856854; c=relaxed/simple;
	bh=8qAcjD5C/YKKipmzwR4wx3up8GfuLOBWdcljyM5kM58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=tIQ1eyt9b1ALTthaKvS7aB9orv0vqHOSy68928E3HWysR+cU6UPPqjZBcRX3CjZ9aqA41VJoDoXOeH0EUQzqWoi09eNHIaMbyoUAwDsKrCjrU52KBarNnT/tNXxcSCnj0H1qVqbOAsWWKi5loFSjcZf4ArG9DM2+6EqE/2/23PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-105-yxIePQGGMR-86E0GIzmtkQ-1; Wed, 02 Oct 2024 09:14:04 +0100
X-MC-Unique: yxIePQGGMR-86E0GIzmtkQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 2 Oct
 2024 09:13:15 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 2 Oct 2024 09:13:15 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alan Stern' <stern@rowland.harvard.edu>
CC: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon
	<will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng
	<boqun.feng@gmail.com>, John Stultz <jstultz@google.com>, Neeraj Upadhyay
	<Neeraj.Upadhyay@amd.com>, Frederic Weisbecker <frederic@kernel.org>, "Joel
 Fernandes" <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, "Mark
 Rutland" <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, "maged.michael@gmail.com"
	<maged.michael@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, Gary Guo
	<gary@garyguo.net>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "lkmm@lists.linux.dev"
	<lkmm@lists.linux.dev>
Subject: RE: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Thread-Topic: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Thread-Index: AQHbE2njI9qt6nx11kSrjhsE5O+AlrJyIkGggABQqYCAAKZugA==
Date: Wed, 2 Oct 2024 08:13:15 +0000
Message-ID: <22638e2fe1274eb0834fa3e43b44184e@AcuMS.aculab.com>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <9539c551-5c91-42db-8ac1-cff1d6d7c293@huaweicloud.com>
 <2cdda043-1ad9-40cf-a157-0c16a0ffb046@rowland.harvard.edu>
 <5d7d8a59-57f5-4125-95bb-fda9c193b9cf@huaweicloud.com>
 <82e97ad5-17ad-418d-8791-22297acc7af4@rowland.harvard.edu>
 <ea02ce2ce8a348efa8d461f84f976478@AcuMS.aculab.com>
 <2b1caba3-48fa-43b9-bd44-cf60b9a141d7@rowland.harvard.edu>
In-Reply-To: <2b1caba3-48fa-43b9-bd44-cf60b9a141d7@rowland.harvard.edu>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: 'Alan Stern'
> Sent: 01 October 2024 23:57
>=20
> On Tue, Oct 01, 2024 at 05:11:05PM +0000, David Laight wrote:
> > From: Alan Stern
> > > Sent: 30 September 2024 19:53
> > >
> > > On Mon, Sep 30, 2024 at 07:05:06PM +0200, Jonas Oberhauser wrote:
> > > >
> > > >
> > > > Am 9/30/2024 um 6:43 PM schrieb Alan Stern:
> > > > > On Mon, Sep 30, 2024 at 01:26:53PM +0200, Jonas Oberhauser wrote:
> > > > > >
> > > > > >
> > > > > > Am 9/28/2024 um 4:49 PM schrieb Alan Stern:
> > > > > >
> > > > > > I should also point out that it is not enough to prevent the co=
mpiler from
> > > > > > using @a instead of @b.
> > > > > >
> > > > > > It must also be prevented from assigning @b=3D@a, which it is o=
ften allowed to
> > > > > > do after finding @a=3D=3D@b.
> > > > >
> > > > > Wouldn't that be a bug?
> > > >
> > > > That's why I said that it is often allowed to do it. In your case i=
t
> > > > wouldn't, but it is often possible when a and b are non-atomic &
> > > > non-volatile (and haven't escaped, and I believe sometimes even the=
n).
> > > >
> > > > It happens for example here with GCC 14.1.0 -O3:
> > > >
> > > > int fct_hide(void)
> > > > {
> > > >     int *a, *b;
> > > >
> > > >     do {
> > > >         a =3D READ_ONCE(p);
> > > >         asm volatile ("" : : : "memory");
> > > >         b =3D READ_ONCE(p);
> > > >     } while (a !=3D b);
> > > >     OPTIMIZER_HIDE_VAR(b);
> > > >     return *b;
> > > > }
> > > >
> > > >
> > > >
> > > >         ldr     r1, [r2]
> > > >         ldr     r3, [r2]
> > > >         cmp     r1, r3
> > > >         bne     .L6
> > > >         mov     r3, r1   // nay...
> > >
> > > A totally unnecessary instruction, which accomplishes nothing other t=
han
> > > to waste time, space, and energy.  But nonetheless, allowed -- I agre=
e.
> > >
> > > The people in charge of GCC's optimizer might like to hear about this=
,
> > > if they're not already aware of it...
> > >
> > > >         ldr     r0, [r3] // yay!
> > > >         bx      lr
> > >
> > > One could argue that in this example the compiler _has_ used *a inste=
ad
> > > of *b.  However, such an argument would have more force if we had
> > > described what we are talking about more precisely.
> >
> > The 'mov r3, r1' has nothing to do with 'a'.
>=20
> What do you mean by that?  At this point in the program, a is the
> variable whose value is stored in r1 and b is the variable whose value
> is stored in r3.  "mov r3, r1" copies the value from r1 into r3 and is
> therefore equivalent to executing "b =3D a".  (That is why I said one
> could argue that the "return *b" statement uses the value of *a.)  Thus
> it very much does have something to do with "a".

After the cmp and bne r1 and r3 have the same value.
The compiler tracks that and will use either register later.
That can never matter.
Remember the compiler tracks values (in pseudo/internal registers)
not variables.

> > It is a more general problem that OPTIMISER_HIDE_VAR() pretty much
> > always ends up allocating a different internal 'register' for the
> > output and then allocating a separate physical rehgister.
>=20
> What output are you referring to?  Does OPTIMISER_HIDE_VAR() have an
> output?  If it does, the source program above ignores it, discarding any
> returned value.

Look up OPTIMISER_HIDE_VAR(x) it basically x =3D f(x) where f() is
the identity operation:
=09asm ("" : "+r"(x))
I'll bet that gcc allocates a separate internal/pseudo register
for the result so wants to do y =3D f(x).
Probably generating y =3D x; y =3D f(y);
(The 'mov' might be after the asm, but I think that would get
optimised away - the listing file might help.)

So here the compiler has just decided to reuse the register that
held the other of a/b for the extra temporary.

=09David

>=20
> > There doesn't seem to be a later optimisation path to remove
> > 'pointless' register moves.
>=20
> That would be a good thing to add, then.
>=20
> Alan

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

