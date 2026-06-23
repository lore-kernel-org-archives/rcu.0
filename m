Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5A3D1CCA;
	Tue, 23 Jun 2026 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212652; cv=none; b=Tc+8EYcQDwF2qilHdZ+IjhU3sI2O6CWcEnkpnACepICKSSbi0Ef58rSxTQEfLymYiFgTh8FX5dUKQ2kS501Rxz2f09le47Y2o5q9HGUBTuk17+KXj7MbVC3mdrFxJfiyxkTYxDsSaHgzSQFDxeo4+NyYUEmrsZ2ATCfr94z8ILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212652; c=relaxed/simple;
	bh=TkGRx6cKET5CaXEEJ9SPtLz5Ws0gbttQWauWzqhGA2Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=iPdGfjIU6VkEywxYoEiz+1Kp9kbCqBOxC7WjvrJiEcdmHsQVoXfgO6sy1s0pWH6wgsr9dDNWvYJUhPrLXm2lnZejxB9c+rMUIWz7Y0XdAPiXKPqQATVFT2xjvElmusgTt96CdisXgLEfQxRXRqQOXL4J40pH2nqnbBUMkD5uZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODlmXOmc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODlmXOmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EAD1F000E9;
	Tue, 23 Jun 2026 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782212650;
	bh=OSYgSga/i+pSM8InQLThNq0tTer63q61mB7clX4esxY=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=ODlmXOmcLsMg84jq24n5cRL2vMLDwD3yImpQ1uOu0E9fUR1EJw551k/RsKiYA908G
	 YcDcp6LOUNa1sDt1FYXRPlz+KTUrDxdr6vy85USvHV+xyw/LrBoQbK+B9ZVlUIerrz
	 fCP+JR5J22FlhVqNsUuoVqay/sqzxXO5Ju3Qujcf488pMn+uOiRfw5k1h5ao62kM4V
	 pV39Jiarx1wqMpFBzPjIwUXOt+tF0fU+n5Hb4XOJSgI6W61f86ZpXVBEYSMKx3farg
	 1L2chTBXVCedQJ5v9MDmLFxr1AsmdY3qLHsXR282j0NvKwvfS2/X+gJh91d7TroeeN
	 EC9KLmttHFQlQ==
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 13:04:03 +0200
Message-Id: <DJGDNLFBZNI8.QMS435A1U37R@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/3] rust: sync: Add abstraction for
 synchronize_rcu()
Cc: <phasta@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Lyude Paul" <lyude@redhat.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Josh Triplett" <josh@joshtriplett.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Christian Schrefl"
 <chrisi.schrefl@gmail.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <rcu@vger.kernel.org>
To: "Philipp Stanner" <phasta@mailbox.org>
References: <20260622173250.411377-2-phasta@kernel.org>
 <20260622173250.411377-3-phasta@kernel.org>
 <DJFSV0OS9NEG.G9W8K1OHQ8D5@kernel.org>
 <cf185852a6a28287012154c1ba3823614498177e.camel@mailbox.org>
In-Reply-To: <cf185852a6a28287012154c1ba3823614498177e.camel@mailbox.org>

On Tue Jun 23, 2026 at 8:09 AM CEST, Philipp Stanner wrote:
> The reason I wrote "typically" is because my mind had the potential
> future use-case of ours prefetched where we might have to do a
> synchronize_rcu() to wait for a C backend to be done with something,
> where no one really holds a Rust `Guard` (though of course the read
> lock).

In that case I'd just say "read side critical section" and then mention the
rcu::Guard type as one way to end up in such.

In comparison with other synchronization primitives, RCU is a global mechan=
ism,
so only talking about the rcu::Guard specifically might indeed be misleadin=
g.

>> Also, while it's implicit, it might still be worth to explicitly call ou=
t that
>> this means concurrently held Guard objects (concurrent read side critica=
l
>> sections), i.e. subsequent read side critical sections may still run
>> concurrently.
>
> That's quite generic RCU knowledge IMO. I'm not sure to what degree one
> wants to document RCU in general at this new function here, vs just the
> Rust API.

One or two precise sentences should be enough; no need to document RCU in
general.

> Rewording the documentation is fine by me, but since we're in a nitty
> domain here I would then ask you to provide a few draft sentences that
> would satisfy your basic requirements.

Should be as simple as adding "in progress", e.g. considering the above:

	This waits for all RCU read-side critical sections already in progress,
	including those established by an [`rcu::Guard`].
=09
	This does not prevent new read-side critical sections from starting;
	those may begin and run while this call blocks.
