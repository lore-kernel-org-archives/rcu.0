Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898BB3D3485
	for <rcu@vger.kernel.org>; Wed, 11 Mar 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226062; cv=none; b=XVnzZmeLsaB5GGv/62shRiYunWX78JzADZIbm9XvGmWJje68BI8f+XBgxsHMhPR/F/cNyFmCSLgUq5ISeo8Qm19g5UwMfcRhEchQVPR8Lp9bzmxB/l1Abfh5i4eM3Rc6GxvHlxWyCcu9QXkCfVdG77WtY8d2u3CwMMWjheBiBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226062; c=relaxed/simple;
	bh=zRCIOZXGAulewyBbqGE0TlQlTPqeFeIDTbPGyy24MV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/Kvey38hxllltljXfUMcc0Q0tWF+/5PyKrN9phktKQxGWnHkG3ATtbdm6KS0CpsAme7GrSDTLiT9fBCVdIL57ALELxUEsO1pj0IgxmWrCUGRlRMNdO7Et2C3DSFDYEl0Y2ARDIs2wdfyOtsmkSOaIdm1vxK5oWecDvWPZ648R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+NfnaGG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+NfnaGG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-482f454be5bso9529105e9.0
        for <rcu@vger.kernel.org>; Wed, 11 Mar 2026 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773226059; x=1773830859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us9WYwCiTBLLsk5cVeG22xmuXfkRkjPu0Kbcd1njBZs=;
        b=l+NfnaGGhGE/Qag8NAZKtowOcVY2wLQCbEgf8MnpvieTQKfxTgLXG7gVpu41GQE3Cp
         lhcuSJ3ojhuoA+XvMW4ZK8DqWwguSBIQJdzHM+m0gGn1i58Im+PG8aw4GSSmMwNkHayu
         W9J2Et5BO3MOuAYEpSQbP4o8f9J9gsDj/OANzpqDRda1qkC6GXeo6tLR1/FbLVhhy7Cf
         MUxhHc5jx0lvSaHnxQ6WahuluHX1XzGqARVN8PyVe1PrQbU+agAKtUfEmOiyxhtTA+gY
         BR6kn5ugraDiB91Rov4L/mant481Z758KVbs1s66hkgz+KSI4U1uv3Da1yI4gGWMgZ4d
         Uvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226059; x=1773830859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=us9WYwCiTBLLsk5cVeG22xmuXfkRkjPu0Kbcd1njBZs=;
        b=Ly6TfiZPIUr7hCFrW+Ghe+j2LASkyEnclMdVHz5utvOERRltxseiSJMgDtiun/aqoU
         fmReZzeIrQ+0hSv/F8fUBdIoGVjsGw8R7sxoWJ8dMcooDFb4ob0qzwxhgvz/t8/PsLvb
         7Na/TCXOaw4D5gJ/zhulboB8mMWG5NCuJFAHVThTDd1MCP3YjuPF9jgXbywTtjYeoC1r
         nR2hqk1yfVXQWMs/WcK1rV85czdtp3yYR0o6nVYp+DAMQM10WmG7WKfzzTEMG7Gx3JIo
         cEh7rcUGcZy8q3EGfv7avWMWTTSilJ5UFiXE2LyIXaGK6B7NNKRLIuFhtCvuAW4UxnOP
         Oenw==
X-Forwarded-Encrypted: i=1; AJvYcCWNksqUQSKnPITAvstdB2YForT0PKD9EYHtnYyPOaNFXjhZ+ob1ajnVniKeYQkceOejIts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7i6xemiBvP5PUPrkRnUpCptSGgtwNtFBTNLLGsAVfrxMX03BT
	+DqTyZCmb4AFFApTLBZwVqkbrE3h25Tc63qcmwWCqoA1nelTckHyhHiH
X-Gm-Gg: ATEYQzxCuKE19mFXhH/q/SqyWsEcn2HbX9WW3A1hLE67b9UqN+XzvG9ISA/xUT/P6Jb
	XHhH1HnWwqZHQxJHE37TPnDRo+v3lb48zU/jQWvPgBukrmI0zH4CQcVinMvjLjqbJ3NWJtCp/zw
	70pYjIgOyThG5OSe3M+OpJWIf0oTlZwhxw/b0ripzg1SMJfVe1R99yTLFMePlXIAzEiPFWIBikb
	O83Cz62gw3JolwdaoT2mpOuXaXWxU/AYcWbNwDrnaco1HiYfqJUeAcnzP314yiYGOj9fsD74t15
	1qMlnQnhzFYuBueIAMl78eRq+fp1bhQXrUis+Ob2HdIwXy3l100E4YD0nJgj3+o1EhZZv+350RK
	B8txs33t25G9WDKMP0LRVqdt80Dy17Kxe6gYf42ZnHTq3NH1Kk6NxIrXti8H8ycIii/nqnw3/QT
	v7Huh8KFp4KLf9pFNYg4P9i9Y8vwvwQMuc8QMtf3emJXdJq1Hv3Q6IzIyTgrxmBr7mDK8jiO265
	OE=
X-Received: by 2002:a05:600c:5298:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4854b291dc2mr30148705e9.15.1773226058755;
        Wed, 11 Mar 2026 03:47:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f820a2f1sm5725154f8f.30.2026.03.11.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:47:38 -0700 (PDT)
Date: Wed, 11 Mar 2026 10:47:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-nfs@vger.kernel.org, bpf@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netfs@lists.linux.dev, io-uring@vger.kernel.org, audit@vger.kernel.org,
 rcu@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, Christian Loehle
 <christian.loehle@arm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kthread: remove kthread_exit()
Message-ID: <20260311104736.51b53405@pumpkin>
In-Reply-To: <20260310-work-kernel-exit-v2-1-30711759d87b@kernel.org>
References: <20260310-work-kernel-exit-v2-0-30711759d87b@kernel.org>
	<20260310-work-kernel-exit-v2-1-30711759d87b@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 15:56:09 +0100
Christian Brauner <brauner@kernel.org> wrote:

> In 28aaa9c39945 ("kthread: consolidate kthread exit paths to prevent use-after-free")
> we folded kthread_exit() into do_exit() when we fixed a nasty UAF bug.
> We left kthread_exit() around as an alias to do_exit(). Remove it
> completely.
...
> -#define module_put_and_kthread_exit(code) kthread_exit(code)
> +#define module_put_and_kthread_exit(code) do_exit(code)

I'm intrigued...
How does that actually know to do the module_put()?
(I know it does one - otherwise my driver wouldn't unload.)

The corresponding try_module_get(THIS_MODULE) is done before the
kthread_run() (and has to be 'put' if that fails).
So there is an explicit 'get' but an implicit 'put'.

While a loadable module that creates a kthread usually needs to give
the kthread a reference to its module and then have that reference
released as the kthread exits, I can imagine cases where that isn't true.
(Or broken code that just hopes the module won't be unloaded just
as the kthread exits.)

It actually makes me think that module_put_and_exit() ought to have
a 'module' parameter.
Or, perhaps, kthread_create() should have the module parameter and
hold a reference to that module until it exits.

	David
