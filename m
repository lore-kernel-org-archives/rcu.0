Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76218F6C;
	Fri, 11 Jul 2025 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752192170; cv=none; b=a76loWyYgAoTXnIkHBRBUxJIICB5pTyk+CowXfRJH+jFV79m1BPYkMup6eEHDVa9daa32bnaeWvAiNBwopCF6OF9TJbV2fUj6IzYN4PTSrw7a5iA1CTg22fuaAwJRWZzNwUG4XQI+pUcx9G7n2HTTgA8ZV9br7UZmm/yZQ0Y7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752192170; c=relaxed/simple;
	bh=xdcFbHRdZncjlRIQrGyU2IWo++gCSR0xp+gqRGqTULM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoW741+sAVUQShR6lar6ocjlDXUOnv3xTEAaxP5gE1x2XwkGeid3eS3D6gXbOvAJeAfdzfEYuFZaQunJ0wg8ER/EeDvGvD8M81EGRPvbo3kNugBgMDr3sHjT8JWZsX5vVL2WCgNzh5pQGPH8Q9NlCL+5iUIQtGN+wvrnGbsV4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c18D6O9e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c18D6O9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864D6C4CEE3;
	Fri, 11 Jul 2025 00:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752192170;
	bh=xdcFbHRdZncjlRIQrGyU2IWo++gCSR0xp+gqRGqTULM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=c18D6O9eDmQEJTrIMAcbntkGlr+KdNZYb7uDOIG4SYKLBMW4C/O2LhHK+sCiJTAJ5
	 6HXa5eOjpGCwwbGIIX0BMBCgpwN4Beo/Ag/q28MR4cpHwLnI9VLqHzlt94WYQUbDQ3
	 4XFgPB+/xN8jlIn7D4V1Ct0Q84gXceA0taACKlhHnFHmpkGhV5IPCXSUcu2/s3Yu83
	 q4uo6crKNUIc5G6XHThTeTQ/ZOsGdjsTyiqJPg7zyDVVmkuxjy55xSBSNI1S2qd/CC
	 icdgrEcmUNwOJADbD81GM5/wAUHmhOPXq0BSmlg4kkMxXDUBltZiDZ9u3IsFa3h6gK
	 JkoS1QGMcBhxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 31505CE0A44; Thu, 10 Jul 2025 17:02:50 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:02:50 -0700
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
Subject: Re: [PATCH -rcu -next 6/7] rcu: Document separation of rcu_state and
 rnp's gp_seq
Message-ID: <9fc515d7-313b-4d94-a48a-5a4ef0a40f71@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
 <20250708142224.3940851-6-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708142224.3940851-6-joelagnelf@nvidia.com>

On Tue, Jul 08, 2025 at 10:22:23AM -0400, Joel Fernandes wrote:
> The details of this are subtle and was discussed recently. Add a
> quick-quiz about this and refer to it from the code, for more clarity.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  .../Data-Structures/Data-Structures.rst       | 32 +++++++++++++++++++
>  kernel/rcu/tree.c                             |  4 +++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
> index 04e16775c752..930535f076b4 100644
> --- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
> +++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
> @@ -286,6 +286,38 @@ in order to detect the beginnings and ends of grace periods in a
>  distributed fashion. The values flow from ``rcu_state`` to ``rcu_node``
>  (down the tree from the root to the leaves) to ``rcu_data``.
>  
> ++-----------------------------------------------------------------------+
> +| **Quick Quiz**:                                                       |
> ++-----------------------------------------------------------------------+
> +| Given that the root rcu_node structure has a gp_seq field,            |
> +| why does RCU maintain a separate gp_seq in the rcu_state structure?   |
> +| Why not just use the root rcu_node's gp_seq as the official record    |
> +| and update it directly when starting a new grace period?              |
> ++-----------------------------------------------------------------------+
> +| **Answer**:                                                           |
> ++-----------------------------------------------------------------------+
> +| On single-node RCU trees (where the root node is also a leaf),        |
> +| updating the root node's gp_seq immediately would create unnecessary  |
> +| lock contention. Here's why:                                          |
> +|                                                                       |
> +| If we did rcu_seq_start() directly on the root node's gp_seq:         |
> +| 1. All CPUs would immediately see their node's gp_seq from their rdp's|
> +|    gp_seq, in rcu_pending(). They would all then invoke the RCU-core. |
> +| 2. Which calls note_gp_changes() and try to acquire the node lock.    |
> +| 3. But rnp->qsmask isn't initialized yet (happens later in            |
> +|    rcu_gp_init())                                                     |
> +| 4. So each CPU would acquire the lock, find it can't determine if it  |
> +|    needs to report quiescent state (no qsmask), update rdp->gp_seq,   |
> +|    and release the lock.                                              |
> +| 5. Result: Lots of lock acquisitions with no grace period progress    |
> +|                                                                       |
> +| By having a separate rcu_state.gp_seq, we can increment the official  |
> +| grace period counter without immediately affecting what CPUs see in   |
> +| their nodes. The hierarchical propagation in rcu_gp_init() then       |
> +| updates the root node's gp_seq and qsmask together under the same lock|
> +| acquisition, avoiding this useless contention.                        |
> ++-----------------------------------------------------------------------+
> +
>  Miscellaneous
>  '''''''''''''
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 32fdb66e9c9f..c31b85e62310 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1842,6 +1842,10 @@ static noinline_for_stack bool rcu_gp_init(void)
>  	 * use-after-free errors. For a detailed explanation of this race, see
>  	 * Documentation/RCU/Design/Requirements/Requirements.rst in the
>  	 * "Hotplug CPU" section.
> +	 *
> +	 * Also note that the root rnp's gp_seq is kept separate from, and lags,
> +	 * the rcu_state's gp_seq, for a reason. See the Quick-Quiz on
> +	 * Single-node systems for more details (in Data-Structures.rst).
>  	 */
>  	rcu_seq_start(&rcu_state.gp_seq);
>  	/* Ensure that rcu_seq_done_exact() guardband doesn't give false positives. */
> -- 
> 2.34.1
> 
