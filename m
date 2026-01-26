Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1B222565
	for <rcu@vger.kernel.org>; Mon, 26 Jan 2026 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769404101; cv=pass; b=uRHyQUY6oMOlBQksSyOStyW5w1ua8CuvBz6YmuOJwg8GAq91jiTuLQS1GxuM2NSdKqbVBJ6jYN3vZA+c3gpUVa3BbUVl6l4FUQix2Mk2ubde3wKUTGqkXvbfbsWd2bIxp2YUwek2JRPqnBO/e7ukM1pbajYFsSxl5twASQi/Euw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769404101; c=relaxed/simple;
	bh=ZBsVD6kxKzurT7H7DtCLfcoGufza6/gI7cdcVlj4q0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCMcHDxUuHya2oRNvS3gWURscMwGHN7+Zq7lHo8RNBwZotIKGSxq0LkC3zbEZblwZW90vkhQd3pUd1lQzUA9OCh1cQp1dRJUI1qydovtOIaxiskmwbrAiNGP3ZxYWq11mYbWClx6aaVIjYSI6lHMf2RYWqwlMnBf2yAhZW7pqAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9kfJBC+; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9kfJBC+"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b1769fda0eso431215eec.3
        for <rcu@vger.kernel.org>; Sun, 25 Jan 2026 21:08:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769404098; cv=none;
        d=google.com; s=arc-20240605;
        b=cCIWwV0UV/d6EtognccQhjci9A55fYhfcuV6y81zmWcyCJtga+w+PDIJvW/MMqjzvZ
         /lGM6ThHorX2fXh+3T5PAqs4C/gaP7zpQllyFPEHdWPvnUg7fOtiOR1YcRRAOtmv5Gi2
         lOG1ui4IgscJeUdzS4zcjArUmNmN3XAnEnupW5FcqYNeQE4rOb9Z0St60Gtp5tgahaIq
         ugKW5OUOyPdQeK5EQyOTOTP21aKGmDl/3NeyPqNuh4Cb887ZOjIHGsMtXAfMn15hDcCx
         uGxmvzZgzwRsDGH9kPPA4PUVNEbviN8fH4YPHW401Yxd1zYJc/NE8mgpTq0PNJ0qeuKB
         sXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bsbA3S4vvXnWg6PVwhDAv4/t5NunrqZ0yk7Z9wsyNZU=;
        fh=TZznE91+hlu0ST+EesrAREtSgsAie5KXCkoiAhEe9j0=;
        b=efyzbwrCWx0oXBuf8KJNtfAxf6JrGm4LP0XpWXIb7ExxaCiW2khZYoayM83TAgDXh5
         uauqnLsflAxh5SfbwuGXDiDtMZZkr+a7P0CcbFu5KnTU2un4lvbI/SO1enCvClm30uqA
         +KzQ7S+vHIkeWgKyzKtW2iFbzuOniP2kohhneeXfNrZZBn4vV7ftMaQgYAk7nfD+DkZE
         Zfc0uktHYYUi4+KxtPcNquiUVakH/3/eQ1kCZV8sboWONMK1fjAqY/WUv5b1gW0XWQ/k
         g6H68NFRBKuURut0/YPcNq03awBEKXY59PM03Oicv8SDl2O9yQElpaz8TxRiyqjNm9R+
         C9/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769404098; x=1770008898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsbA3S4vvXnWg6PVwhDAv4/t5NunrqZ0yk7Z9wsyNZU=;
        b=k9kfJBC+ldCHGEir2hpwOAhElO6egoRCIxzj0IKfTEqmro2/yY4nV/+ZWVpPnASaL2
         +mKMYxEvPEWQ3mA0MifDdWsjJxAV9WDFd60bga1tQmEuwjCMbcYXGnmdKnOy0gkl2ch2
         Mwj8Ks7ue/Tv0fi0t1I2FGHTzLLGzLT7EpWkOR1/bqd5u34W9Lgxxo6NypTHOKYsnB2Z
         KCh6L7ducVKh/8PXfUb+iHCyyPnIdAB5ON83DnVEVnBfpqvtvEurIJrSHBLvIkSub/iU
         dCIDy2cliqsDj+61/J2ss/bUZVs3zCGOy2Q26lc2sW5MOSWlOjMrzV8iWQUqiUi0YrGB
         4lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769404098; x=1770008898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bsbA3S4vvXnWg6PVwhDAv4/t5NunrqZ0yk7Z9wsyNZU=;
        b=GqnOF/jHX7rkalmc/4HLhU1b2JgneVT1XZIOwF7SrWuxJ4DFWJjFxIMT7YPGA7tAc2
         zu/JKRsnKYMETTdqanmaHzOAp+sjaId3SXC7HbDk3ht7DmYBLNfFQ3e7+zck66xMIeoZ
         qECj3fineLEP+LgO7qhJyzYhnekaICkWyWDMF7Kg/2fVMq0ISI5QIACMSQZryW1RcT4z
         8pbPJTz2WI7VoNYqN9z6WoBc7Mw8xXs0lC/Yw3YDIur7S1YJVyXcFJ28oYVTITeoQQf1
         2qgW//1ul8610JG66ytS5f0GHq30loLbUHy5TISBb3URCCUvkHkfnVM6zq2dGrYYwqXQ
         LqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuNFlgqdCg7ypueYVh1PdltdGvGUpTh71Ocq4baTuUt61JhNadb4lKu8lOrguUh620Gdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVfhRx5lrwfY6acpYDYvG4waghAbVRbcoqOtadkNSFrFhIBaex
	YQdd9LfliMptguYcZKVELEUutBEd42XhkeOVxfXeN3XeeiXBmTyFuuxlsgwKgGybMN0/6/5o5g6
	e3mSm/uVTWYOTdGBWO6bp8OuGuO3Ckls=
X-Gm-Gg: AZuq6aL/rDpmAswnDMZpFyZUFvK500BXC/hbF7p4+p4Koa/IZ8uYpboQzHpfeDhJj2W
	QkvhfYSKzXsu0djLndFjQ5pvbLrd2YKURC1SI3DrxFEAVUT1z28WWvwdwJZX3aS+BZE6H9EimZw
	nuW6dGFuTvfGze9lNvRIH0AzYWWacEdyTTa/Hym+3mVyD/cNHonqNPsj5oSmuez3wrfm8i7/28C
	Jpp2MQXzFSIfzITfkcKkSxVFiTpJGzZ4AkgDiTnXMfSzfyHYr155lb6VHhIryXOjdHGuItoIvLl
	YFjoEnb8XYAypSblqzrJ0oY0Kty6O5isnWzCvzgCICDREhe3lVY/H8yyhw3dYbF6pcYhj4Fim6k
	8ZXZUD0dcZOaG
X-Received: by 2002:a05:7301:3d10:b0:2ae:5b8c:324a with SMTP id
 5a478bee46e88-2b7644f41dbmr855051eec.4.1769404098278; Sun, 25 Jan 2026
 21:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Jan 2026 06:08:03 +0100
X-Gm-Features: AZwV_QjC45jcqbNpvCzRgWaUDtcYZvulw1uksmCYv_NCU9WJD69mYzMDZ_yhpJo
Message-ID: <CANiq72m4hBinKM4jRrkpZ5nM_wraQ8FMsYtjgKRkNDmK5sS8dw@mail.gmail.com>
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
>       rust: bug: add __rust_helper to helpers
>       rust: err: add __rust_helper to helpers
>       rust: maple_tree: add __rust_helper to helpers
>       rust: mm: add __rust_helper to helpers
>       rust: of: add __rust_helper to helpers
>       rust: rbtree: add __rust_helper to helpers
>       rust: slab: add __rust_helper to helpers
>       rust: uaccess: add __rust_helper to helpers
>       rust: workqueue: add __rust_helper to helpers

Applied these to `rust-next` -- thanks everyone!

If someone did not intend for me to take it even if the Acked-by is
there (e.g. perhaps Andrew wanted to pick those nevertheless?), then
please shout.

With this, and if I didn't miss any message (plus looking at
linux-next where I see Greg picked usb), then only clk and jump_label
remain (plus any new incoming one).

Let's see if we can get them done next cycle then.

Cheers,
Miguel
