Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D671993AE;
	Thu, 25 Jul 2024 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721920941; cv=none; b=gAuDkTfobPz4pVkF+EkaKZTKM3d3eKoCBD5Rt/6qhovZGKPrChlTDjMae7Q5oxLGk5dlcjIrLGY2AkuDLzi6qSKxubg+M+CDvUAdim/md3dgwNofJRWuvGkk7Jo/ETDdLVEhS1i1k8WCfNC5N9JZlQzx6CAMgDUM0K+cu9BwTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721920941; c=relaxed/simple;
	bh=gAWZqpgLpw/cslZTppcs196uMtnC5f1eZdrcRvgrq0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRxVa2n4lZHfUgQ+9ryl5/wcz4UUglaC7R6BN8gEpucCj6LdTwwQbgrGBaCNRLsMUUHwhzGPHheBflHG5ND7PMPy/tegLwtVIQ2OyxMaRSNz1MYdIi0yvBFcH5zhJYLiuVNUZbrDmJ5brq6W/EUwPzU/HmpaIsjExqewEjXwt3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6blw3LG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6blw3LG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23B6C116B1;
	Thu, 25 Jul 2024 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721920941;
	bh=gAWZqpgLpw/cslZTppcs196uMtnC5f1eZdrcRvgrq0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6blw3LGVh4qrB5AXwaTsh92xrwezBsfddhhJ18CaZZjCKk18fyND5fWS6jxAXe88
	 vVWgPqoy161CYTPnttncrx+Ghv1i7Yi15f6gjIf4FW9MM2RdHRP2h/YYakTS1+myMT
	 SfxuOnK8NgA3HymDhzKIeRVlUSOiEY7k/JyLKTTJrWe4qygwGlXkLA7f5tJhCGHgxk
	 jHT3gMrykfrztimHyZxm9suhznx2NBrcJAElBtRMvWgLMU0388oJ2QaI/qQfzbz4U6
	 MAuQgfAtWkq+Erkxv2rutXoa+kMgthXswersZYh3LC2dhaH/2E5BoXryroOxbB+rPD
	 rV4aQqAIR2/ng==
Date: Thu, 25 Jul 2024 20:52:12 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 00/25] context_tracking, rcu: Spring cleaning of
 dynticks references
Message-ID: <20240725152212.GA927726@neeraj.linux>
References: <20240724144325.3307148-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724144325.3307148-1-vschneid@redhat.com>

On Wed, Jul 24, 2024 at 04:43:00PM +0200, Valentin Schneider wrote:
> Git info
> ========
> 
> The series is based on rcu/next at:
> f395ae346be5 ("Merge branches 'doc.2024.06.06a', 'fixes.2024.06.06a', 'mb.2024.06.03a', 'nocb.2024.06.03a', 'rcu-tasks.2024.06.06a' and 'rcutorture.2024.06.06a' into HEAD")
>

Hi Valentin,

I see that this series is based on paulmck/linux-rcu.git next branch,
whereas the RCU tree has moved to shared tree now [1] and the next
branch there is pulled for v6.11 (tag: rcu.2024.07.12a). I get merge
conflicts while applying it. Can you please rebase?


[1] https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/log/?h=next


- Neeraj

> It's also available as a git tree at:
> https://gitlab.com/vschneid/linux.git -b redhat/isolirq/defer/v3-rcu-v3
> 
> 
> Series description
> ==================
> 
> I've done one patch per renaming for my own sanity, a lot of these probably
> deserve to be squashed together (e.g. all of the nmi_nesting into one).
> 
> At the end of the renaming exercise, the remaining RCU references to "dyntick"
> are:
> - Comments in core RCU code:
>   kernel/rcu/:
>   tree.h:208:8:	/* 3) dynticks interface. */
>   tree.h:209:46:	int  watching_snap;		/* Per-GP tracking for dynticks. */
>   tree_nocb.h:55:19: * about entering dyntick-idle mode.
>   tree_plugin.h:873:4: * dyntick-idle quiescent state visible to other CPUs, which will in
>   Kconfig:11:4:	# Dynticks-idle tracking
>   tree.c:358:56: * We inform the RCU core by emulating a zero-duration dyntick-idle period.
>   tree.c:773:10: * is in dynticks idle mode, which is an extended quiescent state.
>   tree.c:793:54: * by virtue of being in or having passed through an dynticks idle state since
>   tree.c:808:44:	 * If the CPU passed through or entered a dynticks idle phase with
>   tree.c:1986:14:		/* Collect dyntick-idle snapshots. */
>   tree.c:1989:13:		/* Handle dyntick-idle and offline CPUs. */
>   tree.c:2683:54: * Otherwise, invoke the specified function to check dyntick state for
>   tree.c:2743:16: * CPUs are in dyntick-idle mode.
> 
> 
> - Stale documentation in RCU/Design/Data-Structures/Data-Structures.rst
>   referencing fields that have been moved out of RCU after
>   904e600e60f4 ("rcu/context_tracking: Move dynticks_nesting to context tracking")
> 
> Testing
> =======
> 
> Ran through TREE01 and TREE04.
> 
> Revisions
> =========
> 
> v2 -> v3
> ++++++++
> 
> o Collected Reviewed-By
> o Rebased onto latest rcu/next
> 
> o Made it clear rcu_dynticks_in_eqs_since() is to be used in wait-for-EQS loops
> o Slight rename variations following v2 suggestions
> 
> Cheers,
> Valentin
> 
> 
> Valentin Schneider (25):
>   treewide: context_tracking: Rename CONTEXT_* into CT_STATE_*
>   context_tracking, rcu: Rename RCU_DYNTICKS_IDX into CT_RCU_WATCHING
>   context_tracking, rcu: Rename ct_dynticks() into ct_rcu_watching()
>   context_tracking, rcu: Rename ct_dynticks_cpu() into
>     ct_rcu_watching_cpu()
>   context_tracking, rcu: Rename ct_dynticks_cpu_acquire() into
>     ct_rcu_watching_cpu_acquire()
>   context_tracking, rcu: Rename struct context_tracking
>     .dynticks_nesting into .nesting
>   context_tracking, rcu: Rename ct_dynticks_nesting() into ct_nesting()
>   context_tracking, rcu: Rename ct_dynticks_nesting_cpu() into
>     ct_nesting_cpu()
>   context_tracking, rcu: Rename struct context_tracking
>     .dynticks_nmi_nesting into .nmi_nesting
>   context_tracking, rcu: Rename ct_dynticks_nmi_nesting() into
>     ct_nmi_nesting()
>   context_tracking, rcu: Rename ct_dynticks_nmi_nesting_cpu() into
>     ct_nmi_nesting_cpu()
>   context_tracking, rcu: Rename DYNTICK_IRQ_NONIDLE into
>     CT_NESTING_IRQ_NONIDLE
>   context_tracking, rcu: Rename rcu_dynticks_task*() into rcu_task*()
>   context_tracking, rcu: Rename rcu_dynticks_curr_cpu_in_eqs() into
>     rcu_watching_curr_cpu()
>   rcu: Rename rcu_dynticks_eqs_online() into rcu_watching_online()
>   rcu: Rename rcu_dynticks_in_eqs() into rcu_watching_snap_in_eqs()
>   rcu: Rename rcu_dynticks_in_eqs_since() into
>     rcu_watching_snap_stopped_since()
>   rcu: Rename rcu_dynticks_zero_in_eqs() into rcu_watching_zero_in_eqs()
>   rcu: Rename struct rcu_data .dynticks_snap into .watching_snap
>   rcu: Rename struct rcu_data .exp_dynticks_snap into .exp_watching_snap
>   rcu: Rename dyntick_save_progress_counter() into
>     rcu_watching_snap_save()
>   rcu: Rename rcu_implicit_dynticks_qs() into rcu_implicit_eqs()
>   rcu: Rename rcu_momentary_dyntick_idle() into rcu_momentary_eqs()
>   rcu: Update stray documentation references to rcu_dynticks_eqs_{enter,
>     exit}()
>   context_tracking, rcu: Rename rcu_dyntick trace event into
>     rcu_watching
> 
>  .../Data-Structures/Data-Structures.rst       |  28 ++--
>  .../Tree-RCU-Memory-Ordering.rst              |   8 +-
>  .../Memory-Ordering/TreeRCU-dyntick.svg       |   8 +-
>  .../Design/Memory-Ordering/TreeRCU-gp-fqs.svg |   8 +-
>  .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg |   8 +-
>  .../Memory-Ordering/TreeRCU-hotplug.svg       |   4 +-
>  arch/Kconfig                                  |   2 +-
>  arch/arm64/kernel/entry-common.c              |   2 +-
>  arch/powerpc/include/asm/interrupt.h          |   6 +-
>  arch/powerpc/kernel/interrupt.c               |   6 +-
>  arch/powerpc/kernel/syscall.c                 |   2 +-
>  arch/x86/entry/common.c                       |   2 +-
>  include/linux/context_tracking.h              |  32 ++--
>  include/linux/context_tracking_state.h        |  58 ++++----
>  include/linux/entry-common.h                  |   2 +-
>  include/linux/rcutiny.h                       |   2 +-
>  include/linux/rcutree.h                       |   2 +-
>  include/trace/events/rcu.h                    |  18 +--
>  kernel/context_tracking.c                     | 140 +++++++++---------
>  kernel/entry/common.c                         |   2 +-
>  kernel/rcu/rcu.h                              |   4 +-
>  kernel/rcu/rcutorture.c                       |   4 +-
>  kernel/rcu/tasks.h                            |   2 +-
>  kernel/rcu/tree.c                             | 111 +++++++-------
>  kernel/rcu/tree.h                             |   4 +-
>  kernel/rcu/tree_exp.h                         |   8 +-
>  kernel/rcu/tree_nocb.h                        |   2 +-
>  kernel/rcu/tree_plugin.h                      |   6 +-
>  kernel/rcu/tree_stall.h                       |   6 +-
>  kernel/sched/core.c                           |   4 +-
>  kernel/stop_machine.c                         |   2 +-
>  kernel/trace/trace_osnoise.c                  |   4 +-
>  32 files changed, 256 insertions(+), 241 deletions(-)
> 
> --
> 2.43.0
> 
