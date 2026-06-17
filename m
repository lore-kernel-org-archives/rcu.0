Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74D237B00F;
	Wed, 17 Jun 2026 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728837; cv=none; b=TW8BBnKZkgeuHe4Gp4G+w+jbm0pruR91xDAVOPFqaZonZ0I0UN17oCRnwdiqFjvXB+3L2qP6UlyM8p84tduRXBZ1LSYlIB8LoVw2m728kHlvmaaAEsckcBf00700u1vl4YGx0KOPuecOgO4q4tKPPItKStLQEpmh+dLG3j6PlRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728837; c=relaxed/simple;
	bh=5XhIsKQCjWFjO3PQebkYOOJNGb2YyRKBd9WuB3miT9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX3NM1YSlrMWTNbzVG0COZPTNWYe95ki5F57Vw62PtmZdENhKkMvJNeFH+F5nFcc0ueHOPb1vhsAHEKFrh6MUCNzLxydhx8h2qxU100LPHFd+QTSR73AGyaSmIfb8Q+OnpoNVg473mau7B/NDMKYvomdX4uFfTiUWEmWruIhOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gylbkn5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gylbkn5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DF81F000E9;
	Wed, 17 Jun 2026 20:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781728836;
	bh=VvEnwrbAPa/pJg7QIpc03r+TzOKPlfQjHrFj1uoaMwc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=gylbkn5PU4X+qaVT2pQyl74j/WSjRQWrKsuURN7hn4ompKgYAjbhUzMRoBi+GSCUO
	 cLIDzdgF692xY3/wUsGWcMxF2jPcw7Zg6qPxMDMEUYJgMjEh5ZDQt+uEg+lC2hlvsa
	 0elmDj41ytZWORBXtwvwLGcZWnfpS1xHQ/hCQQNsoYdu8MdSJj1OUoi7zWh925Z+1/
	 ydwZ7ia3625Hjxq0keojNKHc/pMJHyNlL3Bp2/jJjx6LLaQ9HUGfHl+gdIW5qFBEdw
	 Z/oJtM6GAU0Dko3RbCVsKcX+gako9fxvDVuxF4mqMLGKEFq7vQHwv7WEmTs8GHBY5d
	 Lyczkdkin9Y7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E9DC2CE1113; Wed, 17 Jun 2026 13:40:35 -0700 (PDT)
Date: Wed, 17 Jun 2026 13:40:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <03da8742-3790-4428-84b8-11911bf44c9e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-6-70a54f3775bb@kernel.org>
 <f3a56a5a-f10b-46dc-bc99-28449ade1661@kernel.org>
 <40591888-3a87-433e-b3d2-cda1cab543be@kernel.org>
 <9d8ca1ed-bc53-417f-944b-d78eecd1e6a5@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d8ca1ed-bc53-417f-944b-d78eecd1e6a5@kernel.org>

On Wed, Jun 17, 2026 at 07:38:16AM +0200, Vlastimil Babka (SUSE) wrote:
> On 6/17/26 07:14, Harry Yoo wrote:
> > 
> > 
> > On 6/17/26 2:24 AM, Vlastimil Babka (SUSE) wrote:
> >> On 6/15/26 13:06, Harry Yoo (Oracle) wrote:
> >>> As suggested by Vlastimil Babka, kfree_rcu_sheaf() can be used
> >>> on PREEMPT_RT if we always assume spinning is not allowed on PREEMPT_RT.
> >>> This is because local_trylock and spinlock_t are safe to use with
> >>> trylock variant as long as the kernel does not spin and the context is
> >>> not NMI and not hardirq.
> >>>
> >>> Now that __kfree_rcu_sheaf() knows how to handle allow_spin = false,
> >>> relax the limitation and try the sheaves path on PREEMPT_RT as well.
> >>>
> >>> Keep the lockdep map on non RT kernels. However, do not use the lockdep
> >>> map on PREEMPT_RT to avoid suppressing valid lockdep warnings.
> >>>
> >>> Link: https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f98162@kernel.org
> >>> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> >>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> >> 
> >> LGTM, but maybe unnecessary pessimistic wrt call_rcu() on PREEMPT_RT?
> >> I thought (in the Link: above) we'd only need to downgrade allow_spin to
> >> false on PREEMPT_RT for handling sheaves movement from/to barn and
> >> alloc_empty_sheaf(), but call_rcu() would be safe from kfree_rcu() even on
> >> RT?
> > 
> > Indeed. Good point, thanks!
> > 
> > Hmm, but I'm not sure that it's worth the complexity given that
> > PREEMPT_RT tries very hard to avoid disabling IRQs...
> > 
> >> Or is the irqs_disabled() condition rare enough so we don't care?
> > 
> > Given that most users don't call kfree_rcu() under raw spinlock or
> > IRQs-disabled section on PREEMPT_RT, I think it's okay to keep it as is
> > (it's not making things worse, at least) and wait for call_rcu_nolock()?
> 
> Sounds good.
> 
> > On a side note, I don't have much idea on what needs to call kfree_rcu()
> > under a raw spinlock, other than set_cpus_allowed_force(), which should
> > really be using kfree_nolock() instead of kfree_rcu() once we support
> > kmalloc() -> kfree_nolock():
> 
> Looks like the case. Well if the fallback path of kfree_nolock() that is
> irq_work_queue() is indeed safe here.
> 
> >> 	/*
> >> 	 * Because this is called with p->pi_lock held, it is not possible
> >> 	 * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
> >> 	 * kfree_rcu().
> >> 	 */
> >> 	kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
> > 
> > Any thoughts, RCU/RT folks?

For the call_rcu*() counterparts, I am currently considering making the
existing functions check for interrupts disabled, using irq_work_queue()
in that case.  I suppose that I could use raise_softirq() in the
use_softirq=1 case when in_hardirq().  Either way, the check should be
cheap compared to rest of the processing.  The additional rcu_barrier()
work required is of course way down in the noise compared to acquiring
a global mutex.

In your case, kfree_rcu() can be quite a bit lighter weight, though.
So the extra checks might not be lost in the noise.

Thoughts?

								Thanx, Paul
