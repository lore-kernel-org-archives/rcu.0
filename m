Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25B4C433F5
	for <rcu@archiver.kernel.org>; Wed, 25 May 2022 11:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbiEYL5X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 May 2022 07:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243392AbiEYL5P (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 May 2022 07:57:15 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28BE1FCC5;
        Wed, 25 May 2022 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653479820; x=1685015820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nEAyTJOdRBehDHHmeCA8nAnq7gmElWIt7+YFR+MXpkU=;
  b=v1zKIWBS0d/5Esa7+dQ4SoPNvIZSnHXheQuDUaDu02s5jFb1frij+FdE
   cQ/6C7eHY3h6t8dVn+OXNHu0a+BI2S+mbRk8iQvxIuLiRgDYRn+CCN0p0
   Ow1munqTRf+r2QrPyK9GBTErbGZUW6yLADvitNpILgE2buDlah2EkPSo/
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 May 2022 04:57:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 04:56:59 -0700
Received: from [10.216.2.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 25 May
 2022 04:56:57 -0700
Message-ID: <7b641200-88b1-8d45-7068-3e9f4d9e0530@quicinc.com>
Date:   Wed, 25 May 2022 17:26:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] rcu: Fix incorrect judgment condition in
 show_rcu_nocb_state()
Content-Language: en-US
To:     Zqiang <qiang1.zhang@intel.com>, <paulmck@kernel.org>,
        <frederic@kernel.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220525033430.1953349-1-qiang1.zhang@intel.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220525033430.1953349-1-qiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 5/25/2022 9:04 AM, Zqiang wrote:
> When check the 'rdp->nocb_cb_kthread' tasks exists, if is true, however
> the output is the cpu where 'rdp->nocb_gp_kthread' is located. this
> ensure that the tasks in the judgment condition and the tasks of the
> cpu where the output tasks are located are the same tasks.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>   kernel/rcu/tree_nocb.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index fa8e4f82e60c..f4ee81d119c8 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1438,8 +1438,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
>   		(long)rdp->nocb_gp_seq,
>   		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
>   		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
> -		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
> -		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
> +		rdp->nocb_gp_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
> +		show_rcu_should_be_on_cpu(rdp->nocb_gp_kthread));
>   }
>   
>   /* Dump out nocb kthread state for the specified rcu_data structure. */
> @@ -1483,7 +1483,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
>   		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
>   		rcu_segcblist_n_cbs(&rdp->cblist),
>   		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
> -		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
> +		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_cb_kthread) : -1,
>   		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
>   

Nice !!
Reviewed-by: quic_mojha@quicinc.com

-Mukesh

>   	/* It is OK for GP kthreads to have GP state. */
