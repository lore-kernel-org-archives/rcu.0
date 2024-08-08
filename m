Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0120233F7;
	Thu,  8 Aug 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140089; cv=none; b=LDXSrfdQq+2tdh5fJYnYjERk38xW7PWlDMNrC3/KvEywnqfxWz8PAxxNJQFen0J5UPs4hj7p+a2CaIk/3insVITfwWy15nE8Se1mJXPfPQPQRwJ/dNjmCKKhqzJH/9+zj0uSXyMD5B5jXtTSKdKqatGPSpsX66MRaNuOlNAqPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140089; c=relaxed/simple;
	bh=CVp2GLuewmyFFc6NwbWeOoPtNl/w7OIBR0Cgbit0W2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vg1me+IKJhVdDmSyKeMsQgiWvfCN+HhsESW9aQkD0S7TfN/kxTet5i+K8yOod703eP9rIxx0qtisN/La5J1GbyiqYgFWArDtW4XUwoRe3hAVYCJ37Lz3MIylReOvSZEX/nUANUEK1mbGj+mub1MqCulhCS9QYVO2PvC8GvR6FXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDBJ1sfr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDBJ1sfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82347C32782;
	Thu,  8 Aug 2024 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723140088;
	bh=CVp2GLuewmyFFc6NwbWeOoPtNl/w7OIBR0Cgbit0W2Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sDBJ1sfrjhefk3YF6t1zqBKAptt/vxIq4dByYx+HHER+0NfKNloS1b37cLsXmvek2
	 ZkgMAy8IDeNBlZzTbyZBi+cxA7ZEtTs+gvyfE+U3omkcwBnHdwPHIZp3MXUaugIRDe
	 ck6xsDWJfkJaqQ/Brl7QIVZy+XUg+aiTPZm4Wnu5Mh8XcrXrXCdDvWtG1bwg8AZtkq
	 BbFvow7vzQwCO6TnLXHEtkoWRfY1ZTNfNa/ryxrRpKJDMWzAS/Nff7EDzrX0tD5srP
	 tqXzsRLqTyoF1ObZr1USse3b0K6h5eLyJ8f2C0y0/Gyi0szTmjWR2oy0SVfdRUm8Mt
	 B6iyR9XT/wEpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 32E27CE09DB; Thu,  8 Aug 2024 11:01:28 -0700 (PDT)
Date: Thu, 8 Aug 2024 11:01:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	joel@joelfernandes.org, frederic@kernel.org, boqun.feng@gmail.com,
	urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, neeraj.iitr10@gmail.com
Subject: Re: [PATCH 2/2] context_tracking: Invoke Tasks-RCU enter/exit for
 NMI context
Message-ID: <8eac856d-0b09-4f5e-939d-b24d6fad8311@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240807163506.434885-1-neeraj.upadhyay@kernel.org>
 <20240807163506.434885-3-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807163506.434885-3-neeraj.upadhyay@kernel.org>

On Wed, Aug 07, 2024 at 10:05:06PM +0530, neeraj.upadhyay@kernel.org wrote:
> From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> 
> rcu_task_enter() and rcu_task_exit() are not called on NMI
> entry and exit. So, Tasks-RCU-Rude grace period wait is required to
> ensure that NMI handlers have entered/exited into Tasks-RCU eqs.
> For architectures which do not require Tasks-RCU-Rude (as the code
> sections where RCU is not watching are marked as noinstr), when
> those architectures switch to not using Tasks-RCU-Rude, NMI handlers
> task exit to eqs will need to be handled correctly for Tasks-RCU holdout
> tasks running on nohz_full CPUs. As it is safe to call these two
> functions from NMI context, remove the in_nmi() check to ensure that
> Tasks-RCU entry/exit is marked correctly for NMI handlers.

This last sentence could be broken up.  ;-)

Other than that, looks good!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> ---
>  kernel/context_tracking.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 152b485a62db..626dd7a173a5 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -239,8 +239,7 @@ void noinstr ct_nmi_exit(void)
>  	ct_kernel_exit_state(CT_RCU_WATCHING);
>  	// ... but is no longer watching here.
>  
> -	if (!in_nmi())
> -		rcu_task_exit();
> +	rcu_task_exit();
>  }
>  
>  /**
> @@ -273,8 +272,7 @@ void noinstr ct_nmi_enter(void)
>  	 */
>  	if (!rcu_is_watching_curr_cpu()) {
>  
> -		if (!in_nmi())
> -			rcu_task_enter();
> +		rcu_task_enter();
>  
>  		// RCU is not watching here ...
>  		ct_kernel_enter_state(CT_RCU_WATCHING);
> -- 
> 2.40.1
> 
