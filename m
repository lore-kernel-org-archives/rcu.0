Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6660EC2D0E4
	for <rcu@archiver.kernel.org>; Fri, 27 Nov 2020 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059CC2223C
	for <rcu@archiver.kernel.org>; Fri, 27 Nov 2020 08:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qYGp5ib7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgK0I12 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Nov 2020 03:27:28 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:43072 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbgK0I11 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Nov 2020 03:27:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606465647; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=IWwasJt0tRMK1gc4MDCFwZQfJfjRy1hB6m5yMjEDyX8=; b=qYGp5ib75bjiTEWK9b8ykgXJbValRBBsRRI/3ZNnthvuowamG4Ar3U5nxLHxwgAclarBnypu
 LQf68XPTHHMI3jMoaRqGRwEt3JgDglNM0VlQ6z9yg2v5nqGoMlaUS5eH+dlYZ+43EDGPHXuA
 QOJCv3twgbbh6v4WU+G/n9Q3/QU=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fc0b869d64ea0b703db9c40 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 27 Nov 2020 08:27:21
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77B7BC4346D; Fri, 27 Nov 2020 08:27:20 +0000 (UTC)
Received: from [192.168.0.105] (unknown [49.206.49.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E04EAC433C6;
        Fri, 27 Nov 2020 08:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E04EAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v2 tip/core/rcu 6/6] srcu: Document polling interfaces for
 Tree SRCU grace periods
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, kent.overstreet@gmail.com
References: <@@@> <20201121005919.17152-6-paulmck@kernel.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <4b803d78-7464-0ba7-450e-181928080956@codeaurora.org>
Date:   Fri, 27 Nov 2020 13:57:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201121005919.17152-6-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 11/21/2020 6:29 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit adds requirements documentation for the
> get_state_synchronize_srcu(), start_poll_synchronize_srcu(), and
> poll_state_synchronize_srcu() functions.
> 
> Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
> Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>


Thanks
Neeraj

>   Documentation/RCU/Design/Requirements/Requirements.rst | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 1e3df77..2dce79d 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -2600,6 +2600,24 @@ also includes DEFINE_SRCU(), DEFINE_STATIC_SRCU(), and
>   init_srcu_struct() APIs for defining and initializing
>   ``srcu_struct`` structures.
>   
> +More recently, the SRCU API has added polling interfaces:
> +
> +#. start_poll_synchronize_srcu() returns a cookie identifying
> +   the completion of a future SRCU grace period and ensures
> +   that this grace period will be started.
> +#. poll_state_synchronize_srcu() returns ``true`` iff the
> +   specified cookie corresponds to an already-completed
> +   SRCU grace period.
> +#. get_state_synchronize_srcu() returns a cookie just like
> +   start_poll_synchronize_srcu() does, but differs in that
> +   it does nothing to ensure that any future SRCU grace period
> +   will be started.
> +
> +These functions are used to avoid unnecessary SRCU grace periods in
> +certain types of buffer-cache algorithms having multi-stage age-out
> +mechanisms.  The idea is that by the time the block has aged completely
> +from the cache, an SRCU grace period will be very likely to have elapsed.
> +
>   Tasks RCU
>   ~~~~~~~~~
>   
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
