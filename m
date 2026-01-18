Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FAD1D5174;
	Sun, 18 Jan 2026 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768766357; cv=none; b=RfKpmlVySDsPKukt3Uf+Y1/RVmqnSg6Qx/1X7Lyc9y/dyYZnXNZeFBjNp6SDXMiS1G7AQHsHa09dAIZR89pIzbpBiFRXwhUBCPnUvWVBAykDt0wmT+VwxbvEUoWBdanuTwX25xr8y/iy4QFSxOT/VTjyYi5E4Kcb6GCgwDiA4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768766357; c=relaxed/simple;
	bh=tdfFs8o6IzX0PU1jw/waS8H4E99wWg+JeQJm1sdbrRM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M0y/wP8yujUZr+NfsrpACz4rXgrqQq2KqZJsVJQvTBrOvPrFa+JlqGNHpj9sqShKOVQkG39PgYEDQMys+9bJsHGI5hhpYbDhZmzrRneG50HeaStS85tzJueNC5nUXmz5DxGPTwPYISTUFwBiF7Kj/sWXypdLFt8DP5X/2xnHanA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg4jW5ig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg4jW5ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73385C116D0;
	Sun, 18 Jan 2026 19:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768766356;
	bh=tdfFs8o6IzX0PU1jw/waS8H4E99wWg+JeQJm1sdbrRM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=dg4jW5igsyGoKRtJ9HcfCH5Z/6dWYEI3KLA2H3qYxKuQdhuHgKuGcyyMnxFa13E/G
	 DCNYClllqMnGsEdZuM1LtdWisM0SQJfKzEKWoIGFvFUOmcrLno4ylcTdUu9MvQG8IZ
	 RXWhpJ0i28Bj7KQbKzYDTMFhuXnDedKPBqzoN7fltL9RTlbUFrerry4MyGbtm9t/Fp
	 oS1dExloxWUfuFYgGv35R0AXTfuCKnkC6BeX89QfTs2Vv10RUP1FZF7nWfucKVCWYM
	 ak5hZ/MaY1m/O1iSGidCvefQF1JZfDPBbUinxWysZJEdY3s9TgdIXgjizrX93ETyFe
	 yg+2+SYUvRLxg==
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Jan 2026 20:59:09 +0100
Message-Id: <DFRZCBBXBTM8.2BSEQFA5F28W9@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay"
 <neeraj.upadhyay@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 4/5] rust: sync: atomic: Add Atomic<*mut T> support
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Dirk Behme" <dirk.behme@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260117122243.24404-1-boqun.feng@gmail.com>
 <20260117122243.24404-5-boqun.feng@gmail.com>
 <67e5482b-93ed-4b5f-8375-f7e68c50a436@gmail.com>
 <aWz04Tb7SSDQls8T@tardis-2.local> <aWz2oZqMaQHQWe-e@tardis-2.local>
In-Reply-To: <aWz2oZqMaQHQWe-e@tardis-2.local>

On Sun Jan 18, 2026 at 4:05 PM CET, Boqun Feng wrote:
> On Sun, Jan 18, 2026 at 10:57:37PM +0800, Boqun Feng wrote:
>> On Sun, Jan 18, 2026 at 09:38:36AM +0100, Dirk Behme wrote:
>> [...]
>> > > =20
>> > > +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hen=
ce the atomicity is only
>> >=20
>> > uses -> use ?
>> >=20
>>=20
>> Will fix, thank you!
>>=20
>> > > +// guaranteed against read-modify-write operations if the architect=
ure supports native atomic RmW.
>> > > +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
>> > > +impl AtomicImpl for *const c_void {
>> > > +    type Delta =3D isize;
>> > > +}
>> >=20
>> > Are all users of this guarded with CONFIG_ARCH_SUPPORTS_ATOMIC_RMW as
>> > well? Or do we want (need?) to cover the
>>=20
>> No, the users don't need to guard with CONFIG_ARCH_SUPPORTS_ATOMIC_RMW,
>> the purpose of this #[cfg] is to avoid surprise that when
>> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dn arch supports Rust, when that happen=
s,
>> we need to add the support to the helpers of i8/i16/ptr.
>>=20
>
> Hmm... I guess at this moment, I probably should do
>
> #[cfg(not(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW))]
> static_assert!(false,
>                "Support of architectures that don't have native atomic ne=
eds to implement helpers in atomic_ext.c");
>
> I can add a patch in the next version if it looks good to everyone.

I think this is a great idea!

By the way, did you know about `cfg!` [1]?:

    static_assert!(
        cfg!(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW),
        "Support of architectures that don't have native atomic needs to im=
plement helpers in atomic_ext.c",
    );


[1]: https://doc.rust-lang.org/core/macro.cfg.html

Cheers,
Benno
