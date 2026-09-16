Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9565221EF;
	Wed, 16 Sep 2026 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568797; cv=none; b=DGPe2yJd2/+GZ5EfkRn1NvJZYc3tn5evCJKxf9OkI/qIwZUdvP9eDfi+yCA76dQV77Yh/ZNrmeLdFrSUO9bv2XJrJYtDfJuo8GWSJ6Nu37+qlmEBudcsvHYELbuldWq03REJWlxxVZbU9PtcJwEkTxvkkUNV9bNBC//4yo6af84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568797; c=relaxed/simple;
	bh=5FAMRqjp4KOqSJIjiuk2XIQlxb2HmynTSae9DHgZsQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXWyDA2sk1y60V9uu6V3kbcu3Of0KHv9spBp72/Jq7pndR/NXnIYyV9B4AKivpmHAkWE1uOy8E7CoQrOnyIAXtVFp9zJbesxhejKtVUoNiCMLiMjFu4KyOZQU0Q2gx7rSUFYpVTaG+vAUinxUaejpQSl5+gaGokpW6EHgz12S/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNFUoDHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNFUoDHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721FD1F00898;
	Wed, 16 Sep 2026 14:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568795;
	bh=YQpLtInKnNU1c3G2VdhDCkw1r2wibZuZTlQmjanXtRs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=bNFUoDHPGDIHKeQpseuwGqWMM1DE5j1Rk5TojUwfAftuYfcdlx87V1FeTMnCjtl2N
	 AzZz2tcm6JX+Y1OQc6CtoOxaw5D3FfiXa2dnSchn35L6zymzQspNu5cth2kF7lsF5q
	 jpNwWJ3uu8kdD0rYYiWAJjzbNTYo7CXS4+AgNb1RdbrKjGhDjwDBgmcBv56HpihnJf
	 5lAGbidbtuSopBfptp1v/0NgSaHPYv5eiVpr4cDUdhOG39Il9EFme26lRJQ6V++7Fx
	 IZEnAV/A5Yb1YwrjoCJL+B+GlgcJlLS1josFK4IKPCjqSH/X4mmuQciMXq9yC8zj9q
	 8uuQhtPvBPadQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5AEB5CE04DE; Wed, 16 Sep 2026 07:26:35 -0700 (PDT)
Date: Wed, 16 Sep 2026 07:26:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Juergen Gross <jgross@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v3 03/13] rcu-tasks: Add a Tasks RCU implementation
 for reader-marked trampolines
Message-ID: <91687748-0781-4133-baed-43cf82f35ff5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
 <20260915-b4-rcu-tasks-preempt-qs-v3-3-0ad30c4c5ee7@toxicpanda.com>
 <aqlgxKGk_AEKls_1@localhost.localdomain>
 <edc7cca2-a5c5-455c-8969-ea05dbdb08f7@paulmck-laptop>
 <aqqONH8flTIpOUqT@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqqONH8flTIpOUqT@localhost.localdomain>

On Wed, Sep 16, 2026 at 02:40:20PM +0200, Frederic Weisbecker wrote:
> Le Tue, Sep 15, 2026 at 04:56:41PM -0700, Paul E. McKenney a écrit :
> > > Alternatively the approach could be generalized to vanilla RCU, it could be
> > > possible to define a .text.rcu_no_qs section within which code running is
> > > considered as an RCU reader (with a pause while on the explicit RCU tasks
> > > section). It would be forbidden to voluntary sleep inside
> > > and to put explicit preemption points (CONFIG_PROVE_RCU could report misuses).
> > > 
> > > Based on IP, RCU could consider those interrupted section as readers. This would
> > > require PREEMPT_RCU though.
> > > 
> > > And then synchronize_rcu() would do the 1, 2, 4 jobs.
> > 
> > If I am following correctly (ha!), sleepable BPF programs rule out use
> > of RCU in this manner.
> > 
> > But your point is nevertheless valid, in that SRCU could be used.
> > And because rcu_read_lock_trace() is a thin wrapper around SRCU-fast, we
> > *might* be able to instead use rcu_read_lock_tasks_trace(), which would
> > skip the task-struct increment and decrement, saving a few instructions.
> > Then, instead of waiting for each task's counter to go to zero, instead
> > just invoke synchronize_rcu_tasks_trace().
> > 
> > Which is pretty close to what Josef is proposing, just with the new RCU
> > Tasks Trace read-side primitives.  I think.  ;-)
> > 
> > This assumes that we do not need to flatten partially overlapping RCU
> > Tasks Trace readers into one big reader.
> > 
> > Or am I missing something here?
> 
> Yes I think that's what Josef does in this patchset. The problem is about
> handling the few instructions:
> 
> 1) between the begining of the trampoline and the call to rcu_read_lock_trace()
> 
> 2) between the call to rcu_read_unlock_trace() and the end of the trampoline
> 
> So what I'm proposing is to make those two parts implicit RCU read lock sections.
> 
> So the whole trampoline would be .text.rcu_no_qs:
> 
> .text.rcu_no_qs trampoline:
>   __________________________________________________________________________________________
>  |Few instructions 1 | rcu_read_lock_trace() .... rcu_read_unlock_trace | Few instructions 2|
>  ___________________________________________________________________________________________
> 
> Then when a tick fires, rcu_flavor_sched_clock_irq() discards the interrupted
> code as QS if the IP was within .text.rcu_no_qs _unless_ it is in the
> rcu_read_lock_trace. Both are easy and quick to verify.
> 
> Also preempt_schedule_irq() would make sure to verify the same condition and
> enqueue the task as a GP blocker if preempting inside "Few instructions 1"
> or "Few instructions 2".

Ah, OK, I might be following now.  ;-)

We also need both versions of rcu_exp_handler() to check the IP as well,
given that sooner or later someone is going to want trampoline removal
to go faster.  Or am I still missing a turn in here somewhere?

> And since RCU tasks already does a synchronize RCU before and after the scan,
> that's all we would have to do.

This is going to need some *serious* documentation.

Also, what would be a good way to add tests for this to rcutorture?
Designate some new rcutorture function as being in .text.rcu_no_qs and
add this as another type of rcutorture reader?  Or is there a better way?

							Thanx, Paul
