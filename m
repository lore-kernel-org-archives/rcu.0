Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF816D30F;
	Wed, 31 Jul 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463715; cv=none; b=ScBQCrITZeAn1UMsk0h++ufBuUs3gCZ3oBaH5mNuPROimCxLDPJDRS68o0XtTrLWz33RtMSaRlwwi2YMVIAezqqFkMr62tr91CrGl8whLwikqsCdCYIpxHW/iH94+PuOf4yzp4ua7wzqSgcqCColVIpjAYUnUAQXMQdYcFiqtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463715; c=relaxed/simple;
	bh=a34TN3KwIKgc4hKuJGY4XM5T5ue33al74Tkes/MJzus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stxaVR9CP1t7QQI12sovVHqO68+c+F037XtMVwreug+f34nmPpRE++lCTpAzfPOfbJzeSDa+wo0INpfdruSZNpADVOgUwjgCGfvOEPus+X0oYXY5gsTvHGeEg20O8fCM2FuywB3J5EeEpGZ+WOxwBtsah8RvRL6Qef2suYegAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/RehEzI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/RehEzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AECCC116B1;
	Wed, 31 Jul 2024 22:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722463715;
	bh=a34TN3KwIKgc4hKuJGY4XM5T5ue33al74Tkes/MJzus=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=K/RehEzIqnBEp8i5fIQkB3Orr6xN43rTlVv1rawK9Ow/xFfMdIcFDFOLyHcWzNOME
	 z4iJSGNtAuBghf1eCl9NL2DUx55mAfYOFD6zucmwZplK7qGCeZQ5N2HdrWKDazBqVd
	 dgYzcaS8ma1cU59ZYW6ApcivZ4SGAQX02+KWZZS31EEBVp11LOLOWCyWan8Rk2zabO
	 6pXa8NqesnjHJfOrOTgrI6M9NIWGtaKDFrii8wtna6n2C0FN1xMlUrrSfFmLmMUsc1
	 h/ZxZ15zp3yae9lZQ8H3BdcI42K6yJ1PJZkuZpsaKJz4p6BE8NfaFnAZn9pWWlIe7d
	 vQfuaUCace2Kg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C8CD7CE0A63; Wed, 31 Jul 2024 15:08:29 -0700 (PDT)
Date: Wed, 31 Jul 2024 15:08:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Leonardo Bras <leobras@redhat.com>
Cc: neeraj.upadhyay@kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	mingo@kernel.org, peterz@infradead.org, imran.f.khan@oracle.com,
	riel@surriel.com, tglx@linutronix.de
Subject: Re: [PATCH v2 2/3] locking/csd_lock: Provide an indication of
 ongoing CSD-lock stall
Message-ID: <c95fd735-30b0-471b-bbcc-7c456acd6dc4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240722133559.GA667117@neeraj.linux>
 <20240722133735.667161-2-neeraj.upadhyay@kernel.org>
 <ZqquJwsH1vqsZhD2@LeoBras>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqquJwsH1vqsZhD2@LeoBras>

On Wed, Jul 31, 2024 at 06:35:35PM -0300, Leonardo Bras wrote:
> On Mon, Jul 22, 2024 at 07:07:34PM +0530, neeraj.upadhyay@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > If a CSD-lock stall goes on long enough, it will cause an RCU CPU
> > stall warning.  This additional warning provides much additional
> > console-log traffic and little additional information.  Therefore,
> > provide a new csd_lock_is_stuck() function that returns true if there
> > is an ongoing CSD-lock stall.  This function will be used by the RCU
> > CPU stall warnings to provide a one-line indication of the stall when
> > this function returns true.
> 
> I think it would be nice to also add the RCU usage here, as for the 
> function being declared but not used.

These are external functions, and the commit that uses it is just a few
farther along in the stack.  Or do we now have some tool that complains
if an external function is not used anywhere?

> > [ neeraj.upadhyay: Apply Rik van Riel feedback. ]
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Imran Khan <imran.f.khan@oracle.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Leonardo Bras <leobras@redhat.com>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: Rik van Riel <riel@surriel.com>
> > Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> > ---
> >  include/linux/smp.h |  6 ++++++
> >  kernel/smp.c        | 16 ++++++++++++++++
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/include/linux/smp.h b/include/linux/smp.h
> > index fcd61dfe2af3..3871bd32018f 100644
> > --- a/include/linux/smp.h
> > +++ b/include/linux/smp.h
> > @@ -294,4 +294,10 @@ int smpcfd_prepare_cpu(unsigned int cpu);
> >  int smpcfd_dead_cpu(unsigned int cpu);
> >  int smpcfd_dying_cpu(unsigned int cpu);
> >  
> > +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> > +bool csd_lock_is_stuck(void);
> > +#else
> > +static inline bool csd_lock_is_stuck(void) { return false; }
> > +#endif
> > +
> >  #endif /* __LINUX_SMP_H */
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 81f7083a53e2..9385cc05de53 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -207,6 +207,19 @@ static int csd_lock_wait_getcpu(call_single_data_t *csd)
> >  	return -1;
> >  }
> >  
> > +static atomic_t n_csd_lock_stuck;
> > +
> > +/**
> > + * csd_lock_is_stuck - Has a CSD-lock acquisition been stuck too long?
> > + *
> > + * Returns @true if a CSD-lock acquisition is stuck and has been stuck
> > + * long enough for a "non-responsive CSD lock" message to be printed.
> > + */
> > +bool csd_lock_is_stuck(void)
> > +{
> > +	return !!atomic_read(&n_csd_lock_stuck);
> > +}
> > +
> >  /*
> >   * Complain if too much time spent waiting.  Note that only
> >   * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
> > @@ -228,6 +241,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> >  		cpu = csd_lock_wait_getcpu(csd);
> >  		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
> >  			 *bug_id, raw_smp_processor_id(), cpu);
> > +		atomic_dec(&n_csd_lock_stuck);
> >  		return true;
> >  	}
> >  
> > @@ -251,6 +265,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> >  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
> >  		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
> >  		 cpu, csd->func, csd->info);
> > +	if (firsttime)
> > +		atomic_inc(&n_csd_lock_stuck);
> >  	/*
> >  	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
> >  	 * to become unstuck. Use a signed comparison to avoid triggering
> > -- 
> > 2.40.1
> > 
> 
> IIUC we have a single atomic counter for the whole system, which is 
> modified in csd_lock_wait_toolong() and read in RCU stall warning.
> 
> I think it should not be an issue regarding cache bouncing because in worst 
> case scenario we would have 2 modify / cpu each csd_lock_timeout (which is 
> 5 seconds by default).

If it does become a problem, there are ways of taking care of it.
Just a little added complexity.  ;-)

> Thanks!

And thank you for looking this over!

							Thanx, Paul
