Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1E3546E6;
	Thu, 30 Jul 2026 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380828; cv=none; b=cxzsGTiHquaRExxHrU/cMwEWXGFgnqhRbVWiVqRoUbHF7uS+702JFm4ihgoNnaXwVJ4QbiAruNTL+qlRvt/nQKxFyooJ0fkhy0OWvnoJ2G1NkzWq61R89kHh8zPViwLnZwhYYodiQjEid0OHSNzE3W2V0EZIjVxSrqmUQh6af3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380828; c=relaxed/simple;
	bh=sCY+K4DkAjhiR6dYdfx2h2rqq90TqChd6e8Mt6L7qVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du9C5OUx08/Y+KBumH8zY3xOrvZv3t1ReOOedGjShoYXQsIeHto8b+IW/JbvljKdwSeyKityfyzYRZWHJk7LuG578cp2Ow2qnckKuy1v+Wog5prsq3LA4JQeZFwtUbcjwkCPs+fhD2G13hAgfNZI9n262OQIAANZYCTY61Ad5kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E51sKSfe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E51sKSfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69CB1F000E9;
	Thu, 30 Jul 2026 03:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380826;
	bh=fjAqdmIhpZ1vVpExo2y/0q1CHCN+4GtNv2IMQGVhBK0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=E51sKSfe7wtAhBUuw01PkEfbc3AVabEdl4M0CtOO8olC8Pgd1l4x6feEwrQUyyCVz
	 83A2GvgUZNEy8P5hV0LPfFp1MPY2QfBiMJQnX5i+J2soBwzyqyXBP95cC7yvpEGDgY
	 qJ35qqfL90fJwgg7niIVAv6nTF5/QtwDYHsrxTzwCna8RGXsJl2k0yxSsiGNQsnAGR
	 X17041xB4/K0GHxPTiSAa/J8tPpykxJj0f1KFUzqZoJxKCEE8q9WvKwhaPvzayQIFP
	 uQCOQwNvWrdEKLZgEdc5CpDBjq7KaFNxtriCRgbdV4bHpXSD5CV2JZahPh+JwNI/CA
	 CTX3vcRmUe7rQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 76A50CE1402; Wed, 29 Jul 2026 20:07:06 -0700 (PDT)
Date: Wed, 29 Jul 2026 20:07:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 0/6] rcu,srcu: Make call_rcu()/call_srcu() safe from any
 context
Message-ID: <0096fbf8-c3be-4388-a60b-1968664e4f27@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260729162207.1567770-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729162207.1567770-1-puranjay@kernel.org>

On Wed, Jul 29, 2026 at 09:21:59AM -0700, Puranjay Mohan wrote:
> call_rcu() and call_srcu() only ever touch their per-CPU callback lists
> with interrupts disabled: the enqueue runs under local_irq_save() (and the
> nocb locks when offloaded), and so do callback invocation and grace-period
> work.  That is fine as long as call_rcu() itself is invoked with
> interrupts enabled, but it is not always.  An NMI handler can call
> call_rcu(), and instrumentation can reenter it.  The case that prompted
> this is a BPF program attached to rcu_segcblist_enqueue() that frees an
> object: the free reaches call_rcu_tasks_trace(), which is call_srcu()
> under the hood, back on the same CPU with the srcu_data lock already held,
> and it deadlocks on that lock.  Either way, enqueuing directly can corrupt
> the list or deadlock.
> 
> Rather than scatter context checks through the enqueue, make it defer
> whenever interrupts are disabled: stage the callback on a per-CPU lockless
> list and re-issue it from an irq_work once interrupts are back on, going
> straight to the enqueue helper so the re-issue cannot defer again.  Only
> the drain side takes a lock; the staging is a bare llist_add() and stays
> safe from NMI.  This is behind a new hidden CONFIG_RCU_DEFER, which is set
> wherever a reentrant enqueue is possible (HAVE_NMI, KPROBES,
> FUNCTION_TRACER or TRACEPOINTS); without it call_rcu() enqueues exactly as
> before.
> 
> CPU offline is the awkward part.  A callback can be deferred very late in
> the outgoing CPU's teardown -- from do_idle() or cpuhp_ap_report_dead(),
> past the CPUHP_AP_SMPCFD_DYING flush that would otherwise run the irq_work
> -- so the irq_work can no longer run there to re-issue it.  rcu_barrier()
> and srcu_barrier() therefore drain the deferred lists themselves before
> they wait: for online CPUs they wait the irq_work out, and for offline
> ones they drain the list directly, since that irq_work may never run
> again.  rcutree_migrate_callbacks() drains the outgoing CPU's list too, so
> a late deferral still lands on a callback list even when nobody calls a
> barrier.  To keep those three drainers from stepping on each other, the
> drain holds a per-CPU raw lock across the llist_del_all() and the
> re-issue, so a drainer never returns having pulled callbacks off the
> deferred list but not yet put them on a callback list.  Every lock the
> re-issue touches (nocb, rcu_node, srcu_data) is already raw, so the
> nesting is fine.
> 
> The irq_work is IRQ_WORK_INIT_HARD.  It is not needed for correctness, but
> a non-HARD irq_work runs from a kthread on PREEMPT_RT and can be delayed
> under load, letting deferred callbacks pile up; running the re-issue in
> hard-irq context keeps that from turning into an OOM.
> 
> Patches 1 and 2 do Tree and Tiny RCU, 3 and 4 Tree and Tiny SRCU.  Patch 5
> teaches rcutorture to issue ->call() from a perf-overflow NMI -- the
> nmi_calls parameter, on by default -- on the flavors that advertise it,
> and checks that every callback issued from NMI is later invoked.  Patch 6
> adds the BPF reentry reproducer described above.

Nice!  I applied this series to -rcu for testing and review.  Patch 6
might want to go up a different path, but let's see how it goes.
If it goes via -rcu, it will need an appropriate ack.

							Thanx, Paul

> Puranjay Mohan (6):
>   rcu: Make call_rcu() safe to call from any context
>   rcu: Make Tiny call_rcu() safe to call from any context
>   srcu: Make call_srcu() safe to call from any context
>   srcu: Make Tiny call_srcu() safe to call from any context
>   rcutorture: Exercise ->call() from NMI context
>   selftests/bpf: Add a call_srcu() re-entry reproducer
> 
>  include/linux/srcutiny.h                      |  11 +-
>  include/linux/srcutree.h                      |   4 +
>  kernel/rcu/Kconfig                            |   6 +
>  kernel/rcu/rcu.h                              |  18 +++
>  kernel/rcu/rcutorture.c                       | 115 +++++++++++++++
>  kernel/rcu/srcutiny.c                         |  53 ++++++-
>  kernel/rcu/srcutree.c                         | 138 +++++++++++++++++-
>  kernel/rcu/tiny.c                             | 101 ++++++++++---
>  kernel/rcu/tree.c                             | 122 ++++++++++++++--
>  kernel/rcu/tree.h                             |   5 +
>  .../selftests/bpf/prog_tests/rcu_reentry.c    |  58 ++++++++
>  .../testing/selftests/bpf/progs/rcu_reentry.c |  45 ++++++
>  12 files changed, 636 insertions(+), 40 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
>  create mode 100644 tools/testing/selftests/bpf/progs/rcu_reentry.c
> 
> 
> base-commit: 9dc303e69bcd49f9668ca090ae45325269531fbb
> -- 
> 2.53.0-Meta
> 
