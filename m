Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB540C43334
	for <rcu@archiver.kernel.org>; Tue, 21 Jun 2022 05:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiFUFfU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Jun 2022 01:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiFUFfU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Jun 2022 01:35:20 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C4B2181B;
        Mon, 20 Jun 2022 22:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655789718; x=1687325718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jxYs77w82kG4F9iMmzULoGawmt1nSz58YBjgnbMIT9o=;
  b=FsiYOFEAWMw2C0jCs/IpIFR8e7BRcHC10zylajEVyiaNgGItXtRuV/cV
   r3uT8BvbM5i6S7HhpmSirUUa/Y+Aa4PKsQXVNyDBcl6wEYgOHzZ4MJNCU
   YLzcIRWRqtLrrlqHEQRuBu97zJJVKJPCE3JPh27ueH8zGEv2FXDXB/8ME
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Jun 2022 22:35:18 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 22:30:04 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 22:30:01 -0700
Message-ID: <87c17e9a-565a-d717-3534-83a4c506b984@quicinc.com>
Date:   Tue, 21 Jun 2022 10:59:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 01/12] rcu: Decrease FQS scan wait time in case of
 callback overloading
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-1-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620222032.3839547-1-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 6/21/2022 3:50 AM, Paul E. McKenney wrote:
> The force-quiesce-state loop function rcu_gp_fqs_loop() checks for
> callback overloading and does an immediate initial scan for idle CPUs
> if so.  However, subsequent rescans will be carried out at as leisurely a
> rate as they always are, as specified by the rcutree.jiffies_till_next_fqs
> module parameter.  It might be tempting to just continue immediately
> rescanning, but this turns the RCU grace-period kthread into a CPU hog.
> It might also be tempting to reduce the time between rescans to a single
> jiffy, but this can be problematic on larger systems.
> 
> This commit therefore divides the normal time between rescans by three,
> rounding up.  Thus a small system running at HZ=1000 that is suffering
> from callback overload will wait only one jiffy instead of the normal
> three between rescans.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   kernel/rcu/tree.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c25ba442044a6..c19d5926886fb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1993,6 +1993,11 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
>   			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
>   				   jiffies + (j ? 3 * j : 2));
>   		}
> +		if (rcu_state.cbovld) {
> +			j = (j + 2) / 3;
> +			if (j <= 0)
> +				j = 1;
> +		}

We update 'j' here, after setting rcu_state.jiffies_force_qs

     WRITE_ONCE(rcu_state.jiffies_force_qs, jiffies + j)

So, we return from swait_event_idle_timeout_exclusive after 1/3 time 
duration.

     swait_event_idle_timeout_exclusive(rcu_state.gp_wq,
				 rcu_gp_fqs_check_wake(&gf), j);

This can result in !timer_after check to return false and we will
enter the 'else' (stray signal block) code?

This might not matter for first 2 fqs loop iterations, where 
RCU_GP_FLAG_OVLD is set in 'gf', but subsequent iterations won't benefit
from this patch?


if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
	(gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
			...
} else {
	/* Deal with stray signal. */
}


So, do we need to move this calculation above the 'if' block which sets 
rcu_state.jiffies_force_qs?
		if (!ret) {

			WRITE_ONCE(rcu_state.jiffies_force_qs, jiffies +
						j);...
		}

Thanks
Neeraj

>   		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>   				       TPS("fqswait"));
>   		WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_FQS);
