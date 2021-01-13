Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A743EC433E0
	for <rcu@archiver.kernel.org>; Wed, 13 Jan 2021 05:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A75D221ED
	for <rcu@archiver.kernel.org>; Wed, 13 Jan 2021 05:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbhAMFMe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 Jan 2021 00:12:34 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:18197 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbhAMFMb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 13 Jan 2021 00:12:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610514727; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=lz1rbHEN8q40hJaefWgl9UylDcfTHqHw9eJZzyNgRG0=; b=iPWkC+sx2uN6C1YATa2Icf6dOad2S86F68Ocd0A7JNCQBk4AFfc9RW7Z8rhjzDnGwC3sEijv
 wyaGc5dKGZLFJK13LUTVbdaoBN0NZvTqFRQ7t66FVniJgYUgaYA15Up6cLN2ehnlQtKI0DVW
 /bweg1gW1tGgXUcpndYzGf0DNxg=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5ffe80ffd84bad3547d26848 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Jan 2021 05:11:27
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95DB5C43465; Wed, 13 Jan 2021 05:11:27 +0000 (UTC)
Received: from [192.168.0.103] (unknown [49.206.37.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 881FEC433CA;
        Wed, 13 Jan 2021 05:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 881FEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu: Correct cpu offline trace in rcutree_dying_cpu
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1610365558-8330-1-git-send-email-neeraju@codeaurora.org>
 <20210112173116.GG2743@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <c1dd3362-7087-7141-4a4a-28d67db1924e@codeaurora.org>
Date:   Wed, 13 Jan 2021 10:41:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210112173116.GG2743@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 1/12/2021 11:01 PM, Paul E. McKenney wrote:
> On Mon, Jan 11, 2021 at 05:15:58PM +0530, Neeraj Upadhyay wrote:
>> Correctly trace whether the outgoing cpu blocks current gp in
>> rcutree_dying_cpu().
>>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> 
> Good catch, queued, thank you!  Please see below for my usual
> wordsmithing, and please lat me know if I messed something up.
> 
> 							Thanx, Paul
> 

Thanks Paul, looks good!


Thanks
Neeraj

> ------------------------------------------------------------------------
> 
> commit ab6e7609e7590e1bb220ef6b0822a823dde46f6c
> Author: Neeraj Upadhyay <neeraju@codeaurora.org>
> Date:   Mon Jan 11 17:15:58 2021 +0530
> 
>      rcu: Fix CPU-offline trace in rcutree_dying_cpu
>      
>      The condition in the trace_rcu_grace_period() in rcutree_dying_cpu() is
>      backwards, so that it uses the string "cpuofl" when the offline CPU is
>      blocking the current grace period and "cpuofl-bgp" otherwise.  Given that
>      the "-bgp" stands for "blocking grace period", this is at best misleading.
>      This commit therefore switches these strings in order to correctly trace
>      whether the outgoing cpu blocks the current grace period.
>      
>      Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index cc6b6fc..63c6dba 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2387,7 +2387,7 @@ int rcutree_dying_cpu(unsigned int cpu)
>   
>   	blkd = !!(rnp->qsmask & rdp->grpmask);
>   	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
> -			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
> +			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
>   	return 0;
>   }
>   
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
