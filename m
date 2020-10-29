Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8C1C55179
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 19:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8891620759
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604000846;
	bh=V+V07lhCpUF+HCTBfLkbtZeP+0HuQ4h1rnvCaQcraac=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=gxSmNaEuxgamqACy5DKT3r99lI2OdgVKbz33LyczRWGFqTNNqDbBjqL8a6SGWnNWl
	 5PC2lOFX2629I3GSOdeKYaL8vHwOI9N8Ft/wE7k9fMzFVvFNdHv5BAmmVwolDWRWG/
	 kmaCC4rOGBVaGDBp05Zu4DhrZ3Aik82GVPPCB9c0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgJ2Tr0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 15:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgJ2TrZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 15:47:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C31B206E9;
        Thu, 29 Oct 2020 19:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604000844;
        bh=V+V07lhCpUF+HCTBfLkbtZeP+0HuQ4h1rnvCaQcraac=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U6VjP+Xo1MSj+0E80L039VzWiUeNXGCantpn6Sh5nexsYBqSV/FNZQ6lSOO1nh89y
         ZvUOKZrLN7W+f7B+WEBe+AnP1G1Qa5OVww873jyQRLnwdTyGB2YxE0x8Sw5bVHFloG
         JGrnauY3MC9itKkNdLzjWx0vAepjciDMog7ZIJJY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1793935225E2; Thu, 29 Oct 2020 12:47:24 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:47:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 16/16] rcu/tree: Use delayed work instead of hrtimer to
 refill the cache
Message-ID: <20201029194724.GN3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201029165019.14218-16-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029165019.14218-16-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 29, 2020 at 05:50:19PM +0100, Uladzislau Rezki (Sony) wrote:
> A CONFIG_PREEMPT_COUNT is unconditionally enabled, thus a page
> can be obtained directly from a kvfree_rcu() path. To distinguish
> that and take a decision the preemptable() macro is used when it
> is save to enter allocator.
> 
> It means that refilling a cache is not important from timing point
> of view. Switch to a delayed work, so the actual work is queued from
> the timer interrupt with 1 jiffy delay. An immediate placing a task
> on a current CPU can lead to rq->lock double lock. That is why a
> delayed method is in place.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you, Uladzislau!

I applied this on top of v5.10-rc1 and got the following from the
single-CPU builds:

  SYNC    include/config/auto.conf.cmd
  DESCEND  objtool
  CC      kernel/bounds.s
  CALL    scripts/atomic/check-atomics.sh
  UPD     include/generated/bounds.h
  CC      arch/x86/kernel/asm-offsets.s
In file included from ./include/asm-generic/atomic-instrumented.h:20:0,
                 from ./include/linux/atomic.h:82,
                 from ./include/linux/crypto.h:15,
                 from arch/x86/kernel/asm-offsets.c:9:
./include/linux/pagemap.h: In function ‘__page_cache_add_speculative’:
./include/linux/build_bug.h:30:34: error: called object is not a function or function pointer
 #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
                                 ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/mmdebug.h:45:25: note: in expansion of macro ‘BUILD_BUG_ON_INVALID’
 #define VM_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)
                         ^~~~~~~~~~~~~~~~~~~~
./include/linux/pagemap.h:207:2: note: in expansion of macro ‘VM_BUG_ON’
  VM_BUG_ON(preemptible())
  ^~~~~~~~~
scripts/Makefile.build:117: recipe for target 'arch/x86/kernel/asm-offsets.s' failed
make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
Makefile:1199: recipe for target 'prepare0' failed
make: *** [prepare0] Error 2

I vaguely recall something like this showing up in the previous series
and that we did something or another to address it.  Could you please
check against the old series at -rcu branch dev.2020.10.22a?  (I verified
that the old series does run correctly in the single-CPU scenarios.)

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3f9b016a44dc..9ea55f800b4b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3086,7 +3086,6 @@ struct kfree_rcu_cpu_work {
>   *	per-cpu lock.
>   * @page_cache_work: A work to refill the cache when it is empty
>   * @work_in_progress: Indicates that page_cache_work is running
> - * @hrtimer: A hrtimer for scheduling a page_cache_work
>   * @nr_bkv_objs: number of allocated objects at @bkvcache.
>   *
>   * This is a per-CPU structure.  The reason that it is not included in
> @@ -3104,9 +3103,8 @@ struct kfree_rcu_cpu {
>  	bool initialized;
>  	int count;
>  
> -	struct work_struct page_cache_work;
> +	struct delayed_work page_cache_work;
>  	atomic_t work_in_progress;
> -	struct hrtimer hrtimer;
>  
>  	struct llist_head bkvcache;
>  	int nr_bkv_objs;
> @@ -3355,22 +3353,12 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  }
>  
> -static enum hrtimer_restart
> -schedule_page_work_fn(struct hrtimer *t)
> -{
> -	struct kfree_rcu_cpu *krcp =
> -		container_of(t, struct kfree_rcu_cpu, hrtimer);
> -
> -	queue_work(system_highpri_wq, &krcp->page_cache_work);
> -	return HRTIMER_NORESTART;
> -}
> -
>  static void fill_page_cache_func(struct work_struct *work)
>  {
>  	struct kvfree_rcu_bulk_data *bnode;
>  	struct kfree_rcu_cpu *krcp =
>  		container_of(work, struct kfree_rcu_cpu,
> -			page_cache_work);
> +			page_cache_work.work);
>  	unsigned long flags;
>  	bool pushed;
>  	int i;
> @@ -3398,12 +3386,8 @@ static void
>  run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  {
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> -			!atomic_xchg(&krcp->work_in_progress, 1)) {
> -		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
> -			HRTIMER_MODE_REL);
> -		krcp->hrtimer.function = schedule_page_work_fn;
> -		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
> -	}
> +			!atomic_xchg(&krcp->work_in_progress, 1))
> +		schedule_delayed_work(&krcp->page_cache_work, 1);
>  }
>  
>  // Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
> @@ -4503,7 +4487,7 @@ static void __init kfree_rcu_batch_init(void)
>  		}
>  
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> -		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
> +		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
>  		krcp->initialized = true;
>  	}
>  	if (register_shrinker(&kfree_rcu_shrinker))
> -- 
> 2.20.1
> 
