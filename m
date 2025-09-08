Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB96173;
	Tue,  9 Sep 2025 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376994; cv=none; b=eFY8CyUR/MZf64cFztBpvz2p2kRiH+OKKblJfbPv9rNCo6jRfpXRl1XqvwbbyADk1p2FGBJwZkrePqGSkP4n4dIO7Chpvs/+lmKWUXDNdyscSx92vPvh6DAYZLmkTUfD8TTMYWwPIbQwZk1thjKRBZQ5BjX8kyO8sPI4wfzvpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376994; c=relaxed/simple;
	bh=7EmNl0AiWorMC2hdJ8vEHhI6St/xXWrepBy19CUbVGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOYhBlAJS8b1/RwXBidKz7dDamD0aPBTMAd/d13LSR/Gi+eCPcSVRRlHM8e2pA55tzYiwNR/hsSQG+FkR5oXCCmNiZPxM5HuDFUSytWEhAGgIqW3znr9+CIUbi2HSH6GTbCKfOlPFpmTTv+HRG8eVq7kwRngC+ZZQTxVI4v0llo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5nD+AA4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5nD+AA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF63C4CEF1;
	Tue,  9 Sep 2025 00:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757376993;
	bh=7EmNl0AiWorMC2hdJ8vEHhI6St/xXWrepBy19CUbVGI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Q5nD+AA4WT6kvHkjsMLFy9Ys85te7ttCpjEHIfDX5W8na4UUvpZIxSZ0es1+LP6Uc
	 4m1RKtU56dPei8F4OvGNd3VTuFYDV13xuI2cwYIIdd8Sb5mEYdGe7sILMS7zeRd2mo
	 LqIrD7t0rJ4mxquNsEPlNeTZ2W9nckaCbvt7Wa/p+IYwryKbEwHh4BzHGVsXB8wbeY
	 0VNmf9p5zf5RPHESdD7B3CCzlSDOF0QiudLIC5Lk0oe9tlAiskaQXZ0v+NRN3mI8jo
	 nB7Mut5WvbXZO8hSRXhA0ZLk9BRSc6ST4z0whWIFIZbe86Z9pta91mLbk4NtWA1Q/N
	 8xeKMxhbtsvQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 83E22CE0EA2; Mon,  8 Sep 2025 08:07:48 -0700 (PDT)
Date: Mon, 8 Sep 2025 08:07:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Jens Axboe <axboe@kernel.dk>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH 0/2] rcu: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
Message-ID: <c83ad820-3380-423d-aa1f-96e3cd2c56b4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250905090747.107232-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905090747.107232-1-marco.crivellari@suse.com>

On Fri, Sep 05, 2025 at 11:07:45AM +0200, Marco Crivellari wrote:
> Hi!
> 
> Below is a summary of a discussion about the Workqueue API and cpu isolation
> considerations. Details and more information are available here:
> 
>         "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
>         https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> 
> === Current situation: problems ===
> 
> Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
> set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.
> 
> This leads to different scenarios if a work item is scheduled on an isolated
> CPU where "delay" value is 0 or greater then 0:
>         schedule_delayed_work(, 0);
> 
> This will be handled by __queue_work() that will queue the work item on the
> current local (isolated) CPU, while:
> 
>         schedule_delayed_work(, 1);
> 
> Will move the timer on an housekeeping CPU, and schedule the work there.
> 
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> === Plan and future plans ===
> 
> This patchset is the first stone on a refactoring needed in order to
> address the points aforementioned; it will have a positive impact also
> on the cpu isolation, in the long term, moving away percpu workqueue in
> favor to an unbound model.
> 
> These are the main steps:
> 1)  API refactoring (that this patch is introducing)
>     -   Make more clear and uniform the system wq names, both per-cpu and
>         unbound. This to avoid any possible confusion on what should be
>         used.
> 
>     -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
>         introduced in this patchset and used on all the callers that are not
>         currently using WQ_UNBOUND.
> 
>         WQ_UNBOUND will be removed in a future release cycle.
> 
>         Most users don't need to be per-cpu, because they don't have
>         locality requirements, because of that, a next future step will be
>         make "unbound" the default behavior.
> 
> 2)  Check who really needs to be per-cpu
>     -   Remove the WQ_PERCPU flag when is not strictly required.
> 
> 3)  Add a new API (prefer local cpu)
>     -   There are users that don't require a local execution, like mentioned
>         above; despite that, local execution yeld to performance gain.
> 
>         This new API will prefer the local execution, without requiring it.
> 
> === Introduced Changes by this series ===
> 
> 1) [P 1] Replace use of system_wq
> 
>         system_wq is a per-CPU workqueue, but his name is not clear.
> 
>         Because of that, system_wq has been renamed in system_percpu_wq..
> 
> 2) [P 2] add WQ_PERCPU to remaining alloc_workqueue() users
> 
>         Every alloc_workqueue() caller should use one among WQ_PERCPU or
>         WQ_UNBOUND. This is actually enforced warning if both or none of them
>         are present at the same time.
> 
>         WQ_UNBOUND will be removed in a next release cycle.
> 
> === For Maintainers ===
> 
> There are prerequisites for this series, already merged in the master branch.
> The commits are:
> 
> 128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
> system_dfl_wq")
> 
> 930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")

Queued for review and testing.  If you would prefer to route this some
other way, please let me know.

							Thanx, Paul

> Thanks!
> 
> Marco Crivellari (2):
>   rcu: replace use of system_wq with system_percpu_wq
>   rcu: WQ_PERCPU added to alloc_workqueue users
> 
>  kernel/rcu/tasks.h | 4 ++--
>  kernel/rcu/tree.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> -- 
> 2.51.0
> 
