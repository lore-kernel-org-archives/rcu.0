Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFD6125
	for <rcu@vger.kernel.org>; Fri,  5 Jul 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203040; cv=none; b=FV3kVnjIe8eBhienllQMbXTmtuRmpcVDc5QROgTGIC4+MsV+gTPtnzQcDnk97Bx+gWUPjWOeqHvgJHYT+fwgKAqpNbsx4M8Y75a1j/Q1HA8x9jJXqvgyaWklkc6IVLd34O1hgjzzvYcQ8O4an67Ul5oSQJWo1QOSaIcN/bcG6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203040; c=relaxed/simple;
	bh=61ydhAezwtOaBDtJxE89ZE0iuAvE9Xf7ekayMhijXDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHtVH3AvWOfPhkKKVQJCM2pzpqLlj0yYCakuRYzaCz0u8U3DIHBqlurMRZc7o0cPFC8+o7aFcD2ij2UHrdSZ+46lONLNdlfNNjof0BkFDANE/hfmnB7HNd2A45q9HuoTCZ4LPC9ZdLy0N0qEaj9Ht2fUQi3zsGHa+wLguQuVtRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y5EmP8A+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HCDkN1Ah; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y5EmP8A+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HCDkN1Ah"
Date: Fri, 5 Jul 2024 20:10:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720203036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PT735/jE8smjmcF87HQzcBLe/w+K+6tTOY8t/QZR8c0=;
	b=y5EmP8A+x2fwCfFmtp0uOB5QuicAfr3P3nLSI5C1aRiBc8zmRa/O+qOi1mR/7UuQCToz9/
	B2hOJSP9mQhga67TsKvfy1oXO6rNIWkbZlEnR+HYNwb0kFL7y8Iwwat5WLQZVJXsTqIy6V
	DyLyRTFGQDm+VUwo6oekECflKBIqAaTXbE9OEGXMWFUQaxfp9QwhQQ9/pSUG55Fv1K5+QW
	3a9jp6kvVZJja4P8xvavLqGBltR+s17sS9Y4tEMhOj6e+v9npiMZMAsDOBzOkJZPL7IDzN
	WJlUqTqfnkK5XloaxZw1STdHBt6bRnMh92AB25agt28bw9lQBILw7r5TKL7UTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720203036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PT735/jE8smjmcF87HQzcBLe/w+K+6tTOY8t/QZR8c0=;
	b=HCDkN1AhjVf1OlxaRyBAbtyMNqdqIx7iQovuockTiIGTl00Uhh3mR0NFlrwxQ23q/fNGzr
	WuZ4/Ive2Jn4EbBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Wakes of the rcuc/ thread on isolated CPUs.
Message-ID: <20240705181035.XauAhLGH@linutronix.de>
References: <20240705161240.HiOFN5hH@linutronix.de>
 <b73f21c1-cee8-405f-8eb2-52d79320052f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b73f21c1-cee8-405f-8eb2-52d79320052f@paulmck-laptop>

On 2024-07-05 10:39:25 [-0700], Paul E. McKenney wrote:
> As a workaround, the following commit in -rcu that is slated for
> the upcoming merge window addresses a similar case involving KVM and
> nohz_full:
>=20
> 68d124b09999 ("rcu: Add rcutree.nohz_full_patience_delay to reduce
> nohz_full OS jitter")
>=20
> The KVM guys found that setting rcutree.nohz_full_patience_delay to 1000
> (AKA one second) made things work better for them.  Does this help your
> use case?

My problem is that I have a task stuck in percpu_down_write()/
__wait_rcu_gp() and I think this is because the RCU machinery is stuck
and there is no grace period.
I have see a rcuc/ thread with a wakeup but it won't be scheduled
because it's priority is lower than the thread that is currently on the
CPU and that thread uses at 100%.
I *think* this explains it because the rcuc moves the grace period
forward.
Looking at the patch, there would be a delay up to 5 secs which would
mean if the task consumes 100% of the CPU then it doesn't change a
thing.

Thank you Paul for the pointers.

> This is again a workaround.  Clearly, it would be better if we could
> eliminate that second rcuc wakeup.  I tried something similar some time
> back, and there was a problem with it.  I will see if I can reconstitute
> the corresponding brain cells.

Is my assumption correct, in order to push the grace period forward,
otherwise the whole is stuck?

> But in the meantime, one advantage of the workaround is that in the
> common case, it would reduce the number of rcuc wakeups to zero, rather
> than to just one.
>=20
> Thoughts?

I *think* if what I just wrote is correct, I will either have to raise
the priority of rcuc/ or make the thread, that consumes 100% of the CPU
lose its RT priority. Then with the limited number of wakeups it should
be doable.

PS: I do remember the RCU-task thread we had. I did have an idea but I
need check if this is feasible first. So I did not forget, just slow=E2=80=
=A6

> 							Thanx, Paul

Sebastian
