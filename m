Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5F34BA50;
	Tue, 23 Jun 2026 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213421; cv=none; b=oHX2a5wRB2nBUtvx2fhKwA0eWFdWFX0VDypTXvrAI3cyKwiudhl2mDRL73EaOhl3AXUPEfxC/0BjoU5sgoAdAJi+Rgjn+TBZwO6RCrQoMcPY+idpEbiRQ9nx6Ve5sEl1gk20js17Dj+yLeIItVRE72AhhfUmrHOlrkVvDlgeJX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213421; c=relaxed/simple;
	bh=+PKArGvkgKV9hQ6UYF3rddykA5jy/ezmBTSvvA0P4Ac=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=E04FwuhByzUJkolVnYUVlN+JDSSRoM5cAL7bbsif3ae9a4RYPr0w5VvvpqLO1ZnP4ruL5myjfLzSJfi08OIRT6CssB2ZXXduCsYGodkBIMfFOgzNCo1LGqCa3Y1a5ilC+/BSjk1P2T7vy0N43cUo23CF8IJmNkFV240gkAnuBBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnoJusIn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnoJusIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA561F000E9;
	Tue, 23 Jun 2026 11:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782213420;
	bh=+PKArGvkgKV9hQ6UYF3rddykA5jy/ezmBTSvvA0P4Ac=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=JnoJusInSLUUqbs7lMQyVsWIUsrz2NkYyE+g0b5TRmbXifE9FDqYu90tXm+l1mnbi
	 NbTOnnnv3s7F/R6x+Xebmyhy2vas+dPJINWJgSWC9ZN6zCdRKDdw3Uhb05EJTTj66M
	 lUJ0RV8Ih95UVLMDAzfgBqKMXB5LQcv8yZfiLjLUqNLe+k409EC3xs76VL2cvtDM+M
	 PSSZ12KeA+Mr+RAIkEdecrkt/gVjIEraWpgIk+GrlEcbJVxxltGy5oCy9RxehVMgYd
	 dy/3GOb7Z7Ky1owlSguXfzJ1q+v1DwTJzDpltIUD5DaHzZ6Sqyly9GqlWLUsWRTLic
	 QHkz2pdHfXWkw==
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 13:16:51 +0200
Message-Id: <DJGDXEJXXWC8.1PT6LZH1ZLGB0@kernel.org>
Subject: Re: [PATCH v2 1/3] rust: sync: Add abstraction for
 synchronize_rcu()
Cc: <phasta@kernel.org>, "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, "Pedro Falcato" <pfalcato@suse.de>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
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
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260622173250.411377-2-phasta@kernel.org>
 <20260622173250.411377-3-phasta@kernel.org>
 <ajpJmjTST-Hoxutb@pedro-suse.lan>
 <908762cb7fd90df1df70eda28363a0015c404527.camel@mailbox.org>
 <CANiq72knGU+PUCXUATOkA7225++0nvALNByoJa8gaV_EuyHx6g@mail.gmail.com>
 <b94b2ef73d70652fba062331aa902c8f89034d7f.camel@mailbox.org>
In-Reply-To: <b94b2ef73d70652fba062331aa902c8f89034d7f.camel@mailbox.org>

On Tue Jun 23, 2026 at 1:04 PM CEST, Philipp Stanner wrote:
> with a hyper-strict definition (note that I'm unsure whether calling
> synchronize_rcu() in atomic context is actually even defined behavior;
> I think it is. I'm just brainstorming here)

From the Rust side of things this is well defined; please see [1] and [2].

However, given the kernel context, things such as deadlocks have more
consequences than in userspace. Which is why it is still desirable to catch=
 them
(e.g. with tools like klint).

[1] https://doc.rust-lang.org/reference/behavior-considered-undefined.html
[2] https://doc.rust-lang.org/reference/behavior-not-considered-unsafe.html
