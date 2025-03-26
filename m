Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2618BC2F;
	Wed, 26 Mar 2025 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028608; cv=none; b=WbrsOPZ2ORao+U7UpY8l5W54221pGsSt7g8nHyH1kWINZ9/PN0foLeD6A2Ji0gQZRvBCk6aedVu7J0DvOIC+7TDR+Y25ajZRsQOffnp7kSH/z4FMBzaaIsqN7eQa7cs4Sov/bv870RUoRWAOLXX+rdKsJ6GKjpykawGAPrFxzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028608; c=relaxed/simple;
	bh=uf9/CA9iY7R55UcAmNn+mkDY0iXT9Kbinev+Y+8u/eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubO6a4eNVfrvwidQraHxuB9HBvt9Dh/oT/aQTZfKozN3Sy4+69hgUb/IbX9NlWGgDfQUc8ma0UX1DjmGgKTaqzbZ0Kp9etZd1TEYZf7u+LAutWYV3K/IoWcFCG+xiEIwxUJLdkexHixO6YyVkyabIEiuWgaSNQ9d2tmD5yI537U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cghPgQCU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cghPgQCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E2FC4CEE2;
	Wed, 26 Mar 2025 22:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743028608;
	bh=uf9/CA9iY7R55UcAmNn+mkDY0iXT9Kbinev+Y+8u/eE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cghPgQCUZ18NnUn/67ceC3Xl987BbFsoO0cdtPKNSIBYvN/lgL8CpG7buyS/eWuKx
	 TdpSpxapwSluEus48VFPWzJdemmuGVqrJxmt7NIlJK8Jn99qV1m6PE8ud8ac6hHB5x
	 hbrnGnDhHLLfSXq9mD+0dbuZ4EPvAZqePUpTEVg3eP3M4/twy3Gv/aXZE8wxDAy/cU
	 eqV6D/ptcQVXFMFtPwx0jg2mJ1+Jrjl1AaSLpESTk+9wPMm0JKE/fOPb/rtnrtMX7N
	 e9PN1amBYT7kemorBiMKiXeJRE86PtsVVGqINN62AGAA7lrjaHPq4cl1ktVn3df2us
	 P/iveq9bzI9dQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CEBCDCE0C2A; Wed, 26 Mar 2025 15:36:47 -0700 (PDT)
Date: Wed, 26 Mar 2025 15:36:47 -0700
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
Subject: Re: [PATCH 2/3] rcu: Add warning to ensure rcu_seq_done_exact() is
 working
Message-ID: <4a40eba2-ebd3-42a8-a25f-b7a0ff94256b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-3-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324170156.469763-3-joelagnelf@nvidia.com>

On Mon, Mar 24, 2025 at 01:01:54PM -0400, Joel Fernandes wrote:
> The previous patch improved the rcu_seq_done_exact() function by adding
> a meaningful constant for the guardband.
> 
> Ensure that this is working for the future by a quick check during
> rcu_gp_init().
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

This is a good test for the guardband being way too short.

Are there other tests the should be run, possibly on a separate gp_seq
used only for testing?  Should the test below be under CONFIG_PROVE_RCU?

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 659f83e71048..29ddbcbea25e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1798,6 +1798,7 @@ static noinline_for_stack bool rcu_gp_init(void)
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp = rcu_get_root();
>  	bool start_new_poll;
> +	unsigned long old_gp_seq;
>  
>  	WRITE_ONCE(rcu_state.gp_activity, jiffies);
>  	raw_spin_lock_irq_rcu_node(rnp);
> @@ -1825,7 +1826,11 @@ static noinline_for_stack bool rcu_gp_init(void)
>  	 */
>  	start_new_poll = rcu_sr_normal_gp_init();
>  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> +	old_gp_seq = rcu_state.gp_seq;
>  	rcu_seq_start(&rcu_state.gp_seq);
> +	/* Ensure that rcu_seq_done_exact() guardband doesn't give false positives. */
> +	WARN_ON_ONCE(rcu_seq_done_exact(&old_gp_seq, rcu_seq_snap(&rcu_state.gp_seq)));
> +
>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
>  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
>  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> -- 
> 2.43.0
> 
