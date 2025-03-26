Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953A219D88B;
	Wed, 26 Mar 2025 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028666; cv=none; b=MnC4uDiTl30K2dvO7Pk8Yw7at2mqEFg7EuLbP9Vdr9uKXVjoonXqVul0aYoXG0O9pyoi/h1hRK8sYXnU6Tr9CYIFvT9OKECRdgDsqosukPEMROdDJmx42cJez4b/0thLdSrzQWGeWQ17UMWFZ/hupg6NRUcyChwiBCtU8MY1ctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028666; c=relaxed/simple;
	bh=vqL0V1SiP5cE9hDVYJ44aj2dIhVNbZXSCTb/rBYtgyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CR3Da/Nr0xPRxB9NT87rgjU803YZvAbBagcOxiW6pEssCctr35qf+AGqP+RHcvF/vcyTREeeNY2DXH8pGzjHKTJXEq37fi8vHOrytyBM4NUu//gXSAdQFG3O6hhsd8JdqHlSfNYWuZZoSS+gpVTI2zEoHqiyqBzMWlZWq8pQveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NulT1pcZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NulT1pcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191D1C4CEE2;
	Wed, 26 Mar 2025 22:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743028666;
	bh=vqL0V1SiP5cE9hDVYJ44aj2dIhVNbZXSCTb/rBYtgyY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NulT1pcZbz1Zavwtb+8Hb6HzNGpmZVew9oA7BYMZK6zjRDPwW3Ak8c2yB6MMlQOGB
	 UNSsvA/SxS40MexqOOH3SdNa02iMkNg7CXwz391ENfTtj52HJ1VrpsCZl3n//Mf5KH
	 /qayhlGBG0aGpkC45lwsP9qHgfhq5vGuk7WFKTT3J4x/JMBHGCdf9oZZWefsMOSEHM
	 gQVeGZo9e2V9t0lgN7tZp7aimPI5w7l81tm0u5cF702uieQORld/Zyl4fG9AWQsvpH
	 ZmC3jSvL/PmSPCKwtgcz1ZWcOBS9eSabYZTKZENe9/3athYc/omhxZoOYpr6OrpSkU
	 r1iZk6FMkzIhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C8183CE0C2A; Wed, 26 Mar 2025 15:37:45 -0700 (PDT)
Date: Wed, 26 Mar 2025 15:37:45 -0700
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
Subject: Re: [PATCH 3/3] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
Message-ID: <925905dd-e87e-497f-8723-f1f2ca6ecb12@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250324170156.469763-1-joelagnelf@nvidia.com>
 <20250324170156.469763-4-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324170156.469763-4-joelagnelf@nvidia.com>

On Mon, Mar 24, 2025 at 01:01:55PM -0400, Joel Fernandes wrote:
> From: Frederic Weisbecker <frederic@kernel.org>
> 
> The numbers used in rcu_seq_done_exact() lack some explanation behind
> their magic. Especially after the commit:
> 
>     85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")
> 
> which reported a subtle issue where a new GP sequence snapshot was taken
> on the root node state while a grace period had already been started and
> reflected on the global state sequence but not yet on the root node
> sequence, making a polling user waiting on a wrong already started grace
> period that would ignore freshly online CPUs.
> 
> The fix involved taking the snaphot on the global state sequence and
> waiting on the root node sequence. And since a grace period is first
> started on the global state and only afterward reflected on the root
> node, a snapshot taken on the global state sequence might be two full
> grace periods ahead of the root node as in the following example:
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
> Add a comment about those expectations and to clarify the magic within
> the relevant function.
> 
> Note that the issue arises mainly with the use of rcu_seq_done_exact()
> which has a much tigher guardband (of 2 GPs) to ensure the false-negative
> window of the API during wraparound is limited to just 2 GPs.
> rcu_seq_done() does not have such strict requirements, however its large
> false-negative window of ULONG_MAX/2 is not ideal for the polling API.
> However, this also means care is needed to ensure the guardband is as
> large as needed to avoid the example scenario describe above which a
> warning added in an earlier patch does.
> 
> [ Comment wordsmithing by Joel ]
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Looks good, and I stand by my Reviewed-by.  ;-)

							Thanx, Paul

> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/rcu.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 5e1ee570bb27..db63f330768c 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -160,6 +160,15 @@ static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
>   * Given a snapshot from rcu_seq_snap(), determine whether or not a
>   * full update-side operation has occurred, but do not allow the
>   * (ULONG_MAX / 2) safety-factor/guard-band.
> + *
> + * The token returned by get_state_synchronize_rcu_full() is based on
> + * rcu_state.gp_seq but it is tested in poll_state_synchronize_rcu_full()
> + * against the root rnp->gp_seq. Since rcu_seq_start() is first called
> + * on rcu_state.gp_seq and only later reflected on the root rnp->gp_seq,
> + * it is possible that rcu_seq_snap(rcu_state.gp_seq) returns 2 full grace
> + * periods ahead of the root rnp->gp_seq. To prevent false-positives with the
> + * full polling API that a wrap around instantly completed the GP, when nothing
> + * like that happened, adjust for the 2 GPs in the ULONG_CMP_LT().
>   */
>  static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
>  {
> -- 
> 2.43.0
> 
