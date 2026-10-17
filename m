Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848DD35E93B;
	Sat, 17 Oct 2026 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792259403; cv=none; b=te6qbP4fzN9ut2ibeMz6+P1UeoaGfpvoNmx4dmIQUQpVIVrmjifBq/8zkgn3RUyvSMSUy9/thEYBRNfCt5veLLO26BBYM3hcuckSIX7+Kwd+IVm3cVoJyrkFB6tKi+iilSV23LBouzIqLVAHHdFLleGNgVDTsAXO4cq5NLZIhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792259403; c=relaxed/simple;
	bh=WomyPTJOf7S6kPc9z8XyViMr1A04acnVLxGEefz8QuQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sGR2SnNrTjB6QDkAqONdIfNLK2nAf4/YGBJHsDvhZGCvwiokxHtgRsKkxLZV8MM3Qp9y9TH+p219uTA1MXeGUqjKAzRcKFZIvZjC9YpWdHzLF0QnHrIisIUbCTJIX0s80SF2xY0bnWvz4J0/rm5S09Jxvau2r6fRu+zLTvNwYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=a5Mn7W6/; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=XC0HNqzp; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="a5Mn7W6/";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="XC0HNqzp"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792259383; bh=lFWRw1M0xQeR8VHphjUrnfw
	TJEkg/MDrPe6wHSJ5D2k=; b=a5Mn7W6/X3ufD6GkM85wlwq32g2oPYQgBkyTCuEoliBZ0TbTTV
	VgIvpVCrn9WRf0RMrEI44buffBWTagtE1R/P7miOZ0+QcM0TqNtLS8NOVBm0kbIzydUngwbnQvi
	9xzT3hcfZl/E5GnBObo0+6mUeKhoMZ0L23jtbRKZN9330EMuiz9ZqBBv3/+Nlb7/KppWIlVJwzk
	3dDEjhgaz2ndF6TchUd8EWvrrvseWpoS0F9SB9KMQUxoM20zmyGll4qNaqG608v6E9HZRsJpi0h
	5LWDjcxlhj6DqIr/CE9gD1+S7Jjb5zUFZcZ9gWzR298kXEW1Yo17TWe5fpvq+UhKkYQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792259383; bh=lFWRw1M0xQeR8VHphjUrnfw
	TJEkg/MDrPe6wHSJ5D2k=; b=XC0HNqzpY/XdCCtYW2j0EOQsbAfbWvzcmGjJqZHBu6aozXWVnm
	LdtvV1GfiVr26J1clSch6vH+MaSm/PbUSzCA==;
Date: Sat, 17 Oct 2026 18:49:41 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
CC: Zqiang <qiang.zhang@linux.dev>, boqun@kernel.org, frederic@kernel.org,
 joelagnelf@nvidia.com, linux-kernel@vger.kernel.org,
 neeraj.upadhyay@kernel.org, rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
In-Reply-To: <3fc682be-c0ed-48b2-ae91-af80d1535520@paulmck-laptop>
References: <D155FA7E-8E99-4D4F-92A8-74472834F25A@mainlining.org> <8d7f265cd1320bf7996bcffea07ffdea69cfd625@linux.dev> <2247C12C-EE02-46CC-922F-D6A62D1E77C1@mainlining.org> <3fc682be-c0ed-48b2-ae91-af80d1535520@paulmck-laptop>
Message-ID: <0E5D0BB2-BEF1-430A-B30C-C53F4254214F@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 17 October 2026 18:46:25 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Sat, Oct 17, 2026 at 12:16:48PM +0100, Bradley Morgan wrote:
>> On 17 October 2026 00:41:00 BST, Zqiang <qiang.zhang@linux.dev> wrote:
>> >> 
>> >> On 15 October 2026 10:46:19 BST, Zqiang <qiang.zhang@linux.dev>
>wrote:
>> >> 
>> >> > 
>> >> > The RCU Tasks Rude grace period is implemented by invoking the
>> >> > schedule_on_each_cpu() with an empty work function, which forces
>> >> > a context switch on every online CPU and guarantees that all
>> >> > rude-tasks read-side critical sections have completed. However,
>> >> > schedule_on_each_cpu() can fail (via alloc_percpu() returning
>> >> > -ENOMEM) and returns immediately, in which case those context
>> >> > switches never happen, too-short grace period happen.
>> >> > 
>> >> > This commit therefore wraps the schedule_on_each_cpu() call in
>> >> > WARN_ONCE() so that this failure is reported as a "Too-short
>> >> > grace period" warning.
>> >> > 
>> >> NAK, this seems like a edge case, and potentially panicking the
>system
>> >> with panic on oops doesn't seem right to me, because we would reserve
>> >that
>> >> for when something definitely goes really wrong and we need to notify
>> >> the user.
>> >> 
>> >> I don't believe this patch should go in for this reason, it's a heavy
>> >edge
>> >> case, that doesn't *have* nessesarily need to be accounted for.
>> >
>> >Indeed, this is a rare event, so I use WARN_ONCE() to mark it, the
>> >WARN_ONCE()
>> >not panicking system unless you set warn_on_oops true, this can help us
>> >troubleshoot
>> >UAF issues caused by a too short tasks-rude grace period.
>> >
>> >or maybe we can use DEFINE_PER_CPU(struct work_struct, rude_work) to
>> >replace
>> >alloc_percpu(struct work_struct) queue to all online CPUs.
>> >
>> >Anyway, Thank you for your reply. I would also like to hear the
>opinions
>> >of others.
>> 
>> Fair enough, but me and Paul done some discussions:
>> 
>> Here is the TL;DR
>> 
>> My ^W^Wai slop^W^W tool helped me with this: if the too short grace
>> happens,
>> it falls back.
>> 
>> 
>> root@p10-linux-brads:~/linux# git diff kernel/rcu
>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>> index 627295396cd9..65bb7d4ed632 100644
>> --- a/kernel/rcu/tasks.h
>> +++ b/kernel/rcu/tasks.h
>> @@ -1344,15 +1344,23 @@ void exit_tasks_rcu_finish(void) { }
>>  // Ordering is provided by the scheduler's context-switch code.
>> 
>>  // Empty function to allow workqueues to force a context switch.
>> -static void rcu_tasks_be_rude(struct work_struct *work)
>> +static void __maybe_unused rcu_tasks_be_rude(struct work_struct *work)
>>  {
>>  }
>> 
>>  // Wait for one rude RCU-tasks grace period.
>> +static void rcu_tasks_rude_ipi(void *info)
>> +{
>> +}
>> +
>>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>>  {
>> +       int cpu;
>>         rtp->n_ipis += cpumask_weight(cpu_online_mask);
>> -       schedule_on_each_cpu(rcu_tasks_be_rude);
>> +       cpus_read_lock();
>> +       for_each_online_cpu(cpu)
>> +               smp_call_function_single(cpu, rcu_tasks_rude_ipi, NULL,
>1);
>> +       cpus_read_unlock();
>>  }
>> 
>>  static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t
>func);
>> root@p10-linux-brads:~/linux#
>> 
>> On POWERPC, this passes 12 hours of rcutorture on the RUDE01 config.
>
>That is surprising, given that when I run your patch shown above on my
>x86 laptop, rcutorture reports a too-short grace period within 20 seconds.

Odd! I definitely ran it for 12 hours, on PowerPC, so this is certainly odd

>
>							Thanx, Paul
>
>> If you plan on submitting this into a patch, please add my authorship,
>or
>> my c-d-b. 
>> 
>> Feel free to rcutorture test it ;d
>> 
>> BTW: have you reproduced this on your own system?
>> 
>> >
>> >Thanks
>> >Zqiang
>> >
>> >
>> >> 
>> >> Zqiang, have you reproduced this OOM on your own system, if so, could
>> >you
>> >> tell me more details, you may turn my frown into a smiley face ;)
>> >> 
>> >> > 
>> >> > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
>> >> > ---
>> >> >  kernel/rcu/tasks.h | 3 ++-
>> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >> > 
>> >> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>> >> > index fcac7361ec51..91c25717402e 100644
>> >> > --- a/kernel/rcu/tasks.h
>> >> > +++ b/kernel/rcu/tasks.h
>> >> > @@ -1361,7 +1361,8 @@ static void rcu_tasks_be_rude(struct
>work_struct
>> >*work)
>> >> >  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>> >> >  {
>> >> >  rtp->n_ipis += cpumask_weight(cpu_online_mask);
>> >> > - schedule_on_each_cpu(rcu_tasks_be_rude);
>> >> > + WARN_ONCE(schedule_on_each_cpu(rcu_tasks_be_rude),
>> >> > + "%s: Too-short grace period, OOM is now expected behavior!!!\n",
>> >rtp->name);
>> >> > 
>> >> Good message, makes sense. But I don't think this is right, see
>above.
>> >> 
>> >> > 
>> >> > }
>> >> >  
>> >> >  static void call_rcu_tasks_rude(struct rcu_head *rhp,
>rcu_callback_t
>> >> >  func);
>> >> > 
>> >> --- Thanks!
>> >> "I'm not a very positive person" - Linus torvalds
>> >>
>> 
>> --- Thanks!
>> "I'm not a very positive person" - Linus torvalds

--- Thanks!
"I'm not a very positive person" - Linus torvalds
