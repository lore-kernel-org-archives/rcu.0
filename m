Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62512C43381
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 12:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC6164F34
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 12:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbhCDL7p (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Mar 2021 06:59:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:8070 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239682AbhCDL7m (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 Mar 2021 06:59:42 -0500
IronPort-SDR: UrnLBjMoHGx5EbNWMihUGN2hLj93FjDOvntr84cW3U/qiN3i/HYG25519sTA9tXK9kKMw38tRz
 7AW3zPoQyTaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="184989654"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="184989654"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 03:59:01 -0800
IronPort-SDR: VblYH86PkOAJfSht4+uTOTPNr/R/oWUW0zBJP7aRvjGaRGXI1E+bPeE0sycFlrtFS0P+ykApj1
 iVy14uplVX2w==
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="445704561"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.135.211]) ([10.249.135.211])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 03:58:56 -0800
Subject: Re: [PATCH tip/core/rcu 02/12] timer: Report ignored local enqueue in
 nohz mode
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
 <20210304002311.23655-2-paulmck@kernel.org>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <a1bac9f6-cc67-943d-0f88-aad2f2b46bd7@intel.com>
Date:   Thu, 4 Mar 2021 12:58:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304002311.23655-2-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 3/4/2021 1:23 AM, paulmck@kernel.org wrote:
> From: Frederic Weisbecker <frederic@kernel.org>
>
> Enqueuing a local timer after the tick has been stopped will result in
> the timer being ignored until the next random interrupt.
>
> Perform sanity checks to report these situations.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar<mingo@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   kernel/sched/core.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ca2bb62..4822371 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -674,6 +674,26 @@ int get_nohz_timer_target(void)
>   	return cpu;
>   }
>   
> +static void wake_idle_assert_possible(void)
> +{
> +#ifdef CONFIG_SCHED_DEBUG
> +	/* Timers are re-evaluated after idle IRQs */
> +	if (in_hardirq())
> +		return;
> +	/*
> +	 * Same as hardirqs, assuming they are executing
> +	 * on IRQ tail. Ksoftirqd shouldn't reach here
> +	 * as the timer base wouldn't be idle. And inline
> +	 * softirq processing after a call to local_bh_enable()
> +	 * within idle loop sound too fun to be considered here.
> +	 */
> +	if (in_serving_softirq())
> +		return;
> +
> +	WARN_ON_ONCE("Late timer enqueue may be ignored\n");
> +#endif
> +}
> +
>   /*
>    * When add_timer_on() enqueues a timer into the timer wheel of an
>    * idle CPU then this timer might expire before the next timer event
> @@ -688,8 +708,10 @@ static void wake_up_idle_cpu(int cpu)
>   {
>   	struct rq *rq = cpu_rq(cpu);
>   
> -	if (cpu == smp_processor_id())
> +	if (cpu == smp_processor_id()) {
> +		wake_idle_assert_possible();
>   		return;
> +	}
>   
>   	if (set_nr_and_not_polling(rq->idle))
>   		smp_send_reschedule(cpu);


