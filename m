Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906BB4430;
	Tue, 25 Feb 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498536; cv=none; b=VZLAkwI4RdFkED6w7GviaVYw2ud2HaGHsGBWGO8J5KHoouQbP2e+5O/IbZA6K7y028V6EGZw+PLHdFrOtsme7mpjCK1K2YOjCLllsDd5Y9b6Rb8BuOG+p4uCtztcfyOCPPw7h1LEpGYCGWJL81d+BL6GYAsxWL1LTadbTBB7kFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498536; c=relaxed/simple;
	bh=AeGdF/eU2Z9X4vfhHJOOAYS0KC67VcW7+xCbmNb6CAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MajGK1aNkWpZPGODpm1R0IQoDvTcgwtI03yNxaXcVk5UXFe9/OvI1FJ/6OdtW7ZSJ9FJEAl2JlZMbUtA+ZaZmq8b5l5AYP2XAtTTqBSMs6rokSh/qvhvlieWaGnNdcXpIXalMx1U5UUS0TZMSkzjyI9Gbj75DQi+m81VQ+8COgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nljzQG5F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nljzQG5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D08C4CEDD;
	Tue, 25 Feb 2025 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740498536;
	bh=AeGdF/eU2Z9X4vfhHJOOAYS0KC67VcW7+xCbmNb6CAg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nljzQG5FjcBX9sDfo5Gm/+BpFugvD+TOkv0HgHH5ispgVWchEJgQPC1dIVcbIIGsD
	 VA+stwy4/CkLPgFLCdKqc/B2vG7YwP5x4VR/zdv9NU9cUgk9Mmaj2LFEwZ8K3bp2gV
	 eKF3DGJsj4ko/iMUthElh4yO13e/XN8v5BMnkIec2XyS0FjQ+ep932tE//SIS1BJuS
	 EaDeYTuwmeiCpornVIZas2NxPcIDgU9JTKs8PXEkUyoWtnG/zQgo+G9Z72DGVHi4mj
	 x0Io871NMxFT0R8DsORD5AciWcVBbISWr6A5FGXrjgxGDAk3PHkWPoSjJUZBZ+Toz5
	 ErPqKE3mnA7Hw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9CA71CE045A; Tue, 25 Feb 2025 07:48:55 -0800 (PST)
Date: Tue, 25 Feb 2025 07:48:55 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <b643758e-5a6a-41e7-9688-4a685ec48533@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250225110020.59221-1-urezki@gmail.com>
 <20250225110020.59221-3-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225110020.59221-3-urezki@gmail.com>

On Tue, Feb 25, 2025 at 12:00:20PM +0100, Uladzislau Rezki (Sony) wrote:
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

This one passes light testing, so:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/rcupdate_wait.h | 3 +++
>  kernel/rcu/tree.c             | 8 +++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> index f9bed3d3f78d..4c92d4291cce 100644
> --- a/include/linux/rcupdate_wait.h
> +++ b/include/linux/rcupdate_wait.h
> @@ -16,6 +16,9 @@
>  struct rcu_synchronize {
>  	struct rcu_head head;
>  	struct completion completion;
> +
> +	/* This is for debugging. */
> +	struct rcu_gp_oldstate oldstate;
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
