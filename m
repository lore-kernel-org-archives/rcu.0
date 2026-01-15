Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE517DE36
	for <rcu@vger.kernel.org>; Thu, 15 Jan 2026 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513191; cv=none; b=Uhbc6wTwDjbBscRBToZt+mskZdDCyzLp8GBncoyzbQG0mfot/+zDjNJWBl9JPYLo+6TCHidkAkU3YXKNYY3qYYyehba5rtCsbXY9D0IHMCoaENrN2pY+Gl/SVM7kgHPldDfbqB4XfPFSwYpFkEIkR1RKzG26FGzgbEJicoFD1RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513191; c=relaxed/simple;
	bh=bdrtUc8FUz9IoMkqRV2xTVfpT7lEE13YW38nEJcDiUc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnUkjdk08XqvKOfoiUIC+5RxYHu5+bvmSvMnA8nd0mggrozbY8loYzUGgOcS4uVmkXOozM1ao+9Mbouidur9aNFtuWNUdSVRKpUeAzLLUN5/SHL3Z+di8yfcqfRRiGbUd0lovitnDm3fP25Zp/EKR3FEEutfQUiGudstCXrXvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWe50jKR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWe50jKR"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3831ad8ae4eso12251451fa.1
        for <rcu@vger.kernel.org>; Thu, 15 Jan 2026 13:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768513188; x=1769117988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OrPuXeSmbwvwSwICtI9YCJ5a6NcKbmAEzN0LGQQqy0M=;
        b=EWe50jKRFVkog+IR9FbLMy4pVkHFGnRv85sk6bx4RAE3XkYjnTIwvJ09rw12p7QkiM
         Z7yurY9J8Ek9dBxQtQ+nMormvbCf3GcTYFlI5JlGmZ5dYBNABqEl1wKcXHSOYzv+Dtox
         d0zn0M8t7qLn50EwmLM1LyzC05YjUEHOoLwcy2s9fEn7NJw/mlcnL26hswsZKgzR4Gdw
         /DEG57qUNxRg2q6Dv7kT5mowlr08WhNAPMSbOvNFqMMB/Rz7VL9EPCpsZMDbxAZSCzgk
         37UfkniqR8U9hBkkakRBLL1UFP/THjLjdYr/RAStQ/wWeVCNwzl9mYGPzzu8eD1uVvxE
         nKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768513188; x=1769117988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrPuXeSmbwvwSwICtI9YCJ5a6NcKbmAEzN0LGQQqy0M=;
        b=g8X7cWIT1ocjtC6h2wP0+pUroNgR89DFcX2tKt554NOMlPKStgMvjcY96+ej0yWD5F
         SyKazOex9Z9+RChV9wSuOPeKlVvtN9sMWAXln+ej8wG1DTYDhBMVw65JlRUWhPqHiX62
         vsfp+5d1DcpfWpi2ktI/gA3b4xx78mGcuEElHYaifGiVSt4LX/CmLe1bJbQp5j3rcOD1
         uR7HTgetb5wN9dGXUmlrDLxmL3o0glgeKHeXPodSqvmx1kOotxffsZ5c/7d9uiwALbbg
         D3iKEgb7k73YS1Guu1379mDKV8OsxjPAXPnPDKj3+EUJGEuBO/a6L4ysU63wfsw8imAu
         I3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWAaSnGkToKS+WVbwRbjXaUVzNKv41rWElWbliTCkpSrRBydDUIHDpEAUpRnBzk5zU1IdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNPyQvcYPkMeg311uGX0Qy7QdRxRYwzGjsVEztNToBxm5F+1jN
	7gA8d/jVDM0L6BB+SjzMWTxhHwWljgHAT1OjeJv9CdZKiihFF6i0/mUX
X-Gm-Gg: AY/fxX7wuydQRTyfO8gFj+dTMzXffcL2X/9pWLTdOBe6MR8RqUsWHxrYf69SN5O77N0
	EeBddPuIOokMrrrvI27ANikGNhhXrbcYlvnGzD6jD5hYZuH70s45G4kG26OZ0o+PN65D/0qi8lu
	f5yelGVaxFKTsLsrvq7lle9sZEzoq7RKJqHyeSm2z7nB5zRy5EkKRa5qB7vjWqEaMZeb47xNLWx
	npuhG39XU7PhoKZ5QlM2wmdU4n25QDDjIRlc7VEDjt8LWah76M9q0GOatCmu/49xpa1JROs0Su/
	kkv/t3lopOT6p0tiLAXeTFAAa3bEwHk/vFPTpO7POATCfRYFunkgLcW0qImoJg02JFWnjG66Hm2
	Rnas3NjvoZHVdBywUlyQND2ixk6riorcqJQW7YH9AIpXLVTL4ssI=
X-Received: by 2002:a2e:a556:0:b0:382:51cc:d26b with SMTP id 38308e7fff4ca-3838692b26cmr1266391fa.21.1768513187512;
        Thu, 15 Jan 2026 13:39:47 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384dbec4dsm1738841fa.20.2026.01.15.13.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 13:39:46 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 15 Jan 2026 22:39:45 +0100
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>, samir@linux.ibm.com,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH] rcu: Latch normal synchronize_rcu() path on flood
Message-ID: <aWleoTMxmWlzbT-e@pc636>
References: <20260114183415.286489-1-urezki@gmail.com>
 <f83b53da-7812-4285-a1db-2fa0fb8d611a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83b53da-7812-4285-a1db-2fa0fb8d611a@linux.ibm.com>

On Thu, Jan 15, 2026 at 10:53:47PM +0530, Shrikanth Hegde wrote:
> +samir
> 
> On 1/15/26 12:04 AM, Uladzislau Rezki (Sony) wrote:
> > Currently, rcu_normal_wake_from_gp is only enabled by default
> > on small systems(<= 16 CPUs) or when a user explicitly set it
> > enabled.
> > 
> > This patch introduces an adaptive latching mechanism:
> >   * Tracks the number of in-flight synchronize_rcu() requests
> >     using a new atomic_t counter(rcu_sr_normal_count);
> > 
> 
> is this atomic variable getting updated by multiple CPUs at the
> same time? We had seen in past such updates tend to be very costly.
> 
The threshold we maintain is 64 users in a queue. So first 64
parallel users create contention but it is mitigated right away
by switching to another path. Latching normal path due to flood.

> >   * If the count exceeds RCU_SR_NORMAL_LATCH_THR(64), it sets
> >     the rcu_sr_normal_latched, reverting new requests onto the
> >     scaled wait_rcu_gp() path;
> > 
> >   * The latch is cleared only when the pending requests are fully
> >     drained(nr == 0);
> > 
> >   * Enables rcu_normal_wake_from_gp by default for all systems,
> >     relying on this dynamic throttling instead of static CPU
> >     limits.
> > 
> > Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >   kernel/rcu/tree.c | 37 ++++++++++++++++++++++++++-----------
> >   1 file changed, 26 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 293bbd9ac3f4..c42d480d6e0b 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1631,17 +1631,21 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
> >   	atomic_set_release(&sr_wn->inuse, 0);
> >   }
> > -/* Enable rcu_normal_wake_from_gp automatically on small systems. */
> > -#define WAKE_FROM_GP_CPU_THRESHOLD 16
> > -
> > -static int rcu_normal_wake_from_gp = -1;
> > +static int rcu_normal_wake_from_gp = 1;
> >   module_param(rcu_normal_wake_from_gp, int, 0644);
> >   static struct workqueue_struct *sync_wq;
> > +#define RCU_SR_NORMAL_LATCH_THR 64
> > +
> > +/* Number of in-flight synchronize_rcu() calls queued on srs_next. */
> > +static atomic_long_t rcu_sr_normal_count;
> > +static atomic_t rcu_sr_normal_latched;
> > +
> >   static void rcu_sr_normal_complete(struct llist_node *node)
> >   {
> >   	struct rcu_synchronize *rs = container_of(
> >   		(struct rcu_head *) node, struct rcu_synchronize, head);
> > +	long nr;
> >   	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> >   		!poll_state_synchronize_rcu_full(&rs->oldstate),
> > @@ -1649,6 +1653,15 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> >   	/* Finally. */
> >   	complete(&rs->completion);
> > +	nr = atomic_long_dec_return(&rcu_sr_normal_count);
> > +	WARN_ON_ONCE(nr < 0);
> > +
> > +	/*
> > +	 * Unlatch: switch back to normal path when fully
> > +	 * drained and if it has been latched.
> > +	 */
> > +	if (nr == 0)
> > +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
> >   }
> >   static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > @@ -1794,7 +1807,14 @@ static bool rcu_sr_normal_gp_init(void)
> >   static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> >   {
> > +	long nr;
> > +
> >   	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
> > +	nr = atomic_long_inc_return(&rcu_sr_normal_count);
> > +
> > +	/* Latch: only when flooded and if unlatched. */
> > +	if (nr >= RCU_SR_NORMAL_LATCH_THR)
> > +		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
> >   }
> >   /*
> > @@ -3268,7 +3288,8 @@ static void synchronize_rcu_normal(void)
> >   	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
> > -	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
> > +	if (READ_ONCE(rcu_normal_wake_from_gp) < 1 ||
> > +			atomic_read(&rcu_sr_normal_latched)) {
> >   		wait_rcu_gp(call_rcu_hurry);
> >   		goto trace_complete_out;
> >   	}
> > @@ -4892,12 +4913,6 @@ void __init rcu_init(void)
> >   	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> >   	WARN_ON(!sync_wq);
> > -	/* Respect if explicitly disabled via a boot parameter. */
> > -	if (rcu_normal_wake_from_gp < 0) {
> > -		if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
> > -			rcu_normal_wake_from_gp = 1;
> > -	}
> > -
> >   	/* Fill in default value for rcutree.qovld boot parameter. */
> >   	/* -After- the rcu_node ->lock fields are initialized! */
> >   	if (qovld < 0)
> 
> 
> Samir,
> Could you please give this patch a try on 1000+ cpu system?
> 
> Specifically test time taken for SMT1 to SMT8 and SMT8 to SMT1 switching
> time.
> 
> 
> Uladzislau, Is there any specific testing(other than above) you are looking for?
> 
Yep, your test cases which are important for you. You also run it on
~400 CPUs system according to previous conversation in first topic.

--
Uladzislau Rezki
