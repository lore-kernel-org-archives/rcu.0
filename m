Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEF62144CF;
	Mon,  7 Jul 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903765; cv=none; b=PlbqClWCLKWyiVQMMG9VeMZmdoJjbaSuwp2ToA/A1j46DmLSwEfFhR+n01EVUU7rg4mWWZjiklr8FFuff+iY8spZ9afAZilL4+9iGghKxqJLdEBaUi5KdoiWqpCJM3M6HiJysCDOZGkKAIrrPquyYesoNPfY1ZiVdooYkngkcp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903765; c=relaxed/simple;
	bh=f6DsW0WYHxLyXHwiXum+i83pkEndPZCJeiW0ueulBxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDrA3HD+MrKpXSBB9KnSZmiHR+aYXZdTe3yG4WjMI1G8VR2Pccn+cdA1hgOaH5tDUzxymM7/rb6Hw65hZ1JUIj1TfM5DAXyHjdcizmBfZrBYOVZxpc81lmY9fsDLuwOd2qSmaLw5lZDk9j+wmlKnNYt1RKRFB/jSaWnIOH9IXO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdJ5BOzL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdJ5BOzL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF57BC4CEE3;
	Mon,  7 Jul 2025 15:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751903764;
	bh=f6DsW0WYHxLyXHwiXum+i83pkEndPZCJeiW0ueulBxk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HdJ5BOzLRtXDqoOLhhV2Qj7wOmLCaQaRGPPjUhbV9euuRWBaKS7jy+ZQnxnfG5VvY
	 iH4qta6l2IYoiANGgt2ib240phFrRp6C4kPvqGPkhCjDthYNvsj2YbuTWEWIBy5aP/
	 k2pYmyygJrtZdAbnr+KEj1Oaz2kXMIsb5VcE4c2f+9x1j9smvvGYvDwVun8/QXZ0sT
	 rNKrEKCa324UB4CPM+2TDltWJnAJKvb7jGUoIyd43xnE+lCTJ9gMeccooSG3fW7fX8
	 eKiN2C4smyNGFsaq8RlAE7jOSm0DM0SS1oG7541oI+yq6gmg7YgkpA6ry0u81kAQUe
	 E03HVM1hiIuOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 553B4CE09EB; Mon,  7 Jul 2025 08:56:04 -0700 (PDT)
Date: Mon, 7 Jul 2025 08:56:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrea Righi <arighi@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] smp: Document preemption and stop_machine() mutual
 exclusion
Message-ID: <298d86df-65bc-4f7a-a361-a8382cdee296@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250705172328.4114289-1-joelagnelf@nvidia.com>
 <20250707075050.GB1613200@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707075050.GB1613200@noisy.programming.kicks-ass.net>

On Mon, Jul 07, 2025 at 09:50:50AM +0200, Peter Zijlstra wrote:
> On Sat, Jul 05, 2025 at 01:23:27PM -0400, Joel Fernandes wrote:
> > Recently while revising RCU's cpu online checks, there was some discussion
> > around how IPIs synchronize with hotplug.
> > 
> > Add comments explaining how preemption disable creates mutual exclusion with
> > CPU hotplug's stop_machine mechanism. The key insight is that stop_machine()
> > atomically updates CPU masks and flushes IPIs with interrupts disabled, and
> > cannot proceed while any CPU (including the IPI sender) has preemption
> > disabled.
> 
> I'm very conflicted on this. While the added comments aren't wrong,
> they're not quite accurate either. Stop_machine doesn't wait for people
> to enable preemption as such.
> 
> Fundamentally there seems to be a misconception around what stop machine
> is and how it works, and I don't feel these comments make things better.
> 
> Basically, stop-machine (and stop_one_cpu(), stop_two_cpus()) use the
> stopper task, a task running at the ultimate priority; if it is
> runnable, it will run.
> 
> Stop-machine simply wakes all the stopper tasks and co-ordinates them to
> literally stop the machine. All CPUs have the stopper task scheduled and
> then they go sit in a spin-loop driven state machine with IRQs disabled.
> 
> There really isn't anything magical about any of this.

There is the mechanism (which you have described above), and then there
are the use cases.  Those of us maintaining a given mechanism might
argue that a detailed description of the mechanism suffices, but that
argument does not always win the day.

I do like the description in the stop_machine() kernel-doc header:

 * This can be thought of as a very heavy write lock, equivalent to
 * grabbing every spinlock in the kernel.

Though doesn't this need to upgrace "spinlock" to "raw spinlock"
now that PREEMPT_RT is in mainline?

Also, this function is more powerful than grabbing every write lock
in the kernel because it also excludes all regions of code that have
preemption disabled, which is one thing that CPU hotplug is relying on.
Any objection to calling out that additional semantic?

							Thanx, Paul
