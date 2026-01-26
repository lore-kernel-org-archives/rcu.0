Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC83101AD
	for <rcu@vger.kernel.org>; Mon, 26 Jan 2026 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471248; cv=pass; b=eB1ldrxXS4pnckJhnKyeIEZmgmNQRunbJksU7hQ6FYVTPN6/P7E6/IZP/MnuP36jThDAwYUrKpWDUdcybJu8Qpxem4MOWgnf8K5tJvVLicNXmXVpndrhwrWhMr/sDLUYXaT4hWELCq+k8uceU68JWFBUCMjntqNM5LMMKEEDix8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471248; c=relaxed/simple;
	bh=fG2Ruh+rMXy8HECrlWrSGEzE9JMwnw/wcqEcRF2te3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwiCOQPgrGdkyWmzc6HTfE4klzQV4OoEFpFruAGE5JdtMb/e1o49e/SR9NaYma3Sz9z8Q6sYq+AmPhCWzGark6M1QmHFRsDljWc/xyyR55UTemPRwzNggnoyXafhQS5ZJQstaUMIAzO0rXWrl4bM2UpC1J7IHM+zQSoiewLEM+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QPyFHk96; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QPyFHk96"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1249b9f5703so1040976c88.0
        for <rcu@vger.kernel.org>; Mon, 26 Jan 2026 15:47:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769471245; cv=none;
        d=google.com; s=arc-20240605;
        b=aM+kqovNfEcPatO29vvSQ9goku6tiG765yFV7H1JpkOAu6ErVdt3YwgN0nj4pHw7RP
         BiiVfOCngZKDcT0r3udhlmIExP26n+0cE8ptsfM9UDtr3S2BklucA4t2WaD+Odntr2Oj
         Laku2lrVYjtDNepH3a2uz46rex6x8pIxBWBV6dgkvak72oaHExGWJ2PzyJireCTyZFHN
         RWD2i2dpZCSQfyPkhcgFae1BXWOZEGo6crAiUjZzp049NXIPCpNFvDWvSzeMnPTgHVjR
         XYmdEVAxxMnelD0RGuGzgIAuZ78AWjN6tYblwrOyhjvxmM64sh7qB+A4KZUCtze6LeqK
         u36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X34tjfxPPMupW8WHmEJAIsWdH0Oem6uch60iKqedEdc=;
        fh=Yv17vwbCbvQQ+uc9f2rse5BvL7kasLkYtuI3RXv2Ji0=;
        b=RlBrUCuRohYPUsO3iA33WPWQzWiI5uBThUt9+PLzx3dVrUms47TGJUes3340AkDWR9
         7tbX46tUBRkcacOye07Le8awy1p5V0qLnPsS9xzV+C9nH783h8uwxGX7Q6i8g+MB4ujN
         FdHH0tjtE6hIgpDyngZORilHaKxco3jGm+knT2zdFSwxiq4wNaE9cV5RGxlUxNU630s5
         Wl5Y8v7/Q6s1kp7BhrIoqDyfBStGTAtGXkiuGVTvzIOKKw5janlfwq2x2mdvC9Ca+Xrc
         l1cJKx28W3b+204iCgxlxxgYDx5MkwSPmT43XPHBXAbmpnoCH3SVngW6OXY9OmgDxcqQ
         j3Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769471245; x=1770076045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X34tjfxPPMupW8WHmEJAIsWdH0Oem6uch60iKqedEdc=;
        b=QPyFHk96UvMrpMwkoIa7K76IVIsyFEnfZylNFV5QMW6rzMt1q1yhPRJPbtVPkVYr37
         QQih6C5oGngtDrT2O6TJ/NmalrhezMNkb25dAEFdF2KrioK3GhDmedvDZGFMwEh3ihqY
         JVQlTZ1GsSZw62zjipX4WnEYc1xlFLHZ/rBXw+v03T9uvrvWmt9jJfxjhDBTrivMhecH
         xY5XiTzs4FuuW3ITTswqPixr9Dy8rk2WBhWOlxNNBc7UF3/u5o1AfjHwCch4TOYbauT2
         KWPjRIH+OaDaBKqKOStCJSGsldadRt4KZBNG7dUZlgqW5w7DYgS30qdNee0ahFDUD1nl
         VIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471245; x=1770076045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X34tjfxPPMupW8WHmEJAIsWdH0Oem6uch60iKqedEdc=;
        b=GN1U1Z3LawR6TI72hwoJPRoDP7wY+0YLwy4JcB4D3ofVWA18d5JTnFVao5CVHJ7XPD
         XgX9Zg3dG09l2CGYv1QCc59/MuDhveISSO9OBCBZmgbYI7ZBWmX4LslbcKz6lp8StJVU
         anI9JzOzg2EaBejaJVWml3FFekDZxBYAWJS1OM5YB87hM0SxWF+cEF+fAM7BykiBdnnJ
         DEPdroCTm7c+O6YIE6OTdmOJLlSJwyhi8ovK/fPwucnHhJchFP+uy8lcIEo7nFt3rGOk
         kYB5EyNZxtiDGLcBgSpd3r4n7ZW1ggC3eNvNrsSRjyUulxbeLbjfBi4HiONwLS87Zann
         Rupw==
X-Forwarded-Encrypted: i=1; AJvYcCUqBcgXQqjIvPZg58sE+9KtEGpbG6c1Rmf5uPjETXq91G/C6tPGTD9cHcjnhIBPn1Ur/oE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyty27EGmx7ANdiN2MI2qHD1l2C1i8FPxc4UCEYFKNksnyTITRE
	nxuQCs94BWspZqIqciX3NdeLelVqGLAD8bNPI9V0cDgGTUHZ+wp5r8H35d9AtJEudR1Pj5KbXIV
	1rYoiv9WDNBgSQGdQxL6yxB1E21Ig4jC0EQjkF9nC
X-Gm-Gg: AZuq6aIisbq9QxNmN+sLQpm0VozcLt0IJpk758uWoVbfAFx/+aF6eOIWuhap+RpCLDE
	Z0AXoAEjK0GnsLiUtpgDOMP2cjQC/lK5RVNyTrMCNHjsuaS7/UledwcdTAGZ/nAWi8CxQJ7ZxPp
	spCrUAS7qS2uAntkbHlnUiRPrYASGvfmTLJNFLjMAPVP9tZP3TDsAetg6RIxQ8rXhz1nyLwIBYx
	9ZcTGmTo/K3s3J5qK7V05ymhdHYrwgWx4yHmsuQq2uz2HaMbXZh8RG86/iqY0temli4vukvNYj8
	1VWpAmAyJWZLfd6f6eNMCjEzj3gcAFIIbMitUA==
X-Received: by 2002:a05:7022:eb46:20b0:124:9e46:82fb with SMTP id
 a92af1059eb24-1249e468815mr157327c88.38.1769471245289; Mon, 26 Jan 2026
 15:47:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-16-elver@google.com>
 <dd65bb7b-0dac-437a-a370-38efeb4737ba@acm.org> <aXez9fSxdfu5-Boo@elver.google.com>
 <8c1bbab4-4615-4518-b773-a006d1402b8b@acm.org> <20260126213556.GQ171111@noisy.programming.kicks-ass.net>
In-Reply-To: <20260126213556.GQ171111@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Tue, 27 Jan 2026 00:46:49 +0100
X-Gm-Features: AZwV_QgcknJe0PlLV-z7bksgFQT7uSnaZ1B5QvyI9tPRocr5FzcCAIEUg9yCt-Y
Message-ID: <CANpmjNPs9CtY1w1-MqL1-CnHVFLxXoA2rbd6d2w4wfxT8AP0ew@mail.gmail.com>
Subject: Re: [PATCH v5 15/36] srcu: Support Clang's context analysis
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
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

On Mon, 26 Jan 2026 at 22:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jan 26, 2026 at 10:54:56AM -0800, Bart Van Assche wrote:
>
> > Has it ever been considered to add support in the clang compiler for a
> > variant of __must_hold() that expresses that one of two capabilities
> > must be held by the caller? I think that would remove the need to
> > annotate SRCU update-side code with __acquire_shared(ssp) and
> > __release_shared(ssp).
>
> Right, I think I've asked for logical operators like that. Although I
> think it was in the __guarded_by() clause rather than the __must_hold().
> Both || and && would be nice to have ;-)

Some attributes take multiple arguments (__must_hold does), though
__guarded_by doesn't. Yet, && can still be had with adding it multiple
times e.g. '__guarded_by(pi_lock) __guarded_by(rq->__lock)'.

Only thing that doesn't exist is ||. I think the syntax you ask for
won't fly, but I can add it to the backlog to investigate an _any
variant of these attributes. Don't hold your breath though, given the
time it takes to land all that in a released Clang version.

> Specifically, I think I asked for something like:
>
>         cpumask_t       cpus_allowed __guarded_by(pi_lock && rq->__lock)
>                                      __guarded_shared_by(pi_lock || rq->__lock);
>
>
> I think Marco's suggestion was to use 'fake' locks to mimic those
> semantics.
