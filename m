Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081550;
	b=MdbkJ2slv0UOlm6aE+OntDnUFyYxlCBavbG1RYWMEy4JTH3yV5Sj4D3q/v0o9+qS78I2
	 kXgwnOXM2OON314P5z+wnp6yAMBU6FR6rkbfUcHhmFmooP2e3g4CYYQId4md6axOiCaHn
	 JBp4GL3rZfxOih1PjIQBOLl7+/T9X8m33qDHrQo8aBntmjNWWDK+WefhmKrqoTerohdb7
	 uZpM1VwA/MWkmyaT0Xm73zKbnREfwPfIRTn3GVvdCfocWqfgvIwDL/J2g+LNPby2lkbia
	 qgfxejkwiFbJx+mbmy9uw1xlb81xF0GrIDspStum3IvRNMcDbObnN33oRdAYECd3f9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081550;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=/9nKjusmABPy2ntroGY1Ws7SpbD9n/CmrvgD7HW1p4k=;
	b=d+9Q6BP6WKw5ebQ/gHg9OLbpqJew7g2XVC4QIjJRk06Tt/Co1+xFBQ5JyMtbsqISrpDq
	 Qdsh/ZseOtITPDuOpEDiI8QFDl4QQAr4ETWc0DXFH4Mz3Xc/V9b+fUbkHSMen4l9U7iZT
	 l2kTLfmY5+gyxBkacz6gj2YzxFmU2heFSKTYn4YJz9LCuSsASZRIS2+8bpiPJ0bDyU3n1
	 e0Io40+dvARYy0RsVY4nZ3hi3oXGbWA+tej4PVoztsKi994pVo56/NaICA7bU8uJCLnwS
	 wdsKDe+3aLjvuYA5gh4uiMugf5KvBIa+ACeQd5FCtPVeU6B5xT2F3AKs/eshRImFBLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=F66lCS2Z;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=nt3pbzXA;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD49960A2608;
	Thu, 19 Nov 2026 09:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD49960A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=F66lCS2Z;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=nt3pbzXA
Date: Thu, 19 Nov 2026 10:45:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795081546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/9nKjusmABPy2ntroGY1Ws7SpbD9n/CmrvgD7HW1p4k=;
	b=F66lCS2ZtGEFFfBUcBgGzCMrhZvPH1x8LxF3LW8H0XkB0MKeR/O0BEygRurKc06FGcKoDz
	OFt7PULoA0oLZzyMonEwxb6iCn4JROzFmVvkze12OTak5TK35p3HyQWYon64NkgYWaT03d
	mY01hvQ3rCzfzlCwLIhc6XrvykfuyapAspgDBri1gXfpr5mW+8K+d5FN36UkdIg9IVW4Rn
	dRxh17U9yZwgkSJ+Sh25ehcX/jWkj2TTmhK6xEYuyQIlaUCQwwQDVdcJKVOHJZDbo7Up/K
	FtVMlRvYGxHzfxoj5T8wV4y4dOvE4iDp9q6Yyxgc5ariQ11wW6Xv7rtfy5ptRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795081546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/9nKjusmABPy2ntroGY1Ws7SpbD9n/CmrvgD7HW1p4k=;
	b=nt3pbzXA149MO8r/35QX7h78S3NVE8qlMVkZoC6ByrP4kl+HFbzhjGJgQ/N18kq4zsXVNp
	COEXPpjYfQEnUJCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joel Fernandes <jfern@kernel.org>
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
Subject: Re: [PATCH v2 5/7] rcu: Add rcutree.boost_disable to disable
 priority boosting at runtime
Message-ID: <20261119094545.rDWiSb98@linutronix.de>
References: <20261116194438.306618-1-jfern@kernel.org>
 <20261116194438.306618-6-jfern@kernel.org>
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
In-Reply-To: <20261116194438.306618-6-jfern@kernel.org>

On 2026-11-16 14:44:36 [-0500], Joel Fernandes wrote:
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
>  	    (!rcu_preempt_blocked_readers_cgp(rnp) && !rnp->exp_tasks)) {
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  		return;

What about not deploying the boost thread as suggested in
	https://lore.kernel.org/all/20261113163647.OrW62pCV@linutronix.de/

You would have one condition less to check for. Then it depends if you
want this limited to testing or also allow in production.

Sebastian
