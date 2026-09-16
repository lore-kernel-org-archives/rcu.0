Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E72252D2D8;
	Wed, 16 Sep 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569355; cv=none; b=e65BA4UrH606IhIr6X+UP/pGchMKDOWNpNpSPMtaaXjmwRZSxDb0R7+VBcgXd0oEmmZxIZxFdB7CV4tMdqkjoyjhcpKLTolVHyNtQc1ZyKcUuZrpdsBkNJypAkpYjk4l+iX6ui8yvTtIDNP7ASIT2UJI2euVruF8xnyV3O7INWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569355; c=relaxed/simple;
	bh=7oUNScbLhLVmbifKAon+Dy5z9EPbwE+6Slb6PewB6wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFa4TRMrDMeJYSQFlCct/p8oBrMFYnXeFK9jsiZUVcdNVFiKZiOR2cKY3DuiffB8Q18jkDACTtKm+Ce11Hucs/IhY1C1GX+o9wPWA06dyUC5PHldAZhc8HBANgF0BTT9vMGujIU2WNnakp5KxBdtPXO1vKJf6on4QkCkAGlM5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA5kMueD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA5kMueD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284711F00893;
	Wed, 16 Sep 2026 14:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569353;
	bh=dRzGIp8BZC3HTfXO+TCW/m41vLXjfhf9X+2OCoM1kLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FA5kMueDfHQy6e7vnoQFHpYhwZpX7iem27nD89IbZJX2O9EUmarZgs1YNP4KAYjAK
	 QifdGNffl2hCcco37lyGuH3hnSh6qg+tY3yJtb3RWolk50ac+Z7PmhikxXXLCDUc3l
	 CnuwVmM9f3JUI5Ylx7XQYhbg4O78htzc8S2XmH7oHC9F2WbMqRXZ2mLRizxW4+c6IK
	 wLhbL7RGjN9QRqvaBL7HmI70fgIgjcWABsFnNBBIbszSofHGVMPtQmr61SstIQUgeI
	 nEaLyqYTCaYzHG7enXG6FfKdw6evl82vQs3bPs+7qBV93sYtEKnTZ4HL2C4CoAyN71
	 tmAdxw/yHaJMw==
Date: Wed, 16 Sep 2026 16:35:50 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <aqqpRoTfywUuTgoC@localhost.localdomain>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
 <20260915-b4-rcu-tasks-preempt-qs-v3-3-0ad30c4c5ee7@toxicpanda.com>
 <aqlgxKGk_AEKls_1@localhost.localdomain>
 <edc7cca2-a5c5-455c-8969-ea05dbdb08f7@paulmck-laptop>
 <aqqONH8flTIpOUqT@localhost.localdomain>
 <91687748-0781-4133-baed-43cf82f35ff5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91687748-0781-4133-baed-43cf82f35ff5@paulmck-laptop>

Le Wed, Sep 16, 2026 at 07:26:35AM -0700, Paul E. McKenney a écrit :
> On Wed, Sep 16, 2026 at 02:40:20PM +0200, Frederic Weisbecker wrote:
> > Le Tue, Sep 15, 2026 at 04:56:41PM -0700, Paul E. McKenney a écrit :
> > > > Alternatively the approach could be generalized to vanilla RCU, it could be
> > > > possible to define a .text.rcu_no_qs section within which code running is
> > > > considered as an RCU reader (with a pause while on the explicit RCU tasks
> > > > section). It would be forbidden to voluntary sleep inside
> > > > and to put explicit preemption points (CONFIG_PROVE_RCU could report misuses).
> > > > 
> > > > Based on IP, RCU could consider those interrupted section as readers. This would
> > > > require PREEMPT_RCU though.
> > > > 
> > > > And then synchronize_rcu() would do the 1, 2, 4 jobs.
> > > 
> > > If I am following correctly (ha!), sleepable BPF programs rule out use
> > > of RCU in this manner.
> > > 
> > > But your point is nevertheless valid, in that SRCU could be used.
> > > And because rcu_read_lock_trace() is a thin wrapper around SRCU-fast, we
> > > *might* be able to instead use rcu_read_lock_tasks_trace(), which would
> > > skip the task-struct increment and decrement, saving a few instructions.
> > > Then, instead of waiting for each task's counter to go to zero, instead
> > > just invoke synchronize_rcu_tasks_trace().
> > > 
> > > Which is pretty close to what Josef is proposing, just with the new RCU
> > > Tasks Trace read-side primitives.  I think.  ;-)
> > > 
> > > This assumes that we do not need to flatten partially overlapping RCU
> > > Tasks Trace readers into one big reader.
> > > 
> > > Or am I missing something here?
> > 
> > Yes I think that's what Josef does in this patchset. The problem is about
> > handling the few instructions:
> > 
> > 1) between the begining of the trampoline and the call to rcu_read_lock_trace()
> > 
> > 2) between the call to rcu_read_unlock_trace() and the end of the trampoline
> > 
> > So what I'm proposing is to make those two parts implicit RCU read lock sections.
> > 
> > So the whole trampoline would be .text.rcu_no_qs:
> > 
> > .text.rcu_no_qs trampoline:
> >   __________________________________________________________________________________________
> >  |Few instructions 1 | rcu_read_lock_trace() .... rcu_read_unlock_trace | Few instructions 2|
> >  ___________________________________________________________________________________________
> > 
> > Then when a tick fires, rcu_flavor_sched_clock_irq() discards the interrupted
> > code as QS if the IP was within .text.rcu_no_qs _unless_ it is in the
> > rcu_read_lock_trace. Both are easy and quick to verify.
> > 
> > Also preempt_schedule_irq() would make sure to verify the same condition and
> > enqueue the task as a GP blocker if preempting inside "Few instructions 1"
> > or "Few instructions 2".
> 
> Ah, OK, I might be following now.  ;-)
> 
> We also need both versions of rcu_exp_handler() to check the IP as well,
> given that sooner or later someone is going to want trampoline removal
> to go faster.  Or am I still missing a turn in here somewhere?

Yes indeed, missed the exp part!

> 
> > And since RCU tasks already does a synchronize RCU before and after the scan,
> > that's all we would have to do.
> 
> This is going to need some *serious* documentation.

Yes :-)

> Also, what would be a good way to add tests for this to rcutorture?
> Designate some new rcutorture function as being in .text.rcu_no_qs and
> add this as another type of rcutorture reader?  Or is there a better way?

Yes that sounds good!

> 
> 							Thanx, Paul

-- 
Frederic Weisbecker
SUSE Labs
