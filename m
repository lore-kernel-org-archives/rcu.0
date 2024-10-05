Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0415E5C2;
	Sat,  5 Oct 2024 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728154343; cv=none; b=I6ImNBe1kpWpPoaz9E8vH1VxDXp1PKtyQF6WFrtGBFwqQ0rRLTBbrL1VNnGF9r6Jc48pOlhJfihBpgBxWH3t/pHkPsxHZ2AS5yjY5AEi5WGl6LRf7yn1bGtRz2zSR61WcK75sDuCWQsvDsnpC47kt1jkjMQ7WdNLBMgIewO71vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728154343; c=relaxed/simple;
	bh=JSI4GIafCFIDWNusASxURrvmoqUTCwAH/RTHAgePnVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1C/lLU2vyRXKTdYoWfge6G7ZhrKV3OU94WTeMh9p4nzOi6mSp++qX3AlRiFzaMYpdvqZLofzhQR/iGjH2tOtF5sIVHM2MHwOMpyNJPYDOmAuvwMRlpO8QMgyHmGFS6YQc4ZmHIGtq+d1BSQHhkkqaEI5seKoJhPG0G3n4TWXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=vxTXlShV; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vxTXlShV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728154338;
	bh=JSI4GIafCFIDWNusASxURrvmoqUTCwAH/RTHAgePnVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vxTXlShVlxBtfVRn9FZAIew6JLF1xV1uJViSIOkv1tsFkyEXnPZvLOTOPqNMXYRYJ
	 Suei90Ej5J6nX12eotVsnRrVCPkb36HAY3bEFgULmSHyDbRnXt4VMJlg6rqP8YM7cw
	 xbgMDtpdAI9AEq7Wc2t3mT6bLGznLBLJpLdujjmpUHjcROlKsKliaPw33sBQ/lVuel
	 irK0eTFdPU3Mckx8mpDUYFZxYJKUAQZGweM8R0C3+bin5khSmV3jOWvwSJ7ku5BLGJ
	 cCwCQspuaSQkYYFaU2ps1EAwdJGFxfYLayg3QZGPAoc2y4S4P+/iD1eoqQIvaxbSqr
	 /qgPE4N4CD7TA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XLZKG0RJxzcCP;
	Sat,  5 Oct 2024 14:52:18 -0400 (EDT)
Message-ID: <df28acef-cf35-49fc-8b40-bc105e3f818f@efficios.com>
Date: Sat, 5 Oct 2024 14:50:17 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/4] hp: Implement Hazard Pointers
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org,
 linux-mm@kvack.org, lkmm@lists.linux.dev
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
 <20241004182734.1761555-4-mathieu.desnoyers@efficios.com>
 <20241005160444.GA18071@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241005160444.GA18071@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-05 18:04, Peter Zijlstra wrote:
> On Fri, Oct 04, 2024 at 02:27:33PM -0400, Mathieu Desnoyers wrote:
>>   include/linux/hp.h | 158 +++++++++++++++++++++++++++++++++++++++++++++
>>   kernel/Makefile    |   2 +-
>>   kernel/hp.c        |  46 +++++++++++++
>>   3 files changed, 205 insertions(+), 1 deletion(-)
>>   create mode 100644 include/linux/hp.h
>>   create mode 100644 kernel/hp.c
>>
>> diff --git a/include/linux/hp.h b/include/linux/hp.h
>> new file mode 100644
>> index 000000000000..e85fc4365ea2
>> --- /dev/null
>> +++ b/include/linux/hp.h
>> @@ -0,0 +1,158 @@
>> +// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> +//
>> +// SPDX-License-Identifier: LGPL-2.1-or-later
>> +
>> +#ifndef _LINUX_HP_H
>> +#define _LINUX_HP_H
>> +
>> +/*
>> + * HP: Hazard Pointers
>> + *
>> + * This API provides existence guarantees of objects through hazard
>> + * pointers.
>> + *
>> + * It uses a fixed number of hazard pointer slots (nr_cpus) across the
>> + * entire system for each HP domain.
>> + *
>> + * Its main benefit over RCU is that it allows fast reclaim of
>> + * HP-protected pointers without needing to wait for a grace period.
>> + *
>> + * It also allows the hazard pointer scan to call a user-defined callback
>> + * to retire a hazard pointer slot immediately if needed. This callback
>> + * may, for instance, issue an IPI to the relevant CPU.
>> + *
>> + * References:
>> + *
>> + * [1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
>> + *      lock-free objects," in IEEE Transactions on Parallel and
>> + *      Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
>> + */
>> +
>> +#include <linux/rcupdate.h>
>> +
>> +/*
>> + * Hazard pointer slot.
>> + */
>> +struct hp_slot {
>> +	void *addr;
>> +};
>> +
>> +/*
>> + * Hazard pointer context, returned by hp_use().
>> + */
>> +struct hp_ctx {
>> +	struct hp_slot *slot;
>> +	void *addr;
>> +};
>> +
>> +/*
>> + * hp_scan: Scan hazard pointer domain for @addr.
>> + *
>> + * Scan hazard pointer domain for @addr.
>> + * If @retire_cb is NULL, wait to observe that each slot contains a value
>> + * that differs from @addr.
>> + * If @retire_cb is non-NULL, invoke @callback for each slot containing
>> + * @addr.
>> + */
>> +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
>> +	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr));
> 
> struct hp_domain {
> 	struct hp_slot __percpu *slots
> };
> 
> might clarify things a wee little.

Good point. This introduces:

#define DECLARE_HP_DOMAIN(domain)                                       \
         extern struct hp_domain domain

#define DEFINE_HP_DOMAIN(domain)                                        \
         static DEFINE_PER_CPU(struct hp_slot, __ ## domain ## _slots);  \
         struct hp_domain domain = {                                     \
                 .percpu_slots = &__## domain ## _slots,                 \
         }

> 
>> +
>> +/* Get the hazard pointer context address (may be NULL). */
>> +static inline
>> +void *hp_ctx_addr(struct hp_ctx ctx)
>> +{
>> +	return ctx.addr;
>> +}
> 
>  From where I'm sitting this seems like superfluous fluff, what's wrong
> with ctx.addr ?

I'm OK removing the accessor and just using ctx.addr.

> 
>> +/*
>> + * hp_allocate: Allocate a hazard pointer.
>> + *
>> + * Allocate a hazard pointer slot for @addr. The object existence should
>> + * be guaranteed by the caller. Expects to be called from preempt
>> + * disable context.
>> + *
>> + * Returns a hazard pointer context.
> 
> So you made the WTF'o'meter crack, this here function does not allocate
> nothing. Naming is bad. At best this is something like
> try-set-hazard-pointer or somesuch.

I went with the naming from the 2004 paper from Maged Michael, but I
agree it could be clearer.

I'm tempted to go for "hp_try_post()" and "hp_remove()", basically
"posting" the intent to use a pointer (as in on a metaphorical billboard),
and removing it when it's done.

> 
>> + */
>> +static inline
>> +struct hp_ctx hp_allocate(struct hp_slot __percpu *percpu_slots, void *addr)
>> +{
>> +	struct hp_slot *slot;
>> +	struct hp_ctx ctx;
>> +
>> +	if (!addr)
>> +		goto fail;
>> +	slot = this_cpu_ptr(percpu_slots);
>> +	/*
>> +	 * A single hazard pointer slot per CPU is available currently.
>> +	 * Other hazard pointer domains can eventually have a different
>> +	 * configuration.
>> +	 */
>> +	if (READ_ONCE(slot->addr))
>> +		goto fail;
>> +	WRITE_ONCE(slot->addr, addr);	/* Store B */
>> +	ctx.slot = slot;
>> +	ctx.addr = addr;
>> +	return ctx;
>> +
>> +fail:
>> +	ctx.slot = NULL;
>> +	ctx.addr = NULL;
>> +	return ctx;
>> +}
>> +
>> +/*
>> + * hp_dereference_allocate: Dereference and allocate a hazard pointer.
>> + *
>> + * Returns a hazard pointer context. Expects to be called from preempt
>> + * disable context.
>> + */
> 
> More terrible naming. Same as above, but additionally, I would expect a
> 'dereference' to actually dereference the pointer and have a return
> value of the dereferenced type.

hp_dereference_try_post() ?

> 
> This function seems to double check and update the hp_ctx thing. I'm not
> at all sure yet wtf this is doing -- and the total lack of comments
> aren't helping.

The hp_ctx contains the outputs.

The function loads *addr_p to then try_post it into a HP slot. On success,
it re-reads the *addr_p (with address dependency) and if it still matches,
use that as output address pointer.

I'm planning to remove hp_ctx, and just have:

/*
  * hp_try_post: Try to post a hazard pointer.
  *
  * Post a hazard pointer slot for @addr. The object existence should
  * be guaranteed by the caller. Expects to be called from preempt
  * disable context.
  *
  * Returns true if post succeeds, false otherwise.
  */
static inline
bool hp_try_post(struct hp_domain *hp_domain, void *addr, struct hp_slot **_slot)
[...]

/*
  * hp_dereference_try_post: Dereference and try to post a hazard pointer.
  *
  * Returns a hazard pointer context. Expects to be called from preempt
  * disable context.
  */
static inline
void *__hp_dereference_try_post(struct hp_domain *hp_domain,
                                 void * const * addr_p, struct hp_slot **_slot)
[...]

#define hp_dereference_try_post(domain, p, slot_p)              \
         ((__typeof__(*(p))) __hp_dereference_try_post(domain, (void * const *) p, slot_p))

/* Clear the hazard pointer in @slot. */
static inline
void hp_remove(struct hp_slot *slot)
[...]

> 
>> +static inline
>> +struct hp_ctx hp_dereference_allocate(struct hp_slot __percpu *percpu_slots, void * const * addr_p)
>> +{
>> +	void *addr, *addr2;
>> +	struct hp_ctx ctx;
>> +
>> +	addr = READ_ONCE(*addr_p);
>> +retry:
>> +	ctx = hp_allocate(percpu_slots, addr);
>> +	if (!hp_ctx_addr(ctx))
>> +		goto fail;
>> +	/* Memory ordering: Store B before Load A. */
>> +	smp_mb();
>> +	/*
>> +	 * Use RCU dereference without lockdep checks, because
>> +	 * lockdep is not aware of HP guarantees.
>> +	 */
>> +	addr2 = rcu_access_pointer(*addr_p);	/* Load A */
>> +	/*
>> +	 * If @addr_p content has changed since the first load,
>> +	 * clear the hazard pointer and try again.
>> +	 */
>> +	if (!ptr_eq(addr2, addr)) {
>> +		WRITE_ONCE(ctx.slot->addr, NULL);
>> +		if (!addr2)
>> +			goto fail;
>> +		addr = addr2;
>> +		goto retry;
>> +	}
>> +	/*
>> +	 * Use addr2 loaded from rcu_access_pointer() to preserve
>> +	 * address dependency ordering.
>> +	 */
>> +	ctx.addr = addr2;
>> +	return ctx;
>> +
>> +fail:
>> +	ctx.slot = NULL;
>> +	ctx.addr = NULL;
>> +	return ctx;
>> +}
>> +
>> +/* Retire the hazard pointer in @ctx. */
>> +static inline
>> +void hp_retire(const struct hp_ctx ctx)
>> +{
>> +	smp_store_release(&ctx.slot->addr, NULL);
>> +}
>> +
>> +#endif /* _LINUX_HP_H */
>> diff --git a/kernel/Makefile b/kernel/Makefile
>> index 3c13240dfc9f..ec16de96fa80 100644
>> --- a/kernel/Makefile
>> +++ b/kernel/Makefile
>> @@ -7,7 +7,7 @@ obj-y     = fork.o exec_domain.o panic.o \
>>   	    cpu.o exit.o softirq.o resource.o \
>>   	    sysctl.o capability.o ptrace.o user.o \
>>   	    signal.o sys.o umh.o workqueue.o pid.o task_work.o \
>> -	    extable.o params.o \
>> +	    extable.o params.o hp.o \
>>   	    kthread.o sys_ni.o nsproxy.o \
>>   	    notifier.o ksysfs.o cred.o reboot.o \
>>   	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
>> diff --git a/kernel/hp.c b/kernel/hp.c
>> new file mode 100644
>> index 000000000000..b2447bf15300
>> --- /dev/null
>> +++ b/kernel/hp.c
>> @@ -0,0 +1,46 @@
>> +// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> +//
>> +// SPDX-License-Identifier: LGPL-2.1-or-later
>> +
>> +/*
>> + * HP: Hazard Pointers
>> + */
>> +
>> +#include <linux/hp.h>
>> +#include <linux/percpu.h>
>> +
>> +/*
>> + * hp_scan: Scan hazard pointer domain for @addr.
>> + *
>> + * Scan hazard pointer domain for @addr.
>> + * If @retire_cb is non-NULL, invoke @callback for each slot containing
>> + * @addr.
>> + * Wait to observe that each slot contains a value that differs from
>> + * @addr before returning.
>> + */
>> +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
>> +	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr))
>> +{
>> +	int cpu;
>> +
>> +	/*
>> +	 * Store A precedes hp_scan(): it unpublishes addr (sets it to
>> +	 * NULL or to a different value), and thus hides it from hazard
>> +	 * pointer readers.
>> +	 */
>> +
>> +	if (!addr)
>> +		return;
>> +	/* Memory ordering: Store A before Load B. */
>> +	smp_mb();
>> +	/* Scan all CPUs slots. */
>> +	for_each_possible_cpu(cpu) {
>> +		struct hp_slot *slot = per_cpu_ptr(percpu_slots, cpu);
>> +
>> +		if (retire_cb && smp_load_acquire(&slot->addr) == addr)	/* Load B */
>> +			retire_cb(cpu, slot, addr);
> 
> Is retirce_cb allowed to cmpxchg the thing?

It could, but we'd need to make sure the slot is not re-used by another
hp_try_post() before the current user removes its own post. It would
need to synchronize with the current HP user (e.g. with IPI).

I've actually renamed retire_cb to "on_match_cb".

> 
>> +		/* Busy-wait if node is found. */
>> +		while ((smp_load_acquire(&slot->addr)) == addr)	/* Load B */
>> +			cpu_relax();
> 
> This really should be using smp_cond_load_acquire()

Good point,

Thanks,

Mathieu

> 
>> +	}
>> +}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

