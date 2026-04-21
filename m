Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422E259CB9
	for <rcu@vger.kernel.org>; Tue, 21 Apr 2026 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813042; cv=none; b=NTsbkrGTowab5w8yqPqxiIWkZTkaFWNw48/VSxR2NPvS5m4kYqWjbGXKGQoLpnoZ3neZN8+vaurhkn2cyvfUG5A5fBAgn3Ejg6hrpIymYTRbFWCroGJplkLklVMfI3fdrToI5vbtnNHfHQmK5LnDxLyRDZ6rx33qkr/COl3zxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813042; c=relaxed/simple;
	bh=uWFGKbNF+jvCnJvLU7bV2fXPTdB62h78thExsjJWKSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAG4ukQg2BqGxHG9qVGIDq6A9bvIkB0bevn9XqdRHEo3ZTMuRtyP4oUYP3TkZGjSYFQCEyLZ3yEGeW1vH4wprKcWBDWm6KWX/rXYpgOgObWzes3il6uM1X9eHoR/nTryTpn7y5YMkyZTOjXsmHGhYCAyQQ51fidKKLpu+J3p3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy5hv4Ym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy5hv4Ym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FACC2BCB0;
	Tue, 21 Apr 2026 23:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776813041;
	bh=uWFGKbNF+jvCnJvLU7bV2fXPTdB62h78thExsjJWKSo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Yy5hv4YmmcgAI82jCQraYYf5vDilMpQRVB61ZB03JtSBqLmUEK2zz+nNiR3JTMT7I
	 kcmkeeBgL7nMrU57E/S9EWIRivKvhpoQXon/miiKn3YSgyAOD0HRo94fvSfRgfJIDL
	 1tLNXXxiLMBlyvAp257ITERNKS0XSCGQ+cdlG+D0ze9cKeCnAu0NAbk76PMugRl7qD
	 nNNEIFY2A9qCg9QrltZef577/7KmG2/oGr3i0keM9Y4YCh/7NambeftK1mtAaiLF1q
	 Tn/n+/Uk7IlvVi0Wdh96CrD6K81DZFXlrpmV9cTXvzxiIr6y5PvOkjLBXr4uYyXwbS
	 6fGP3gb6xuX9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 488D2CE0C56; Tue, 21 Apr 2026 16:10:41 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:10:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
Message-ID: <805c33d7-3a7b-470c-bd9d-065717a3e3e2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
 <DHZ7543VMYIQ.1US6BY7G0AUJK@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHZ7543VMYIQ.1US6BY7G0AUJK@gmail.com>

On Tue, Apr 21, 2026 at 03:46:30PM -0700, Alexei Starovoitov wrote:
> On Thu Apr 16, 2026 at 2:10 AM PDT, Harry Yoo (Oracle) wrote:
> >  struct kfree_rcu_cpu {
> > +	// Objects queued on a lockless linked list, used to free objects
> > +	// in unknown contexts when trylock fails.
> > +	struct llist_head defer_head;
> > +
> > +	struct irq_work defer_free;
> > +	struct irq_work sched_delayed_monitor;
> > +	struct irq_work run_page_cache_worker;
> > +
> >  	// Objects queued on a linked list
> >  	struct rcu_ptr *head;
> >  	unsigned long head_gp_snap;
> > @@ -1333,12 +1341,99 @@ struct kfree_rcu_cpu {
> >  	struct llist_head bkvcache;
> >  	int nr_bkv_objs;
> >  };
> > +
> > +static void defer_kfree_rcu_irq_work_fn(struct irq_work *work);
> > +static void sched_delayed_monitor_irq_work_fn(struct irq_work *work);
> > +static void run_page_cache_worker_irq_work_fn(struct irq_work *work);
> > +
> > +static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> > +	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
> > +	.defer_head = LLIST_HEAD_INIT(defer_head),
> > +	.defer_free = IRQ_WORK_INIT(defer_kfree_rcu_irq_work_fn),
> > +	.sched_delayed_monitor =
> > +		IRQ_WORK_INIT_LAZY(sched_delayed_monitor_irq_work_fn),
> > +	.run_page_cache_worker =
> > +		IRQ_WORK_INIT_LAZY(run_page_cache_worker_irq_work_fn),
> > +};
> 
> I think kfree_rcu_cpu doesn't need to be per-cpu.
> It can be global llist with single irq_work for them all.

I would be quite nervous about that, but you might well be right, given
that this is a trylock-acquisition failure path.  Give or take people
and/or machines analyzing the code for potential denial-of-service
attacks.  :-/

> Not sure about sched_delayed_monitor/run_page_cache_worker.
> Do they have to be per-cpu ? Can all 3 share single irq_work?

On the other hand, if all CPUs are doing kfree_rcu() in even a semi-tight
loop, having them all unconditionally use global state is not going to
make for a fun time on large systems.  And there already are situations
where user code can make all CPUs to call_rcu() in a semi-tight loop,
so even if that is not yet the case for kfree_rcu(), past experience
indicates that it soon will be.

And noted on the desirability of call_rcu_nolock(), apologies for being
slow.

							Thanx, Paul
