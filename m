Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4051DF75B;
	Mon,  7 Jul 2025 03:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751857637; cv=none; b=LJL7E+lrJ9MgoEHqENxEZvxr8ydh62HXIluDxOgggCvoGSBK7zm9js/KqsboPdzLrde7qFiC/DVuIHiQHK2yTUYHgPFE5QG7L7uhRHXWGYAYm051W3gxngRvCCblBU0r6UaoBzGsfZcaF6n6KBWJMxTPo3N/GfNGU2hQeYgn36I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751857637; c=relaxed/simple;
	bh=ESklXczDxBkJQsEGiJCPpzFAGpFwcnpfBHXspaxNty8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fmKgd91qpbeaPmgKh5xkCVcpJIU0DxZh8lerz/8wwuqVImJUlvTpY67wIo/HCIVq9cmjfm13U3Xc9BTM1i4lCWU3BkkbkV/NE5YlwNVqD/6VslIYtQP4tJkmzbjjANSCmNHTYbe346XAcSmctLu8qbrub9pci7kQO1SOTvhSrt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bb8Gh6pYCz13MZn;
	Mon,  7 Jul 2025 11:04:28 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id D19B51402F5;
	Mon,  7 Jul 2025 11:07:04 +0800 (CST)
Received: from kwepemn200010.china.huawei.com (7.202.194.133) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 7 Jul 2025 11:07:01 +0800
Received: from [10.174.178.56] (10.174.178.56) by
 kwepemn200010.china.huawei.com (7.202.194.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 7 Jul 2025 11:07:00 +0800
Message-ID: <40dea5dd-7ca2-4bee-8ca5-bb1df8b3750b@huawei.com>
Date: Mon, 7 Jul 2025 11:06:59 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
To: Joel Fernandes <joelagnelf@nvidia.com>, Xiongfeng Wang
	<wangxiongfeng2@huawei.com>
CC: <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
	<ankur.a.arora@oracle.com>, Frederic Weisbecker <frederic@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, <neeraj.upadhyay@kernel.org>,
	<urezki@gmail.com>, <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>, Xie XiuQi
	<xiexiuqi@huawei.com>
References: <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <c448118b-9f7e-4c29-d6b3-a66e70f7163f@huawei.com>
 <a963b475-72cd-474d-96d4-9e651fc8f857@paulmck-laptop>
 <e7354668-2573-4564-834b-44d76d983222@nvidia.com>
 <09e4d018-3db4-404e-a8f0-041cdee15a62@huawei.com>
 <279d2f06-d4f7-46e1-9678-999a2d19b710@nvidia.com>
 <506d8c4e-c317-4c85-9bcf-695596551d28@huawei.com>
 <166bc5aa-a715-438e-8805-c74c2b5fc83b@nvidia.com>
 <c16ddb6e-73f1-4eff-bbcf-c03b95f79fdf@nvidia.com>
 <8f5925c1-9553-63d3-d5a0-387c2395963d@huawei.com>
 <20250705131230.GA4059783@joelnvbox>
Content-Language: en-GB
From: Qi Xi <xiqi2@huawei.com>
In-Reply-To: <20250705131230.GA4059783@joelnvbox>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn200010.china.huawei.com (7.202.194.133)

Hi Joel,

After reverting the previous 2 commits and applying the new bugfix, the 
problem is resolved now.

Thanks for your help!


Best regards,

Qi


On 2025/7/5 21:12, Joel Fernandes wrote:
> On Thu, Jul 03, 2025 at 09:04:31AM +0800, Xiongfeng Wang wrote:
>>
>> On 2025/7/3 1:24, Joel Fernandes wrote:
>>>
>>> On 7/2/2025 6:59 AM, Joel Fernandes wrote:
>>>>
>>>> On 7/2/2025 5:14 AM, Qi Xi wrote:
>>>>> Hi Joel,
>>>>>
>>>>> After applying the 2 patches, the problem still exists. Compared to the previous
>>>>> fixes which did solve the problem, the difference is ct_in_irq() in the first
>>>>> patch.
>>>>>
>>>>> I am wondering why "nesting != CT_NESTING_IRQ_NONIDLE" is added?
>>>>>
>>>>>
>>>>> (previous fix: problem is solved)
>>>>>
>>>>> +bool ct_in_irq(void)
>>>>> +{
>>>>> +    return ct_nmi_nesting() != 0;
>>>>> +}
>>>>>
>>>>> (current fix: problem still exists)
>>>>>
>>>>> +bool ct_in_irq(void)
>>>>> +{
>>>>> +    long nesting = ct_nmi_nesting();
>>>>> +
>>>>> +    return (nesting && nesting != CT_NESTING_IRQ_NONIDLE);
>>>>> +}
>>>> Oh gosh, thanks for spotting that! Indeed,  I had changed it to != 0 in the last
>>>> version but applied an older patch. I will fix it in the tree. Thank you again!
>>>>
>>>> Neeraj, would you like this as a separate commit that you can then squash? Or
>>>> could you fix it up in your tree?
>>>>
>>> Qi, Xiongfeng, I am currently working on alternative fix after discussing with
>>> the crew. I will keep you posted with the fix, and would it to be good to get
>>> your testing on it once I have it (hopefully in couple of days), thanks for the
>>> report!
>> Sure, we are glad to help test once we get the fix patch.
> Could you try the following patch? I tested it and it fixes the issue for me.
>
> If you prefer git, then cherry-pick the HEAD commit from:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=rcu/irq-exit-v2-no-task
> (cherry-pick sha a58cc91fdca766cb719fb8beee3bb10ffe8e9d58)
>
> ---8<---
>
> From: Joel Fernandes <joelagnelf@nvidia.com>
> Subject: [PATCH] rcu: Fix rcu_read_unlock() deadloop due to IRQ work
>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>   kernel/rcu/tree.h        | 11 ++++++++++-
>   kernel/rcu/tree_plugin.h | 29 ++++++++++++++++++++++-------
>   2 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 3830c19cf2f6..f8f612269e6e 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -174,6 +174,15 @@ struct rcu_snap_record {
>   	unsigned long   jiffies;	/* Track jiffies value */
>   };
>   
> +/*
> + * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
> + * It can be in one of the following states:
> + * - DEFER_QS_IDLE: An IRQ work was never scheduled.
> + * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
> + */
> +#define DEFER_QS_IDLE		0
> +#define DEFER_QS_PENDING	1
> +
>   /* Per-CPU data for read-copy update. */
>   struct rcu_data {
>   	/* 1) quiescent-state and grace-period handling : */
> @@ -192,7 +201,7 @@ struct rcu_data {
>   					/*  during and after the last grace */
>   					/* period it is aware of. */
>   	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
> -	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
> +	int defer_qs_iw_pending;	/* Scheduler attention pending? */
>   	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
>   
>   	/* 2) batch handling */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index dd1c156c1759..baf57745b42f 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>   	struct rcu_node *rnp;
>   	union rcu_special special;
>   
> +	rdp = this_cpu_ptr(&rcu_data);
> +	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
> +		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
> +
>   	/*
>   	 * If RCU core is waiting for this CPU to exit its critical section,
>   	 * report the fact that it has exited.  Because irqs are disabled,
>   	 * t->rcu_read_unlock_special cannot change.
>   	 */
>   	special = t->rcu_read_unlock_special;
> -	rdp = this_cpu_ptr(&rcu_data);
>   	if (!special.s && !rdp->cpu_no_qs.b.exp) {
>   		local_irq_restore(flags);
>   		return;
> @@ -623,12 +626,24 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
>    */
>   static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>   {
> -	unsigned long flags;
> -	struct rcu_data *rdp;
> +	volatile unsigned long flags;
> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>   
> -	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
>   	local_irq_save(flags);
> -	rdp->defer_qs_iw_pending = false;
> +
> +	/*
> +	 * Requeue the IRQ work on next unlock in following situation:
> +	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
> +	 * 2. CPU enters new rcu_read_lock()
> +	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
> +	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
> +	 * 5. Deferred QS reporting does not happen.
> +	 */
> +	if (rcu_preempt_depth() > 0) {
> +		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
> +		local_irq_restore(flags);
> +		return;
> +	}
>   	local_irq_restore(flags);
>   }
>   
> @@ -675,7 +690,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>   			set_tsk_need_resched(current);
>   			set_preempt_need_resched();
>   			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> -			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
> +			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING && cpu_online(rdp->cpu)) {
>   				// Get scheduler to re-evaluate and call hooks.
>   				// If !IRQ_WORK, FQS scan will eventually IPI.
>   				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> @@ -685,7 +700,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>   				else
>   					init_irq_work(&rdp->defer_qs_iw,
>   						      rcu_preempt_deferred_qs_handler);
> -				rdp->defer_qs_iw_pending = true;
> +				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
>   				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>   			}
>   		}
