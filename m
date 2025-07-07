Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D017D7;
	Mon,  7 Jul 2025 04:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751862037; cv=none; b=O8P7yzm09N1eE3I2VrpeaUslSOQ0b21yIdjgwGUAGTHRF0nJajMjby0vLmd0cmUhYHbQhSmjXXO2lfAWM+0w2e3HCdJK36GQTbgoaSWiZUKvc6TInalD72PNDgC/lj0xIQMkNiBhDkBS2Qpa7JQrT/FX6VbvXu+J3jP6yLv74nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751862037; c=relaxed/simple;
	bh=WAGbWQXseZT84lWgcOZHGC1WmG1f/1lTy/9CY08SFbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw6XwNkucmK1x4JD3jIcG6eDXo3hU/HeSkA0tIg9+r1bVDKE65HDRX+djvK6dt4s9Cl3iWKx08vT+x0SGUHuN/9gy1tT5QbEiHJhiqZLOhcp/fa+bDmwBbS9cZRgrRR3+B6JfFc9ePYTKH7s5RNWrZr/EM/rRmalpSUqlMifnL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnHKcsGl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnHKcsGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860C7C4CEEE;
	Mon,  7 Jul 2025 04:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751862036;
	bh=WAGbWQXseZT84lWgcOZHGC1WmG1f/1lTy/9CY08SFbw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XnHKcsGle4hT5gNJ422fqy4VfduY/21Ke7mOAGUWIJ64qARGqluQbP7Sa3nqpotvs
	 ivKWmYSi/Z9LHnGQ8Rlx19Y9QJnIkMZEAX1p9QY8jHh9nMkBN1GGEmgLcT4x3OZa3l
	 HIbs4NOA8y3Vc61TNybF4mK7WesFUwGvrG9EYZiqSiKNy3rXqwEbK2KFX6vVwJwXwC
	 NwA2KVP6zRvD3gIKSLK8GKB/x1Dip9oacO35lVN+ozCGRoZGA0vvv/neH2fIiHJkj4
	 /n/q+vfJLiwZ5H0obVZz246r7jmQz7XL2q1tgUq/eaPT5q0zTpxg6F3gZgKNfd1xjg
	 PkiqgXpT0qMbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 24BFBCE0B76; Sun,  6 Jul 2025 21:20:31 -0700 (PDT)
Date: Sun, 6 Jul 2025 21:20:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 2/3] rcu: Refactor expedited handling check in
 rcu_read_unlock_special()
Message-ID: <15ecbf34-b835-4c76-9ea6-23bf72709bc5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
 <20250705203918.4149863-2-joelagnelf@nvidia.com>
 <941d82f3-1c09-4db2-ae22-a80d04227673@paulmck-laptop>
 <52679e35-c6a4-4e0c-876a-a80a1a9b2bd8@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52679e35-c6a4-4e0c-876a-a80a1a9b2bd8@nvidia.com>

On Sun, Jul 06, 2025 at 03:16:54PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On 7/6/2025 1:18 PM, Paul E. McKenney wrote:
> > On Sat, Jul 05, 2025 at 04:39:16PM -0400, Joel Fernandes wrote:
> >> Extract the complex expedited handling condition in rcu_read_unlock_special()
> >> into a separate function rcu_unlock_needs_exp_handling() with detailed
> >> comments explaining each condition.
> >>
> >> This improves code readability. No functional change intended.
> > 
> > Very nice!!!
> 
> Thanks!
> 
> > 
> > Some questions and comments interspersed below.
> 
> I replied inline below:
> 
> > 
> > 							Thanx, Paul
> > 
> >> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >> ---
> >>  kernel/rcu/tree_plugin.h | 80 +++++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 71 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> >> index baf57745b42f..8504d95bb35b 100644
> >> --- a/kernel/rcu/tree_plugin.h
> >> +++ b/kernel/rcu/tree_plugin.h
> >> @@ -647,6 +647,72 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
> >>  	local_irq_restore(flags);
> >>  }
> >>  
> >> +/*
> >> + * Check if expedited grace period processing during unlock is needed.
> >> + *
> >> + * This function determines whether expedited handling is required based on:
> >> + * 1. Task blocking an expedited grace period
> > 
> > This is a heuristic.  What we are actually checking is whether the task
> > is blocking *some* grace period and whether at least one task (maybe
> > this one, maybe not) is blocking an expedited grace period.
> 
> Makes sense, I changed this to:
> 
>  * 1. Task blocking an expedited grace period (based on a heuristic, could be
>  *    false-positive, see below.)
> 
> And the below comment to:
> 
>         /*
>          * Check if this task is blocking an expedited grace period. If the
>          * task was preempted within an RCU read-side critical section and is
>          * on the expedited grace period blockers list (exp_tasks), we need
>          * expedited handling to unblock the expedited GP. This is not an exact
>          * check because 't' might not be on the exp_tasks list at all - its
>          * just a fast heuristic that can be false-positive sometimes.
>          */
>         if (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks))
>                 return true;
> 
> Hope that looks Ok.

Looks good, thank you!

							Thanx, Paul

> > Why not an exact check?  Because that would mean traversing the list
> > starting at ->exp_tasks, and that list could potentially contain every
> > task in the system.  And I have received bug reports encountered on
> > systems with hundreds of thousands of tasks.
> 
> Got it.
> 
> > 
> > I could imagine a more complex data structure that semi-efficiently
> > tracked exact information, but I could also imagine this not being worth
> > the effort.
> > 
> >> + * 2. CPU participating in an expedited grace period
> >> + * 3. Strict grace period mode requiring expedited handling
> >> + * 4. RCU priority boosting needs when interrupts were disabled
> > 
> > s/boosting/deboosting/
> > 
> 
> Fixed, thanks.
> 
> > 
> >> +	 */
> >> +	if (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks))
> >> +		return true;
> >> +
> >> +	/*
> >> +	 * Check if this CPU is participating in an expedited grace period.
> >> +	 * The expmask bitmap tracks which CPUs need to check in for the
> >> +	 * current expedited GP. If our CPU's bit is set, we need expedited
> >> +	 * handling to help complete the expedited GP.
> >> +	 */
> >> +	if (rdp->grpmask & READ_ONCE(rnp->expmask))
> >> +		return true;
> >> +
> >> +	/*
> >> +	 * In CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, all grace periods
> >> +	 * are treated as short for testing purposes even if that means
> >> +	 * disturbing the system more. Check if either:
> >> +	 * - This CPU has not yet reported a quiescent state, or
> >> +	 * - This task was preempted within an RCU critical section
> >> +	 * In either case, requird expedited handling for strict GP mode.
> > 
> > s/requird/required/  ;-)
> 
> I meant "require" :-D. Will fix.
> 
> > 
> >> +	 */
> >> +	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> >> +	    ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node))
> >> +		return true;
> >> +
> >> +	/*
> >> +	 * RCU priority boosting case: If a task is subject to RCU priority
> >> +	 * boosting and exits an RCU read-side critical section with interrupts
> >> +	 * disabled, we need expedited handling to ensure timely deboosting.
> >> +	 * Without this, a low-priority task could incorrectly run at high
> >> +	 * real-time priority for an extended period effecting real-time
> > 
> > s/effecting/degrading/ to be more precise.
> > 
> 
> Fixed, thanks.
> 
>  - Joel
> 
