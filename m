Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABBB18D;
	Fri, 11 Jul 2025 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752192108; cv=none; b=ne6Lhr9Qr5eW1/Ozffg/NWuZCR9SuhLygDrzR9EqorTSfPQ8TFXZy94N6xpWcveWkWi6MFU0U5hFOpQjLQpSjim/Vcimghg13KMVoxqeTAEQGdCG2JCozP9uvEYwq33EVDzAoL5otfEoO1prA2rC598tFELYd6+Qsh3N16u3Ubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752192108; c=relaxed/simple;
	bh=bfhRUE9KLj4AiPwRuPJog/FV9o9BOqxquXFb122pM2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBmHTLJe7i4Gaythn/QgOdOr2RFDRLaMoATfMBe3Z4DkouAyIkTR6jUKQYoeqzJKENyCUk7L2Bm5F0guO7CnM6M+I1prcxxEI5NWESZ2hVyiwBFVLu3OckUJEyPJGeOHXcPAU1UzMzStq74xtmmMd8caoK/qXMySEc5fTah8gKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIkw7as1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIkw7as1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31C6C4CEE3;
	Fri, 11 Jul 2025 00:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752192107;
	bh=bfhRUE9KLj4AiPwRuPJog/FV9o9BOqxquXFb122pM2w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uIkw7as1EA4K7vu69fCnQpgXiGQ9LgO/KFw/3aJb6hBMxQ/Bw0Lm7V1Pz9KCev0mY
	 47II1sSNNKOIrk32GLgK166HOzEEBxoIVroUsx2P8XpCzDxKaN3upG9Js3ccu6EyJ8
	 A9GJwIAVrnwTq4po8l9c6escr1TeukqgAl2XwxOC5Hm4lOYxKKCbgiXAjAM79Bz9z6
	 mt50hsSOc0u0/mtnlRIgDRK1fK0wRTyHdEaS2KNplmTK5/mlqHTp1YSqyUhzwynGa4
	 PP5Nc42WWFjx3JAfVg77u6074TpmV7mqzZ19s6N9lSa1iDIRzL23hiDehnDKut6/9c
	 ecQ6Il9cRchUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 662EACE0A44; Thu, 10 Jul 2025 17:01:47 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:01:47 -0700
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
	Zqiang <qiang.zhang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH -rcu -next 5/7] rcu: Document GP init vs hotplug-scan
 ordering requirements
Message-ID: <92d599bc-dbaa-4dd6-93b7-8fb07b10cf8e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
 <20250708142224.3940851-5-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708142224.3940851-5-joelagnelf@nvidia.com>

On Tue, Jul 08, 2025 at 10:22:22AM -0400, Joel Fernandes wrote:
> Add detailed comments explaining the critical ordering constraints
> during RCU grace period initialization, based on discussions with
> Frederic.
> 
> Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  .../RCU/Design/Requirements/Requirements.rst  | 41 +++++++++++++++++++
>  kernel/rcu/tree.c                             |  8 ++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 6125e7068d2c..771a1ce4c84d 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -1970,6 +1970,47 @@ corresponding CPU's leaf node lock is held. This avoids race conditions
>  between RCU's hotplug notifier hooks, the grace period initialization
>  code, and the FQS loop, all of which refer to or modify this bookkeeping.
>  
> +Note that grace period initialization (rcu_gp_init()) must carefully sequence
> +CPU hotplug scanning with grace period state changes. For example, the
> +following race could occur in rcu_gp_init() if rcu_seq_start() were to happen
> +after the CPU hotplug scanning.
> +
> +.. code-block:: none
> +
> +   CPU0 (rcu_gp_init)                   CPU1                          CPU2
> +   ---------------------                ----                          ----
> +   // Hotplug scan first (WRONG ORDER)
> +   rcu_for_each_leaf_node(rnp) {
> +       rnp->qsmaskinit = rnp->qsmaskinitnext;
> +   }
> +                                        rcutree_report_cpu_starting()
> +                                            rnp->qsmaskinitnext |= mask;
> +                                        rcu_read_lock()
> +                                        r0 = *X;
> +                                                                      r1 = *X;
> +                                                                      X = NULL;
> +                                                                      cookie = get_state_synchronize_rcu();
> +                                                                      // cookie = 8 (future GP)
> +   rcu_seq_start(&rcu_state.gp_seq);
> +   // gp_seq = 5
> +
> +   // CPU1 now invisible to this GP!
> +   rcu_for_each_node_breadth_first() {
> +       rnp->qsmask = rnp->qsmaskinit;
> +       // CPU1 not included!
> +   }
> +
> +   // GP completes without CPU1
> +   rcu_seq_end(&rcu_state.gp_seq);
> +   // gp_seq = 8
> +                                                                      poll_state_synchronize_rcu(cookie);
> +                                                                      // Returns true!
> +                                                                      kfree(r1);
> +                                        r2 = *r0; // USE-AFTER-FREE!
> +
> +By incrementing gp_seq first, CPU1's RCU read-side critical section
> +is guaranteed to not be missed by CPU2.
> +
>  Scheduler and RCU
>  ~~~~~~~~~~~~~~~~~
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 327848f436e7..32fdb66e9c9f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1835,6 +1835,14 @@ static noinline_for_stack bool rcu_gp_init(void)
>  	start_new_poll = rcu_sr_normal_gp_init();
>  	/* Record GP times before starting GP, hence rcu_seq_start(). */
>  	old_gp_seq = rcu_state.gp_seq;
> +	/*
> +	 * Critical ordering: rcu_seq_start() must happen BEFORE the CPU hotplug
> +	 * scan below. Otherwise we risk a race where a newly onlining CPU could
> +	 * be missed by the current grace period, potentially leading to
> +	 * use-after-free errors. For a detailed explanation of this race, see
> +	 * Documentation/RCU/Design/Requirements/Requirements.rst in the
> +	 * "Hotplug CPU" section.
> +	 */
>  	rcu_seq_start(&rcu_state.gp_seq);
>  	/* Ensure that rcu_seq_done_exact() guardband doesn't give false positives. */
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> -- 
> 2.34.1
> 
