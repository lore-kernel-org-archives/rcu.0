Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD28F49;
	Fri, 19 Jun 2026 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852168; cv=none; b=Y+G/2OmhBLZRAcVt3aPectd8Wp8GbqGVMdI+nuTkqBpQ+xlxkm7MLnnhEOF/ikG3IsgBLWV+pJ6rBbCXy2eVgvTznf7M8AZKVkegczMOth3NZOODUzcbY2lEjNkDTdHf5TI3BxBh8jgQWnXErLlhdE05Wl31HWjBlJUlaxuPgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852168; c=relaxed/simple;
	bh=rnMwtPFZnLUO11a+g60kO7gTwd4Qi44HIG83dTASAoE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aFjnLMEjRCpKadwz9SAT0Bnig2d/YRrYzAORiJLmUXjv9xtZ8HpjohNQZSa3hYYARJA1AntCqOd4mvv2EZYGMbequYyUWyVQFfJ2bB6ixVdyE/ew/pkz+Htu0WIfX+q3L87fXbceBNylIFGlS/zPyBIoYm5Z7m5Fpf9eMbbi6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qREpy7H+; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qREpy7H+"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ghSzc4Fs0z9ts2;
	Fri, 19 Jun 2026 08:55:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781852156; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnMwtPFZnLUO11a+g60kO7gTwd4Qi44HIG83dTASAoE=;
	b=qREpy7H+srfkUlKmgnvmZLwwzsua7BHkTyYbHhtmNgqNiI5JRiPmvGB2fZFL2nkERatEgD
	7HNBx4Qls48PQ+JqnoGF/h0BeltpcBcCXGmoLrl04tEjLw9dCiviaBMNBXFGMheBEgiqYJ
	3cGdwbRf0vF+0Ag4qt85y52MKQTiEfLbU0uY6NkjlV6qLanYAoXR5bPQYTzOrk3EfCP/D0
	T5bdf+oHGpodOnoK7Q3viwlFguwKSfU61xxHYMdnT2SaxI75yHro5Piq7hPqUuAPUqA8BJ
	+VSliA+VDby4g1S9T8lFMWdLpkf9xMgmysJlStIL6txCrtaTIcBcTyPiNkuhaA==
Message-ID: <c449f26e2283a2df6d5240879f85bee1b2fd4c50.camel@mailbox.org>
Subject: Re: [PATCH 3/3] rust: sync: Use safe synchronize_rcu() abstraction
 in poll
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Philipp Stanner
	 <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner	 <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Lyude Paul <lyude@redhat.com>,  "Paul E. McKenney"
	 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett	 <josh@joshtriplett.org>, Uladzislau
 Rezki <urezki@gmail.com>, Steven Rostedt	 <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,  Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, Christian Schrefl
	 <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 rcu@vger.kernel.org
Date: Fri, 19 Jun 2026 08:55:44 +0200
In-Reply-To: <20260618181142.200117-1-work@onurozkan.dev>
References: <20260618095952.3687099-1-phasta@kernel.org>
	 <20260618095952.3687099-4-phasta@kernel.org>
	 <20260618181142.200117-1-work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 329e3f9f6774554fee3
X-MBO-RS-META: 5849hp6ni6h4tycs7cw57pyxmz7igp8t

On Thu, 2026-06-18 at 21:11 +0300, Onur =C3=96zkan wrote:
> On Thu, 18 Jun 2026 11:59:52 +0200
> Philipp Stanner <phasta@kernel.org> wrote:
>=20
> > We now have a safe wrapper for the foreign function synchronize_rcu().
> >=20
> > Use it in poll.rs.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0rust/kernel/sync/poll.rs | 6 ++----
> > =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
> > index 0ec985d560c8..401cf4d3f35f 100644
> > --- a/rust/kernel/sync/poll.rs
> > +++ b/rust/kernel/sync/poll.rs
> > @@ -8,7 +8,7 @@
> > =C2=A0=C2=A0=C2=A0=C2=A0 bindings,
> > =C2=A0=C2=A0=C2=A0=C2=A0 fs::File,
> > =C2=A0=C2=A0=C2=A0=C2=A0 prelude::*,
> > -=C2=A0=C2=A0=C2=A0 sync::{CondVar, LockClassKey},
> > +=C2=A0=C2=A0=C2=A0 sync::{rcu::synchronize_rcu, CondVar, LockClassKey}=
,
>=20
> nit: Missing vertical import. Same in the other module as well.

Was already like that when I came here ;)

But if it helps I can format it while I'm at it..


P.
