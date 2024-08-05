Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223115B56E;
	Mon,  5 Aug 2024 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884298; cv=none; b=IcU76fYmUgypDgMHBRd9NAlEcAfX5fAeGTeSX7ZGtxqFSmaZteDbyuRVacm8+rUnm/bO1o+Qvx2zqDcQt7Cv41rsGZiGhvhA782iaolPOt3CMWLruPvdDzPYvzuNOAlirl/IvF5+soN5deqnW0eANWBQhLlVwRYro7Lluxxq5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884298; c=relaxed/simple;
	bh=njd0DJogPG55X9yTYiWrnv7QjYuFPWUq73N4p708nK8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iei8383pD8fwxiimORBTSjiwo5hPrFjimzxdBUv9gc8NVWCGQU11TiohDziw32ZzmbL5Qy3px8NjlRtJTzzmNyZMAvw9D4OU1uabh9qKuPeRyqVPL5w345AcRR/xYz+ahtKxhUo2oPM2rvM4GMBu75Lu5oKeWX6/FUoO7Q1LcGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmD6aXkb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmD6aXkb"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so16680165e87.1;
        Mon, 05 Aug 2024 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722884294; x=1723489094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6zOpbKZlyyEpf7p8saMgrewPpCPBh0IVajsvpl6fDWM=;
        b=YmD6aXkbxH3ptr0yEr4ZnnPEWvhO8PbukxxhDOALxy4DdC8az7m7YOOmV6gs/HjBTt
         7xQ3CG7mzAboWvEz3vKASK/ew97g1gCZwT5aBYMyByrYlvpc1FB0EWWjdJyHA/g6DQLO
         YVZBJdei0qFXO5o0pczhgZ99yn1FpV4PHJ62FC4FlslYz8VQAd++HXBpsuIkPHRiKEso
         /4Lm9w5vLxvq/fevQ42Q+rEzRUFf0MqoapZwMoCvreVt/d0VwCIzxeANsq5CM9jCKT5K
         EiAbwym7VOGQ/rI0J7dpItofr3marMTsHZ5Jt67q41SwA0UTSDfkVh6mNA26/VHqcy2O
         ObXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722884294; x=1723489094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zOpbKZlyyEpf7p8saMgrewPpCPBh0IVajsvpl6fDWM=;
        b=useLUNiR0MzAdMC0hJX5S1pBjpxnQM5DflZiJrATwWGUiltExHqUe+fdRKOwDm53A2
         JFHvaoSsavpOue9eFv82/9eSsyIkAnTuMqX4YyMEgbzBTPwy+AXR7a/8KmJIbubD9iK1
         S+NSkh/H4pMGPyHyJx5w9m/tJj2Fd7rzu75DiAUfdAS/YJF5UjPMlcioeNtvE5lbvqf7
         PNrJAb6XaGHasTOq85vdTDQkDvl9lHunGWA7WfllrUrb/IzbEVA+4Q3h0GwVrT+DIe8O
         L2QuxKwAf5QkYfTHYbvoL4vI8sOKyJytixjB54iO14WwWBnHfVnXHJZhtja+kHXSIGrH
         sb2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPojvXrJDJal1BO8EIuiWyduEUatl5JqMlXPkoAAQ3z7WnyJeFZjWXUHa4bahhiyWOWF/yWqsDmVvPdbyksnqtYNghU6D/PHyeySXhz2+zlnkfpzfzfw4hUpcma9Q/+Psl
X-Gm-Message-State: AOJu0YwrGZoQbHQPlKmX/zGyu7jjBiM7TzQDgJF5oO5dwKn87hpbBVAE
	2U5ebfyRJlgg8sAo0QyGQEySQ/vzGOPtK3zyMiZp/Hj+wE4G7Ck+
X-Google-Smtp-Source: AGHT+IEc8MlyYYOOdN/Lw9mR/eN3RKaNgkaPfoixAQD508JuVKM3fH7Rh3OJiSf2nvwvdIs0CWBCjA==
X-Received: by 2002:a05:6512:1243:b0:52c:df6f:a66 with SMTP id 2adb3069b0e04-530bb3b189cmr6793022e87.58.1722884294023;
        Mon, 05 Aug 2024 11:58:14 -0700 (PDT)
Received: from pc636 (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba10eeasm1215135e87.95.2024.08.05.11.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:58:13 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 5 Aug 2024 20:58:11 +0200
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/kvfree: Add kvfree_rcu_barrier() API
Message-ID: <ZrEgwyQFnmToTNvl@pc636>
References: <20240801111039.79656-1-urezki@gmail.com>
 <ZrD537_itA2sWQoA@boqun-archlinux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrD537_itA2sWQoA@boqun-archlinux>

On Mon, Aug 05, 2024 at 09:12:15AM -0700, Boqun Feng wrote:
> On Thu, Aug 01, 2024 at 01:10:39PM +0200, Uladzislau Rezki (Sony) wrote:
> > Add a kvfree_rcu_barrier() function. It waits until all
> > in-flight pointers are freed over RCU machinery. It does
> > not wait any GP completion and it is within its right to
> > return immediately if there are no outstanding pointers.
> > 
> > This function is useful when there is a need to guarantee
> > that a memory is fully freed before destroying memory caches.
> > For example, during unloading a kernel module.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  include/linux/rcutiny.h |   5 ++
> >  include/linux/rcutree.h |   1 +
> >  kernel/rcu/tree.c       | 103 ++++++++++++++++++++++++++++++++++++----
> >  3 files changed, 101 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > index d9ac7b136aea..522123050ff8 100644
> > --- a/include/linux/rcutiny.h
> > +++ b/include/linux/rcutiny.h
> > @@ -111,6 +111,11 @@ static inline void __kvfree_call_rcu(struct rcu_head *head, void *ptr)
> >  	kvfree(ptr);
> >  }
> >  
> > +static inline void kvfree_rcu_barrier(void)
> > +{
> > +	rcu_barrier();
> > +}
> > +
> >  #ifdef CONFIG_KASAN_GENERIC
> >  void kvfree_call_rcu(struct rcu_head *head, void *ptr);
> >  #else
> > diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> > index 254244202ea9..58e7db80f3a8 100644
> > --- a/include/linux/rcutree.h
> > +++ b/include/linux/rcutree.h
> > @@ -35,6 +35,7 @@ static inline void rcu_virt_note_context_switch(void)
> >  
> >  void synchronize_rcu_expedited(void);
> >  void kvfree_call_rcu(struct rcu_head *head, void *ptr);
> > +void kvfree_rcu_barrier(void);
> >  
> >  void rcu_barrier(void);
> >  void rcu_momentary_dyntick_idle(void);
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 28c7031711a3..1423013f9fe6 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3550,18 +3550,15 @@ kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
> >  }
> >  
> >  /*
> > - * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
> > + * Return: %true if a work is queued, %false otherwise.
> >   */
> > -static void kfree_rcu_monitor(struct work_struct *work)
> > +static bool
> > +kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
> >  {
> > -	struct kfree_rcu_cpu *krcp = container_of(work,
> > -		struct kfree_rcu_cpu, monitor_work.work);
> >  	unsigned long flags;
> > +	bool queued = false;
> >  	int i, j;
> >  
> > -	// Drain ready for reclaim.
> > -	kvfree_rcu_drain_ready(krcp);
> > -
> >  	raw_spin_lock_irqsave(&krcp->lock, flags);
> >  
> >  	// Attempt to start a new batch.
> > @@ -3600,11 +3597,27 @@ static void kfree_rcu_monitor(struct work_struct *work)
> >  			// be that the work is in the pending state when
> >  			// channels have been detached following by each
> >  			// other.
> > -			queue_rcu_work(system_wq, &krwp->rcu_work);
> > +			queued = queue_rcu_work(system_wq, &krwp->rcu_work);
> >  		}
> >  	}
> >  
> >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > +	return queued;
> > +}
> > +
> > +/*
> > + * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
> > + */
> > +static void kfree_rcu_monitor(struct work_struct *work)
> > +{
> > +	struct kfree_rcu_cpu *krcp = container_of(work,
> > +		struct kfree_rcu_cpu, monitor_work.work);
> > +
> > +	// Drain ready for reclaim.
> > +	kvfree_rcu_drain_ready(krcp);
> > +
> > +	// Queue a batch for a rest.
> > +	kvfree_rcu_queue_batch(krcp);
> >  
> >  	// If there is nothing to detach, it means that our job is
> >  	// successfully done here. In case of having at least one
> > @@ -3825,6 +3838,80 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> >  }
> >  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> >  
> > +/**
> > + * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
> > + *
> > + * Note that a single argument of kvfree_rcu() call has a slow path that
> > + * triggers synchronize_rcu() following by freeing a pointer. It is done
> > + * before the return from the function. Therefore for any single-argument
> > + * call that will result in a kfree() to a cache that is to be destroyed
> > + * during module exit, it is developer's responsibility to ensure that all
> > + * such calls have returned before the call to kmem_cache_destroy().
> > + */
> > +void kvfree_rcu_barrier(void)
> > +{
> > +	struct kfree_rcu_cpu_work *krwp;
> > +	struct kfree_rcu_cpu *krcp;
> > +	bool queued;
> > +	int i, cpu;
> > +
> > +	/*
> > +	 * Firstly we detach objects and queue them over an RCU-batch
> > +	 * for all CPUs. Finally queued works are flushed for each CPU.
> > +	 *
> > +	 * Please note. If there are outstanding batches for a particular
> > +	 * CPU, those have to be finished first following by queuing a new.
> > +	 */
> > +	for_each_possible_cpu(cpu) {
> > +		krcp = per_cpu_ptr(&krc, cpu);
> > +
> > +		/*
> > +		 * Check if this CPU has any objects which have been queued for a
> > +		 * new GP completion. If not(means nothing to detach), we are done
> > +		 * with it. If any batch is pending/running for this "krcp", below
> > +		 * per-cpu flush_rcu_work() waits its completion(see last step).
> > +		 */
> > +		if (!need_offload_krc(krcp))
> 
> Still trying to figure out the locking inside kfree_rcu(), but don't you
> need holding krcp->lock to performance these checks?
> 
Here we just need answer the question, "need" or not "need" in order to
bail out _early_ for this CPU. We are interested in _already_ in-flight
objects, i.e. the ones before entry to barrier function.

The reason why we have it is - it does not cost. In fact we could eliminate
it and directly queue a batch but it requires locking and more CPU cycles.

That is why there is such check :)

--
Uladzislau Rezki
