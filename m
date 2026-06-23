Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C23D3008;
	Tue, 23 Jun 2026 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212720; cv=none; b=alZuDjQ3oR/0OjizBn7jmZYV6FyjIlOBcRsBkjR9W2yT0OZk9NCkEeRT7q3ndfrV6oPaeAn9AMcmHZIg+QWeMJ/QDvmc1ZJlUlSCjtyzGWD5sJYqKl5D/ghv0hyK6MJ8n4uQJEAHnTLjmnl1L0qybsVQS1szngK7zQImrIawQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212720; c=relaxed/simple;
	bh=DBC0Kik/laXloP5mMrQORNPjKVdZgZybE6gVit3DZf0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCGAjz1zclxGLY1yGfVEoqk4/Kv+TuV+cbqE0PFMIg8Hp7ut0KTruP5CnF/dSq8jfZk8EHc5R4UCaYzh3H+1fLuPgQVPeK8QpwcO/vllN5gIaJqEv3zjatlCo9SULCZhCNHBHtPd3HAGy4qR8vHfUFLqLDdn3buAzrPGHqzzccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yr/tZBxW; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yr/tZBxW"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gl2KK3VsVz9tpB;
	Tue, 23 Jun 2026 13:05:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782212709; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBC0Kik/laXloP5mMrQORNPjKVdZgZybE6gVit3DZf0=;
	b=yr/tZBxWjr3Dd84m3odTOMoUwmgtGxnBy6mb56lCv0RE8x4oZhbcr1wuoR9smHkaha9ndY
	n/duOE2FuSLTQvMvlj/sNVive8bAirU2AWyQTK7kr12QpYuHx3xRAx+YR5khlrmMPc0ZCv
	+AMMbmuEkohdPd7lqPr0zAcqruuhVO1HVUHyv3CLlhOqrDNm558OZJ3+FQ/Da2ttyRFakD
	J76qRQFzWs2JbTcDk0SEPCmis/FEYZ0/A6CQwsFqeWxn1eAu1mXlreeRUK53jdsARQjx1t
	A+bvpQyBLReUtBZVaFlJR7O0v/ZULGi8fQtmVyceXMTQwxa1fOXDgPg+k3fG7Q==
Message-ID: <b94b2ef73d70652fba062331aa902c8f89034d7f.camel@mailbox.org>
Subject: Re: [PATCH v2 1/3] rust: sync: Add abstraction for synchronize_rcu()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, phasta@kernel.org, Gary
 Guo	 <gary@garyguo.net>
Cc: Pedro Falcato <pfalcato@suse.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	 <jack@suse.cz>, Lyude Paul <lyude@redhat.com>, "Paul E. McKenney"	
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett	 <josh@joshtriplett.org>, Uladzislau
 Rezki <urezki@gmail.com>, Steven Rostedt	 <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,  Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Christian Schrefl
	 <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 rcu@vger.kernel.org
Date: Tue, 23 Jun 2026 13:04:59 +0200
In-Reply-To: <CANiq72knGU+PUCXUATOkA7225++0nvALNByoJa8gaV_EuyHx6g@mail.gmail.com>
References: <20260622173250.411377-2-phasta@kernel.org>
	 <20260622173250.411377-3-phasta@kernel.org>
	 <ajpJmjTST-Hoxutb@pedro-suse.lan>
	 <908762cb7fd90df1df70eda28363a0015c404527.camel@mailbox.org>
	 <CANiq72knGU+PUCXUATOkA7225++0nvALNByoJa8gaV_EuyHx6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 1c957bf2e870aef58b0
X-MBO-RS-META: sakb1dze5xik1zdhxeefkjiortrqt9xk

On Tue, 2026-06-23 at 12:24 +0200, Miguel Ojeda wrote:
> On Tue, Jun 23, 2026 at 11:49=E2=80=AFAM Philipp Stanner <phasta@mailbox.=
org> wrote:
> >=20
> > But it would be interesting to know more about how in general Rust's
> > unsafe comments are related to problems beyond UAF issues, and to what
> > degree we want to document context requirements.
>=20
> I am confused by the UAF there. Did you mean UB?
>=20
> Rust's `unsafe` is about way more than just use-after-free -- it is
> about all potential undefined behavior.
>=20
> At the same time, it is not about merely "dangerous" things.
>=20
> If you cannot possibly cause UB, then it is not in scope. Otherwise,
> it is very much in scope and the safety preconditions/requirements
> need to be clearly documented (`# Safety`) or justified (`//
> SAFETY:`).
>=20
> Now, sometimes it may not make a lot of sense to duplicate a ton of
> information, so sometimes we lift text to the Rust module docs and
> refer to it; and sometimes it may also make more sense to refer to
> external docs. One way or another, the goal is to document the
> requirements and what is going on as clearly as possible.

Well, commonly, deadlock is not regarded to be UB.

For RCU the question really is to what extend one wants to have it. The
overall robustness requirement here is definitely for the Rust function
rcu::synchronize_rcu(), since the API caller is the one in charge of
the execution context.

If all potential failures one can cause by calling that function at the
wrong place were regarded to be undefined behavior, then a
synchronize_rcu() Rust function would have to be an unsafe function
always, making a wrapper pointless.

Similarly, Rust's drop() implementations might be potentially "unsafe"
with a hyper-strict definition (note that I'm unsure whether calling
synchronize_rcu() in atomic context is actually even defined behavior;
I think it is. I'm just brainstorming here)

I think briefly documenting the context requirement is fine, but from a
consistency and pragmatism perspective I would not make that a formal
safety requirement.


P.

>=20
> Cheers,
> Miguel
