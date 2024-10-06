Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101131A716
	for <rcu@vger.kernel.org>; Sun,  6 Oct 2024 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728244428; cv=none; b=pk7HtACJv283Z0edZMBY1C4xkDUV+ViBvbBPTHDu5AUKiIgIj/Z9Q9l+2fFatuNUA2uvkmvk3BoNryjwnKKzwGr6NZYFblUjTTUtcir+wghdwdtpYy4JoyJwXEaRux0WCgIJA6lKJkV2nTLMDPHWIQqqw/+/7rW4qaan3RSGH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728244428; c=relaxed/simple;
	bh=urAlj3YIPI6U4fGcdRwOSd1d81yifTqvt07cFMkvJsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=a/Qi9DsHrUUmGYWaPn1MigRgtj8ZyX1a3vFbwQ5rLySEkkhS99EAdPv8fLMmprlGZzsIlbykzo8S7C847OItyWejefav0AeOqfOja5MWVGo1VS+lMKP/ePdS4tqlWD5iwylD2ZnzKxqD+xDqZbyj22pHi7MCeORW+yr9Mo0Mt2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-PX6nP_3yOCep-K_4vURKFQ-1; Sun, 06 Oct 2024 20:53:44 +0100
X-MC-Unique: PX6nP_3yOCep-K_4vURKFQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 6 Oct
 2024 20:52:50 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 6 Oct 2024 20:52:49 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>, Boqun Feng
	<boqun.feng@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Andrew Morton
	<akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "Nicholas
 Piggin" <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon
	<will@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, John Stultz
	<jstultz@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, "Frederic
 Weisbecker" <frederic@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>, "Waiman
 Long" <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
	"maged.michael@gmail.com" <maged.michael@gmail.com>, Mateusz Guzik
	<mjguzik@gmail.com>, Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "lkmm@lists.linux.dev" <lkmm@lists.linux.dev>, Gary Guo
	<gary@garyguo.net>, Nikita Popov <github@npopov.com>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>
Subject: RE: [RFC PATCH v2 2/4] Documentation: RCU: Refer to ptr_eq()
Thread-Topic: [RFC PATCH v2 2/4] Documentation: RCU: Refer to ptr_eq()
Thread-Index: AQHbFpQfGMiCXlKVq0GFl3C1s2BlXbJ6I7mg
Date: Sun, 6 Oct 2024 19:52:49 +0000
Message-ID: <72af935f4a2a4e23b68845d2f6855103@AcuMS.aculab.com>
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
 <20241004182734.1761555-3-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241004182734.1761555-3-mathieu.desnoyers@efficios.com>
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

From: Mathieu Desnoyers
> Sent: 04 October 2024 19:28
>=20
> Refer to ptr_eq() in the rcu_dereference() documentation.
>=20
> ptr_eq() is a mechanism that preserves address dependencies when
> comparing pointers, and should be favored when comparing a pointer
> obtained from rcu_dereference() against another pointer.

Why does this ever really matter for rcu?

The check just ensure that any speculative load uses
a specific one of the pointers when they are different.
This can only matter if you care about the side effects
of the speculative load.

But rcu is all about (things like) lockless list following.
So you need to wait until it is impossible for another
execution context to have a reference to some memory
before actually completely invalidating it (ie kfree()).

And that 50 line comment is pointless.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

