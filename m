Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F042C08D9
	for <rcu@vger.kernel.org>; Thu, 11 Dec 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461287; cv=none; b=fY7GOP+WHJ80hWoof7ZtJZrefqQBxvEezLAmXRkymJAPa1b3sPhN562bx30DKiiPLfV+E0/7+/PoV4AGjjbejq4cV36vLpZdam2KWhNOZk7yKqGB+r7ceqeePZcGeH2IvV/7/r6luQz5sSsU0DmGIclaLSjZO/0MXH/+txhbWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461287; c=relaxed/simple;
	bh=asjipvlumTAG9LX/ZrgSM7qOg2tY3hiQLpH2JweZG4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKa6fhKTu3pcnjaVsozylrHYHU11L7cO4hoLplwldwi15Nfbz+bK0zIjFybqkIBDT6FgsQK8noR40dndCMkBYVDhRIc+hk8ZsHmSF7ODEwHagaC6r50C1ZjWP0egyZW5ZKGPnh6SwQK6SaUa7K5Joh0AFgqNWotxldPonWY5OgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uDYj/hL7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uDYj/hL7"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so99375b3a.1
        for <rcu@vger.kernel.org>; Thu, 11 Dec 2025 05:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765461285; x=1766066085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aWRPRAJ89lgq7qGLYK1gyasHO8BcBnTXm3hkZRbZKOw=;
        b=uDYj/hL7oGwh2XUzc1hqD9+sdZ/Sx2Sq2KIskqtRR/WRmu2isIV04TAqo6JOKiX4kF
         NCpsGtZjwJuX40Ngt1BNK/SQaQ2XpxVQUmNG0btiWJ2i0K4XwxIlSK8GOLCMHLZZhDWN
         WwjUXaxR3Abzxj6Dcz0KKvvpDorVhHMUBws/PgXonrmgS/0ghFX/2ApTrYXWqPZn6utb
         dD/vbXSKFO6Yi5HxsWNMKFQNDEVQRC/xUBmSXlp5CmOLIAyyLDUr+XUKig6XSeGgXovr
         0TEArh7ZcaNENoq1epGedgYRQErJdCKsp57ZQPTUpjmd0nyjiuCtg+KRrEgd72Q3Y6cn
         cRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765461285; x=1766066085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWRPRAJ89lgq7qGLYK1gyasHO8BcBnTXm3hkZRbZKOw=;
        b=b8HrWrMNNZcTZz4Xff/G+r0eAv3el+aj577iPjS2/3wftjKd4QKVJUz644GH9p0e0o
         nRxoFEl3FZLaeLYbcvDUidHe99rRrJkzJ5pE/esfBTReMgCurOvrMfCzCistcx+mnGqN
         QZ2a8DpK/9Fkyf4BFyU1G3VZd+T4viiKe4tgNKymIuxvSMQuh77ALmGwc/Ur+VKVzd6c
         GoZLveESXplwi+oGFnUFsdbIe46h7zBv/X+R8nZM9BG7QBfTcgLUtjYkFA1Xjad/He81
         Z78aMpb73AWzuARRZ68bkkBsVP1jwr2+8TY0uuS0r6aApLgH9pgVkNOrxrol8Jxqkdew
         YyrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn66Cz24c9tgw97K1aPOeWQVqlrF5iQoSEfGQqVbGdWaevS+IM5JrnclUEqqYhvy8iKV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs0h7h1sq7i7u5P7sM54+5ZksPriuUb7n7gwy2ipOkF/v9+hz5
	/coExztHPeAw6GsU9UE2XwqE5LmK0lxMNVqTHJiCAZULlNPLIJgWyix2/GG6acWOFhLhoRdgzFe
	b4mSbd29iQXB/s2LTnBcIdpzXUBUiHZGl4kANmKXr
X-Gm-Gg: AY/fxX7l9VA8HmsdIVjdP874XQGzWkH+8xc7RRfueJ1C+o0z5GORnm2VCahBBNtNovU
	IpBj6FQWOtMGQb0fRi4T7y9F0rlYKdpPNw4GAKdQCcCA0jI/KIY7yX950VpfjyH0WgunW5a/OzW
	Mn7PW8ijaukd0BFa7/ZEeKM9yhi+iPlabTqiLYPdok2LDQp7k3Q75IB+pixeLYjb8jR1hu/fziW
	dx5tmW2NQS9ivHvKlImNvGxBdPtmZoiCLg6bC5pImNHSr2tHFFksFZw8GnqEW+dpoEqNux5cO7h
	zQJwOGLeMx7Vs6CBRp6SNN9+
X-Google-Smtp-Source: AGHT+IEaaruplzdVpdnApdH4OVSrHUz40RptUVIyI3MxrgnCoT6vGrQB2vef/vIeMxQHfT2Nk7cub+UMnQmlsyGPvik=
X-Received: by 2002:a05:7022:2219:b0:11b:bf3f:5208 with SMTP id
 a92af1059eb24-11f296558d9mr5045780c88.1.1765461284380; Thu, 11 Dec 2025
 05:54:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
 <20251120151033.3840508-17-elver@google.com> <20251211122636.GI3911114@noisy.programming.kicks-ass.net>
In-Reply-To: <20251211122636.GI3911114@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Thu, 11 Dec 2025 14:54:06 +0100
X-Gm-Features: AQt7F2oz75av79IX-Fsq5GL2dibuf0pX45-76DYGUr2aahssaITkwrN9Ju3gYq8
Message-ID: <CANpmjNN+zafzhvUBBmjyy+TL1ecqJUHQNRX3bo9fBJi2nFUt=A@mail.gmail.com>
Subject: Re: [PATCH v4 16/35] kref: Add context-analysis annotations
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

On Thu, 11 Dec 2025 at 13:26, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 20, 2025 at 04:09:41PM +0100, Marco Elver wrote:
> > Mark functions that conditionally acquire the passed lock.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/kref.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/kref.h b/include/linux/kref.h
> > index 88e82ab1367c..9bc6abe57572 100644
> > --- a/include/linux/kref.h
> > +++ b/include/linux/kref.h
> > @@ -81,6 +81,7 @@ static inline int kref_put(struct kref *kref, void (*release)(struct kref *kref)
> >  static inline int kref_put_mutex(struct kref *kref,
> >                                void (*release)(struct kref *kref),
> >                                struct mutex *mutex)
> > +     __cond_acquires(true, mutex)
> >  {
> >       if (refcount_dec_and_mutex_lock(&kref->refcount, mutex)) {
> >               release(kref);
> > @@ -102,6 +103,7 @@ static inline int kref_put_mutex(struct kref *kref,
> >  static inline int kref_put_lock(struct kref *kref,
> >                               void (*release)(struct kref *kref),
> >                               spinlock_t *lock)
> > +     __cond_acquires(true, lock)
> >  {
> >       if (refcount_dec_and_lock(&kref->refcount, lock)) {
> >               release(kref);
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >
>
> Note that both use the underlying refcount_dec_and_*lock() functions.
> Its a bit sad that annotation those isn't sufficient. These are inline
> functions after all, the compiler should be able to see through all that.

Wrappers will need their own annotations; for this kind of static
analysis (built-in warning diagnostic), inferring things like
__cond_acquires(true, lock) is far too complex (requires
intra-procedural control-flow analysis), and would likely be
incomplete too.

It might also be reasonable to argue that the explicit annotation is
good for documentation.

Aside: There's other static analysis tooling, like clang-analyzer that
can afford to do more complex flow-sensitive intra-procedural
analysis. But that has its own limitations, requires separate
invocation, and is pretty slow in comparison.
