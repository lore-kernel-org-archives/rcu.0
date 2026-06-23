Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A86B3AC0C0;
	Tue, 23 Jun 2026 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194982; cv=none; b=QRzEpaqdzlxjA1kBIuoh8SjxMrkTlT0abO2urDdPMPUds9C9HvbylCiZYCNcUZhW3m+QMv+Nm3WC6dPo4lxQO9iC2HbJ7qjdmcI6FvThlfx1tfQIncvYB1yRlUOnwPZDxPMEzpTz90msfOFheaoVFagXNhTyNgjBdJEkU2yL9SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194982; c=relaxed/simple;
	bh=y2U9hlwGDE8g868dOUzfECLQ21oGjnvl2CntIAIb2xA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBqVkWSWAqOMCSPW9lCk4wUlM/3MkC8BQmDHl/4AYpOFHTOUtXMyFCyq3fA+MlGee00OknNlyQEiaWjJtj7rR3I5dxOY6FKIoBKD39Dpf/nrltlYO8BqKv0B3JhdXhPGq76AhC1VPtJfEciyod6S5glKRksKUhpzbJmAoCHGx2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=olYNGjPr; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="olYNGjPr"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gkvm94pZRz9srX;
	Tue, 23 Jun 2026 08:09:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782194969; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2U9hlwGDE8g868dOUzfECLQ21oGjnvl2CntIAIb2xA=;
	b=olYNGjPr3WgngqzLWCmzJ/kvsrBGfNxQBQr0nQiRvXm6knNcrCQNXWYyE/H/PNHh2nyAuY
	yPsfdVBBMONHBxTytTvJX3f3/RGwrPp3RVZ0vEsvulKdZTyTM4MESbB2juoGl4FS0X+3ui
	NVWQiy1uYhy8D6HkNlfPmoXxx4OXNX0Drpwol+PaWAd9idx9rB1eU7/ZaGaMaa7Bo9YTHa
	hev6NnNFtF5n0cS5rKR67KszJ9Fp7KJorNbD+Hd73S4x7q82MflSInr9+cOR95ZKwuFmAj
	iavFu1zURKYtBV4n5ZQQ/i9HYdm0hee+tXQTCrrFrKLxUORsmumw3MgUPhBP0w==
Message-ID: <cf185852a6a28287012154c1ba3823614498177e.camel@mailbox.org>
Subject: Re: [PATCH v2 1/3] rust: sync: Add abstraction for synchronize_rcu()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lyude Paul
 <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay	
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt	 <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Christian Schrefl	
 <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 rcu@vger.kernel.org
Date: Tue, 23 Jun 2026 08:09:21 +0200
In-Reply-To: <DJFSV0OS9NEG.G9W8K1OHQ8D5@kernel.org>
References: <20260622173250.411377-2-phasta@kernel.org>
	 <20260622173250.411377-3-phasta@kernel.org>
	 <DJFSV0OS9NEG.G9W8K1OHQ8D5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: cab6a483726621c2f00
X-MBO-RS-META: goahc39jr7no9x3447cqfsypt7omewgw

On Mon, 2026-06-22 at 20:46 +0200, Danilo Krummrich wrote:
> On Mon Jun 22, 2026 at 7:32 PM CEST, Philipp Stanner wrote:
> > +/// Wait for one RCU grace period.
> > +///
> > +/// You typically do this to wait for everyone holding a [`Guard`].
>=20
> NIT: "typically" reads a bit as if there were other reasons to call
> synchronize_rcu() than to wait for all concurrent RCU read side critical
> sections.

The reason I wrote "typically" is because my mind had the potential
future use-case of ours prefetched where we might have to do a
synchronize_rcu() to wait for a C backend to be done with something,
where no one really holds a Rust `Guard` (though of course the read
lock).

>=20
> Also, while it's implicit, it might still be worth to explicitly call out=
 that
> this means concurrently held Guard objects (concurrent read side critical
> sections), i.e. subsequent read side critical sections may still run
> concurrently.

That's quite generic RCU knowledge IMO. I'm not sure to what degree one
wants to document RCU in general at this new function here, vs just the
Rust API.


Rewording the documentation is fine by me, but since we're in a nitty
domain here I would then ask you to provide a few draft sentences that
would satisfy your basic requirements.


P.

>=20
> > +#[inline]
> > +pub fn synchronize_rcu() {
> > +=C2=A0=C2=A0=C2=A0 // SAFETY: `synchronize_rcu()` is always safe to be=
 called. It just waits for a grace period.
> > +=C2=A0=C2=A0=C2=A0 unsafe { bindings::synchronize_rcu() };
> > +}
> > --=20
> > 2.54.0
