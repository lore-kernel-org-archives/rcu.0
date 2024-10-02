Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE01D0BB6;
	Wed,  2 Oct 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878189; cv=none; b=Gi3YQDLm7QVRhXdB0rLwd9v2Gb/S+XSHTvgtLrgFtqGiU2IlcjbPPxohxWz6NaA7sXIUi9jADRN6BR5qgeYXTpWI8w/BsoENFGkTUyNVdLmXeStdVo96jpAU5EVz1L1vsd4cbZuM6jRpCQBB5RuKr7/HzNJkVJJRA8PmZY/+sSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878189; c=relaxed/simple;
	bh=ztEtpO2kOUfk95Fq1fQfm+HQEaDF0QnfJ03JKTdJUHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp7XaAfGNzczNGmWZTAeqCs0ZHVtS5HmsHig8ntqaYQFjitnPyxRCp657FUwf6GhfnrQAhc7lIV5OpO3BKCPAea6i8wSHTdTlBSBXL/YZUw49Yofq72ZFJ7b/7U8OoDp7yLvq9iXeO+F9OttjSwZRfVvXywD3jIuW2KZWEigGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW0oa0SL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW0oa0SL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20444C4CEC5;
	Wed,  2 Oct 2024 14:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727878189;
	bh=ztEtpO2kOUfk95Fq1fQfm+HQEaDF0QnfJ03JKTdJUHs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fW0oa0SL00BMD5AxbNVSpfHResa4zReH+jYl5W3c4FzobttWTVraba/51xUO3ejUo
	 fkFz4qihVsDkhKd2fHyWKmWTyh9KPc3gN6iWuQ803xyFDy/l6cfgLoSrsNjhbr6Z1T
	 2/hTWJkUHLwdkAKzpeptJMdmBSX9s0FdZNzmENdaHc73z8rrgwgO2BPkVJ/7Qxy/lK
	 IBiKE2h+gP1y8vgzM2DFODO8j8WFhnqZeGAubbIosYVU3YHXotQiXjAcvpBE+UVoxl
	 MYUICTvuMdBGXfFZPyc9YBh7/jE4Q30Zf9D9J+lJpIKKvkPgfHmE4c1ySbUin8kDaG
	 VqMotaKRQyVlw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AD341CE0710; Wed,  2 Oct 2024 07:09:48 -0700 (PDT)
Date: Wed, 2 Oct 2024 07:09:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
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
Subject: Re: [RFC PATCH 0/4] sched+mm: Track lazy active mm existence with
 hazard pointers
Message-ID: <cfcf9c05-c639-4757-a3ac-6504d154cdfe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>

On Tue, Oct 01, 2024 at 09:02:01PM -0400, Mathieu Desnoyers wrote:
> Hazard pointers appear to be a good fit for replacing refcount based lazy
> active mm tracking.
> 
> Highlight:
> 
> will-it-scale context_switch1_threads
> 
> nr threads (-t)     speedup
>     24                +3%
>     48               +12%
>     96               +21%
>    192               +28%

Impressive!!!

I have to ask...  Any data for smaller numbers of CPUs?

							Thanx, Paul

> I'm curious to see what the build bots have to say about this.
> 
> This series applies on top of v6.11.1.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: John Stultz <jstultz@google.com>
> Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: maged.michael@gmail.com
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Cc: rcu@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: lkmm@lists.linux.dev
> 
> Mathieu Desnoyers (4):
>   compiler.h: Introduce ptr_eq() to preserve address dependency
>   Documentation: RCU: Refer to ptr_eq()
>   hp: Implement Hazard Pointers
>   sched+mm: Use hazard pointers to track lazy active mm existence
> 
>  Documentation/RCU/rcu_dereference.rst |  38 ++++++-
>  Documentation/mm/active_mm.rst        |   9 +-
>  arch/Kconfig                          |  32 ------
>  arch/powerpc/Kconfig                  |   1 -
>  arch/powerpc/mm/book3s64/radix_tlb.c  |  23 +---
>  include/linux/compiler.h              |  63 +++++++++++
>  include/linux/hp.h                    | 154 ++++++++++++++++++++++++++
>  include/linux/mm_types.h              |   3 -
>  include/linux/sched/mm.h              |  71 +++++-------
>  kernel/Makefile                       |   2 +-
>  kernel/exit.c                         |   4 +-
>  kernel/fork.c                         |  47 ++------
>  kernel/hp.c                           |  46 ++++++++
>  kernel/sched/sched.h                  |   8 +-
>  lib/Kconfig.debug                     |  10 --
>  15 files changed, 346 insertions(+), 165 deletions(-)
>  create mode 100644 include/linux/hp.h
>  create mode 100644 kernel/hp.c
> 
> -- 
> 2.39.2
