Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A70481D5;
	Tue,  6 Aug 2024 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967865; cv=none; b=IELFzdLVdtE3zUEtF+6HsBHlhtx8Ug2xbv8qgAlo8i7byKwcfX9wvurvq4KIerzxGBbyjUoth2vdgmsq6ugAUMG8vBm/1iJlVkdImlBwiLORkH+xysAKK/dygn8BjGHeXGuwSWMFhW8Q6rs3oOsUfjeAesD8FesG3K5+pwPmNaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967865; c=relaxed/simple;
	bh=3di6R+nkCndRgrAqvkZqbc0TKP4ULxAxRH2e/8MBJCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0c+SgQwENn5Wp5I/ynNzbeSMnJ8H5kbFZcdqy/1aSKFjCShXMpD5MI6dUHQzi9SmluyPiP+l+IyR2v1HUwieTpleTSiE2UIbO0n4Jz3QIXGm4nbZxK9d+HTMGgTLI5sosYGIRY9lSyeNvEFgs5e02qz9zwtTeYSPOoGBDoaTJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWZZqhb/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWZZqhb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4A0C32786;
	Tue,  6 Aug 2024 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722967864;
	bh=3di6R+nkCndRgrAqvkZqbc0TKP4ULxAxRH2e/8MBJCg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FWZZqhb//UQU1wHXRAjXaAsb+dT05/gACCIhSUpcMLDrhC6KmP+ixHxYgjnfn4Tpa
	 NXd3X2/VapefKueUsoXM1AoPBBm4oCGVI2+d148Kl4YAdF/VC0anWVlZ778QBgwkri
	 HOBMsTG4NCsC9jFhtjL8GOh3pgYjxvaltE9eZ16RtzQYTlwVoySvqsuYQas/u54TwK
	 bEYkzBkAv0B3qZjeLHvOQk9LaZqhngbWJDLyc+L8eL0XIEz9IONQZbWKfwQTHYb0Dv
	 G5duhkqehx/i6LZC5lv1VC7E43ykn+MEWcIupzkkx1OJ3WltnWYNfdBXbIWBjiJhBZ
	 l33kkuahnEZUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33EABCE0A72; Tue,  6 Aug 2024 11:10:59 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:10:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] refscale: Constify struct ref_scale_ops
Message-ID: <86dbcaa7-db16-4a90-9022-eb7b6e736ed7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <46cd762aeef493d8655e8a053bfd591f849d27ec.1722951006.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46cd762aeef493d8655e8a053bfd591f849d27ec.1722951006.git.christophe.jaillet@wanadoo.fr>

On Tue, Aug 06, 2024 at 03:30:16PM +0200, Christophe JAILLET wrote:
> 'struct ref_scale_ops' are not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   34231	   4167	    736	  39134	   98de	kernel/rcu/refscale.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   35175	   3239	    736	  39150	   98ee	kernel/rcu/refscale.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only.

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/refscale.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index cfec0648e141..0db9db73f57f 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -135,7 +135,7 @@ struct ref_scale_ops {
>  	const char *name;
>  };
>  
> -static struct ref_scale_ops *cur_ops;
> +static const struct ref_scale_ops *cur_ops;
>  
>  static void un_delay(const int udl, const int ndl)
>  {
> @@ -171,7 +171,7 @@ static bool rcu_sync_scale_init(void)
>  	return true;
>  }
>  
> -static struct ref_scale_ops rcu_ops = {
> +static const struct ref_scale_ops rcu_ops = {
>  	.init		= rcu_sync_scale_init,
>  	.readsection	= ref_rcu_read_section,
>  	.delaysection	= ref_rcu_delay_section,
> @@ -205,7 +205,7 @@ static void srcu_ref_scale_delay_section(const int nloops, const int udl, const
>  	}
>  }
>  
> -static struct ref_scale_ops srcu_ops = {
> +static const struct ref_scale_ops srcu_ops = {
>  	.init		= rcu_sync_scale_init,
>  	.readsection	= srcu_ref_scale_read_section,
>  	.delaysection	= srcu_ref_scale_delay_section,
> @@ -232,7 +232,7 @@ static void rcu_tasks_ref_scale_delay_section(const int nloops, const int udl, c
>  		un_delay(udl, ndl);
>  }
>  
> -static struct ref_scale_ops rcu_tasks_ops = {
> +static const struct ref_scale_ops rcu_tasks_ops = {
>  	.init		= rcu_sync_scale_init,
>  	.readsection	= rcu_tasks_ref_scale_read_section,
>  	.delaysection	= rcu_tasks_ref_scale_delay_section,
> @@ -271,7 +271,7 @@ static void rcu_trace_ref_scale_delay_section(const int nloops, const int udl, c
>  	}
>  }
>  
> -static struct ref_scale_ops rcu_trace_ops = {
> +static const struct ref_scale_ops rcu_trace_ops = {
>  	.init		= rcu_sync_scale_init,
>  	.readsection	= rcu_trace_ref_scale_read_section,
>  	.delaysection	= rcu_trace_ref_scale_delay_section,
> @@ -310,7 +310,7 @@ static void ref_refcnt_delay_section(const int nloops, const int udl, const int
>  	}
>  }
>  
> -static struct ref_scale_ops refcnt_ops = {
> +static const struct ref_scale_ops refcnt_ops = {
>  	.init		= rcu_sync_scale_init,
>  	.readsection	= ref_refcnt_section,
>  	.delaysection	= ref_refcnt_delay_section,
> @@ -347,7 +347,7 @@ static void ref_rwlock_delay_section(const int nloops, const int udl, const int
>  	}
>  }
>  
> -static struct ref_scale_ops rwlock_ops = {
> +static const struct ref_scale_ops rwlock_ops = {
>  	.init		= ref_rwlock_init,
>  	.readsection	= ref_rwlock_section,
>  	.delaysection	= ref_rwlock_delay_section,
> @@ -384,7 +384,7 @@ static void ref_rwsem_delay_section(const int nloops, const int udl, const int n
>  	}
>  }
>  
> -static struct ref_scale_ops rwsem_ops = {
> +static const struct ref_scale_ops rwsem_ops = {
>  	.init		= ref_rwsem_init,
>  	.readsection	= ref_rwsem_section,
>  	.delaysection	= ref_rwsem_delay_section,
> @@ -419,7 +419,7 @@ static void ref_lock_delay_section(const int nloops, const int udl, const int nd
>  	preempt_enable();
>  }
>  
> -static struct ref_scale_ops lock_ops = {
> +static const struct ref_scale_ops lock_ops = {
>  	.readsection	= ref_lock_section,
>  	.delaysection	= ref_lock_delay_section,
>  	.name		= "lock"
> @@ -454,7 +454,7 @@ static void ref_lock_irq_delay_section(const int nloops, const int udl, const in
>  	preempt_enable();
>  }
>  
> -static struct ref_scale_ops lock_irq_ops = {
> +static const struct ref_scale_ops lock_irq_ops = {
>  	.readsection	= ref_lock_irq_section,
>  	.delaysection	= ref_lock_irq_delay_section,
>  	.name		= "lock-irq"
> @@ -490,7 +490,7 @@ static void ref_acqrel_delay_section(const int nloops, const int udl, const int
>  	preempt_enable();
>  }
>  
> -static struct ref_scale_ops acqrel_ops = {
> +static const struct ref_scale_ops acqrel_ops = {
>  	.readsection	= ref_acqrel_section,
>  	.delaysection	= ref_acqrel_delay_section,
>  	.name		= "acqrel"
> @@ -524,7 +524,7 @@ static void ref_clock_delay_section(const int nloops, const int udl, const int n
>  	stopopts = x;
>  }
>  
> -static struct ref_scale_ops clock_ops = {
> +static const struct ref_scale_ops clock_ops = {
>  	.readsection	= ref_clock_section,
>  	.delaysection	= ref_clock_delay_section,
>  	.name		= "clock"
> @@ -556,7 +556,7 @@ static void ref_jiffies_delay_section(const int nloops, const int udl, const int
>  	stopopts = x;
>  }
>  
> -static struct ref_scale_ops jiffies_ops = {
> +static const struct ref_scale_ops jiffies_ops = {
>  	.readsection	= ref_jiffies_section,
>  	.delaysection	= ref_jiffies_delay_section,
>  	.name		= "jiffies"
> @@ -706,9 +706,9 @@ static void refscale_typesafe_ctor(void *rtsp_in)
>  	preempt_enable();
>  }
>  
> -static struct ref_scale_ops typesafe_ref_ops;
> -static struct ref_scale_ops typesafe_lock_ops;
> -static struct ref_scale_ops typesafe_seqlock_ops;
> +static const struct ref_scale_ops typesafe_ref_ops;
> +static const struct ref_scale_ops typesafe_lock_ops;
> +static const struct ref_scale_ops typesafe_seqlock_ops;
>  
>  // Initialize for a typesafe test.
>  static bool typesafe_init(void)
> @@ -769,7 +769,7 @@ static void typesafe_cleanup(void)
>  }
>  
>  // The typesafe_init() function distinguishes these structures by address.
> -static struct ref_scale_ops typesafe_ref_ops = {
> +static const struct ref_scale_ops typesafe_ref_ops = {
>  	.init		= typesafe_init,
>  	.cleanup	= typesafe_cleanup,
>  	.readsection	= typesafe_read_section,
> @@ -777,7 +777,7 @@ static struct ref_scale_ops typesafe_ref_ops = {
>  	.name		= "typesafe_ref"
>  };
>  
> -static struct ref_scale_ops typesafe_lock_ops = {
> +static const struct ref_scale_ops typesafe_lock_ops = {
>  	.init		= typesafe_init,
>  	.cleanup	= typesafe_cleanup,
>  	.readsection	= typesafe_read_section,
> @@ -785,7 +785,7 @@ static struct ref_scale_ops typesafe_lock_ops = {
>  	.name		= "typesafe_lock"
>  };
>  
> -static struct ref_scale_ops typesafe_seqlock_ops = {
> +static const struct ref_scale_ops typesafe_seqlock_ops = {
>  	.init		= typesafe_init,
>  	.cleanup	= typesafe_cleanup,
>  	.readsection	= typesafe_read_section,
> @@ -1026,7 +1026,7 @@ static int main_func(void *arg)
>  }
>  
>  static void
> -ref_scale_print_module_parms(struct ref_scale_ops *cur_ops, const char *tag)
> +ref_scale_print_module_parms(const struct ref_scale_ops *cur_ops, const char *tag)
>  {
>  	pr_alert("%s" SCALE_FLAG
>  		 "--- %s:  verbose=%d verbose_batched=%d shutdown=%d holdoff=%d lookup_instances=%ld loops=%ld nreaders=%d nruns=%d readdelay=%d\n", scale_type, tag,
> @@ -1081,7 +1081,7 @@ ref_scale_init(void)
>  {
>  	long i;
>  	int firsterr = 0;
> -	static struct ref_scale_ops *scale_ops[] = {
> +	static const struct ref_scale_ops *scale_ops[] = {
>  		&rcu_ops, &srcu_ops, RCU_TRACE_OPS RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
>  		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops, &jiffies_ops,
>  		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
> -- 
> 2.45.2
> 
