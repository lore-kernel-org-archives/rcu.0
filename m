Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D591513555;
	Wed, 30 Sep 2026 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786571; cv=none; b=n99DTUBFcTOrlOjmUrqgXoPPM+rQviJ2YOXaYJF8GZBrgRjyfHhLRXByKTObp511CuW7Eins/V1LI61EPqbfo5KvlLF4TBlZ06++cEjXVV7syrI26sMLgaqbYzIh4XVGeokPLzg+UHL+qruJtXf0NAZrwJkcBuvf0idBmuamXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786571; c=relaxed/simple;
	bh=x52tz2MJowBAe+J0Z8YawH5abQ6xtsSiuT5agfRnVKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azWCZe/7T0Pz7jj+W2htHmR9KTLSlRuIUHSv55yFgZEHCddB0JuJPo0cKYif9MpCVSbobpTQmxOAhI0iWSdEAsVHqlOCvgYoMO3QjYVA4Qkzjw8hphSf1/b/LMOzTBN/btUBMPBtPqTrvOFFRMU2aeAtR4P9Cimvyo87YcFbUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhfXjTQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhfXjTQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6A31F000FF;
	Wed, 30 Sep 2026 16:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790786570;
	bh=OsbP1vWAYIH+TLT7k6+ZWFsNQw4uBWUoiKTeshvbXts=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=lhfXjTQIxdzRWCZO/Xy9gs8YEOmCraNpinwKFZSs3WW6vPHueNbJjRjmdh+YQO0VX
	 jMFYP4/qs67fxlKNoumOO0KO4FUA2/H6IXE0qNghdCm+GTWu8OZIH1Bbz3jOJLdB6Z
	 CPPnK5oCvU2Ni/7VZw9x6VpcIUuhny4tCBnfLitOvobANvNvZo+/JqQ0zYY8GXiiej
	 6y5GQLNeSZM7DAZJWszIM6q63/SPOYpIc0dj0CP6hqZPbI6FH2E8dpIJOS8gN0/VYo
	 86Gb3p/jcgShIyGlSB/P9zXMH1xLG55HKK3H+dhcVGgN6aF9joo6XaInrX2zhTmrhe
	 +TeMRYQJ8e5dA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B1317CE097C; Wed, 30 Sep 2026 09:42:49 -0700 (PDT)
Date: Wed, 30 Sep 2026 09:42:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, boqun@kernel.org,
	urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH] rcuscale: add srcu_atomic scale type
Message-ID: <6bafffd8-d253-47d4-a698-b6ee22fbdc3d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260927100359.3903688-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927100359.3903688-1-kunwu.chan@gmail.com>

On Sun, Sep 27, 2026 at 06:03:59PM +0800, Kunwu Chan wrote:
> Add support for scaling atomic SRCU grace periods using
> srcu_read_lock_atomic()/srcu_read_unlock_atomic() and
> synchronize_srcu_atomic().
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Nice, thank you!!!

Some suggestions below.

							Thanx, Paul

> ---
>  kernel/rcu/rcuscale.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 5aca31c3c01d..86f1a912ebee 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -264,6 +264,51 @@ static struct rcu_scale_ops srcu_ops = {
>  	.name		= "srcu"
>  };
>  
> +static struct srcu_struct srcu_atomic_ctlp;

The trailing "p" suggests that this is a pointer, for example, see the
difference between srcu_ctl_scale and srcu_ctlp.  You could make this
consistent with "srcud" and save a few lines of code as follows:

static struct srcu_struct srcua;

> +static int srcu_scale_atomic_read_lock(void)
> +{
> +	return srcu_read_lock_atomic(&srcu_atomic_ctlp);
> +}
> +
> +static void srcu_scale_atomic_read_unlock(int idx)
> +{
> +	srcu_read_unlock_atomic(&srcu_atomic_ctlp, idx);
> +}
> +
> +static void srcu_scale_atomic_synchronize(void)
> +{
> +	synchronize_srcu_atomic(&srcu_atomic_ctlp);
> +}
> +
> +static void srcu_atomic_scale_init(void)
> +{
	srcu_ctlp = &srcua;
> +	init_srcu_struct_atomic(srcu_ctlp);
> +}
> +
> +static void srcu_atomic_scale_cleanup(void)
> +{
> +	cleanup_srcu_struct(&srcu_atomic_ctlp);
> +}

You can then drop srcu_atomic_scale_cleanup() and just use the existing
srcu_sync_scale_cleanup().

> +static unsigned long srcu_atomic_scale_completed(void)
> +{
> +	return srcu_batches_completed(&srcu_atomic_ctlp);
> +}

You can also drop srcu_atomic_scale_completed() and just use the existing
srcu_scale_completed().  Of course, both this and the above require
adjusting the srcu_atomic_ops initializer.

> +static struct rcu_scale_ops srcu_atomic_ops = {
> +	.ptype		= SRCU_FLAVOR,
> +	.init		= srcu_atomic_scale_init,
> +	.cleanup	= srcu_atomic_scale_cleanup,
> +	.readlock	= srcu_scale_atomic_read_lock,
> +	.readunlock	= srcu_scale_atomic_read_unlock,
> +	.get_gp_seq	= srcu_atomic_scale_completed,
> +	.gp_diff	= rcu_seq_diff,
> +	.exp_completed	= srcu_atomic_scale_completed,
> +	.sync		= srcu_scale_atomic_synchronize,

You can also then do this to get more debug data:

	.stats		= srcu_scale_stats,

> +	.name		= "srcu_atomic"

Then this could be "srcua".  Or maybe more typing on the rcuscale
scale_type module parameter is OK.  If so, maybe we should change
"srcud" to "srcu_dynamic", but this would require quite a few other
changes as well.  (At least if we want the rcutorture names to be
consistent.)

Thoughts?

> +};
> +
>  static struct srcu_struct srcud;
>  
>  static void srcu_sync_scale_init(void)
> @@ -1176,7 +1221,7 @@ rcu_scale_init(void)
>  	long i;
>  	long j;
>  	static struct rcu_scale_ops *scale_ops[] = {
> -		&rcu_ops, &srcu_ops, &srcud_ops,
> +		&rcu_ops, &srcu_ops, &srcu_atomic_ops, &srcud_ops,
>  		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
>  		HAZPTR_SCALE_OPS
>  	};
> -- 
> 2.43.0
> 
