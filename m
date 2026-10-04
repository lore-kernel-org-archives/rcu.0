Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E491FB1;
	Sun,  4 Oct 2026 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791073024; cv=none; b=AK3lFYpA3mqTvuvPOnS2R0ti0wjTktVdF/u81JT9cCsbNZc2jIolMkLt1a0XnJrHbT8ELxq7tLuMpxR5Y6hxVZ8+kTqs+cClyjXCL0ty1vprOFUaLBRWhvVS1Cazgd8qC0rsvn5/2ZRTDUQmEoEHVvWHHtYrdKhEsxdCedYMZQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791073024; c=relaxed/simple;
	bh=QwPx0hRDcObW7PfhIUc5+6PwUltypAH+jdVDo3Om/gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK1oXY/2FRaPTCrvmUZ1lXUW6+7cVTJj/Huxhv7hn/+wP8wzDFrICkzbM2Kc7MdneQhYmqBj+1GxmudvMSYKCysHQMqHcko43jgSaFPXySwhLj6SS9EIBYgSDb5e8V5z4Y2jIXBL75vOvUVmTuDym0fLwsA7Boo78P6NbFb9DEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/yKHVeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/yKHVeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E531F0089B;
	Sun,  4 Oct 2026 00:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791073022;
	bh=f0X55k1JjyZmnpTVYm2uh+cKq8TEASg4b9fJw48Vv8k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=U/yKHVeL8XHRcEr60nsO4bv/yZckU6MfB/7U1Ftr3bJR8xPDT2YttyctjtK0qCVef
	 D04+Kzbq2m/UClrBSH2Ytqkc9NyYfDw96s3CCOMIZdePz3/VLsODTJLkxEhoO22tf4
	 VWJQnGN7xcjsdYbkyL84vRR+xARl3zzhkn1VWgLeNYlHoVJDZq9gcsh/GwqQJfbVpJ
	 wqybdEO7RECabHL0K9JkID0fTAv93KNaGfHt/g775R3d6XuVYaaaHERUzTnZNfBGp5
	 nG/97tdBz1RCL2I6d9JOKbLvRE+9QqckO54Dp4XjF1LHXSb9BuSL1WPbGicktG8gqi
	 pRD0wPFQ7i3Tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7AB35CE39A4; Sat,  3 Oct 2026 17:17:02 -0700 (PDT)
Date: Sat, 3 Oct 2026 17:17:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, boqun@kernel.org,
	urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcuscale: add srcua scale type
Message-ID: <e148f43b-b41c-410f-b699-e7b033f91029@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261003161720.240855-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003161720.240855-1-kunwu.chan@gmail.com>

On Sun, Oct 04, 2026 at 12:17:19AM +0800, Kunwu Chan wrote:
> Add support for scaling atomic SRCU grace periods using
> srcu_read_lock_atomic()/srcu_read_unlock_atomic() and
> synchronize_srcu_atomic().
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Queued for testing and further review, thank you!!!

							Thanx, Paul

> ---
> Changes since v1:
> - Rename srcu_atomic_ctlp to srcua and reuse srcu_ctlp for
>   SRCU operations, as suggested by Paul.
> - Reuse the existing SRCU cleanup and completed helpers by
>   initializing srcu_ctlp in srcu_atomic_scale_init().
> - Add .stats using srcu_scale_stats().
> - Use "srcua" to match the existing "srcu" and "srcud" scale
>   type names.
> - Use synchronize_srcu_atomic() for both normal and expedited
>   scale tests.
> 
> v1: https://lore.kernel.org/all/20260927100359.3903688-1-kunwu.chan@gmail.com/
> Tested with kvm.sh --torture rcuscale scale_type=srcua on x86_64 and
> arm64, alongside gp_exp=1 and PROVE_LOCKING=y: no warnings or lockdep
> splats.
> ---
>  kernel/rcu/rcuscale.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 1097ec15879c..b172882824ac 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -293,6 +293,44 @@ static struct rcu_scale_ops srcud_ops = {
>  	.name		= "srcud"
>  };
>  
> +static struct srcu_struct srcua;
> +
> +static int srcu_scale_atomic_read_lock(void)
> +{
> +	return srcu_read_lock_atomic(srcu_ctlp);
> +}
> +
> +static void srcu_scale_atomic_read_unlock(int idx)
> +{
> +	srcu_read_unlock_atomic(srcu_ctlp, idx);
> +}
> +
> +static void srcu_scale_atomic_synchronize(void)
> +{
> +	synchronize_srcu_atomic(srcu_ctlp);
> +}
> +
> +static void srcu_atomic_scale_init(void)
> +{
> +	srcu_ctlp = &srcua;
> +	init_srcu_struct_atomic(srcu_ctlp);
> +}
> +
> +static struct rcu_scale_ops srcua_ops = {
> +	.ptype		= SRCU_FLAVOR,
> +	.init		= srcu_atomic_scale_init,
> +	.cleanup	= srcu_sync_scale_cleanup,
> +	.readlock	= srcu_scale_atomic_read_lock,
> +	.readunlock	= srcu_scale_atomic_read_unlock,
> +	.get_gp_seq	= srcu_scale_completed,
> +	.gp_diff	= rcu_seq_diff,
> +	.exp_completed	= srcu_scale_completed,
> +	.sync		= srcu_scale_atomic_synchronize,
> +	.exp_sync	= srcu_scale_atomic_synchronize,
> +	.stats		= srcu_scale_stats,
> +	.name		= "srcua"
> +};
> +
>  #ifdef CONFIG_TASKS_RCU
>  
>  /*
> @@ -1110,7 +1148,8 @@ rcu_scale_init(void)
>  	long i;
>  	long j;
>  	static struct rcu_scale_ops *scale_ops[] = {
> -		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> +		&rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
> +		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
>  	};
>  
>  	if (!torture_init_begin(scale_type, verbose))
> 
> base-commit: d21906b0aa1e9573cdb5e7acaca44966b9d1dcd2
> -- 
> 2.43.0
> 
