Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB4DEB64DD
	for <rcu@archiver.kernel.org>; Wed,  5 Jul 2023 08:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjGEIRY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjGEIRW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 5 Jul 2023 04:17:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED4171C;
        Wed,  5 Jul 2023 01:17:19 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qwstf595zzTm9T;
        Wed,  5 Jul 2023 16:16:10 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 16:17:12 +0800
Subject: Re: [PATCH 2/2] rcu: Don't dump the stalled CPU on where RCU GP
 kthread last ran twice
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230705073020.2030-1-thunder.leizhen@huawei.com>
 <20230705073020.2030-3-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6e6bede7-288d-b793-89d1-fc8d6550a545@huawei.com>
Date:   Wed, 5 Jul 2023 16:17:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230705073020.2030-3-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 2023/7/5 15:30, Zhen Lei wrote:
> The stacks of all stalled CPUs will be dumped. If the CPU on where RCU GP
> kthread last ran is stalled, its stack does not need to be dumped again.

Should I add Fixes?

Fixes: 243027a3c805 ("rcu: For RCU grace-period kthread starvation, dump last CPU it ran on")

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/rcu/tree_stall.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index dcfaa3d5db2cbc7..cc884cd49e026a3 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -534,12 +534,14 @@ static void rcu_check_gp_kthread_starvation(void)
>  		       data_race(READ_ONCE(rcu_state.gp_state)),
>  		       gpk ? data_race(READ_ONCE(gpk->__state)) : ~0, cpu);
>  		if (gpk) {
> +			struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +
>  			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
>  			pr_err("RCU grace-period kthread stack dump:\n");
>  			sched_show_task(gpk);
>  			if (cpu_is_offline(cpu)) {
>  				pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
> -			} else  {
> +			} else if (!(data_race(READ_ONCE(rdp->mynode->qsmask)) & rdp->grpmask)) {
>  				pr_err("Stack dump where RCU GP kthread last ran:\n");
>  				dump_cpu_task(cpu);
>  			}
> 

-- 
Regards,
  Zhen Lei
