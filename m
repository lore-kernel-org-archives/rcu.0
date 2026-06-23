Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8751367B8A;
	Tue, 23 Jun 2026 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208153; cv=none; b=r9kRGV5ZauvFFFiRlNDSAFnltv2hkUGUJYTr7O3gXNnLi1ZBSHKHaWhX+n0lbXJGCXGHYa+HEJCof3WOsotW0IUfX0QXNiK5VUpqRjQWzP1XMS7f9hAaA8xwiZ+DISwRSmH1dcGNJpCTboKx/yLOtbjqDTklG09QoVoBgE/ngtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208153; c=relaxed/simple;
	bh=myHlpcVxrje/4LogYH81Ir3neHlcOUHx7Cq5HKiPvoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R+A7Qcn3MnbfLc+PP1/zxIN5Gsd+P3CdVx2VhRevxxfwupWOnxQI06VIhrF7fmUMAf22OpYBXSHuT9619jYwNYdcSsXf/CcUNxWkAkozIdLGPK9s5GWiASJ2W89xKp8rCbp4OKdi3vL47QYQaQvqFksOEoX99Qf20KuQBGrN9kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yplXKjHQ; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yplXKjHQ"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gl0dT19JHz9v0J;
	Tue, 23 Jun 2026 11:49:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782208141; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myHlpcVxrje/4LogYH81Ir3neHlcOUHx7Cq5HKiPvoo=;
	b=yplXKjHQ2VZwlE7gs0Cme6obvZk+1MOY0dMydr0mkUYtKJIUYXMW2q0C2DY9VCZ0FbrDjq
	CBXUolVF13Grpx7cAhNCF4KwLJe/Y4+yf4Jf22d9rbvlQw06rZ6BJI1dHY5WTh5dznsPUc
	WMTN/gRipuQb/cw90+Evmk9DrdMneJl9uGC69Ar5ccLiwWUZN25EY6l61H8ovritF+szoz
	O+UPhPouCIyYF5tUr44JqNZ6urmQBN8g2cOh/+GnFk5YkcKe5vUuJ6VGxB9scwk5kUoj/+
	Oe/FVJTnI7BIjAM0zepFouwbUO+0hZtIMmpxuzM1s0vcTmwi0IcEoEwVeZYUXQ==
Message-ID: <908762cb7fd90df1df70eda28363a0015c404527.camel@mailbox.org>
Subject: Re: [PATCH v2 1/3] rust: sync: Add abstraction for synchronize_rcu()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Pedro Falcato <pfalcato@suse.de>, Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
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
Date: Tue, 23 Jun 2026 11:48:50 +0200
In-Reply-To: <ajpJmjTST-Hoxutb@pedro-suse.lan>
References: <20260622173250.411377-2-phasta@kernel.org>
	 <20260622173250.411377-3-phasta@kernel.org>
	 <ajpJmjTST-Hoxutb@pedro-suse.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: f00e168481f30d97e01
X-MBO-RS-META: gr93mh3f3t88hakhgorj5p61kskyjdbu

On Tue, 2026-06-23 at 09:56 +0100, Pedro Falcato wrote:
> On Mon, Jun 22, 2026 at 07:32:49PM +0200, Philipp Stanner wrote:
> > synchronize_rcu() is a frequently used C function which is always safe
> > to be called.
> >=20
> > Add a safe abstraction for synchronize_rcu().
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0rust/kernel/sync/rcu.rs | 9 +++++++++
> > =C2=A01 file changed, 9 insertions(+)
> >=20
> > diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> > index a32bef6e490b..0d438ef31766 100644
> > --- a/rust/kernel/sync/rcu.rs
> > +++ b/rust/kernel/sync/rcu.rs
> > @@ -50,3 +50,12 @@ fn drop(&mut self) {
> > =C2=A0pub fn read_lock() -> Guard {
> > =C2=A0=C2=A0=C2=A0=C2=A0 Guard::new()
> > =C2=A0}
> > +
> > +/// Wait for one RCU grace period.
> > +///
> > +/// You typically do this to wait for everyone holding a [`Guard`].
> > +#[inline]
> > +pub fn synchronize_rcu() {
> > +=C2=A0=C2=A0=C2=A0 // SAFETY: `synchronize_rcu()` is always safe to be=
 called. It just waits for a grace period.
>=20
> Commething randomly here (I know as much rust as the next not-knowing-rus=
t-guy, sadly),
> but synchronize_rcu() is not always safe to be called. You cannot call it=
 if
> you have the rcu read lock, or cannot sleep for any reason. I don't know =
if
> you can encode these in the rust type system though.

Preventing illegal actions in atomic context seems very difficult to
achieve in Rust and AFAIK the only viable path forward currently is to
have klint check for rule violations. Gary is working on that.

But it would be interesting to know more about how in general Rust's
unsafe comments are related to problems beyond UAF issues, and to what
degree we want to document context requirements.

C documents functions like synchronize_rcu() in much detail, but its
documentation trusts on the readers general familiarity with RCU,
assuming no one would come up with the idea of calling
synchronize_rcu() in an atomic context.


P.
