Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED13806C9
	for <rcu@vger.kernel.org>; Tue, 10 Mar 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140196; cv=pass; b=HGTQMeC6Z/FxdXu73IlG17F94GOaYjNeUfzPmSpKmeO36Z61wX+115nnMFwoYrvnCw6nBOtWgB8sF3GaEKSwv/W0R0oT0Oq6UXk4VLMcz1LkxRS4/rVyoG2RPgiEwwgDqPS+XSITDSmbhqwR1Zrlp5sMslhGZP20rqACXlgQvBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140196; c=relaxed/simple;
	bh=nL8Tve9qxXBojU4CG3EUAlYMJTfM1E+ZMJp6NeH7Zns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzGjjgJttBBQMYUFotb8oqAIzUqRmn7FtaUCJ3bF8EEgLqswXqro7qzdf8X2arrzSQaT2x+6q+UTU7+AYryRoSLJncqtDYHMmP33FEra2Ot3IWPoBUaZN6XhUKjIR2rL6YhmGtn1Btf1QMrhBwCGDSR1JRtKACGED0+W8pNcf38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBbGtEBR; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBbGtEBR"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2be0f64a05bso497040eec.3
        for <rcu@vger.kernel.org>; Tue, 10 Mar 2026 03:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773140194; cv=none;
        d=google.com; s=arc-20240605;
        b=kjZ6tnCtRGWtCq3aq+LI5tlQgLquwLd/r8QoeNYOxjl6yixLz55SCM3Uo666Q/fmbU
         cnYz/D885dseBylqnKe328TNrgxWNp+xutEYtxI8jt4sxdJ2KaZ6Nmv/qtMNAFZUeZnE
         x8AoD/8z3hYt3GmqcCa1wGJW3e8caDqINp9waOo4yToy+rghUf2VbMhbqYbGRL7SemAR
         vpEzX4AFfh1r9P/UnpBoo0bqS2j5wUQkp4dC6d1eZa+M5OGRYkRtoxWGKZSxRSJIiGnq
         +yrL1TaAKbrJ+SU891ENov3FdO/usnrxAxB36JzkhaU1k/TISmQeuJnGZaLy/ya/nGR0
         oEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4qBpWaqAk74juZmeca9VRmKlmVoYIHqDYNOH37dt7g0=;
        fh=t0BmNaY+df0VprRNH5vZs+y53z8bWYk5oLt71YyCLS4=;
        b=g+lbIHCFe/Cv5u1s9OpZetwe3VoRUL9Z2a2xUc6K/l7+1pRcqDmUwvxPLb5cw4Q9m1
         qV232kFsBG7ZTjgz+9r9v09V5n/KyfH58EpRCh/hweYo3H+IriGHqUjTeR2DK8NgpPc+
         ucYFs5wwKpWFp38XDczbEvmSZS2h7Kl/qCW6WuEitMbAgzRj5wojC03Guft8nIO/S25m
         7eZRR99gFtFJ+sLjWddtu79DbgXc15+cChvNf55o3id2i+bdQdSR2Y0fK3ON71ISv2XR
         j3gzO3DcqBlmxfCI0DpxCORt7Ajfg7iiAUzTPB9P7eqHJlxAZ2acb0JcDme70DXkXbxY
         2a8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773140194; x=1773744994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qBpWaqAk74juZmeca9VRmKlmVoYIHqDYNOH37dt7g0=;
        b=MBbGtEBRBoxPubDO7aR6dBNxnj1NeX5HfI/2iP8Lzp9seSiN+tybz+fCRUtGLW5x5H
         Dk4DqYa2NIr6W29OV7/5WrHN0FEJ0+ScFhbkZQJ4OBIDWeIUWzj5869zWBkvAx1laXES
         Udu4UtFP+aCcp5tqTGuMUR8kxmr0FTGzsSlplMqaY0hCenwPTPwkdVVfNjLo+2nmkSeb
         ZLZA0ovPwmjNnfImTXGvS4gMKe4x5tYPKrZqYjvhXgCHtOZOaqyl0J7nwehmYLSwCQiN
         4RvcjhTehRXfc9XMyLghddQw5UZF09s2CvUvSITa7ja7/9lOwh6jaZeNRFPG6ODik9Ho
         PR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773140194; x=1773744994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4qBpWaqAk74juZmeca9VRmKlmVoYIHqDYNOH37dt7g0=;
        b=ts+yvitEPTdXA60ZO5vm1TiDdJwj/i7fmwJHMmHOs/S1j+Ivoz/cpA0RG4n7xmkf9p
         pFYVLbq4axaEuLDPPiDmhhgvqtpZfUQLr4YjXRBG8YiPzB3ImYO83N1OJI2X8KZ2yfkL
         7VwL+l5R1LMR8SzbRusEWbd+9hj1+gAc4ylWJWU1ogoD6StuhXZC+t4zZ1scLoZ1Skg7
         G2bXA97bQMRvzQr1xbNKFKqnmgAWftF6BNQiwktCt0YhzLuugOE6f2ozAaIShSj7eINo
         kNMWKg43vHL5NJaJ9Aevg5xSFFpgm1XhkoOZCjJ2upChGFLyBf/kfs1cz534ktrbQqMm
         VLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHSe5PsXuzph3FX6d9sGvhkCfZCFvaBjwbFLPE78LSc2IdKGes/fxL0BcYssCrojHCAE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfDN+DkqRbFkCVmD7SkEUxfL+ShV9v7Xuln+4n6sA8Owg6r/b
	RDXqBtt+b7rf4q/H2NKe0x7YDuClcQanqs4LswOcRENTdDShqVbXFHjHz6lYmW/ACX27nyql/w0
	lCmmznALlmYuyNBBkfZ9ZroeNP0xUeAw=
X-Gm-Gg: ATEYQzwOAS/1ipilg5EenUyh2Iil+dtH2feYu+9tj+HB3W7JYPaqHRDKyDNnyKImWp6
	UzeIRDaVNxIvvVoWZoVOTrp7dCGT0CF1nvuq0WHVPEG0RpPzgWtLqTjMjO363kgI+lbXSny/QzP
	W9ygYxKLQPhbVy8KfWlv8a0i7cBTHfoDKrmYCNhBYunZ7xyO6X526dc8i76rwEYcY56SDMIyQvA
	rnCH+0pODTCfLX5uTAmf6A43IbgMDoQBEVqHM72hxPz5LI5TupTQ1n55AIm5wWdaD4U4bEB32M6
	i4xHUF3TfKtv4n0bVbndx+TpRdY38+Xubm2rzDAx/QBjtSH5ucn6Su713WZyp5IdO65nTdTImXB
	eJlmi9ZqYWlsDDvuRUM3MI/k=
X-Received: by 2002:a05:7300:ef97:b0:2bd:bc33:ca32 with SMTP id
 5a478bee46e88-2be4e09ebfdmr2731651eec.4.1773140194353; Tue, 10 Mar 2026
 03:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Mar 2026 11:56:22 +0100
X-Gm-Features: AaiRm523FMnYeZ1Cbp2n7uyCKjNSK8gDXCio5_BkegPeyUfSKYibfT47XJIo0_0
Message-ID: <CANiq72mT2-8m71NtnodVXVBRkhUSiK3Byq5OkBntEQpW9hbU6w@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] Allow inlining C helpers into Rust when using LTO
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Peter Zijlstra <peterz@infradead.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-pwm@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Mitchell Levy <levymitchell0@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, linux-usb@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 1:42=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
>       rust: clk: add __rust_helper to helpers
>       rust: jump_label: add __rust_helper to helpers

Applied these to `rust-next` -- thanks everyone!

With these, the series is complete.

Cheers,
Miguel
