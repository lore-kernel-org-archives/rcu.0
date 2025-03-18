Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E1211A20;
	Tue, 18 Mar 2025 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318982; cv=none; b=LGCEJ2ec2W+fF7ujGtdtwg2RXoynBfGc+sHNsTmmS3lB+LKW9fc8+TtR7I0kHFw2xf+ah3m3OrXJKz0i2HkZruhocgLQvnX9IMPQ+bBYW2lF5QBnYhDNyxfupmE8xKskOr2gfZ3NQCfKmfRjAu+QMf/cECKo5CPFaEEVxI/rPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318982; c=relaxed/simple;
	bh=Cio401m5J8j6/Hx5tMo+Hm7yebMVzz/u47TvF8D9QvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0iD918X8Rk5q6X9rXWkZ4uPXPYlwddWYO+kI3A2Q0eJ3ejDrzBks3vdyAHjhbsgLQ/l/fSuD/jhRNEWyFiDKZMwpp3p5s+3UvhY1goAAH9XmKO4GhXm/rGlME7khNAVAPUvc24g+eXPAar2oufQcPDo+QLuIGB2s2Mgs3E/6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oISihzR0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oISihzR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB76C4CEDD;
	Tue, 18 Mar 2025 17:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318981;
	bh=Cio401m5J8j6/Hx5tMo+Hm7yebMVzz/u47TvF8D9QvM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=oISihzR0AuizwReOex7jaJZZM03k3l+Zw4XqdLmkV4B4iG8g7E6NXKw+Yi5JkLtVm
	 0GxZbEDQLdbNYY+cS0Zzsh2Y+/ukVlh6GRPHn4fBhxSES7qtFVb2Uc/fOCrlJN0o1N
	 FVCbvGJAcXKyZEvlAU51nrFnbDarA9uAYk5twZsdqCOfM15xW6o57Pmc+h150HxRxM
	 yWWUPPDpceAdPrKEaAqulRv689PWiuhesiVxd1Lcs3EGgkC7LIpDUg7/rpA/MG2gtO
	 24Gngi+UCIh6jeuefsf4o2ksVRKbnx5GYk5ufPPsy1MwWKGYKFR/13jtoxSDDmVq90
	 A9rxswD53nhVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 08641CE0843; Tue, 18 Mar 2025 10:29:41 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:29:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH] rcu/nocb: Dump gp state even if rdp gp itself is not
 offloaded
Message-ID: <f65f89b2-ce50-471f-b948-5869df69c197@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250318092336.5794-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318092336.5794-1-frederic@kernel.org>

On Tue, Mar 18, 2025 at 10:23:36AM +0100, Frederic Weisbecker wrote:
> When a stall is detected, the state of each NOCB CPU is dumped along
> with the state of each NOCB group. The latter part however is
> incidentally ignored if the NOCB group leader happens not to be
> offloaded itself.
> 
> Fix this to make sure related precious informations aren't lost over
> a stall report.
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Much better, thank you!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_nocb.h  | 3 +++
>  kernel/rcu/tree_stall.h | 3 +--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 4a954ecf1c36..56baa78c6e85 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1564,6 +1564,9 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
>  	if (rdp->nocb_gp_rdp == rdp)
>  		show_rcu_nocb_gp_state(rdp);
>  
> +	if (!rcu_segcblist_is_offloaded(&rdp->cblist))
> +		return;
> +
>  	nocb_next_rdp = list_next_or_null_rcu(&rdp->nocb_gp_rdp->nocb_head_rdp,
>  					      &rdp->nocb_entry_rdp,
>  					      typeof(*rdp),
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 56b21219442b..f96235d51642 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -927,8 +927,7 @@ void show_rcu_gp_kthreads(void)
>  	for_each_possible_cpu(cpu) {
>  		rdp = per_cpu_ptr(&rcu_data, cpu);
>  		cbs += data_race(READ_ONCE(rdp->n_cbs_invoked));
> -		if (rcu_segcblist_is_offloaded(&rdp->cblist))
> -			show_rcu_nocb_state(rdp);
> +		show_rcu_nocb_state(rdp);
>  	}
>  	pr_info("RCU callbacks invoked since boot: %lu\n", cbs);
>  	show_rcu_tasks_gp_kthreads();
> -- 
> 2.48.1
> 
