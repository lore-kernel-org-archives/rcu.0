Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11518F2D3;
	Fri, 30 Aug 2024 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014391; cv=none; b=T1Mo0DiuDyL256l8NHBGfabTeUhGJw4JjZh49S60sBF5oIFrGDB12kUmYEsG8voTjki6QgcH8WAhJ7APipzq2Bo8OhC4SzMJ4aJcv4zKJK6T4B2pQ1XK40k51SZ1uv3Rc2Ihb0wt/S+5HZuZ0SZvd/cYcsGxaHbFpxWcMB/Jw5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014391; c=relaxed/simple;
	bh=G6MWC5e6R+noyQxSjslE/IMrHUOozuFkANb3uVMyQck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2m+1cum2PRaes+Wbafc+LKPBO0CHhQU0pBeXClGjE+qeSxh/yImrhyWmUyFIsVC4MMyr2Dw5a2iK8LmUVpC3NNNjpaDRBUUXDKNOX/aHaq3SugUb4m8Wiae/tSWcwBurL/i8uIa3kbDuDTRkdu17MlDPbbDKbvbEo0V4drjG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHrsHV/Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHrsHV/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF69C4CEC8;
	Fri, 30 Aug 2024 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725014390;
	bh=G6MWC5e6R+noyQxSjslE/IMrHUOozuFkANb3uVMyQck=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RHrsHV/YKRRVl0+peg0C1LeAn+5sZCFEQIkLxz69jk0qkqo1zjWmcXr5R4SIDGRxR
	 c+LSJKOwYKP3fJDN56KeJHxlg/wvYV29Bv0Po+V8O0KXCoMTZEdyXQ5wY88P0VmKl3
	 Y416yexzAIbNfjJMl2Md/r2p3I2uQm1IvPnIiWOWBdbtLIJsQy3dN9QetU3NbrEMLg
	 hFFnelLjsBVzUV4iwClkay4Ve/odOh2GqIMoipKXKhOqYQCbtJP+95CHSjV5Zx/Lbm
	 7oe39/hTyW+2x9EndqTLTOyXsvV48nKr2hodgzzgl1X1LH+zfBUVPVFx2KudRiGg/G
	 OKIKPO9sCApwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5EB6FCE0FF5; Fri, 30 Aug 2024 03:39:50 -0700 (PDT)
Date: Fri, 30 Aug 2024 03:39:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] srcu: Replace WARN_ON_ONCE() with BUILD_BUG_ON() if
 possible
Message-ID: <cd0cd3a9-f372-4c49-9530-de51719f3cbc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240822032128.1970-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822032128.1970-1-thunder.leizhen@huawei.com>

On Thu, Aug 22, 2024 at 11:21:28AM +0800, Zhen Lei wrote:
> The value of ARRAY_SIZE() can be determined at compile time, so if both
> sides of the equation are ARRAY_SIZE(), using BUILD_BUG_ON() can help us
> catch the problem earlier.
> 
> While there are cases where unequal array sizes will work, there is no
> point in allowing them, so it makes more sense to force them to be equal
> using BUILD_BUG_ON().
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/srcutree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index b24db425f16d850..a9c7795bb77d650 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -128,7 +128,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
>  	 * Initialize the per-CPU srcu_data array, which feeds into the
>  	 * leaves of the srcu_node tree.
>  	 */
> -	WARN_ON_ONCE(ARRAY_SIZE(sdp->srcu_lock_count) !=
> +	BUILD_BUG_ON(ARRAY_SIZE(sdp->srcu_lock_count) !=
>  		     ARRAY_SIZE(sdp->srcu_unlock_count));
>  	for_each_possible_cpu(cpu) {
>  		sdp = per_cpu_ptr(ssp->sda, cpu);
> @@ -186,7 +186,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
>  	/* Each pass through this loop initializes one srcu_node structure. */
>  	srcu_for_each_node_breadth_first(ssp, snp) {
>  		spin_lock_init(&ACCESS_PRIVATE(snp, lock));
> -		WARN_ON_ONCE(ARRAY_SIZE(snp->srcu_have_cbs) !=
> +		BUILD_BUG_ON(ARRAY_SIZE(snp->srcu_have_cbs) !=
>  			     ARRAY_SIZE(snp->srcu_data_have_cbs));
>  		for (i = 0; i < ARRAY_SIZE(snp->srcu_have_cbs); i++) {
>  			snp->srcu_have_cbs[i] = SRCU_SNP_INIT_SEQ;
> -- 
> 2.34.1
> 
