Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586414830D;
	Sat,  5 Oct 2024 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728128645; cv=none; b=RgcqWgHgsQldQkhvyBAYrCDyAYYcp9jDd6uubvekgQGpnHit48udEvLLgtjn/RdNgxJN6N1jZ3vC73xOncCxb9NfBtaB02sKKUXeGkgQGAbTzAppv3i+1XCe+o8z0EliY6ycfPwUqsaY52N+iWdze/AdqpI8/YdqUujKgwUCqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728128645; c=relaxed/simple;
	bh=RiefWV/KnAglaCg6B6xncMJjyAlrwOW9ZGgZzmAcY6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZO3hAuXvNE5r8Z+4h2UFVB0eVty0YXDisRhAV0EjVv48bmc3DEvoP8xz5IVDnFYeqy1kurg3T+vuVIhvhRBidUBNvpuJdzigezwUSHAm2IkCyIaUSK3iwVxOR9Nm+lsmgpSmOT8CEHbj99UyGjrEarjeml0KdGS56vVWSJjHwVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lAp1iGgy; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lAp1iGgy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728128642;
	bh=RiefWV/KnAglaCg6B6xncMJjyAlrwOW9ZGgZzmAcY6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lAp1iGgyHY00422nQo2IXiANrNtcwoGGpu/Q/yTRhPo+ujfznQp6cl4HBq7AhsOpL
	 21ZQ8MdYARUwcdE7GNTczciAk7ANkmARtjNx7lA8Lr6mc7agBv4/6yCR0ZpzM010cC
	 Qb5qJNKeIphzrKLWqqrawY0fOmv9cmqhDnEWLihttea3Jv43/V3VRzc+wQAK+l92Sz
	 j4cglAbqVrCrBkm+CwIFz9nR/btJpFu+rWE/1Zo8x4BmdsEfR3UT8/njbuEAsuWEic
	 Ua05+k7AGFd/Ke4HceCjC93SLf1gn3cuy3i8uupiQ87dUA/JdQk7jpR5X3Kn4tlN/W
	 PUB04rqPtmiRQ==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XLNq60jHFzXmb;
	Sat,  5 Oct 2024 07:44:02 -0400 (EDT)
Message-ID: <bede6c18-45f9-419b-be18-aa167e42ca37@efficios.com>
Date: Sat, 5 Oct 2024 07:42:01 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/4] hp: Implement Hazard Pointers
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
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
 <ZwEgtU8MFPfGmEfA@pavilion.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ZwEgtU8MFPfGmEfA@pavilion.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-05 13:19, Frederic Weisbecker wrote:
> Le Fri, Oct 04, 2024 at 02:27:33PM -0400, Mathieu Desnoyers a écrit :
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
>> +		/* Busy-wait if node is found. */
>> +		while ((smp_load_acquire(&slot->addr)) == addr)	/* Load B */
>> +			cpu_relax();
> 
> You agree that having a single possible per-cpu pointer per context and a busy
> waiting update side pointer release can't be a general purpose hazard pointer
> implementation, right? :-)

Of course. This is a minimalist implementation, which can be extended in
various ways, some of which I've implemented as POC in userspace already:

- Increase the number of per-cpu slots available,
- Distinguish between current scan depth target and available
   per-cpu slots,
- Fall-back to reference counter when slots are full,
- Allow scanning for a range of addresses (useful for type-safe
   memory),
- Allow scanning for a set of hazard pointers (scan batching)
   using Bloom filters to probabilistically speed up the comparison
   (not implemented yet).
- Implement a queued blocking wait/wakeup when HP scan must wait
   (not implemented yet).
- Implement a HP-to-refcount promotion triggered by the HP scan
   callback to promote hazard pointers which would be blocked on
   to a reference count increment. (not implemented yet)
- Use hazard pointers + refcount to implement smart pointers, which
   could be useful for Rust. (not implemented yet)

But my general approach is to wait until the use-cases justify adding
features.

Although if you are curious about any of the points listed above,
just ask and I'll be happy to discuss them in more depth.

Thanks,

Mathieu

> 
> Thanks.
> 
>> +	}
>> +}
>> -- 
>> 2.39.2
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

