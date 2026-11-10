Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269375;
	b=3Da9WDyNlAMNhEKKAhTgXkIJkxiRNmw4PR6kSMvxRP/nM7Z7rDW90c6mK80eB6me8oHR
	 qSt+m57ezCyvx0xvN2SHQdK1nO52B+RsK8ixlHDHbl3/xnAq2yCMqPMBfP8VFiLuUQkPl
	 I7GX1MqGOiAxwA2pX8apS3Dxcyl2i+ozBwCxf/vaweIemKOT5GnYqueE17G96gW7UaYn9
	 BTT/7qX0T6Zp2CYrbxL3z8CS/6seWUb6ADWGuDfNZtJw2Vqvsls5QPm2CWCjlJcjckoXB
	 O+SYTqBbQiPub2RFgiqbfUkEmr5+ECqTSZvjJM3okPGyMCYypVWKpbcjnQt5Sd7p07A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269375;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=zz/y8Al2fvS+ck7SHQ75UQyOO0qUgFsq890s/WnyAZA=;
	b=stVAO8tLpw1OgrNFeiVWvjpAAUy5ez8A16HXzp2/XfbPysxdcALl/3R3LLZi/X8rjq8k
	 MVxjwwURzb7BL/KepzBFsUvlp9uj/qljy6DYiIp73SPcHEvc0h007fp/z5i+e0Y5WGnLI
	 acZM/WwTAYc2X6QxqfQWGWXRoU2dxK9FnQZxjiFjBzKCuWyGanu34u5kpTysYJfB1PJiP
	 eI+Kxvy4jUJdZDqxzaSOclp/u2Y1BtkyGQj+hq7NhqUv5lb9FwiedDdfnx1dQfGorq/Cy
	 JkSEQJrpWAATSrxU/Es4jhJNpVmPAWS4bTP32+DNfVfND/TrqC+4YbwS5fzZerIJ/Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5xLVplx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC656606A31C;
	Tue, 10 Nov 2026 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5xLVplx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65051F008A1;
	Tue, 10 Nov 2026 00:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794269374;
	bh=zz/y8Al2fvS+ck7SHQ75UQyOO0qUgFsq890s/WnyAZA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Y5xLVplxHiVTZxyZL6FIyaQAGzYh1HV1CqbvjT+Fb7IVXRNhCLiTo/TsWvemrei6u
	 QncjriJFGKtCRDE183zBO7cEnRHuRzeEuhxmO+KDLPCwD+94SLWyOYJrcAR1ojW5L9
	 99CVmqQizVNCfo2J6saayg1XmbFhLNxUkB2yqxeXYU9va4cDEyEsw72cQFgdKTzdvf
	 Dq3xdCDzeTtVWEO11Rb+eIAwupI5vb+ctHHFGHstArq8R3YCW7L+ZA10FxcOpiSjgH
	 /9UJEMl4yX0syoCCkvtrlPeTNKWoATx3aK2wuIGYVCqBrgNAr9aZl75NY7lgfYJ7uH
	 jz/c6NtFRpHrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7CBA7CE0C97; Mon,  9 Nov 2026 16:09:34 -0800 (PST)
Date: Mon, 9 Nov 2026 16:09:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org
Subject: Re: [PATCH v2 3/5] scftorture: Protect the initial affinity check
 from hotplug
Message-ID: <5e9b466c-4ab4-4857-ba49-3fdf5820f772@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261109000243.3936824-1-joelagnelf@nvidia.com>
 <20261109000243.3936824-4-joelagnelf@nvidia.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109000243.3936824-4-joelagnelf@nvidia.com>

On Sun, Nov 08, 2026 at 07:02:39PM -0500, Joel Fernandes wrote:
> An invoker binds to its target CPU, sleeps for the holdoff interval, and
> then warns if it is running elsewhere. CPU hotplug can offline the target
> during that sleep and legitimately move the invoker. A built-in test with
> matching worker and hotplug holdoffs reproduces this warning.
> 
> Check the initial binding while holding cpus_read_lock(), before sleeping.
> If the target is already offline, let the existing offline/rebind path
> handle it instead of warning about an impossible initial binding. Release
> the read lock before the holdoff and test loop so hotplug remains tested.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Good catch!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/scftorture.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/scftorture.c b/kernel/scftorture.c
> index ff9a8271a464..64ee2c5cf51c 100644
> --- a/kernel/scftorture.c
> +++ b/kernel/scftorture.c
> @@ -479,19 +479,24 @@ static int scftorture_invoker(void *arg)
>  
>  	VERBOSE_SCFTORTOUT("scftorture_invoker %d: task started", scfp->cpu);
>  	cpu = scfp->cpu % nr_cpu_ids;
> -	WARN_ON_ONCE(set_cpus_allowed_ptr(current, cpumask_of(cpu)));
> +	cpus_read_lock();
> +	if (cpu_online(cpu)) {
> +		WARN_ON_ONCE(set_cpus_allowed_ptr(current, cpumask_of(cpu)));
> +		/* Check affinity before hotplug can move this task away. */
> +		curcpu = raw_smp_processor_id();
> +		WARN_ONCE(curcpu != cpu,
> +			  "%s: Wanted CPU %d, running on %d, nr_cpu_ids = %d\n",
> +			  __func__, scfp->cpu, curcpu, nr_cpu_ids);
> +	} else {
> +		was_offline = true;
> +	}
> +	cpus_read_unlock();
>  	set_user_nice(current, MAX_NICE);
>  	if (holdoff)
>  		schedule_timeout_interruptible(holdoff * HZ);
>  
>  	VERBOSE_SCFTORTOUT("scftorture_invoker %d: Waiting for all SCF torturers from cpu %d", scfp->cpu, raw_smp_processor_id());
>  
> -	// Make sure that the CPU is affinitized appropriately during testing.
> -	curcpu = raw_smp_processor_id();
> -	WARN_ONCE(curcpu != cpu,
> -		  "%s: Wanted CPU %d, running on %d, nr_cpu_ids = %d\n",
> -		  __func__, scfp->cpu, curcpu, nr_cpu_ids);
> -
>  	if (atomic_dec_return(&n_started))
>  		while (atomic_read_acquire(&n_started)) {
>  			if (torture_must_stop()) {
> -- 
> 2.54.0
> 
