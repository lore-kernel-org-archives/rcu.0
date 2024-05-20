Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4AB18EB1;
	Mon, 20 May 2024 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235399; cv=none; b=jQgKM1DDSRr6PrcxRVagsdm8U9+GOYW2V1RN0hILTSPPV4rDY0DI+3DcEPUNmE4+4xIU7OdZQNEXZyP62HfLbPuSUqoGsdjtAdxRwx19l1u8VIPmv4WqmHmm4qb+qMoagMdAGtsaOtHwWUX4gwNM6bvvZVy1sT+9qkpa46V8+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235399; c=relaxed/simple;
	bh=nRm4lwVO4aNIYcE4K0ymDegIzaRnOX6D1ml7Ph6469o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWTnHwenfQUIHuJHxTvyiWUJTheJ2TmInY6AjKfsuwutCGEOx38cWTjv88l9T/m5gQQJNrxDvbS+tfDRx9juCrSYP0SglEZ/2unaDzs28ERUoWtsCfeYNPCif8QmjONCJr15OHXD5h3eIHsA0J6veJuMEVxY62evhZ82/oZpfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlmTdfiC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlmTdfiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53614C2BD10;
	Mon, 20 May 2024 20:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716235399;
	bh=nRm4lwVO4aNIYcE4K0ymDegIzaRnOX6D1ml7Ph6469o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JlmTdfiCWp8Et2sZhPHBGjb9Y/kMB5PgEKC5uchelF1dVlgghjYxeCarZIIjALRYO
	 kO2p4fd7Z+eG3W5IgHQd4u94JRvRej1m8SiEuQ6t9kiO3Qdn8W8//xBQFCtVs9GrEI
	 hCOGp7bu28AlIz9bSpikR7OZ7vuXs8qx1h4NKTHbeFrnOXjNQ69uQPTlBXIVn5HwwH
	 KlfPbVhiVgOH19n/rpdx6+fwaW+ckKqUsx1IqrnNDtA9WSuoS9C8InaZ0usVlXpXAt
	 OPukHng/rg0asusQZ1rwenU3a4qhb7Tvey8DHQQzZy9dqHP7Bii97o/JS+nIrQC1Hp
	 RmxnQ4DPo9WpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DF4A5CE0C3C; Mon, 20 May 2024 13:03:18 -0700 (PDT)
Date: Mon, 20 May 2024 13:03:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH V2 00/11] rcu/x86: Use per-cpu rcu preempt count
Message-ID: <363efc75-7ebf-408d-be2d-e6c579674f44@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240407090558.3395-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407090558.3395-1-jiangshanlai@gmail.com>

On Sun, Apr 07, 2024 at 05:05:47PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> 
> Changed from v1:
> 	Merge thunk_64.S and thunk_32.S into thunk.S
> 	Add missing #ifdef in arch/x86/kernel/cpu/common.c
> 
> X86 can access percpu data in a single instruction.
> 
> Use per-cpu rcu preempt count and make it able to be inlined.
> 
> patch 1-8: prepare
> patch 9-11: implement PCPU_RCU_PREEMPT_COUNT
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>

Hello, Lai!

This is really cool stuff, thank you!!!

Two big questions remain: (1) What system-level net performance benefit
is there, taking the increased context-switch overhead into account and
(2) Are the scheduler maintainers on board with these changes?

On #1, I do well recall your ca. 2019 points about the improved code
generated, but I have seen cases where improved code actually ran
more slowly.  My guess is that you have the best chance of seeing
system-level benefits on low-end x86 platforms, perhaps the old Atom
or Celeron systems.  The rcuref module provides a good way of doing
microbenchmarks, which would be a good start.  Other metrics that
might help include overall kernel code size.

On #2, good data for #1 would help greatly.

Thoughts?

							Thanx, Paul

> Lai Jiangshan (11):
>   lib: Use rcu_preempt_depth() to replace current->rcu_read_lock_nesting
>   rcu: Move rcu_preempt_depth_set() to rcupdate.h
>   rcu: Reorder tree_exp.h after tree_plugin.h
>   rcu: Add macros set_rcu_preempt_special() and
>     clear_rcu_preempt_special()
>   rcu: Make rcu_read_unlock_special() global
>   rcu: Rename marco __LINUX_RCU_H to __KERNEL_RCU_H
>   sched/core: Add rcu_preempt_switch()
>   x86/entry: Merge thunk_64.S and thunk_32.S into thunk.S
>   rcu: Implement PCPU_RCU_PREEMPT_COUNT framework
>   x86/rcu: Add rcu_preempt_count
>   x86/rcu: Add THUNK rcu_read_unlock_special_thunk
> 
>  arch/x86/Kconfig                       |   1 +
>  arch/x86/entry/Makefile                |   2 +-
>  arch/x86/entry/{thunk_64.S => thunk.S} |   5 ++
>  arch/x86/entry/thunk_32.S              |  18 ----
>  arch/x86/include/asm/current.h         |   3 +
>  arch/x86/include/asm/rcu_preempt.h     | 109 +++++++++++++++++++++++++
>  arch/x86/kernel/cpu/common.c           |   4 +
>  include/linux/rcupdate.h               |  36 ++++++++
>  kernel/rcu/Kconfig                     |   8 ++
>  kernel/rcu/rcu.h                       |  15 +++-
>  kernel/rcu/tree.c                      |   2 +-
>  kernel/rcu/tree_exp.h                  |   2 +-
>  kernel/rcu/tree_plugin.h               |  41 ++++++----
>  kernel/sched/core.c                    |   2 +
>  lib/locking-selftest.c                 |   6 +-
>  15 files changed, 212 insertions(+), 42 deletions(-)
>  rename arch/x86/entry/{thunk_64.S => thunk.S} (72%)
>  delete mode 100644 arch/x86/entry/thunk_32.S
>  create mode 100644 arch/x86/include/asm/rcu_preempt.h
> 
> 
> base-commit: f2f80ac809875855ac843f9e5e7480604b5cbff5
> -- 
> 2.19.1.6.gb485710b
> 
