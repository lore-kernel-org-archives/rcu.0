Return-Path: <SRS0=+AtR=DP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1794C04EBE
	for <rcu@archiver.kernel.org>; Thu,  8 Oct 2020 07:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F0820739
	for <rcu@archiver.kernel.org>; Thu,  8 Oct 2020 07:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vv7rJK7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgJHHUC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 8 Oct 2020 03:20:02 -0400
Received: from z5.mailgun.us ([104.130.96.5]:58857 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgJHHUA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 8 Oct 2020 03:20:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602141598; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=sMId6QbHBP1c3GiWF09Qa5VF+xMEy1yf5rDnhSRqa8U=; b=vv7rJK7YVtl+VvUM6NNM153W2Mw4Sv1sW7Wlf8jKq7zXDsXw/ckiOkHdtprSd773Eo+uHVCa
 JtKLps5pdCIIzZxu/ZeU+oRXoIIDxg71ru2KZVT1a/eQMw31/LREo7Tz0IIUDDgalW2MPjoW
 7DRJuiOarC+ab3+ULbvVRJpc1+w=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f7ebd92ad37af35ec10f637 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Oct 2020 07:19:46
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A571AC43385; Thu,  8 Oct 2020 07:19:46 +0000 (UTC)
Received: from [192.168.0.102] (unknown [124.123.181.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2380AC433CB;
        Thu,  8 Oct 2020 07:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2380AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v2] rcu/tree: nocb: Avoid raising softirq when there are
 ready to execute CBs
To:     paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <20201005021132.146534-1-joel@joelfernandes.org>
 <20201007223438.GU29330@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <7fb89900-18e3-f438-ec31-2bce21c02afe@codeaurora.org>
Date:   Thu, 8 Oct 2020 12:49:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201007223438.GU29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 10/8/2020 4:04 AM, Paul E. McKenney wrote:
> On Sun, Oct 04, 2020 at 10:11:32PM -0400, Joel Fernandes (Google) wrote:
>> During testing, I see it is possible that rcu_pending() returns 1 when
>> offloaded callbacks are ready to execute thus raising the RCU softirq.
>>
>> However, softirq does not execute offloaded callbacks. They are executed in a
>> kthread which is awakened independent of the softirq.
>>
>> This commit therefore avoids raising the softirq in the first place. That's
>> probably a good thing considering that the purpose of callback offloading is to
>> reduce softirq activity.
>>
>> Passed 30 minute tests of TREE01 through TREE09 each.
>>
>> On TREE08, I notice that there is atmost 150us from when the softirq was
>> NOT raised when ready cbs were present, to when the ready callbacks were
>> invoked by the rcuop thread. This also further confirms that there is no
>> need to raise the softirq for ready cbs in the first place.
>>
>> Cc: neeraju@codeaurora.org
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Looks good, applied, thank you!  I reworked things a bit based on
> previous patches and to more precisely capture why this patch does
> not cause additional problems.  Please let me know if I messed
> anything up.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 33847a34a2d261354a79b4a24d9d37222e8ec888
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Wed Oct 7 13:50:36 2020 -0700
> 
>      rcu/tree: nocb: Avoid raising softirq for offloaded ready-to-execute CBs
>      
>      Testing showed that rcu_pending() can return 1 when offloaded callbacks
>      are ready to execute.  This invokes RCU core processing, for example,
>      by raising RCU_SOFTIRQ, eventually resulting in a call to rcu_core().
>      However, rcu_core() explicitly avoids in any way manipulating offloaded
>      callbacks, which are instead handled by the rcuog and rcuoc kthreads,
>      which work independently of rcu_core().
>      
>      One exception to this independence is that rcu_core() invokes
>      do_nocb_deferred_wakeup(), however, rcu_pending() also checks
>      rcu_nocb_need_deferred_wakeup() in order to correctly handle this case,
>      invoking rcu_core() when needed.
>      
>      This commit therefore avoids needlessly invoking RCU core processing
>      by checking rcu_segcblist_ready_cbs() only on non-offloaded CPUs.
>      This reduces overhead, for example, by reducing softirq activity.
>      
>      This change passed 30 minute tests of TREE01 through TREE09 each.
>      
>      On TREE08, there is at most 150us from the time that rcu_pending() chose
>      not to invoke RCU core processing to the time when the ready callbacks
>      were invoked by the rcuoc kthread.  This provides further evidence that
>      there is no need to invoke rcu_core() for offloaded callbacks that are
>      ready to invoke.
>      
>      Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
>      Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 

Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>


Thanks
Neeraj

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 85e3f29..bfd38f2 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3716,7 +3716,8 @@ static int rcu_pending(int user)
>   		return 1;
>   
>   	/* Does this CPU have callbacks ready to invoke? */
> -	if (rcu_segcblist_ready_cbs(&rdp->cblist))
> +	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
> +	    rcu_segcblist_ready_cbs(&rdp->cblist))
>   		return 1;
>   
>   	/* Has RCU gone idle with this CPU needing another grace period? */
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
