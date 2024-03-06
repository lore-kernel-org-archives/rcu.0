Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B613E7E9
	for <rcu@vger.kernel.org>; Wed,  6 Mar 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750626; cv=none; b=ZNdbkkI4eTUkUUV9fGM5kWnhb1ApadPzGFv1E+HpjH0SYOe6RtJU7atXpiWxHgclyU4Qo8QVbx2m+kyg+hJ5R5yb5G2l49FY0Of3aXNaJNz+PlPPevNjNIitoZTy+2A34FSM4MuhopvNM6yvhK2MCq8244BD3nfeIEV7wgQuZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750626; c=relaxed/simple;
	bh=sMqhYwV20Y535DYN+vGw6lCYwpXjUAzsUCGQTdaeBto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RauOZ2krbYuitIXvr/VVjwB3k22i0aVQJfghrcM5SJh0p9Z0AYJrherl5zDNxp4raOoKP1f9hEaABhytT+e7t/GcuSUT7udlTyLndegfct9XsrPLwVTDtVSUomc2eL93Ab8SDtypCpEKj4JRWhBbfD7mkr15So3oqimw++Ppes8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PKYG0eNe; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PKYG0eNe"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso11280266b.0
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 10:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709750622; x=1710355422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DQKl6UzO1h7CA/xfOVaLJcIbW5ASITdcUcyzKmlemHI=;
        b=PKYG0eNecOmdTpLL+RPIqV9CBWk27H33G2ZSU9x07XZ03QrLVLugxwOoQhB9qfB2af
         swC9ixmsMyHkI2NRaDSMUBkmQ1K21O6DarmJ9J2azk+3WIT+S1zbJtX8Vff8CJEsf6jI
         NBudWr79uVkqAHdDX/sCru6/P6hPk1hEV+5fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709750622; x=1710355422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQKl6UzO1h7CA/xfOVaLJcIbW5ASITdcUcyzKmlemHI=;
        b=EWmPj3lCMqMvpdT0WDF8WDwPXEBFR0Fz8Pq2X8/L1ZMpH3FR1svz6+MKtBVQKB2nC3
         /KLEgh0P7SeHMQgaPVgbUJCIdieajgl0mLF735p7j0ZWdfeMH0wmsEnnO2skbFV7I4Eh
         1ZJmj7ZO5c5ljuj5xByS2bIPtln+Shn3HwVkvtmlCBKfot1NbVh9abIuFB3UyrKiFLCN
         1qaeXGuq0sf6D/faD2WWCFdWRKCSYl9MIPLb4gSr7XuDaSPwqWhyiNXTeW09zLr9ZMqv
         yQUhnW8k+92fwV1rYe1AR74FE1zLm0+Wp6e9fKT4VhEPy8XPvWIQzEHJazB+M5030SW9
         fUDA==
X-Forwarded-Encrypted: i=1; AJvYcCU8qVVoNgeV5sUtI0dG32yYrjzL/qBYVEwgqMX/K/ZQCbqWoVOczaH7emSPT/ihjNRoU3E8E8xYqCjwNMY+IzJsOZMh
X-Gm-Message-State: AOJu0Yy+KAhwEj6SJZAON96MdVsRApbucHCe7fwloiGv69RL6h5B7WyZ
	bjiulh95rryQMWGNYyR8n8cckNWq2JGgUTTSoQPBnlWupdr4Ha97VbchKOo999qMF2OEyt1oUgk
	oX9I=
X-Google-Smtp-Source: AGHT+IGcuk9Sf1h32YIywf/IHOn055Dg7++vSgLn1a7v1DUpSC+adPug56UPz6tGhPDeh3vV+x5dtg==
X-Received: by 2002:a17:906:5954:b0:a45:b7a4:93e4 with SMTP id g20-20020a170906595400b00a45b7a493e4mr1975972ejr.18.1709750622643;
        Wed, 06 Mar 2024 10:43:42 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id gl7-20020a170906e0c700b00a44e65447f9sm5098433ejb.7.2024.03.06.10.43.42
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 10:43:42 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso11278966b.0
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 10:43:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUusq+qGvO9HcQlTBJbt7YcyTw22Te/T/SGSil05sOdm7UD2aHdWTyqf44nHYZ7CoEdEakQCvziZybd/3ku0YGF2269
X-Received: by 2002:a17:906:f898:b0:a44:17da:424 with SMTP id
 lg24-20020a170906f89800b00a4417da0424mr10700423ejb.56.1709750621742; Wed, 06
 Mar 2024 10:43:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com> <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop> <20240306130103.6da71ddf@gandalf.local.home>
In-Reply-To: <20240306130103.6da71ddf@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 10:43:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
Message-ID: <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 09:59, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> IIRC, the original purpose of READ_ONCE() and WRITE_ONCE() was to make sure
> that the compiler only reads or writes the variable "once". Hence the name.
> That way after a load, you don't need to worry that the content of the
> variable you read isn't going to be read again from the original location
> because the compiler decided to save stack space and registers.
>
> But that macro has now been extended for other purposes.

Not really.

Tearing of simple types (as opposed to structures or bitfields or
"more than one word" or whatever) has never really been a real
concern.

It keeps being brought up as a "compilers could do this", but it's
basically just BS fear-mongering. Compilers _don't_ do it, and the
reason why compilers don't do it isn't some "compilers are trying to
be nice" issue, but simply a "it is insane and generates worse code"
issue.

So what happens is that READ_ONCE() and WRITE_ONCE() have always been
about reading and writing *consistent* values. There is no locking,
but the idea is - and has always been - that you get one *single*
answer from READ_ONCE(), and that single answer will always be
consistent with something that has been written by WRITE_ONCE.

That's often useful - lots of code doesn't really care if you get the
old or the new value, but the code *does* care that it gets *one*
value, and not some random mix of "I tested one value for validity,
then it got reloaded due to register pressure, and I actually used
another value".

And not some "I read one value, and it was a mix of two other values".

But in order to get those semantics, the READ_ONCE() and WRITE_ONCE()
macros don't do just the 'volatile' (to get the "no reloads"
guarantee), but they also do that "simple types" check.

So READ_ONCE/WRITE_ONCE has never really been "extended for other
purposes". The purpose has always been the same: one single consistent
value.

What did happen that our *original* name for this was not "read vs
write", but just "access".

So instead of "READ_ONCE(x)" you'd do "ACCESS_ONCE(x)", and instead of
"WRITE_ONCE(x,y)" you'd do "ACCESS_ONCE(x) = y".

And, to make matters more interesting, we had code that did that on
things that were *not* simple values. IOW, we'd have things like
ACCESS_ONCE() on things that literally *couldn't* be accessed as one
single value.

The most notable was accessing page table entries, which on multiple
architectures (including plain old 32-bit x86) ended up being two
words.

So the extension that *did* happen is that READ_ONCE and WRITE_ONCE
actually verify that the type is simple, and that you can't do a
64-bit READ_ONCE on a 32-bit architecture. Because then while you
migth guarantee that the value isn't reloaded multiple times, you
cannot guarantee that you actually get a value that is consistent with
a WRITE_ONCE (because the reads and writes are both two operations).

Now, we've gotten rid of the whole ACCESS_ONCE() thing, and so some of
that history is no longer visible (although you can still see that
pattern in the rseq self-tests).

So yes, READ_ONCE/WRITE_ONCE do control "tearing", but realistically,
it was always only about the "complex values" kind of tearing that the
old ACCESS_ONCE() model silently and incorrectly allowed.

              Linus
