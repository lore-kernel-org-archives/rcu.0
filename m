Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E582931283E
	for <rcu@vger.kernel.org>; Thu, 11 Dec 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765459543; cv=none; b=gAYaGhRdh1NNUIqDQW7xUHUoVo/X5i+HOyoqwQZ73C7019qpZP1oW+B0/ALRON6bLsXmV658OGkWZfm8Ei3fZpwpd0XICYIuOh55biHZpmt+mucl0/+KXlnCJuPtO6tjoIei1nA7wUGVyLV4fd+F7QLPbc+MFQmLUxxpE6bOaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765459543; c=relaxed/simple;
	bh=4koDoOQRFcQ8EnbnmmJvgwasJ9ijqSyJnmmWmgQ4c2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W19I/LN7/2lX+DfRnpczrcUxyBsi4UwkERzdEcTKrMwl7jrk847yE4Za7dKJ52y3q6hSQJEvFUryXSb/AepKv4k1ncfXyRHFZ4OqCBzeV4hsNL2feY/N0fwHSNsggah4sI79Bx4hHdIl41pueeRMzRogIvdouByygBuP/rTQqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3sYjDGk; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3sYjDGk"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6446c1a7a1cso43109d50.3
        for <rcu@vger.kernel.org>; Thu, 11 Dec 2025 05:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765459537; x=1766064337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bWA/kjxAjN+uRNvgRsuZ3C4JKMpyTL0y62dCZ1FivCw=;
        b=S3sYjDGkvoZmbdvrKBBU43ykeWBEyeIUzGZ1bUJYcShsHuHKiW4SEI2gYcMdxdZWwk
         2aA7slM8MmQr4oatTRXGZSDUu9aaPNBM5UXKIo4tZu3aBCHtdy1H/9eebAGdUo6qgX8L
         DvHj6zwUMUlBjO2u0UJVOCuNjgIiGKpFJ3xkH9rQCWgifZulMuykpqPtovrI/gQQK4fX
         tWozvIJabkt3lh8qlKQzKY5OQDpzBc2BgZrGHZlvzzLYrhdrhOMCB5DCqM/inYUnmrTm
         BOMqEJRR2hhdiarGzrCSpdsUJZAL7hGLrXSyYC+4RigvkTH6UsHPfhyza3j2GXbJnMLT
         uY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765459537; x=1766064337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWA/kjxAjN+uRNvgRsuZ3C4JKMpyTL0y62dCZ1FivCw=;
        b=ugwDNKqInoQfp0VLqokbJIjm7qKu/L+33esPwdlyu3NRO98sLfiVzh5wsfhdwvDiyX
         gwPYldjaPgS1NC9NALdhVB5wILw7TcJZliuxgqXc7fT40WhKbKqs3cD8sGhWrUofAxlL
         A4WZS6rtdjk16MJEAsV/CT+GwtpxnOGCo0KCtFVevXk/LCrYTOj9Vy7xDwLhu7Xp3ngc
         uvbwRXq8wMaWl02PdlTLBP451uPPcH2cdD/LuBAzpzrgWqCvkcwzzdbFPg9qmWYYrLkA
         roDtPXjBouhqc8z5GOn2fRClFepyBR3cm1pqcE6Xcq4SjOAUtql4L5ASK0vF1nKPTeNB
         dLXA==
X-Forwarded-Encrypted: i=1; AJvYcCVL/E2G6jfaXlz2BplTHQsKiUmKmYUhqRnl45N1qixF4vaHd12RXjAILlMwaU/MGGLP3/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEAa5CKHznMiLVw31gtu+Pv8YGSEIWxV3KKPLZPRbvMYLI24YA
	f9zF3urFUg+l9WysNfeXRbLeVkUHlNSsKwAleuzte3gA7qUBlW5kSTJ9JUKC2MR/uhD4VBMLAd2
	Wj+itShvxxdOYcNbwpFG3S2W6tM1AcFGXYN76KqaE
X-Gm-Gg: AY/fxX7YkeQ2dKkqb2VfTgkRHH9RW87+loG4b3jTQrMWB0RAvaatvDR1Y7hV6eU1COZ
	UVYbGGXeYg/EGimCpunMUOTQeQFteKJ9cCI23sQoBUOn6Kh50E+7Gx8XPfstTJmw+mw1n8WMm5h
	9/H/lsNcnk2xIpSigEitZx8nOp9ZZjDhUDOgrpvDxBwF9vQXfaZEtuxeS8+BCpdo7EIYfjwQ6nG
	/kUvy9/ts5A8bd7CxK+IvUjYsDdo9TGYEodlbWfT3/qU2+MCHBGCuqVimdKp8p5hbGlYr2dv7pv
	5NPCVMp++ovEkLzaiUKD9Z64XXiv0tQvHMw=
X-Google-Smtp-Source: AGHT+IGPj4VYuvzobJuySeUtMjR2owpUV9b14snNLjzBypYDLw2+crQYToZkiUGcBVWZIJW//ll4Or+5K7PYShnu4As=
X-Received: by 2002:a53:d01b:0:b0:643:1a78:4492 with SMTP id
 956f58d0204a3-6446eb6016cmr3860639d50.81.1765459536448; Thu, 11 Dec 2025
 05:25:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
 <20251120151033.3840508-8-elver@google.com> <20251211114302.GC3911114@noisy.programming.kicks-ass.net>
In-Reply-To: <20251211114302.GC3911114@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Thu, 11 Dec 2025 14:24:57 +0100
X-Gm-Features: AQt7F2r5KNsATXW8d-J0gXHLFG6W_D0lOL42kIv9mnu54Km1ZPN_9U9TSDd09do
Message-ID: <CANpmjNObaGarY1_niCkgEXMNm2bLAVwKwQsLVYekE=Ce6y3ehQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/35] lockdep: Annotate lockdep assertions for context analysis
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Chris Li <sparse@chrisli.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Johannes Berg <johannes.berg@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 12:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 20, 2025 at 04:09:32PM +0100, Marco Elver wrote:
>
> >  include/linux/lockdep.h | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 67964dc4db95..2c99a6823161 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -282,16 +282,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
> >       do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
>
> Since I typically read patches without first reading the Changelog --
> because when I read the code later, I also don't see changelogs.
>
> I must admit to getting most terribly confused here -- *again*, as I
> then search back to previous discussions and found I was previously also
> confused.
>
> As such, I think we want a comment here that explains that assume_ctx
> thing.
>
> It is *NOT* (as the clang naming suggests) an assertion of holding the
> lock (which is requires_ctx), but rather an annotation that forces the
> ctx to be considered held.

Noted. I'll add some appropriate wording above the
__assumes_ctx_guard() attribute, so this is not lost in the commit
logs.
