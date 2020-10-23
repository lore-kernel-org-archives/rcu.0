Return-Path: <SRS0=TpT1=D6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0816C388F9
	for <rcu@archiver.kernel.org>; Fri, 23 Oct 2020 19:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BEA621582
	for <rcu@archiver.kernel.org>; Fri, 23 Oct 2020 19:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbgJWT3c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 23 Oct 2020 15:29:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45809 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753115AbgJWT3b (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 23 Oct 2020 15:29:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kW2kg-0005Ad-2w; Fri, 23 Oct 2020 19:29:26 +0000
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
To:     Zong Li <zong.li@sifive.com>, paulmck@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, vincent.whitchurch@axis.com,
        tglx@linutronix.de, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, guoren@kernel.org, atishp@atishpatra.org,
        mhiramat@kernel.org, greentime.hu@sifive.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20201021073839.43935-1-zong.li@sifive.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <50bdca78-0cbb-5c62-f241-ed50737131b2@canonical.com>
Date:   Fri, 23 Oct 2020 20:29:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201021073839.43935-1-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 21/10/2020 08:38, Zong Li wrote:
> Like the commit cb9d7fd51d9f ("watchdog: Mark watchdog touch functions
> as notrace"), some architectures assume that the stopped CPUs don't make
> function calls to traceable functions when they are in the stopped
> state. For example, it causes unexpected kernel crashed when switching
> tracer on RISC-V.
> 
> The following patches added calls to these two functions, fix it by
> adding the notrace annotations.
> 
> Fixes: 4ecf0a43e729 ("processor: get rid of cpu_relax_yield")
> Fixes: 366237e7b083 ("stop_machine: Provide RCU quiescent state in
> multi_cpu_stop()")
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  kernel/rcu/tree.c     | 2 +-
>  kernel/stop_machine.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 06895ef85d69..2a52f42f64b6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -409,7 +409,7 @@ bool rcu_eqs_special_set(int cpu)
>   *
>   * The caller must have disabled interrupts and must not be idle.
>   */
> -void rcu_momentary_dyntick_idle(void)
> +notrace void rcu_momentary_dyntick_idle(void)
>  {
>  	int special;
>  
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index 865bb0228ab6..890b79cf0e7c 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -178,7 +178,7 @@ static void ack_state(struct multi_stop_data *msdata)
>  		set_state(msdata, msdata->state + 1);
>  }
>  
> -void __weak stop_machine_yield(const struct cpumask *cpumask)
> +notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
>  {
>  	cpu_relax();
>  }
> 

Apologies for taking so long to reply, I needed to test this on several
devices.

This not only fixes the ftrace issue I see on RISC-V but also a ftrace
hang issue on ARM64 in 5.8 too.

Tested-by: Colin Ian King <colin.king@canonical.com>

Many thanks!
