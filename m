Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7201AF0AF;
	Fri, 11 Jul 2025 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254309; cv=none; b=fHfpCamcGKTc2BF9f8khDEqRprX2mgf/J/Nklfz6RAbPFHX+4VbdiJ9MwptKSt1rBHUDWV8QLsYoGvviLGn0sc3NGs8nK/q2ZL8KOd8Y9vfjbkV2E5xXCly31wYSD+RNortuArqUXqVN5P0BkZMZxyjh4GkjCeyBGRLBpXESm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254309; c=relaxed/simple;
	bh=nVLLPVIWbGUSgKsKv9vPKZDnyjXBKWiQbjkOiqpZTIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4/IiW2eSwcn+tYK9AFQdWeg1o+R0ZR6Pym5g/7tL44srIhzSfus/KyUi75SbCsIYqxM4ScaEeUFe5Wi6gdZGqRNWkrRLKjBP4ssnOpbYpUwy6gNjMND/+Uj8neScua7U1NOZiFYpqDHWuJ6Lbdma1xEoGW7HPmSZn99jl1qVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYe9uuOR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYe9uuOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A6BC4CEED;
	Fri, 11 Jul 2025 17:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752254308;
	bh=nVLLPVIWbGUSgKsKv9vPKZDnyjXBKWiQbjkOiqpZTIk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BYe9uuORtR0YWPHBE05GkoLiBsyfbIv/+6NgHG++QzJsBbc2vtC65UeJwCoxI08UN
	 4f44mmpRSqHTHctaxtLdFr+Uh1OAiorMKwLH2NOJdx7+YDxuXwo+tE7+H9655WC88/
	 4Yok+WMf7tomzhzoWIRTzrq7j7xrphRJlVuDJawMP0Vbqhg/PJF/SJ1BC7yYLUKQ3G
	 WDeL8AQSAYb6wEjy+3NWtxM+vxO7cMriNFtQNsDOJVT0eV4dXlwdbV183RP55EI9Cj
	 eciPWmljN00JX2ONdrs+t6rVIn9syqNFl/cC5oWagjr21IDwzbkD+5MMo2u+JGUHcb
	 Z/ZPLpgmzsXBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 133D9CE0C16; Fri, 11 Jul 2025 10:18:28 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:18:28 -0700
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
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH -rcu -next 4/7] rcu: Remove redundant check for irq state
 during unlock
Message-ID: <c25c1084-ef70-409b-b38f-84c69e08e562@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
 <20250708142224.3940851-4-joelagnelf@nvidia.com>
 <9b67bbca-dfdc-470e-9a32-486300efa586@paulmck-laptop>
 <ebfa8f35-8ede-46c3-a865-384d12d11e90@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebfa8f35-8ede-46c3-a865-384d12d11e90@nvidia.com>

On Fri, Jul 11, 2025 at 12:30:08PM -0400, Joel Fernandes wrote:
> 
> 
> On 7/10/2025 8:00 PM, Paul E. McKenney wrote:
> > On Tue, Jul 08, 2025 at 10:22:21AM -0400, Joel Fernandes wrote:
> >> The check for irqs_were_disabled is redundant in
> >> rcu_unlock_needs_exp_handling() as the caller already checks for this.
> >> This includes the boost case as well. Just remove the redundant check.
> > 
> > But in the very last "if" statement in the context of the last hunk of
> > this patch, isn't it instead checking for !irqs_were_disabled?
> > 
> > Or is there something that I am missing that makes this work out OK?
> 
> You are right, after going over all the cases I introduced a behavioral change.
> 
> Say, irqs_were_disabled was false. And say we are RCU-boosted. needs_exp might
> return true now, but previously it was returning false. Further say, we are not
> in hardirq.
> 
> New code will raise softirq, old code would go to the ELSE and just set:
>                 set_tsk_need_resched(current);
> set_preempt_need_resched();
> 
> But preempt_bh_were_disabled that's why we're here.
> 
> So we need to only set resched and not raise softirq, because the preempt enable
> would reschedule.
> 
> Sorry I missed this, but unless this behavior is correct or needs further work,
> lets drop this patch. Thanks and kudos on the catch!

Not a problem!

You can use cbmc to check these sorts of transformations, as described
here: https://paulmck.livejournal.com/38997.html

							Thanx, Paul

>  - Joel
> 
> > 
> > 							Thanx, Paul
> > 
> >> This is a first win for the refactor of the needs_exp (formerly
> >> expboost) condition into a new rcu_unlock_needs_exp_handling() function,
> >> as the conditions became more easier to read.
> >>
> >> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >> ---
> >>  kernel/rcu/tree_plugin.h | 16 +++++++---------
> >>  1 file changed, 7 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> >> index e20c17163c13..7d03d81e45f6 100644
> >> --- a/kernel/rcu/tree_plugin.h
> >> +++ b/kernel/rcu/tree_plugin.h
> >> @@ -659,14 +659,12 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
> >>   * @t: The task being checked
> >>   * @rdp: The per-CPU RCU data
> >>   * @rnp: The RCU node for this CPU
> >> - * @irqs_were_disabled: Whether interrupts were disabled before rcu_read_unlock()
> >>   *
> >>   * Returns true if expedited processing of the rcu_read_unlock() is needed.
> >>   */
> >>  static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
> >>  				      struct rcu_data *rdp,
> >> -				      struct rcu_node *rnp,
> >> -				      bool irqs_were_disabled)
> >> +				      struct rcu_node *rnp)
> >>  {
> >>  	/*
> >>  	 * Check if this task is blocking an expedited grace period. If the
> >> @@ -702,14 +700,14 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
> >>  
> >>  	/*
> >>  	 * RCU priority boosting case: If a task is subject to RCU priority
> >> -	 * boosting and exits an RCU read-side critical section with interrupts
> >> -	 * disabled, we need expedited handling to ensure timely deboosting.
> >> -	 * Without this, a low-priority task could incorrectly run at high
> >> -	 * real-time priority for an extended period degrading real-time
> >> +	 * boosting and exits an RCU read-side critical section, we need
> >> +	 * expedited handling to ensure timely deboosting. Without this,
> >> +	 * a low-priority task could incorrectly run at high real-time
> >> +	 * priority for an extended period degrading real-time
> >>  	 * responsiveness. This applies to all CONFIG_RCU_BOOST=y kernels,
> >>  	 * not just to PREEMPT_RT.
> >>  	 */
> >> -	if (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled && t->rcu_blocked_node)
> >> +	if (IS_ENABLED(CONFIG_RCU_BOOST) && t->rcu_blocked_node)
> >>  		return true;
> >>  
> >>  	return false;
> >> @@ -738,7 +736,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >>  		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >>  		struct rcu_node *rnp = rdp->mynode;
> >>  
> >> -		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp, irqs_were_disabled);
> >> +		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp);
> >>  	
> >>  		// Need to defer quiescent state until everything is enabled.
> >>  		if (use_softirq && (in_hardirq() || (needs_exp && !irqs_were_disabled))) {
> >> -- 
> >> 2.34.1
> >>
> 
