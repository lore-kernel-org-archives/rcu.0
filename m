Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05F22CBD9;
	Sun,  2 Aug 2026 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785703630; cv=none; b=e2mH7fLAEWGZNx73Fn92cpQ0yBMHKh5Wi6hqj/hViLH45ADRESQdP4kYn3qZeCCr75jxBUNx8FqIikhztv/2Rfn5h6VIWUEWZUxPsZZEmSTKKI+2jeDuAghSfcuf9nmWQk9Xw/L0ZHGlH4bIxaO00ADSmC1bCUMFSTxUKGwq7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785703630; c=relaxed/simple;
	bh=F5oX/jszxsav1DpNItKt47lDP8ox3JEfhfTCJmFUqOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StXV1RjsebfjX8Z9O8tPSGjcxlehyDHTU/3XVgbB2tz8H3OCcOzXCYvLeSYhBju9E6OGjbOEqzrAXk/buDtt2jMqTmdtjHVGKdh8jljIyz57MfqBfMyUE56NExmJYXrGp5drz40z6jc8u1hFbLA8F53lIfLU89P9vHD5e9aPFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzIwO+GP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzIwO+GP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E061F000E9;
	Sun,  2 Aug 2026 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785703629;
	bh=ZEpbOoyAgd8U9otS3+svfsLTO28M4sOEaw9r2Tv89HE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=HzIwO+GP+fXxGRnEgpXFRWrtZBcAE8WwgC6eIH9booxA+wf4wATM+IWSUQTtKoiPg
	 5jO4bfuxL+/g4FgofthE1PrvwbDx2Vw947mGeh/xONG8pw0xcdqKPjZlbt+EIe7ISy
	 10MNUaKW8Hs3E3rxDrt1rU5Yiq8VV1LC+WyqoviXVF4TATdq+RQem85mT+/z1CiKAc
	 fRdwFLEpVeJj6qBtmHc94he2e2L4ERx4HyDouVfuddb3tRSsZkVLeTdNLfZOOgljCz
	 IAq+dIE7XzED+PACUqqV0zv1wOTGV1HbrRMGyOe9sLZXDhJhoO8L8rxVyiEYyr7gqm
	 sZcaAguEmSgIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C9931CE1887; Sun,  2 Aug 2026 13:47:08 -0700 (PDT)
Date: Sun, 2 Aug 2026 13:47:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
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
Message-ID: <22a89293-b622-42c0-81a5-6b92160e0046@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260729162207.1567770-1-puranjay@kernel.org>
 <0096fbf8-c3be-4388-a60b-1968664e4f27@paulmck-laptop>
 <DKEQ1D0U77V6.1EMGXI819YAW9@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKEQ1D0U77V6.1EMGXI819YAW9@gmail.com>

On Sun, Aug 02, 2026 at 09:56:53PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu Jul 30, 2026 at 5:07 AM CEST, Paul E. McKenney wrote:
> > On Wed, Jul 29, 2026 at 09:21:59AM -0700, Puranjay Mohan wrote:
> >> call_rcu() and call_srcu() only ever touch their per-CPU callback lists
> >> with interrupts disabled: the enqueue runs under local_irq_save() (and the
> >> nocb locks when offloaded), and so do callback invocation and grace-period
> >> work.  That is fine as long as call_rcu() itself is invoked with
> >> interrupts enabled, but it is not always.  An NMI handler can call
> >> call_rcu(), and instrumentation can reenter it.  The case that prompted
> >> this is a BPF program attached to rcu_segcblist_enqueue() that frees an
> >> object: the free reaches call_rcu_tasks_trace(), which is call_srcu()
> >> under the hood, back on the same CPU with the srcu_data lock already held,
> >> and it deadlocks on that lock.  Either way, enqueuing directly can corrupt
> >> the list or deadlock.
> >>
> >> Rather than scatter context checks through the enqueue, make it defer
> >> whenever interrupts are disabled: stage the callback on a per-CPU lockless
> >> list and re-issue it from an irq_work once interrupts are back on, going
> >> straight to the enqueue helper so the re-issue cannot defer again.  Only
> >> the drain side takes a lock; the staging is a bare llist_add() and stays
> >> safe from NMI.  This is behind a new hidden CONFIG_RCU_DEFER, which is set
> >> wherever a reentrant enqueue is possible (HAVE_NMI, KPROBES,
> >> FUNCTION_TRACER or TRACEPOINTS); without it call_rcu() enqueues exactly as
> >> before.
> >>
> >> CPU offline is the awkward part.  A callback can be deferred very late in
> >> the outgoing CPU's teardown -- from do_idle() or cpuhp_ap_report_dead(),
> >> past the CPUHP_AP_SMPCFD_DYING flush that would otherwise run the irq_work
> >> -- so the irq_work can no longer run there to re-issue it.  rcu_barrier()
> >> and srcu_barrier() therefore drain the deferred lists themselves before
> >> they wait: for online CPUs they wait the irq_work out, and for offline
> >> ones they drain the list directly, since that irq_work may never run
> >> again.  rcutree_migrate_callbacks() drains the outgoing CPU's list too, so
> >> a late deferral still lands on a callback list even when nobody calls a
> >> barrier.  To keep those three drainers from stepping on each other, the
> >> drain holds a per-CPU raw lock across the llist_del_all() and the
> >> re-issue, so a drainer never returns having pulled callbacks off the
> >> deferred list but not yet put them on a callback list.  Every lock the
> >> re-issue touches (nocb, rcu_node, srcu_data) is already raw, so the
> >> nesting is fine.
> >>
> >> The irq_work is IRQ_WORK_INIT_HARD.  It is not needed for correctness, but
> >> a non-HARD irq_work runs from a kthread on PREEMPT_RT and can be delayed
> >> under load, letting deferred callbacks pile up; running the re-issue in
> >> hard-irq context keeps that from turning into an OOM.
> >>
> >> Patches 1 and 2 do Tree and Tiny RCU, 3 and 4 Tree and Tiny SRCU.  Patch 5
> >> teaches rcutorture to issue ->call() from a perf-overflow NMI -- the
> >> nmi_calls parameter, on by default -- on the flavors that advertise it,
> >> and checks that every callback issued from NMI is later invoked.  Patch 6
> >> adds the BPF reentry reproducer described above.
> >
> > Nice!  I applied this series to -rcu for testing and review.  Patch 6
> > might want to go up a different path, but let's see how it goes.
> > If it goes via -rcu, it will need an appropriate ack.
> >
> 
> I think it makes sense to take it through your tree for now. If there are issues
> when we get these changes on BPF side (with the selftest), we'll fix forward. If
> we take it now, it will end up deadlocking the CI, so should come with the
> relevant changes once trees are synced.
> 
> You can add my ack when taking it in.
> 
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Very good, and I will apply this on my next rebase.

							Thanx, Paul

> >> Puranjay Mohan (6):
> >>   rcu: Make call_rcu() safe to call from any context
> >>   rcu: Make Tiny call_rcu() safe to call from any context
> >>   srcu: Make call_srcu() safe to call from any context
> >>   srcu: Make Tiny call_srcu() safe to call from any context
> >>   rcutorture: Exercise ->call() from NMI context
> >>   selftests/bpf: Add a call_srcu() re-entry reproducer
> >>
> >>  include/linux/srcutiny.h                      |  11 +-
> >>  include/linux/srcutree.h                      |   4 +
> >>  kernel/rcu/Kconfig                            |   6 +
> >>  kernel/rcu/rcu.h                              |  18 +++
> >>  kernel/rcu/rcutorture.c                       | 115 +++++++++++++++
> >>  kernel/rcu/srcutiny.c                         |  53 ++++++-
> >>  kernel/rcu/srcutree.c                         | 138 +++++++++++++++++-
> >>  kernel/rcu/tiny.c                             | 101 ++++++++++---
> >>  kernel/rcu/tree.c                             | 122 ++++++++++++++--
> >>  kernel/rcu/tree.h                             |   5 +
> >>  .../selftests/bpf/prog_tests/rcu_reentry.c    |  58 ++++++++
> >>  .../testing/selftests/bpf/progs/rcu_reentry.c |  45 ++++++
> >>  12 files changed, 636 insertions(+), 40 deletions(-)
> >>  create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_reentry.c
> >>  create mode 100644 tools/testing/selftests/bpf/progs/rcu_reentry.c
> >>
> >>
> >> base-commit: 9dc303e69bcd49f9668ca090ae45325269531fbb
> >> --
> >> 2.53.0-Meta
> >>
> 
