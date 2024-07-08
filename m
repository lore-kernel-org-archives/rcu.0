Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B777F12
	for <rcu@vger.kernel.org>; Mon,  8 Jul 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447675; cv=none; b=EUYMzBMnrdth5VKyav0d/T9Ex9icHJ7c8DegxRrwb+1eMA3nzDEYHOcUHvT+pFYCgx7dX7K0DVlkDyt17tWJIENhjShT7zFivVPyPkXoywYU29M8FXJjHxDYjPWvRioquD6RD3r1jMQ4k/Z7ohvRI/UXgr6uJy6S8VDGZ8wMQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447675; c=relaxed/simple;
	bh=QWWCCecZwJrL4xYHRlFvI0r17cK9X+DNTRtZZ1BLWF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4/oLSTQtUsvR7Y+RbyiUu2lHTwiSCF7DvoPSA/TF7qqtI9m9FbTcUSxL1iQEbrNCXx3VH8QXIImRRt1Cz3hMtdZmiNO7FmUwnLziF4gARILDuvPhUQEQ9oqY/YcsUHZp6i2gaRK2RcMpsVeYinij4mVBPSZ+ymRu23y7lwL6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMHjrjB+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMHjrjB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FAAC116B1;
	Mon,  8 Jul 2024 14:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720447674;
	bh=QWWCCecZwJrL4xYHRlFvI0r17cK9X+DNTRtZZ1BLWF4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bMHjrjB+9bi1YLTwT6F/ZuhVwcKfeZ3vx2dSoH828W7X9fgnIPNwIYgef59CnMY9/
	 jdqaHXM0pxB03DTj+haf5KpNf6Phxf+D9HlhWCxJUTK3cvnDcT/yWcB8aA1n1c2KUj
	 BTgBQpsamu/oHOfrMN5a01rPZL5Fz8qh9UTchPfc2zeAyuXq4YVzwKATYHinjd+5c6
	 a/xPUtN4aTCb4b/WIXrhZpC1gTOG4ekwFFeq5YCQAfhc3TdgMzX21WSyi85/FQoT7G
	 6BzvxtevrVXogDiLMTJxmvqePDACBoorBd1LuwtwQMjzUU5fkPhnWJStubGJNTTsrB
	 YGWKV7xx4eS9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8F3C8CE0D52; Mon,  8 Jul 2024 07:07:54 -0700 (PDT)
Date: Mon, 8 Jul 2024 07:07:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rcu@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Wakes of the rcuc/ thread on isolated CPUs.
Message-ID: <325d38cc-7aa3-483b-b38d-6ec66d600202@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240705161240.HiOFN5hH@linutronix.de>
 <b73f21c1-cee8-405f-8eb2-52d79320052f@paulmck-laptop>
 <20240705181035.XauAhLGH@linutronix.de>
 <b8a58665-2f9c-4ad5-b8a2-9608b5aba9b5@paulmck-laptop>
 <20240708063838.WeB_3jv2@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708063838.WeB_3jv2@linutronix.de>

On Mon, Jul 08, 2024 at 08:38:38AM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-07-05 18:15:25 [-0700], Paul E. McKenney wrote:
> > > Looking at the patch, there would be a delay up to 5 secs which would
> > 
> > I would have said "up to 1 sec", so what am I missing?
> 
> The patch description said that there is 5 sec upper limit. Yes, default
> 1 sec.

Ah, yes, there is a five-second upper limit on the value of the
rcutree.nohz_full_patience_delay kernel boot parameter and there is a
default one-second value.  The default value places a one-second upper
limit on the RCU grace-period kthread's patience.

So I guess we were both right.  ;-)

> > > mean if the task consumes 100% of the CPU then it doesn't change a
> > > thing.
> > 
> > As long as RCU's grace-period kthread gets some CPU and as long as
> > the CPU-bound task executes often in userspace, that task's CPU's rcuc
> > kthread need never run.  The grace-period kthread would see that the CPU
> > has been in an extended quiescent state, and would report that quiescent
> > state on that CPU's behalf.
> 
> Okay. So the 100% usage is the problem indeed.

And, if that usage is nohz_full userspace execution, also the potential
solution.

> > > Thank you Paul for the pointers.
> > > 
> > > > This is again a workaround.  Clearly, it would be better if we could
> > > > eliminate that second rcuc wakeup.  I tried something similar some time
> > > > back, and there was a problem with it.  I will see if I can reconstitute
> > > > the corresponding brain cells.
> > > 
> > > Is my assumption correct, in order to push the grace period forward,
> > > otherwise the whole is stuck?
> > 
> > Again, if the CPU running the CPU-bound task executes in nohz_full
> > userspace context, that CPU's rcuc kthread need never run.
> > 
> > Of course, if you tried the patch and it didn't help, that is another
> > story.  Hardware facts beat human theories, now as always.
> 
> of course.
> 
> > > > But in the meantime, one advantage of the workaround is that in the
> > > > common case, it would reduce the number of rcuc wakeups to zero, rather
> > > > than to just one.
> > > > 
> > > > Thoughts?
> > > 
> > > I *think* if what I just wrote is correct, I will either have to raise
> > > the priority of rcuc/ or make the thread, that consumes 100% of the CPU
> > > lose its RT priority. Then with the limited number of wakeups it should
> > > be doable.
> > 
> > You can:  (1) Raise the rcuc kthread's priority, as you say, (2) Ensure
> > that the CPU-bound task runs frequently (or even always) in nohz_full
> > usermode context, or (3) #2 and also apply the patch, which would in
> > addition prevent the wakeups.
> > 
> > I think.  After all, I could easily be missing something here.
> 
> Let me backport and see what happens in the end.
> 
> Thank you.

Thank you in advance, and I look forward to hearing how it goes!

> > > PS: I do remember the RCU-task thread we had. I did have an idea but I
> > > need check if this is feasible first. So I did not forget, just slow…
> > 
> > I must confess that I have been wondering about how much tracing goes
> > on withing real-time systems running in production...
> 
> This is little I know. However, it is used during testing of production
> systems to see what is going on due to its little overhead.

That should introduce some fun constraints into tracing mechanisms and
their synchronizations.  Or some fun constraints into which mechanisms
are used when in production real-time systems.  But why not both?  ;-)

							Thanx, Paul
