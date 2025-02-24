Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274801DD0D4;
	Mon, 24 Feb 2025 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423962; cv=none; b=AawC0DtE3FwmjNeSBmut7/hCPpiuCl0JvsiBx8HbaKJqG+Os6Qx39sQn8HOJcmTT97GMX+HkOclHzAN+hea3mrWBJXQaYciTPDMBngVmxKnpivEi4Ig5Ri630FfE8f8Cdb9jM2aO3u/3fVqZmWcm2DFM/B48NN3n94vm9NdoNL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423962; c=relaxed/simple;
	bh=yL4OWxX8CjxP2qnWTYPMsQNdz6HBPW+WOAg7NNtS33A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uk0+kQ1xPQmSf10HLN+mv/3B6QT+nZzXWDwRF7oePID7yQmru4uB2ZSJTfK/lXAIMB5BJ19gsAGIYuPGmrYwyPkSdGnAc6zV2n1pslXZTsp2hUrh6Dz8x5eVg9bcZ86o+zmOA47bGigdvpCJYvC2q0R6FlOvREEZ+O6qig8ZY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu0uTFfP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu0uTFfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A3BC4CED6;
	Mon, 24 Feb 2025 19:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423961;
	bh=yL4OWxX8CjxP2qnWTYPMsQNdz6HBPW+WOAg7NNtS33A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cu0uTFfPyaEWy81P4KRM3QfYkBYP3dCTVyoHZnYJFJ8hHWRDZ29wSOa36ou/zRugH
	 63tfpBBXlqXwCqIQGEsVAqOgqj14ViEM2j2ZC4DHRTTaTwHzweN2nAZug5lqofjAUU
	 y7sBr5ipJASwbUNRhYQWg+YEwxcj9PL599Mw45QHvWIrikFSwFkTRMhRMPnxwgxf4s
	 LaEKEQyIUfVpb49vvyzS2JgzLg9fKJPNOVaaXU63Wo9J3Sr2GFXxkGhKS13GssN+u1
	 Ii1li9mAJxMvNJ/d4FyI3Y/rg6jSqX1ZfrkJPr8rIoztGH2DrPimNhfFtyxDc0sOEH
	 hIzVlOIg7z1FQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0E76CCE0B34; Mon, 24 Feb 2025 11:06:01 -0800 (PST)
Date: Mon, 24 Feb 2025 11:06:01 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <400c9d5c-8725-4723-b129-c5f2976817a9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250224133659.879074-1-urezki@gmail.com>
 <20250224133659.879074-3-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224133659.879074-3-urezki@gmail.com>

On Mon, Feb 24, 2025 at 02:36:59PM +0100, Uladzislau Rezki (Sony) wrote:
> Switch for using of get_state_synchronize_rcu_full() and
> poll_state_synchronize_rcu_full() pair for debug a normal
> synchronize_rcu() call.
> 
> Just using "not" full APIs to identify if a grace period
> is passed or not might lead to a false kernel splat.
> 
> Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> Reported-by: cheung wall <zzqq0103.hey@gmail.com>
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

This causes the build to fail on TREE01.  One way to make the build
succeed is to remove the #ifdefs above.  Another way would be to add
#ifdefs to the WARN_ONCE() below.  I suspect that removing the #ifdefs
is best, at least until such time as people start passing many tens
of SRCU instances to synchronize_rcu_mult() or some such (which seems
quite unlikely).

Thoughts?

							Thanx, Paul

>  };
>  void wakeme_after_rcu(struct rcu_head *head);
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8625f616c65a..48384fa2eaeb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1632,12 +1632,10 @@ static void rcu_sr_normal_complete(struct llist_node *node)
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
>  
>  	/* Finally. */
>  	complete(&rs->completion);
> @@ -3247,7 +3245,7 @@ static void synchronize_rcu_normal(void)
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
