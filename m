Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385D314D31
	for <rcu@vger.kernel.org>; Fri, 12 Dec 2025 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765535913; cv=none; b=rWbSS22f9dIZ3gLbI4h8NUMByi+uEDUrCvhRxhRZXUPczrMTtPDRB0bdWuewjjYzheYGhw7H+jpUinJJVOgrNoL3xjlyAzaPCBlAVSAuS4Z2hlstlIpKXz8NESF4B1ocFG3qtjWnXoG9sjGO/5YZn7XTnVSJAmsEw5bYqbhYf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765535913; c=relaxed/simple;
	bh=nctQCqtW4QYyeaejz8PEb38w/v2g7uc6tb41WntjKNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXvb4fDjv7LdUOpMv9kOy8cWDtFvbJOUXyhkQM3EKG+kIc3B5G924fccP9bbTGa+WGU9+FPL7M7s1XF9yvuhiDuxeS/X5RUZxMGs7i60GeJ+sDJEeIfRuavbbh6NhAkIYbK+UiHtvVXP1eRF2/LnA5WaJHCJu/AtlfgqQCU8D4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wtLV9uLE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wtLV9uLE"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-298145fe27eso15836975ad.1
        for <rcu@vger.kernel.org>; Fri, 12 Dec 2025 02:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765535911; x=1766140711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nctQCqtW4QYyeaejz8PEb38w/v2g7uc6tb41WntjKNI=;
        b=wtLV9uLEJ8zGhaL4wKcOMyzwlj7uEoqLP5ERNoV1rB3MPH+6lFfeCEOqtTG+oP/fcW
         HGpBFUZbgj83fZgoAxHjZqAy9ZpcXj3xsbc+3VWVErj6/tKNnvoOy/HwS+/1+X4i89iB
         +X26zSMrjD7X6MDPXJTfhiOSF2kD8XWxXhjnE0P0BBmQ6OrgN49HNUgVVdxxb3VL/+gC
         POW/ri/J2PD0pcCUBURT4yXCX/Miipf/Ma3wOy7gBSu+4ewCZzxDCRp2MLTcR13GzmII
         KqNixkzAhP2++PWhMyYRYPJyGGpka2IPweeHNWT8olNfOSrAx8B/sH65h/hs690SL0/0
         H+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765535911; x=1766140711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nctQCqtW4QYyeaejz8PEb38w/v2g7uc6tb41WntjKNI=;
        b=lPoSw2Q8odDXmTS4PjKTaK4uK5w0+QIrZqIKQFbO5p/sX0xfn/LsysFAV8Rejags58
         tgdTUjKZkF6CBC6h6+S8NBez5Y1w7MbtwIXnUvaA5Hn4taB83on/uNf4yzUNnz/MwFXw
         RhIsQWLkGALB+mJFr9ZOCCOf8fACQoAU2E9IR/bFvf5GWbDRbGk5l0FWo7EX19iiGwlk
         Zidr6705s63rCluY/uctmjUe5TEmbBOXC+0bwGWCMf2ScUvs5LAC7yWitAB9sMgIFA6l
         irqsitirJC2LKzzn2e3DmxaVcVnmFoHgVbnjKwv09L0BHTewGYnjKwzOL2hHHPlbwhpx
         nkHw==
X-Forwarded-Encrypted: i=1; AJvYcCWuEHZ5LQPE0hQzYedQqAK6474cnPOaokH3ymhfQTyclI5rDERytEdDx9xO2nHr1p6mVjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8tUyz8y/58/6UeWUpFF91lmRf7IeITRNGKoIjFG2TLm+Azii5
	8fdUd1NNx8wjwIqg+DLH8FX2Xuivcxt1MlpiYTRNqronHDxhEFe5+8vwSJPhkOQF51NB5TnphVh
	KO5a8y5z1HFHfB2ILzZGPPewLIM3saqGbkGkLccSm
X-Gm-Gg: AY/fxX7d9sj3nJTg+o74TxnO0IApgjBeQhxsE092eXHbD0NLbK77uZrrcG+sTaene6W
	kAtKvvr0b5nH/dQf0KXHCxD0D/d+IHfC3+U7AtoULJqFLqShMgoVnz08qDJ/MrdD7ksTIwiD66D
	Gc1kMBiNARAD7TGDrvmCBCVaMI9j7LOlLDul2D2G2VS5zjftW+xg/U0475YzQpc8hOHB+oynfjS
	LAiRdleKiXhjJI9O1vueaSdTZHiXeETF7/2dH7gj/Ygn3tE3v2nYyuF6tNhsJ1FpDbVlA+kLwJz
	g7XUt99Zj8xVRxz6Kn7cZQTbN+4=
X-Google-Smtp-Source: AGHT+IHEQqbAgYefprbsSuiVLt7KDiCECxoW496oPYm+Bj8DbPCCV7ccSZXk9zoE7kqarbEHot35Mb+a9uphNkvnkwk=
X-Received: by 2002:a05:701b:2719:b0:11d:c86c:652e with SMTP id
 a92af1059eb24-11f34ac540dmr1125346c88.5.1765535910093; Fri, 12 Dec 2025
 02:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120145835.3833031-4-elver@google.com>
 <20251211120441.GG3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOyDW7-G5Op5nw722ecPEv=Ys5TPbJnVBB1_WGiM2LeWQ@mail.gmail.com> <20251212093149.GJ3911114@noisy.programming.kicks-ass.net>
In-Reply-To: <20251212093149.GJ3911114@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Fri, 12 Dec 2025 11:37:51 +0100
X-Gm-Features: AQt7F2qnWyV-H6zf6AeMnZTuFb_nb7UwLLraoghpFqSJ0q6RecRlENqaq0woPuo
Message-ID: <CANpmjNPcw5AnpLpaFvyRee7mH12Ym-NKTx331xXEusK5zpiscA@mail.gmail.com>
Subject: Re: [PATCH v4 02/35] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
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

On Fri, 12 Dec 2025 at 10:32, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Dec 11, 2025 at 02:12:19PM +0100, Marco Elver wrote:
>
> > What's a better name?
>
> That must be the hardest question in programming; screw this P-vs-NP
> debate :-)
>
> > context_lock_struct -> and call it "context lock" rather than "context
> > guard"; it might work also for things like RCU, PREEMPT, BH, etc. that
> > aren't normal "locks", but could claim they are "context locks".
> >
> > context_handle_struct -> "context handle" ...
>
> Both work for me I suppose, although I think I have a slight preference
> to the former: 'context_lock_struct'.
>
> One other possibility is wrapping things like so:
>
> #define define_context_struct(name) ... // the big thing
>
> #define define_lock_struct(name) define_context_struct(name)

Note that 'context_lock_struct' (assuming that's the new name) can be
used to just forward declare structs, too, so 'define' in the name is
probably incorrect. And to avoid more levels of indirection I'd just
stick with one name; if 'context_lock_struct' isn't too offensive to
anyone, that'd be the name for the next version.

Thanks,
-- Marco
