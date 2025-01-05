Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4037F10FD
	for <rcu@vger.kernel.org>; Sun,  5 Jan 2025 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736104890; cv=none; b=kOi7hfostrSMHCJULnuebkP/ZjFMWgE78X6/1LpuK5m9w4S6VHrOJXKbzGrDYbIchZMK6wkmuSR4+2HYwO43TdKxFttc6ck7INQMSkokIMosxXnI7wnLuIaezoFDiKnmPCaHCnN2zilKMzfhT1W8hENLH/SaL0KOqsvSeRsqET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736104890; c=relaxed/simple;
	bh=ZcawMcmMQE2FILtBYjPlvMrqAkfCLOJ3uGJk5xXKRIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+dhgHtPF4OmLig2E7hk210bHezPb1DEbY5++qit1Bz1yVffxxHyIWWNaodfmwUiRqDH7to5zOfB6haQKu7M/YFy9M2jEt+tNvQh5M1Vjt+jl0oh+x2g/4QaldsPlNtcVjxNS/cAAeK/ZdSOs6dmbpFUUJ0kXM/5oOzE6uN68wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOjKnFWL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOjKnFWL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C630AC4CED0;
	Sun,  5 Jan 2025 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736104889;
	bh=ZcawMcmMQE2FILtBYjPlvMrqAkfCLOJ3uGJk5xXKRIo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jOjKnFWLJvTMnsX6az7HbYpKqX1GZ4hfFoIAVWduw1XLpdIJwxDljDg4FwVqUuQI7
	 imY1qlslROFv+d5YpEZSCyqXUbyBfOiFgOCfwbhnbERvkfhDGk2OFALO/rrA7cWaUZ
	 0wvT/0kpMyYvMFpU+QXJF+mY1pVB30SynPLwDtHExsDRZqj85Ivr3Q8/lZLrzjlQmA
	 e0wS9H7FEbQu9kbfybQCw5+RuYnOT9QLNHHb4igQQ4Xo4yuKBDg+1peMb9dGZ6pSM5
	 k0IDR0pHt8xkBt21TReqCodTWqffF1WSCHnOFGJlZWRuV+6f+MOfdIiap+9Yxv5X7X
	 mkboIkRXv3MPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 63794CE0B73; Sun,  5 Jan 2025 11:21:29 -0800 (PST)
Date: Sun, 5 Jan 2025 11:21:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Karim Manaouil <kmanaouil.dev@gmail.com>
Cc: rcu@vger.kernel.org
Subject: Re: Taking page faults in RCU critical sections
Message-ID: <b64b0008-40df-426e-9a9e-a1f80ac63f90@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250102182343.vlgzo6wjf5abqxol@ed.ac.uk>
 <afa3b043-0591-463e-8b61-21db547a25ad@paulmck-laptop>
 <20250104205619.juog4hsn4vramp6u@ed.ac.uk>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104205619.juog4hsn4vramp6u@ed.ac.uk>

On Sat, Jan 04, 2025 at 08:56:19PM +0000, Karim Manaouil wrote:
> On Thu, Jan 02, 2025 at 11:16:11AM -0800, Paul E. McKenney wrote:
> > On Thu, Jan 02, 2025 at 06:23:43PM +0000, Karim Manaouil wrote:
> > > Hi Paul,
> > > 
> > > First, I wish you a happy new year!
> > 
> > Hello, Karim, and a very happy square new year to you and yours as well!
> > I have added the rcu email list in case someone else has ideas.
> > 
> > > I am working on implementing page migration for some types of kernel
> > > memory. My technique is to remap those kernel pages in vmap/vmalloc 
> > > area and allow the kernel to take page faults during page migration.
> > > 
> > > However, I have the problem of spinlocks and RCU critical sections.
> > > A page fault can occur while the kernel is inside an RCU read critical
> > > section. For example, in fs/dcache.c:dget_parent():
> > > 
> > > rcu_read_lock()
> > > seq = raw_seqcount_begin(&dentry->d_seq);
> > > rcu_read_unlock()
> > > 
> > > If the kernel page where "dentry" belongs to is undergoing migration,
> > > a page fault could occur on the CPU executing the code above, when the
> > > migration thread (running on another CPU) clears the corresponding 
> > > PTE entry in vmap and flushes the TLB (but the new page is not mapped
> > > yet).
> > > 
> > > The page table entries are replaced by migration entries, and the CPU,
> > > on which the page fault happened, will have to wait or spin in the page
> > > fault handler until the migration is complete (success or failure).
> > > 
> > > With calssical RCU, I cannot wait in the page fault handler (like it's
> > > done in migration_entry_wait()) because that's explicit blocking and 
> > > that's prohihited.
> > 
> > Indeed it is, and by design.
> > 
> > > I tried to spin in the fault handler with something like
> > > 
> > > for (;;) {
> > > 	pte = ptep_get_lockless(ptep);
> > > 	if (pte_none(pte) || pte_present(pte))
> > > 		break;
> > > 	cpu_relax();
> > > }
> > > 
> > > But the entire system stopped working (I assume because rcu_synchronise()
> > > on other CPUs is waiting for us and we are waiting for other CPUs, so a
> > > deadlock situation).
> > > 
> > > I realised that I need something like preempt RCU. Would the cpu_relax()
> > > above work with preempt RCU?
> > 
> > You would need something like cond_resched(), but you cannot use this
> > within an RCU read-side critical section.  And spinning in this manner
> > within a fault handler is not a good idea.  You will likely get lockups
> > and stalls of various sorts.
> > 
> > Preemptible RCU permits preemption, but not unconditional blocking.
> > The reason for this is that a preempted reader can be subjected to RCU
> > priority boosting, but if a reader were to block, priority boosting
> > would not help.
> > 
> > The reason that we need priority boosting to help is that blocked RCU
> > readers stall the current RCU grace period, which means that any memory
> > waiting to be freed continues waiting, eventually resulting in OOM.
> > Of course, OOMs are not good for your kernel's uptime, hence the
> > restriction against general blocking in RCU readers.
> 
> I believe not only OOM, but it could also lead to a deadlock, as I observed 
> in my small experiments. Basically, one CPU (0) was blocked inside an RCU
> region, waiting for another CPU (1), running the page migration/compaction
> thread, but the migration thread itself (on CPU1) was trying to free some 
> memory and it had to first wait for the existing RCU readers, amongst them
> CPU0, and that lead to circular waiting (CPU0 waiting for CPU1, but
> CPU1 ends up waiting for CPU0).

Yes, making an RCU read-side critical section wait, whether directly or
indirectly, on an RCU grace period is a good way to achieve deadlock.

> > Please note that spinlocks have this same restriction.  Sleeping while
> > holding a spinlock can result in deadlock, which is even worse for your
> > kernel's uptime.
> > 
> > > Do you have any ideas for how to properly approach this problem?
> > 
> > Here are a few to start with:
> > 
> > 0.	Look at the existing code that migrates processes and/or kernels
> > 	from one system to another, and then do whatever they do.
> > 
> > 1.	Allocate the needed memory up front, before acquiring the
> > 	spinlocks and before entering the RCU readers.
> > 
> > 2.	Move the existing spinlocks to mutexes and the existing uses
> > 	of RCU to SRCU, perhaps using srcu_read_lock_lite().  But note
> > 	that a great deal of review and benchmarking will be necessary
> > 	to prove that there are no regressions.  And that changes of
> > 	this sort in mm almost always result in regressions.
> > 
> > 	So I strongly advise you not to take this approach lightly.
> > 
> > 3.	Your ideas here!
> 
> For (0), it seems that most of the solutions along those lines are "stop
> the world" kind of solutions, which is not ideal.

How about the solutions that are not "stop the world"?

> I thought about (2) before I sent you the email, but then I was
> skeptical for the same reasons you listed.

Fair enough!

> I believe that another variation of (2) is the solution to this problem.
> 
> In fact, there is a very small window in which an RCU reader can trigger
> a page fault, which is the window between flushing the TLB and updating
> the page table entry.
> 
> This makes think that to prevent the deadlock situation above, I need to 
> make sure that the page migration/compaction path should never wait for RCU
> readers. In this case, the RCU reader will wait (spinning) for a bounded
> amount of time which is the amount of time needed to close the window
> described above: copy the contents of the old page to the new page, update
> the page table entry and make the writes visible to the spinning RCU reader,
> no blocking, no scheduling and no grace periods to wait for.
> 
> Do you think this is a sane approach? Obviously one down side is
> burning CPU cycles while spinning, but it should be a small enough
> amount of time.

Maybe?

If you are running in a guest OS, can vCPU preemption cause trouble?
There are lots of moving parts in TLB flushing, so have you checked all
the ones that you need to in this case?

One (rough!) rule of thumb is that if you can use a spinlock to protect
the race window you are concerned about, then it is OK to spin waiting
for that race window from within an RCU read-side critical section.

But as always, this rule is no substitute for understanding the
interactions.

							Thanx, Paul

> > > Last question, do I need the -rt kernel for preempt RCU?
> > 
> > No, CONFIG_PREEMPT=y suffices.
> > 
> > Note that CONFIG_PREEMPT_RT=y, AKA -rt, also makes spinlocks (but not
> > raw spinlocks) be limited sleeplocks, and thus allows RCU read-side
> > critical sections to block when acquiring these sleeping "spinlocks".
> > But this is OK, because all of this is still subject to priority boosting.
> > 
> > 							Thanx, Paul
> 
> Thank you!
> 
> -- 
> Best,
> Karim
> Edinburgh University
