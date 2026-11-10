Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271548;
	b=CFAwBysCMorwTnAXgTdY+86AzDby1q0/gmLsmToyB6FppUa6nOcA4e8UgQ57n+DMvIGJ
	 JDRlYjA6pe/Flxc0NxMSCQKvzCfPsrAaC/8VZ/7aEYhtBpoQpgew23HkWkfsWMJ8x9JbR
	 zd4eocTd3HW3/yUumpLlcY0rDTwpl4JbwGi5q/AA88u8Q0kArOsAWTJfAougFpOKIEoNo
	 2vxl+mREFg9lmORMPk1uCUPpybvM2PJUk6k94JKt4y56tzfpQkl4HeioS4Cxpzu1KmyzG
	 vfdfZCBkjOj24IZMEM17jMKsZRqsuJQ9K8vBfHMmtkl4D7kdpbwOKBk3v6aoYAQy78w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271548;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=fcbUPbe6uH/pYtRrMttkaD8RGbk8+1aeFbed8cWIV9I=;
	b=XG4e6y3/pOYpugFR/it2f7DALg+HtuLaY8g+/em7+RwjOcfgjSTt61aBOzv1TZHBp1kh
	 cw8PeYIKT81cqP6zuPKQRRaHC0r9dbAw1gBW2tfmGpJMXGgFXxN5WvhVRYwAvovzXqzTj
	 IFnEzxQe1jkPH33E5kVraA5nzoFAJrgZuQLjddOPQxoj7HupGLtS4BlS2L+r90+osJSnX
	 wJO1MrbTC6fkVfryazSLEgwMytwPECzUsRxfOEqFwEi21bRobWnS9AzbCa3RX1gcOOZmf
	 Y75zIz9wPMUq0AKG4UzA7RdnFg4oimOrxMklxlyZpDVHUnBB2z8xmVVt+MBfzIVLTZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QnnuhMwn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B3606A321;
	Tue, 10 Nov 2026 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QnnuhMwn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DE01F008A1;
	Tue, 10 Nov 2026 00:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794271547;
	bh=fcbUPbe6uH/pYtRrMttkaD8RGbk8+1aeFbed8cWIV9I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=QnnuhMwn6T3tQSTW1WDzk3fHQBeRqbMbP3+wrnjzx+c4q1R2GNHfe0ycX2soMUbPH
	 10NvjImXBF2mf02hiF0WU4sd5fg8H7edygtQpz1QXn+bYx2nEr/KyHQ8gJpDAP6WuV
	 /z8THO4Ug4jvPnOae4Ti9Wzd+lbrNEa+eyn6UQbqYYi5wkh4iZWaUhrdtd33YQOYVO
	 WfEhDVHghxy0VliZG2BF8wFxx0TO3nyH53vC21cWZi/Mfhm4DHuMNMaWSMuV8v2WOs
	 anPcsY43I7pmpWTkfCmKXXMUrM0PvO9UHqgKPvjB1S8/sPObDwTqhLEVHU8UA34KD2
	 ReONysUVy6p7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 29FD2CE0C97; Mon,  9 Nov 2026 16:45:47 -0800 (PST)
Date: Mon, 9 Nov 2026 16:45:47 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <5f5ffa5b-9fa5-4359-87fc-7558f37ff0eb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261105165113.82N-rPMG@linutronix.de>
 <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
 <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
 <auzXjQfYXs_gzx1y@gpd4>
 <c81d8243-c130-44d8-bef6-e678ecb088ac@paulmck-laptop>
 <20261106140401.90MH_6qt@linutronix.de>
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
In-Reply-To: <20261106140401.90MH_6qt@linutronix.de>

On Fri, Nov 06, 2026 at 03:04:01PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-05 12:03:11 [-0800], Paul E. McKenney wrote:
> > > For rcutorture, I don't think there's a ready-made kernel interface,
> > > maybe we could add a sched helper that performs the same operation as
> > > the debugfs knobs?
> > 
> > I would very much appreciate that.  ;-)
> 
> This maybe? Since it is built-in only, there is no need to restore the
> old state, is there?

Hearing no objections, I will start testing this.  I am applying both of
your patches from this email thread, but please let me know if something
else would work better.

I would expect that this command would result in rcutorture complaining
about priority-boost failures because SRCU does not support priority
boosting.

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 15 --configs SRCU-P --bootargs "rcutorture.test_boost=2" --trust-make

But please correct me if I missed a turn in here somewhere.

And yes, in the built-in case we normally don't care about restoring
state.  The usual situation is that the system (usually a guest OS)
is brought down at the end of the test anyway, in contrast to running
rcutorture non-builtin, that is, using modprobe and rmmod.

							Thanx, Paul

> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1333,6 +1333,8 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
>  	return cur_ops->gp_diff(new, old);
>  }
>  
> +void dl_server_fair_disable(unsigned int cpu);
> +
>  static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long *start)
>  {
>  	int cpu;
> @@ -3394,6 +3396,8 @@ static int rcutorture_booster_init(unsigned int cpu)
>  
>  	/* Don't allow time recalculation while creating a new task. */
>  	mutex_lock(&boost_mutex);
> +	if (IS_BUILTIN(CONFIG_RCU_TORTURE_TEST))
> +		dl_server_fair_disable(cpu);
>  	VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
>  	boost_tasks[cpu] = kthread_run_on_cpu(rcu_torture_boost, NULL,
>  					      cpu, "rcu_torture_boost_%u");
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 076a6c2f017bb..45b1251922c4f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1921,6 +1921,31 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>  	return 0;
>  }
>  
> +#ifdef CONFIG_RCU_TORTURE_TEST
> +/*
> + * The RCU-TORTURE built-in test will disable fair-server to avoid any
> + * throttling while testing RCU-boosting.
> + * If compiled as module then the user needs to disable it manually before
> + * loading the module.
> + */
> +void dl_server_fair_disable(unsigned int cpu);
> +
> +void dl_server_fair_disable(unsigned int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +	int retval;
> +
> +	scoped_guard (rq_lock_irqsave, rq) {
> +		struct sched_dl_entity *dl_se = &rq->fair_server;
> +
> +		update_rq_clock(rq);
> +		dl_server_stop(dl_se);
> +		retval = dl_server_apply_params(dl_se, 0, dl_se->dl_period, 0);
> +	}
> +	WARN_ON_ONCE(retval);
> +}
> +#endif
> +
>  /*
>   * Add @dl_se's bw to the root-domain accounting.
>   *
> -- 
> 2.55.0
> 
