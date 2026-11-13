Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587813;
	b=JCcDw69rWV1ny1RAzcmlpqNdQJBkEtKULaXhpVik4goznQCMk1dt8CxCNagrDk5++38F
	 Qj711XFmso2AgojTIOQT44H1py79psqTkUePPJafPrPK4Bn2IfR0yMZ+OZWbGmD/Ybedm
	 x87Ldhj3JrEgZ25dqSno7kXP1ZSz9zM4HGcOw5mIxvEZsRL0nKydEGV7d7jXfRuZn6C3f
	 YUyauXAV3NKu/E28wi8ySUt2sGz2mqCUccdqRd9WbQFmcBS9E/M0/IL6uKHd1Lo45G6SI
	 LPqfMMxiGWsgslHFOH1+QiC+kabIFyMZHRfKIADlr5PIpMxr+4MMuEYZow2DaGP+7fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587813;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=W0073ALJig0hMJYwab+InzC0jgWWQhNHsIl2BaOpc4k=;
	b=VaSJqTiAc0D/pcskwlzUJibmoR3c3hqu19QcYLlZrnZqkEVUEGXe9EG8bKIchEC/uh6l
	 Sl1LK6ycvIqCVQqFgovt30iXzwNnMzfLYrZBEJeXmREXeztZcVnEoU1UKAHl2oBZhReyL
	 2YT9LQdBz/e6jwtnuYSX1c/MoLba+WZx7K30AvEkdfgBG2XCfbsvecXEa1OaeTzutoesk
	 tVL5x7oQeUSZYMFK8sWW4h+/QeTtgalIyItvIOx7tEY3pXQbg4O9LK/A/qsUOJEQvjIl5
	 ChtE4xAhQLZkDHJ3pHpTrV2pcStUITJ7wJkWYcb+wdf31xCnZRZBHFIOgPCyHaQ7Asg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=R1GKYOCs;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=g4cNNxiP;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9FC606A323;
	Fri, 13 Nov 2026 16:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C9FC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=R1GKYOCs;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=g4cNNxiP
Date: Fri, 13 Nov 2026 17:36:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794587809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W0073ALJig0hMJYwab+InzC0jgWWQhNHsIl2BaOpc4k=;
	b=R1GKYOCsZa5n9FFnsbM0LFknAZHzWH1x1tXSLHs8OH40lTClLpnJF0GLi4+JttsIpiFBNF
	2IbiKrE+UgXAH0OEfDaawxZpbCBstl0oOBFdFv2LwtPVe/XC1xKqDziefyGXA9WSEozBlh
	ONaUHy7IaQ+DA+p2D8/nmscDlHS3Vxv+PNr1IARDOm+iY6DvKOi91FK94ukS5XGhy2+lua
	rmEagEaHKPlylq6iC6WKRrp095vNd9FPh/tQaIV/EOst89kYxqcb1Qv9/lgIAufnsCSMvf
	ecoEo86jFdNY/YSSVWLjsKQd//+LCErac69kNuyfekUARj91f0yQ4NGcOOJquw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794587809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W0073ALJig0hMJYwab+InzC0jgWWQhNHsIl2BaOpc4k=;
	b=g4cNNxiPjikLIqtG448C3HF4/MmQKqJMYOMCVFurPsXXcwvn0POibBP7qBawynCQxZUT8y
	waDBRi8dBnS77fDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 5/7] rcu: Add rcutree.boost_disable to disable
 priority boosting at runtime
Message-ID: <20261113163647.OrW62pCV@linutronix.de>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
 <20261111213826.2035045-6-joelagnelf@nvidia.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111213826.2035045-6-joelagnelf@nvidia.com>

On 2026-11-11 16:38:23 [-0500], Joel Fernandes wrote:
> CONFIG_RCU_BOOST is now enabled automatically for preemptible RCU and
> cannot be turned off, so rcutorture's BUSTED-BOOST scenario, which is
> meant to show that rcutorture detects broken priority boosting, can no
> longer break it.  Add a boot parameter that makes rcu_initiate_boost()
> do nothing, giving that scenario a way to break boosting.

It has:
|         depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT
|         default y if PREEMPT_RT

which I read as always enable on PREEMPT_RT and on PREEMPT_RCU only with
RCU_EXPERT enabled which off by default.
But BUSTED-BOOST always enabled RCU_EXPERT which means it is always
enabled. Hmm.

> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1270,6 +1270,9 @@ static int rcu_boost_kthread(void *arg)
>  	return 0;
>  }
>  
> +static bool boost_disable;
> +module_param(boost_disable, bool, 0444);
> +
>  /*
>   * Check to see if it is time to start boosting RCU readers that are
>   * blocking the current grace period, and, if so, tell the per-rcu_node
> @@ -1284,7 +1287,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
>  	__releases(rnp->lock)
>  {
>  	raw_lockdep_assert_held_rcu_node(rnp);
> -	if (!rnp->boost_kthread_task ||
> +	if (boost_disable || !rnp->boost_kthread_task ||

Could you instead make this a parameter of rcutorture (and not rcu's)
and then check it behind IS_ENABLED(CONFIG_RCU_TORTURE_TEST)?
That way non-testing code does not have this additional read and the
variable parameter and so on.

Maybe tell rcu_spawn_one_boost_kthread() not to populate the tread this
thread in case.

>  	    (!rcu_preempt_blocked_readers_cgp(rnp) && !rnp->exp_tasks)) {
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  		return;

Sebastian
