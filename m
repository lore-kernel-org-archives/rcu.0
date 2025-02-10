Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530CA2566D9
	for <rcu@vger.kernel.org>; Mon, 10 Feb 2025 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211830; cv=none; b=ohuZKukRT1axGJRnFTY/j5q4IH0vakjYmmO/t6hez6bkOSVmSosqYHV/ld00N87A5zGvZ60x0rP7o3ee+QfK+BUK2NczZQL12g55P8PK4z5T9RLbge+SywoYdFS3fdTEGA/Qyi9ccKrymcnIcKol/dZy3MMPxG645XIgbzUNM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211830; c=relaxed/simple;
	bh=Miu/trECjtxaQhLI9ymFMWHhU+IK6xkOEhR0bChPAI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0Ran5tvVQwJScouOOIIQ+H2jL15avt3kPHd1XNytOn5RRKvW1D6J55LF9lphbkN6KBZSw2X7VdT+kVDtkrK2/dRXkzudHajclhx+Z67AHDr3pVsbnZMNumhHh5v+2yVXpttKxEThBtTIB31Tvo48oEzyfMU2eBM2jKx86UO4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfhxME3k; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfhxME3k"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa1d9fb990so7258064a91.2
        for <rcu@vger.kernel.org>; Mon, 10 Feb 2025 10:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739211828; x=1739816628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GHmPYfF8/lSNO+AXa3rKVXqC3Xbb512b0LOODXOyyrk=;
        b=vfhxME3kpRGU0L+tQy9Iz3xJSuUNw3rRHNJB4yM7RYnt7RTdCKUl8ahL359cmL3+Ws
         23v3DbStxFS8/zqfdFvTl5l43z7RbGDrue11rCF6jEt9t2p8/b4z7RnjbsG2ipJ5G/HK
         bB08xNvjgA4B5C80SJH35dtPfBZCd1MJV3581a3jL6P219fBchD4+7KaTYuTScgOul+U
         b+zYpRD3QVsGGD9ju//59UZZFl/+RU64qI2gttNoxode624cv4yWOJxgXwqJk0wRN2k3
         mm3Xzq6NhSDAYzo8A8qioUpDuYIG/SgfP5EyJRlwR6flAdwk08EUrjAamyBXGhTIw4kC
         Mv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211828; x=1739816628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHmPYfF8/lSNO+AXa3rKVXqC3Xbb512b0LOODXOyyrk=;
        b=piXgElguFJLO87fsgkkbsL0RJhg+M4d8pelHZTj7FbOFfOxXj9nrp7jKUpk5iPsVcr
         CgoL8IslHFWxlQqBxrJ9wAm+u1c24SdBBuJQrwg8L9dJOjBIfdXRpGU+DsPn/IWpN8aY
         hYq4lSGOKvo07DfeL1OWAzethItTULhC4+2SxAmg5KvMuiIGqGi/glKcEN71Yqrmjqz6
         8dk/UH4MTadgBHJA9D107Gs1/TiNC2uLEn4nnG0i44oDzYteYV2Un2jIioGo4kKk7jhc
         qYNKoU1ectqw9mOiTXeI+QLFRlOVCG6YAYuDMH+FKXziL+i5TN8b75A4O1oQmHl81oNM
         pkCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCA6dKXsHuv6cSVDpJwf5INrB8ty69Cp9fJIlxALNGjiJosPTeIsYkvKOTxmeNk5BCyE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPWBhvHngv33fA5A30o5/TCDJr+KqhqxxLXL9pm0zZhAijssIw
	s7FZy30qz6AZ1SCoojEPqUqODI5bMcoWnMZLxmCErjoNdcnfx0uNp4rLIgjREufUwD0X098S98S
	9rbLBcrD0Lt6ANxFq2QdmYkJ52qLxRD20Usk0
X-Gm-Gg: ASbGncuTnYsiG9uhXarytKa/f2DYNeJZAyn0vbkjUIs4OifeuY67JATAE2Cyh3Kn5Mv
	XufnXsqZGUY12n/UPRZLDejJWP9LRlinbl3yOvR7xklvnvDBtd3mXY0CMpL98L+L1NROaXGBzD0
	QSznBkc4Tg/IMQTOYFFzGQl3R4AlM=
X-Google-Smtp-Source: AGHT+IEpjZI+LySUmcGlEa+CW28RWh5CJfAMFDDLShGLLN4xFU3oiMLkaI2j0IpT7DZLL4InHIDC1P6Sa7+hlDf+qGU=
X-Received: by 2002:a17:90b:2ec5:b0:2fa:2252:f438 with SMTP id
 98e67ed59e1d1-2fa2450cf33mr21544870a91.30.1739211828003; Mon, 10 Feb 2025
 10:23:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206181711.1902989-1-elver@google.com> <20250206181711.1902989-9-elver@google.com>
 <e276263f-2bc5-450e-9a35-e805ad8f277b@acm.org>
In-Reply-To: <e276263f-2bc5-450e-9a35-e805ad8f277b@acm.org>
From: Marco Elver <elver@google.com>
Date: Mon, 10 Feb 2025 19:23:11 +0100
X-Gm-Features: AWEUYZmxMGiGlzeQT0LaguR-GUnXW8sHLZhY4gy5ushUKI7JT1xIrRKge8P_UM4
Message-ID: <CANpmjNMfxcpyAY=jCKSBj-Hud-Z6OhdssAXWcPaqDNyjXy0rPQ@mail.gmail.com>
Subject: Re: [PATCH RFC 08/24] lockdep: Annotate lockdep assertions for
 capability analysis
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

On Mon, 10 Feb 2025 at 19:10, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/6/25 10:10 AM, Marco Elver wrote:
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 67964dc4db95..5cea929b2219 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -282,16 +282,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
> >       do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
> >
> >   #define lockdep_assert_held(l)              \
> > -     lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
> > +     do { lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD); __assert_cap(l); } while (0)
> >
> >   #define lockdep_assert_not_held(l)  \
> >       lockdep_assert(lockdep_is_held(l) != LOCK_STATE_HELD)
> >
> >   #define lockdep_assert_held_write(l)        \
> > -     lockdep_assert(lockdep_is_held_type(l, 0))
> > +     do { lockdep_assert(lockdep_is_held_type(l, 0)); __assert_cap(l); } while (0)
> >
> >   #define lockdep_assert_held_read(l) \
> > -     lockdep_assert(lockdep_is_held_type(l, 1))
> > +     do { lockdep_assert(lockdep_is_held_type(l, 1)); __assert_shared_cap(l); } while (0)
>
> These changes look wrong to me. The current behavior of
> lockdep_assert_held(lock) is that it issues a kernel warning at
> runtime if `lock` is not held when a lockdep_assert_held()
> statement is executed. __assert_cap(lock) tells the compiler to
> *ignore* the absence of __must_hold(lock). I think this is wrong.
> The compiler should complain if a __must_hold(lock) annotation is
> missing. While sparse does not support interprocedural analysis for
> lock contexts, the Clang thread-safety checker supports this. If
> function declarations are annotated with __must_hold(lock), Clang will
> complain if the caller does not hold `lock`.
>
> In other words, the above changes disable a useful compile-time check.
> I think that useful compile-time checks should not be disabled.

The assert_capability attribute was designed precisely for assertions
that check at runtime that the lock is held, and delegate to runtime
verification where the static analysis is just not powerful enough. In
the commit description:

Presence of these annotations causes the analysis to assume the
capability is held after calls to the annotated function, and avoid
false positives with complex control-flow; for example, where not all
control-flow paths in a function require a held lock, and therefore
marking the function with __must_hold(..) is inappropriate.

If you try to write code where you access a guarded_by variable, but
the lock is held not in all paths we can write it like this:

struct bar {
  spinlock_t lock;
  bool a; // true if lock held
  int counter __var_guarded_by(&lock);
};
void foo(struct bar *d)
{
   ...
   if (d->a) {
     lockdep_assert_held(&d->lock);
     d->counter++;
   } else {
     // lock not held!
   }
  ...
}

Without lockdep_assert_held() you get false positives, and there's no
other good way to express this if you do not want to always call foo()
with the lock held.

It essentially forces addition of lockdep checks where the static
analysis can't quite prove what you've done is right. This is
desirable over adding no-analysis attributes and not checking anything
at all.
