Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EFA6FC2
	for <rcu@vger.kernel.org>; Sat,  6 Jul 2024 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720228526; cv=none; b=plJMYWLXV0nqmcAzOrxj6kwRt63LiYY/1nF1r8iFQsCdKWpAf+2kmJxh9sDXNI+2vL6TN+E/HOHpZZaKKYOD9IeZY7bicG3/rCKO7xXsgHAjpxaMmRIqoqmvn9FcGPWgxCd2Mk5Iyxs6cCnqvvn7ew/RI6R29LKWhR81B46DrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720228526; c=relaxed/simple;
	bh=zHXaYpC5a27bCN88cB63tj2JH0dbMo430UmnIGyKA40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNC0oOCywTMhPo3WQydDGie6kG1k0+h+6mNlJx0iLjHWVVQVRzn62gKYgWRx1nA+2Ux2l0m/hEQUK7tc8VoevHhJeRGEMzxzQjEQLYwb5HEz5ydRePIdmYXMQGftINdC/q+27YUNT/PPJeXxHc+m7pr2beOCICpMqtNehE1r0mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYIAtEJE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYIAtEJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E4DC116B1;
	Sat,  6 Jul 2024 01:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720228525;
	bh=zHXaYpC5a27bCN88cB63tj2JH0dbMo430UmnIGyKA40=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hYIAtEJEqiN/3BnO+ZCTGQIOb4HRBMN/45oC/hH6wJuhxDQacjs4TZuaMxvdrygUh
	 ixvvmkFXtn+djyyNv7tj6V7r6uFpbre4glev+cAXTPZd1za7N6xN1brhiala5BIPxv
	 92hVZkjS++yqd1yYNi232RoiZy9kVznYHcLcduxOoBGU7jWCsb+UYrkb4sGo06VQt9
	 HYuoO+9k7LFNSAZtJQ5hkqwwe6E4LbPyaVNawWd6zODPInk896o1EwVMsT2qRu3gBT
	 TsHmaOh914oRrxqsgb/KiaCgkOHN+I3UwsfQvj+BVFdThUzXEZ7Mdzht7PwdNN2x5K
	 bpDtAj5ci52hw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2F518CE0BC5; Fri,  5 Jul 2024 18:15:25 -0700 (PDT)
Date: Fri, 5 Jul 2024 18:15:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rcu@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Wakes of the rcuc/ thread on isolated CPUs.
Message-ID: <b8a58665-2f9c-4ad5-b8a2-9608b5aba9b5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240705161240.HiOFN5hH@linutronix.de>
 <b73f21c1-cee8-405f-8eb2-52d79320052f@paulmck-laptop>
 <20240705181035.XauAhLGH@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240705181035.XauAhLGH@linutronix.de>

On Fri, Jul 05, 2024 at 08:10:35PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-07-05 10:39:25 [-0700], Paul E. McKenney wrote:
> > As a workaround, the following commit in -rcu that is slated for
> > the upcoming merge window addresses a similar case involving KVM and
> > nohz_full:
> > 
> > 68d124b09999 ("rcu: Add rcutree.nohz_full_patience_delay to reduce
> > nohz_full OS jitter")
> > 
> > The KVM guys found that setting rcutree.nohz_full_patience_delay to 1000
> > (AKA one second) made things work better for them.  Does this help your
> > use case?
> 
> My problem is that I have a task stuck in percpu_down_write()/
> __wait_rcu_gp() and I think this is because the RCU machinery is stuck
> and there is no grace period.
> I have see a rcuc/ thread with a wakeup but it won't be scheduled
> because it's priority is lower than the thread that is currently on the
> CPU and that thread uses at 100%.
> I *think* this explains it because the rcuc moves the grace period
> forward.
> Looking at the patch, there would be a delay up to 5 secs which would

I would have said "up to 1 sec", so what am I missing?

> mean if the task consumes 100% of the CPU then it doesn't change a
> thing.

As long as RCU's grace-period kthread gets some CPU and as long as
the CPU-bound task executes often in userspace, that task's CPU's rcuc
kthread need never run.  The grace-period kthread would see that the CPU
has been in an extended quiescent state, and would report that quiescent
state on that CPU's behalf.

> Thank you Paul for the pointers.
> 
> > This is again a workaround.  Clearly, it would be better if we could
> > eliminate that second rcuc wakeup.  I tried something similar some time
> > back, and there was a problem with it.  I will see if I can reconstitute
> > the corresponding brain cells.
> 
> Is my assumption correct, in order to push the grace period forward,
> otherwise the whole is stuck?

Again, if the CPU running the CPU-bound task executes in nohz_full
userspace context, that CPU's rcuc kthread need never run.

Of course, if you tried the patch and it didn't help, that is another
story.  Hardware facts beat human theories, now as always.

> > But in the meantime, one advantage of the workaround is that in the
> > common case, it would reduce the number of rcuc wakeups to zero, rather
> > than to just one.
> > 
> > Thoughts?
> 
> I *think* if what I just wrote is correct, I will either have to raise
> the priority of rcuc/ or make the thread, that consumes 100% of the CPU
> lose its RT priority. Then with the limited number of wakeups it should
> be doable.

You can:  (1) Raise the rcuc kthread's priority, as you say, (2) Ensure
that the CPU-bound task runs frequently (or even always) in nohz_full
usermode context, or (3) #2 and also apply the patch, which would in
addition prevent the wakeups.

I think.  After all, I could easily be missing something here.

> PS: I do remember the RCU-task thread we had. I did have an idea but I
> need check if this is feasible first. So I did not forget, just slow…

I must confess that I have been wondering about how much tracing goes
on withing real-time systems running in production...

							Thanx, Paul
