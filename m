Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B9245AFC;
	Fri, 14 Feb 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524249; cv=none; b=rRttSgldQrgEwR6NFlYSPy/6NLYn67ohmeBniFfB1T3fw4RRK4Vl87bo23o9oWHUB8ik67LDhebNUnsURYw6/5NWdJ9Pi8krhw9bh64uTsviozJSpY7gAOwfcyLO7HOHW+zvp+KkVn4NXLiXLJlBeoxoyd2DawVKBzyalqe4/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524249; c=relaxed/simple;
	bh=i2DkwNe+hd5bSVB4MM+FQdVbcjl7cWhkxdqwDUKiAcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgJQEks3pmrhbEc5f+kvHvvWmC3vf/T6uoYH6qE8Fo/IecTLVcTuEqNK67LjphAMtmq8vMJfd+0GVa1Z8KMJ2YLLc6iYxDwtuN18jByb0tAS3gpqLFgS6D0R28D6QcUSC5MfjcmGtjUOLncSrIAQsGPtNvnmNJNGUixb6AlGogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjial0J4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjial0J4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EF6C4CED1;
	Fri, 14 Feb 2025 09:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739524248;
	bh=i2DkwNe+hd5bSVB4MM+FQdVbcjl7cWhkxdqwDUKiAcM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bjial0J4w0bzmX9kyvBVYwgAzQO658jxw9OEGaz3IO6lXixoPP2mlcu/HJxoEWvgG
	 fMdXe1tADgNlAa76xF372GgzuPMB1VXYImvECKK5Xz12tU/pKbma5ECvWTAO02V5N7
	 aYcu0BdyE6FHLEyw1QGXIlP4c9SXQqFHpNQfhUxttld4lYFrIdalnK7ybKiB+iaFkp
	 gDC39BNvWq6bYd5hRugnmhEbHWbd+qWffHxMY7VFsgiha9K+ISJ3vJVNlDgfH+STco
	 ClxPRu4QcTwA+63nksto3YbAX9cblHrK8mMHYS3PqAXueuAtTpIGnBNszOqkkDlkkF
	 CcyhfPIP4vePQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EC12CCE0426; Fri, 14 Feb 2025 01:10:43 -0800 (PST)
Date: Fri, 14 Feb 2025 01:10:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/3] rcu/exp: Protect against early QS report
Message-ID: <abaf4f7f-42b3-43ff-888c-369501b0b4c6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213232559.34163-2-frederic@kernel.org>

On Fri, Feb 14, 2025 at 12:25:57AM +0100, Frederic Weisbecker wrote:
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
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Thank you for looking into this!

One question:  What happens if a CPU has tasks pending during the
call to sync_exp_reset_tree(), but all of these tasks complete
their RCU read-side critical sections before execution reaches
__sync_rcu_exp_select_node_cpus()?

(My guess is that all is well, but even if so, it would be good to record
why in the commit log.)

						Thanx, Paul

> ---
>  kernel/rcu/tree_exp.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 8d4895c854c5..caff16e441d1 100644
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
> 2.46.0
> 
