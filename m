Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F4392C3C
	for <rcu@vger.kernel.org>; Wed, 18 Mar 2026 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831063; cv=none; b=o28w3RnMOF8+iyqpGm6vzW0FYOd4khjsUyTyv/h2rF2IhJQSbcySslR4AzLfyiTLtutW/hpRoh8wDdd3pnYw2hvBFxtbn+BJZJmVhUfmBfjk1h2COdLWDGF2B1urne4p/QP/D5Gs9bP7lLvBASnWWSLa2M3YamckSZjEi5bzNtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831063; c=relaxed/simple;
	bh=PjRMpA0rlvHDDJIya1ikFCsImYUJs+XvwSN2DqxgJtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG0IqlGUb6MYg+wQ15swyUVMq+qaH+9YjNj1YLHxPen9vAcgOvB8S3S39T5o13oxhNoOOwa/CC6j/uNPvyu4ZeSWQsVcD37Eymyh9t+iZD9SxMFh/zKat/ve1eFmabEQkM1JamqToFzknLYq7P068WjcA9DqUTqpiJw100VdgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nrbiLQNM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O3zQJnoC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nrbiLQNM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O3zQJnoC"
Date: Wed, 18 Mar 2026 11:50:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773831059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TG3gSfaFbftzH5qS9PpOfl5ajQuMiqQgNSiwfYBqECw=;
	b=nrbiLQNMecds1ZOAgXjUvL8vlS0tLg1ucc5P3zoXNdLb9e+Nu42xXVCp90f1Z1rnQFSX6g
	Hyp7E5iGsOTXV4xj5BOKtBGTCK4/Zw7mt4Gw/XCo7N8+y3wrNJoIXkKBbyRXfv8U1dVCka
	nsERNWc0njwZ261KUM4lqQxhJzILYX04b/0OKHYPl/b79+Uw/a4uSrDgy+QeoBxLJqkCgA
	hPjpoInlRa4gqZGGP4XV1cG+pRuQEoAkWv4UeI2K4xr/F13OtUzmyo06OnNmdaVDj5wfvL
	mO6jFC2FmnzKitwK0lvV+5E/hQuIHS0+5YyJT6pR+mn4DSLKD/3aqBzQS5EBVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773831059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TG3gSfaFbftzH5qS9PpOfl5ajQuMiqQgNSiwfYBqECw=;
	b=O3zQJnoC5ZxjmDDAitOijGg4GmAAWgPFgxRO3G0nvsnKVP9K2DpwFpHVHiaMsaPK4/fzsw
	YuIuCxC+I7FJRBAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <20260318105058.j2aKncBU@linutronix.de>
References: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop>

On 2026-03-17 06:34:26 [-0700], Paul E. McKenney wrote:
> Hello!
Hi,

> Kumar Kartikeya Dwivedi (CCed) privately reported a bug in
> my implementation of the RCU Tasks Trace API in terms of SRCU-fast.
> You see, I forgot to ask what contexts call_rcu_tasks_trace() is called
> from, and it turns out that it can in fact be called with the scheduler
> pi/rq locks held.  This results in a deadlock when SRCU-fast invokes the
> scheduler in order to start the SRCU-fast grace period.  So RCU needs
> a fix to my fix found here:
>=20
> b540c63cf6e5 ("srcu: Use raw spinlocks so call_srcu() can be used under p=
reempt_disable()")

I can't find it. I looked in next and the rcu tree.

> Sebastian, the PREEMPT_RT aspect is that lockdep does not complain
> about acquisition of non-raw spinlocks from preemption-disabled regions
> of code.  This might be intentional, for example, there might be large
> bodies of Linux-kernel code that frequently acquire non-raw spinlocks
> from preemption-disabled regions of code, but which are never part of
> PREEMPT_RT kernels.  Otherwise, it might be good for lockdep to diagnose
> this sort of thing.

The point is you don't know where this preempt_disable() is coming from
on !RT. It might be part of spinlock_t it might be explicit. We only
have the might_sleep() on PREEMPT_RT.
To catch this we would have to iterate over all held locks, compare the
expected preemption level with the current and account for possible
corner cases such as in-IRQ will be one higher and so on=E2=80=A6

However, if you hold a raw_spinlock_t (such as rq/pi) then are asking
for a spinlock_t lockdep should respond with a
|	BUG: Invalid wait context

report.

> Back to the actual bug, that call_srcu() now needs to tolerate being call=
ed
> with scheduler rq/pi locks held...

This is because it is called from sched_ext BPF callbacks?

> The straightforward (but perhaps broken) way to resolve this is to make
> srcu_gp_start_if_needed() defer invoking the scheduler, similar to the

Quick question. If srcu_gp_start_if_needed() can be invoked from a
preempt-disabled section (due to rq/pi lock) then=20
	spin_lock_irqsave_sdp_contention(sdp, &flags);

does not work, right?

> way that vanilla RCU's call_rcu_core() function takes an early exit if
> interrupts are disabled.  Of course, vanilla RCU can rely on things like
> the scheduling-clock interrupt to start any needed grace periods [1],
> but SRCU will instead need to manually defer this work, perhaps using
> workqueues or IRQ work.
>=20
> In addition, rcutorture needs to be upgraded to sometimes invoke
> ->call() with the scheduler pi lock held, but this change is not fixing
> a regression, so could be deferred.  (There is already code in rcutorture
> that invokes the readers while holding a scheduler pi lock.)
>=20
> Given that RCU for this week through the end of March belongs to you guys,
> if one of you can get this done by end of day Thursday, London time,
> very good!  Otherwise, I can put something together.
>=20
> Please let me know!

Given that the current locking does allow it and lockdep should have
complained, I am curious if we could rule that out ;)

>=20
> 						Thanx, Paul [2]
>=20
> [1] The exceptions to this rule being handled by the call to
>     invoke_rcu_core() when rcu_is_watching() returns false.
>=20
> [2] Ah, and should vanilla RCU's call_rcu() be invokable from NMI
>     handlers?  Or should there be a call_rcu_nmi() for this purpose?
>     Or should we continue to have its callers check in_nmi() when needed?

Did someone ask for this?

Sebastian
