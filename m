Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151D1B6CF6
	for <rcu@vger.kernel.org>; Thu,  2 Jan 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735845372; cv=none; b=buKaaUMfsep1CHPaKLGm+lUrut8gC7MdcYgMZRPbwSb0WSA3y4U8Oh3/G+eoFyjPXJPF2W3yn1ZBaNWPUhANyYnD12x5ZngCy6fpA4awx6iOuhMnABYvCmUa4RCoBD9Gj8YWjxOBcqeJRJ9Npnuz5x40IWlFDuViYKKYe6xjiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735845372; c=relaxed/simple;
	bh=6ISI21O+b39f3AQbbCYNjHEptCQudv7fmyH5THxb+ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZOi/Izwa9p7HZ3ySgxWD3SgBSo2qDPSYmR2jhcEBxdOT1WJwgI9CzJYb0kQ62uKjyhtey93xxqEpRolaoMEA+CcWKwjapSOcnillY9c0zR8BfNM3ljW77SSZj/B5pGvjZwIvj/MaPlhhvgSxIhZ2vkpoA8LfwEZ9u0wAioS88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu22uR/8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu22uR/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E21C4CED0;
	Thu,  2 Jan 2025 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735845371;
	bh=6ISI21O+b39f3AQbbCYNjHEptCQudv7fmyH5THxb+ZI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Gu22uR/8yeR8D0eystPVMW6mOtvsaAWAY0qqrzGVt/IZIPyNmfQQVKa38uVapQYAe
	 /fh1d0DvI6dZ/rRHk2eh6dNzCc2QVtKWPdva3v80f9QJ7pXUOGtygl52ELRy7XMYau
	 zPIwusyuaQIH8rUfF4olfN8wqBqeeTSPvDFh5p5mY7p48gGDbZ/vLSCGGUR9lzFWtW
	 aMj+GXqF2l4eqKmWSmmBK6SLfZS7BeYmv3S/AVNg+bSv+uN02Bo91ROU5SE6c+RGWt
	 qe/JKSh1CzgM4f+Oi+v1mBbooJU6TSL836uNaW+JIkNbamlCU47wL8/t6htx/SJYxo
	 FCNMhptBN1oSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 38894CE0DEB; Thu,  2 Jan 2025 11:16:11 -0800 (PST)
Date: Thu, 2 Jan 2025 11:16:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Karim Manaouil <kmanaouil.dev@gmail.com>
Cc: rcu@vger.kernel.org
Subject: Re: Taking page faults in RCU critical sections
Message-ID: <afa3b043-0591-463e-8b61-21db547a25ad@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250102182343.vlgzo6wjf5abqxol@ed.ac.uk>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102182343.vlgzo6wjf5abqxol@ed.ac.uk>

On Thu, Jan 02, 2025 at 06:23:43PM +0000, Karim Manaouil wrote:
> Hi Paul,
> 
> First, I wish you a happy new year!

Hello, Karim, and a very happy square new year to you and yours as well!
I have added the rcu email list in case someone else has ideas.

> I am working on implementing page migration for some types of kernel
> memory. My technique is to remap those kernel pages in vmap/vmalloc 
> area and allow the kernel to take page faults during page migration.
> 
> However, I have the problem of spinlocks and RCU critical sections.
> A page fault can occur while the kernel is inside an RCU read critical
> section. For example, in fs/dcache.c:dget_parent():
> 
> rcu_read_lock()
> seq = raw_seqcount_begin(&dentry->d_seq);
> rcu_read_unlock()
> 
> If the kernel page where "dentry" belongs to is undergoing migration,
> a page fault could occur on the CPU executing the code above, when the
> migration thread (running on another CPU) clears the corresponding 
> PTE entry in vmap and flushes the TLB (but the new page is not mapped
> yet).
> 
> The page table entries are replaced by migration entries, and the CPU,
> on which the page fault happened, will have to wait or spin in the page
> fault handler until the migration is complete (success or failure).
> 
> With calssical RCU, I cannot wait in the page fault handler (like it's
> done in migration_entry_wait()) because that's explicit blocking and 
> that's prohihited.

Indeed it is, and by design.

> I tried to spin in the fault handler with something like
> 
> for (;;) {
> 	pte = ptep_get_lockless(ptep);
> 	if (pte_none(pte) || pte_present(pte))
> 		break;
> 	cpu_relax();
> }
> 
> But the entire system stopped working (I assume because rcu_synchronise()
> on other CPUs is waiting for us and we are waiting for other CPUs, so a
> deadlock situation).
> 
> I realised that I need something like preempt RCU. Would the cpu_relax()
> above work with preempt RCU?

You would need something like cond_resched(), but you cannot use this
within an RCU read-side critical section.  And spinning in this manner
within a fault handler is not a good idea.  You will likely get lockups
and stalls of various sorts.

Preemptible RCU permits preemption, but not unconditional blocking.
The reason for this is that a preempted reader can be subjected to RCU
priority boosting, but if a reader were to block, priority boosting
would not help.

The reason that we need priority boosting to help is that blocked RCU
readers stall the current RCU grace period, which means that any memory
waiting to be freed continues waiting, eventually resulting in OOM.
Of course, OOMs are not good for your kernel's uptime, hence the
restriction against general blocking in RCU readers.

Please note that spinlocks have this same restriction.  Sleeping while
holding a spinlock can result in deadlock, which is even worse for your
kernel's uptime.

> Do you have any ideas for how to properly approach this problem?

Here are a few to start with:

0.	Look at the existing code that migrates processes and/or kernels
	from one system to another, and then do whatever they do.

1.	Allocate the needed memory up front, before acquiring the
	spinlocks and before entering the RCU readers.

2.	Move the existing spinlocks to mutexes and the existing uses
	of RCU to SRCU, perhaps using srcu_read_lock_lite().  But note
	that a great deal of review and benchmarking will be necessary
	to prove that there are no regressions.  And that changes of
	this sort in mm almost always result in regressions.

	So I strongly advise you not to take this approach lightly.

3.	Your ideas here!

> Last question, do I need the -rt kernel for preempt RCU?

No, CONFIG_PREEMPT=y suffices.

Note that CONFIG_PREEMPT_RT=y, AKA -rt, also makes spinlocks (but not
raw spinlocks) be limited sleeplocks, and thus allows RCU read-side
critical sections to block when acquiring these sleeping "spinlocks".
But this is OK, because all of this is still subject to priority boosting.

							Thanx, Paul
