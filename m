Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1482417DFE9;
	Sat, 28 Sep 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727523350; cv=none; b=uQwpBluUiyTrXk4Q5AN1e8jCWuP5PcbLSRed/P/mGr7Bi2uUZsLgNvi+pCy0Ai/11wTgi8IfwDdgHdHJpxHKVyc07QOIMjp5y/Xfs4OCAVjBT66C9zLnVY95JIVJqjr/aWk0Rm3eCmHDRgyRPR4z84nO8HG/qd+KrwueoCUW13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727523350; c=relaxed/simple;
	bh=5lMXHFtn0jEoSxgXj3YeXoWW7aLl3YwVJkTxD0aY9Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZIJ+a4swkOrN+cETCE7q6rbDZ/6NrEM9pYuv23AtOBIBQsgnzWVV+RAdOPicH7mBLpmhSkyKbVUx5kmpTHpc3X/Dtbs1Le+12YTj6sdtNQgIH0GYdVwwVFDEIjEgh253+Aacv+m8U5TPOEwlgHh9NdvegUvkCrf+udac5U3UTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hOr8uGwP; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hOr8uGwP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727523342;
	bh=5lMXHFtn0jEoSxgXj3YeXoWW7aLl3YwVJkTxD0aY9Cs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hOr8uGwP1TTSe8m6DHD671x0tWa98Xb1hZRss8eWxYv6g9Qor63TrPpXcP7obYlms
	 tnYPBRGIq97iQBkWPmB3s7CC+7GIGMuACO1mXtqtpUxkJGejBXFoxwfXM/eTXk5thW
	 zhKZ8DTE2zeu6IpLnsRCeQyPyQD7WggQ0wQEK8QY7kl2j85U2hY5a7JiTo1pEeaqtE
	 rUd7hS88Omfqk+EGtsd9N3rPTNnaookz4corTEJkQ9ssAfexpbTGU6jhX4kOkfNLae
	 Qf6foZYIXejmOAM4PLp97DJd3F7qUZmnt3cEvAmTkTHYJbLxh8UgROs3DuwtdGhHqE
	 4RTk5216pVDxQ==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XG4yk2Ys7z1Zbx;
	Sat, 28 Sep 2024 07:35:42 -0400 (EDT)
Message-ID: <2ca589bc-2a60-48ef-95a0-d9ee4a814dea@efficios.com>
Date: Sat, 28 Sep 2024 07:33:37 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] hpref: Hazard Pointers with Reference Counter
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Alan Stern
 <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev
References: <20240921164210.256278-1-mathieu.desnoyers@efficios.com>
 <db17633f-354d-428e-97c2-bcd455766c3a@huaweicloud.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <db17633f-354d-428e-97c2-bcd455766c3a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-28 13:22, Jonas Oberhauser wrote:
> Two more questions below:
> 
> Am 9/21/2024 um 6:42 PM schrieb Mathieu Desnoyers:
>> +#define NR_PERCPU_SLOTS_BITS    3
> 
> Have you measured any advantage of this multi-slot version vs a version 
> with just one normal slot and one emergency slot?

No, I have not. That being said, I am taking a minimalistic
approach that takes things even further in the "simple" direction
for what I will send as RFC against the Linux kernel:
there is just the one "emergency slot", irqs are disabled around
use of the HP slot, and promotion to refcount is done before
returning to the caller.

> With just one normal slot, the normal slot version would always be zero, 
> and there'd be no need to increment etc., which might make the common 
> case (no conflict) faster.

The multi-slots allows preemption while holding the slot. It also allows
HP slots users to keep it longer without doing to refcount right away.

I even have a patch that dynamically adapts the scan depth (increase
by reader, decrease by synchronize, with an hysteresis) in my userspace
prototype. This splits the number of allocated slots from the scan
depth. But I keep that for later and will focus on the simple case
first (single HP slot, only used with irqoff).

> 
> Either way I recommend stress testing with just one normal slot to 
> increase the chance of conflict (and hence triggering corner cases) 
> during stress testing.

Good point.

> 
>> +retry:
>> +    node = uatomic_load(node_p, CMM_RELAXED);
>> +    if (!node)
>> +        return false;
>> +    /* Use rseq to try setting current slot hp. Store B. */
>> +    if (rseq_load_cbne_store__ptr(RSEQ_MO_RELAXED, RSEQ_PERCPU_CPU_ID,
>> +                (intptr_t *) &slot->node, (intptr_t) NULL,
>> +                (intptr_t) node, cpu)) {
>> +        slot = &cpu_slots->slots[HPREF_EMERGENCY_SLOT];
>> +        use_refcount = true;
>> +        /*
>> +         * This may busy-wait for another reader using the
>> +         * emergency slot to transition to refcount.
>> +         */
>> +        caa_cpu_relax();
>> +        goto retry;
>> +    }
> 
> I'm not familiar with Linux' preemption model. Can this deadlock if a 
> low-interrupt-level thread is occupying the EMERGENCY slot and a 
> higher-interrupt-level thread is also trying to take it?

This is a userspace prototype. This will behave similarly to a userspace
spinlock in that case, which is not great in terms of CPU usage, but
should eventually unblock the waiter, unless it has a RT priority that
really prevents any progress from the emergency slot owner.

On my TODO list, I have a bullet about integrating with sys_futex to
block on wait, wake up on slot release. I would then use the wait/wakeup
code based on sys_futex already present in liburcu.

Thanks!

Mathieu


> 
> 
> 
> 
> Best wishes,
>    jonas
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

