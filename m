Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8914A96
	for <rcu@vger.kernel.org>; Mon,  8 Jul 2024 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420724; cv=none; b=Yc0txZiIJ61iwwEOQSNJhSgPYl6eWStsDCKay8cQQd8qwWcI2KA5K4QCQ066yPHbbp6juT8qzagiAATGo3a/lUAj7umqQopp/899HRcfB420f1NA/OmBQAqbAmFitUIMGGQhd4txP0pzJxg7MbHVKrgPbCH0zwMl+kY0nhNOpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420724; c=relaxed/simple;
	bh=hmMiEwNzP8YW/qBqD6vb83A+wSHPB3hqJHStCKgK7aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+PMmtA6DGA2PHoxOacl6cBxLlvWL5bH+MROc7UoX6WLSdB1tkEm5WOueTqzq5LRcG2GuZ/huEqb4QhLnKZIjZZIIn/D3nHJEvWR5MawyTEOX3GL2sORPfrUBoRAoVX9ckNpaU7RmBEtzBVrJXnC+fPBYAue13qIN9GwccSw2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rJ1o3nNo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m2VCVSMu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJ1o3nNo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m2VCVSMu"
Date: Mon, 8 Jul 2024 08:38:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720420720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yg0hdi13AWMetr4lZulKocsd2G+RMt32gvsCUoyAkn0=;
	b=rJ1o3nNoHT/EldBfuM4La1HPfWjcezg1oaev4oWQw73zvAbqFKTYHb+6Rq7512SYhiJtHb
	CHwpLUSPUKtbfy36fTuyYW6ktnPqq3ecBkA7XAjrwogCHFe93UHU8EBv+d0Wqt3dfHREoj
	2B3YQGmvkSiert8STFr0fVn2w1lu38dC0lnoMz7k48vdwMBQU2IcsMLQOe0zcI9cvN59He
	Jdvn8cl5d1Qs1sIZNqrhIqqNKG+t64vM2wsjb22tbWB5BQUCOBpZZ41SYYbFJPXgFDFDXh
	kiEzKL/SxYmVob3sZXHxiQz7w28WJzsNwwEhNc1UgSuol2JCa9yMY/Unv4rCSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720420720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yg0hdi13AWMetr4lZulKocsd2G+RMt32gvsCUoyAkn0=;
	b=m2VCVSMuN3zRvPGdjv28LxJO4V8nqElXOKEDEl2TFOKdUnvd5J3ZRPGhFK2YuDhKts3+i+
	8/aF7/mlWCFCToBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Wakes of the rcuc/ thread on isolated CPUs.
Message-ID: <20240708063838.WeB_3jv2@linutronix.de>
References: <20240705161240.HiOFN5hH@linutronix.de>
 <b73f21c1-cee8-405f-8eb2-52d79320052f@paulmck-laptop>
 <20240705181035.XauAhLGH@linutronix.de>
 <b8a58665-2f9c-4ad5-b8a2-9608b5aba9b5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b8a58665-2f9c-4ad5-b8a2-9608b5aba9b5@paulmck-laptop>

On 2024-07-05 18:15:25 [-0700], Paul E. McKenney wrote:
> > Looking at the patch, there would be a delay up to 5 secs which would
>=20
> I would have said "up to 1 sec", so what am I missing?

The patch description said that there is 5 sec upper limit. Yes, default
1 sec.

> > mean if the task consumes 100% of the CPU then it doesn't change a
> > thing.
>=20
> As long as RCU's grace-period kthread gets some CPU and as long as
> the CPU-bound task executes often in userspace, that task's CPU's rcuc
> kthread need never run.  The grace-period kthread would see that the CPU
> has been in an extended quiescent state, and would report that quiescent
> state on that CPU's behalf.

Okay. So the 100% usage is the problem indeed.

> > Thank you Paul for the pointers.
> >=20
> > > This is again a workaround.  Clearly, it would be better if we could
> > > eliminate that second rcuc wakeup.  I tried something similar some ti=
me
> > > back, and there was a problem with it.  I will see if I can reconstit=
ute
> > > the corresponding brain cells.
> >=20
> > Is my assumption correct, in order to push the grace period forward,
> > otherwise the whole is stuck?
>=20
> Again, if the CPU running the CPU-bound task executes in nohz_full
> userspace context, that CPU's rcuc kthread need never run.
>=20
> Of course, if you tried the patch and it didn't help, that is another
> story.  Hardware facts beat human theories, now as always.

of course.

> > > But in the meantime, one advantage of the workaround is that in the
> > > common case, it would reduce the number of rcuc wakeups to zero, rath=
er
> > > than to just one.
> > >=20
> > > Thoughts?
> >=20
> > I *think* if what I just wrote is correct, I will either have to raise
> > the priority of rcuc/ or make the thread, that consumes 100% of the CPU
> > lose its RT priority. Then with the limited number of wakeups it should
> > be doable.
>=20
> You can:  (1) Raise the rcuc kthread's priority, as you say, (2) Ensure
> that the CPU-bound task runs frequently (or even always) in nohz_full
> usermode context, or (3) #2 and also apply the patch, which would in
> addition prevent the wakeups.
>=20
> I think.  After all, I could easily be missing something here.

Let me backport and see what happens in the end.

Thank you.

> > PS: I do remember the RCU-task thread we had. I did have an idea but I
> > need check if this is feasible first. So I did not forget, just slow=E2=
=80=A6
>=20
> I must confess that I have been wondering about how much tracing goes
> on withing real-time systems running in production...

This is little I know. However, it is used during testing of production
systems to see what is going on due to its little overhead.

> 							Thanx, Paul

Sebastian
