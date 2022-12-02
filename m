Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C6C4332F
	for <rcu@archiver.kernel.org>; Fri,  2 Dec 2022 19:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiLBT50 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Dec 2022 14:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLBT5Z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 2 Dec 2022 14:57:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC51BEE958;
        Fri,  2 Dec 2022 11:57:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EB1F62237;
        Fri,  2 Dec 2022 19:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E890C433D6;
        Fri,  2 Dec 2022 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670011043;
        bh=acLl0i6Ws/i0Io5d6dMkIRF0Fh8/UGGdP7tcPSuvFLY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eE+VVFxQskQjOSvQjiHlUv7GnJBc3WzIHD9IvX9jEmiW6lSuVvwOOWniGONNE6OUv
         QTKkN1oV6OHMvbTA3R7XkaPz//JcrhMiSVi/HOX+Zy8OxAjCng+T7TfLMDhSQSi2Bt
         L4mNRSWFL8pBM+n/1r+NcRpK9HphWyVd1ddQE4koOhh9zz1sxU30rdVo5OU0ntHrIz
         HkfedLIflKQXGmcliYo1DWKBmLEj52FPq1ITp9Oz3NblXMUXIKbbnSh11YNxMwBgDk
         0ZZ3HsZhvaHfuwGDGF3DKX8IB3fGFuMP6nu3AjWFPL2GKdl0eN7qmXVo6d1Tgxk2WG
         3FIOAGVK+rBGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 39B795C095D; Fri,  2 Dec 2022 11:57:23 -0800 (PST)
Date:   Fri, 2 Dec 2022 11:57:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Make shrink down to a single callback queue
 safely
Message-ID: <20221202195723.GB4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221130051253.1884572-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130051253.1884572-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 30, 2022 at 01:12:53PM +0800, Zqiang wrote:
> Assume that the current RCU-task belongs to per-CPU callback queuing
> mode and the rcu_task_cb_adjust is true.
> 
>       CPU0					CPU1
> 
> rcu_tasks_need_gpcb()
>   ncbsnz == 0 and
>   ncbs < rcu_task_collapse_lim
> 
> 					      invoke call_rcu_tasks_generic()
> 						 enqueue callback to CPU1
> 					        (CPU1 n_cbs not equal zero)
> 
>   if (rcu_task_cb_adjust &&
>   ncbs <= rcu_task_collapse_lim)
>     if (rtp->percpu_enqueue_lim > 1)
>       rtp->percpu_enqueue_lim = 1;
>       rtp->percpu_dequeue_gpseq =
>       get_state_synchronize_rcu();
> 
> 
>   A full RCU grace period has passed

I don't see how this grace period can elapse.  The rcu_tasks_need_gpcb()
function is invoked only from rcu_tasks_one_gp(), and while holding
->tasks_gp_mutex.

What am I missing here?

							Thanx, Paul

>   if (rcu_task_cb_adjust && !ncbsnz &&
>   poll_state_synchronize_rcu(
>     rtp->percpu_dequeue_gpseq) == true
>     if (rtp->percpu_enqueue_lim <
> 	rtp->percpu_dequeue_lim)
>         rtp->percpu_dequeue_lim = 1
>     for (cpu = rtp->percpu_dequeue_lim;
>         cpu < nr_cpu_ids; cpu++)
>         find CPU1 n_cbs is not zero
>         trigger warning
> 
> The above scenario will not only trigger WARN_ONCE(), but also set the
> rcu_tasks structure's->percpu_dequeue_lim is one when CPU1 still have
> callbacks, which will cause the callback of CPU1 to have no chance to be
> called.
> 
> This commit add per-cpu callback check(except CPU0) before set the rcu_tasks
> structure's->percpu_dequeue_lim to one, if other CPUs(except CPU0) still have
> callback, not set the rcu_tasks structure's->percpu_dequeue_lim to one, set it
> until the all CPUs(except CPU0) has no callback.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tasks.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index e4f7d08bde64..690af479074f 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -433,14 +433,17 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>  	    poll_state_synchronize_rcu(rtp->percpu_dequeue_gpseq)) {
>  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
>  		if (rtp->percpu_enqueue_lim < rtp->percpu_dequeue_lim) {
> +			for (cpu = rtp->percpu_enqueue_lim; cpu < nr_cpu_ids; cpu++) {
> +				struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
> +
> +				if(rcu_segcblist_n_cbs(&rtpcp->cblist)) {
> +					raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> +					return needgpcb;
> +				}
> +			}
>  			WRITE_ONCE(rtp->percpu_dequeue_lim, 1);
>  			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
>  		}
> -		for (cpu = rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
> -			struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
> -
> -			WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
> -		}
>  		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
>  	}
>  
> -- 
> 2.25.1
> 
