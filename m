Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC41D0794
	for <rcu@vger.kernel.org>; Wed,  2 Oct 2024 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882740; cv=none; b=XQSVD5y/h9DlopBDkhvPvGHO4gpI5gYCtMllpPJEC2GijmMd4AXZA+g6vAkpjA9K7AfEEVK+ONVc0kLwzUfsMPBIwqmoLQ1pHcS3cUXdhnhFluzXSqUgC8Tauv4pu1m+CUmx/QsLrUzsF1dE/OMFYn1DluvYcyFfN7Y8wWbNsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882740; c=relaxed/simple;
	bh=nn7GQ6Dvxkknp11uEm8bVJIELYcnBbsclZqYnTTCGQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=iRo/q2Q36RbO6EsyjX89+gyRemOQVa4wJceZ5fTe5NOQP5YYQbPG78J4YWJaw42HtGGi+6lbtkO66gULwFf8G/h+qCEcGPMSckzncGTNLSNSTD0FZL79Q9Gezq3oJB3Bky3JkKMT5F2pbsrgWh8utGKdIXHsuDrlbtCLX+88fsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-319-0qh1U1F9OE-o__CYQVvx_A-1; Wed, 02 Oct 2024 16:25:35 +0100
X-MC-Unique: 0qh1U1F9OE-o__CYQVvx_A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 2 Oct
 2024 16:24:46 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 2 Oct 2024 16:24:46 +0100
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
Thread-Index: AQHbE2njI9qt6nx11kSrjhsE5O+AlrJyIkGggABQqYCAAKZugIAAWd+AgAAhswA=
Date: Wed, 2 Oct 2024 15:24:45 +0000
Message-ID: <e39c6e5975f345c4b1a97145e207dee4@AcuMS.aculab.com>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <9539c551-5c91-42db-8ac1-cff1d6d7c293@huaweicloud.com>
 <2cdda043-1ad9-40cf-a157-0c16a0ffb046@rowland.harvard.edu>
 <5d7d8a59-57f5-4125-95bb-fda9c193b9cf@huaweicloud.com>
 <82e97ad5-17ad-418d-8791-22297acc7af4@rowland.harvard.edu>
 <ea02ce2ce8a348efa8d461f84f976478@AcuMS.aculab.com>
 <2b1caba3-48fa-43b9-bd44-cf60b9a141d7@rowland.harvard.edu>
 <22638e2fe1274eb0834fa3e43b44184e@AcuMS.aculab.com>
 <d192cf63-a274-4721-968e-a2c098db523b@rowland.harvard.edu>
In-Reply-To: <d192cf63-a274-4721-968e-a2c098db523b@rowland.harvard.edu>
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
> Sent: 02 October 2024 15:15
>=20
> On Wed, Oct 02, 2024 at 08:13:15AM +0000, David Laight wrote:
> > From: 'Alan Stern'
> > > Sent: 01 October 2024 23:57
> > >
> > > On Tue, Oct 01, 2024 at 05:11:05PM +0000, David Laight wrote:
> > > > From: Alan Stern
> > > > > Sent: 30 September 2024 19:53
> > > > >
> > > > > On Mon, Sep 30, 2024 at 07:05:06PM +0200, Jonas Oberhauser wrote:
> > > > > >
> > > > > >
> > > > > > Am 9/30/2024 um 6:43 PM schrieb Alan Stern:
> > > > > > > On Mon, Sep 30, 2024 at 01:26:53PM +0200, Jonas Oberhauser wr=
ote:
> > > > > > > >
> > > > > > > >
> > > > > > > > Am 9/28/2024 um 4:49 PM schrieb Alan Stern:
> > > > > > > >
> > > > > > > > I should also point out that it is not enough to prevent th=
e compiler from
> > > > > > > > using @a instead of @b.
> > > > > > > >
> > > > > > > > It must also be prevented from assigning @b=3D@a, which it =
is often allowed to
> > > > > > > > do after finding @a=3D=3D@b.
> > > > > > >
> > > > > > > Wouldn't that be a bug?
> > > > > >
> > > > > > That's why I said that it is often allowed to do it. In your ca=
se it
> > > > > > wouldn't, but it is often possible when a and b are non-atomic =
&
> > > > > > non-volatile (and haven't escaped, and I believe sometimes even=
 then).
> > > > > >
> > > > > > It happens for example here with GCC 14.1.0 -O3:
> > > > > >
> > > > > > int fct_hide(void)
> > > > > > {
> > > > > >     int *a, *b;
> > > > > >
> > > > > >     do {
> > > > > >         a =3D READ_ONCE(p);
> > > > > >         asm volatile ("" : : : "memory");
> > > > > >         b =3D READ_ONCE(p);
> > > > > >     } while (a !=3D b);
> > > > > >     OPTIMIZER_HIDE_VAR(b);
> > > > > >     return *b;
> > > > > > }
> > > > > >
> > > > > >
> > > > > >
> > > > > >         ldr     r1, [r2]
> > > > > >         ldr     r3, [r2]
> > > > > >         cmp     r1, r3
> > > > > >         bne     .L6
> > > > > >         mov     r3, r1   // nay...
> > > > >
> > > > > A totally unnecessary instruction, which accomplishes nothing oth=
er than
> > > > > to waste time, space, and energy.  But nonetheless, allowed -- I =
agree.
> > > > >
> > > > > The people in charge of GCC's optimizer might like to hear about =
this,
> > > > > if they're not already aware of it...
> > > > >
> > > > > >         ldr     r0, [r3] // yay!
> > > > > >         bx      lr
> > > > >
> > > > > One could argue that in this example the compiler _has_ used *a i=
nstead
> > > > > of *b.  However, such an argument would have more force if we had
> > > > > described what we are talking about more precisely.
> > > >
> > > > The 'mov r3, r1' has nothing to do with 'a'.
> > >
> > > What do you mean by that?  At this point in the program, a is the
> > > variable whose value is stored in r1 and b is the variable whose valu=
e
> > > is stored in r3.  "mov r3, r1" copies the value from r1 into r3 and i=
s
> > > therefore equivalent to executing "b =3D a".  (That is why I said one
> > > could argue that the "return *b" statement uses the value of *a.)  Th=
us
> > > it very much does have something to do with "a".
> >
> > After the cmp and bne r1 and r3 have the same value.
> > The compiler tracks that and will use either register later.
> > That can never matter.
>=20
> The whole point of this thread is that sometimes it _does_ matter.  Not
> on x86, but on weakly ordered architectures where using the wrong
> register will bypass a dependency and allow the CPU to speculatively
> load values earlier than the programmer wants it to.
>=20
> > Remember the compiler tracks values (in pseudo/internal registers)
> > not variables.
> >
> > > > It is a more general problem that OPTIMISER_HIDE_VAR() pretty much
> > > > always ends up allocating a different internal 'register' for the
> > > > output and then allocating a separate physical rehgister.
> > >
> > > What output are you referring to?  Does OPTIMISER_HIDE_VAR() have an
> > > output?  If it does, the source program above ignores it, discarding =
any
> > > returned value.
> >
> > Look up OPTIMISER_HIDE_VAR(x) it basically x =3D f(x) where f() is
> > the identity operation:
> > =09asm ("" : "+r"(x))
> > I'll bet that gcc allocates a separate internal/pseudo register
> > for the result so wants to do y =3D f(x).
> > Probably generating y =3D x; y =3D f(y);
> > (The 'mov' might be after the asm, but I think that would get
> > optimised away - the listing file might help.)
> >
> > So here the compiler has just decided to reuse the register that
> > held the other of a/b for the extra temporary.
>=20
> I think you've got this backward.  As mentioned above, a is originally
> in r1 and b is in r3.  The source says OPTIMIZER_HIDE_VAR(b), so you're
> saying that gcc should be copying r3 into a separate internal/pseudo
> register.  But instead it's copying r1.

I think I know what you are trying to do, and you just fail.
Whether something can work is another matter, but that code
can't ever work.

Inside if (a =3D=3D b) the compiler will always use the same register
for references to a and b - because it knows they have the same value.

Possibly something like:
=09c =3D b;
=09OPTIMISER_HIDE_VAR(c);
=09if (a =3D=3D c) {
=09=09*b
will ensure that there isn't a speculative load from *a.
You'll get at least one register-register move - but they are safe.
Otherwise you'll need to put the condition inside an asm block.

=09David

>=20
> Alan

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

