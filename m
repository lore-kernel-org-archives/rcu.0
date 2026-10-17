Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CAA4CF489;
	Sat, 17 Oct 2026 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792267707; cv=none; b=uxsUq0z8cOsB40FWs/1+eqvZQvmJODEYi4/tBmwa2LOUCZ7EAKH+BIdVwyXezCvaAOKMg10bNzHTm4UrZSHHA1yIJftVPmqLTIp3pqtrjV2OAMEJgKdpFSrEC8G4FJjLdYu2KV6ZldCUGb4nv0d28Mjdvc7Otfb7P0vNv2dxa1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792267707; c=relaxed/simple;
	bh=SgxPrBIkYCcPi30gyGH4MQTBEMSNpjs9yE/2MFe/s4g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=n2Hpu0tCesBC5MPi/xIEtngC1uicoOxPz8+9WD4Ei9qRMWLCyFe5N65o+N9Wk3GjWS4eaGLLCducdSW4M8RDVghlM8FDB264JOjnVUQTB8uP0sgDa60Q3nDekTc0wxRbCOfcsjnjmVFB3Xu1Lc7peB39ZbPPVeB3EHOtA6RTzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=pTdYhPl+; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=juc68V3q; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="pTdYhPl+";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="juc68V3q"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792267703; bh=yJCb7x6Wu2ieI/lhWZQWGE6
	i7B6nkQk7onSe4PgkTEQ=; b=pTdYhPl+NELM4pRNAQ6x9GPt/fr/uQeTwwQQda7xgp3lIzHVDa
	QzlCq+jcg1VpFahy29klJBjAQYmXFJrrwGSmuChH7SMdwZTmqSFaD/sh1HjwLzCXhQM1oTBEAqh
	ipPXBPGmIv8FkdfoiRRrol2FArELbrIodrWSL/JQxWgp4lCIjh0cuoiu4LeVNnruqO1wYJBbK3j
	iCrydEDZxFw+mlJHTQ5vOhTBuI/sZ2FNnWrQ1fJPVcMzt/1yXsymfoxKtcDfKe3yGwr6KiztumJ
	wkiYvfApvvLmonfLB+BUEVXaulMTo2l8FiGGjJGFJVP24KN3+ElVgK2KWP4e+Gy5hbA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792267703; bh=yJCb7x6Wu2ieI/lhWZQWGE6
	i7B6nkQk7onSe4PgkTEQ=; b=juc68V3qa0mzmmjElu/dKfqgrzkJmv3Kq9Own+6gDMUfj7ZnS0
	kzX8wKRUmtpqnwKYEIZSqHMEFbWN3GO45ZDg==;
Date: Sat, 17 Oct 2026 21:08:24 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
CC: Zqiang <qiang.zhang@linux.dev>, boqun@kernel.org, frederic@kernel.org,
 joelagnelf@nvidia.com, linux-kernel@vger.kernel.org,
 neeraj.upadhyay@kernel.org, rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH] rcu-tasks: Warn on too-short RCU Tasks Rude grace period
In-Reply-To: <82551705-77de-48d3-b310-ba23a5549903@paulmck-laptop>
References: <D155FA7E-8E99-4D4F-92A8-74472834F25A@mainlining.org> <8d7f265cd1320bf7996bcffea07ffdea69cfd625@linux.dev> <2247C12C-EE02-46CC-922F-D6A62D1E77C1@mainlining.org> <3fc682be-c0ed-48b2-ae91-af80d1535520@paulmck-laptop> <0E5D0BB2-BEF1-430A-B30C-C53F4254214F@mainlining.org> <82551705-77de-48d3-b310-ba23a5549903@paulmck-laptop>
Message-ID: <5568467D-34D6-4735-9F01-43B2CB8C207F@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 17 October 2026 21:04:37 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Sat, Oct 17, 2026 at 06:49:41PM +0100, Bradley Morgan wrote:
>> On 17 October 2026 18:46:25 BST, "Paul E. McKenney" <paulmck@kernel.org>
>> wrote:
>> >On Sat, Oct 17, 2026 at 12:16:48PM +0100, Bradley Morgan wrote:
>> >> On 17 October 2026 00:41:00 BST, Zqiang <qiang.zhang@linux.dev>
>wrote:
>> >> >> 
>> >> >> On 15 October 2026 10:46:19 BST, Zqiang <qiang.zhang@linux.dev>
>> >wrote:
>> >> >> 
>> >> >> > 
>> >> >> > The RCU Tasks Rude grace period is implemented by invoking the
>> >> >> > schedule_on_each_cpu() with an empty work function, which forces
>> >> >> > a context switch on every online CPU and guarantees that all
>> >> >> > rude-tasks read-side critical sections have completed. However,
>> >> >> > schedule_on_each_cpu() can fail (via alloc_percpu() returning
>> >> >> > -ENOMEM) and returns immediately, in which case those context
>> >> >> > switches never happen, too-short grace period happen.
>> >> >> > 
>> >> >> > This commit therefore wraps the schedule_on_each_cpu() call in
>> >> >> > WARN_ONCE() so that this failure is reported as a "Too-short
>> >> >> > grace period" warning.
>> >> >> > 
>> >> >> NAK, this seems like a edge case, and potentially panicking the
>> >system
>> >> >> with panic on oops doesn't seem right to me, because we would
>reserve
>> >> >that
>> >> >> for when something definitely goes really wrong and we need to
>notify
>> >> >> the user.
>> >> >> 
>> >> >> I don't believe this patch should go in for this reason, it's a
>heavy
>> >> >edge
>> >> >> case, that doesn't *have* nessesarily need to be accounted for.
>> >> >
>> >> >Indeed, this is a rare event, so I use WARN_ONCE() to mark it, the
>> >> >WARN_ONCE()
>> >> >not panicking system unless you set warn_on_oops true, this can help
>us
>> >> >troubleshoot
>> >> >UAF issues caused by a too short tasks-rude grace period.
>> >> >
>> >> >or maybe we can use DEFINE_PER_CPU(struct work_struct, rude_work) to
>> >> >replace
>> >> >alloc_percpu(struct work_struct) queue to all online CPUs.
>> >> >
>> >> >Anyway, Thank you for your reply. I would also like to hear the
>> >opinions
>> >> >of others.
>> >> 
>> >> Fair enough, but me and Paul done some discussions:
>> >> 
>> >> Here is the TL;DR
>> >> 
>> >> My ^W^Wai slop^W^W tool helped me with this: if the too short grace
>> >> happens,
>> >> it falls back.
>> >> 
>> >> 
>> >> root@p10-linux-brads:~/linux# git diff kernel/rcu
>> >> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>> >> index 627295396cd9..65bb7d4ed632 100644
>> >> --- a/kernel/rcu/tasks.h
>> >> +++ b/kernel/rcu/tasks.h
>> >> @@ -1344,15 +1344,23 @@ void exit_tasks_rcu_finish(void) { }
>> >>  // Ordering is provided by the scheduler's context-switch code.
>> >> 
>> >>  // Empty function to allow workqueues to force a context switch.
>> >> -static void rcu_tasks_be_rude(struct work_struct *work)
>> >> +static void __maybe_unused rcu_tasks_be_rude(struct work_struct
>*work)
>> >>  {
>> >>  }
>> >> 
>> >>  // Wait for one rude RCU-tasks grace period.
>> >> +static void rcu_tasks_rude_ipi(void *info)
>> >> +{
>> >> +}
>> >> +
>> >>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>> >>  {
>> >> +       int cpu;
>> >>         rtp->n_ipis += cpumask_weight(cpu_online_mask);
>> >> -       schedule_on_each_cpu(rcu_tasks_be_rude);
>> >> +       cpus_read_lock();
>> >> +       for_each_online_cpu(cpu)
>> >> +               smp_call_function_single(cpu, rcu_tasks_rude_ipi,
>NULL,
>> >1);
>> >> +       cpus_read_unlock();
>> >>  }
>> >> 
>> >>  static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t
>> >func);
>> >> root@p10-linux-brads:~/linux#
>> >> 
>> >> On POWERPC, this passes 12 hours of rcutorture on the RUDE01 config.
>> >
>> >That is surprising, given that when I run your patch shown above on my
>> >x86 laptop, rcutorture reports a too-short grace period within 20
>seconds.
>> 
>> Odd! I definitely ran it for 12 hours, on PowerPC, so this is certainly
>odd
>
>Those who care are free run it themselves on the systems of their choice.


root@p10-linux-brads:~/linux/tools/testing/selftests/rcutorture/res/2026.10.15-19.45.43/RUDE01#
uname -a && uname
Linux p10-linux-brads 7.0.0-34-generic #34-Ubuntu SMP PREEMPT_DYNAMIC Wed
Sep  2 16:05:10 UTC 2026 ppc64le GNU/Linux
Linux
root@p10-linux-brads:~/linux/tools/testing/selftests/rcutorture/res/2026.10.15-19.45.43/RUDE01#
tail -n 20 console.log
[43269.029077][   T73] tasks-rude-torture: rcu_torture_read_exit: Start of
episode
[43269.033954][   T73] tasks-rude-torture: rcu_torture_read_exit: End of
episode
[43282.341070][   T73] tasks-rude-torture: rcu_torture_read_exit: Start of
episode
[43282.345268][   T73] tasks-rude-torture: rcu_torture_read_exit: End of
episode
[43295.653087][   T73] tasks-rude-torture: rcu_torture_read_exit: Start of
episode
[43295.657260][   T73] tasks-rude-torture: rcu_torture_read_exit: End of
episode
[43308.965081][   T73] tasks-rude-torture: rcu_torture_read_exit: Start of
episode
[43308.969151][   T73] tasks-rude-torture: rcu_torture_read_exit: End of
episode
[43322.277071][   T73] tasks-rude-torture: rcu_torture_read_exit: Start of
episode
[43322.281345][   T73] tasks-rude-torture: rcu_torture_read_exit: End of
episode
[43335.589160][   T73] tasks-rude-torture: rcu_torture_read_exit: Start of
episode
[43335.593159][   T73] tasks-rude-torture: rcu_torture_read_exit: End of
episode
[43348.901077][   T73] tasks-rude-torture: rcu_torture_read_exit: Start of
episode
[43348.905165][   T73] tasks-rude-torture: rcu_torture_read_exit: End of
episode
[43362.213069][   T73] tasks-rude-torture: rcu_torture_read_exit: Start of
episode
[43362.217298][   T73] tasks-rude-torture: rcu_torture_read_exit: End of
episode
[43375.525085][   T73] tasks-rude-torture: rcu_torture_read_exit: Start of
episode
[43375.529207][   T73] tasks-rude-torture: rcu_torture_read_exit: End of
episode
[43388.837074][   T73] tasks-rude-torture: rcu_torture_read_exit: Start of
episode
[43388.841160][   T73] tasks-rude-torture: rcu_torture_read_exit: End of
episode
root@p10-linux-brads:~/linux/tools/testing/selftests/rcutorture/res/2026.10.15-19.45.43/RUDE01#

I certainly ran it :(


>
>							Thanx, Paul
>
>> >> If you plan on submitting this into a patch, please add my
>authorship,
>> >or
>> >> my c-d-b. 
>> >> 
>> >> Feel free to rcutorture test it ;d
>> >> 
>> >> BTW: have you reproduced this on your own system?
>> >> 
>> >> >
>> >> >Thanks
>> >> >Zqiang
>> >> >
>> >> >
>> >> >> 
>> >> >> Zqiang, have you reproduced this OOM on your own system, if so,
>could
>> >> >you
>> >> >> tell me more details, you may turn my frown into a smiley face ;)
>> >> >> 
>> >> >> > 
>> >> >> > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
>> >> >> > ---
>> >> >> >  kernel/rcu/tasks.h | 3 ++-
>> >> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >> >> > 
>> >> >> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>> >> >> > index fcac7361ec51..91c25717402e 100644
>> >> >> > --- a/kernel/rcu/tasks.h
>> >> >> > +++ b/kernel/rcu/tasks.h
>> >> >> > @@ -1361,7 +1361,8 @@ static void rcu_tasks_be_rude(struct
>> >work_struct
>> >> >*work)
>> >> >> >  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>> >> >> >  {
>> >> >> >  rtp->n_ipis += cpumask_weight(cpu_online_mask);
>> >> >> > - schedule_on_each_cpu(rcu_tasks_be_rude);
>> >> >> > + WARN_ONCE(schedule_on_each_cpu(rcu_tasks_be_rude),
>> >> >> > + "%s: Too-short grace period, OOM is now expected
>behavior!!!\n",
>> >> >rtp->name);
>> >> >> > 
>> >> >> Good message, makes sense. But I don't think this is right, see
>> >above.
>> >> >> 
>> >> >> > 
>> >> >> > }
>> >> >> >  
>> >> >> >  static void call_rcu_tasks_rude(struct rcu_head *rhp,
>> >rcu_callback_t
>> >> >> >  func);
>> >> >> > 
>> >> >> --- Thanks!
>> >> >> "I'm not a very positive person" - Linus torvalds
>> >> >>
>> >> 
>> >> --- Thanks!
>> >> "I'm not a very positive person" - Linus torvalds
>> 
>> --- Thanks!
>> "I'm not a very positive person" - Linus torvalds

--- Thanks!
"I'm not a very positive person" - Linus torvalds
