Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E88C352A1
	for <rcu@archiver.kernel.org>; Wed, 30 Nov 2022 17:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiK3ROa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Nov 2022 12:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiK3ROJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Nov 2022 12:14:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950D7658D;
        Wed, 30 Nov 2022 09:11:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 302B261CF1;
        Wed, 30 Nov 2022 17:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919D6C433D6;
        Wed, 30 Nov 2022 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669828284;
        bh=My7V4d9WJLefteKBiB+Fp5Mig1pJRCVQN44U1DCKMX0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BL/cq+P7CfXp9V/yBDIsyefctZLkohFMSJfKQrxm//ysUD+fkYCPwLYMciA7tZDDz
         8zci5Eo9bBN9TwwZYew3O+xSmAxIlYt0VWUFDNVJYVMh5+rRWVEkIm1AFiS7u5R0tD
         Td9DaG0RaS5CZuBwyOgfjHch926fVSk/f88U6M+UBEU4346t3WYodjpZqrqmc9ekBR
         tESzEfm2t7ZEf0YE8bUk2p9urh2t+mNaWQoEML2H5P2GHGXuMkeBiMe4p0pHv15Ywl
         ZTlri9mmXpc7fpu6aiZV36S6jPownmPNKBKAAKe2CMfdV46gj8GYLJjpQOyw3PNsfl
         aOx4JKz0RlPOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4658F5C051C; Wed, 30 Nov 2022 09:11:24 -0800 (PST)
Date:   Wed, 30 Nov 2022 09:11:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Message-ID: <20221130171124.GO4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221130012445.1863104-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130012445.1863104-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 30, 2022 at 09:24:45AM +0800, Zqiang wrote:
> Currently, invoke rcu_tasks_rude_wait_gp() to wait one rude
> RCU-tasks grace period, if __num_online_cpus == 1, will return
> directly, indicates the end of the rude RCU-task grace period.
> suppose the system has two cpus, consider the following scenario:
> 
>         CPU0                                   CPU1 (going offline)
>                                           migration/1 task:
>                                       cpu_stopper_thread
>                                        -> take_cpu_down
>                                           -> _cpu_disable
>                                            (dec __num_online_cpus)
>                                           ->cpuhp_invoke_callback
>                                                 preempt_disable
>                                                 access old_data0
>            task1
>  del old_data0                                  .....
>  synchronize_rcu_tasks_rude()
>  task1 schedule out
>  ....
>  task2 schedule in
>  rcu_tasks_rude_wait_gp()
>      ->__num_online_cpus == 1
>        ->return
>  ....
>  task1 schedule in
>  ->free old_data0
>                                                 preempt_enable
> 
> when CPU1 dec __num_online_cpus and __num_online_cpus is equal one,
> the CPU1 has not finished offline, stop_machine task(migration/1)
> still running on CPU1, maybe still accessing 'old_data0', but the
> 'old_data0' has freed on CPU0.
> 
> In order to prevent the above scenario from happening, this commit
> remove check for __num_online_cpus == 0 and add handling of calling
> synchronize_rcu_tasks_generic() during early boot(when the
> rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE, the scheduler
> not yet initialized and only one boot-CPU online).
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tasks.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 4dda8e6e5707..e4f7d08bde64 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -560,8 +560,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
>  {
>  	/* Complain if the scheduler has not started.  */
> -	WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
> -			 "synchronize_rcu_tasks called too soon");
> +	if (WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
> +			"synchronize_rcu_tasks called too soon"))

Much better, thank you!

But as long as you are touching this line of code, could you please also
fix it to print rtp->name instead of "synchronize_rcu_tasks"?

							Thanx, Paul

> +		return;
>  
>  	// If the grace-period kthread is running, use it.
>  	if (READ_ONCE(rtp->kthread_ptr)) {
> @@ -1064,9 +1065,6 @@ static void rcu_tasks_be_rude(struct work_struct *work)
>  // Wait for one rude RCU-tasks grace period.
>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>  {
> -	if (num_online_cpus() <= 1)
> -		return;	// Fastpath for only one CPU.
> -
>  	rtp->n_ipis += cpumask_weight(cpu_online_mask);
>  	schedule_on_each_cpu(rcu_tasks_be_rude);
>  }
> -- 
> 2.25.1
> 
