Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9AF29A2;
	Wed,  4 Jun 2025 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749007569; cv=none; b=iAlzJ7wDCUllJZRMs4ZPy7TFRG7XfWj0bg8TEi03yp3hD05S/RjvHXlpuV1FeGqm9w2MByNQwG3C6i2szgRPe/MdDULjwz9ZudN40L2jwNSZvQJ7wk1CTFKRIo5e3Udmp9R0bjtOOHQplIXADd/1KhiMrBG9D6ZLcWHw60NjtwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749007569; c=relaxed/simple;
	bh=gntv/jhjWZpou/8HjRtmuBWNkBcHD3Xn/7v5XKPVgwE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oHnUa0H3li03pxuc3/zhccFjGrbX55NCUSi4BjoD6ZoxbQb0zn/ybUUIP6SEkpC0KIcaVi6LrMyLj36INSBbOKCuTmbvk7ekzMuO+Z57CjuEGNW3lTqhF12/f/4FAveGR6KPJvLDWDEr62TFhxl6xqC6hAh3L/tCTNHVg9XbRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bBtHR71DFz1fy4h;
	Wed,  4 Jun 2025 11:24:51 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A44241402CD;
	Wed,  4 Jun 2025 11:26:02 +0800 (CST)
Received: from kwepemq500009.china.huawei.com (7.202.195.53) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Jun 2025 11:25:52 +0800
Received: from [10.174.179.5] (10.174.179.5) by kwepemq500009.china.huawei.com
 (7.202.195.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Jun
 2025 11:25:51 +0800
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
To: Joel Fernandes <joelagnelf@nvidia.com>
CC: Joel Fernandes <joel@joelfernandes.org>, <ankur.a.arora@oracle.com>,
	Frederic Weisbecker <frederic@kernel.org>, "Paul E . McKenney"
	<paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	<neeraj.upadhyay@kernel.org>, <urezki@gmail.com>, <rcu@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <xiqi2@huawei.com>, "Wangshaobo (bobo)"
	<bobo.shaobowang@huawei.com>
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
 <20250603185939.GA1109523@joelnvbox>
 <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
 <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <20250604013526.GA1192922@joelnvbox>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <0f322c7b-d8b7-ff0a-5c98-26230a9fbad0@huawei.com>
Date: Wed, 4 Jun 2025 11:25:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250604013526.GA1192922@joelnvbox>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500009.china.huawei.com (7.202.195.53)



On 2025/6/4 9:35, Joel Fernandes wrote:
> On Tue, Jun 03, 2025 at 03:22:42PM -0400, Joel Fernandes wrote:
>>
>>
>> On 6/3/2025 3:03 PM, Joel Fernandes wrote:
>>>
>>>
>>> On 6/3/2025 2:59 PM, Joel Fernandes wrote:
>>>> On Fri, May 30, 2025 at 09:55:45AM +0800, Xiongfeng Wang wrote:
>>>>> Hi Joel,
>>>>>
>>>>> On 2025/5/29 0:30, Joel Fernandes wrote:
>>>>>> On Wed, May 21, 2025 at 5:43 AM Xiongfeng Wang
>>>>>> <wangxiongfeng2@huawei.com> wrote:
>>>>>>>
>>>>>>> Hi RCU experts,
>>>>>>>
>>>>>>> When I ran syskaller in Linux 6.6 with CONFIG_PREEMPT_RCU enabled, I got
>>>>>>> the following soft lockup. The Calltrace is too long. I put it in the end.
>>>>>>> The issue can also be reproduced in the latest kernel.
>>>>>>>
>>>>>>> The issue is as follows. CPU3 is waiting for a spin_lock, which is got by CPU1.
>>>>>>> But CPU1 stuck in the following dead loop.
>>>>>>>
>>>>>>> irq_exit()
>>>>>>>   __irq_exit_rcu()
>>>>>>>     /* in_hardirq() returns false after this */
>>>>>>>     preempt_count_sub(HARDIRQ_OFFSET)
>>>>>>>     tick_irq_exit()
>>>>>>>       tick_nohz_irq_exit()
>>>>>>>             tick_nohz_stop_sched_tick()
>>>>>>>               trace_tick_stop()  /* a bpf prog is hooked on this trace point */
>>>>>>>                    __bpf_trace_tick_stop()
>>>>>>>                       bpf_trace_run2()
>>>>>>>                             rcu_read_unlock_special()
>>>>>>>                               /* will send a IPI to itself */
>>>>>>>                               irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>>>>>>>
>>>>>>> /* after interrupt is enabled again, the irq_work is called */
>>>>>>> asm_sysvec_irq_work()
>>>>>>>   sysvec_irq_work()
>>>>>>> irq_exit() /* after handled the irq_work, we again enter into irq_exit() */
>>>>>>>   __irq_exit_rcu()
>>>>>>>     ...skip...
>>>>>>>            /* we queue a irq_work again, and enter a dead loop */
>>>>>>>            irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>>>>>>
> 
> The following is a candidate fix (among other fixes being
> considered/discussed). The change is to check if context tracking thinks
> we're in IRQ and if so, avoid the irq_work. IMO, this should be rare enough
> that it shouldn't be an issue and it is dangerous to self-IPI consistently
> while we're exiting an IRQ anyway.
> 
> Thoughts? Xiongfeng, do you want to try it?

Thanks a lot for the fast response. My colleague is testing the modification.
 She will feedback the result.

Thanks,
Xiongfeng

> 
> Btw, I could easily reproduce it as a boot hang by doing:
> 
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -638,6 +638,10 @@ void irq_enter(void)
>  
>  static inline void tick_irq_exit(void)
>  {
> +	rcu_read_lock();
> +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
> +	rcu_read_unlock();
> +
>  #ifdef CONFIG_NO_HZ_COMMON
>  	int cpu = smp_processor_id();
>  
> ---8<-----------------------
> 
> From: Joel Fernandes <joelagnelf@nvidia.com>
> Subject: [PATCH] Do not schedule irq_work when IRQ is exiting
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  include/linux/context_tracking_irq.h |  2 ++
>  kernel/context_tracking.c            | 12 ++++++++++++
>  kernel/rcu/tree_plugin.h             |  3 ++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/context_tracking_irq.h b/include/linux/context_tracking_irq.h
> index 197916ee91a4..35a5ad971514 100644
> --- a/include/linux/context_tracking_irq.h
> +++ b/include/linux/context_tracking_irq.h
> @@ -9,6 +9,7 @@ void ct_irq_enter_irqson(void);
>  void ct_irq_exit_irqson(void);
>  void ct_nmi_enter(void);
>  void ct_nmi_exit(void);
> +bool ct_in_irq(void);
>  #else
>  static __always_inline void ct_irq_enter(void) { }
>  static __always_inline void ct_irq_exit(void) { }
> @@ -16,6 +17,7 @@ static inline void ct_irq_enter_irqson(void) { }
>  static inline void ct_irq_exit_irqson(void) { }
>  static __always_inline void ct_nmi_enter(void) { }
>  static __always_inline void ct_nmi_exit(void) { }
> +static inline bool ct_in_irq(void) { return false; }
>  #endif
>  
>  #endif
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index fb5be6e9b423..8e8055cf04af 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -392,6 +392,18 @@ noinstr void ct_irq_exit(void)
>  	ct_nmi_exit();
>  }
>  
> +/**
> + * ct_in_irq - check if CPU is currently in a tracked IRQ context.
> + *
> + * Returns true if ct_irq_enter() has been called and ct_irq_exit()
> + * has not yet been called. This indicates the CPU is currently
> + * processing an interrupt.
> + */
> +bool ct_in_irq(void)
> +{
> +	return ct_nmi_nesting() != 0;
> +}
> +
>  /*
>   * Wrapper for ct_irq_enter() where interrupts are enabled.
>   *
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 3c0bbbbb686f..a3eebd4c841e 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -673,7 +673,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			set_tsk_need_resched(current);
>  			set_preempt_need_resched();
>  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> -			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
> +			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu) &&
> +			    !ct_in_irq()) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
>  				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> 
