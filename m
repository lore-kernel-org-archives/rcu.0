Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ABAC43334
	for <rcu@archiver.kernel.org>; Tue, 19 Jul 2022 09:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiGSJ2a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Jul 2022 05:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiGSJ2M (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Jul 2022 05:28:12 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569F91FCE4;
        Tue, 19 Jul 2022 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658222891; x=1689758891;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=leGrc9xXUuRzZfE+huco6T6eawpHA5+J1INEV2knv98=;
  b=P7RiMy/vpnP3YZyaU7zk8WfOA7rKxaNFjcxlbEOxsjdxQ2EcgCOcL3N4
   ZeXxD++zP1+kSiJK9YSA5PJDrfD5JrFv9jczhLlgznMbX/iCHNfa6Mpcf
   WYICc1+J1GSzhvvLME8J2ndlz20wsaum1B5JFxUUzHiBHU49DGiJWmncK
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Jul 2022 02:28:11 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 02:28:11 -0700
Received: from [10.50.41.193] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Jul
 2022 02:28:07 -0700
Message-ID: <5fff0b52-ae83-52ea-b606-1aa73def05aa@quicinc.com>
Date:   Tue, 19 Jul 2022 14:58:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 2/7] rcu/nocb: Invert rcu_state.barrier_mutex VS
 hotplug lock locking order
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>, Zqiang <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
 <20220620224503.3841196-2-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620224503.3841196-2-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 6/21/2022 4:14 AM, Paul E. McKenney wrote:
> From: Zqiang <qiang1.zhang@intel.com>
> 
> In case of failure to spawn either rcuog or rcuo[p] kthreads for a given
> rdp, rcu_nocb_rdp_deoffload() needs to be called with the hotplug
> lock and the barrier_mutex held. However cpus write lock is already held
> while calling rcutree_prepare_cpu(). It's not possible to call
> rcu_nocb_rdp_deoffload() from there with just locking the barrier_mutex
> or this would result in a locking inversion against
> rcu_nocb_cpu_deoffload() which holds both locks in the reverse order.
> 
> Simply solve this with inverting the locking order inside
> rcu_nocb_cpu_[de]offload(). This will be a pre-requisite to toggle NOCB
> states toward cpusets anyway.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>


Thanks
Neeraj

>   kernel/rcu/tree_nocb.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index dac74952e1d1b..f2f2cab6285a1 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1055,8 +1055,8 @@ int rcu_nocb_cpu_deoffload(int cpu)
>   	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>   	int ret = 0;
>   
> -	mutex_lock(&rcu_state.barrier_mutex);
>   	cpus_read_lock();
> +	mutex_lock(&rcu_state.barrier_mutex);
>   	if (rcu_rdp_is_offloaded(rdp)) {
>   		if (cpu_online(cpu)) {
>   			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
> @@ -1067,8 +1067,8 @@ int rcu_nocb_cpu_deoffload(int cpu)
>   			ret = -EINVAL;
>   		}
>   	}
> -	cpus_read_unlock();
>   	mutex_unlock(&rcu_state.barrier_mutex);
> +	cpus_read_unlock();
>   
>   	return ret;
>   }
> @@ -1134,8 +1134,8 @@ int rcu_nocb_cpu_offload(int cpu)
>   	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>   	int ret = 0;
>   
> -	mutex_lock(&rcu_state.barrier_mutex);
>   	cpus_read_lock();
> +	mutex_lock(&rcu_state.barrier_mutex);
>   	if (!rcu_rdp_is_offloaded(rdp)) {
>   		if (cpu_online(cpu)) {
>   			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
> @@ -1146,8 +1146,8 @@ int rcu_nocb_cpu_offload(int cpu)
>   			ret = -EINVAL;
>   		}
>   	}
> -	cpus_read_unlock();
>   	mutex_unlock(&rcu_state.barrier_mutex);
> +	cpus_read_unlock();
>   
>   	return ret;
>   }
