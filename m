Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F563932D1
	for <rcu@vger.kernel.org>; Wed, 22 Apr 2026 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776826928; cv=none; b=FQ+P1nYZk9OhCndfnrM8pOwtf0zqAerUxuHGncnWStUtGrUrjBoagKGhpilYFOrPTnG9BriQBQtvEnHSO/3eSTrj0ZoC5q7ZV3knifyYYQGs47TcrNAfUCW2MqFjWLlUoZe6lDd9Lz1ALZf5auG17dVMHeE88TtrjkWxcZ6ziJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776826928; c=relaxed/simple;
	bh=sd4O6bp9bJ6/CkpIBKSx3gBRzusegphBjTuUq0STAQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbnnNnv1gyI4r07AApjDX+lyhw6tWfo22uzul0FSuIXHJ4n0bSLrkL7QJZ7SE6dcyLxsMqg0grW7MiG6cl5WR5wlbcsgbe8OGqrFemn3akdtiWt0ED4jonH/Oh2AA1h2Ar7EX5+X+zoDnKH/+6K+OsqfF1UR1DJ+mZnOU0UlPEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLiP4ZEn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLiP4ZEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D429C2BCB0;
	Wed, 22 Apr 2026 03:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776826925;
	bh=sd4O6bp9bJ6/CkpIBKSx3gBRzusegphBjTuUq0STAQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLiP4ZEnUe7HRV+QaodZGpD/1YTHkLAj6H+vbGJmFwrXaauLuOTvX+QWd2+TVDbwa
	 thHLX39Cp6IDLUfKSUcZ0sSc4Eh0jO1Lj0eZxLMrbmWHJmlBZhWfKuvjBVt2h58UvC
	 ifBU+FUGg21SKDQuWb4vYCi/P57VJJ9WR0fpYpceU3c7sOIKGhCMnhYMOKN+mw9cVV
	 KfIgaXMe8wWlgDouuSa2ObFEI9PUIzcDZ7AVsKWIay9j7ZS46EwqWZHRsf7YSWlNds
	 5QKGBxwFERxA/UqXIU6Hj24S4uSOnxEteFHvygjp2HfivQp2Ei0+u8Edc2aCX84GtS
	 uVPWJnPV+IwsA==
Date: Wed, 22 Apr 2026 12:02:03 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <aeg6K-NcvFHZ02bk@hyeyoo>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
 <DHZ7543VMYIQ.1US6BY7G0AUJK@gmail.com>
 <805c33d7-3a7b-470c-bd9d-065717a3e3e2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <805c33d7-3a7b-470c-bd9d-065717a3e3e2@paulmck-laptop>

On Tue, Apr 21, 2026 at 04:10:41PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 21, 2026 at 03:46:30PM -0700, Alexei Starovoitov wrote:
> > On Thu Apr 16, 2026 at 2:10 AM PDT, Harry Yoo (Oracle) wrote:
> > >  struct kfree_rcu_cpu {
> > > +	// Objects queued on a lockless linked list, used to free objects
> > > +	// in unknown contexts when trylock fails.
> > > +	struct llist_head defer_head;
> > > +
> > > +	struct irq_work defer_free;
> > > +	struct irq_work sched_delayed_monitor;
> > > +	struct irq_work run_page_cache_worker;
> > > +
> > >  	// Objects queued on a linked list
> > >  	struct rcu_ptr *head;
> > >  	unsigned long head_gp_snap;
> > > @@ -1333,12 +1341,99 @@ struct kfree_rcu_cpu {
> > >  	struct llist_head bkvcache;
> > >  	int nr_bkv_objs;
> > >  };
> > > +
> > > +static void defer_kfree_rcu_irq_work_fn(struct irq_work *work);
> > > +static void sched_delayed_monitor_irq_work_fn(struct irq_work *work);
> > > +static void run_page_cache_worker_irq_work_fn(struct irq_work *work);
> > > +
> > > +static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> > > +	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
> > > +	.defer_head = LLIST_HEAD_INIT(defer_head),
> > > +	.defer_free = IRQ_WORK_INIT(defer_kfree_rcu_irq_work_fn),
> > > +	.sched_delayed_monitor =
> > > +		IRQ_WORK_INIT_LAZY(sched_delayed_monitor_irq_work_fn),
> > > +	.run_page_cache_worker =
> > > +		IRQ_WORK_INIT_LAZY(run_page_cache_worker_irq_work_fn),
> > > +};
> > 
> > I think kfree_rcu_cpu doesn't need to be per-cpu.

After reading this, I was like "Oh, that's quite a drastic change?",
but looks like I misread it. I didn't create a new percpu structure,
but extended the existing one.

I guess you meant the new fields added (defer_head, and irq works)
to struct kfree_rcu_cpu, not the whole structure.

> > It can be global llist with single irq_work for them all.

It could be, but what is the benefit of separating them from
existing kfree_rcu_cpu and making them global?

> I would be quite nervous about that, but you might well be right, given
> that this is a trylock-acquisition failure path.  Give or take people
> and/or machines analyzing the code for potential denial-of-service
> attacks.  :-/

It'll probably not that bad because it's trylock-acquisiion failure path
of per-cpu lock; IIRC during my test, falling back to defer_free
happened only a few times (< 10) when the kunit test is calling
kfree_rcu() in a tight loop (100k calls) while concurrently invoking
kfree_rcu_nolock() ~10k times on the same CPU.

> > Not sure about sched_delayed_monitor/run_page_cache_worker.
> > Do they have to be per-cpu ?

Since existing sched_delayed_monitor/run_page_cache_worker works are
per-cpu, I think it's better to keep those irq_works per-cpu as well.

> > Can all 3 share single irq_work?

I thought defer_free and defer_call_rcu should be non-lazy irq work
and others should be lazy irq work. And I was thinking of having
one lazy and one non-lazy IRQ work (two instead of four).

But given that sched_delayed_monitor and run_page_cache_worker should
not triggered that frequently anyway, it'll probably be okay for all of
them to share a single non-lazy IRQ work.

> On the other hand, if all CPUs are doing kfree_rcu() in even a semi-tight
> loop, having them all unconditionally use global state is not going to
> make for a fun time on large systems.  And there already are situations
> where user code can make all CPUs to call_rcu() in a semi-tight loop,
> so even if that is not yet the case for kfree_rcu(), past experience
> indicates that it soon will be.

A tight loop for kfree_rcu() should be fine.

I think the question is "Can a malicious user can make all CPUs to
kfree_rcu() in a tight loop AND concurrently trigger kfree_rcu_nolock()
on those CPUs, so that trylock will mostly fail"

> And noted on the desirability of call_rcu_nolock(), apologies for being
> slow.

No problem. Really appreciate looking into it, Alexei and Paul!

-- 
Cheers,
Harry / Hyeonggon
