Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA837C;
	Tue,  4 Jun 2024 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717459855; cv=none; b=YgXDxzCmnPu63S/F+YW1ctwA4lPLOwX/i0/U5rMp57BLpifeqXH3QdL+N3RRZ/sRZnBOnRAMHb/vga8sVGUhxr4AMQoFCIpSaCPxNkOXj6F5sxVUou9+2MnvQkC0Kg3SQ4/SNGl5T5zWL8yppzuoKrdwjtcEZKcINluhWdwOLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717459855; c=relaxed/simple;
	bh=PY1+D0GVG5kZRRDKKyxIm4TEVwjORk0BV4O9hhADL/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUYbjTLgmJiJ4Ed3kqkqLk4pgv+tuDAqJ6G6bZNxdmMFyx9bihI22oLn6PSMqz9bkVoYQdowwqIBPZdVVAz9UBXtGxRBevpFGIV/+RdPZr43czYiKcwlQKtTnp8fnjMK5Ta4WQOUWdGOmruAvyGyBYcAly1RcJlJjkImf7W7d2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHNNGFlF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHNNGFlF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453C2C2BD10;
	Tue,  4 Jun 2024 00:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717459855;
	bh=PY1+D0GVG5kZRRDKKyxIm4TEVwjORk0BV4O9hhADL/4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nHNNGFlFD1eLsDquaGgbZ0iUe9rNarXs8gOtuEMA14qN2gCThN24zsDq88tMUb4SU
	 BvQcA/OR07vTNjH82vP0v/qAVUSTvSOophbqZFHNEQZFYOFu0+rzwVN5+W38Cn16ka
	 iz1VysAiJFxaXKgod5mrJWKuxxfOTeqEk6XuMeRY8CEcEQCy4naGssepc71n+lc/87
	 rZtuv8gKNN4gCbEFj8YJBR9QOmQo6whxqYEOysGoHzudNYW/3M2gHOz8PvSJ6v7O/W
	 BFyqS658h4IGN6TKgyD0nym25bYTHCXjwcHXDqEKJon0+oaTwNz93Ypm6g8WaC7/M6
	 pg751Wu84QdWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E6BD3CE0886; Mon,  3 Jun 2024 17:10:54 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:10:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5/6] rcu: Remove full memory barrier on RCU stall printout
Message-ID: <5bc2d72a-ae27-43f0-893e-afb202abd61b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-6-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515125332.9306-6-frederic@kernel.org>

On Wed, May 15, 2024 at 02:53:31PM +0200, Frederic Weisbecker wrote:
> RCU stall printout fetches the EQS state of a CPU with a preceding full
> memory barrier. However there is nothing to order this read against at
> this debugging stage. It is inherently racy when performed remotely.
> 
> Do a plain read instead.
> 
> This was the last user of rcu_dynticks_snap().
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

I went through all of these, and the look good.  Though I am a bit
nervous about this one.  The RCU CPU stall warning code used to be
completely unordered, but the hardware taught me better.  I did not
add these in response to a problem (just lazily used the existing fully
ordered primitive), but you never know.  Me, I would have kept the extra
memory barriers in all six patches because they are not on a fastpath,
but you are quite correct that they are redundant.

So I have queued these, and intend to send them into the next merge
window.  However, you now own vanilla RCU grace-period memory ordering,
both normal and expedited.  As in if someone else breaks it, you already
bought it.  ;-)

							Thanx, Paul

> ---
>  kernel/rcu/tree.c       | 10 ----------
>  kernel/rcu/tree_stall.h |  4 ++--
>  2 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 02f6f3483482..04dde7473613 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -299,16 +299,6 @@ static void rcu_dynticks_eqs_online(void)
>  	ct_state_inc(RCU_DYNTICKS_IDX);
>  }
>  
> -/*
> - * Snapshot the ->dynticks counter with full ordering so as to allow
> - * stable comparison of this counter with past and future snapshots.
> - */
> -static int rcu_dynticks_snap(int cpu)
> -{
> -	smp_mb();  // Fundamental RCU ordering guarantee.
> -	return ct_dynticks_cpu_acquire(cpu);
> -}
> -
>  /*
>   * Return true if the snapshot returned from rcu_dynticks_snap()
>   * indicates that RCU is in an extended quiescent state.
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 460efecd077b..4b0e9d7c4c68 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -501,7 +501,7 @@ static void print_cpu_stall_info(int cpu)
>  	}
>  	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
>  	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
> -			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
> +			rcu_dynticks_in_eqs(ct_dynticks_cpu(cpu));
>  	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
>  	if (rcuc_starved)
>  		// Print signed value, as negative values indicate a probable bug.
> @@ -515,7 +515,7 @@ static void print_cpu_stall_info(int cpu)
>  			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
>  				"!."[!delta],
>  	       ticks_value, ticks_title,
> -	       rcu_dynticks_snap(cpu) & 0xffff,
> +	       ct_dynticks_cpu(cpu) & 0xffff,
>  	       ct_dynticks_nesting_cpu(cpu), ct_dynticks_nmi_nesting_cpu(cpu),
>  	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
>  	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
> -- 
> 2.44.0
> 
