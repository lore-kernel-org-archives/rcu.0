Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7C62904;
	Wed, 26 Feb 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585102; cv=none; b=TgvWW17cYPZJKZVytXBXKtPhHaLREZHOmXg2wAf4UgSK569yeXK1ulwZ93sR8uAiZTB6nK5IX3PYbCOqmxobN9pJl7ohaKJjTMIUs7aq2OtU1TygpcMhfOXIm2ZzDQEBZdOkvkaeBgSM+FmIykBruwoNtSqFTKzVyNmPV8VRJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585102; c=relaxed/simple;
	bh=dystgmSF/TCO8+uxX80prLd9mmlEKMg2wmXGUfrA378=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cD2PbHZ1dbmstvKL3M3eDvyPylXut+c9LD9vVUhGNX+COSxQM9QaYSNRiGdl3v9wHMttOJkYK3emTLPhDBVyMzBz8xwBI8LsicxHy1u8HZ+flnHlIk0PlcWOaig6Ybes1+VmyaY0jOicBwnbv/v9y6hcDIHhIKmIF3bWPGccFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/wtZVHD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/wtZVHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B506C4CED6;
	Wed, 26 Feb 2025 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740585101;
	bh=dystgmSF/TCO8+uxX80prLd9mmlEKMg2wmXGUfrA378=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/wtZVHDOkcHb7Wj/XoTGhFH+jxWlVoY/3JmSc85XIsQBGuD3Gxmv325CJ64iW62I
	 sLn3ueeKUKKEkkKxXG1r3zuySs0GQNjC2xBBRb9EJlIYFWS6GbsPUfrvvmRV2a6dvf
	 XZAXHrOF0l30oLCks2wqUQnLjyU0cWBHUEWG6Y+ePaw0Mbm1ktvpkoGZBHjhBfKYwi
	 B7uFEabl3vRtrjctHeND1AeJpBZ72c+gaKOg/ZzNTibJxVnK7fN2grML69IQB6MsBH
	 BpVyRJswqscjYs7RJNdAbTx/Zlf0XO+ANH2X/3e4oTROLG/KcresZY91V6qxiCWYPA
	 BqIqJwDfWeC1Q==
Date: Wed, 26 Feb 2025 08:51:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Keith Busch <keith.busch@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-nvme@lists.infradead.org,
	leitao@debian.org
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Message-ID: <Z784iRR13v6SkJv5@kbusch-mbp>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
 <Z74KHyGGMzkhx5f-@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z74KHyGGMzkhx5f-@pc636>

On Tue, Feb 25, 2025 at 07:21:19PM +0100, Uladzislau Rezki wrote:
> WQ_MEM_RECLAIM-patch fixes this for me:

This is successful with the new kuint test for me as well. I can't
readily test this in production where I first learned of this issue (at
least not in the near term), but for what it's worth, this looks like a
good change to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
> <snip>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4030907b6b7d..1b5ed5512782 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1304,6 +1304,8 @@ module_param(rcu_min_cached_objs, int, 0444);
>  static int rcu_delay_page_cache_fill_msec = 5000;
>  module_param(rcu_delay_page_cache_fill_msec, int, 0444);
> 
> +static struct workqueue_struct *rcu_reclaim_wq;
> +
>  /* Maximum number of jiffies to wait before draining a batch. */
>  #define KFREE_DRAIN_JIFFIES (5 * HZ)
>  #define KFREE_N_BATCHES 2
> @@ -1632,10 +1634,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>         if (delayed_work_pending(&krcp->monitor_work)) {
>                 delay_left = krcp->monitor_work.timer.expires - jiffies;
>                 if (delay < delay_left)
> -                       mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> +                       mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
>                 return;
>         }
> -       queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> +       queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
>  }
> 
>  static void
> @@ -1733,7 +1735,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
>                         // "free channels", the batch can handle. Break
>                         // the loop since it is done with this CPU thus
>                         // queuing an RCU work is _always_ success here.
> -                       queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
> +                       queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
>                         WARN_ON_ONCE(!queued);
>                         break;
>                 }
> @@ -1883,7 +1885,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>         if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>                         !atomic_xchg(&krcp->work_in_progress, 1)) {
>                 if (atomic_read(&krcp->backoff_page_cache_fill)) {
> -                       queue_delayed_work(system_unbound_wq,
> +                       queue_delayed_work(rcu_reclaim_wq,
>                                 &krcp->page_cache_work,
>                                         msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
>                 } else {
> @@ -2120,6 +2122,10 @@ void __init kvfree_rcu_init(void)
>         int i, j;
>         struct shrinker *kfree_rcu_shrinker;
> 
> +       rcu_reclaim_wq = alloc_workqueue("rcu_reclaim",
> +               WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
> +       WARN_ON(!rcu_reclaim_wq);
> +
>         /* Clamp it to [0:100] seconds interval. */
>         if (rcu_delay_page_cache_fill_msec < 0 ||
>                 rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
> <snip>
