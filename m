Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7911C433EF
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 23:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359683AbiELX6Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 19:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359694AbiELX6X (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 19:58:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC28216840
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 16:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07ADDB8200D
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 23:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8506C385B8;
        Thu, 12 May 2022 23:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652399898;
        bh=vsdyd2Yic2+481u+Z9yjSbnBvmetFR0Qblbwv446zKs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Td2Nfut6OoAfRABFDuaYvpPuXkqSSb9MX0bmymT4ndDn4YS47w4g7nAbV5eqoKdoZ
         ntvL991rSlKO/DTKslol8F8EGLcOEOGcX1Xrhn67icby0Umgdh/8xPunUn/pXdqYeq
         J+mHsQt7JdM/S5RYA+qvYUui/75IH1HzpmArmYaz5wsWP4OS+SG7mPOHrggaPAXV7p
         MShHinqwJPuQPf2CdbaBEHqCdM5ZnIaYzcxe5GlxNo1ByTjHt72g/LEyhJ1pykOauw
         X3X4NJCtRuVIPVeVwxWl4Fco2xxCNTMVdvjaKofyaFi3YZezkCE4Whh5OlYPwM510d
         DVKqWtDLMGRkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4DFE05C051B; Thu, 12 May 2022 16:58:18 -0700 (PDT)
Date:   Thu, 12 May 2022 16:58:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 02/14] workqueue: Add a lazy version of queue_rcu_work()
Message-ID: <20220512235818.GV1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512030442.2530552-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 03:04:30AM +0000, Joel Fernandes (Google) wrote:
> This will be used in kfree_rcu() later to make it do call_rcu() lazily.

Given that kfree_rcu() does its own laziness in filling in the page
of pointers, do we really need to add additional laziness?

Or are you measuring a significant benefit from doing this?

							Thanx, Paul

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/workqueue.h |  1 +
>  kernel/workqueue.c        | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 7fee9b6cfede..2678a6b5b3f3 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -444,6 +444,7 @@ extern bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
>  extern bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
>  			struct delayed_work *dwork, unsigned long delay);
>  extern bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork);
> +extern bool queue_rcu_work_lazy(struct workqueue_struct *wq, struct rcu_work *rwork);
>  
>  extern void flush_workqueue(struct workqueue_struct *wq);
>  extern void drain_workqueue(struct workqueue_struct *wq);
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 33f1106b4f99..9444949cc148 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1796,6 +1796,31 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
>  }
>  EXPORT_SYMBOL(queue_rcu_work);
>  
> +/**
> + * queue_rcu_work_lazy - queue work after a RCU grace period
> + * @wq: workqueue to use
> + * @rwork: work to queue
> + *
> + * Return: %false if @rwork was already pending, %true otherwise.  Note
> + * that a full RCU grace period is guaranteed only after a %true return.
> + * While @rwork is guaranteed to be executed after a %false return, the
> + * execution may happen before a full RCU grace period has passed.
> + */
> +bool queue_rcu_work_lazy(struct workqueue_struct *wq, struct rcu_work *rwork)
> +{
> +	struct work_struct *work = &rwork->work;
> +
> +	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> +		rwork->wq = wq;
> +		call_rcu_lazy(&rwork->rcu, rcu_work_rcufn);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(queue_rcu_work_lazy);
> +
> +
>  /**
>   * worker_enter_idle - enter idle state
>   * @worker: worker which is entering idle state
> -- 
> 2.36.0.550.gb090851708-goog
> 
