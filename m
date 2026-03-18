Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED83F87F4
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864732; cv=pass; b=BGU6MknnUmL4a+AzbmRZJ/2rZMCBIPy6gIOaht9ZCGZv9x5jKIMSZpg3EKoQgNNeYBHTX4KbBnPU+LyX5+xTM9MrAGxChL8kpxmqjhE2VzhRLqy3GzoOY8r48nXWd6MLUfZuyIkeTZMWaI1ibMzXuvuze1D+f3CB0pKbxIYGSbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864732; c=relaxed/simple;
	bh=V2IPrgiv+mFBg7jyJT/IkQ0HNcEDNnMZd5urGN+Cfw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6nngQBqryhxfY7QMaK7ihogFPGVwlNbob82plbQbXSlNy2d5ZZTtlxhPPdXKhNGGyfimEUZphgVJalNwR4yncl9WnRofXdiCN/L8xyRHZpPTmaIBI2K54q15BA8ddN6L/hDYBrEbm1vIcIxKYr/s3y8Sb6WnWkFjywygrZtFj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mL9gUR//; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL9gUR//"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4853aec185aso1917335e9.1
        for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 13:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773864729; cv=none;
        d=google.com; s=arc-20240605;
        b=X7Cok6SlyGR4q5a7rZfd5gR2XNwCEj86HYBvInQEuy2IyC/7WiBpxurYJZk4cOrC/j
         USHQ6MJTxzwRAd1o3kVTVv2AZjNBZBza722e5rywgsJcA2KsUAL75rgITDz5DxLDdJ5A
         5dWWi8GSrI/GRP2Y/ltn46FHZdsRMU+30ef9H0K76Snz0Y9lPazuvQLCFuE6FjDXCQsK
         MO1M4oXqnh9guSm1RncU1cB/tnQ6fXJ/k8SAGnkyvM181Eg90aSBabpg7p7hU/RkGkYe
         mrGp2aTfkSsP77xq7iQzqnC0bXhJatt9E3WPNg2abi/9tuzQqG4d0mxs3Q8T1y5rh/B+
         Bi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3WqqRXzbYPIvkepoZf2TInJOmy/km5/CTe5iNXZMOfs=;
        fh=/zlEqeGX3JSs24EnoQYX1mg3xRKJTtW9zGS7hoO/2Z4=;
        b=fta1yS3jDWgv+aAQT5YTi7ZuKRgEYkFNDP9qD2Cm2ELKqvTVahoLsYzd+0RL5sTssX
         2e7MoRVoebb5j+BoiOttdHwuuhsx8BpXWO69HUfqTFnAH3ZEpog9fH3B4JnXnCM5EmFH
         VQ0BZo+pAG6zAOnLunXYW/IOh3qTiOQoqf6YwtuE16oiVkvf9nm+qjDjK4QYRfep5//0
         F5bR+EnltYtI3IBGo/emnTaeNwXv9WKQehCCQlhZ++73oLNXYu/b8CQOwuzYyFgNek1h
         PjIxtUtdCLnrk5RvyvR2SKHG4fiBA7PhH85e9uY/+1A9hNK7z3j7JGCAQuQOa1U3YJ5D
         FfYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773864729; x=1774469529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3WqqRXzbYPIvkepoZf2TInJOmy/km5/CTe5iNXZMOfs=;
        b=mL9gUR//JgXo4Af/jYe51l018ZvgoUrNTj1hEwdK+9S+OVZKCDO186tZv5uG7bol3Z
         KWa7aPMOQn7ypuOEU1uv6eavbGzC7Wq7Yz/TW/wXVoD2WAmNTjGqTOE46Q5HUB4TGQ9T
         t8q+06DDJLL7Iu0ce3LHweaxL+GSqlx5tUflL9AWtxCzFF6Q0MGGiZLXUoC4FJkXnXsL
         i8LU0UFiNJyDiimkWyXhn2IWYOcujbm2PJM+NjitOBJYe6/El0b5K+balNdt+U2f2DKW
         MtCDX3F3Gt2QffyvU3hTklRcao+7HhTLAWkh2GQ85tbtYi/HyJhmGt9Mp+7ATC9G4WHo
         VBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864729; x=1774469529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WqqRXzbYPIvkepoZf2TInJOmy/km5/CTe5iNXZMOfs=;
        b=TLsKsdZrtJ9Ic6izlPRRLb7YLTa6KwjDVBSUnh+DuJecluwNhcoz+QV3xDPIWT7ghy
         2boawVaiECtqdkRIHrLb3wHviMdCNOR82QvGPBOOugKD8D8HxRjWEUjBaexMJlPJkgRf
         1eJombG+eVGBEtdLD3GeOZRK2s9twgODQyUdoZGM5T4F9e/ygNcRj2Kr1PHjuwuHMFmv
         Ocj/HBv4Ij4BCrCTtlrVY9fyfHZPaurpERt65/xNupNc4VXk87wXYk4eQYGEXbK++DVT
         QPJkXpJ8ZcFMnhwvLvu+wmQ7ZqdofBQ34tmDUsw37hXeJqA4z+Mi7Zw20WN9Ws96jeqg
         B4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2Cv9xtJUluaOQZApCqFlIwWjZuPU/SNs+KXud/pfWN3JHZj5CCRYJ1y+8bk3u4skHTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ53dSbxyVhwUk+OYwZd/PdYLloJp0y5Aze/LDJ3+u+4V3zc3Y
	q4EdiGpUUk+0WLuqXpZcoqsgJykOYryYsmDxm+3zHkoa/TnpkcL/BmkHNQwROsXE5QJPTmhZ65S
	5O/UT593KbaU1NGvMcAs9CvTcoRL/Xp0=
X-Gm-Gg: ATEYQzzhl0tyNZKori5RKJtGMNV/wbI7NpKBr6Sd2BSPQvg2J5SpdGtrMCJ7oXvc7pc
	KAZjxBuc4i2d7LBj5AlyonKpb8f72YoR3Zal9KCw0BP8Ml8TocQQ5eXJ/2ZlLohEXsKDp2ee5tr
	CuT+r6LrPTSQljd6Ii7OUn2W65kvHWUcDGdpQeO+xhnVjh8igRPxMRTVY24dXNYAi04sVoB+QWU
	p+xbufISYvQaoUdU2De0sAC0kGSBON0Y6XNZZJhOjxrsnPcVkvIzsv+GnxNRLt68WY1CyZYHX1y
	0YuyW7FTBIUyViG5e7PXUetxi0IWcq7RZnvPNd7zuwBhwVqErW9D6Qfoiyk=
X-Received: by 2002:a05:600c:4f94:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-486f4425e29mr83683325e9.13.1773864728633; Wed, 18 Mar 2026
 13:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
 <20260318105058.j2aKncBU@linutronix.de> <b33d2dc2-7ccf-4524-a846-95c2b64fe117@paulmck-laptop>
 <20260318144305.xI6RDtzk@linutronix.de> <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop> <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
In-Reply-To: <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 18 Mar 2026 21:11:32 +0100
X-Gm-Features: AaiRm53vEL2wTzZUvLgrlRnYpiStaPzkpYbyofqbGMc73P3s6K_mERHwfAwM4gI
Message-ID: <CAP01T77waxWVZ7Ftscn9PZtUb=MaPZYtYJz36Xhs+2fe3pqP9w@mail.gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace + PREEMPT_RT
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, Boqun Feng <boqun@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org, neeraj.iitr10@gmail.com, 
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 21:04, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>
> On 3/18/2026 2:42 PM, Paul E. McKenney wrote:
> > On Wed, Mar 18, 2026 at 08:51:16AM -0700, Boqun Feng wrote:
> >> On Wed, Mar 18, 2026 at 03:43:05PM +0100, Sebastian Andrzej Siewior wrote:
> >> [..]
> >>>>>> way that vanilla RCU's call_rcu_core() function takes an early exit if
> >>>>>> interrupts are disabled.  Of course, vanilla RCU can rely on things like
> >>>>>> the scheduling-clock interrupt to start any needed grace periods [1],
> >>>>>> but SRCU will instead need to manually defer this work, perhaps using
> >>>>>> workqueues or IRQ work.
> >>>>>>
> >>>>>> In addition, rcutorture needs to be upgraded to sometimes invoke
> >>>>>> ->call() with the scheduler pi lock held, but this change is not fixing
> >>>>>> a regression, so could be deferred.  (There is already code in rcutorture
> >>>>>> that invokes the readers while holding a scheduler pi lock.)
> >>>>>>
> >>>>>> Given that RCU for this week through the end of March belongs to you guys,
> >>>>>> if one of you can get this done by end of day Thursday, London time,
> >>>>>> very good!  Otherwise, I can put something together.
> >>>>>>
> >>>>>> Please let me know!
> >>>>>
> >>>>> Given that the current locking does allow it and lockdep should have
> >>>>> complained, I am curious if we could rule that out ;)
> >>>
> >>> Your patch just s/spinlock_t/raw_spinlock_t so we get the locking/
> >>> nesting right. The wakeup problem remains, right?
> >>> But looking at the code, there is just srcu_funnel_gp_start(). If its
> >>> srcu_schedule_cbs_sdp() / queue_delayed_work() usage is always delayed
> >>> then there will be always a timer and never a direct wake up of the
> >>> worker. Wouldn't that work?
> >>
> >> Late to the party, so just make sure I understand the problem. The
> >> problem is the wakeup in call_srcu() when it's called with scheduler
> >> lock held, right? If so I think the current code works as what you
> >> already explain, we defer the wakeup into a workqueue.
> >
> > The issue is that call_rcu_tasks() (which is call_srcu() now) is
> > also invoked with a scheduler pi/rq lock held, which results in a
> > deadlock cycle.  So the srcu_gp_start_if_needed() function's call to
> > raw_spin_lock_irqsave_sdp_contention() must be deferred to the workqueue
> > handler, not just the wake-up.  And that in turn means that the callback
> > point also needs to be passed to this handler.
> >
> > See this email thread:
> >
> > https://lore.kernel.org/all/CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com/
> >
> >> (but Paul, we are not talking about calling call_srcu(), that requires
> >> some more work to get it work)
> >
> > Agreed, splitting srcu_gp_start_if_needed() and using a workqueue if
> > interrupts were already disabled on entry.  Otherwise, directly invoking
> > the split-out portion of srcu_gp_start_if_needed().
> >
> > But we might be talking past each other.
> >
>
> Ah so it is an ABBA deadlock, not a ABA self-deadlock. I guess this is a
> different issue, from the NMI issue? It is more of an issue of calling
> call_srcu  API with scheduler locks held.
>
> Something like below I think:
>
>   CPU A (BPF tracepoint)                CPU B (concurrent call_srcu)
>   ----------------------------         ------------------------------------
>   [1] holds  &rq->__lock
>                                         [2]
>                                         -> call_srcu
>                                         -> srcu_gp_start_if_needed
>                                         -> srcu_funnel_gp_start
>                                         -> spin_lock_irqsave_ssp_content...
>                                           -> holds srcu locks
>
>   [4] calls  call_rcu_tasks_trace()      [5] srcu_funnel_gp_start (cont..)
>                                                  -> queue_delayed_work
>           -> call_srcu()                         -> __queue_work()
>           -> srcu_gp_start_if_needed()           -> wake_up_worker()
>           -> srcu_funnel_gp_start()              -> try_to_wake_up()
>           -> spin_lock_irqsave_ssp_contention()  [6] WANTS  rq->__lock
>           -> WANTS srcu locks
>
> If I understand this, this looks like an issue that can happen independent
> of the conversion of the spin locks.
>

Yes, this is a separate issue, we should make the conversion to raw
spin locks anyway, but lockdep found this once we applied that fix
from Paul.
In sched-ext, we can end up calling call_srcu() while rq->lock is
held, e.g. from exit_task() -> some bpf map that deletes an element ->
call_srcu().
There are other callbacks of course where it can be held, and other
programs that can run tracing the kernel while it is held.

> thanks,
>
> --
> Joel Fernandes
