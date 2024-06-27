Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137581BF40;
	Thu, 27 Jun 2024 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514411; cv=none; b=eGTlNZl14wM7GLs8DoJXlEQfUoc1h+zyk09gzCFrxBoCCO9SbQedGF/bjfI90iJjB2NnPwNPDBnCP6GSiijhgzBZWozmpGw6pGqYFPbC0nswCVxYX3nt0bgnYXabsetNccobH31PEWjJF6x2gk2oZuz4pDqsDnOU4qFEd91PcJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514411; c=relaxed/simple;
	bh=1KVw3L84epfGHUAL0h2wWcELjpi6bck2ru57OtDq+o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLYLCsGiRX8T6ZSgPaM0j1JDKiO1d5dCYRqFQtM1mSNCUKfNfhGlMPvH1Gn89Za6kTRl87EuMwGj0W3VZ3FmHg68408kaxIWd8cRUF/QQq9EJz1oMp4hmnDVBGYYyb9fTplHywTt4mPFPIo6RY4gx4FJ2ZhubYndAogJy/cok9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2dv/69r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2dv/69r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C63C2BBFC;
	Thu, 27 Jun 2024 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719514410;
	bh=1KVw3L84epfGHUAL0h2wWcELjpi6bck2ru57OtDq+o0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=h2dv/69rB3axRUtIhJMznRNXM4daAFP/39wggC8012p1pKPHWiACr5TxRwJZ8obUT
	 PUYcKFWJDteAamf1Xe9PVnB/Gla+V9nIexu9yBh2xwXCR71xp5W2VcSvz6mOwFQxlq
	 HHYALLcPdhY0NL9ziXrZo7hvVkelktK/YYScrGsTOAB1rr12/sypUYa6rKCOFx7Quw
	 5DLp45JH0wuCnma78GFlxmSp3SN9qH26q18ZegFEkeyH83oBSXhDjS6QcCrapK+WYB
	 BUO2LwEjab7Tyau6cctu/AdBMo0821uxRKa5BhFTQsahW5VxVnorljcawFIrqm67+A
	 G6GJYIfjlcoAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3E1EFCE0A70; Thu, 27 Jun 2024 11:53:29 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:53:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 3/6 v2] rcu/exp: Remove superfluous full memory
 barrier upon first EQS snapshot
Message-ID: <4a11271a-d873-4f1c-87e6-38874e38ac13@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-3-paulmck@kernel.org>
 <Zn1O2qKaIVOXniYH@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn1O2qKaIVOXniYH@pavilion.home>

On Thu, Jun 27, 2024 at 01:36:58PM +0200, Frederic Weisbecker wrote:
> When the grace period kthread checks the extended quiescent state
> counter of a CPU, full ordering is necessary to ensure that either:

Just to make sure that I understand...

I need to replace these commits in -rcu:

da979d0162fc6 rcu: Remove full ordering on second EQS snapshot
6411f4185f657 rcu: Remove superfluous full memory barrier upon first EQS snapshot
dec56ca5f1c34 rcu/exp: Remove superfluous full memory barrier upon first EQS snapshot

With these three patches, and keep these three commits as they are?

d43a302fc08a5 rcu: Remove full memory barrier on boot time eqs sanity check
b1c36aa90cbf1 rcu: Remove full memory barrier on RCU stall printout
64d68f1d53f77 rcu/exp: Remove redundant full memory barrier at the end of GP

							Thanx, Paul

> * If the GP kthread observes the remote target in an extended quiescent
>   state, then that target must observe all accesses prior to the current
>   grace period, including the current grace period sequence number, once
>   it exits that extended quiescent state.
> 
> or:
> 
> * If the GP kthread observes the remote target NOT in an extended
>   quiescent state, then the target further entering in an extended
>   quiescent state must observe all accesses prior to the current
>   grace period, including the current grace period sequence number, once
>   it enters that extended quiescent state.
> 
> This ordering is enforced through a full memory barrier placed right
> before taking the first EQS snapshot. However this is superfluous
> because the snapshot is taken while holding the target's rnp lock which
> provides the necessary ordering through its chain of
> smp_mb__after_unlock_lock().
> 
> Remove the needless explicit barrier before the snapshot and put a
> comment about the implicit barrier newly relied upon here.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> ---
>  kernel/rcu/tree_exp.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 8a1d9c8bd9f7..1dbad2442e8d 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -357,7 +357,21 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
>  		    !(rnp->qsmaskinitnext & mask)) {
>  			mask_ofl_test |= mask;
>  		} else {
> -			snap = rcu_dynticks_snap(cpu);
> +			/*
> +			 * Full ordering between remote CPU's post idle accesses
> +			 * and updater's accesses prior to current GP (and also
> +			 * the started GP sequence number) is enforced by
> +			 * rcu_seq_start() implicit barrier, relayed by kworkers
> +			 * locking and even further by smp_mb__after_unlock_lock()
> +			 * barriers chained all the way throughout the rnp locking
> +			 * tree since sync_exp_reset_tree() and up to the current
> +			 * leaf rnp locking.
> +			 *
> +			 * Ordering between remote CPU's pre idle accesses and
> +			 * post grace period updater's accesses is enforced by the
> +			 * below acquire semantic.
> +			 */
> +			snap = ct_dynticks_cpu_acquire(cpu);
>  			if (rcu_dynticks_in_eqs(snap))
>  				mask_ofl_test |= mask;
>  			else
> -- 
> 2.45.2
> 
