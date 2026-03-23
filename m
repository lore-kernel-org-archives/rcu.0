Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979B3806DE
	for <rcu@vger.kernel.org>; Mon, 23 Mar 2026 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302659; cv=pass; b=JIpsf69vsO5C77FueqN9xCUG8S1h9Yl3mIUEahEayexsBzH2xOxpTrtuVIbQqVNRp4zjdEG75IZVRWg8JLJEmAV4gVtsHWnooWONgy5GKq8gWD6KcbsEYBnstfS/zmkUM7gf2b2t3Qc2HPua/hFCwqviceVqAI2juNcYU3qvb9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302659; c=relaxed/simple;
	bh=JauitbIwwmYeCKBlB7lhjuVccxN5zx1g3hyEezuQjYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLBsGAX0rV4DHSJuHeSx9ln4iGpyTeBeePDz4eF4/j9MwbQQTEl6ASBV+urvA9ZehC4zINrX4rYpYB1cGoovAux8vQXfm76fsbReJVs+HBph5MJ3NABfB1k1xWOO6Hl9EWmhamRK6AEPxzCPMWok7JCTV7eeVQajcfUCP1EVwAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UADIvjmP; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UADIvjmP"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439c56e822eso591324f8f.2
        for <rcu@vger.kernel.org>; Mon, 23 Mar 2026 14:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774302655; cv=none;
        d=google.com; s=arc-20240605;
        b=GiLrpQvJm036wEytcpLfvCd9PPItSnbnzjSUcfc3FIDs4tEZsvGqAW6NeJF15RbHB+
         N9JmCsinPlU7HVorXfno0GqgjeVn2lpkHW7BHRIrcCcWQd4nPcSje+BXIukSJmlV7sMG
         g24tG6KfodQqXjLdNM57IU9xpCzRCoaFSZqrf3r9wQoj292DQGvjq7UsKpHrQFMsbAfe
         voic6CvSqv7xhtKPIgKgjEsvD0O+0+QSvKEImJRoYzZtWic191EFlgFzy2kE+RnXeLIF
         GjiVYwC7Ly4vFK2XwrUyOkFDfCDbQQwhvJZW6jU6gQAuINh8juOb8il8EPFzH7A9K3U3
         bJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HZaqjwMv1jZa3mR6SG8YTIplciqnanieik6C1WY8Ebw=;
        fh=Rt8JgBK5NbejHCTYoQWcEgQupq73BzF8DKL75My7B8s=;
        b=ORM0cLdxqFgkaPrNK6tSOnOEQyoxcfmBOJd7HnRzmtTBecvlJZw7xo91sGUejzds30
         ksYIMVJJ87k0v9j4GyPI7f4f5G7C3LxXk9exJVwwM+9wtaY55NLzZ3/Kru7ViH0wr50L
         gVmDiGHInnu+aUAisiBsWZEd5ITxciGcd9ISX94kThvRyyZ2op55d1AG2At0DIKb5dJn
         6+4jjFOYTwBxWsicUE7AAXaVEu3WO/eYr8U8feJ+QM7XPtxqMeLXfO1BOHVuENI8G2wn
         p8Ppf1D3nbU9lq5kxZhN1NoX4gHFHlQILVtVBRjVlT+SWGrtQmDevxHQJrDeBdZfv2Ia
         d5Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774302655; x=1774907455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HZaqjwMv1jZa3mR6SG8YTIplciqnanieik6C1WY8Ebw=;
        b=UADIvjmPpyhZ0y2N9cpoPd2ywI0IqJoSt2zwq5cDIpv9Fx/MkTixQho4r819Q6InSP
         pgw9Yd3vHRY6VtjXEIAbS155x1C8pwUIltmbcdy9Dc4/YRsgXJMAyPip7OgL7rjn0xoe
         zxWU9k7d2I/pV+s+ELdGk3hWwR3cc6abt0W3+cKefd16vR3lG0ohtJYjql2EeIy8mGPN
         G3FX7bvm8bop0cyZy+EngClUgfgTd9N5Z8RKOY+4sZaB6Wlo4gdC6Hgq/MRMcE0aRSWP
         CVB+v0RcQ3gebzuETPNvVhsMdf0k6zyhN57taUf5Kjhd9B2VwziEeUTsmKFGL1yR+6hu
         +C4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774302655; x=1774907455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZaqjwMv1jZa3mR6SG8YTIplciqnanieik6C1WY8Ebw=;
        b=Uli2tMCgYaVRQXaZx1nW5FZYSoUCREMeNRNVVfecuVsx3tm0hVG3SW9yYaNKAHhIr6
         b6MyO/+8Syy380txJTvOAmd1tmixLDSaSLGgZxb6mGXyt5M2kD3fXdmxFM2cirjqF8ws
         FuZjyaQI02xrSGMzCCnKH9g7qlfOIfVcgg1MWrw4Kb8NJjnG6WyR00I5zCJk7MNvkz/N
         M1P+SuoFy846iE29sGxSZ7tAfoYS1YWBSZm/zc2dhAzhIuHPjgvADAYoNEBBfbJJ0L1I
         6uwO7+fUxJ8N2UnsFyZY//gVmkBSCf4pYkiBkm/W5drOTbKOPnk9BxYBF8YsTlshV6a0
         il7w==
X-Forwarded-Encrypted: i=1; AJvYcCXdENIxV5E5ocr6wWceSTMltK3EQ+6z25FVa2KA8sGVPuI5c3ljpkPSpVL2f0i0kYnLBy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/W1/RpVrJn0tCT1x/pAoD/s+6nMvpl/DTQYJ0+zTnTz8pDbZ
	feWbl7wy4rMw/SHPxpxwX0JCu0VdzJjfDciwW/OyfWjhxd8r5Mu6gQOQUCulNOGdSTZ7q5F967F
	NliiON8LcAjCCP/177liQ4fTjhHfGUS8=
X-Gm-Gg: ATEYQzyZZrHvkEwMjKkr2pi/1r0EWhiQPV4zESfpn/GkD5yRKAAGwp92aB2qg4z0g4v
	GThWQwIyEc6Ub6IxgKoN0B83z57SUf0dqTlMflYXumHwBkNb8KmLyXZN7UcV95u1A5lSUxE1pO3
	rmF9mKJ5ROoH5fGDbYoVgv9kawo3yG9JBR9fnJQ+PhTAg5rsArt9eMsVdfWmrkwVIewxPSLS2jv
	aaf+8skU6VnWRCwbiER2F8YTn7GTqIzhdKi38ojysE6FrClgq7Olozup0obRNESdc14aS5zz0zg
	g48zQJ+B+a7kA4IZXHPLnvijfRLsLAWX8zg1OwexImkS55wiQU5Pg80PK24=
X-Received: by 2002:a05:6000:2203:b0:43b:4625:5933 with SMTP id
 ffacd0b85a97d-43b6426b699mr21284499f8f.30.1774302654583; Mon, 23 Mar 2026
 14:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop>
 <20260321170321.32257-1-boqun@kernel.org> <acFZem9MNHRXin2h@tardis.local>
In-Reply-To: <acFZem9MNHRXin2h@tardis.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 23 Mar 2026 22:50:18 +0100
X-Gm-Features: AQROBzA6-lACn3W8FU3yX1Q9-qB7EYcxhd8oV2QbGHkx-eHXL253BwoztQRf0sM
Message-ID: <CAP01T761Y4AMau-4OyuvgSCNMHRD-3YW6+8JDYFxm0Nf9ycwaw@mail.gmail.com>
Subject: Re: [RFC PATCH] rcu-tasks: Avoid using mod_timer() in call_rcu_tasks_generic()
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org, neeraj.iitr10@gmail.com, 
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Song Liu <song@kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Mar 2026 at 16:17, Boqun Feng <boqun@kernel.org> wrote:
>
> On Sat, Mar 21, 2026 at 10:03:21AM -0700, Boqun Feng wrote:
> > The following deadlock is possible:
> >
> > __mod_timer()
> >   lock_timer_base()
> >     raw_spin_lock_irqsave(&base->lock)   <- base->lock ACQUIRED
> >   trace_timer_start()                    <- tp_btf/timer_start fires here
> >     [probe_timer_start BPF program]
> >       bpf_task_storage_delete()
> >         bpf_selem_unlink(selem, false)   <- reuse_now=false
> >           bpf_selem_free(false)
> >             call_rcu_tasks_trace()
> >               call_rcu_tasks_generic()
> >                 raw_spin_trylock(rtpcp)  <- succeeds (different lock)
> >                 mod_timer(lazy_timer)    <- lazy_timer is on this CPU's base
> >                   lock_timer_base()
> >                     raw_spin_lock_irqsave(&base->lock) <- SAME LOCK -> DEADLOCK
> >
> > because BPF can instrument a place while the timer base lock is held.
> > Fix it by using an intermediate irq_work.
> >
> > Further, because a "timer base->lock" to a "rtpcp lock" lock dependency
> > can be establish in this way, we cannot mod_timer() with a rtpcp lock
> > held. Fix that as well.
> >
> > Fixes: d119357d0743 ("rcu-tasks: Treat only synchronous grace periods urgently")
> > Cc: stable@kernel.org
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > ---
> > This is a follow-up of [1], and yes we can trigger a whole system
> > deadlock freeze easily with (even non-recursively) tracing the
> > timer_start tracepoint. I have a reproduce at:
> >
> >       https://github.com/fbq/rcu_tasks_deadlock
> >
> > Be very careful, since it'll freeze your system when run it.
> >
> > I've tested it on 6.17 and 6.19 and can confirm the deadlock could be
> > triggered. So this is an old bug if it's a bug.
> >
> > It's up to BPF whether this is a bug or not, because it has existed for
> > a while and nobody seems to get hurt(?).
> >
>
> Ping BPF ;-) I know this was sent in a Saturday and only 2 days have
> passed, but we are at the decision point about how hard/urgent we should
> fix these "BPF deadlocks": As this patch shows, the deadlocks existed
> before v7.0 (i.e. before SRCU switches). And yes, ideally we should fix
> all of them, but given we are close to v7.0 release, I would like to
> focus the new issue that SRCU introduces, because that one would likely
> affect SCHED_EXT. Thoughts?

I tried both of your changes, thanks for working on these. I agree the
one reported by Andrea is more important, so that should be the first
priority and should be sent as a fix for 7.0.

It would be good to make the timer-related fix too, but it doesn't
need to be rushed for 7.0. We're aware of the issue being fixed by
this patch in timer tracepoints [0].
It's a corner case which no one has hit thus far. We already made
similar fixes where we could, e.g. [1], but it's difficult to make a
similar change for local storage.

Given Paul said he plans into looking into call_{s,}rcu_nolock()
anyway, the guard can be dropped once call_{s,}rcu_nolock()
materializes.

Something like what you did in this patch would be prerequisite for
the call_{s,}rcu_nolock() anyway, the assumption will be that it could
be invoked from NMI, so reentrancy can happen anywhere, it doesn't
matter much then whether it happens in the same context when the lock
is held and we end up invoking the same path through call_srcu(), or
when an NMI prog interrupts when the timer lock is held.

  [0]: https://lore.kernel.org/bpf/CAP01T76xUCrDH4G2XikNvhPTn6ZbNTgQH59qt2Q_o0c9uudd8w@mail.gmail.com
  [1]: https://lore.kernel.org/bpf/20260204055147.54960-2-alexei.starovoitov@gmail.com

>
> [...]
