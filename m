Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511686;
	b=25R1Id6+JmRQ4E0+T7KrkXzdAoweQfS0OZsAJfOlMMFRCkjOkVOGTrlui6kEDOx90mWe
	 zhkgaQNtW/pxfNlcUlBFepqa7Czb/BBrAUc3ksrSh1iv8R2qYYGjkY1/R8LM/kRTepckj
	 VpOU7zevh/1EF3yUiP1O6R16j//8jPbCtOYQnbscRu+nf9j2nw3f85lbLXB5IRpHFWlGB
	 YiIykA9BW45+UKlbLjryUwnoPNbWi0sjIVcWzRKLTytCByZZaQkvOKnK6MMj7n31A4aW5
	 Ci6r/h6AsP/FtIx8OnZW3RrpEd88WTzdL3n/aMAm0R0T7BAVNtFcpYajbRB7dgjbE6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511686;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Wp0urfq61yNXrOEhEx3kr5H9rFjj647tUQQ+T0MMReU=;
	b=t+pI8I30rG9PKXmWNARe9oWFGu+a30lApiMV765bzaYZgYiOo+VKxquY4/EaihX5cO7m
	 ILrDrMH0RKF7Xfik48UHX0Pk9+wm1oKN6xhgin5IZfpDfmEtyPZ49509I9m8fKJtOIwBG
	 lw0vzAcxXDBBv+dSIVVWX+oWQ6o+lZRl4LGPnMHf63UPHnf0S+cuDmfEkw+7vELxOREg/
	 a8fkdqd3sDQHbTsK/2ZiuVcm6GtLHBImPBsEhgHlZBc6PqEuQUxKX3szrNS3Sw6RJRxje
	 QAXhUAXYmjBNwp03Fn5YPOXwtjJJ5FISG3s0E/rE134u2b4CBUV0ZFVzvNs68fpPVbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSXo8Uyl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23302606A327;
	Thu, 12 Nov 2026 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSXo8Uyl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1C31F000C5;
	Thu, 12 Nov 2026 19:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794511686;
	bh=Wp0urfq61yNXrOEhEx3kr5H9rFjj647tUQQ+T0MMReU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=gSXo8Uyl/WPN5vlQICWamKQIdubeL88aAuQUlTRh4JJc0Ulvy/kgTt7OnwngztVEu
	 qb65h0Q+7M1e6R3jqvigw7CIn+RqcBy35OaKavUkNU//Jt04xk87jua86vjtAi58Bk
	 1JpZAPb3/4OHnfydKqvoiZ7JofZnW92oO9KLua62SFpSnf6yZnsr9Cj9vNXgxScNdX
	 Rgph/Eb29Xk4Od382Nser80pc/UutRXX5M/1QqXMtARkVmLaDuPLj5/7j5SEZ3TYMF
	 1ML//C4uUWSqI/2YLKLtnsy/rKK5T+bq5oTo3i6ACAa5kjCfQFg3t1gow/noGnq+9I
	 rqao2P/ZNC64w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ADFD6CE0840; Thu, 12 Nov 2026 11:28:05 -0800 (PST)
Date: Thu, 12 Nov 2026 11:28:05 -0800
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
Subject: Re: [PATCH] torture: Forgive SMT-control failures in CPU-hotplug
 testing
Message-ID: <f5775bef-72ad-4d76-87d2-dc5d23fb96ca@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261112175220.767903-1-joelagnelf@nvidia.com>
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
In-Reply-To: <20261112175220.767903-1-joelagnelf@nvidia.com>

On Thu, Nov 12, 2026 at 12:52:20PM -0500, Joel Fernandes wrote:
> The onoff task ends rcutorture with "End of test: RCU_HOTPLUG" if any
> CPU-hotplug attempt fails, other than -EBUSY during boot.  Toggling
> /sys/devices/system/cpu/smt/control while onoff runs causes two failures
> that are not the test's fault.  cpu_up() returns -EPERM for an SMT thread
> that SMT control keeps offline, and device_online() and device_offline()
> return 1 when the toggle already did the operation.
> 
> Repro: in a 16-vCPU guest (8 cores, 2 threads), run
> "modprobe rcutorture onoff_interval=1 gp_exp=0" while looping
> "echo off/on > smt/control" for 120 seconds.  This ended in RCU_HOTPLUG,
> with no reader errors.  With this change it ends in SUCCESS.
> 
> Forgive these like boot-time -EBUSY, by not counting the attempt.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/torture.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 8c4e6b2fe8ba..b860c99e9ca7 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -194,6 +194,24 @@ int torture_num_online_cpus(void)
>  }
>  EXPORT_SYMBOL_GPL(torture_num_online_cpus);
>  
> +/*
> + * If the CPU-hotplug failure is not the torture test's fault, return a
> + * string saying why it is forgiven.  Otherwise, return NULL.
> + */
> +static const char *torture_onoff_forgive(int ret)
> +{
> +	// PCI probe frequently disables hotplug during boot.
> +	if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY)
> +		return " (-EBUSY forgiven during boot)";
> +	// Hotplug is forbidden, for example by SMT control.
> +	if (ret == -EPERM)
> +		return " (-EPERM forgiven, hotplug forbidden)";
> +	// Something else, such as SMT control, already did the operation.
> +	if (ret == 1)
> +		return " (already in requested state, forgiven)";
> +	return NULL;
> +}
> +
>  /*
>   * Attempt to take a CPU offline.  Return false if the CPU is already
>   * offline or if it is not subject to CPU-hotplug operations.  The
> @@ -204,7 +222,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
>  {
>  	unsigned long delta;
>  	int ret;
> -	char *s;
> +	const char *s;
>  	unsigned long starttime;
>  
>  	if (!cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
> @@ -220,12 +238,11 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
>  	(*n_offl_attempts)++;
>  	ret = remove_cpu(cpu);
>  	if (ret) {
> -		s = "";
> -		if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY) {
> -			// PCI probe frequently disables hotplug during boot.
> +		s = torture_onoff_forgive(ret);
> +		if (s)
>  			(*n_offl_attempts)--;
> -			s = " (-EBUSY forgiven during boot)";
> -		}
> +		else
> +			s = "";
>  		if (verbose)
>  			pr_alert("%s" TORTURE_FLAG
>  				 "torture_onoff task: offline %d failed%s: errno %d\n",
> @@ -266,7 +283,7 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
>  {
>  	unsigned long delta;
>  	int ret;
> -	char *s;
> +	const char *s;
>  	unsigned long starttime;
>  
>  	if (cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
> @@ -280,12 +297,11 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
>  	(*n_onl_attempts)++;
>  	ret = add_cpu(cpu);
>  	if (ret) {
> -		s = "";
> -		if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY) {
> -			// PCI probe frequently disables hotplug during boot.
> +		s = torture_onoff_forgive(ret);
> +		if (s)
>  			(*n_onl_attempts)--;
> -			s = " (-EBUSY forgiven during boot)";
> -		}
> +		else
> +			s = "";
>  		if (verbose)
>  			pr_alert("%s" TORTURE_FLAG
>  				 "torture_onoff task: online %d failed%s: errno %d\n",
> -- 
> 2.54.0
> 
> 
