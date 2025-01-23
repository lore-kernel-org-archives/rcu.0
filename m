Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A161CC881;
	Thu, 23 Jan 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669178; cv=none; b=gnrywWE9Ee75NvEfVm3WSZo+VCbsh6qUEOOFlWFLLPCrj+/IwVOtEneDFyyvJk5bsIrRl9VQEJtrLoClLgDzKBy458rBrLzjmxYwREHHJiWVbaG+dMNSUB0O9txBhEXSjercDZ/r7gvakexK7YOr0YmmqXvaI4gIBE+utmClHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669178; c=relaxed/simple;
	bh=f6+UPUNuZpmIh6EyaK6jnpUslxTgcKdctqVTk2mUZJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8BBtFaTSzNobAs4AlZtGKC36LRkJe5hLJdgML5RzTxOvpQBJ9iV0cKWpcFu502h97hD5DM6XFpGhWow00q5dIBGugpK2FUrSHuomS3nFOjB5AOZp2S4EeDKEKj1P4olEFh5C3wEIUMmGJWDep9krGCPGZlYVkseY9ylril6o+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbSw/J8u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbSw/J8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E31AC4CED3;
	Thu, 23 Jan 2025 21:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737669177;
	bh=f6+UPUNuZpmIh6EyaK6jnpUslxTgcKdctqVTk2mUZJI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sbSw/J8uLOR27bnu47LD2ir25yDwDfX38kxyAFHx9pQzE+WboicitjdW4cJ2QJ/gL
	 Q+pCdBFKy8UMxea1n2CICInDGvDMtnZeTsr+EYO15T6n6SsF1+xqIP0dZhXmQAeLke
	 LWldrxRP1eWrXQ27FKyXxPu4qon9T5oVQJdHuFTM2dEPmxnpVNKDSzId5S0qAbClPl
	 MB/LSBzX0t9pfNGcaONwqfu4HUkYHYsXb40GMpg8ZwijJEnhOQSWEK2tkWgXPCBh8m
	 oHJHQzSIrKJ4cHTIv+fRmiXcAczjWYopEWZWLqXHk2F1fib0lAt+KPvq2l9jfrwfo/
	 RWKVR1wWd8OGQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 365E0CE378B; Thu, 23 Jan 2025 13:52:57 -0800 (PST)
Date: Thu, 23 Jan 2025 13:52:57 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 4/4] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <ea7d8677-f81e-4590-9716-23ea41597873@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-4-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123185828.460836-4-urezki@gmail.com>

On Thu, Jan 23, 2025 at 07:58:28PM +0100, Uladzislau Rezki (Sony) wrote:
> Switch for using of get_state_synchronize_rcu_full() and
> poll_state_synchronize_rcu_full() pair for debug a normal
> synchronize_rcu() call.
> 
> Just using "not" full APIs to identify if a grace period
> is passed or not might lead to a false kernel splat.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcupdate_wait.h | 4 ++++
>  kernel/rcu/tree.c             | 8 +++-----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> index f9bed3d3f78d..a16fc2a9a7d7 100644
> --- a/include/linux/rcupdate_wait.h
> +++ b/include/linux/rcupdate_wait.h
> @@ -16,6 +16,10 @@
>  struct rcu_synchronize {
>  	struct rcu_head head;
>  	struct completion completion;
> +#ifdef CONFIG_PROVE_RCU
> +	/* This is for testing. */
> +	struct rcu_gp_oldstate oldstate;
> +#endif
>  };
>  void wakeme_after_rcu(struct rcu_head *head);
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2795d6b5109c..0ae90089ef09 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1612,12 +1612,10 @@ static void rcu_sr_normal_complete(struct llist_node *node)
>  {
>  	struct rcu_synchronize *rs = container_of(
>  		(struct rcu_head *) node, struct rcu_synchronize, head);
> -	unsigned long oldstate = (unsigned long) rs->head.func;
>  
>  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> -		!poll_state_synchronize_rcu(oldstate),
> -		"A full grace period is not passed yet: %lu",
> -		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
> +		!poll_state_synchronize_rcu_full(&rs->oldstate),
> +		"A full grace period is not passed yet!\n");

Looks good, but why not also continue printing out the required
grace-period sequence number?  Yes, there would need to be helper
sprintf()-style functions to paper over the difference between Tiny RCU
and Tree RCU.  ;-)

							Thanx, Paul

>  	/* Finally. */
>  	complete(&rs->completion);
> @@ -3214,7 +3212,7 @@ static void synchronize_rcu_normal(void)
>  	 * snapshot before adding a request.
>  	 */
>  	if (IS_ENABLED(CONFIG_PROVE_RCU))
> -		rs.head.func = (void *) get_state_synchronize_rcu();
> +		get_state_synchronize_rcu_full(&rs.oldstate);
>  
>  	rcu_sr_normal_add_req(&rs);
>  
> -- 
> 2.39.5
> 
