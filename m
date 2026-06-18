Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3D335BA7;
	Thu, 18 Jun 2026 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799999; cv=none; b=IvE52tG0DiqPBFyMbsooU1w3K6uX0dIe2hrTOifSZ8W+V8fooz7X5siIAiR6vsNbV7AKzOzTrYM7UUT971t7PzlCvTUCD7dWWwhhW4KXme+s22BDKR6xVvszLmybLqPjtUD68avzwVs/RXKZczQ6HwtliznGM1qyp91ARm5Kejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799999; c=relaxed/simple;
	bh=l9GsWwxaV6V2eqeKD24cv48fa9vPsxRqYgvfc+DFAUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWPbE/NjcP1Y7hiBbVqV1nElmai5gMVMhoWL8OBxxlYgJRFnx2TunEr3bup2yJEW6I7RaK5Cf7bozY2wxdKVp2rL0h6Ki7ObAd8miHbdRqfzuQ/CWawPQdvU3mvkXM8AYMH6voa7cbhvLjJGjxe/jPpPGbu9btwrVjUyOPaM2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXeSeYYy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXeSeYYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ABF1F000E9;
	Thu, 18 Jun 2026 16:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781799997;
	bh=dp1MV9ObzkvUOdtywXejE6RIKhm8Pl3m6Mmpvgkxwlo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=UXeSeYYy01DT4VR6OXkqWDULLhP/Ccy8K724rlCfZGQAGXI6Lp4xZ8QALJOyHr/2c
	 Mq+ZZjyzqFJ+yAR82SvjbjzJ3ZCqeJG5h4ymHKb1wxf9ngahGzu8FzRLZ/9SRZKyP6
	 Gt243QxzOS35okQnX6XxShRInIQunlGyY4hJ6auK1x2VVoZC8bU1nqcB08/rNrBB/T
	 4kIyLPvyXFgHm19SFWfFF/vb3tNT778H7MuoWRRClTpTfDHxRgmcqy0t9XkjoCiNvY
	 SIoHiZNod8mGUvvxZ5qfhjUwVmosYXvqZy3lJWipH8QqauvCd+CWU2Jspwb/L5k7eJ
	 t025mjEP7Oc5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DC1B9CE0C39; Thu, 18 Jun 2026 09:26:36 -0700 (PDT)
Date: Thu, 18 Jun 2026 09:26:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Harry Yoo <harry@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH for-next v3 6/9] mm/slab: allow kfree_rcu_sheaf() on
 PREEMPT_RT
Message-ID: <2bfc956b-0708-4e55-afba-77843e67b494@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-6-70a54f3775bb@kernel.org>
 <f3a56a5a-f10b-46dc-bc99-28449ade1661@kernel.org>
 <40591888-3a87-433e-b3d2-cda1cab543be@kernel.org>
 <9d8ca1ed-bc53-417f-944b-d78eecd1e6a5@kernel.org>
 <03da8742-3790-4428-84b8-11911bf44c9e@paulmck-laptop>
 <39758d58-f646-470c-9c35-818ac75427d3@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39758d58-f646-470c-9c35-818ac75427d3@kernel.org>

On Thu, Jun 18, 2026 at 09:46:04PM +0900, Harry Yoo wrote:
> On 6/18/26 5:40 AM, Paul E. McKenney wrote:
> > On Wed, Jun 17, 2026 at 07:38:16AM +0200, Vlastimil Babka (SUSE) wrote:
> >> On 6/17/26 07:14, Harry Yoo wrote:
> >>> On 6/17/26 2:24 AM, Vlastimil Babka (SUSE) wrote:
> >>>> On 6/15/26 13:06, Harry Yoo (Oracle) wrote:
> >>>>> As suggested by Vlastimil Babka, kfree_rcu_sheaf() can be used
> >>>>> on PREEMPT_RT if we always assume spinning is not allowed on PREEMPT_RT.
> >>>>> This is because local_trylock and spinlock_t are safe to use with
> >>>>> trylock variant as long as the kernel does not spin and the context is
> >>>>> not NMI and not hardirq.
> >>>>>
> >>>>> Now that __kfree_rcu_sheaf() knows how to handle allow_spin = false,
> >>>>> relax the limitation and try the sheaves path on PREEMPT_RT as well.
> >>>>>
> >>>>> Keep the lockdep map on non RT kernels. However, do not use the lockdep
> >>>>> map on PREEMPT_RT to avoid suppressing valid lockdep warnings.
> >>>>>
> >>>>> Link: https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f98162@kernel.org
> >>>>> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> >>>>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> >>>>
> >>>> LGTM, but maybe unnecessary pessimistic wrt call_rcu() on PREEMPT_RT?
> >>>> I thought (in the Link: above) we'd only need to downgrade allow_spin to
> >>>> false on PREEMPT_RT for handling sheaves movement from/to barn and
> >>>> alloc_empty_sheaf(), but call_rcu() would be safe from kfree_rcu() even on
> >>>> RT?
> >>>
> >>> Indeed. Good point, thanks!
> >>>
> >>> Hmm, but I'm not sure that it's worth the complexity given that
> >>> PREEMPT_RT tries very hard to avoid disabling IRQs...
> >>>
> >>>> Or is the irqs_disabled() condition rare enough so we don't care?
> >>>
> >>> Given that most users don't call kfree_rcu() under raw spinlock or
> >>> IRQs-disabled section on PREEMPT_RT, I think it's okay to keep it as is
> >>> (it's not making things worse, at least) and wait for call_rcu_nolock()?
> >>
> >> Sounds good.
> >>
> >>> On a side note, I don't have much idea on what needs to call kfree_rcu()
> >>> under a raw spinlock, other than set_cpus_allowed_force(), which should
> >>> really be using kfree_nolock() instead of kfree_rcu() once we support
> >>> kmalloc() -> kfree_nolock():
> >>
> >> Looks like the case. Well if the fallback path of kfree_nolock() that is
> >> irq_work_queue() is indeed safe here.
> >>
> >>>> 	/*
> >>>> 	 * Because this is called with p->pi_lock held, it is not possible
> >>>> 	 * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
> >>>> 	 * kfree_rcu().
> >>>> 	 */
> >>>> 	kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
> >>>
> >>> Any thoughts, RCU/RT folks? 
> 
> Thanks for looking into it, Paul!
> 
> Perhaps I'm missing some context here... let me clarify.
> 
> > For the call_rcu*() counterparts, I am currently considering making the
> > existing functions check for interrupts disabled, using irq_work_queue()
> > in that case. 
> 
> Ack.
> 
> > I suppose that I could use raise_softirq() in the
> > use_softirq=1 case when in_hardirq(). 
> 
> Ack.
> 
> > Either way, the check should be
> > cheap compared to rest of the processing.
> 
> Agreed.
> 
> > The additional rcu_barrier() work required is of course way down in
> 
> Assuming "The additional rcu_barrier() work required" means
> rcu_barrier() now needs to wait for all CPUs to complete irq_work or
> softirq...

What I would instead have rcu_barrier() do is to: (1) pull in the pending
callbacks awaiting irq-work, (2) wait for an RCU grace period (and thus
for any pending irq-work handlers), (3) invoke the underlying call_rcu()
machinery on these callbacks (just as the irq-work handler would,
and also the rcu_core() function if the raise_softirq() optimization
is implemented), and (4) proceed as it currently does, which is the
for_each_possible_cpu(cpu) just before the retry: label.

As in item #1 above would start just after this block of code:

	init_completion(&rcu_state.barrier_completion);
	atomic_set(&rcu_state.barrier_cpu_count, 2);
	raw_spin_unlock_irqrestore(&rcu_state.barrier_lock, flags);

> > the noise compared to acquiring a global mutex.
> 
> Are you referring to a specific mutex, or just in general?

A specific mutex, namely the one that rcu_barrier() already acquires:

	mutex_lock(&rcu_state.barrier_mutex);

> > In your case, kfree_rcu() can be quite a bit lighter weight, though.
> > So the extra checks might not be lost in the noise.
> 
> Assuming "the extra checks" means checking whether interrupts are
> disabled in call_rcu()*...

Yes, exactly.

> It will probably be fine since we invoke call_rcu() only when sheaves
> become full, not once for each object?

For the purposes only of my verbiage starting with "In your case,
kfree_rcu()", I was thinking in terms of these extra checks potentially
also being in kfree_rcu().

> Perhaps slightly off-topic; at some point, though, I think it'd be
> better to teach SLUB to use RCU polling API for RCU sheaves.
> 
> e.g.) put sheaves into barn->sheaves_pending instead of invoking
> call_rcu(), and the SLUB alloc slowpath checks if there are sheaves
> past grace period before allocating and refilling sheaves.

That makes a great deal of sense to me!

In fact this one of the types of use case that I was thinking of back
when I was implementing the RCU polling API.  ;-)

							Thanx, Paul
