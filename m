Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB6522FF22
	for <rcu@vger.kernel.org>; Thu,  6 Feb 2025 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879359; cv=none; b=lJiQ1lZzrsb4S4FpRFL6yDkq5yFAtlZo5292kNCfD7l7Gr9XU+zDjFJ5g/4/24vpZFfpEAoL7/QonLfiZ9tkO+q8032do5xBv3RVE8iEHHKNvONxwK5uHv5uNWcgCu8nwFrki5JHu6DkneXnsXJdyyT0rCeBN7gEBw1GMplT2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879359; c=relaxed/simple;
	bh=yhX7RJVwaA+Lpx5zbK94yXYQtEnJwzrvecNure0CHC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzgZL05nUf0sHdW3v8QNVkMYmSr59LbTv5syYDG0Dqs6+jETQzUTF/+xnjlKLijOtZZZEgFdL0QCUYQSYZf619akpfn/cqEWGUsrb7jehJ93SKcf1R7iTFH/8ASYcvyxm582GZihyXKTe8P5L+5bltq6uHQf8Tr21OC28E4pJvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxIVV+nl; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxIVV+nl"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9f5caa37cso3122492a91.0
        for <rcu@vger.kernel.org>; Thu, 06 Feb 2025 14:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738879356; x=1739484156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+VZ6pc7yhUf3GbCnbHnQECLXNAA4wAPKI9VijFmeNYk=;
        b=kxIVV+nlOzHE5Iqj8I8vuEVrs88qB4A69R7D27IpLydGzluqwEmvEeSeFI4g4aZVLZ
         uyi37TBXdKGgF8z1hkcMXg192VnrJnBfWsqFfqhxTWKJYX8FpJRbpxlKtJmtsuo0EXsY
         Jep6UxWiFFrn6uj73IuGYC8lGeXzD7J55V5P4jt75iLIs16WRizCYm9bj12JO6A77Tg7
         qe68Nt0aaZ4/yEb2/NvTci9s3nd0EVg/ii1Ng9zOWSpidlOL7jReuregTMMFa4h6hGKe
         NINmtRSHo3/YlblodsPrwC8AwpCvaONm0NecI/4PAwfmkb5qnInTbe2rS92+xBG/xemW
         XvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879356; x=1739484156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VZ6pc7yhUf3GbCnbHnQECLXNAA4wAPKI9VijFmeNYk=;
        b=qbXJnaBc5P5zxIZwH9Fp4gVcwU+7Ax5Cji/1Uz22DjLvv5HTk/EvthCXwcGXx3s7Z+
         3WyiPATGmW0PpkWYeLiHrSNjRNMYEvfDSlJDxSpuf0snni1+VreEstkx+ccHZnzqHmb8
         mvxKgTuf9DvpsJj/FwOg4MlWaNGWOhcpfTvaBOjKYf7dM2gg7CMMFz2aRqCYzTVD/T2E
         hFSDoZqoT+X5ZEsSavt6QTmtLoZgcxcnsnbFcjflhXaBlWyWC2mplPZDI/0/7LxIGUhn
         Fmc0HpOWuE2YmWAI7XR+XtE4+pzKn0gfAE3hadKvcXIz6xCKSIOnjiaeTfVFkGyHcD1B
         qd+A==
X-Forwarded-Encrypted: i=1; AJvYcCWwbncFTiEImcTfHu99mwHyiJtahLEHZacVttklwzMTpVRVlDx8xl8s1Ch4NHRxdbcEEPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmru2nwAk+DOLeswALuwA534GIqMSOELdduh3Ipp5r/8qGgJeh
	KgW3d26n4wis+SoEGoxmmkIKmsWbHMXdatq0nwY3T+Hfzk7Y6EIpQeusu7tZPFgBl/91/R3ZIk4
	GWDcepTkypvBvzBTya8Hg2RJvMnMxmFd/5xq+
X-Gm-Gg: ASbGnctOj/ye4ywzppVr5C8o3DXsFTZcmyWGdamAsx2SX1BeR74d3u2dUOdztd5HBYK
	arwgupsIXb4elccLiFbd4vQRTKSGAgb8zO8g+nDPdOz349RbAOXUVwsmkIOTrKHfEEGuPuPlC4I
	sxW/NkZfkFDEFvFzdC5Zq9/jOVC1fF
X-Google-Smtp-Source: AGHT+IHT0gKSH+kblZFLx/Wzk00J8ULB9nNNudVm2CwEFSzub8EVmI8aYK9egI+4TLHMpy13Xtg4Kl5eKF+OeEA9kSk=
X-Received: by 2002:a17:90b:1a91:b0:2ef:949c:6f6b with SMTP id
 98e67ed59e1d1-2f9ffb38596mr8748127a91.13.1738879355643; Thu, 06 Feb 2025
 14:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206181711.1902989-1-elver@google.com> <20250206181711.1902989-8-elver@google.com>
 <4ce8f5f2-4196-43e7-88a2-0b5fa2af37fb@acm.org>
In-Reply-To: <4ce8f5f2-4196-43e7-88a2-0b5fa2af37fb@acm.org>
From: Marco Elver <elver@google.com>
Date: Thu, 6 Feb 2025 23:01:59 +0100
X-Gm-Features: AWEUYZnffMY9S6S6so6pFI6Su5ySq6ByivopC2ArucfUZC95P3tyJXAV2JoDeGo
Message-ID: <CANpmjNMGH36vs8K9Z8tnJc=4xSeeQjeZGyhZj5KSUwh0kQ06MQ@mail.gmail.com>
Subject: Re: [PATCH RFC 07/24] cleanup: Basic compatibility with capability analysis
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

On Thu, 6 Feb 2025 at 22:29, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/6/25 10:10 AM, Marco Elver wrote:
> > @@ -243,15 +243,18 @@ const volatile void * __must_check_fn(const volatile void *val)
> >   #define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)             \
> >   typedef _type class_##_name##_t;                                    \
> >   static inline void class_##_name##_destructor(_type *p)                     \
> > +     __no_capability_analysis                                        \
> >   { _type _T = *p; _exit; }                                           \
> >   static inline _type class_##_name##_constructor(_init_args)         \
> > +     __no_capability_analysis                                        \
> >   { _type t = _init; return t; }
>
> guard() uses the constructor and destructor functions defined by
> DEFINE_GUARD(). The DEFINE_GUARD() implementation uses DEFINE_CLASS().
> Here is an example that I found in <linux/mutex.h>:
>
> DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
>
> For this example, how is the compiler told that mutex _T is held around
> the code protected by guard()?

DEFINE_GUARD is the generic variant usable for more than just locking
primitives. DEFINE_LOCK_GUARD_X is a specialization of DEFINE_GUARD
intended for locking primitives, all of which should be
capability-enabled.

So I added automatic support for DEFINE_LOCK_GUARD_1 (keeping in mind
the limitations as described in the commit message). All later patches
that introduce support for a locking primitive that had been using
DEFINE_GUARD are switched over to DEFINE_LOCK_GUARD. There's no
additional runtime cost (_T is just a struct containing _T->lock). For
example, the change for mutex [1] switches it to use
DEFINE_LOCK_GUARD_1.

[1] https://lore.kernel.org/all/20250206181711.1902989-12-elver@google.com/

(For every primitive added I have added tests in
test_capability-analysis.c, including testing that the scoped guard()
helpers work and do not produce false positives.)

The RCU patch [15/24] also makes it work for LOCK_GUARD_0, by simply
adding an optional helper macro to declare the attributes for lock and
unlock. There's no need for additional variants of
DEFINE_LOCK_GUARD_X.

Should the need arise to add add annotations for DEFINE_GUARD, we can
introduce DECLARE_GUARD_ATTRS(), similar to
DECLARE_LOCK_GUARD_0_ATTRS() introduced in [15/24]. But it's omitted
because DEFINE_GUARD() can be replaced by DEFINE_LOCK_GUARD for
locking primitives.

In general I wanted to keep the current interface for defining guards
untouched, and keeping it simpler.
