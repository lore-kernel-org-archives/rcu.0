Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665091FBCBD
	for <rcu@vger.kernel.org>; Fri,  3 Jan 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735924093; cv=none; b=kF9oM+mxGLtN6S49L6zB1+AgPX3rt3nTroMztij8fLMRWGg7uNcp9jRDzsZAoBBzRKYpCmATVd/Hy2+ojWl/lOfbobGJXmq/aW6j3AJv1/QntX2byjiIFwwzGGkzrj0/TjOSXGpcUDHfW9pTaFlWgd2T6hSMw4PCzoarEeWysog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735924093; c=relaxed/simple;
	bh=eq+i4u0TDCIqn3i5mEJho8EqBT9Ti5ETp/tVUOQY6lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSLTOJq/iLokTMLqL4XvZB/wV/80dZbb6OIV9isqBjsdAecQzlspEMEv+XNXDu+LoXTRJDUp0JaARQovUdazjBxfxkfUXm38T4mJtNO/PekQsrKSsDVg1/ma0xNYWEAg7sRUxEGjDAELMSXymXkdAiEiiCJ9jyGp/5FvI2QeJ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0Xshrgn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0Xshrgn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4539C4CECE;
	Fri,  3 Jan 2025 17:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735924092;
	bh=eq+i4u0TDCIqn3i5mEJho8EqBT9Ti5ETp/tVUOQY6lo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=D0XshrgnmgPt3eH25sr4YfoH8xSPkMBFMQgQHjQnByoh6p/yJQY4FkS6rEfJJ/nQW
	 pqm+9R+/kQ3hEE6BuIyXVtEcQhnx0QjnP16HvFLa6GprzA+hqOdDphd6FOcwxXZbeM
	 A1qRFvozoD5J515iyhi6K7/wnJ4dbHbcawHQki6KN0yOg81Gfns1wRiujtMpDorEGu
	 DcU6Jw1faqP9zEoCr0+SC/s5WlqED3mWJI4Takn6cdfIVgK9d296N9JAyXQcnNSVjB
	 bg7e6krwmQT0uLOHo3Ja9E9p5lMayTJFYW9gFMfVr5Az2Klnzp7L9oTjlLnihSaLBh
	 M+/dmrt15EtAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8A9F2CE0E98; Fri,  3 Jan 2025 09:08:12 -0800 (PST)
Date: Fri, 3 Jan 2025 09:08:12 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Karim Manaouil <kmanaouil.dev@gmail.com>, rcu@vger.kernel.org
Subject: Re: Taking page faults in RCU critical sections
Message-ID: <9b3565b8-7182-4ba5-8dcd-b93fd7eb7ddd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250102182343.vlgzo6wjf5abqxol@ed.ac.uk>
 <afa3b043-0591-463e-8b61-21db547a25ad@paulmck-laptop>
 <CAEXW_YT5W2R4ebof1Eo5hix1JasHm0Kz_nDOxM9Fv-k7iNGsmQ@mail.gmail.com>
 <CAEXW_YRcGAMgjOM1Qv5=k7sVVWfiDagoHsvYn_6XJrFsZbHAEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRcGAMgjOM1Qv5=k7sVVWfiDagoHsvYn_6XJrFsZbHAEw@mail.gmail.com>

On Fri, Jan 03, 2025 at 11:50:29AM -0500, Joel Fernandes wrote:
> On Thu, Jan 2, 2025 at 7:58 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> [...]
> > > > Last question, do I need the -rt kernel for preempt RCU?
> > >
> > > No, CONFIG_PREEMPT=y suffices.
> > >
> > > Note that CONFIG_PREEMPT_RT=y, AKA -rt, also makes spinlocks (but not
> > > raw spinlocks) be limited sleeplocks, and thus allows RCU read-side
> > > critical sections to block when acquiring these sleeping "spinlocks".
> > > But this is OK, because all of this is still subject to priority boosting.
> >
> > Should PREEMPT_RT kernels not throw warnings though when calling
> > rcu_note_context_switch() in RCU read-side sections?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/rcu/tree_plugin.h#n331
> >
> > I don't run a PREEMPT_RT kernel myself so I can't confirm if these
> > warnings somehow don't appear, but I figured it would be good to
> > double check in this discussion.
> 
> Please ignore my noise, Steven clarified for me in a meeting today
> that preempt != 0 in that warning, when an a
> "spinlock-coverted-to-rtmutex for PREEMPT_RT" blocks. So even though
> the rtmutex blocks in an RCU read-side critical section.
> 
> In other words, I believe rtmutex is the exception -- It can block in
> an RCU read-side critical section on any kernel (PREEMPT_RT or
> otherwise). I could stand corrected though but that's my current
> understanding.

RCU doesn't know about this distinction, it is just told preempt or not.
The scheduler passes in @true when the sched_mode is greater than SM_NONE,
which includes SM_RTLOCK_WAIT.  But this latter is used only in -rt
kernels, so that you cannot use rtmutexes in RCU read-side critical
sections in non-rt kernels.

So, in practice, portable code only gets to use spinlocks in RCU read-side
critical sections.

At least as of v6.12.  ;-)

							Thanx, Paul
