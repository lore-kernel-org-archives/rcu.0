Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B6B448BAE;
	Thu, 23 Jul 2026 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831417; cv=none; b=rhiP+U3AlCSeQ6yDYeQpxluzkJfPJkJrzBbyanvrU4v5lV36oaCm9n93hhunYWjEQfU+hLFns7wLSpW8DW0P7hM+b1Des/CtrgjkU5y6jupdey/hSa/GJwtuyNrhXjxDBUAQDdizz/Akd4+FQODeIt5vMK7DczBYOYCutDIcDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831417; c=relaxed/simple;
	bh=Uag77Smio5XH9/bkoUaPVRWbN0eTDINHs6brvSQB5YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULfzWNbLCv4GDdvEzGVZru56LbWdzVCMU9dxl/e8W8jrSc0rhCyQdIXfARK/nIOHGO/JPfTciCFRgmS3RrVb/InWK+MfH3zKxZj6K7xfRvujs4n1McQS+Gll0gEXzrr347G1VOPtFSjgHVWtWTrBbAAxjzwwpqsXyvfDlCYVt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5lcb15+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5lcb15+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49691F000E9;
	Thu, 23 Jul 2026 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784831411;
	bh=i377WEoIQ116ApMWoz15FZJ66a5GrGvAywe01KRqunw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=L5lcb15+/XElVbYXPa4LaVjobponXiF1RmzdjqiGipX6DpzFzCskdnLv6Hn/fJnuk
	 Dq5sDUeL1frutg9ZY8FD5wi4x1nYb6luAlBUhR1xXAGfOnJIGHUzRaW3lVZAI4daet
	 qf+KbQDwWAAk2hXELKIymJBShjdx3HMDQHdAkU+rYM9UT08vlvXrymEhFjVcDnXa/w
	 QSNe/7Hnl5q+gXeQxcAi7afLWq/TY5lkihcY+XAGudULUrBTFpkn9X4M0KmvHkW5wM
	 uRjWN8lUSLxB9b/h9IkvSCY9BjDVOvJeRZDEhE/jKvPhZGL6yy5+x4QF6fCEVmjPtX
	 BGCnxBVJbpN3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8C59BCE0AD8; Thu, 23 Jul 2026 11:30:11 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:30:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Reduce stack usage in show_rcu_gp_kthreads()
Message-ID: <2bf1d884-e2e2-41e7-b6fb-b8820efee451@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260723100430.17813-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723100430.17813-1-qiang.zhang@linux.dev>

On Thu, Jul 23, 2026 at 06:04:30PM +0800, Zqiang wrote:
> When CONFIG_KASAN=y and CONFIG_KASAN_STACK=y builds, the
> show_rcu_gp_kthreads() exceeds the 1024-byte frame-size limit:
> 
> make kernel/rcu/tree.o KCFLAGS="-fstack-usage"
>   DESCEND objtool
>   DESCEND bpf/resolve_btfids
>   INSTALL libsubcmd_headers
>   CC      kernel/rcu/tree.o
> In file included from kernel/rcu/tree.c:4998:
> kernel/rcu/tree_stall.h: In function 'show_rcu_gp_kthreads':
> kernel/rcu/tree_stall.h:994:1: warning: the frame size of 1656 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> grep show_rcu kernel/rcu/tree.su
> tree_nocb.h:1622:13:show_rcu_nocb_state 896     dynamic,bounded
> tree_stall.h:933:6:show_rcu_gp_kthreads 1784    dynamic,bounded
> tree_stall.h:1102:13:sysrq_show_rcu     16      static
> 
> Wrap the pr_info() into two noinline_for_stack helpers function:
> show_rcu_state() print rcu_state status, and show_rcu_node()
> print single rcu_node status.
> 
> After apply this change:
> 
> grep show_rcu kernel/rcu/tree.su
> tree_stall.h:955:22:show_rcu_node	696	dynamic,bounded
> tree_stall.h:930:22:show_rcu_state	872	dynamic,bounded
> tree_nocb.h:1622:13:show_rcu_nocb_state	896	dynamic,bounded
> tree_stall.h:972:6:show_rcu_gp_kthreads	544	static
> tree_stall.h:1113:13:sysrq_show_rcu	16	static
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Queued and pushed for further review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree_stall.h | 47 +++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 45b9856ccd2b..a6dfd036a7e9 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -927,20 +927,13 @@ bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
>  }
>  EXPORT_SYMBOL_GPL(rcu_check_boost_fail);
>  
> -/*
> - * Show the state of the grace-period kthreads.
> - */
> -void show_rcu_gp_kthreads(void)
> +static noinline_for_stack void show_rcu_state(void)
>  {
> -	unsigned long cbs = 0;
> -	int cpu;
>  	unsigned long j;
>  	unsigned long ja;
>  	unsigned long jr;
>  	unsigned long js;
>  	unsigned long jw;
> -	struct rcu_data *rdp;
> -	struct rcu_node *rnp;
>  	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
>  
>  	j = jiffies;
> @@ -957,21 +950,39 @@ void show_rcu_gp_kthreads(void)
>  		(long)data_race(READ_ONCE(rcu_get_root()->gp_seq_needed)),
>  		data_race(READ_ONCE(rcu_state.gp_max)),
>  		data_race(READ_ONCE(rcu_state.gp_flags)));
> +}
> +
> +static noinline_for_stack void show_rcu_node(struct rcu_node *rnp)
> +{
> +	pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
> +		rnp->grplo, rnp->grphi,
> +		(long)data_race(READ_ONCE(rnp->gp_seq)),
> +		(long)data_race(READ_ONCE(rnp->gp_seq_needed)),
> +		data_race(READ_ONCE(rnp->qsmask)),
> +		".b"[!!data_race(READ_ONCE(rnp->boost_kthread_task))],
> +		".B"[!!data_race(READ_ONCE(rnp->boost_tasks))],
> +		".E"[!!data_race(READ_ONCE(rnp->exp_tasks))],
> +		".G"[!!data_race(READ_ONCE(rnp->gp_tasks))],
> +		data_race(READ_ONCE(rnp->n_boosts)));
> +}
> +
> +/*
> + * Show the state of the grace-period kthreads.
> + */
> +void show_rcu_gp_kthreads(void)
> +{
> +	unsigned long cbs = 0;
> +	int cpu;
> +	struct rcu_data *rdp;
> +	struct rcu_node *rnp;
> +
> +	show_rcu_state();
>  	rcu_for_each_node_breadth_first(rnp) {
>  		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq_needed)) &&
>  		    !data_race(READ_ONCE(rnp->qsmask)) && !data_race(READ_ONCE(rnp->boost_tasks)) &&
>  		    !data_race(READ_ONCE(rnp->exp_tasks)) && !data_race(READ_ONCE(rnp->gp_tasks)))
>  			continue;
> -		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
> -			rnp->grplo, rnp->grphi,
> -			(long)data_race(READ_ONCE(rnp->gp_seq)),
> -			(long)data_race(READ_ONCE(rnp->gp_seq_needed)),
> -			data_race(READ_ONCE(rnp->qsmask)),
> -			".b"[!!data_race(READ_ONCE(rnp->boost_kthread_task))],
> -			".B"[!!data_race(READ_ONCE(rnp->boost_tasks))],
> -			".E"[!!data_race(READ_ONCE(rnp->exp_tasks))],
> -			".G"[!!data_race(READ_ONCE(rnp->gp_tasks))],
> -			data_race(READ_ONCE(rnp->n_boosts)));
> +		show_rcu_node(rnp);
>  		if (!rcu_is_leaf_node(rnp))
>  			continue;
>  		for_each_leaf_node_possible_cpu(rnp, cpu) {
> -- 
> 2.17.1
> 
