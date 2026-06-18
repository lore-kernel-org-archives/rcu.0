Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282F37C0EB;
	Thu, 18 Jun 2026 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781782828; cv=none; b=IZym5e3A+xtzmB8u5ld4zyNPbAqDGsgwSrAUHUigEKtYtpl0bang90kFqSECVPStXeEPMkcS3f3c03+jz3dJlCQozIGwwBPlai5QK7FRJY+Y/a8aIOJhAJUqLkd9kzfEkzE0yf7xUqPkZYDczDd6F17zA16RrCx3dkJYbfUfAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781782828; c=relaxed/simple;
	bh=A8rtBmtWshlcmcY1Vqpwg0EZtW2bh3KslsKA5KSWBrQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FQqq4uprLsJZ+kwFXFfbrkNSwvBILSmLVel1nfeDHx2baEZpFXON3Th54bCE/wpZSWqpjO+/HVAlJVTpoCRVzk80eTgd4Bs/Y7rEgdwdKxYLt1hJmpDf2cpqHocMOZsyUNm037igQLgl3TpkdqBDWS7WFhejAIdlXmBmSTaIagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Gj/X7PrN; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Gj/X7PrN"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ggzLG2lCtz9tSP;
	Thu, 18 Jun 2026 13:40:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781782822; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8rtBmtWshlcmcY1Vqpwg0EZtW2bh3KslsKA5KSWBrQ=;
	b=Gj/X7PrNU6EyYrro3L+oJgoixsaQ2Neqbudv00zua6Geht6auHc3ccaQVA+gjV8vF+nniW
	TpIk1yvRGCX7lbJ4+uNIUyM2w9labPzzW8n3NICX6PitNhMon8edjtZ2uAE//e9OwBFxnx
	3I9DuGBKck0uSMdJWzXym2HtALvGwxTMVasQZaD1FOH+KWCgwuHZ7AABT0CwKQAqbsUeIC
	lnQSXjsj7KtY8h9+dvp6QpltuV5pBdPQDOBmEArn+jxaztN6iffKykaKwYe7ICXdb/zxDj
	S2cMp0u/IOETPc3v+LnQppBgU8wf2G+OwbUkVeHZJpnD0AxN4fGE+Rzz2QDZkg==
Message-ID: <15e81f5bf354cbe3cde765526762e4ebb3ef6970.camel@mailbox.org>
Subject: Re: [PATCH 1/3] rust: sync: Add abstraction for synchronize_rcu()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Daniel Almeida	
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=
 <work@onurozkan.dev>, Alexander Viro	 <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara	 <jack@suse.cz>, Lyude Paul
 <lyude@redhat.com>, "Paul E. McKenney"	 <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett	 <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt	 <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Christian Schrefl	
 <chrisi.schrefl@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org
Date: Thu, 18 Jun 2026 13:40:05 +0200
In-Reply-To: <20260618095952.3687099-2-phasta@kernel.org>
References: <20260618095952.3687099-1-phasta@kernel.org>
	 <20260618095952.3687099-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: eu18ycrf7gkspftrdip7ubxxpc8g4ua8
X-MBO-RS-ID: 3b31cc664c5f18c2c1f

On Thu, 2026-06-18 at 11:59 +0200, Philipp Stanner wrote:
> synchronize_rcu() is a frequently used C function which is always safe
> to be called.
>=20
> Add a safe abstraction for synchronize_rcu().
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> =C2=A0rust/kernel/sync/rcu.rs | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> index a32bef6e490b..9b9addf8fedf 100644
> --- a/rust/kernel/sync/rcu.rs
> +++ b/rust/kernel/sync/rcu.rs
> @@ -50,3 +50,11 @@ fn drop(&mut self) {
> =C2=A0pub fn read_lock() -> Guard {
> =C2=A0=C2=A0=C2=A0=C2=A0 Guard::new()
> =C2=A0}
> +
> +/// Wait for one RCU grace period.
> +///
> +/// You typically do this to wait for everyone holding a [`Guard`].
> +pub fn synchronize_rcu() {

Hm, should it actually be #[inline]?

In C nowadays usage of inline is discouraged ("compiler knows better").
Unsure how Rust handles it; is its compiler different?

Moreover, this would be an opportunity to change the naming convention
to rcu::synchronize()

But since Boqun & Alice are pushing for rcu::RcuKBox for the reason
that it seems desirable to explicitly highlight that that's a special
Box, I guess we should be consistent with that and also have "rcu" in
the name here.


P.

> +=C2=A0=C2=A0=C2=A0 // SAFETY: `synchronize_rcu()` is always safe to be c=
alled. It just waits for a grace period.
> +=C2=A0=C2=A0=C2=A0 unsafe { bindings::synchronize_rcu() };
> +}
