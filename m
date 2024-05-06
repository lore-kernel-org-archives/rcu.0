Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977F84DFF;
	Mon,  6 May 2024 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715033906; cv=none; b=CqGYVpHM5rn30u2K9IxYOFlNCMpdflC/WvbgzLPuCYWXGBmmXsSkCoWwdpqEDqB/PkbZ+DX0G45PI+Q7c21++AtC+syV+1id7TzXOqM1vVPCTq3U7ZBP3KXvJScKetsCxGQtfLInpkcB9Ys4KxxaG+h7SgkmLbv+DJFRVaaqH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715033906; c=relaxed/simple;
	bh=1X0wUuW9Rp2t/ahmzXCvAfNAoLvjif0qwEKzPQG+nWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lisflUHRZNXiLdl6o0bz8vA3y9J/G36tekfUfuht86gYp5goVKeESmTOx1/OVPcrQsUMCvxScv/wnI4bdMLelsEmRcVsdwNwY9UmlP6RnFeUqn+dz0Bby1/noGgE2+OVeBcdi6utU3kyTC/C1/JxIqxfqt9Z9rkTFmc18Vd1Kpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq+/M1ns; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq+/M1ns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B4BC116B1;
	Mon,  6 May 2024 22:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715033906;
	bh=1X0wUuW9Rp2t/ahmzXCvAfNAoLvjif0qwEKzPQG+nWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bq+/M1nsawz1HY6ztPeJWhW2x1y0Mk4RjtvDOPIsR4FrsESg0yE73NDZ81WWMOuAN
	 DIg1cqveBEocU9bkugIEJWbcXlwOAX5a0Cnn8rEareSSpe2QFN0wRMwEANqwTy5dGm
	 pnPZBk9Vvov8BuOXfxmW3GvSARRgz13DT/9+CYSCYLbjfTQqBKS+SYa+HRbAEJcdFX
	 S6u/Nbr1EOQr30d7CGJ1HmcCcaSRbojYvx8lZn/+2UZvmpoxydONLXVoWV/oTI8YQ9
	 TwUMvFLIhQe8B7txNotn36zyqY5UslOlM189kWvYPfYENpuJ1YHOjGN7lS50Eho0D3
	 SbAO2jEAn0A+g==
Date: Tue, 7 May 2024 00:18:23 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 15/27] rcu: Rename rcu_dynticks_eqs_online() into
 rcu_watching_eqs_online()
Message-ID: <ZjlXLzjSKgXyI_7S@pavilion.home>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-16-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-16-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:19AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/rcu/tree.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index bb0d9dd8b6d3a..fe2beb7d2e82d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -280,7 +280,7 @@ void rcu_softirq_qs(void)
>  }
>  
>  /*
> - * Reset the current CPU's ->dynticks counter to indicate that the
> + * Reset the current CPU's RCU_WATCHING counter to indicate that the
>   * newly onlined CPU is no longer in an extended quiescent state.
>   * This will either leave the counter unchanged, or increment it
>   * to the next non-quiescent value.
> @@ -289,7 +289,7 @@ void rcu_softirq_qs(void)
>   * of the ->dynticks counter are manipulated only by the corresponding CPU,
>   * or when the corresponding CPU is offline.
>   */
> -static void rcu_dynticks_eqs_online(void)
> +static void rcu_watching_eqs_online(void)

Or simply rcu_watching_online?

Thanks.

>  {
>  	if (ct_rcu_watching() & CT_RCU_WATCHING)
>  		return;
> @@ -5051,7 +5051,7 @@ void rcutree_report_cpu_starting(unsigned int cpu)
>  	rnp = rdp->mynode;
>  	mask = rdp->grpmask;
>  	arch_spin_lock(&rcu_state.ofl_lock);
> -	rcu_dynticks_eqs_online();
> +	rcu_watching_eqs_online();
>  	raw_spin_lock(&rcu_state.barrier_lock);
>  	raw_spin_lock_rcu_node(rnp);
>  	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
> -- 
> 2.43.0
> 
