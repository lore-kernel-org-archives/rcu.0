Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009FF375F81
	for <rcu@vger.kernel.org>; Thu, 23 Apr 2026 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944132; cv=none; b=Pps3RRQMlBcq/6E2I7+CpUGPKdnCe0HWM4lsc2BQrfNtmr8De4PWHmb8AdbPj8dlnNnc1VWmdEcZEz/LWffkGmZE2TiSVJ03Xkh072XFYVe6KvvzNXJsrtqOQVNG0pOz0ErECNlO6gbExkFMSyWZrQ98CFTvyku1nXOfDfgbFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944132; c=relaxed/simple;
	bh=S/TuTHs8TAB69o8Dy/Q/eai58sxdBsXMm8f2eO8Ynzs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQ1IMAz+zNHPgPwH5ZnM014HOgdVSltSbSo9sk/elMvI6RPYZ8idQUarsRGpEVCMi49OzsH1w+pw/Jkw7vhbz5g9eLWJwd8SPhKTHgZ3PdpHsOuHsTwEmnwk8p84btI9ypMLoCwJLsOEd35jOBiapUDdge5Yxpd/SdbS4PjY+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erpzjYPy; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erpzjYPy"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38e68e4389cso69297671fa.3
        for <rcu@vger.kernel.org>; Thu, 23 Apr 2026 04:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776944129; x=1777548929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iscWRn4jKN3kB/fAMJ/YC6wowWsWoekdUPD+h4UIdhI=;
        b=erpzjYPynSqVJN8SJNEbN2sTjWL19HwsCsbkr9rFisp6MnyXVC4X9N6TprkxbCeko9
         EzXvn36YkfXbQ1wm62keV1FtKGbVBakNGE+ZAIKGeall+8QYrXQdTldguNzF20kmWrIG
         wJaZbRCVQMRLw6eC68k1VGuOYAaLj47WBMkwPo7fEqjqOMNH6DimuPvNNuGPk49ZxZN1
         XezX9j/s4rgwfbs5rxSsWXHTYjhmoeW8fQC2TqodWz50b6z27+IpB39HaUFsK+AVopiY
         6p9wqRuNzGKvhyhPtaStftvllGhVw6ZBRwUmy1YxM/XBJK5+YSMrGdnbPhdR+Mgzp9aw
         pPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776944129; x=1777548929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iscWRn4jKN3kB/fAMJ/YC6wowWsWoekdUPD+h4UIdhI=;
        b=CtNmoUfJJ326D+6ILoG1k7XEgCmAyGEz3IsXtRRU3v7dd0gRxOPyJpbQPnhXP0J+FF
         t/iKsZL2EVMOS51vm9AlBfu7QKmBmiUk0iD2kN8NQOjP3T4TaWasPBgLOljZjWsUTt5A
         NGD0QM6RQV+oZ+k4R+antCBjhwaFOV+RJzsjOA6T3vvDddLFXzyg4jLq5gFtYhDEIHzA
         se3JJ/wukwh7aXIXA48esNdFDOjSdWyOHBrlRQvyjpFnqj2UQhexw+er3NVjpLll3YYo
         5FIdgf93SIxZia983i01lONss47wqhW4d5TG5RwSrDL9WxQRnmgqp+T4joNHDLG6fU57
         XLAg==
X-Forwarded-Encrypted: i=1; AFNElJ9v8q2xg4I37k1JCnrjxGoq64aeowsMaq6VyMJkOb160jjwOv1VOwWxmys2kiRsDgYMqzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD02Vm1nlNTM1IVICh7Hhl3Pf/cBi1eYpP75oFT8uxmU8L3y/D
	5MFSf9Ey1cRgMvq03Pn38G+c2yCW6GbCMh3TbLfgCOgG7jf/SXsxS/HZ
X-Gm-Gg: AeBDiev5CeWPCRrRIk8+4LQ1b9/tIRC24KPbRb647omKmDUhAqcIOmDvz6YcjGchl3w
	FjXkpMhCUCtwXHFt0XoV9BIBdELTZQV15kgKiE+P71jYu5mko8l7GLYAqQ64P4lQdb5EGFE/jAE
	l3R1jOilM0M8ZuWb4krf98bqH2lcFgSMioEwPnkqRErS5PsfjjUI4q7RIzLXFEXV7QJLjUyvGXs
	JOuZ2itC7naDxSncVI9TPtr8nFH5Aw9F7wydAJ3sHoN/TGzSyoX+7Wp9bHGpF8t7JVaMJ0ZKIu3
	iCp1i2bzDQZN9lAgA9TaN6xzsHpGYGQEJez4lZ6NMJUqpYeWAwwfRmJNZDwVaFg+9DwwQVFX/qh
	puTBP3KKcTdzJ9XwL73pOimiTID+RX7SCp+gkHoWRZUz2+B9kz2ypdLIs+oqPSckJacAKYalCbB
	C3lTgwnVQxc9RmZJJWs1df+Wa+tZuTS3khE1xNrCGXXjn+8sP6J2wgVbi2ow==
X-Received: by 2002:a2e:bc14:0:b0:38c:4b14:144e with SMTP id 38308e7fff4ca-38ec780993bmr91273391fa.5.1776944128799;
        Thu, 23 Apr 2026 04:35:28 -0700 (PDT)
Received: from pc636 (host-95-203-26-80.mobileonline.telia.com. [95.203.26.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb6f3a30sm40716001fa.24.2026.04.23.04.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 04:35:28 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 23 Apr 2026 13:35:25 +0200
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
Message-ID: <aeoD_Ts6hLsgNc9-@pc636>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
 <aejeVK0J_jHSfVhD@milan>
 <aemevSofweaUSx0n@hyeyoo>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aemevSofweaUSx0n@hyeyoo>

On Thu, Apr 23, 2026 at 01:23:25PM +0900, Harry Yoo (Oracle) wrote:
> On Wed, Apr 22, 2026 at 04:42:28PM +0200, Uladzislau Rezki wrote:
> > I think a better option is to add a separate kvfree_rcu_nmi() helper,
> > or similar, and avoid complicating the generic implementation. Otherwise,
> > the common path risks becoming harder to maintain.
> > 
> > Below is a simple implementation.
> 
> I'm happy to keep things simple as long as that doesn't mean
> compromising performance.
> 
> We can discuss that.
> 
> > <patch>
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index d5a70a831a2a..f6ae3795ec6c 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1402,6 +1402,14 @@ struct kfree_rcu_cpu {
> >  
> >  	struct llist_head bkvcache;
> >  	int nr_bkv_objs;
> > +
> > +	/* For NMI context. */
> 
> I think "unknown context" is a better term since it includes
> NMI context as well as other contexts.
> (I'm also slightly moving towards the term, :D)
> 
> > +	struct llist_head drain_list;
> > +	struct llist_node *pending_list;
> > +
> > +	struct rcu_work drain_rcu_work;
> > +	struct irq_work drain_irqwork;
> > +	atomic_t drain_in_progress;
> >  };
> 
> [... changing the order of functions a little bit to help review ...]
> 
> >  static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> > @@ -1926,6 +1934,69 @@ void __init kfree_rcu_scheduler_running(void)
> >  	}
> >  }
> > +
> > +/*
> > + * Queue a request for lazy invocation.
> > + * Context: For NMI contexts or unknown contexts only.
> > + */
> > +void
> > +kvfree_call_rcu_nolock(struct rcu_head *head, void *ptr)
> > +{
> > +	struct kfree_rcu_cpu *krcp = this_cpu_ptr(&krc);
> > +
> > +	head->func = ptr;
> > +	llist_add((struct llist_node *) head, &krcp->drain_list);
> > +
> 
> So it inserts objects to the list,
> 
> > +	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING) {
> > +		/* Only first(and only one) user rings the bell. */
> > +		if (!atomic_cmpxchg(&krcp->drain_in_progress, 0, 1))
> > +			irq_work_queue(&krcp->drain_irqwork);
> 
> and only the task that succeeds cmpxchg queues the IRQ work.
> The IRQ work queues an RCU work which iterates over the
> list of objects and frees them.
> 
> Draining will be performed a little bit more frequently
> (every call_rcu_hurry() + work queue delay) compared to the ordinary
> kvfree_rcu path (every 1-5 seconds)
> 
> The question is how frequent is too frequent, when it comes to
> additional IRQ/RCU work invocations affecting performance.
> 
> > +static void
> > +kvfree_rcu_nolock_irqwork(struct irq_work *irqwork)
> > +{
> > +	struct kfree_rcu_cpu *krcp =
> > +		container_of(irqwork, struct kfree_rcu_cpu, drain_irqwork); > +	bool queued;
> > +
> > +	krcp->pending_list = llist_del_all(&krcp->drain_list);
> > +	ASSERT_EXCLUSIVE_WRITER(krcp->pending_list);
> > +	queued = queue_rcu_work(rcu_reclaim_wq, &krcp->drain_rcu_work);
> > +	WARN_ON_ONCE(!queued);
> > +}
> >
> > +static void
> > +kvfree_rcu_nolock_work(struct work_struct *work)
> > +{
> > +	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
> > +		struct kfree_rcu_cpu, drain_rcu_work);
> > +	struct llist_node *pos, *n, *pending;
> > +	bool queued;
> > +
> > +	pending = krcp->pending_list;
> > +	krcp->pending_list = NULL;
> > +	ASSERT_EXCLUSIVE_WRITER(krcp->pending_list);
> > +
> > +	llist_for_each_safe(pos, n, pending) {
> > +		struct rcu_head *rcu = (struct rcu_head *) pos;
> > +		void *ptr = (void *) rcu->func;
> > +		kvfree(ptr);
> > +	}
> 
> This is pretty similar to what a kvfree_rcu(two_arg) call does
> in the slowpath (kvfree_rcu_list), except that we don't maintain
> RCU state explicitly.
> 
> How much performance do we sacrifice compared to
> letting them go through the kvfree_rcu() fastpath?
> 
I think we may be focusing too much on performance here. In fact it depends
on use cases which we try to improve or fix. Freeing an object over RCU from
NMI context is a corner case. It is __not_ generic. We even do not have(now
in mainline) users because we never support it from NMI, just like call_rcu().

From the other hand, if you heavily reclaim from NMI, this is likely not a
common or intended usage pattern this is how i understand it. If BPF needs
it, then the first question which comes to mind is not about performance.
It is how to support this case in kfree_rcu() without adding noticeable
complexity or overhead or hacks to the generic path without making it harder
to maintain.

Performance wise you noted, you mean:

a) call latency(this is probably the most important for NMI)?
b) memory footprint?
c) pointer-chasing overhead?

Please note, when we are talking about NMI support, we are in a special
conditions thus we should no overthinking here. This is how i look at it.

--
Uladzislau Rezki
