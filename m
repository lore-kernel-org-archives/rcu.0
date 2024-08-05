Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FC16C84B
	for <rcu@vger.kernel.org>; Mon,  5 Aug 2024 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722894165; cv=none; b=hZbaqd1dngNXuaSYPDvvgJFA1dK68HZep74lSQBK8XHbwpIzzYDpEPVRp/kz2mS8YIOHvW1dyINm2xH7lGdKcZBJVau4NMDbVn+D3DR0MTsA3gN8p4RzjQkM65+2HhLKeDHhQLUphaQjf6wGUv9zGiQivbJMeO72wlU5Z5CJcrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722894165; c=relaxed/simple;
	bh=1CL9BOJ0mEhfnYReT/6WVWyy2T4vzzx17of5YWsvio4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=d0ZBZty8+8Ksujx1fjbnXYWUg+XzzMjFtyXIHC68zxtUc5sVtAZoVZFY21uhkd3zljbPZywLJUyH7o4M7X54lN0pcf/C1LaGdVFMRdvrZgwkrHsTduvHwgTsitcv0HraRe4fUHf7/iA9I23qPJzfhDNaa90ho8ybQroqPMljiCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWLlmFRG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWLlmFRG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722894162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWLpmNOUmnPHJOdiA3JRIaCGYZSxWHXRf9U3OHgDsOo=;
	b=IWLlmFRGKozyZIIUJ4YnTkVN+BACAqt8O1F+IUDsZLoOKqIlsJpE7vj3arCT9nXruVtYuM
	rFASdisRJpCZO8qGZykE+1htI7sNIsuNxZ7O4VbYfNuXuy0g246u53RDf08wOs5PCdu73h
	ibE7EtUJyG37cm3uoNv4Giw5+s0k0qU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-7rHshxo9POCBs4skW8Bulw-1; Mon, 05 Aug 2024 17:42:41 -0400
X-MC-Unique: 7rHshxo9POCBs4skW8Bulw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-200618d71dfso1519245ad.1
        for <rcu@vger.kernel.org>; Mon, 05 Aug 2024 14:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722894160; x=1723498960;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWLpmNOUmnPHJOdiA3JRIaCGYZSxWHXRf9U3OHgDsOo=;
        b=bjcsgjQ3em7y7iL2Qke9lHquFMc+taJ5s6Tn0lqjq7tcPXHlAw1pw1AkhRMs9ufz1v
         xL8urEcY0y0a9h/mN5flEPUdQghTwKl7t9N8DFxrsk+EukSqGzB+4vFfMYg3EegJus/O
         SNvggQj6qmCwlfwu8wnybMkQ3aVU1uMmPf2RHKyb8DsXr1ubnYCDPiETAllhPnDN5FMq
         vcc9ImRK5IknOMeI7CAp1mZvEhRR63ar5oDouSCU9e5YJtIG95PNbTfS6AACaUuh830p
         FshqNQe8LKxVT0a3YGMWiMlMdX28lY7lkY2aNl8atX84B36HJmdDQ8ZC/lWAqyqzmdZB
         K55g==
X-Forwarded-Encrypted: i=1; AJvYcCVBnj/692HukWaWIN8P8WCWxMbIQlqy/ry4s5lHJ75D3almk5GdybmO36cXw95+4xONYpc+nFjUI8jShfL3J9M7l7Ez
X-Gm-Message-State: AOJu0YyPoGqdPXyVLH7/GTQzP4CCCuY3Kc8rJJmbEFN3b2R6BLImhlSR
	8bb+MK48fhJ7CRJFrQcK7FjxrrHaaHudTMVh7LckQ8K6tOoY87lbw1BdensqktbBkJHDc9y0YsP
	Yxu8q9BPAs3wYC7amsG9zEMYzbbhizoBkxJv/LxayU1x9UPm+Pw==
X-Received: by 2002:a17:903:124e:b0:1fd:a412:5df2 with SMTP id d9443c01a7336-1ff524b3d24mr213616035ad.29.1722894160128;
        Mon, 05 Aug 2024 14:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXZL3j0naT+k8M7hE/kMki+FAesMGDGQi+w+0bVCMhZwooc9jPvm5zCXmFA0/m5NNTdyxsjQ==
X-Received: by 2002:a17:903:124e:b0:1fd:a412:5df2 with SMTP id d9443c01a7336-1ff524b3d24mr213615825ad.29.1722894159726;
        Mon, 05 Aug 2024 14:42:39 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:431:c7ed:9fa5:5bef:f08e:c5a8:9864])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59176c89sm73306285ad.192.2024.08.05.14.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 14:42:39 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	neeraj.upadhyay@kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	mingo@kernel.org,
	peterz@infradead.org,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	tglx@linutronix.de
Subject: Re: [PATCH v2 2/3] locking/csd_lock: Provide an indication of ongoing CSD-lock stall
Date: Mon,  5 Aug 2024 18:42:25 -0300
Message-ID: <ZrFHQbmkcGc6DLad@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <c95fd735-30b0-471b-bbcc-7c456acd6dc4@paulmck-laptop>
References: <20240722133559.GA667117@neeraj.linux> <20240722133735.667161-2-neeraj.upadhyay@kernel.org> <ZqquJwsH1vqsZhD2@LeoBras> <c95fd735-30b0-471b-bbcc-7c456acd6dc4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 31, 2024 at 03:08:29PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 31, 2024 at 06:35:35PM -0300, Leonardo Bras wrote:
> > On Mon, Jul 22, 2024 at 07:07:34PM +0530, neeraj.upadhyay@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > If a CSD-lock stall goes on long enough, it will cause an RCU CPU
> > > stall warning.  This additional warning provides much additional
> > > console-log traffic and little additional information.  Therefore,
> > > provide a new csd_lock_is_stuck() function that returns true if there
> > > is an ongoing CSD-lock stall.  This function will be used by the RCU
> > > CPU stall warnings to provide a one-line indication of the stall when
> > > this function returns true.
> > 
> > I think it would be nice to also add the RCU usage here, as for the 
> > function being declared but not used.
> 

Hi Paul,

> These are external functions, and the commit that uses it is just a few
> farther along in the stack.

Oh, I see. I may have received just part of this patchset.

I found it weird a series of 3 to have a 4th patch, and did not think that 
it could have more, so I did not check the ML. :)

>  Or do we now have some tool that complains
> if an external function is not used anywhere?

Not really, I was just interested in the patchset but it made no sense in 
my head to add a function & not use it. On top of that, it did not occur to 
me that it was getting included on a different patchset. 

Thanks!
Leo


> 
> > > [ neeraj.upadhyay: Apply Rik van Riel feedback. ]
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Imran Khan <imran.f.khan@oracle.com>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Leonardo Bras <leobras@redhat.com>
> > > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > > Cc: Rik van Riel <riel@surriel.com>
> > > Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> > > ---
> > >  include/linux/smp.h |  6 ++++++
> > >  kernel/smp.c        | 16 ++++++++++++++++
> > >  2 files changed, 22 insertions(+)
> > > 
> > > diff --git a/include/linux/smp.h b/include/linux/smp.h
> > > index fcd61dfe2af3..3871bd32018f 100644
> > > --- a/include/linux/smp.h
> > > +++ b/include/linux/smp.h
> > > @@ -294,4 +294,10 @@ int smpcfd_prepare_cpu(unsigned int cpu);
> > >  int smpcfd_dead_cpu(unsigned int cpu);
> > >  int smpcfd_dying_cpu(unsigned int cpu);
> > >  
> > > +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> > > +bool csd_lock_is_stuck(void);
> > > +#else
> > > +static inline bool csd_lock_is_stuck(void) { return false; }
> > > +#endif
> > > +
> > >  #endif /* __LINUX_SMP_H */
> > > diff --git a/kernel/smp.c b/kernel/smp.c
> > > index 81f7083a53e2..9385cc05de53 100644
> > > --- a/kernel/smp.c
> > > +++ b/kernel/smp.c
> > > @@ -207,6 +207,19 @@ static int csd_lock_wait_getcpu(call_single_data_t *csd)
> > >  	return -1;
> > >  }
> > >  
> > > +static atomic_t n_csd_lock_stuck;
> > > +
> > > +/**
> > > + * csd_lock_is_stuck - Has a CSD-lock acquisition been stuck too long?
> > > + *
> > > + * Returns @true if a CSD-lock acquisition is stuck and has been stuck
> > > + * long enough for a "non-responsive CSD lock" message to be printed.
> > > + */
> > > +bool csd_lock_is_stuck(void)
> > > +{
> > > +	return !!atomic_read(&n_csd_lock_stuck);
> > > +}
> > > +
> > >  /*
> > >   * Complain if too much time spent waiting.  Note that only
> > >   * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
> > > @@ -228,6 +241,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> > >  		cpu = csd_lock_wait_getcpu(csd);
> > >  		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
> > >  			 *bug_id, raw_smp_processor_id(), cpu);
> > > +		atomic_dec(&n_csd_lock_stuck);
> > >  		return true;
> > >  	}
> > >  
> > > @@ -251,6 +265,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> > >  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
> > >  		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
> > >  		 cpu, csd->func, csd->info);
> > > +	if (firsttime)
> > > +		atomic_inc(&n_csd_lock_stuck);
> > >  	/*
> > >  	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
> > >  	 * to become unstuck. Use a signed comparison to avoid triggering
> > > -- 
> > > 2.40.1
> > > 
> > 
> > IIUC we have a single atomic counter for the whole system, which is 
> > modified in csd_lock_wait_toolong() and read in RCU stall warning.
> > 
> > I think it should not be an issue regarding cache bouncing because in worst 
> > case scenario we would have 2 modify / cpu each csd_lock_timeout (which is 
> > 5 seconds by default).
> 
> If it does become a problem, there are ways of taking care of it.
> Just a little added complexity.  ;-)
> 
> > Thanks!
> 
> And thank you for looking this over!
> 
> 							Thanx, Paul
> 

