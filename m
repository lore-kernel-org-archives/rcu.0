Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EDF493D43;
	Sat, 17 Oct 2026 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239969; cv=none; b=le0sV46/9nCX93J53XSP5Hn7Wxy+7Fx/NSKrX5e8gZT+uhobNuUxBlgWY2d/38NuJ4gKoSM8yr67vw4+WexHZBWMVCfvbGQGnVTpp0K/px/ymVxlJpsPrMqx6BVUbi7iOju9ZGUqBSIgvoIp5FcJcE0cuR+JM9lmOCtpb/V1ua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239969; c=relaxed/simple;
	bh=3Dq29GvGh4+bMOwB2XN89eh6PKn1kb/k9yJ4FeYK3AI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=roZv0ZC/RdHWyemDeEtWFgj5JOOUZZEWaZFU86eO4eATc+rsQVWFi5I6nUp3qqzzFEk5CnwsO0aA6Gpt/Lq0+YU3mqbtQZ0kY6q+5ryPuVuuoH2cbnkH07uAWutVK2MQbctCnbtirEUR3He5vLWhpE4BYYnWYIXE+3gYgvrOCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=LKnd038M; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=DePbOyNt; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="LKnd038M";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="DePbOyNt"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792239955; bh=wkpJtZu/njg0XVl7e2YOBb+
	gMzWBqWLd5zQ2I4DUGYU=; b=LKnd038M/GSeFAtMr/h1yKRPn6ZJHzTagPZqBlxb0qFzHi3Fw2
	kIjTAbE+t3opHbCUF84aSy591RH4jXuBeCPTefLO7jd7HJqL6D7K2dO90OV7WjGzOTWYEOGk6xk
	1PmIQbuaW9EiF1d9yXVOQacwye4kO3D6T8ixhN3fTwy1uyhdGk05oZmxyk+X+tjDk7GzU79+hOh
	k6NC7CgxxL7KLadbIBmOnqAEUO0/kgu5q9lGexgpLanWeDZ7EdLMoBkPMAONO3WMHJHRl5fbWNK
	hnQH55e69zgnJkWjqqaLh5pmJFNwTqa5WxaMeHm0ps7FBY15YfwKFpMPcbcTyj4IsxA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792239955; bh=wkpJtZu/njg0XVl7e2YOBb+
	gMzWBqWLd5zQ2I4DUGYU=; b=DePbOyNt9KkbyehT67Xjm7A5IpDjhfD9rmENK6u4dc32WyFvHA
	FP5iZYY30XjkN6WTfX9dO8dmrcnnXzAosACQ==;
Date: Sat, 17 Oct 2026 13:25:55 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Zqiang <qiang.zhang@linux.dev>
CC: boqun@kernel.org, frederic@kernel.org, joelagnelf@nvidia.com,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org, paulmck@kernel.org,
 rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
In-Reply-To: <C2E20E85-17A3-458C-9279-50022D30F5C8@mainlining.org>
References: <D155FA7E-8E99-4D4F-92A8-74472834F25A@mainlining.org> <8d7f265cd1320bf7996bcffea07ffdea69cfd625@linux.dev> <2247C12C-EE02-46CC-922F-D6A62D1E77C1@mainlining.org> <aa11c41ba0458bda078c6cdff9e2b155bee1a59b@linux.dev> <C2E20E85-17A3-458C-9279-50022D30F5C8@mainlining.org>
Message-ID: <AB14D6F5-9882-4527-82E6-BB33C1C7D3DE@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 17 October 2026 13:20:50 BST, Bradley Morgan <brads@mainlining.org>
wrote:
>On 17 October 2026 13:14:29 BST, Zqiang <qiang.zhang@linux.dev> wrote:
>>> 
>>> On 17 October 2026 00:41:00 BST, Zqiang <qiang.zhang@linux.dev> wrote:
>>> 
>>> > 
>>> > > 
>>> > > On 15 October 2026 10:46:19 BST, Zqiang <qiang.zhang@linux.dev>
>>wrote:
>>> > >  
>>> > >  > 
>>> > >  > The RCU Tasks Rude grace period is implemented by invoking the
>>> > >  > schedule_on_each_cpu() with an empty work function, which forces
>>> > >  > a context switch on every online CPU and guarantees that all
>>> > >  > rude-tasks read-side critical sections have completed. However,
>>> > >  > schedule_on_each_cpu() can fail (via alloc_percpu() returning
>>> > >  > -ENOMEM) and returns immediately, in which case those context
>>> > >  > switches never happen, too-short grace period happen.
>>> > >  > 
>>> > >  > This commit therefore wraps the schedule_on_each_cpu() call in
>>> > >  > WARN_ONCE() so that this failure is reported as a "Too-short
>>> > >  > grace period" warning.
>>> > >  > 
>>> > >  NAK, this seems like a edge case, and potentially panicking the
>>system
>>> > >  with panic on oops doesn't seem right to me, because we would
>>reserve
>>> > > 
>>> > that
>>> > 
>>> > > 
>>> > > for when something definitely goes really wrong and we need to
>>notify
>>> > >  the user.
>>> > >  
>>> > >  I don't believe this patch should go in for this reason, it's a
>>heavy
>>> > > 
>>> > edge
>>> > 
>>> > > 
>>> > > case, that doesn't *have* nessesarily need to be accounted for.
>>> > > 
>>> > Indeed, this is a rare event, so I use WARN_ONCE() to mark it, the
>>> > WARN_ONCE()
>>> > not panicking system unless you set warn_on_oops true, this can help
>>us
>>> > troubleshoot
>>> > UAF issues caused by a too short tasks-rude grace period.
>>> > 
>>> > or maybe we can use DEFINE_PER_CPU(struct work_struct, rude_work) to
>>> > replace
>>> > alloc_percpu(struct work_struct) queue to all online CPUs.
>>> > 
>>> > Anyway, Thank you for your reply. I would also like to hear the
>>opinions
>>> > of others.
>>> > 
>>> Fair enough, but me and Paul done some discussions:
>>> 
>>> Here is the TL;DR
>>> 
>>> My ^W^Wai slop^W^W tool helped me with this: if the too short grace
>>> happens,
>>> it falls back.
>>> 
>>> root@p10-linux-brads:~/linux# mailto:root@p10-linux-brads:~/linux#  git
>>diff kernel/rcu
>>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>>> index 627295396cd9..65bb7d4ed632 100644
>>> --- a/kernel/rcu/tasks.h
>>> +++ b/kernel/rcu/tasks.h
>>> @@ -1344,15 +1344,23 @@ void exit_tasks_rcu_finish(void) { }
>>>  // Ordering is provided by the scheduler's context-switch code.
>>> 
>>>  // Empty function to allow workqueues to force a context switch.
>>> -static void rcu_tasks_be_rude(struct work_struct *work)
>>> +static void __maybe_unused rcu_tasks_be_rude(struct work_struct *work)
>>>  {
>>>  }
>>> 
>>>  // Wait for one rude RCU-tasks grace period.
>>> +static void rcu_tasks_rude_ipi(void *info)
>>> +{
>>> +}
>>> +
>>>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>>>  {
>>> + int cpu;
>>>  rtp->n_ipis += cpumask_weight(cpu_online_mask);
>>> - schedule_on_each_cpu(rcu_tasks_be_rude);
>>> + cpus_read_lock();
>>> + for_each_online_cpu(cpu)
>>> + smp_call_function_single(cpu, rcu_tasks_rude_ipi, NULL, 1);
>>> + cpus_read_unlock();
>>>  }
>>
>>RCU Tasks Rude use preempt_disable/enable as the read critical section,
>>you use smp_call_function_single() to send ipi to each online CPUs, 
>>it's not forces a context sched switch, and not wait the
>>preempt_disable/enable
>>read critical section to exit, this is the wrong mechanism. ;-(
>>
>>Obviously, we only need to not apply alloc_percpu dynamic allocation:
>>
>>diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>>index fcac7361ec51..49b629b0010b 100644
>>--- a/kernel/rcu/tasks.h
>>+++ b/kernel/rcu/tasks.h
>>@@ -1357,11 +1357,25 @@ static void rcu_tasks_be_rude(struct work_struct
>*work)
>> {
>> }
>>
>>+static DEFINE_PER_CPU(struct work_struct, tasks_rude_work);
>>+
>> // Wait for one rude RCU-tasks grace period.
>> static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>> {
>>+       int cpu;
>>+
>>+       guard(cpus_read_lock)();
>>        rtp->n_ipis += cpumask_weight(cpu_online_mask);
>>-       schedule_on_each_cpu(rcu_tasks_be_rude);
>>+
>>+       for_each_online_cpu(cpu) {
>>+               struct work_struct *work = &per_cpu(tasks_rude_work,
>cpu);
>>+
>>+               INIT_WORK(work, rcu_tasks_be_rude);
>>+               schedule_work_on(cpu, work);
>>+       }
>>+
>>+       for_each_online_cpu(cpu)
>>+               flush_work(&per_cpu(tasks_rude_work, cpu));
>> }
>>
>> static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t
>> func);
>>
>
>Wow!
>
>Reviewed-by: Bradley Morgan <brads@mainlining.org>


Gimme a sec I'll submit the patch.. 

>
>>
>>Thanks
>>Zqiang
>>
>>
>>
>>> 
>>>  static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t
>>func);
>>> root@p10-linux-brads:~/linux# mailto:root@p10-linux-brads:~/linux# 
>>> 
>>> On POWERPC, this passes 12 hours of rcutorture on the RUDE01 config.
>>> 
>>> If you plan on submitting this into a patch, please add my authorship,
>>or
>>> my c-d-b. 
>>> 
>>> Feel free to rcutorture test it ;d
>>> 
>>> BTW: have you reproduced this on your own system?
>>> 
>>> > 
>>> > Thanks
>>> > Zqiang
>>> > 
>>> > > 
>>> > > Zqiang, have you reproduced this OOM on your own system, if so,
>>could
>>> > > 
>>> > you
>>> > 
>>> > > 
>>> > > tell me more details, you may turn my frown into a smiley face ;)
>>> > >  
>>> > >  > 
>>> > >  > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
>>> > >  > ---
>>> > >  > kernel/rcu/tasks.h | 3 ++-
>>> > >  > 1 file changed, 2 insertions(+), 1 deletion(-)
>>> > >  > 
>>> > >  > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>>> > >  > index fcac7361ec51..91c25717402e 100644
>>> > >  > --- a/kernel/rcu/tasks.h
>>> > >  > +++ b/kernel/rcu/tasks.h
>>> > >  > @@ -1361,7 +1361,8 @@ static void rcu_tasks_be_rude(struct
>>work_struct
>>> > > 
>>> > *work)
>>> > 
>>> > > 
>>> > > > static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>>> > >  > {
>>> > >  > rtp->n_ipis += cpumask_weight(cpu_online_mask);
>>> > >  > - schedule_on_each_cpu(rcu_tasks_be_rude);
>>> > >  > + WARN_ONCE(schedule_on_each_cpu(rcu_tasks_be_rude),
>>> > >  > + "%s: Too-short grace period, OOM is now expected
>>behavior!!!\n",
>>> > > 
>>> > rtp->name);
>>> > 
>>> > > 
>>> > > > 
>>> > >  Good message, makes sense. But I don't think this is right, see
>>above.
>>> > >  
>>> > >  > 
>>> > >  > }
>>> > >  > 
>>> > >  > static void call_rcu_tasks_rude(struct rcu_head *rhp,
>>rcu_callback_t
>>> > >  > func);
>>> > >  > 
>>> > >  --- Thanks!
>>> > >  "I'm not a very positive person" - Linus torvalds
>>> > >
>>> > 
>>> --- Thanks!
>>> "I'm not a very positive person" - Linus torvalds
>>>
>
>--- Thanks!
>"I'm not a very positive person" - Linus torvalds

--- Thanks!
"I'm not a very positive person" - Linus torvalds
