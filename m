Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3C16A92E
	for <rcu@vger.kernel.org>; Thu, 31 Oct 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410064; cv=none; b=WRlSOfujknpaykkPZkaKzvB2g2do938WSAsGVsV/h/wZWwXxgcXgU4YI9KPpvlaWLZ7XXDQqImifn+jHVMbpbPY12LzsDxOoHATn1v0ozMshpgTBpGAmc+6rWx6YhfvKN34rYZj3761WGy/Q+udVN/rRegxdFL00ihjGL+GaeIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410064; c=relaxed/simple;
	bh=tKf5e14OTBlk5KKjE7rCsWwIXg/YUm+7goii6JRgdME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKmUP/rrLjwtueD8ir3akRs/TpJxiRKTImyYTNjC+2X33085cQbyppGnWyZfbFN9jSEecc/ig74Ggs5oR9A7RThILPO+3aI1qBJnPMz3/isCOFmJ4b6cMU4eu7ATKcpnnbgkYXlp3BFWdMKwX506QzFIL6buTI1rLWKrQ2Bww1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kJP2Ctom; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kJP2Ctom"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1543092e87.3
        for <rcu@vger.kernel.org>; Thu, 31 Oct 2024 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730410055; x=1731014855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rnezyo9f7Uf8IzrR2IKyv8RCihqJSnIkygb/brXSDwI=;
        b=kJP2CtomzIqAH/jNByGVhHwtGfYUG9t2oWF6uTFiCuJEEAgfnXDxdlxx2rW57dkX+4
         naIFSKkgfJQu6Ako3FMlqql+ucxHmjtXf45Iog/Qg04rjEIvPR4xWiZKHIFdRPd5h+5c
         wELmeraOmt3gD8Js3dBfUmWAEq2sA4m1RP+wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730410055; x=1731014855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rnezyo9f7Uf8IzrR2IKyv8RCihqJSnIkygb/brXSDwI=;
        b=t/rChGkpHk/od4DsFX3VgvPTVjcpfgSKVjgCo6QVENYrSJ5aKKuYxUfzVKOeKl/c8J
         HPT2RyJ8sq1NEQoCQvRpWaRwIbQFrfYkjUuH/ocHNu27sQmwAMqQKI4zZLWHpnnQiuoa
         CyZoLRTNbRAd6SNMmnuRMMdSKmrO8MG32U/ryHo6n2vZJcWJV4KMnr4PsTB9J+zqsecW
         OaYQV2LeGklzSRBIW+Lzl9GmBVvazaP6MgpsY4Q3qTFjtYpZRajnjAN8JYGWCSAlWHd9
         fZSw0c4AmxEGReaGov8TBMhi/fW6qYBRtmwR/uQjqp5dnI4Qpuz7HtoApesE9AAIu7ix
         HDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDIplFrU33TijhiHsIy7kvwwI6+tNk13k2CTBkH79y8tWn60cDRu/xEZ+McCXuoJ2Evn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLL63bHpKLQOA1fMfXOyCseHnOrlA1xbDL8JtLMChLhdVNzoaZ
	hchOvDxYCRj16WHyOeitRqoMbWjs1A9rdRMGF9x+C+M4IAZFEC373tpAXZ+zqjF7LOjArLiIx5T
	pG53V
X-Google-Smtp-Source: AGHT+IHhATbJ+tcvJRfHMd/Qt8GhrELqRxFZuq6zmw4vh3KyOqBFODkMjm2D9UWPYNWYiYgqLFfcnQ==
X-Received: by 2002:a05:6512:4020:b0:52f:d0f0:e37e with SMTP id 2adb3069b0e04-53b3491ac48mr9768667e87.42.1730410054611;
        Thu, 31 Oct 2024 14:27:34 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcbfbcsm330889e87.199.2024.10.31.14.27.33
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 14:27:33 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1723436e87.2
        for <rcu@vger.kernel.org>; Thu, 31 Oct 2024 14:27:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXw7KcQUM8MZWvRXWDRjXqrpZ3c4kXnaApJNAcpgrba3j1ARZvayRo+Mo5fpLDDa+DExdI=@vger.kernel.org
X-Received: by 2002:a05:6512:3f17:b0:52c:d626:77aa with SMTP id
 2adb3069b0e04-53b34b36b2amr9606822e87.58.1730410053222; Thu, 31 Oct 2024
 14:27:33 -0700 (PDT)
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
 <63859e70-2ea7-4a67-857c-fa226566f25a@paulmck-laptop> <CAD=FV=WsM=om=xobfWkC8nLQNK89xdyNNX=L1=DjD79ZPXYxRg@mail.gmail.com>
 <1617541e-4853-4567-b9c0-febf1cfa26a8@paulmck-laptop>
In-Reply-To: <1617541e-4853-4567-b9c0-febf1cfa26a8@paulmck-laptop>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 31 Oct 2024 14:27:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XHD9FhUPLHWRFSRzuHqoBFKT3_cDwMr0ApOBBOjPNnAg@mail.gmail.com>
Message-ID: <CAD=FV=XHD9FhUPLHWRFSRzuHqoBFKT3_cDwMr0ApOBBOjPNnAg@mail.gmail.com>
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

On Wed, Oct 30, 2024 at 10:03=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> > > > Note that:
> > > >
> > > > * Switching to real NMIs is impossible on many existing arm64 CPUs.
> > > > The hardware support simply isn't there. Pseudo-NMIs should work fi=
ne
> > > > and are (in nearly all cases) just as good as NMIs but they have a
> > > > small performance impact. There are also compatibility issues with
> > > > some pre-existing bootloaders. ...so code can't assume even Pseudo-=
NMI
> > > > will work and needs to be able to fall back. Prior to my recent
> > > > changes arm64 CPUs wouldn't even do stacktraces in some scenarios. =
Now
> > > > at least they fall back to regular IPIs.
> > >
> > > But those IPIs are of no help whatsoever when the target CPU is spinn=
ing
> > > with interrupts disabled, which is the scenario under discussion.
> >
> > Right that we can't trace the target CPU spinning with interrupts
> > disabled.
>
> You can by invoking sched_show_task(cpu_curr(cpu)) on the CPU requesting
> the backtrace.  The resulting backtrace will not be as good as you
> would get from using an NMI, but if you don't have NMIs, it is better
> than nothing.
>
> >           ...but in the case where NMI isn't available it _still_
> > makes sense to make arch_trigger_cpumask_backtrace() fall back to IPI
> > because:
> >
> > 1. There are many cases where the trigger.*cpu.*backtrace() class of
> > functions are used to trace CPUs that _aren't_ looping with interrupts
> > disabled. We still want to be able to backtrace in that case. For
> > instance, you can see in "panic.c" that there are cases where
> > trigger_all_cpu_backtrace() is called. It's valuable to make cases
> > like this (where there's no indication that a CPU is locked) actually
> > work.
> >
> > 2. Even if there's a CPU that's looping with interrupts disabled and
> > we can't trace it because of no NMI, it could still be useful to get
> > backtraces of other CPUs. It's possible that what the other CPUs are
> > doing could give a hint about the CPU that's wedged. This isn't a
> > great hint, but some info is better than no info.
>
> And it also makes sense for an IRQ-based backtrace to fall back to
> something like the aforementioned sched_show_task(cpu_curr(cpu)) if
> the destination CPU has interrupts disabled.
>
> > > Hence my suggestion that arm64, when using IRQs to request stack
> > > backtraces, have an additional short timeout (milliseconds) in
> > > order to fall back to remote stack tracing.  In many cases, this
> > > fallback happens automatically, as you can see in dump_cpu_task().
> > > If trigger_single_cpu_backtrace() returns false, the stack is dumped
> > > remotely.
> >
> > I think the answer here is that the API needs to change. The whole
> > boolean return value for trigger.*cpu.*backtrace() is mostly ignored
> > by callers. Yes, you've pointed at one of the two places that it's not
> > ignored and it tries a reasonable fallback, but all the other callers
> > just silently do nothing when the function returns false. That led to
> > many places where arm64 devices were simply not getting _any_
> > stacktrace.
> >
> > Perhaps we need some type of API that says "I actually have a
> > fallback, so if you don't think the stracktrace will succeed then it's
> > OK to return false".
>
> Boolean is fine for trigger_single_cpu_backtrace(), which is directed at
> a single CPU.  And the one call to this function that does not currently
> check its return value could just call dump_cpu_task() instead.
>
> There are only 20 or so uses of all of these functions, so the API can
> change, give or take the pain involved in changing architecture-specific
> code.

Right. Falling back to "sched_show_task(cpu_curr(cpu))" or something
similar if the IPI doesn't go through is a good idea. Indeed, falling
back to that if the NMI doesn't go through is _also_ a good idea,
right? ...and we don't want to change all 20 callers to all add a
fallback. To that end, it feels like someone should change it so that
the common code includes the fallback and we get rid of the boolean
return value.


> > > > * Even if we decided that we absolutely had to disable stacktrades =
on
> > > > arm64 CPUs without some type of NMI, that won't fix arm32. arm32 ha=
s
> > > > been using regular IPIs for backtraces like this for many, many yea=
rs.
> > > > Maybe folks don't care as much about arm32 anymore but it feels bad=
 if
> > > > we totally break it.
> > >
> > > Because arm32 isn't used much for datacenter workloads, it will not
> > > be suffering from this issue.  Not enough to have motivated anyone to
> > > fix it, anyway.  In contrast, in the datacenter, CPUs really can and
> > > do have interrupts disabled for many seconds.  (No, this is not a goo=
d
> > > thing, but it is common enough for us to need to avoid disabling othe=
r
> > > debugging facilities.)
> > >
> > > So it might well be that arm32 will continue to do just fine with
> > > IRQ-based stack tracing.  Or maybe someday arm32 will also need to de=
al
> > > with this same issue.  But no "maybe" for arm64, given its increasing
> > > use in the datacenter.
> >
> > IMO the answer here is that anyone in datacenters should just turn on
> > pseudo NMI (or NMI on newer arm64 CPUs).
>
> Suppose datacenters all do this.  What part of this issue remains?

I believe that if datacenters enable pseudo NMIs then the issue is
"fixed" and thus only remains for anyone else (datacenters or other
users of Linux) that don't turn on pseudo NMIs.


> > > > IMO waiting 10 seconds for a backtrace is pretty crazy to begin wit=
h.
> > > > What about just changing that globally to 1 second? If not, it does=
n't
> > > > feel like it would be impossibly hard to make an arch-specific
> > > > callback to choose the time and that callback could even take into
> > > > account whether we managed to get an NMI. I'd be happy to review su=
ch
> > > > a patch.
> > >
> > > Let's please keep the 10-second timeout for NMI-based backtraces.
> > >
> > > But I take it that you are not opposed to a shorter timeout for the
> > > special case of IRQ-based stack backtrace requests?
> >
> > IMO the 10 second is still awfully long (HW watchdogs can trigger
> > during that time), but I'm not that upset by it. I'm OK with shorter
> > timeouts for IRQ-based ones, though I'm not sure I'd be OK w/ timeouts
> > measured in milliseconds unless the caller has actually said that they
> > can handle a "false" return or the caller says that it's more
> > important to be quick than to wait for a long time.
>
> If you are using NMIs, and the CPU doesn't respond in 10 seconds,
> something is likely broken.  Maybe bad firmware or bad hardware.  You are
> right that watchdogs might trigger, but they are likely already triggerin=
g
> due to the target CPU being so firmly locked up that it is not responding
> even to NMIs.

Yeah, if NMIs aren't working then things are pretty bad. It still
seems like it would be better to let Linux dump more info before a
hardware watchdog triggers. For instance it could perhaps call
something akin to "sched_show_task(cpu_curr(cpu))".

I don't feel super strongly about it, but in my mind even if a CPU is
unresponsive to NMIs for 1-2 seconds then things are in pretty bad
shape and I'd want to start dumping some more info before the hardware
watchdog kicks in and we can't dump anything.


> On the other hand, when you are not using NMIs, then I agree
> you want a shorter timeout before remotely tracing the staek via
> sched_show_task(cpu_curr(cpu)).  I picked a few milliseconds, but if
> datacenters are using real NMIs or pseudo NMIs (and thus are not being
> blocked by normal interrupt disabling), then I must defer to others on
> the default timeout.  Much depends on the workload and configuration.

As I said, I don't feel strongly about this, so if people want to keep
the timeout or shorten it or add a knob, any of those would be fine
with me. I personally would object to a timeout that's _too_ short or
a timeout that is longer than the current 10 seconds.

-Doug
