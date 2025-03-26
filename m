Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FF4430;
	Wed, 26 Mar 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028402; cv=none; b=KkYE1mKeCWf1AEijSqSZ2mG1c5qQXWABsuLflw5BezDYhxmkFat7lt7rhauxGN7Njz7dx6Xjk19I6lJ2yNgKf1CyoQ7xrUs796s+93SvHsNSXPJ7sJ6w1onwZJURXeBsrjs2fbaFewOFjBXgCInAxBFKZQrx18cpNjFCS8eucOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028402; c=relaxed/simple;
	bh=ISqhImE6eYwjv1Cg06qLnLLs52vZAesQPPWVCd4N+64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO7eiXlbIVPC7nRdE9Y5H9k0cVdompVdsl+gBZABG1IrhojocLrSaNPEp6WTfmQIPWjyKLgFhlU5qgvNyefDs3vDf2BG6aGruT/5kM7dwiFBzfR7dwTonTEfUjd1tmbqEnfPhLyRROAhFmHDe9UsTlmwLgZpwqI6A9QzJHkLLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsHxzSXK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsHxzSXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB6FC4CEE2;
	Wed, 26 Mar 2025 22:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743028401;
	bh=ISqhImE6eYwjv1Cg06qLnLLs52vZAesQPPWVCd4N+64=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NsHxzSXKDXPzF/dGzhQdtG+24ZPYDCYiX6Y3Pm7VA030tuRzWvsSQV253s/XPD7eU
	 B63G8fs6MmYqxI5KFV5UWADoUqbh8VPszJNls+jZ67zcluKeU7rv0MPJGXqmXcUOIp
	 p4EFgf8+PtsHb+3Z+zc7nKU3hDr12AXw1C8SZYtfvoRcHFoU+K7VJvLFSLY2yc5Auo
	 QVoj0Vm0krlyYQ8vQ+6yjGyueYqjKP3zAEPIfT52z9M3Dg+tOyqHGT+WIQ2nBbYM2d
	 OcDQMEKxvlS9HdcvwCpRUuxlVAlCfMWBEEOshbca2vLKgnvZF+x+uJnAz37JwswlgJ
	 +91qQiOSrsVmA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4CC77CE0C2A; Wed, 26 Mar 2025 15:33:21 -0700 (PDT)
Date: Wed, 26 Mar 2025 15:33:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 1/3] rcu: Replace magic number with meaningful constant
 in rcu_seq_done_exact()
Message-ID: <eeda52c2-5397-4aad-ad01-ca04e5b0b80f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-2-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324170156.469763-2-joelagnelf@nvidia.com>

On Mon, Mar 24, 2025 at 01:01:53PM -0400, Joel Fernandes wrote:
> The rcu_seq_done_exact() function checks if a grace period has completed by
> comparing sequence numbers. It includes a guard band to handle sequence number
> wraparound, which was previously expressed using the magic number calculation
> '3 * RCU_SEQ_STATE_MASK + 1'.
> 
> This magic number is not immediately obvious in terms of what it represents.
> 
> Instead, the reason we need this tiny guardband is because of the lag between
> the setting of rcu_state.gp_seq_polled and root rnp's gp_seq in rcu_gp_init().
> 
> This guardband needs to be at least 2 GPs worth of counts, to avoid recognizing
> the newly started GP as completed immediately, due to the following sequence
> which arises due to the delay between update of rcu_state.gp_seq_polled and
> root rnp's gp_seq:
> 
> rnp->gp_seq = rcu_state.gp_seq = 0
> 
>     CPU 0                                           CPU 1
>     -----                                           -----
>     // rcu_state.gp_seq = 1
>     rcu_seq_start(&rcu_state.gp_seq)
>                                                     // snap = 8
>                                                     snap = rcu_seq_snap(&rcu_state.gp_seq)
>                                                     // Two full GP differences
>                                                     rcu_seq_done_exact(&rnp->gp_seq, snap)
>     // rnp->gp_seq = 1
>     WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
> 
> This can happen due to get_state_synchronize_rcu_full() sampling
> rcu_state.gp_seq_polled, however the poll_state_synchronize_rcu_full()
> sampling the root rnp's gp_seq. The delay between the update of the 2
> counters occurs in rcu_gp_init() during which the counters briefly go
> out of sync.
> 
> Make the guardband explictly 2 GPs. This improves code readability and
> maintainability by making the intent clearer as well.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

One concern is that a small error anywhere in the code could cause this
minimal guard band to be too small.  This is not a problem for some
use cases (rcu_barrier() just does an extra operation, and normal grace
periods are protected from forever-idle CPUs by ->gpwrap), but could be
an issue on 32-bit systems for user of polled RCU grace periods.

In contrast, making the guard band a bit longer than it needs to be
has little or no downside.

							Thanx, Paul

> ---
>  kernel/rcu/rcu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index eed2951a4962..5e1ee570bb27 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -57,6 +57,9 @@
>  /* Low-order bit definition for polled grace-period APIs. */
>  #define RCU_GET_STATE_COMPLETED	0x1
>  
> +/* A complete grace period count */
> +#define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
> +
>  extern int sysctl_sched_rt_runtime;
>  
>  /*
> @@ -162,7 +165,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
>  {
>  	unsigned long cur_s = READ_ONCE(*sp);
>  
> -	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
> +	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_GP));
>  }
>  
>  /*
> -- 
> 2.43.0
> 
