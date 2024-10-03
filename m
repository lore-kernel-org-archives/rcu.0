Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8F1990AA;
	Thu,  3 Oct 2024 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962377; cv=none; b=hzYUjOlbWJsPJhe1RkuTnehjD7MOY750x/5fqLFtNrqv5hXo5krOxPAhyX0qnw22CoLicwpEg4pdBOdWQUv0EyL7z+LKZEXn3oZW3EFfhiIC/WBLXeg4u4NUexkRfPN3Ur8oazYr+INdW5JeiCBkipmSA2xWiWTa8syD915FwH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962377; c=relaxed/simple;
	bh=YTSZ1gR4pl10kKX9+QjBQhs9v6DfHc5Ds/ZvHb/XL/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuyXXXECcQS0dzyzLnoED/4P7kQS+WTURoBrazw/CL2a8aNqYNHQBtwxHItGnUdGDfcGlIvlSBn9Zh++aV9ZQcnsvJUNo7Fj/pdz0xa8OTbFO78twFMoV8R/y5Wg3QpQ3jeudqY36SEl2WdyJwfhGi02GnRWn1du8IiBxIIKmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=X1GK8v/O; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="X1GK8v/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727962375;
	bh=YTSZ1gR4pl10kKX9+QjBQhs9v6DfHc5Ds/ZvHb/XL/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X1GK8v/OZtESLEHkimlfFxoawsowDAJytBMD2o7/U0FjMAMyY0u+RROxIqV1qNfcO
	 3VbzfSyj5e74S4TZIP+m3k83XPJdJNWh/ZRB8KvKn7KUAb6g7wvOlIjP+2ynmX6EWw
	 I1hoTW40T0gJ8+mI7oLSWsRRU+KbCt2Lr3PndOE1bIwNRv37f57wCKuVGJ6CaybKuh
	 4h7vJ/CxdQBINIqr6rnGhWb9eGjU+IV3tL5x2CgUP73uxbOv13P7MtRIjp6p6RAfbj
	 QwGn8sBl9bSG4nUAImNPfpOK1upeqFdU8V3+q3bwlJt0qieL+URAbG8uzQ1lmatJi7
	 RovViSGiBjP1A==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKCKf3WScz5Zd;
	Thu,  3 Oct 2024 09:32:54 -0400 (EDT)
Message-ID: <bb890ea6-742f-40b7-ad3d-aa28f658fa3d@efficios.com>
Date: Thu, 3 Oct 2024 09:30:53 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] hp: Implement Hazard Pointers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
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
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
 <20241002010205.1341915-4-mathieu.desnoyers@efficios.com>
 <Zv3kP477pGeOxuu9@boqun-archlinux>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <Zv3kP477pGeOxuu9@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-03 02:24, Boqun Feng wrote:
> On Tue, Oct 01, 2024 at 09:02:04PM -0400, Mathieu Desnoyers wrote:
[...]
>> +/*
>> + * hp_allocate: Allocate a hazard pointer.
>> + *
>> + * Allocate a hazard pointer slot for @addr. The object existence should
>> + * be guaranteed by the caller.
>> + *
>> + * Returns a hazard pointer context.
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
> 
> Are you assuming this is called with preemption disabled? Otherwise,
> there could two threads picking up the same hazard pointer slot on one
> CPU,

Indeed, this minimalist implementation only covers the preempt-off
use-case, where there is a single use of HP per CPU at any given
time (e.g. for the lazy mm use-case). It expects to be called
from preempt-off context. I will update the comment accordingly.

> 
>> +	/*
>> +	 * A single hazard pointer slot per CPU is available currently.
>> +	 * Other hazard pointer domains can eventually have a different
>> +	 * configuration.
>> +	 */
>> +	if (READ_ONCE(slot->addr))
>> +		goto fail;
> 
> .. and they could both read an empty slot, and both think they
> successfully protect the objects, which could be different objects.
> 
> Or am I missing something subtle here?

You are correct, I should document this.

> 
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
>> + * Returns a hazard pointer context.
>> + */
>> +static inline
>> +struct hp_ctx hp_dereference_allocate(struct hp_slot __percpu *percpu_slots, void * const * addr_p)
>> +{
>> +	struct hp_slot *slot;
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
> 
> Why rcu_access_pointer() instead of READ_ONCE()? Because you want to
> mark the head of address dependency?

Yes, the intent here is to mark the address dependency and provide
a publication guarantee similar to RCU pairing rcu_assign_pointer
and rcu_dereference. Do you see any reason why READ_ONCE() would
suffice here ?

Thanks,

Mathieu


> 
> Regards,
> Boqun
> 
>> +	/*
>> +	 * If @addr_p content has changed since the first load,
>> +	 * clear the hazard pointer and try again.
>> +	 */
>> +	if (!ptr_eq(addr2, addr)) {
>> +		WRITE_ONCE(slot->addr, NULL);
>> +		if (!addr2)
>> +			goto fail;
>> +		addr = addr2;
>> +		goto retry;
>> +	}
>> +	ctx.slot = slot;
>> +	ctx.addr = addr2;
>> +	return ctx;
>> +
>> +fail:
>> +	ctx.slot = NULL;
>> +	ctx.addr = NULL;
>> +	return ctx;
>> +}
>> +
> [...]

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

