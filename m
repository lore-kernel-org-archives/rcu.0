Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67A1A3152;
	Sun, 16 Mar 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123231; cv=none; b=umHulqjQ1oWbmz6UPD3TtN6GttfltnZwI27XNwl4o4Rw2ftSIE/xXBXDYGXk41fh3AGHNdqYVXF7bNkskNSLMXtV0nZwNxUtvCwaL+PPWShl8359K9OktiYEjREr9tM6i5VSPjrDEADYRqGHukuXn+g5GcqxGAxQqKFutoacQao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123231; c=relaxed/simple;
	bh=cGUlrgEhuknEeWgAbBAW1RxANZr/aUFKIeRPUyRg2oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqRVTadBKl+mhUlKXP3BGAZy7CnlbanUOV+Z+hef0+Grlq7ge88bwDtXgXSTyDYvgNxW5lrR2b9wDGIDHaqk3JzYiDUzfJtD2ZWN+R2fOT7hxsg9A3kOd1k6VWBtGUVAZLVPpJnAB7pIPai6lTSOeI/lr1LJgpxJRyVhNm/cJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQF3T4Rw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQF3T4Rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27249C4CEDD;
	Sun, 16 Mar 2025 11:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742123230;
	bh=cGUlrgEhuknEeWgAbBAW1RxANZr/aUFKIeRPUyRg2oA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQF3T4RwA+4+Emq+2hXPVJeVwO0R2zkWWUSJ4fAz1hhjCU3FhvhhK6PQtoLkaz81T
	 urN0iPZ/MU8Ad+ixkIv1EQe4eWJ9pda8a73uXvhomp7gjnsC9mACgPbhDoCZ8aeCXf
	 YzuqMfLGCRHk6qzYeXgCmajvzVP2stMULnR9yfSSbV75sX8QteFzOF0FiCNafsbdHg
	 AXzHap4iA3aqiSQRUm22KJDh2jFp4ZXzyzbqD/YZqBlm8tiP82LN2PisfhEnS1bzHA
	 xubg5cruXtODVujgsF0UEC/Xy46JCHpKqTi67NjmDZ03LpVTcAlXTgM9KAgBDv9is0
	 TkJ2H1+LG+X6g==
Date: Sun, 16 Mar 2025 12:07:07 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/5] rcu/exp: Protect against early QS report
Message-ID: <Z9aw252VPvW9K4Wl@pavilion.home>
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-2-frederic@kernel.org>
 <20250315235945.GA2634509@joelnvbox>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250315235945.GA2634509@joelnvbox>

Le Sat, Mar 15, 2025 at 07:59:45PM -0400, Joel Fernandes a écrit :
> Hi Frederic,
> 
> On Fri, Mar 14, 2025 at 03:36:38PM +0100, Frederic Weisbecker wrote:
> > When a grace period is started, the ->expmask of each node is set up
> > from sync_exp_reset_tree(). Then later on each leaf node also initialize
> > its ->exp_tasks pointer.
> > 
> > This means that the initialization of the quiescent state of a node and
> > the initialization of its blocking tasks happen with an unlocked node
> > gap in-between.
> > 
> > It happens to be fine because nothing is expected to report an exp
> > quiescent state within this gap, since no IPI have been issued yet and
> > every rdp's ->cpu_no_qs.b.exp should be false.
> > 
> > However if it were to happen by accident, the quiescent state could be
> > reported and propagated while ignoring tasks that blocked _before_ the
> > start of the grace period.
> > 
> > Prevent such trouble to happen in the future and initialize both the
> > quiescent states mask to report and the blocked tasks head from the same
> > node locked block.
> > 
> > If a task blocks within an RCU read side critical section before
> > sync_exp_reset_tree() is called and is then unblocked between
> > sync_exp_reset_tree() and __sync_rcu_exp_select_node_cpus(), the QS
> > won't be reported because no RCU exp IPI had been issued to request it
> > through the setting of srdp->cpu_no_qs.b.exp.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/tree_exp.h | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index c36c7d5575ca..2fa7aa9155bd 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -141,6 +141,13 @@ static void __maybe_unused sync_exp_reset_tree(void)
> >  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> >  		WARN_ON_ONCE(rnp->expmask);
> >  		WRITE_ONCE(rnp->expmask, rnp->expmaskinit);
> > +		/*
> > +		 * Need to wait for any blocked tasks as well.	Note that
> > +		 * additional blocking tasks will also block the expedited GP
> > +		 * until such time as the ->expmask bits are cleared.
> > +		 */
> > +		if (rcu_is_leaf_node(rnp) && rcu_preempt_has_tasks(rnp))
> > +			WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
> >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  	}
> >  }
> > @@ -393,13 +400,6 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
> >  	}
> >  	mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
> >  
> > -	/*
> > -	 * Need to wait for any blocked tasks as well.	Note that
> > -	 * additional blocking tasks will also block the expedited GP
> > -	 * until such time as the ->expmask bits are cleared.
> > -	 */
> > -	if (rcu_preempt_has_tasks(rnp))
> > -		WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
> >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> 
> A small side effect of this patch could be:
> 
> In the existing code, if between the sync_exp_reset_tree() and the
> __sync_rcu_exp_select_node_cpus(), if a pre-existing reader unblocked and
> completed, then I think it wouldn't be responsible for blocking the GP
> anymore.

Hmm, I don't see how that changes after this patch.

> 
> Where as with this patch, it would not get a chance to be removed from the
> blocked list because it would have to wait on the rnp lock, which after this
> patch would now be held across the setting of exp_mask and exp_tasks?

So that's sync_exp_reset_tree(). I'm a bit confused. An unblocking task
contend on rnp lock in any case. But after this patch it is still going
to remove itself from the blocking task once the rnp lock is released by
sync_exp_reset_tree().

What am I missing?

Thanks.

> 
> But I think it is not a big deal either way, and if you feel it is more
> future proof to do it this way, that sounds good to me.
> 
> thanks,
> 
>  - Joel
> 
> 
> >  
> >  	/* IPI the remaining CPUs for expedited quiescent state. */
> > -- 
> > 2.48.1
> > 
> 
