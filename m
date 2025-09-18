Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43062222B4
	for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232083; cv=none; b=BTvlFwX/bjh/AHHxuuR99GqYXpY24NQB5mtdTzRxdpTuVpqHIMjBgUKLKssKCRV2kfjxCqXom6J9S7Tkug9e/JsoqK32ZFZO6rtSlfiNsAqDjYHJ6sJH/2NwS2ufo2GjpTWWjV8SnG15ax74NCqbjLJ6ROXjtDdWkwn4tY5TTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232083; c=relaxed/simple;
	bh=OBdCMGeWv7G/tkOmZiDbcUQKLH/CnWF06gVEbnVu89c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0pFwTzdSkoV8aFzFqqVUYCt5B1tF/sZwwtlJgmF/OLVsGFSUO8+GsyDYn5VbGb9aJcYCueS50l1KD0xYK7wow93XIyZw1t9k8kheM+yHx6eeRNUTpDXsL9AUYJ9hor6RfNkJv7tWjMQSAiadSZQVVPtAcBbznb688KHCsoJMHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cfK9eoIS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cfK9eoIS"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b2400dcc55eso99632366b.0
        for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758232079; x=1758836879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mLiszfQw8YctXWgw7Rv1CzeIAYsEhv/enJDimwborHo=;
        b=cfK9eoISwy9D70FL722Pe/nKSe5uTxaEevf5/xvwpig9ErinOUk3ZlSBaP66vG95A1
         aUyIw3re0btHyZLNmgqJDBaEB6MDn3+gQl4o21fd94Ch/aruDenYqb2DHtHrChJNQVWh
         gp1jUTpNZmLu0Bs+ATlq8nAebiMdvbX030U+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758232079; x=1758836879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLiszfQw8YctXWgw7Rv1CzeIAYsEhv/enJDimwborHo=;
        b=qdD5SjqmwxzLZUEvgnD9BhduC+sAoJuu3mUnMtCA7JjU84ATv+XL7RIHA1GtuaJ5jK
         2vTRMQvvuxT6xib531ctZ/f2u4WP8ev1VXdw6+FUiR5OxIiCsRh7p3iN+bdVAfRk8Snj
         ANizcW53CYMgHZh35+yIO95sBlt382HBQa8cYgl5rq3DCRwMULyW4C32BQjGd9MsN5EV
         aqAshv+a6G5DX5LnKRxyGOVuHIgfquj+tkJMaY48bYo1+RlYG9uIt+xPqn+WHd2HykDw
         UACXM11+s5ZBCUxRkmbzFD+qroHY4Kv2MIIK+Ihzqggr1zvY1CodU81R9XNyg2in/Dmz
         MZZA==
X-Forwarded-Encrypted: i=1; AJvYcCVPyRkVoCho89uobaKntwHA1Sg6MNrQf9WVwrJa2gvJ23ssF+zHZ5I6UeCbcfz0eakwcnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwASDMMfPITZu2r9wa1Bs7oI1eGviHiE1an+gRMCaWxfWb5id3g
	F+zO8QFtMZqvVdW7fnzvmXB4RSLUF5ihTm5A0GRCt+ZLqbrWw0foWttmQ4yE3Xl1WmYYFd/8Fnu
	ZpRsPqH23HA==
X-Gm-Gg: ASbGncshr28tx4QQm2rHo9nPFrpWxNaYcsCZk9ynvFB2bBw/OIdR3u+AHZ6JQ8KquYg
	cKWfAd2dORH7PieYEbH3sNKCkonONJiyyPsD9C/dawJ3p8q/kL2+3VkjXCLVL1de/MQx3aDiqDr
	WtU5xbRZSNrU7Dr33RB2+OCBry6GK3BOofIw9S5WCUMm2neq9JEqjmABi+cS+Uf8O6doJi6HFTy
	3UtoJrHM0ImD4bV3he6KgbBZF1zIdyX+GXnyF/sWAhBY9W8Qc4BTOhiDL3Ub9UgNG01FPaMfwpd
	eJWKKQz6M++OpZCfjOdPIykMmiN9h9rGeOiRWVh7oa28TeRlIj8REO71daLbWkRlaXfiTdTYW5a
	q757WKc/Gca84/u2TBF/YwGtSZamEF0PM8xqnMujLUDovZuoKzo3waJ6OtPjM0xonupoaQN7NEQ
	zXJeP9bDG5KUpZV44=
X-Google-Smtp-Source: AGHT+IHv5kqm6QBIkkDHD3oRXCsb7vtTkp6yGH5d7hiIGbmC1pfBKZU1IsdeW2KfuXWiWbpRqX5FaA==
X-Received: by 2002:a17:907:3d8b:b0:b12:3f5f:603b with SMTP id a640c23a62f3a-b24ee3160f1mr82427666b.3.1758232078785;
        Thu, 18 Sep 2025 14:47:58 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd271fcd1sm271039666b.107.2025.09.18.14.47.57
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 14:47:58 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so215861966b.3
        for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 14:47:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHcKxMlASkYtjU1bhIlNxDmjUm7tdMjmc84cvK4Qpr5MnUiCWqZrtQn3PhZ0yFStZO1YM=@vger.kernel.org
X-Received: by 2002:a17:906:dc89:b0:b0f:a22a:4c30 with SMTP id
 a640c23a62f3a-b24f5685fdemr62738866b.47.1758232077501; Thu, 18 Sep 2025
 14:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com> <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
 <aMx4-B_WAtX2aiKx@elver.google.com>
In-Reply-To: <aMx4-B_WAtX2aiKx@elver.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Sep 2025 14:47:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQO7c0zc8_VwaVSzG3fEVFFcjWzVBKM4jYjv8UiD2dkg@mail.gmail.com>
X-Gm-Features: AS18NWBxHuMwwtU-EoNbPFA3uJ1YRJkAKqdurj12n-PWNJgH6ecKwZ8QZrX3P28
Message-ID: <CAHk-=wgQO7c0zc8_VwaVSzG3fEVFFcjWzVBKM4jYjv8UiD2dkg@mail.gmail.com>
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

On Thu, 18 Sept 2025 at 14:26, Marco Elver <elver@google.com> wrote:
>
> Fair points. "Context Analysis" makes sense, but it makes the thing
> (e.g. lock) used to establish that context a little awkward to refer to
> -- see half-baked attempt at reworking the documentation below.

Yeah, I agree that some of that reads more than a bit oddly.

I wonder if we could talk about "context analysis", but then when
discussing what is *held* for a particular context, call that a
"context token" or something like that?

But I don't mind your "Context guard" notion either. I'm not loving
it, but it's not offensive to me either.

Then the language would be feel fairly straightforward,

Eg:

> +Context analysis is a way to specify permissibility of operations to depend on
> +contexts being held (or not held).

That "contexts being held" sounds odd, but talking about "context
markers", or "context tokens" would seem natural.

An alternative would be to not talk about markers / tokens / guards at
all, but simply about a context being *active*.

IOW, instead of wording it like this:

> +The set of contexts that are actually held by a given thread at a given point
> +in program execution is a run-time concept.

that talks about "being held", you could just state it in the sense of
the "set of contexts being active", and that immediately reads fairly
naturally, doesn't it?

Because a context is a *state* you are in, it's not something you hold on to.

The tokens - or whatever - would be only some internal implementation
detail of how the compiler keeps track of which state is active, not
the conceptual idea itself.

So you name states, and you have functions to mark those context
states as being entered or exited, but you don't really even have to
talk about "holding" anything.

No?

               Linus
