Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04636C433EF
	for <rcu@archiver.kernel.org>; Wed, 15 Jun 2022 08:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346817AbiFOIvd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jun 2022 04:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiFOIvc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jun 2022 04:51:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3691449CA5
        for <rcu@vger.kernel.org>; Wed, 15 Jun 2022 01:51:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08F24152B;
        Wed, 15 Jun 2022 01:51:31 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.38.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C94033F66F;
        Wed, 15 Jun 2022 01:51:29 -0700 (PDT)
Date:   Wed, 15 Jun 2022 09:51:18 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>, willy@infradead.org,
        urezki@gmail.com, rcu@vger.kernel.org, frederic@kernel.org
Subject: Re: [PATCH rcu/dev] RFC: temporarily reduce rcu tasks kthread sleep
 time for PROVE_RCU
Message-ID: <YqmdhhnPFcoHKC81@FVFF77S0Q05N>
References: <20220527003909.18998-1-zhouzhouyi@gmail.com>
 <20220607234209.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607234209.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Tue, Jun 07, 2022 at 04:42:09PM -0700, Paul E. McKenney wrote:
> On Fri, May 27, 2022 at 08:39:09AM +0800, Zhouyi Zhou wrote:
> > Sometimes, the kernel will boot too fast for rcu_tasks_verify_self_tests
> > to have all required grace periods.

As mentioned on IRC, with v5.19-rc2 I consistently see this on arm64 at boot
time, e.g.

| call_rcu_tasks() has been failed.
| ------------[ cut here ]------------
| WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1751 rcu_tasks_verify_self_tests+0x48/0x74
| Modules linked in:
| CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc2 #2
| Hardware name: linux,dummy-virt (DT)
| pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : rcu_tasks_verify_self_tests+0x48/0x74
| lr : rcu_tasks_verify_self_tests+0x6c/0x74
| sp : ffff80000800bd70
| x29: ffff80000800bd70 x28: 0000000000000000 x27: ffffbd05c97904c8
| x26: ffffbd05c98610a0 x25: 0000000000000007 x24: 0000000000000000
| x23: ffffbd05c9fa0b38 x22: ffffbd05ca42f000 x21: ffffbd05c9514ac0
| x20: ffffbd05ca038808 x19: ffffbd05ca038808 x18: 0000000000000030
| x17: 00000000808cf272 x16: 00000000b4c3fe3b x15: fffffffffffe4328
| x14: 0000000000000001 x13: 2e64656c69616620 x12: 6e65656220736168
| x11: 202928736b736174 x10: 5f7563725f6c6c61 x9 : 64656c696166206e
| x8 : 6565622073616820 x7 : 2928736b7361745f x6 : 7563725f6c6c6163
| x5 : ffff3f48ffbc0c80 x4 : 0000000000000000 x3 : 0000000000000000
| x2 : 0000000000000000 x1 : 0000000000000001 x0 : 00000000ffffffff
| Call trace:
|  rcu_tasks_verify_self_tests+0x48/0x74
|  do_one_initcall+0x74/0x400
|  kernel_init_freeable+0x2fc/0x384
|  kernel_init+0x28/0x130
|  ret_from_fork+0x10/0x20
| irq event stamp: 188396
| hardirqs last  enabled at (188395): [<ffffbd05c7d2b4f4>] vprintk_store+0x3e4/0x4b0
| hardirqs last disabled at (188396): [<ffffbd05c8d9a494>] el1_dbg+0x24/0x90
| softirqs last  enabled at (188302): [<ffffbd05c8b95910>] release_sock+0xac/0xd0
| softirqs last disabled at (188300): [<ffffbd05c8b9588c>] release_sock+0x28/0xd0
| ---[ end trace 0000000000000000 ]---
| registered taskstats version 1

I gave the below diff a go with:

* 100 UP boots
* 100 64-CPU SMP boots

... in a KVM VM on a ThunderX2 host, and out of those 200 boots I never saw the
warning.

So FWIW:

  Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks for this!

Just as an aside, I had to grab this thread from lore as I'm not subscribed to
the RCU list, so there might be others who haven't seen this thread.

Mark.

> commit 3e95d4b287b37ee5f7f82e5ebd749ab89fd706c2
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jun 7 15:23:52 2022 -0700
> 
>     rcu-tasks: Be more patient for RCU Tasks boot-time testing
>     
>     The RCU-Tasks family of grace-period primitives can take some time to
>     complete, and the amount of time can depend on the exact hardware and
>     software configuration.  Some configurations boot up fast enough that the
>     RCU-Tasks verification process gets false-positive failures.  This commit
>     therefore allows up to 30 seconds for the grace periods to complete, with
>     this value adjustable downwards using the rcupdate.rcu_task_stall_timeout
>     kernel boot parameter.
>     
>     Reported-by: Matthew Wilcox <willy@infradead.org>
>     Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index f1209ce621c51..1a4c3adc5c397 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -145,6 +145,7 @@ static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
>  module_param(rcu_task_ipi_delay, int, 0644);
>  
>  /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
> +#define RCU_TASK_BOOT_STALL_TIMEOUT (HZ * 30)
>  #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
>  static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
>  module_param(rcu_task_stall_timeout, int, 0644);
> @@ -1778,23 +1779,24 @@ struct rcu_tasks_test_desc {
>  	struct rcu_head rh;
>  	const char *name;
>  	bool notrun;
> +	unsigned long runstart;
>  };
>  
>  static struct rcu_tasks_test_desc tests[] = {
>  	{
>  		.name = "call_rcu_tasks()",
>  		/* If not defined, the test is skipped. */
> -		.notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
> +		.notrun = IS_ENABLED(CONFIG_TASKS_RCU),
>  	},
>  	{
>  		.name = "call_rcu_tasks_rude()",
>  		/* If not defined, the test is skipped. */
> -		.notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
> +		.notrun = IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
>  	},
>  	{
>  		.name = "call_rcu_tasks_trace()",
>  		/* If not defined, the test is skipped. */
> -		.notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
> +		.notrun = IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
>  	}
>  };
>  
> @@ -1805,23 +1807,28 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
>  
>  	pr_info("Callback from %s invoked.\n", rttd->name);
>  
> -	rttd->notrun = true;
> +	rttd->notrun = false;
>  }
>  
>  static void rcu_tasks_initiate_self_tests(void)
>  {
> +	unsigned long j = jiffies;
> +
>  	pr_info("Running RCU-tasks wait API self tests\n");
>  #ifdef CONFIG_TASKS_RCU
> +	tests[0].runstart = j;
>  	synchronize_rcu_tasks();
>  	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
>  #endif
>  
>  #ifdef CONFIG_TASKS_RUDE_RCU
> +	tests[1].runstart = j;
>  	synchronize_rcu_tasks_rude();
>  	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
>  #endif
>  
>  #ifdef CONFIG_TASKS_TRACE_RCU
> +	tests[2].runstart = j;
>  	synchronize_rcu_tasks_trace();
>  	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
>  #endif
> @@ -1831,11 +1838,18 @@ static int rcu_tasks_verify_self_tests(void)
>  {
>  	int ret = 0;
>  	int i;
> +	unsigned long bst = rcu_task_stall_timeout;
>  
> +	if (bst <= 0 || bst > RCU_TASK_BOOT_STALL_TIMEOUT)
> +		bst = RCU_TASK_BOOT_STALL_TIMEOUT;
>  	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> -		if (!tests[i].notrun) {		// still hanging.
> -			pr_err("%s has been failed.\n", tests[i].name);
> -			ret = -1;
> +		while (tests[i].notrun) {		// still hanging.
> +			if (time_after(jiffies, tests[i].runstart + bst)) {
> +				pr_err("%s has failed boot-time tests.\n", tests[i].name);
> +				ret = -1;
> +				break;
> +			}
> +			schedule_timeout_uninterruptible(1);
>  		}
>  	}
>  
> 
