Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67F2FE57B
	for <rcu@vger.kernel.org>; Thu, 20 Nov 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662925; cv=none; b=jIooRHn7GuND/6B3gW2KnailwCH7tN/CRxemuh2nERRryOqw5nKsbIFfqTPSCjCmpgVidpIGUdmmmsa1+l4ymALMd3ivA1cswk775z0UT38Yc1SYM8ng/iuXVR7NS+Zo3H8K1xgRR7PYQE79C5QhPAWhSvJKZcCIDgxF/yfm3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662925; c=relaxed/simple;
	bh=wecZEUleM2pVH/ldG6VyoxAP3Tx+t9JIJBh2fst1eeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLvGqqvxtEYj1rUz9tBKaA55zftJkzbYIv1cCUBjuaG4dwKxo18Cb4GfqWNWFBp57ZUrJK1uM/2/OnVWd3zBe6ZlKUcDZqHgI9p+T33vrZiuzKdVksC9o0Bmf8M4AlhiQcXkmrK71gWD1Ode0wk32araLVQBIIDFOEXPh/tdecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DsPPEzzh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DsPPEzzh"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5945510fd7aso973263e87.0
        for <rcu@vger.kernel.org>; Thu, 20 Nov 2025 10:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763662921; x=1764267721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BPfdnrOHpw/8tC+sL0oorkp9gKYtrunKdRWYzTn+GA=;
        b=DsPPEzzhi4C2gslYfFn+5cYxvLt+5MraE9h9QFK9d38zYf/2T5Uf6XfhmkL/l7bxvk
         b/oaTjawR7sZEt0ohrKP5oMQRM+zrWkevB8Eo3dtPgE968513eqMb+zXAzqYzGQyaflR
         LOUzA3lM8uRXfJ/48onTcIXe76eyQvuvkbOIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763662921; x=1764267721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BPfdnrOHpw/8tC+sL0oorkp9gKYtrunKdRWYzTn+GA=;
        b=lU/f7pFCFZZnmh5Gz6nd/HyD39FsKFS5S/o7aQoJBpvL12YFL1/6kqnKXOGNH2V95D
         UIDRsVa3xmlZs8jInXDiCccSs+4bGX6cJ62vHLVycHTnASpNwIG9xx87Wb+G0QbOE43G
         UVfF6GKCgPmViMhaVeQzUdApbBc+fAnDk/R//FT1gT1RKUmj1PcEmvsgeCmR6Z/zXD4c
         wz9onhwfOj2N0zT/Z7g0xKSZA7/SsGuZhMcmsACV8CFvyBI3iQI0msiNEb2w6cQder9o
         lxBHWnz9AoofU/J/EghsAA6+85B890n7s3JYkIAFC9ns9q0bWrJCHsRQ8QQ1hghBvNpk
         3tjw==
X-Forwarded-Encrypted: i=1; AJvYcCWmbFA21KLC3jylfVlgUjnSzYmvx7i53I/GkdPb+i3IBOwnJPzy0WlWlul0MAZHytS4IPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze1e3hBdt3tVP+vcMfjidgvYH4AsrtMJAb2hspqd8HKoLcM99n
	jDRD9v6XcH1oUi2SrtaIxfOw3zBAbnhuxePhXrQb4qx9QZMoqA2nnnMJ2qMjEP2FwvNaFGmukJY
	8Uw5usR5kvQ==
X-Gm-Gg: ASbGncsIizvUWytuZLcl2skZhKrjVQInOYpjdSTmAaEfHQx6WKDcLU9c6T9/9I1Y7cM
	vjMJkDflO0506DvRcNeRKtbDhtv3VJ0fQk6g50uy5SMsR0aCOC/LOhsSxWY0Ms0FBhwp8oddqzM
	xNxHLi4ATJfj2Pd16OcPcG/GSzT1PRR5mzjMq0YByQQQ5/R9I7jI9LEqRj3UGIgibqVhnB5Nvkv
	Rof8lva3BC6DUepGfgBlESt/t5rP0RkQrYp30TQiEDRw5E3KPxSL46/hw4hNqRla+SAjBzPyyHD
	Yt8GzkKFm0IFA3/vTC/t112TkohlNrg/xMNplhrGaS7Gh00BnYwLjygbbnwjJXRv8w/3Lz26hFh
	+fU9aE/wjl6HFnI1CAo6Fd71F/jYx3/hPFqUQIBTbss5+UBzwtVH30YkmcXzKQ5eVOHm6I18rSw
	UCsHFXTsYRgaiJBy2EYKkpoIkT24GRD+FZuuQyuIWHZ5Va4T28b1RcOaq/8xbp
X-Google-Smtp-Source: AGHT+IE7ouPN3dP79JVyARFuT5NPafPAZAP0o3uMX5JZKFRx3ezqFpkSjT14p57vRuCvIQ7bnZBhyg==
X-Received: by 2002:a05:6512:3d0c:b0:595:831d:2308 with SMTP id 2adb3069b0e04-5969e2ae98amr1348443e87.1.1763662920797;
        Thu, 20 Nov 2025 10:22:00 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db881cbsm900403e87.33.2025.11.20.10.22.00
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 10:22:00 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5945510fd7aso973239e87.0
        for <rcu@vger.kernel.org>; Thu, 20 Nov 2025 10:22:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmkEyPAiQpwDhdMmjYS3ZekoOL/MMTSVaZ4pLT2jbw3dKruXxRq362Jm8RLCWiiOqO49M=@vger.kernel.org
X-Received: by 2002:a17:907:7f0a:b0:b70:b71a:a5ae with SMTP id
 a640c23a62f3a-b7654fe9b97mr482177966b.44.1763662490181; Thu, 20 Nov 2025
 10:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120145835.3833031-4-elver@google.com>
In-Reply-To: <20251120145835.3833031-4-elver@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Nov 2025 10:14:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whyKteNtcLON-gScv6tu8ssvKWdNw-k371ufDrjOv374g@mail.gmail.com>
X-Gm-Features: AWmQ_bk-my8wSL6P8yRhTUREdDraem8VrQQmjD7uS2S9oN6T2mRX46ftlS1ytQU
Message-ID: <CAHk-=whyKteNtcLON-gScv6tu8ssvKWdNw-k371ufDrjOv374g@mail.gmail.com>
Subject: Re: [PATCH v4 02/35] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 07:13, Marco Elver <elver@google.com> wrote:
>
> --- a/include/linux/compiler-context-analysis.h
> +++ b/include/linux/compiler-context-analysis.h
> @@ -6,27 +6,465 @@
>  #ifndef _LINUX_COMPILER_CONTEXT_ANALYSIS_H
>  #define _LINUX_COMPILER_CONTEXT_ANALYSIS_H
>
> +#if defined(WARN_CONTEXT_ANALYSIS)

Note the 400+ added lines to this header...

And then note how the header gets used:

> +++ b/scripts/Makefile.context-analysis
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +context-analysis-cflags := -DWARN_CONTEXT_ANALYSIS             \
> +       -fexperimental-late-parse-attributes -Wthread-safety    \
> +       -Wthread-safety-pointer -Wthread-safety-beta
> +
> +export CFLAGS_CONTEXT_ANALYSIS := $(context-analysis-cflags)

Please let's *not* do it this way, where the header contents basically
get enabled or not based on a compiler flag, but then everybody
includes this 400+ line file whether they need it or not.

Can we please just make the header file *itself* not have any
conditionals, and what happens is that the header file is included (or
not) using a pattern something like

   -include $(srctree)/include/linux/$(context-analysis-header)

instead.

IOW, we'd have three different header files entirely: the "no context
analysis", the "sparse" and the "clang context analysis" header, and
instead of having a "-DWARN_CONTEXT_ANALYSIS" define, we'd just
include the appropriate header automatically.

We already use that "-include" pattern for <linux/kconfig.h> and
<linux/compiler-version.h>. It's probably what we should have done for
<linux/compiler.h> and friends too.

The reason I react to things like this is that I've actually seen just
the parsing of header files being a surprisingly big cost in build
times. People think that optimizations are expensive, and yes, some of
them really are, but when a lot of the code we parse is never actually
*used*, but just hangs out in header files that gets included by
everybody, the parsing overhead tends to be noticeable. There's a
reason why most C compilers end up integrating the C pre-processor: it
avoids parsing and tokenizing things multiple times.

The other reason is that I often use "git grep" for looking up
definitions of things, and when there are multiple definitions of the
same thing, I actually find it much more informative when they are in
two different files than when I see two different definitions (or
declarations) in the same file and then I have to go look at what the
#ifdef condition is. In contrast, when it's something where there are
per-architecture definitions, you *see* that, because the grep results
come from different header files.

I dunno. This is not a huge deal, but I do think that it would seem to
be much simpler and more straightforward to treat this as a kind of "N
different baseline header files" than as "include this one header file
in everything, and then we'll have #ifdef's for the configuration".

Particularly when that config is not even a global config, but a per-file one.

Hmm? Maybe there's some reason why this suggestion is very
inconvenient, but please at least consider it.

              Linus
