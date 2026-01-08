Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCFE78F29;
	Thu,  8 Jan 2026 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898877; cv=none; b=R1lROyDJAsmBIaoL3DZ7LAQ81kVcpXCZH35MdMS5owOM8OxQo4IjfnbVmcYv9E4yoZ46jGp/nZSCSPWQKeOh2elBLT4Na9LaPyBn6aUi0xQ1qe+RILTgu9lvLGyoyJo7IXuD02oG8UUjOiAEf8GV4Jzh647DA5yMAP23fb2o7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898877; c=relaxed/simple;
	bh=85lqoq+CQJ2HM2BHYhQM6KPWo3GQyLWoKEtp5vriauY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNKwvGqYu6FsgxaHZ13k6zq4Kz/RiBCOsv1vd1ouSZFo/zVrh9GBj6C+Tub1hbAlx6wulQjwhup/4fLekBWHYopUoOXnEaAc4JojkG7H24trBh88LeragaE+tspCU0t4eCYdaafafmVmuAE0lZsGqPRB58PMwWe72l+mxwPz2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnAkSC6a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnAkSC6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4B1C116C6;
	Thu,  8 Jan 2026 19:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767898877;
	bh=85lqoq+CQJ2HM2BHYhQM6KPWo3GQyLWoKEtp5vriauY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CnAkSC6aCYPXrZfTNFoYj/UrHem2yIZRvLMEuBErPVex8IVONGzWUYHqfK20BUS1n
	 uJcTwvY/iTb0C7SvSMi99I4unqgPDoRDt5U1AktB+91vOfCRQMH3vN1+Gj+rqn67xs
	 Hzy5TmEqccfXdqjswjDJpbbD6OnvjpNt0KKB4RV0LvAsWBy8dU6YvAC0zZh4OHbBvN
	 x9Lnt5OoppRhno5FMHaF+Rw/Vpsd2DtG59Np0gFbK7FEIv7fpaWoWbeUThmXWU4zwW
	 uQCq8dlVWc9JDBrwWW9ZsTsOEbTb0lFG732B//kc1A+lk1R4NfY1NguDBr5x7n386a
	 YhxfZwLlBinLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7F7BDCE0CB8; Thu,  8 Jan 2026 11:01:16 -0800 (PST)
Date: Thu, 8 Jan 2026 11:01:16 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH v4 3/4] hazptr: Implement Hazard Pointers
Message-ID: <4f6fe051-b686-4ec4-8aff-4237b3007f33@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
 <20251218014531.3793471-4-mathieu.desnoyers@efficios.com>
 <aUO9KRaP0FXpm_l9@tardis-2.local>
 <fcbc99d0-b7c7-45f7-9cf8-f5d3bfad966e@efficios.com>
 <aUSfu4V9mrD7BQGl@tardis-2.local>
 <6c96dbb5-bffc-423f-bb6a-3072abb5f711@efficios.com>
 <aV_cms1mCPYq6jah@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV_cms1mCPYq6jah@localhost.localdomain>

On Thu, Jan 08, 2026 at 05:34:34PM +0100, Frederic Weisbecker wrote:
> Le Fri, Dec 19, 2025 at 09:22:19AM -0500, Mathieu Desnoyers a écrit :
> > On 2025-12-18 19:43, Boqun Feng wrote:
> > > On Thu, Dec 18, 2025 at 12:35:18PM -0500, Mathieu Desnoyers wrote:
> > > [...]
> > > > > Could you utilize this[1] to see a
> > > > > comparison of the reader-side performance against RCU/SRCU?
> > > > 
> > > > Good point ! Let's see.
> > > > 
> > > > On a AMD 2x EPYC 9654 96-Core Processor with 192 cores,
> > > > hyperthreading disabled,
> > > > CONFIG_PREEMPT=y,
> > > > CONFIG_PREEMPT_RCU=y,
> > > > CONFIG_PREEMPT_HAZPTR=y.
> > > > 
> > > > scale_type                 ns
> > > > -----------------------
> > > > hazptr-smp-mb             13.1   <- this implementation
> > > > hazptr-barrier            11.5   <- replace smp_mb() on acquire with barrier(), requires IPIs on synchronize.
> > > > hazptr-smp-mb-hlist       12.7   <- replace per-task hp context and per-cpu overflow lists by hlist.
> > > > rcu                       17.0
> > > 
> > > Hmm.. now looking back, how is it possible that hazptr is faster than
> > > RCU on the reader-side? Because a grace period was happening and
> > > triggered rcu_read_unlock_special()? This is actualy more interesting.
> > So I could be entirely misreading the code, but, we have:
> > 
> > rcu_flavor_sched_clock_irq():
> > [...]
> >         /* If GP is oldish, ask for help from rcu_read_unlock_special(). */
> >         if (rcu_preempt_depth() > 0 &&
> >             __this_cpu_read(rcu_data.core_needs_qs) &&
> >             __this_cpu_read(rcu_data.cpu_no_qs.b.norm) &&
> >             !t->rcu_read_unlock_special.b.need_qs &&
> >             time_after(jiffies, rcu_state.gp_start + HZ))
> >                 t->rcu_read_unlock_special.b.need_qs = true;
> > 
> > which means we set need_qs = true as a result from observing
> > cpu_no_qs.b.norm == true.
> > 
> > This is sufficient to trigger calls (plural) to rcu_read_unlock_special()
> > from __rcu_read_unlock.
> > 
> > But then if we look at rcu_preempt_deferred_qs_irqrestore()
> > which we would expect to clear the rcu_read_unlock_special.b.need_qs
> > state, we have this:
> > 
> >         special = t->rcu_read_unlock_special;
> >         if (!special.s && !rdp->cpu_no_qs.b.exp) {
> >                 local_irq_restore(flags);
> >                 return;
> >         }
> >         t->rcu_read_unlock_special.s = 0;
> > 
> > which skips over clearing the state unless there is an expedited
> > grace period required.
> > 
> > So unless I'm missing something, we should _also_ clear that state
> > when it's invoked after rcu_flavor_sched_clock_irq, so the next
> > __rcu_read_unlock won't all call into rcu_read_unlock_special().
> > 
> > I'm adding a big warning about sleep deprivation and possibly
> > misunderstanding the whole thing. What am I missing ?
> 
> As far as I can tell, this skips clearing the state if the state is
> already cleared. Or am I even more sleep deprived than you? :o)

Get some sleep!  A good night's sleep is one of the best debugging aids
available, even in this brave new world of LLMs.  ;-)

							Thanx, Paul
