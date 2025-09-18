Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168B313296
	for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210993; cv=none; b=Cjozsj1DpuLtKQ0jj/iW+w8GYhk7Bd+VBUnjMDURwcykLeIZImvY6IRtNoG6kV4o8tSELzqVcN66v+9QcjKX+YX/d48quco123/DQ51bXNOU+yZ9bPHOiHeKYBkLYjsl0bVfKEYiTnKvK1v57fjWvoUkN21b5Evebzn3LkBQx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210993; c=relaxed/simple;
	bh=XhR1h2E8azi9+Iqslf03I/SakVc5s2CaBmw/N8HkwwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaKNwDxShv5Trr6iUPzJyTSS7FonSdl2d4vigUiopwZYSfLY4jNo/aUZB3txd30vLzDv0lvSbctD+P/nqFahnrChnkCl3QNl6FNFZWdWjHgW5wSYgn1/WQugfWlhSKi+JGCfpCD/2sHZ6t6aYEDNwqPFaOusMFv8H59JKnDyunA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PKwILP4Q; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PKwILP4Q"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3610cb77a2aso12196881fa.0
        for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758210989; x=1758815789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hpKO6CsQCuex3g+QZ22KGPC+ZgcKRmVKS1THDCqCkXc=;
        b=PKwILP4Qw/F6r1G9jAuW3x+KHdLqbTsGTExJoGskI1TgcdYwqjhr+K8IfF/VkImrkO
         18bveLC3gs+xTqJHw0eI/MK+do4yyrgUZzVWqhMqrB/GRruOlXwv4GqTvOzyZBgZCwGc
         b4H0biACijJvytI0xGyKiEoXHMenz601ysGUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210989; x=1758815789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpKO6CsQCuex3g+QZ22KGPC+ZgcKRmVKS1THDCqCkXc=;
        b=d76x6sjhV4FTpvFAsM3egxdZO3REhtf/bKnYvCypCLbrUjMJfcN9wTxzZsMbvZnmWE
         a26Y9WZY7mu/bHU3ewynfblaetFDXl5W/BdbFzMMzQUfNW3NeSYqxWtKbZQFZ+6dICEn
         jX+I8eXE8qmBqxCM6quBs5MpQ9fOMZEzeO+PkJDWxWHFDZf+jamiwuOqQjPOtKjaJ0L+
         gnvQZRo3oN34iI2XDxhIMk6Ls/5SuuJdFTXe5pVf2ZCGilUlyfPhmtiSrVeifXLqWmHw
         1fbcm/SUgQFY6dGtSO1PahKbzA9hMZGxEgVaCUSUdmjsdVEG3NXCVlvRh/eueMJUQLnX
         nq/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsGTUxtA2ujW5+KMUOVPMuihgZvbcjNrC97ZaPI97IDfWfq5Hilec5az56QUiQxdqFuU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOJ8FFhMej+40xbzhDsKAOwK0aG4q/o7PIScxOSCqPJXbiHcOo
	nIU0W3B0yq4h6gDHVbZWg3EUu+S1j62tfX+zPAjrhXLs3l5N7bFRAun4q2tUIUuAMfK28dDmEH9
	8j8VhfydDpQ==
X-Gm-Gg: ASbGncsK3IQq0rbEu49Xke5jsYRmBaL1z7bFO0owNttcRpiZydEAFGOcniAlNSyrtan
	3gTofd4r6+ptMaK6w8j0aeaWuWrnQ+dQHuXflozDPAqVy3k9NIgKhKZYlvHJ9W7yOTxDsxt12+g
	S4+ALGX0KVVEWZeVLTEoyra7kpab3G/2Qb6oVlHOw8Ww3ig1bHQSkv2IvuEN3yHUQm70rXuyy61
	wy71UbYk3oTgsJqMWlHkHRxmReqAasoutsFrigo0Su52bDX2m4y9Jbkr9hniKF66NaCCVqMXXdE
	8gXkU5ykA0mmDW/8Vr1nOZhuM6TR5VrXl/jdDacRChyb5eZsOVsv5dijL+DJyXC+5Y3AFcKXkbM
	RHftiS2446loeNY9AOcNiMFsmd3a/f8RPJloPLFKmmaj53cFte63tjczNAHsY5Nxtp+kgo5xft6
	C4xKrDXreHfRjSHFL9BNM=
X-Google-Smtp-Source: AGHT+IFfEh3aHH3AlQyVhkh6wnz6KCGAoyQyriMGz7GZpdN2ahZAvnEy4ZALPoXs25j7Sv8mszRFMg==
X-Received: by 2002:a2e:904f:0:b0:335:2d26:1408 with SMTP id 38308e7fff4ca-3617529137dmr8615681fa.21.1758210988743;
        Thu, 18 Sep 2025 08:56:28 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a9571dcbsm761208e87.96.2025.09.18.08.56.28
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:56:28 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3515a0bca13so25297681fa.1
        for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 08:56:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6Zf+jKMzCEq9VKpkctK4ATYSRWWy8ASUBpfH8ZlG7gdmKw4Tgxgkc2WKfJXXm5N2KfHE=@vger.kernel.org
X-Received: by 2002:a17:907:9612:b0:b10:ecc6:5d8d with SMTP id
 a640c23a62f3a-b1fac9c9b84mr417765966b.26.1758210601571; Thu, 18 Sep 2025
 08:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Sep 2025 08:49:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
X-Gm-Features: AS18NWBk4u9ObN57KesSGhJyt-aPlWZgKdxYhvzpAyoaxlNUF53WHe4dSKjzUBg
Message-ID: <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Compiler-Based Capability- and Locking-Analysis
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
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
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 07:05, Marco Elver <elver@google.com> wrote:
>
> Capability analysis is a C language extension, which enables statically
> checking that user-definable "capabilities" are acquired and released where
> required. An obvious application is lock-safety checking for the kernel's
> various synchronization primitives (each of which represents a "capability"),
> and checking that locking rules are not violated.
>
> Clang originally called the feature "Thread Safety Analysis" [1],

So this looks really interesting, but I absolutely *hate* the new
"capability" name.

We have existing and traditional - and very very different - meaning
of "capabilities" in the kernel, and having this thing called
"capability" is just wrong. Particularly as it then talks about
"acquiring capabilities" - which is *EXACTLY* what our lon-existing
capabilities are all about, but are something entirely and totally
different.

So please - call it something else. Even if clang then calls it
'capability analysis", within the context of a kernel, please ignore
that, and call it something that makes more sense (I don't think
"capabilities" make sense even in the context of clang, but hey,
that's _their_ choice - but we should not then take that bad choice
and run with it).

Sparse called it "context analysis", and while the "analysis" part is
debatable - sparse never did much anything clever enough to merit
calling it analysis - at least the "context" part of the name is I
think somewhat sane.

Because it's about making decisions based on the context the code runs in.

But I'm certainly not married to the "context" name either. I'd still
claim it makes more sense than "capability", but the real problem with
"capability" isn't that it doesn't make sense, it's that we already
*HAVE* that as a concept, and old and traditional use is important.

But we do use the word "context" in this context quite widely even
outside of the sparse usage, ie that's what we say when we talk about
things like locking and RCU (ie we talk about running in "process
context", or about "interrupt context" etc). That's obviously where
the sparse naming comes from - it's not like sparse made that up.

So I'm really happy to see compilers start exposing these kinds of
interfaces, and the patches look sane apart from the absolutely
horrible and unacceptable name. Really - there is no way in hell we
can call this "capability" in a kernel context.

I'd suggest just doing a search-and-replace of 's/capability/context/'
and it would already make things a ton better. But maybe there are
better names for this still?

I mean, even apart from the fact that we have an existing meaning for
"capability", just look at the documentation patch, and read the first
sentence:

  Capability analysis is a C language extension, which enables statically
  checking that user-definable "capabilities" are acquired and released where
  required.

and just from a plain English language standpoint, the word
"capability" makes zero sense. I think you even realized that, in that
you put that word in quotes, because it's _so_ nonsensical.

And if not "context", maybe some other word? But really, absolutely
*not* "capability". Because that's just crazy talk.

Please? Because other than this naming issue, I think this really is a
good idea.

           Linus
