Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6423043C8;
	Mon, 22 Dec 2025 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766387532; cv=none; b=Pjedt4qwY594E3pP7zAWCkjeKR/evCf0SJEZMDIVh/EfqtZWoXHb5S7ch/5e92b0JX4JdNK4xveRZRIk6ulg4LDCbNHMawJgoxlKdqd56S9s+Yd+Wcf/FqP852unuc4qvgt9JnuY/akEW9pT4I1nylWq24Isx8DISxy37vH1qOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766387532; c=relaxed/simple;
	bh=aUNIWiozwaKGPbZ7we6g9cMR6WPhGKJa26i9/Y5kZg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pWZgsf28vbxTAJOnuVQCtRjYdI7+cdBnbj4Fbrvczc8oQfSb2pqYNfo+wRHLeGG12wAQCV5nMXsIqFFhpeFVFqat/CL4pH6y7RvNjbr/Dc1EQckqIzYtICEWyQ+KMfRhYwe2lWICpQOLHYRi4NPz7i8Fw3SwujXs6niBJsukd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3cPYQPNt; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3cPYQPNt"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ztb9+3n+GCcK2m5Ba62kPS3wLNEwIpgkFPKdZJKVyaU=;
	b=3cPYQPNtrXs76shTgfJzQEZ5A/8Iyb/JOHVAymP21fUFzHnurhqUI5HJAh734tIEbPvcfPg+o
	/EDU3CwB7WNJON+BpJ8T5S/u19oLgX6DxzzVw1iaYVePcIJOQe2gpLvmfp+X7K6APDw63Tx4QHd
	eWn/jvEwIdlGfG2ABvpphr4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dZTlQ0hvxzpT0h;
	Mon, 22 Dec 2025 15:09:06 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
	by mail.maildlp.com (Postfix) with ESMTPS id E315740363;
	Mon, 22 Dec 2025 15:11:58 +0800 (CST)
Received: from [100.103.109.15] (100.103.109.15) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Dec 2025 15:11:57 +0800
Message-ID: <597d8f33-106d-45bf-a6da-637ab05604e4@huawei.com>
Date: Mon, 22 Dec 2025 15:11:57 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Fix rcu_read_unlock() deadloop due to softirq
To: Joel Fernandes <joelagnelf@nvidia.com>
CC: <rcu@vger.kernel.org>, <liuyongqiang13@huawei.com>, <paulmck@kernel.org>,
	<frederic@kernel.org>, <neeraj.upadhyay@kernel.org>, <josh@joshtriplett.org>,
	<boqun.feng@gmail.com>, <urezki@gmail.com>, <rostedt@goodmis.org>,
	<mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
	<qiang.zhang@linux.dev>, <linux-kernel@vger.kernel.org>,
	<yujiacheng3@huawei.com>
References: <20251218074950.1936014-1-yaokai34@huawei.com>
 <20251219151400.GA820904@joelbox2>
 <16e20d68-8d19-45bd-b4a1-f2c067ca44a6@nvidia.com>
 <a32ad653-1bcb-44d4-9802-bcfc2725d712@nvidia.com>
Content-Language: en-US
From: Yao Kai <yaokai34@huawei.com>
In-Reply-To: <a32ad653-1bcb-44d4-9802-bcfc2725d712@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr500006.china.huawei.com (7.185.36.185)



On 12/19/2025 11:44 PM, Joel Fernandes wrote:
> 
> 
> On 12/19/2025 10:38 AM, Joel Fernandes wrote:
>>
>>
>> On 12/19/2025 10:14 AM, Joel Fernandes wrote:
>>> On Thu, Dec 18, 2025 at 03:49:50PM +0800, Yao Kai wrote:
>>>> Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
>>>> __rcu_read_unlock()") removes the recursion-protection code from
>>>> __rcu_read_unlock(). Therefore, we could invoke the deadloop in
>>>> raise_softirq_irqoff() with ftrace enabled as follows:
>>>>
>>>> WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stack.constprop.0+0x172/0x180
>>>> Modules linked in: my_irq_work(O)
>>>> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 PREEMPT(full)
>>>> Tainted: [O]=OOT_MODULE
>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>>>> RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
>>>> RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
>>>> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
>>>> RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
>>>> RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
>>>> R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
>>>> R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
>>>> FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:0000000000000000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
>>>> PKRU: 55555554
>>>> Call Trace:
>>>>   <IRQ>
>>>>   trace_buffer_unlock_commit_regs+0x6d/0x220
>>>>   trace_event_buffer_commit+0x5c/0x260
>>>>   trace_event_raw_event_softirq+0x47/0x80
>>>>   raise_softirq_irqoff+0x6e/0xa0
>>>>   rcu_read_unlock_special+0xb1/0x160
>>>>   unwind_next_frame+0x203/0x9b0
>>>>   __unwind_start+0x15d/0x1c0
>>>>   arch_stack_walk+0x62/0xf0
>>>>   stack_trace_save+0x48/0x70
>>>>   __ftrace_trace_stack.constprop.0+0x144/0x180
>>>>   trace_buffer_unlock_commit_regs+0x6d/0x220
>>>>   trace_event_buffer_commit+0x5c/0x260
>>>>   trace_event_raw_event_softirq+0x47/0x80
>>>>   raise_softirq_irqoff+0x6e/0xa0
>>>>   rcu_read_unlock_special+0xb1/0x160
>>>>   unwind_next_frame+0x203/0x9b0
>>>>   __unwind_start+0x15d/0x1c0
>>>>   arch_stack_walk+0x62/0xf0
>>>>   stack_trace_save+0x48/0x70
>>>>   __ftrace_trace_stack.constprop.0+0x144/0x180
>>>>   trace_buffer_unlock_commit_regs+0x6d/0x220
>>>>   trace_event_buffer_commit+0x5c/0x260
>>>>   trace_event_raw_event_softirq+0x47/0x80
>>>>   raise_softirq_irqoff+0x6e/0xa0
>>>>   rcu_read_unlock_special+0xb1/0x160
>>>>   unwind_next_frame+0x203/0x9b0
>>>>   __unwind_start+0x15d/0x1c0
>>>>   arch_stack_walk+0x62/0xf0
>>>>   stack_trace_save+0x48/0x70
>>>>   __ftrace_trace_stack.constprop.0+0x144/0x180
>>>>   trace_buffer_unlock_commit_regs+0x6d/0x220
>>>>   trace_event_buffer_commit+0x5c/0x260
>>>>   trace_event_raw_event_softirq+0x47/0x80
>>>>   raise_softirq_irqoff+0x6e/0xa0
>>>>   rcu_read_unlock_special+0xb1/0x160
>>>>   __is_insn_slot_addr+0x54/0x70
>>>>   kernel_text_address+0x48/0xc0
>>>>   __kernel_text_address+0xd/0x40
>>>>   unwind_get_return_address+0x1e/0x40
>>>>   arch_stack_walk+0x9c/0xf0
>>>>   stack_trace_save+0x48/0x70
>>>>   __ftrace_trace_stack.constprop.0+0x144/0x180
>>>>   trace_buffer_unlock_commit_regs+0x6d/0x220
>>>>   trace_event_buffer_commit+0x5c/0x260
>>>>   trace_event_raw_event_softirq+0x47/0x80
>>>>   __raise_softirq_irqoff+0x61/0x80
>>>>   __flush_smp_call_function_queue+0x115/0x420
>>>>   __sysvec_call_function_single+0x17/0xb0
>>>>   sysvec_call_function_single+0x8c/0xc0
>>>>   </IRQ>
>>>>
>>>> Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
>>>> fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
>>>> setting a flag before calling irq_work_queue_on(). We fix this issue by
>>>> setting the same flag before calling raise_softirq_irqoff() and rename the
>>>> flag to defer_qs_pending for more common.
>>>>
>>>> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")
>>>> Reported-by: Tengda Wu <wutengda2@huawei.com>
>>>> Signed-off-by: Yao Kai <yaokai34@huawei.com>
>>>
>>> Good change! It is the exact same pattern and both IRQ work and softirq
>>> raising are for deferred QS purposes.
>>>
>>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Could you please update the following comment in tree.h to say "An IRQ work or
>> softirq":
>>
>> /*
>>   * An IRQ work (deferred_qs_iw) is used by RCU to get the scheduler's attention.
>>   * to report quiescent states at the soonest possible time.
>>   * The request can be in one of the following states:
>>   * - DEFER_QS_IDLE: An IRQ work is yet to be scheduled.
>>   * - DEFER_QS_PENDING: An IRQ work was scheduled but either not yet run, or it
>>   *                     ran and we still haven't reported a quiescent state.
>>   */
>> #define DEFER_QS_IDLE           0
>> #define DEFER_QS_PENDING        1
>>
>> And resend the patch with my Review tag?
> 
> Oh, and update the variable name in the comment too (deferred_qs_iw) :) and all
> the occurences of "IRQ work" to "IRQ work or softirq".
> 
>   - Joel
> 
> 

Thanks for review. I will send a new patch later.

  - Kai
