Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5346619F489;
	Tue, 18 Mar 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318237; cv=none; b=EIqYI5P2I2yEe7YpH8z5acM7z1NDamUbv7Npj/zyYlxsRm2293uveuLn4IvyzIXzwmWbsHzao9IkIGGJKyXbXK+0v8u90lrmYkWRYyD771tYu929GPnwP1NVia44l52ra+g7LxoPQdgYIJK33ofkf+qL1ZHPcj12ipqfmHYfD8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318237; c=relaxed/simple;
	bh=MvFWPBpBcvoirqV2ig5cxuhteo2WBHtMkJIUUkx+Ve8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uI+dtY2h1++NpEH2JbVMk/9kwAdrRRXFCdxVXUWkHGd2aAB74lRIf3MwHmEaJ6QmLvXuyMtuJBK6S8HLp6UFX8AOHjbgYttQnGwfS8JZWt2fMUG1gHIRmaHIjDwahKhRbAEG/FJd44reW4CHJFkRTRhGRaN0CoCne3KhiCFQrs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urg9B0WC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urg9B0WC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE9EC4CEDD;
	Tue, 18 Mar 2025 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318236;
	bh=MvFWPBpBcvoirqV2ig5cxuhteo2WBHtMkJIUUkx+Ve8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Urg9B0WCcEKNvvuBTJeneX1U0jG4ezBMKPWF4TCxyunvbq+kEu+OojtIlgq3SVXNU
	 KQOYmkzGxJEV05IG8qE7yeJ9ewq+0MsaMoWgRvBU8JS8zXPIIGKbP4stMAfhE1TzjD
	 OTwi0PakDAlqix57/SgsSo8h3F53ZX6TyTPgBLtCBqqheKqUtjUuyJQ0TSOHgznElt
	 1bU+LGMix3gk2nKhobHMlftRuZsVSNRjxBv9S1J/WV5HeW6hwSt5BvgCpTlbYdC/YU
	 +wyv219BaihK+fqJWQLiPD7vfNZhdLgQ+5n0pji5BwSiiR/sKczoaRgpbkEz2USQbT
	 FQng4LRFugZIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3EC8DCE0843; Tue, 18 Mar 2025 10:17:16 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:17:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/5] rcu/exp: Protect against early QS report
Message-ID: <2f9c13de-1e32-4cfb-8cfa-badb26a15bb6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314143642.72554-2-frederic@kernel.org>

On Fri, Mar 14, 2025 at 03:36:38PM +0100, Frederic Weisbecker wrote:
> When a grace period is started, the ->expmask of each node is set up
> from sync_exp_reset_tree(). Then later on each leaf node also initialize
> its ->exp_tasks pointer.
> 
> This means that the initialization of the quiescent state of a node and
> the initialization of its blocking tasks happen with an unlocked node
> gap in-between.
> 
> It happens to be fine because nothing is expected to report an exp
> quiescent state within this gap, since no IPI have been issued yet and
> every rdp's ->cpu_no_qs.b.exp should be false.
> 
> However if it were to happen by accident, the quiescent state could be
> reported and propagated while ignoring tasks that blocked _before_ the
> start of the grace period.
> 
> Prevent such trouble to happen in the future and initialize both the
> quiescent states mask to report and the blocked tasks head from the same
> node locked block.
> 
> If a task blocks within an RCU read side critical section before
> sync_exp_reset_tree() is called and is then unblocked between
> sync_exp_reset_tree() and __sync_rcu_exp_select_node_cpus(), the QS
> won't be reported because no RCU exp IPI had been issued to request it
> through the setting of srdp->cpu_no_qs.b.exp.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

OK, and because ->expmaskinit has all bits set for all CPUs that have
ever been online, the ends of any corresponding readers will give up at
the beginning of the first pass of the loop in __rcu_report_exp_rnp().
This is because the ->expmask is guaranteed to be non-zero.  (Which is
kind of what you are saying in the last paragraph of your commit log,
just digging down another layer.)

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_exp.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index c36c7d5575ca..2fa7aa9155bd 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -141,6 +141,13 @@ static void __maybe_unused sync_exp_reset_tree(void)
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  		WARN_ON_ONCE(rnp->expmask);
>  		WRITE_ONCE(rnp->expmask, rnp->expmaskinit);
> +		/*
> +		 * Need to wait for any blocked tasks as well.	Note that
> +		 * additional blocking tasks will also block the expedited GP
> +		 * until such time as the ->expmask bits are cleared.
> +		 */
> +		if (rcu_is_leaf_node(rnp) && rcu_preempt_has_tasks(rnp))
> +			WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	}
>  }
> @@ -393,13 +400,6 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
>  	}
>  	mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
>  
> -	/*
> -	 * Need to wait for any blocked tasks as well.	Note that
> -	 * additional blocking tasks will also block the expedited GP
> -	 * until such time as the ->expmask bits are cleared.
> -	 */
> -	if (rcu_preempt_has_tasks(rnp))
> -		WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  
>  	/* IPI the remaining CPUs for expedited quiescent state. */
> -- 
> 2.48.1
> 
