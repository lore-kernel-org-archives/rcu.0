Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F0137742;
	Wed, 23 Oct 2024 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678243; cv=none; b=rZQShzpc60LkORvsGpfiT2+H/ffDzb1sVWHuvI2GmRUgLJzpUDJxQYJogrQSUToBgt5JxQ3CwaD23Tgsfq33XF2F1n6UHK1ii8DpOLnc0l++IW1bvR5s9pg1uC7ABk8QSmDBg56SoOyxlFtFWVxBvWAJmqvUtVFDHSPH3kigq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678243; c=relaxed/simple;
	bh=SofnLQzyMRsaMI4sJhitH1kT4UGZy1mDhHDbaITMm9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYZgIQQpc42LXih5CiX0Kywdituz0LTD+g4LjXk26JilGf3puNiuZ9MQnDbcube3/+vqC4B0znxsHhMAjnhOJPKvvQA5eC+MGRsXhRrWcLNahWSbPqwVJVNlzve50bav/jAdHwB2m3ABH/MMd1lmy4rbuuhLhwo3hbzYSyJn/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZFiOSyZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZFiOSyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C1EC4CEC6;
	Wed, 23 Oct 2024 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729678243;
	bh=SofnLQzyMRsaMI4sJhitH1kT4UGZy1mDhHDbaITMm9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZFiOSyZUOf57YkKyaT7ZY83SOQ+2X7+dzKbL5X0DI1js0wCT2X3c2HU+ddChPbCg
	 SAgxUnhzvoTj64HfqWqSEqgROYTn3N8ISNYu0zMHPG19+TlE9F0J/mlhPh8M6LH7Fo
	 tW20ygtGBYrzT/xjvR6fLDmgn/1w/KfNDXjcVt0NHqW2gXJ1SyubPDZRQzrAtvLrxU
	 FPCTFOWhxCnTrNo8460u9KeqO0asH7vgJrKJ75p+DkkDKPVuMMuwZ4lKlGZpIudtIe
	 kr+kRAUkC0lEZIeBk8h23/ImbYqdbSfbkZZ74OjweprFdF7XgXL/Sv8toiTvWsC51H
	 prQB8pQKDO3lw==
Date: Wed, 23 Oct 2024 12:10:40 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] softirq: Use a dedicated thread for timer wakeups on
 PREEMPT_RT.
Message-ID: <ZxjLoAINhmGKImHW@pavilion.home>
References: <20241004103842.131014-1-bigeasy@linutronix.de>
 <20241004103842.131014-2-bigeasy@linutronix.de>
 <ZxeomPnsi6oGHKPT@localhost.localdomain>
 <20241022153421.zLWiABPU@linutronix.de>
 <Zxgm1lOsddTRSToB@pavilion.home>
 <20241023063014.iPbVTkiw@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241023063014.iPbVTkiw@linutronix.de>

Le Wed, Oct 23, 2024 at 08:30:14AM +0200, Sebastian Andrzej Siewior a écrit :
> On 2024-10-23 00:27:34 [+0200], Frederic Weisbecker wrote:
> > > Try again without the "ksoftirqd will collect it all" since this won't
> > > happen since the revert I mentioned.
> > 
> > I still don't get it, this makes:
> > 
> > """
> > Once the ksoftirqd is marked as pending (or is running), a softirq which
> > would have been processed at the end of the threaded interrupt, which runs
> > at an elevated priority, is now moved to ksoftirqd which runs at SCHED_OTHER
> > priority and competes with every regular task for CPU resources.
> > """
> > 
> > ksoftirqd raised for timers still doesn't prevent a threaded IRQ from running
> > softirqs, unless it preempts ksoftirqd and waits with PI. So is it what you're
> > trying to solve?
> > 
> > Or is the problem that timer softirqs are executed with SCHED_NORMAL?
> 
> Exactly. It runs at SCHED_NORMAL and competes with everything else. It
> can delay tasks wakes depending on system load.

Ok so that narrows down the problem and it's much clearer, thanks.

> > > > > +void raise_timer_softirq(void)
> > > > > +{
> > > > > +	unsigned long flags;
> > > > > +
> > > > > +	local_irq_save(flags);
> > > > > +	raise_ktimers_thread(TIMER_SOFTIRQ);
> > > > > +	wake_timersd();
> > > > 
> > > > This is supposed to be called from hardirq only, right?
> > > > Can't irq_exit_rcu() take care of it? Why is it different
> > > > from HRTIMER_SOFTIRQ ?
> > > 
> > > Good question. This shouldn't be any different compared to the hrtimer
> > > case. This is only raised in hardirq, so yes, the irq_save can go away
> > > and the wake call, too.
> > 
> > Cool. You can add lockdep_assert_in_irq() within raise_ktimers_thread() for
> > some well deserved relief :-)
> 
> If you want to, sure. I would add them to both raise functions.

Yeah, just in case. Thanks!

> 
> > Thanks.
> 
> Sebastian
