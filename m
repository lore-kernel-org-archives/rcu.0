Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5518B1552FA;
	Thu, 13 Mar 2025 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885455; cv=none; b=nieXfkW0ha8IcuMiSJxquM41af6KYQ5fbPyvFBck8Z7eUaSWKcadZquApks3AXypwdBC820r2ui+YdZ5Qx8Mgb006xeaQ7uqsrHBC86cd0H1DU3KZ9iz776pWNAE9Hu0ioFP6i4TUY2hM/+dPEAJwUGBAz8cuEaFFrqBpTCVnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885455; c=relaxed/simple;
	bh=qtD8vFHHfdUiS9vJpnr6VWqneWRHBfkV1J7s8qR2xCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieGiKl67A1y7ncAlEubNgWUIva38zCdamsu4XCCD2OSanEO8t7VekBwyrR8cMUt+y4vLxFIA7iB64bCwxqDOGFuag6u7vCwstw8PU3l6nGah+nsZhM5XIDbTzc3TFwKdHg7NUYZaHhtG8NYsRt5pzqUYnqv3OCxoe1dYuJ50Dr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbhFwBK9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbhFwBK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98B8C4CEDD;
	Thu, 13 Mar 2025 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741885454;
	bh=qtD8vFHHfdUiS9vJpnr6VWqneWRHBfkV1J7s8qR2xCc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bbhFwBK9NayqDl/ZD1+GbJTOwpzBsV+zZV6kJbvHI8C2V8HVPYG7mxPmoNKrjo5cc
	 nyaIJmQyBAbID5WwKQc2jPjzh0nRke1sVftoyEz37k8gP1rm7+UqpM3VSTLDygdnFn
	 EduDnyMGGgGyto47cWCOydDrImPcKAUbv8yc2nEqP/nQSUHhPcVvdWn+u1R8kfBWtp
	 7nUSx24Isf6ZvlyVpmWm5LpjSg2SqjzVm2NN924hjXIujYhe2XBJ5+GLTZvktXiioZ
	 30cMIehYPK+FYIgGlVPtBKa2kXl88G0MZxnVSbzvwBlQmCRmB9KoaiVx21l6NkeM9S
	 O2P7v/56iHQ1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4CEC6CE0544; Thu, 13 Mar 2025 10:04:14 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:04:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/3] rcu/exp: Protect against early QS report
Message-ID: <920faa5f-f454-45f0-b82c-216ff2ad9dbe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-2-frederic@kernel.org>
 <abaf4f7f-42b3-43ff-888c-369501b0b4c6@paulmck-laptop>
 <Z9MKc7hlZFgLr_jM@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9MKc7hlZFgLr_jM@localhost.localdomain>

On Thu, Mar 13, 2025 at 05:40:19PM +0100, Frederic Weisbecker wrote:
> Le Fri, Feb 14, 2025 at 01:10:43AM -0800, Paul E. McKenney a écrit :
> > On Fri, Feb 14, 2025 at 12:25:57AM +0100, Frederic Weisbecker wrote:
> > > When a grace period is started, the ->expmask of each node is set up
> > > from sync_exp_reset_tree(). Then later on each leaf node also initialize
> > > its ->exp_tasks pointer.
> > > 
> > > This means that the initialization of the quiescent state of a node and
> > > the initialization of its blocking tasks happen with an unlocked node
> > > gap in-between.
> > > 
> > > It happens to be fine because nothing is expected to report an exp
> > > quiescent state within this gap, since no IPI have been issued yet and
> > > every rdp's ->cpu_no_qs.b.exp should be false.
> > > 
> > > However if it were to happen by accident, the quiescent state could be
> > > reported and propagated while ignoring tasks that blocked _before_ the
> > > start of the grace period.
> > > 
> > > Prevent such trouble to happen in the future and initialize both the
> > > quiescent states mask to report and the blocked tasks head from the same
> > > node locked block.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Thank you for looking into this!
> > 
> > One question:  What happens if a CPU has tasks pending during the
> > call to sync_exp_reset_tree(), but all of these tasks complete
> > their RCU read-side critical sections before execution reaches
> > __sync_rcu_exp_select_node_cpus()?
> > 
> > (My guess is that all is well, but even if so, it would be good to record
> > why in the commit log.)
> 
> All is (expected to be) well because the QS won't be reported yet:
> rdp->cpu_no_qs.b.exp is still false, therefore rnp->expmask will
> still have the RDPs masks set.
> 
> !PREEMPT_RCU is different because sync_sched_exp_online_cleanup()
> can report the QS earlier. But that patch is a PREEMPT_RCU concern
> only.
> 
> I'll drop a note on the changelog.

Thank you!

							Thanx, Paul

> Thanks.
> 
> 
> > 
> > 						Thanx, Paul
> > 
> > > ---
> > >  kernel/rcu/tree_exp.h | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > index 8d4895c854c5..caff16e441d1 100644
> > > --- a/kernel/rcu/tree_exp.h
> > > +++ b/kernel/rcu/tree_exp.h
> > > @@ -141,6 +141,13 @@ static void __maybe_unused sync_exp_reset_tree(void)
> > >  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > >  		WARN_ON_ONCE(rnp->expmask);
> > >  		WRITE_ONCE(rnp->expmask, rnp->expmaskinit);
> > > +		/*
> > > +		 * Need to wait for any blocked tasks as well.	Note that
> > > +		 * additional blocking tasks will also block the expedited GP
> > > +		 * until such time as the ->expmask bits are cleared.
> > > +		 */
> > > +		if (rcu_is_leaf_node(rnp) && rcu_preempt_has_tasks(rnp))
> > > +			WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
> > >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >  	}
> > >  }
> > > @@ -393,13 +400,6 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
> > >  	}
> > >  	mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
> > >  
> > > -	/*
> > > -	 * Need to wait for any blocked tasks as well.	Note that
> > > -	 * additional blocking tasks will also block the expedited GP
> > > -	 * until such time as the ->expmask bits are cleared.
> > > -	 */
> > > -	if (rcu_preempt_has_tasks(rnp))
> > > -		WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
> > >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >  
> > >  	/* IPI the remaining CPUs for expedited quiescent state. */
> > > -- 
> > > 2.46.0
> > > 
