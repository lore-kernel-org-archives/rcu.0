Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78B19F13B
	for <rcu@vger.kernel.org>; Thu,  6 Feb 2025 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867758; cv=none; b=AGgpKaTUSJeo+C9yIAq7fq4PwNd8p5OZeNHS9jD0LQqSbb080ZSccpR8RECJilACPK+/YRd5T1ecB11nZpsVagwDSbu/KfD8yI2GmtqPFdE5hpcRWAaWj8Ba2xgeHCCuKnRruzklkQMsfACHq0ZRntwh8IJHlYRMsxcZDi6Isrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867758; c=relaxed/simple;
	bh=v+PUw2Q3Yxfuone7yJBVYRyJPvIXK21JmruUcVnGGvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rn9GPIIi7KsEL3AUKZyHonKanNGG/mmJ5u7Jei8fsIrS7j9PxKDdbZFzbeE8xYd1GBOsJSGCFkUcaWMsjBPSiKh1En4P+QMPFrmnAVlcldVCCoBPrJbcIJx7GxpBWcws8rgP+kSXZq9PzpdgPSBYJl0WgcJqMzYhMY3nMMP48fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVE4HK7V; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVE4HK7V"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f98dc0d923so10328657b3.1
        for <rcu@vger.kernel.org>; Thu, 06 Feb 2025 10:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738867755; x=1739472555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nlRt5j/kIPL45Og0/CWS7P0L4BsTBNK9TmluKrchWAg=;
        b=gVE4HK7VZHX0tmUnRQSmq/NB+pGNxl1b7NvNA9RtH7vz8x5q66Bg3FNvdwHIFg8CR6
         lHi1qcYoNk1qOXiyXDkTJg6YL4ct6PYidywLwQ1/7rmqRhMQFVvSE2uIgFOgXMNEz5fY
         e16w3lqDIEvpOXTbCKG0gys/MnGdO7IvoHNXpnJGGTlZ0Uodw8YdMgoChpl2r7nUkcpU
         N2WFTyPBJnZ7Ha1xjhIA2uLdGWw0irMR46XwLZAJ17PzuIwGcC376AmGaY6nnjaZGQco
         6hAoANpLeMwSEyfWhrZpjsDeow9q4LtVP98mUJok/fyfYumZTHRD2wqicNoDiKogsjRN
         O6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867755; x=1739472555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlRt5j/kIPL45Og0/CWS7P0L4BsTBNK9TmluKrchWAg=;
        b=pQWgi3XKaRxHM0/8dVLPUXc9bAgrT20qU2/mFDXYHvAmtem/X9EdpvLPkJLSi1Cu9y
         r59QyDpw9JR4kz//ohJ0q3EFlGRV5Uh8miivtp3UVyIBZSGdFTVoNbN8IbRbfHi/RfGq
         FD+ClQ5p7BN8GypLtCZ6FRfsDO9Dbj9uZJfEz5ThyReynZcOxN7WYmyOOOXLOq/e7yOX
         VAuAZYmqYPdkD9HH09u4eeUduilKy9eKzKInQFR8NwYmEzr7nyrEAn/jz9NgOTu5fOye
         s5dj3Vu9rRf3ir/ojldPq6vh7BIhN5BGSXuvy/SKwcVu70akgjHfyeWYcp8DUXM5xYk2
         7jOw==
X-Forwarded-Encrypted: i=1; AJvYcCUjE+zszTcdQ+kSDPGKSDJUCEdBgTQgQqzzD3LGsqrBAgy70CI+KZ+SbHYiaRkGAG5deZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycuKwJeiqUFk+m8U+v+yUyOzo2lH9O3rvyqlWEHhoAdWE++rDo
	CWYibpoPyStWy99uwljKd3t6pNSeD+0IeiW7zgKcMvxIDe3eadc7Ju0iuYQB1lg8aiFN2+BjDJD
	LOlmAGPKeJvvOdSxAu6R94nqSu2arTfuCt8Ze
X-Gm-Gg: ASbGnctE41HNqaISK6WJ6Mqfu5Dl6E/v7FS1IbmiicMlDfZ8Iyla/K9nCGq8XbSsXay
	YrB3mH+Hv6/bN3rVPtHGNpKmzc31LBbJAVxO2riIL1B9iyg/jtT8WYuGptocsuHgXvDVgwQCrUY
	3S/oWL3DXHEr9ZZ0hmRJQvAfB4o5M=
X-Google-Smtp-Source: AGHT+IG732MPGs5331pepE+AcF55+6p+ypSgIeWmQCP+V3pUV36KCk1Ozv7+1d7SFih6fjpij0+2+MtlgsbuGXkbOy0=
X-Received: by 2002:a05:690c:7089:b0:6f9:492e:94db with SMTP id
 00721157ae682-6f9b381fca2mr191027b3.2.1738867755278; Thu, 06 Feb 2025
 10:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206181711.1902989-1-elver@google.com> <20250206181711.1902989-2-elver@google.com>
 <552e940f-df40-4776-916e-78decdaafb49@acm.org>
In-Reply-To: <552e940f-df40-4776-916e-78decdaafb49@acm.org>
From: Marco Elver <elver@google.com>
Date: Thu, 6 Feb 2025 19:48:38 +0100
X-Gm-Features: AWEUYZnk9rIG8ZqxXrgEaM8RCQ6m2IyEZ2vODfXrtzceps44fJ5AzWTWAEX80U4
Message-ID: <CANpmjNP6by9Kp0rf=ihwj_3j6AW+5aSm6L3LZ4NEW7uvBAV02Q@mail.gmail.com>
Subject: Re: [PATCH RFC 01/24] compiler_types: Move lock checking attributes
 to compiler-capability-analysis.h
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Feb 2025 at 19:40, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/6/25 10:09 AM, Marco Elver wrote:
> > +/* Sparse context/lock checking support. */
> > +# define __must_hold(x)              __attribute__((context(x,1,1)))
> > +# define __acquires(x)               __attribute__((context(x,0,1)))
> > +# define __cond_acquires(x)  __attribute__((context(x,0,-1)))
> > +# define __releases(x)               __attribute__((context(x,1,0)))
> > +# define __acquire(x)                __context__(x,1)
> > +# define __release(x)                __context__(x,-1)
> > +# define __cond_lock(x, c)   ((c) ? ({ __acquire(x); 1; }) : 0)
>
> If support for Clang thread-safety attributes is added, an important
> question is what to do with the sparse context attribute. I think that
> more developers are working on improving and maintaining Clang than
> sparse. How about reducing the workload of kernel maintainers by
> only supporting the Clang thread-safety approach and by dropping support
> for the sparse context attribute?

My 2c: I think Sparse's context tracking is a subset, and generally
less complete, favoring false negatives over false positives (also
does not support guarded_by).
So in theory they can co-exist.
In practice, I agree, there will be issues with maintaining both,
because there will always be some odd corner-case which doesn't quite
work with one or the other (specifically Sparse is happy to auto-infer
acquired and released capabilities/contexts of functions and doesn't
warn you if you still hold a lock when returning from a function).

I'd be in favor of deprecating Sparse's context tracking support,
should there be consensus on that.

Thanks,
-- Marco
