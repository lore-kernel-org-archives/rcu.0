Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2D158D92;
	Sat,  5 Oct 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728154709; cv=none; b=d6BYWFRO5GJN079xLMk/+i+KK97dXFbuegtTN454a7+24WVsebldc83CUOT3JwMQdEa6+ElULlNvItvLRri8bk8CfSw4cWYKaULNBWEX+d7jjPiODmmszEv3ThcJ7UQHs7gfXFRqXsCFiYauk/6tXdiX4BshAmtz2HTJghf6+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728154709; c=relaxed/simple;
	bh=RTn2mtKzGWwl0GvRq21Nk5QN+R7yvGZfcgevYW/1xHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kB9NsT4dlx9gQqtkz0L7+6LD1as1W792r3nh4+4e3r4peoqtN8LrepA+in88kwzYtts356mo8IOpBPwBPH3q+1qh2TGCBAAYmLINzuyRHXjPLDLtbY/TDomsWBWceGxAHdkOOluo5XR0P+bRwsQL8o7p1xgmooZ+Cf+HEZ+NNrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dzfRYRp+; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dzfRYRp+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728154707;
	bh=RTn2mtKzGWwl0GvRq21Nk5QN+R7yvGZfcgevYW/1xHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dzfRYRp+/g2Dkm44G64aHTJSYh539TMhvI+oYp/J6IF1LPgUNJ3Xf7X8w5mcpdD3m
	 Ict/VNtQSK18ojMPZS9L4Mmu3WHzRh4nUU17br23h/YXbF/jp3sWLpDhO6kg/cc0bt
	 cMGH9K2Eg+2/zQqT6MvZDVQwyEFagQ2yZftiz8WcQXLlyH6fvQ0PSsf4BSoqaUbcPU
	 pGXWb025Ooe7CbzxM71yA1WBtE2Vf2kFWh8ntiYAgrdYCGwW4ovpEKr9AlKjKchVIn
	 BNXl5XoM1h1GKFQLLVKaNMHEz/K+CB5zLYTin8TYRE1t8grztN21dYAMWsgbAZsAzY
	 CcKQNtTPavV1Q==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XLZSL59k7zbvL;
	Sat,  5 Oct 2024 14:58:26 -0400 (EDT)
Message-ID: <6e7812f7-c94a-46ba-ba4d-cf4b7b1f60c9@efficios.com>
Date: Sat, 5 Oct 2024 14:56:26 -0400
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
 <20241005160723.GI33184@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241005160723.GI33184@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-05 18:07, Peter Zijlstra wrote:
> On Sat, Oct 05, 2024 at 06:04:44PM +0200, Peter Zijlstra wrote:
>> On Fri, Oct 04, 2024 at 02:27:33PM -0400, Mathieu Desnoyers wrote:
> 
>>> +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
>>> +	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr))
>>> +{
>>> +	int cpu;
>>> +
>>> +	/*
>>> +	 * Store A precedes hp_scan(): it unpublishes addr (sets it to
>>> +	 * NULL or to a different value), and thus hides it from hazard
>>> +	 * pointer readers.
>>> +	 */
> 
> This should probably assert we're in a preemptible context. Otherwise
> people will start using this in non-preemptible context and then we get
> to unfuck things later.

Something like this ?

+       /* Should only be called from preemptible context. */
+       WARN_ON_ONCE(in_atomic());

> 
>>> +
>>> +	if (!addr)
>>> +		return;
>>> +	/* Memory ordering: Store A before Load B. */
>>> +	smp_mb();
>>> +	/* Scan all CPUs slots. */
>>> +	for_each_possible_cpu(cpu) {
>>> +		struct hp_slot *slot = per_cpu_ptr(percpu_slots, cpu);
>>> +
>>> +		if (retire_cb && smp_load_acquire(&slot->addr) == addr)	/* Load B */
>>> +			retire_cb(cpu, slot, addr);
>>
>> Is retirce_cb allowed to cmpxchg the thing?

Renaming retire_cb to "on_match_cb". Whatever the callback does needs to
be done with knowledge of the slot user (e.g. IPI).


>>
>>> +		/* Busy-wait if node is found. */
>>> +		while ((smp_load_acquire(&slot->addr)) == addr)	/* Load B */
>>> +			cpu_relax();
>>
>> This really should be using smp_cond_load_acquire()

Done,

Thanks,

Mathieu

>>
>>> +	}
>>> +}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

