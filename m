Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F91925BC
	for <rcu@vger.kernel.org>; Fri,  9 Jan 2026 03:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767930574; cv=none; b=RIAdi+2OJTx+HF9woH7lN3pF4U42hjfmPS2GEEdMrcFQsxdTCwFvnEZ5PusIOH7DABGal+rQuGaxBctVks23cWggf+b0Tbr+fvPz61v0km3ITW/+AdGersAmfVC80AKwvQtofMfqhar+1yjMFNyen14hrAUMsSWL/bFRagXS3Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767930574; c=relaxed/simple;
	bh=WqjIeqfxxdOwGGBQU2Vq/NX3htvkOb9AMu6JKL9HebM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaXUFEYhLOunRUZLT4SuuDVaYErbI/Y5wqSrU5opr4JpAUOgjrJTm6zoPbw8MANSv+6VcipkCpubp5Kn6tTrVl7P6cuZNI/vbOw8ldk+OBdlePTvTIcR4/IjdxU7lZjeZjpzmSAdpPvb508e9r3vVHWzsLaeSvh090laLS7rXMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Bm2dJA/u; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Bm2dJA/u"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11f42e971d6so1467202c88.0
        for <rcu@vger.kernel.org>; Thu, 08 Jan 2026 19:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767930572; x=1768535372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LgxIDNzMCkT6nuPsnzcI0VN0T0IcJAOxVXPXNsPeV88=;
        b=Bm2dJA/uZKmDJdDuIcduvbtHJ23a9Al2cp7XnHtpr02krc6Os3/gUQEQurqmLYdXFh
         K6uV1YSbY694LiI88k6NZDvalaRTTTsBQmLigOqS4AmY4VaE1Vy6+aqI0wie9hYhbvWs
         aigFRtFZU96nc4AGwMGMgBynHEe8pfY2YxmAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767930572; x=1768535372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgxIDNzMCkT6nuPsnzcI0VN0T0IcJAOxVXPXNsPeV88=;
        b=f065Jubdt/EGrTl901eEzC5cElLCNdt/KDTac4wAkcQ4BRi0gjlwqzbZ7wM9Tb/Npz
         MGiVI/9BP9cuc8yzCOx//JL8xYrJ5OLaeKrm5LQqV9MrywkShy8tBQv1XgIgNEZZXWMx
         EejcULsDg7KZf8AaazM4Db5B1iOvhwMinz7QuZA3Vm+06THW0mV/eoOoc8IUeIPv2une
         J2yYH0JgOnnTZwyKhHkW30QAWXShkf/htHQ0xEA0jJ1qTc+f0c1nZLDFp+4PQtmHc3l7
         UWCnWKe/IuXiA/QCwgtSddWjhMccYEv/RaP57kuLp71IVArVZfSXuJj5D3UT09fGSl6v
         O2tg==
X-Forwarded-Encrypted: i=1; AJvYcCUeBJtOdaUwt0GcZKah4+vDZYRhF2Bmu2QBm2c9tLsITKdLk9SDHLe/NOfgaVhLuFuR4Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzUTA6fRLV2fQPPANoyWIKGIWCEZm8d3/HtAprNcwOF4OYXjgN
	5GCsHnhK+0DRn2nbU+62txDwnW5Rrh4mveT/iws1BuToHAQt+/qlyt9yorYkWTN8K+k=
X-Gm-Gg: AY/fxX4rTEXsng9vkhzsTzPiC/KOzQd/KA8ukD5rHYZXJOygSIUCL831Igi1SMwTqsq
	J5NuvioAjl60q5+PtaeHij+peXj6EiUhF/7RHMTCocjX5x18NYA6K78Weyj67BCpI2LaFZI4lk0
	lFHpdMcADXUGfuvE4bR9msulMFwSA/baicJ3SEP5kcy964bf4fKY3CDesFsFLrNLCT+1GuIU1Qz
	rxKiwqxV7BTDhfOC9iDiNHfvVeCX6BFQk8D4XsidP8tg+YJe1siQadKHPtdIwu39cXSddUJmcel
	DmX71BwdkOgXaP/lGXFUh7UyhOU/xVYm7/17yjG1xIFZKUeJzwLM7hd6/WYXqm3a8NNgAoJt+s1
	Qa9AUOeRmvV/MEo0geKKFO18zTXhD45G9vGNIPG5jzY21fhej/tZKU0i85YhfFXcKWdxy9lyEg9
	7P2fxhHeHk
X-Google-Smtp-Source: AGHT+IElB8Jt+Z6/1ysTbos44lwylRdVNby64t69ncnwELksl8rtSDTCEav0CcBtayPCmoNDg5Jdgw==
X-Received: by 2002:a05:7022:eaca:b0:11e:163:be60 with SMTP id a92af1059eb24-121f8b41272mr8257701c88.31.1767930572134;
        Thu, 08 Jan 2026 19:49:32 -0800 (PST)
Received: from localhost ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243ed62sm16638242c88.5.2026.01.08.19.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 19:49:31 -0800 (PST)
Date: Thu, 8 Jan 2026 22:49:30 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next 4/8] rcu/nocb: Add warning if no rcuog wake up
 attempt happened during overload
Message-ID: <20260109034930.GA1105379@joelbox2>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-5-joelagnelf@nvidia.com>
 <aV_n5RqNbikyN90u@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV_n5RqNbikyN90u@localhost.localdomain>

Hi Frederic,

On Thu, Jan 08, 2026 at 06:22:45PM +0100, Frederic Weisbecker wrote:
> Le Thu, Jan 01, 2026 at 11:34:13AM -0500, Joel Fernandes a écrit :
> > To be sure we have no rcog wake ups that were lost, add a warning
> > to cover the case where the rdp is overloaded with callbacks but
> > no wake up was attempted.
> > 
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  kernel/rcu/tree.c      | 4 ++++
> >  kernel/rcu/tree.h      | 1 +
> >  kernel/rcu/tree_nocb.h | 6 +++++-
> >  3 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 293bbd9ac3f4..78c045a5ef03 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3767,6 +3767,10 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >  		debug_rcu_head_unqueue(&rdp->barrier_head);
> >  		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
> >  	}
> > +#ifdef CONFIG_RCU_NOCB_CPU
> > +	if (wake_nocb)
> > +		rdp->nocb_gp_wake_attempt = true;
> > +#endif
> 
> entrain only queues a callback if the list is non-empty. And if it's
> non-empty, rdp->nocb_gp_wake_attempt should be true already.

This is true, we don't need to track this wake up. I will replace it with a
WARN.

> >  	rcu_nocb_unlock(rdp);
> >  	if (wake_nocb)
> >  		wake_nocb_gp(rdp, false);
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index 653fb4ba5852..74bd6a2a2f84 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -257,6 +257,7 @@ struct rcu_data {
> >  	unsigned long nocb_gp_loops;	/* # passes through wait code. */
> >  	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
> >  	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
> > +	bool nocb_gp_wake_attempt;	/* Was a rcuog wakeup attempted? */
> 
> How about nocb_gp_handling ?

This is a better name indeed, considering that we also track this for
deferred wakeups of the GP thread.

> >  	struct task_struct *nocb_cb_kthread;
> >  	struct list_head nocb_head_rdp; /*
> >  					 * Head of rcu_data list in wakeup chain,
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index daff2756cd90..7e9d465c8ab1 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -546,6 +546,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> >  	lazy_len = READ_ONCE(rdp->lazy_len);
> >  	if (was_alldone) {
> >  		rdp->qlen_last_fqs_check = len;
> > +		rdp->nocb_gp_wake_attempt = true;
> >  		rcu_nocb_unlock(rdp);
> >  		// Only lazy CBs in bypass list
> >  		if (lazy_len && bypass_len == lazy_len) {
> > @@ -563,7 +564,8 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> >  
> >  		return;
> >  	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
> > -		/* ... or if many callbacks queued. */
> > +		/* Callback overload condition. */
> > +		WARN_ON_ONCE(!rdp->nocb_gp_wake_attempt);
> >  		rdp->qlen_last_fqs_check = len;
> >  		j = jiffies;
> >  		if (j != rdp->nocb_gp_adv_time &&
> > @@ -688,6 +690,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >  		     bypass_ncbs > 2 * qhimark)) {
> >  			flush_bypass = true;
> >  		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
> > +			rdp->nocb_gp_wake_attempt = false;
> 
> This is when nocb_cb_wait() is done with callbacks but nocb_gp_wait() is done
> with them sooner, when the grace period is done for all pending callbacks.
> 
> Something like this would perhaps be more accurate:
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index e6cd56603cad..52010cbeaa76 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -746,6 +746,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  			needwait_gp = true;
>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>  					    TPS("NeedWaitGP"));
> +		} else if (!rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
> +			rdp->nocb_gp_wake_attempt = false;
>  		}

Hmm, I am trying to understand why this suggestion is better than what I
already have. It is one extra line and adds another conditional.

Also shouldn't it be:

  } else if (!rcu_cblist_n_cbs(&rdp->nocb_bypass) &&
             rcu_segcblist_empty(&rdp->cblist)) {
      rdp->nocb_gp_wake_attempt = false;
  }

  ?

My goal was to mark wake_attempt as false when ALL callbacks on the rdp were
drained. IOW, the GP thread is done with the rdp.

>  		if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
>  			needwake = rdp->nocb_cb_sleep;
> 
> 
> >  			rcu_nocb_unlock_irqrestore(rdp, flags);
> >  			continue; /* No callbacks here, try next. */
> >  		}
> > @@ -1254,6 +1257,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >  			continue;
> >  		}
> >  		rcu_nocb_try_flush_bypass(rdp, jiffies);
> > +		rdp->nocb_gp_wake_attempt = true;
> 
> Same here, we should expect rdp->nocb_gp_wake_attempt to be already on since
> there are lazy callbacks. That's a good opportunity to test the related assertion
> though.

Good point! I will turn it into a WARN.

Btw, I have more patches coming to simplify nocb_gp_wait()... it is quite long :)

thanks,

 - Joel

