Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BDA3955F6
	for <rcu@vger.kernel.org>; Mon,  1 Jun 2026 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307171; cv=none; b=KgZzfwUJVLB1nKwBV7vXTSIWEAFiaqyAKyZUEIzLCL1XqzLR7wkgg9WADhAwIlbWr9B3RYKvS0Q0fmisVZiT1q5pcatC4eFnG6cP35c2BE48FDhdpFwhLW90sDUeaPHCmIUe20944MzHu60iDf9B749qnysVHRlRokThxnPhb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307171; c=relaxed/simple;
	bh=cV18jvtNXIodO6tysPsBXW0X3xVvWrtNzux1ufx6488=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FmiTAHIuAUrC1U7DC1Red8e4uv9W5ipvViK+uEJnBlSTDw+xOnu1A7YgeaFLfsh1ms3P6q3YOnVqCG4msAma3RAy3BV8k0AB32pYNs0vae3EqPgR1DS3wSh1jYVdNevTFxD+KtU3q/dgj4QcFyL2PMO5zKdWahWweOfAz4tbuKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Df+gsVdw; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Df+gsVdw"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-68b3e28267dso3233223a12.3
        for <rcu@vger.kernel.org>; Mon, 01 Jun 2026 02:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780307162; x=1780911962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F2mLiP05KImuXhLYRlm3itUuIPBG7j9sX+uByjRaID4=;
        b=Df+gsVdwnaFnn3ZIHTyclLRbocaC0Vij9gUEXBbEsqwia8hx88vkEF6PrH925lg2F4
         TNkNWB+rjEQ85OPUwZMIbeilLRRRm14mpIG9XQimhC4/GyBjiJxX1Aq6e0IjJGdhoaXQ
         9RuaIevv3hHB2IozWJsYLF11si7iA7x1zS18ujoIoDAfzCEcwxt9UKFWEJEq36f/xzuH
         Unqlf+CvnkFLsRaKk4qu5Lw1T7bUOU/kOBwZ4Po9HiGaTEte9T1rFXm4IUUrcTFF0/NX
         r1QWy5Y/KUoYfUZcBqBlklb8mSemf/5OM6lWVqyNBvGgO0aFoiVE8tLrjCFBVdF1Ijei
         PGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307162; x=1780911962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2mLiP05KImuXhLYRlm3itUuIPBG7j9sX+uByjRaID4=;
        b=XPdCA2XtVWQXGGiawdb/Q08C9eESgLLTKcJcVthilteO3JxoKHpurBS46x6/NrU/He
         qINPKYLPZGiVWRHxDb7hTNg2qmaFCbt/Xnh4W2kZsJznoG2gqqeW2j76sf0HuPPE/A/j
         F/9WWqSF+CEBvZ1jzyEo1O7fkcjbcIyP/WGMk6IOMU3qqUwgwmFs/+cm7iYwxuLzKq+p
         zo9sCxZ2KOEbvHquzqS4ivZi9Yy3QiR5yZT2w9oalXDCIIQUfQFYqG9Fv7PP4D7eMhXp
         KtAhAF9V1jBKdY+i7DD42n1f/VYW8JWU6zM2BLjOuZVHNUk2KNnkgz64XUJy9NQr5r+Z
         k90A==
X-Forwarded-Encrypted: i=1; AFNElJ9OfW4hSmRAkechnUtwimNDoCcSz9+GF6h6ShZG08YG0e//sG6IfJmwnP33B4h7g6KytNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25to3b6VszC/6tDySjOwiJbwLRERMeCPwgVGLPO0jLVBiHdUP
	ZhVUA1YE3LmIShSAIFRgqpv8ZHOs6Kg7QS7MFIWzugb4IKSLNi8CPdPZ+2xs9tz1dd8eK+xOtvQ
	dtxp7l4CQpvRwRKXaKA==
X-Received: from ejcmy11.prod.google.com ([2002:a17:906:5a4b:b0:beb:3773:86c7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:e158:b0:beb:7979:47dd with SMTP id a640c23a62f3a-beb797959f7mr242224566b.27.1780307161830;
 Mon, 01 Jun 2026 02:46:01 -0700 (PDT)
Date: Mon, 1 Jun 2026 09:46:00 +0000
In-Reply-To: <20260530143541.229628-3-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530143541.229628-2-phasta@kernel.org> <20260530143541.229628-3-phasta@kernel.org>
Message-ID: <ah1U2P8ppTjprYwR@google.com>
Subject: Re: [PATCH 1/4] rust: types: implement ForeignOwnable for ARef<T>
From: Alice Ryhl <aliceryhl@google.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Igor Korotin <igor.korotin@linux.dev>, 
	Lorenzo Stoakes <ljs@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Krishna Ketan Rai <prafulrai522@gmail.com>, 
	Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is, 
	Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, May 30, 2026 at 04:35:09PM +0200, Philipp Stanner wrote:
> From: Danilo Krummrich <dakr@kernel.org>
> 
> Implement ForeignOwnable for ARef<T>, making it possible for C code to
> own an ARef<T>.
> 
> Since ARef represents shared ownership, BorrowedMut is &T rather than
> &mut T, matching the semantics of the underlying reference-counted type.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
