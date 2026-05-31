Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D72D9787;
	Sun, 31 May 2026 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780254680; cv=none; b=TluLXbEYm114d1FwxdpGYJFvB1M6jVKUhiOM7xmkayV/G+m+mVrF6KOQL5MgH0BNTF6EFgbXgl8SzlbvsUTpVSqVeTqPYnv2cK94w/6IMsQjw7E/7YIyt4IWbm+w/tPE024aZ8+XhzBuurfiMpO02Ni1h7Fi7oum8c4CcuDuULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780254680; c=relaxed/simple;
	bh=UKRJQc8YqVMTgJsPDJNd00kFseYjS/8ANLRWDlzvXzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sg8CVlIsWDtQpjSo1gHr4L3e11Clr+DTBa4w/yl9dB7C/ahG4kKal2gCyN++x0oniLNBjs9I+d6I8rpOeaJf5Jpvchk14oCpAvZPZMPhXE3FS+THj3EvlzDDeB9UK7SOf9j5zCEvyIZl0oYkrF4psNp8m4bBMQUkTmleujYS+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Y/1oyPGT; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Y/1oyPGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780254674; x=1780513874;
	bh=UKRJQc8YqVMTgJsPDJNd00kFseYjS/8ANLRWDlzvXzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Y/1oyPGTkcPwb2E3eCBr640dIEdACcl75Ywlm6zC2C6Mz9kCFnx9xb84Ryv6+Yap6
	 wfkYAdFEy1D/a0eVg5bNsjW55BawxETDiJVs+aLm1Whffq1Uiz1ycAuN1Onfzp4GYJ
	 zFV/poip5Dk2DAb0dwTrNF49/TzSYhw829rxTfYeVHGjE2iFBzUREXwXYjfdaV2X/c
	 ypk+KdpkHD+C0iyYLE9Q7heHdbBgPpr4d9OVhrmdAmWGCl0JfjDAah5YA8cANadDPZ
	 MY+4etYNU2nhuQYHdmMD8/Yn+w//y5rMX7XkObRRukh7qu1iQtXM2x5Q1sq6H+m+nl
	 EC7w5NZaeJIFw==
X-Pm-Submission-Id: 4gT6Bj3Xrfz1DF70
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: paulmck@kernel.org,
	Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	fujita.tomonori@gmail.com,
	tamird@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
Date: Sun, 31 May 2026 22:11:04 +0300
Message-ID: <20260531191107.35357-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <CANiq72=jVHEu5veW_k9B66avYgVR2aHDN2QmDny=j4EK2uRXbw@mail.gmail.com>
References: <20260528062810.256212-1-work@onurozkan.dev> <20260528062810.256212-4-work@onurozkan.dev> <20260528082025.44414-1-work@onurozkan.dev> <20260528083518.66203-1-work@onurozkan.dev> <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net> <b4f6d3e8-3a08-409e-89ae-ba5d612bae30@paulmck-laptop> <20260530062730.38077-1-work@onurozkan.dev> <3ef86db1-edc4-4e50-8614-2dd7270540b4@paulmck-laptop> <CANiq72=jVHEu5veW_k9B66avYgVR2aHDN2QmDny=j4EK2uRXbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 May 2026 20:53:07 +0200=0D
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:=0D
=0D
> On Sun, May 31, 2026 at 8:06=E2=80=AFPM Paul E. McKenney <paulmck@kernel.=
org> wrote:=0D
> >=0D
> > Is there a Rust-language counterpart to checkpatch.pl that could warn=0D
> > when it sees patches adding calls to this function?=0D
> =0D
> We had some patches for proposed Rust checks for `checkpatch.pl`, so=0D
> it could be there (there was also a proposed `rust_checkpatch.pl`).=0D
> =0D
> Having said that, Clippy's `disallowed_methods` is likely better=0D
> (modulo bugs), and we already have a couple entries on it (please see=0D
> `.clippy.toml` in the root). So I would suggest that first.=0D
> =0D
> There is also Klint if something more custom/complex is needed.=0D
> =0D
=0D
I am waiting for the v9 [1] reviews. If we get a complain on the current=0D
approach we can consider the Rust-specific clean-up C function +=0D
disallowed_methods from Clippy.=0D
=0D
Thanks,=0D
Onur=0D
=0D
[1]: https://lore.kernel.org/all/20260529134004.396743-1-work@onurozkan.dev=
=0D
=0D
> Cheers,=0D
> Miguel=0D
