Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2C263F38;
	Mon, 24 Feb 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422464; cv=none; b=Pz2nLl8mmpuMt1jcmcR/X+kCmQSb5qynn/A/iVufhDBVbZ72fTgJsOmGqltumQTIVVNkd8k8klT51mOR+MblV4YFm4gMxO8z07KFiMqiHFA4R5WgdNHuXYP6ZS00IcDMUyrLhpP/WwUqxJB+9sMhBZWaClLs7C2FOJhxdpfrIcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422464; c=relaxed/simple;
	bh=toZBez88pp0GSlIulNK+mmppe7L3IN4CHlOgLa82MFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX3lgx4uaQ0AT4j/4iTSNU7xGqXgzyh6zmkWE9l2Sf3wVy2f0eZ04CnRoEnbNSrK56B2NBEClqaWFbGiy2KrVnx5z6AAG1cqfSJA5ZAgQtj1SqA54ivsbN9sDxtbMW1sDsttNXcQPPdJN8e+TsyXl1b47db5QlJltWudyjMsRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsISFWg3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsISFWg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4543C4CED6;
	Mon, 24 Feb 2025 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740422463;
	bh=toZBez88pp0GSlIulNK+mmppe7L3IN4CHlOgLa82MFE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GsISFWg3DgNOgq4J3YCLP9RtPmITufle3L/vr3ZDD405jNU3VgB+k3ykr6/zoLEPh
	 LW7FeXuR2EjW09LHx59iPyCJe6VlryCZH8UUql9R6kesU0A6NAvjdZnDyL8ee9b1ZP
	 OfTMXdyZLWgya+Z22QLSNyvSyFiqkyIuvI31ISfaxoTYOWCWqhFiIb2p0wAcgSfHXB
	 goHDD+zZ+RssIjDEa014BkckulKNXsJ9eue2HWfxqZz3faoun/iOGYq+t85/Do5qaj
	 jF/CfZLSzdvXKzGwkTgYKZo+0zqoQPOqyMPUXV0fOaUULlIRLB5+EI3mYqazDK0rFR
	 askJt/ri62qzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 882EECE0B34; Mon, 24 Feb 2025 10:41:03 -0800 (PST)
Date: Mon, 24 Feb 2025 10:41:03 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 1/3] rcutorture: Allow a negative value for
 nfakewriters
Message-ID: <c299a0b1-3271-4229-bdb9-2d4904ac0e13@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250224133659.879074-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224133659.879074-1-urezki@gmail.com>

On Mon, Feb 24, 2025 at 02:36:57PM +0100, Uladzislau Rezki (Sony) wrote:
> Currently "nfakewriters" parameter can be set to any value but
> there is no possibility to adjust it automatically based on how
> many CPUs a system has where a test is run on.
> 
> To address this, if the "nfakewriters" is set to negative it will
> be adjusted to num_online_cpus() during torture initialization.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index d98b3bd6d91f..f376262532ce 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -148,6 +148,7 @@ MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
>  
>  static int nrealnocbers;
>  static int nrealreaders;
> +static int nrealfakewriters;
>  static struct task_struct *writer_task;
>  static struct task_struct **fakewriter_tasks;
>  static struct task_struct **reader_tasks;
> @@ -1763,7 +1764,7 @@ rcu_torture_fakewriter(void *arg)
>  	do {
>  		torture_hrtimeout_jiffies(torture_random(&rand) % 10, &rand);
>  		if (cur_ops->cb_barrier != NULL &&
> -		    torture_random(&rand) % (nfakewriters * 8) == 0) {
> +		    torture_random(&rand) % (nrealfakewriters * 8) == 0) {
>  			cur_ops->cb_barrier();
>  		} else {
>  			switch (synctype[torture_random(&rand) % nsynctypes]) {
> @@ -2568,7 +2569,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
>  		 "nocbs_nthreads=%d nocbs_toggle=%d "
>  		 "test_nmis=%d "
>  		 "preempt_duration=%d preempt_interval=%d\n",
> -		 torture_type, tag, nrealreaders, nfakewriters,
> +		 torture_type, tag, nrealreaders, nrealfakewriters,
>  		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
>  		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
>  		 test_boost, cur_ops->can_boost,
> @@ -3644,7 +3645,7 @@ rcu_torture_cleanup(void)
>  	rcu_torture_reader_mbchk = NULL;
>  
>  	if (fakewriter_tasks) {
> -		for (i = 0; i < nfakewriters; i++)
> +		for (i = 0; i < nrealfakewriters; i++)
>  			torture_stop_kthread(rcu_torture_fakewriter,
>  					     fakewriter_tasks[i]);
>  		kfree(fakewriter_tasks);
> @@ -4066,6 +4067,14 @@ rcu_torture_init(void)
>  
>  	rcu_torture_init_srcu_lockdep();
>  
> +	if (nfakewriters >= 0) {
> +		nrealfakewriters = nfakewriters;
> +	} else {
> +		nrealfakewriters = num_online_cpus() - 2 - nfakewriters;
> +		if (nrealfakewriters <= 0)
> +			nrealfakewriters = 1;
> +	}
> +
>  	if (nreaders >= 0) {
>  		nrealreaders = nreaders;
>  	} else {
> @@ -4122,8 +4131,9 @@ rcu_torture_init(void)
>  					  writer_task);
>  	if (torture_init_error(firsterr))
>  		goto unwind;
> -	if (nfakewriters > 0) {
> -		fakewriter_tasks = kcalloc(nfakewriters,
> +
> +	if (nrealfakewriters > 0) {
> +		fakewriter_tasks = kcalloc(nrealfakewriters,
>  					   sizeof(fakewriter_tasks[0]),
>  					   GFP_KERNEL);
>  		if (fakewriter_tasks == NULL) {
> @@ -4132,7 +4142,7 @@ rcu_torture_init(void)
>  			goto unwind;
>  		}
>  	}
> -	for (i = 0; i < nfakewriters; i++) {
> +	for (i = 0; i < nrealfakewriters; i++) {
>  		firsterr = torture_create_kthread(rcu_torture_fakewriter,
>  						  NULL, fakewriter_tasks[i]);
>  		if (torture_init_error(firsterr))
> -- 
> 2.39.5
> 
