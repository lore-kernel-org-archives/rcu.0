Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C737A78C8B
	for <rcu@vger.kernel.org>; Thu, 31 Oct 2024 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730334095; cv=none; b=fI37+m1txDhaiPDsrRWPc9YJA2bSnH4Otnn3jyT/lAqL02lPedlYpXXQ6cuJuds7bcVJCS07CZsvEhobcL5UQyPx+184rJGq56vZFiggMYbnv2uSgSCY7aO0v9VN8N4dDeOU3eua/Zqkrcn3FbaR/kuWil4eFaUoViomkzNwl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730334095; c=relaxed/simple;
	bh=IxuBFWwJHOt9n1GIDGvzAIhozCCp5glwu9hSR9ARUKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCqN30O5IKmWEQqnQ4ThDqHEMAXadKA8zYeFVrCE58XPAA+P6WrO++9dNy66Hdp6IgTeQZ7RR0isgDESm5tAFlzRUHvJvty916mInK3g3PHl8yuUI8EK8PrTxYWYQn7msOQw5bqgOLmJFCDETb6yuo9DnQqVcnhkNALABYVccuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GwCDQagL; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GwCDQagL"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so2864371fa.3
        for <rcu@vger.kernel.org>; Wed, 30 Oct 2024 17:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730334089; x=1730938889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEBlVMVMu5bFS8p6jyDjYwXC2E+qbBOMtmnoQ6L7Rno=;
        b=GwCDQagLK3m7yHxKMvolXKWWh3hVvAnmUsSgMVXpZi7VL6u/dzSScflL55EZ02etmh
         XyV4jDhY2GO10Ftj053ZJWHcskqcYTzisDW3fm75fN8Riv0zhP/LEk0Djk/JoSHhYNy3
         Y4cpyA6Jd+XHAqewvMr1ovWE9wPCe0rOmSTC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730334089; x=1730938889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEBlVMVMu5bFS8p6jyDjYwXC2E+qbBOMtmnoQ6L7Rno=;
        b=uJNA1drBCwmAdbpWP7x297erMrr/n8G3LGWBp5qrAtHhBVvuHpDquFEtDDU/GRtLCc
         u+lwFQLje/pIg4O8ndtMIOGY1my1S8tmdTxJaWgGZoD9TbKhnQwv74XuIEwB0Ue2uBw8
         3eMYuGrpWh8UtIa76BCV3Qc9lQPKmTF4cOUx6N8fCiMC6mO8J0vQXmw3v4MNwaq/Lgnx
         BOLKo+Rq90P+azp0VWB8vcYAWZXd54fOUHTUrfosTaCwvGjFUb4f+FbGbBR/ma6MY+ku
         VoP59C8EKTG4lQ60MpUI9i7FRwvdHZrgrUBwwT8lgq2FunmEE+yy5O9+kI8RO5NJDnaD
         ReIg==
X-Forwarded-Encrypted: i=1; AJvYcCVHgzKpthtbEM9tWWTFgyGaxVLX5MHeaygb0vT09WCvGzoj0vwJf6BTpIgH5Ef5mNFWzgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5McxItFAlFryUcY87x7OiFbxMxws06JngH55VxYLCcxK2rw++
	MnM1Gen3vmoGY+SRFdxiRS85atwVeAtFdlUE/+oXWPFYmE7N+q7oq+yRWbDuDuAJVx1hDJXlPZJ
	uSVaz
X-Google-Smtp-Source: AGHT+IHPDqnpXNpMmE4efHZygTwIJ8uWiAqWoRBAhBQmfeqRzMIR4pOCex14dk+PViGseze6K80W9g==
X-Received: by 2002:a2e:bc1d:0:b0:2fa:d317:b777 with SMTP id 38308e7fff4ca-2fcbdf6882emr85536851fa.2.1730334089028;
        Wed, 30 Oct 2024 17:21:29 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8fac17sm457771fa.140.2024.10.30.17.21.27
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 17:21:28 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f72c913aso634699e87.1
        for <rcu@vger.kernel.org>; Wed, 30 Oct 2024 17:21:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbMJXNmKW2d/7WOe6EYGZ7ATPrPQx1kshTZSjWr94xgc9Gmyk+4xva2f62HJdtyZzxfU4=@vger.kernel.org
X-Received: by 2002:a05:6512:23a0:b0:539:f995:5b00 with SMTP id
 2adb3069b0e04-53b348c3a47mr8700446e87.7.1730334087057; Wed, 30 Oct 2024
 17:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
 <20241016161931.478592-3-paulmck@kernel.org> <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
 <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
 <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop> <d0adc7d14da0f21909eef68acf19fc5706a4b1af.camel@mediatek.com>
 <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop> <CAD=FV=WBcOCGbD0haRYLGgAFpDhfoqMW8mvj9DEA0CSPHG3Owg@mail.gmail.com>
 <63859e70-2ea7-4a67-857c-fa226566f25a@paulmck-laptop>
In-Reply-To: <63859e70-2ea7-4a67-857c-fa226566f25a@paulmck-laptop>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 Oct 2024 17:21:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WsM=om=xobfWkC8nLQNK89xdyNNX=L1=DjD79ZPXYxRg@mail.gmail.com>
Message-ID: <CAD=FV=WsM=om=xobfWkC8nLQNK89xdyNNX=L1=DjD79ZPXYxRg@mail.gmail.com>
Subject: Re: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()
To: paulmck@kernel.org
Cc: =?UTF-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>, 
	"sumit.garg@linaro.org" <sumit.garg@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"frederic@kernel.org" <frederic@kernel.org>, wsd_upstream <wsd_upstream@mediatek.com>, 
	=?UTF-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel-team@meta.com" <kernel-team@meta.com>, 
	"joel@joelfernandes.org" <joel@joelfernandes.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 30, 2024 at 4:27=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Oct 30, 2024 at 01:12:01PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Oct 30, 2024 at 6:54=E2=80=AFAM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > > > We do assume that nmi_trigger_cpumask_backtrace() uses true NMIs,=
 so,
> > > > > yes, nmi_trigger_cpumask_backtrace() should use true NMIs, just l=
ike
> > > > > the name says.  ;-)
> > > >
> > > > In the comments of following patch, the arm64 maintainers have
> > > > differing views on the use of nmi_trigger_cpumask_backtrace(). I'm =
a
> > > > bit confused and unsure which perspective is more reasonable.
> > > >
> > > > https://lore.kernel.org/all/20230906090246.v13.4.Ie6c132b96ebbbcddb=
f6954b9469ed40a6960343c@changeid/
> > >
> > > I clearly need to have a chat with the arm64 maintainers, and thank
> > > you for checking.
> > >
> > > > > /*
> > > > >  * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the
> > > > name,
> > > > >  * nothing about it truly needs to be implemented using an NMI, i=
t's
> > > > >  * just that it's _allowed_ to work with NMIs. If ipi_should_be_n=
mi()
> > > > >  * returned false our backtrace attempt will just use a regular I=
PI.
> > > > >  */
> > > >
> > > > > Alternatively, arm64 could continue using nmi_trigger_cpumask_bac=
ktrace()
> > > > > with normal interrupts (for example, on SoCs not implementing tru=
e NMIs),
> > > > > but have a short timeout (maybe a few jiffies?) after which its r=
eturns
> > > > > false (and presumably also cancels the backtrace request so that =
when
> > > > > the non-NMI interrupt eventually does happen, its handler simply =
returns
> > > > > without backtracing).  This should be implemented using atomics t=
o avoid
> > > > > deadlock issues.  This alternative approach would provide accurat=
e arm64
> > > > > backtraces in the common case where interrupts are enabled, but a=
llow
> > > > > a graceful fallback to remote tracing otherwise.
> > > > >
> > > > > Would you be interested in working this issue, whatever solution =
the
> > > > > arm64 maintainers end up preferring?
> > > >
> > > > The 10-second timeout is hard-coded in nmi_trigger_cpumask_backtrac=
e().
> > > > It is shared code and not architecture-specific. Currently, I haven=
't
> > > > thought of a feasible solution. I have also CC'd the authors of the
> > > > aforementioned patch to see if they have any other ideas.
> > >
> > > It should be possible for arm64 to have an architecture-specific hook
> > > that enables them to use a much shorter timeout.  Or, to eventually
> > > switch to real NMIs.
> >
> > Note that:
> >
> > * Switching to real NMIs is impossible on many existing arm64 CPUs.
> > The hardware support simply isn't there. Pseudo-NMIs should work fine
> > and are (in nearly all cases) just as good as NMIs but they have a
> > small performance impact. There are also compatibility issues with
> > some pre-existing bootloaders. ...so code can't assume even Pseudo-NMI
> > will work and needs to be able to fall back. Prior to my recent
> > changes arm64 CPUs wouldn't even do stacktraces in some scenarios. Now
> > at least they fall back to regular IPIs.
>
> But those IPIs are of no help whatsoever when the target CPU is spinning
> with interrupts disabled, which is the scenario under discussion.

Right that we can't trace the target CPU spinning with interrupts
disabled. ...but in the case where NMI isn't available it _still_
makes sense to make arch_trigger_cpumask_backtrace() fall back to IPI
because:

1. There are many cases where the trigger.*cpu.*backtrace() class of
functions are used to trace CPUs that _aren't_ looping with interrupts
disabled. We still want to be able to backtrace in that case. For
instance, you can see in "panic.c" that there are cases where
trigger_all_cpu_backtrace() is called. It's valuable to make cases
like this (where there's no indication that a CPU is locked) actually
work.

2. Even if there's a CPU that's looping with interrupts disabled and
we can't trace it because of no NMI, it could still be useful to get
backtraces of other CPUs. It's possible that what the other CPUs are
doing could give a hint about the CPU that's wedged. This isn't a
great hint, but some info is better than no info.


> Hence my suggestion that arm64, when using IRQs to request stack
> backtraces, have an additional short timeout (milliseconds) in
> order to fall back to remote stack tracing.  In many cases, this
> fallback happens automatically, as you can see in dump_cpu_task().
> If trigger_single_cpu_backtrace() returns false, the stack is dumped
> remotely.

I think the answer here is that the API needs to change. The whole
boolean return value for trigger.*cpu.*backtrace() is mostly ignored
by callers. Yes, you've pointed at one of the two places that it's not
ignored and it tries a reasonable fallback, but all the other callers
just silently do nothing when the function returns false. That led to
many places where arm64 devices were simply not getting _any_
stacktrace.

Perhaps we need some type of API that says "I actually have a
fallback, so if you don't think the stracktrace will succeed then it's
OK to return false".


> > * Even if we decided that we absolutely had to disable stacktrades on
> > arm64 CPUs without some type of NMI, that won't fix arm32. arm32 has
> > been using regular IPIs for backtraces like this for many, many years.
> > Maybe folks don't care as much about arm32 anymore but it feels bad if
> > we totally break it.
>
> Because arm32 isn't used much for datacenter workloads, it will not
> be suffering from this issue.  Not enough to have motivated anyone to
> fix it, anyway.  In contrast, in the datacenter, CPUs really can and
> do have interrupts disabled for many seconds.  (No, this is not a good
> thing, but it is common enough for us to need to avoid disabling other
> debugging facilities.)
>
> So it might well be that arm32 will continue to do just fine with
> IRQ-based stack tracing.  Or maybe someday arm32 will also need to deal
> with this same issue.  But no "maybe" for arm64, given its increasing
> use in the datacenter.

IMO the answer here is that anyone in datacenters should just turn on
pseudo NMI (or NMI on newer arm64 CPUs).


> > IMO waiting 10 seconds for a backtrace is pretty crazy to begin with.
> > What about just changing that globally to 1 second? If not, it doesn't
> > feel like it would be impossibly hard to make an arch-specific
> > callback to choose the time and that callback could even take into
> > account whether we managed to get an NMI. I'd be happy to review such
> > a patch.
>
> Let's please keep the 10-second timeout for NMI-based backtraces.
>
> But I take it that you are not opposed to a shorter timeout for the
> special case of IRQ-based stack backtrace requests?

IMO the 10 second is still awfully long (HW watchdogs can trigger
during that time), but I'm not that upset by it. I'm OK with shorter
timeouts for IRQ-based ones, though I'm not sure I'd be OK w/ timeouts
measured in milliseconds unless the caller has actually said that they
can handle a "false" return or the caller says that it's more
important to be quick than to wait for a long time.


-Doug
