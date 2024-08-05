Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0661514E1;
	Mon,  5 Aug 2024 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874400; cv=none; b=Avs2HlZByKa9YRzTsJRZ9l5tiAe0Fj5HboUSM4lWjO0KXdCyL4ogM/Z3Hm9uyuVv0IOft6YneF1KGsyStI8Yz1PRxhaH1/ExU7wrjR3MIULxv42TuLnDoo68emRAQIhz9PznZ9oZ1apRK/EVXXiU5nfEyJYvTm6PRl5yr+gbFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874400; c=relaxed/simple;
	bh=heTlOsnvrlkYyRenUAvoRgHep2KthxBZvpaFf043SUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZXY5XHCj5ldzOf11rlTT+AQGn8pAWdyAfjf7gLOW7/tsAlUt7zYgq+7JXc9h84tw7cnrV/9OeQlL/HQYjHGskZqJsxOv1vdIrDqZMG71deD/qDnetYjX+Vb9GOCDY89jifz1/H+CjGRyNcfV3aVgWT4B+28KCek8teVBUzwFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doipdU9i; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doipdU9i"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-66599ca3470so91491287b3.2;
        Mon, 05 Aug 2024 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722874397; x=1723479197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmwnsEoHbAY87EuQU9lnZlUpz9Uh5Ddif/oMnbsSZCc=;
        b=doipdU9im6m2U+XjKD/M7GV9KmCTstrcf3Fsc6+Irn+R2M7J5l6RFllt7s0l8VMcrU
         6IEDwsnV79kJ8ULdUhwDB+pdRTvIZEXFakPdH0x5ovy6XBtHqIyUGeA+rwv0eXMnyG3E
         mpeGv+vRREuICDPgyH9OV7Rc7o+Iphabe4uWJbVAWsY6NWwlrNPuP0Nqx60R2+hDuLUu
         bxVSl2Et/VfGMsc/JktqPvJG75293M711zhelDmttU2tZVdPZ8xbES+PczbxpvqQrnl/
         C1iseOe77eBvY+GLrj38jk6nDv5ePc8CtvnM0IdMuqx1La0tc7mxlHbcgiJJ/BulTPlH
         nzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722874397; x=1723479197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmwnsEoHbAY87EuQU9lnZlUpz9Uh5Ddif/oMnbsSZCc=;
        b=vw+Ht9StBNYMOr5nKfrFbBpZkTDyzIV45/YB3RD5lzXIsE/G+GfNkQ5KI4KQAp2Zdl
         mOcNm6GnzuGrvYDZ+ABKl/ppfOJpBqwhZqAdIscD7HMUabPGeml2VeGn5lDxDS+Xl6UC
         rx90P8SjE+vdnfKqLtQ0qYJ4qzDU8UIbr5UbgFcezMilje9X2FTwoK3lD4xuyIRyQhl9
         Ne5uCwKOckxIX4XqCJaOrhaPQ0evsZHwXarHu+b7c6NYLaVWAEjgJ1lvxEZHafLoFsru
         kX6XWPwsfvT9z8GKjtLsDT4dNNF+xK7Nb6M/FtGowXJ5gDb7H48ZH32mts+8Tgpj7J96
         g+uA==
X-Forwarded-Encrypted: i=1; AJvYcCV+Qal95+gvxoBxUcTz5BaSKRqfv2NixsUo686HPCyY9/llRcNmYBCEyR6dEom2BDOViGNInXaVAkL6Txt8ridn5h5aGC4WFZa79DDPFtF9Vo4cRjpEc0IIdLa124VYNusa
X-Gm-Message-State: AOJu0YzoKL9Pk7OAB7OaOH99mRusNP9ojYlHEVueQvHqoehOz7ClWOmx
	icYV7zw/SG0Nmfb6owMPthcpuKegEo7kW8/Hi4hAFFYA90WgKc5G
X-Google-Smtp-Source: AGHT+IHN3aad2Wyqnis/9hpIDfEq15oOWP/Hvs90/pTbu/WCdAywybczz/U+ppOhRgHVP++FthyJXg==
X-Received: by 2002:a05:690c:2a44:b0:689:d89a:ecf4 with SMTP id 00721157ae682-689d89af2ddmr108995887b3.36.1722874397350;
        Mon, 05 Aug 2024 09:13:17 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78abfbsm36977226d6.30.2024.08.05.09.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:13:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 52025120006B;
	Mon,  5 Aug 2024 12:13:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 12:13:16 -0400
X-ME-Sender: <xms:HPqwZvDcH4cf2qvne7gC_agaKuGUFXu8F1Ei-Js6JgwDlST-yIIbEw>
    <xme:HPqwZljORj7vtem-pDM-ZW5bbBJ0XjQC1x0Qo-U-Ku_mDC8AR5n8HC19xfLpd7UmM
    EhIc4Oe4nkKzYRaRA>
X-ME-Received: <xmr:HPqwZqlDCaLdot984MvKnxqZJXYl88CGpx6rQGNUHtZJyEOj9Z7sHCvuYH8gAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:HPqwZhwRa4OGviHAfyV0KH6QhBpbQuiER-RV7dvKabM4T6OL3SBNCQ>
    <xmx:HPqwZkQ1CXCUxLIPqpaV6uzT7HB8hdRlb5q36eXbSTm5hFeE3DcOxg>
    <xmx:HPqwZkZiXY1moWhy4QID3hrsVwUkV7w42HOqH6yOv--FzREYaHcMHA>
    <xmx:HPqwZlRNM9bkdeqNS88xC2lkAF5nTVIlgqtGMAoEumFpGYFyVobd7w>
    <xmx:HPqwZqAxcnUdC2C4pcBYcg4ciysDwZRderxj7Ch_8Arscep7kRCyroWT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 12:13:15 -0400 (EDT)
Date: Mon, 5 Aug 2024 09:12:15 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/kvfree: Add kvfree_rcu_barrier() API
Message-ID: <ZrD537_itA2sWQoA@boqun-archlinux>
References: <20240801111039.79656-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801111039.79656-1-urezki@gmail.com>

On Thu, Aug 01, 2024 at 01:10:39PM +0200, Uladzislau Rezki (Sony) wrote:
> Add a kvfree_rcu_barrier() function. It waits until all
> in-flight pointers are freed over RCU machinery. It does
> not wait any GP completion and it is within its right to
> return immediately if there are no outstanding pointers.
> 
> This function is useful when there is a need to guarantee
> that a memory is fully freed before destroying memory caches.
> For example, during unloading a kernel module.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcutiny.h |   5 ++
>  include/linux/rcutree.h |   1 +
>  kernel/rcu/tree.c       | 103 ++++++++++++++++++++++++++++++++++++----
>  3 files changed, 101 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index d9ac7b136aea..522123050ff8 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -111,6 +111,11 @@ static inline void __kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	kvfree(ptr);
>  }
>  
> +static inline void kvfree_rcu_barrier(void)
> +{
> +	rcu_barrier();
> +}
> +
>  #ifdef CONFIG_KASAN_GENERIC
>  void kvfree_call_rcu(struct rcu_head *head, void *ptr);
>  #else
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 254244202ea9..58e7db80f3a8 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -35,6 +35,7 @@ static inline void rcu_virt_note_context_switch(void)
>  
>  void synchronize_rcu_expedited(void);
>  void kvfree_call_rcu(struct rcu_head *head, void *ptr);
> +void kvfree_rcu_barrier(void);
>  
>  void rcu_barrier(void);
>  void rcu_momentary_dyntick_idle(void);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 28c7031711a3..1423013f9fe6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3550,18 +3550,15 @@ kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
>  }
>  
>  /*
> - * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
> + * Return: %true if a work is queued, %false otherwise.
>   */
> -static void kfree_rcu_monitor(struct work_struct *work)
> +static bool
> +kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
>  {
> -	struct kfree_rcu_cpu *krcp = container_of(work,
> -		struct kfree_rcu_cpu, monitor_work.work);
>  	unsigned long flags;
> +	bool queued = false;
>  	int i, j;
>  
> -	// Drain ready for reclaim.
> -	kvfree_rcu_drain_ready(krcp);
> -
>  	raw_spin_lock_irqsave(&krcp->lock, flags);
>  
>  	// Attempt to start a new batch.
> @@ -3600,11 +3597,27 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			// be that the work is in the pending state when
>  			// channels have been detached following by each
>  			// other.
> -			queue_rcu_work(system_wq, &krwp->rcu_work);
> +			queued = queue_rcu_work(system_wq, &krwp->rcu_work);
>  		}
>  	}
>  
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +	return queued;
> +}
> +
> +/*
> + * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
> + */
> +static void kfree_rcu_monitor(struct work_struct *work)
> +{
> +	struct kfree_rcu_cpu *krcp = container_of(work,
> +		struct kfree_rcu_cpu, monitor_work.work);
> +
> +	// Drain ready for reclaim.
> +	kvfree_rcu_drain_ready(krcp);
> +
> +	// Queue a batch for a rest.
> +	kvfree_rcu_queue_batch(krcp);
>  
>  	// If there is nothing to detach, it means that our job is
>  	// successfully done here. In case of having at least one
> @@ -3825,6 +3838,80 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
>  
> +/**
> + * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
> + *
> + * Note that a single argument of kvfree_rcu() call has a slow path that
> + * triggers synchronize_rcu() following by freeing a pointer. It is done
> + * before the return from the function. Therefore for any single-argument
> + * call that will result in a kfree() to a cache that is to be destroyed
> + * during module exit, it is developer's responsibility to ensure that all
> + * such calls have returned before the call to kmem_cache_destroy().
> + */
> +void kvfree_rcu_barrier(void)
> +{
> +	struct kfree_rcu_cpu_work *krwp;
> +	struct kfree_rcu_cpu *krcp;
> +	bool queued;
> +	int i, cpu;
> +
> +	/*
> +	 * Firstly we detach objects and queue them over an RCU-batch
> +	 * for all CPUs. Finally queued works are flushed for each CPU.
> +	 *
> +	 * Please note. If there are outstanding batches for a particular
> +	 * CPU, those have to be finished first following by queuing a new.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		krcp = per_cpu_ptr(&krc, cpu);
> +
> +		/*
> +		 * Check if this CPU has any objects which have been queued for a
> +		 * new GP completion. If not(means nothing to detach), we are done
> +		 * with it. If any batch is pending/running for this "krcp", below
> +		 * per-cpu flush_rcu_work() waits its completion(see last step).
> +		 */
> +		if (!need_offload_krc(krcp))

Still trying to figure out the locking inside kfree_rcu(), but don't you
need holding krcp->lock to performance these checks?

Regards,
Boqun

> +			continue;
> +
> +		while (1) {
> +			/*
> +			 * If we are not able to queue a new RCU work it means:
> +			 * - batches for this CPU are still in flight which should
> +			 *   be flushed first and then repeat;
> +			 * - no objects to detach, because of concurrency.
> +			 */
> +			queued = kvfree_rcu_queue_batch(krcp);
> +
> +			/*
> +			 * Bail out, if there is no need to offload this "krcp"
> +			 * anymore. As noted earlier it can run concurrently.
> +			 */
> +			if (queued || !need_offload_krc(krcp))
> +				break;
> +
> +			/* There are ongoing batches. */
> +			for (i = 0; i < KFREE_N_BATCHES; i++) {
> +				krwp = &(krcp->krw_arr[i]);
> +				flush_rcu_work(&krwp->rcu_work);
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * Now we guarantee that all objects are flushed.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		krcp = per_cpu_ptr(&krc, cpu);
> +
> +		for (i = 0; i < KFREE_N_BATCHES; i++) {
> +			krwp = &(krcp->krw_arr[i]);
> +			flush_rcu_work(&krwp->rcu_work);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
> +
>  static unsigned long
>  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  {
> -- 
> 2.39.2
> 
