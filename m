Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7145FC54EE9
	for <rcu@archiver.kernel.org>; Wed, 28 Sep 2022 01:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiI1BYP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Sep 2022 21:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiI1BYP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Sep 2022 21:24:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5EB188BEA
        for <rcu@vger.kernel.org>; Tue, 27 Sep 2022 18:24:13 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mcdvb4flXzlVjC;
        Wed, 28 Sep 2022 09:19:55 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 09:24:11 +0800
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 09:24:11 +0800
Message-ID: <9b142399-7968-2300-24c4-5a60cee76ec3@huawei.com>
Date:   Wed, 28 Sep 2022 09:24:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH] rcu: remove rcu_is_idle_cpu
To:     <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
CC:     <rcu@vger.kernel.org>, <quic_neeraju@quicinc.com>,
        <josh@joshtriplett.org>, <rostedt@goodmis.org>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <joel@joelfernandes.org>, <rafael.j.wysocki@intel.com>,
        <peterz@infradead.org>
References: <20220926015827.227050-1-zouyipeng@huawei.com>
 <20220926203629.GA183228@lothringen>
 <20220927185121.GU4196@paulmck-ThinkPad-P17-Gen-1>
Content-Language: en-US
From:   Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <20220927185121.GU4196@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


在 2022/9/28 2:51, Paul E. McKenney 写道:
> On Mon, Sep 26, 2022 at 10:36:29PM +0200, Frederic Weisbecker wrote:
>> On Mon, Sep 26, 2022 at 09:58:27AM +0800, Yipeng Zou wrote:
>>> The commit "x86/cpu: Avoid cpuinfo-induced IPIing of idle CPUs" introduce
>>> this function to identify the current CPU idle state.
>>> But after commit "x86/aperfmperf: Replace arch_freq_get_on_cpu()" we
>>> just use MAX_SAMPLE_AGE to do that, So there is no use of this function.
>>>
>>> Fixes: f3eca381bd49 ("x86/aperfmperf: Replace arch_freq_get_on_cpu()")
>>> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Good eyes, Yipeng!  Queued and pushed, thank you both!
>
> As usual, I could not resist the urge to wordsmith, so please check the
> patch below and let me know if I messed something up.

Its all good, and thanks for review.

> And please include both commit IDs in future patches with the
> formatting shows below.  Makes it easier for me to accept your
> patches, after all.  ;-)
ok，got it.
>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit f8b389c24cf9a523472e3e505815b26f0174856c
> Author: Yipeng Zou <zouyipeng@huawei.com>
> Date:   Mon Sep 26 09:58:27 2022 +0800
>
>      rcu: Remove rcu_is_idle_cpu()
>      
>      The commit 3fcd6a230fa7 ("x86/cpu: Avoid cpuinfo-induced IPIing of
>      idle CPUs") introduced rcu_is_idle_cpu() in order to identify the
>      current CPU idle state.  But commit f3eca381bd49 ("x86/aperfmperf:
>      Replace arch_freq_get_on_cpu()") switched to using MAX_SAMPLE_AGE,
>      so rcu_is_idle_cpu() is no longer used.  This commit therefore removes it.
>      
>      Fixes: f3eca381bd49 ("x86/aperfmperf: Replace arch_freq_get_on_cpu()")
>      Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
>      Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 84e930c11065..93485b812712 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -146,8 +146,6 @@ static inline void rcu_virt_note_context_switch(void) { }
>   static inline void rcu_cpu_stall_reset(void) { }
>   static inline int rcu_jiffies_till_stall_check(void) { return 21 * HZ; }
>   static inline void rcu_irq_exit_check_preempt(void) { }
> -#define rcu_is_idle_cpu(cpu) \
> -	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
>   static inline void exit_rcu(void) { }
>   static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>   {
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 3066e0975022..f41c4ab2a884 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -87,8 +87,6 @@ bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
>   void cond_synchronize_rcu(unsigned long oldstate);
>   void cond_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp);
>   
> -bool rcu_is_idle_cpu(int cpu);
> -
>   #ifdef CONFIG_PROVE_RCU
>   void rcu_irq_exit_check_preempt(void);
>   #else
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1930cee1ccdb..96d678c9cfb6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -301,12 +301,6 @@ static bool rcu_dynticks_in_eqs(int snap)
>   	return !(snap & RCU_DYNTICKS_IDX);
>   }
>   
> -/* Return true if the specified CPU is currently idle from an RCU viewpoint.  */
> -bool rcu_is_idle_cpu(int cpu)
> -{
> -	return rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
> -}
> -
>   /*
>    * Return true if the CPU corresponding to the specified rcu_data
>    * structure has spent some time in an extended quiescent state since

-- 
Regards,
Yipeng Zou

