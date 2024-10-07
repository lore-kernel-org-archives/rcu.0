Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499EA1D4146;
	Mon,  7 Oct 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307493; cv=none; b=VIFuo8Kixex4g5no+7ZojB32Tabf4LWw0dpne3RfskAGyHyZE6KxanqXLD+rqelL9EVJHhIuJ+wSq9/KFaVm2C3lZyZCLu6aYYrGfBHOAMNogOng5Ae1EXH4lz4qyGE4QbiFxm8f1nJKVhIaAcsxuOrPBRivL+S7SwrVmN0MOOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307493; c=relaxed/simple;
	bh=89Gasxm3AKnvBRytdU61zHDIonC6RjkNEXr4NpQ4woI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNEEgsrnxBf5p6IAjt84glI0+W5VQ8t6HNzkYabGOMg1drX39H7tKOrEawvqKDKn9rm0f0EPvXWoHiqh7dRd1jUBGzJo8CgA3NIDEZIPX1Pl9y7uvsDwkh2ni5rvuyYYr2DVfZyGG2P/Av45B3GInnAWXFLKHs1qrlQ5c0hKF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=E4Y4UnxL; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="E4Y4UnxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728307491;
	bh=89Gasxm3AKnvBRytdU61zHDIonC6RjkNEXr4NpQ4woI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E4Y4UnxLXftMgVjVchGlQ4dyZB24l3kfZeQVkEBpb/fNniUr2TSRYKkj6XXT8XH7A
	 VMSAsAYcV5RxldzGzjwF1ck/6pVo16iS7Wnu0DuHID6gnYU2RI3CxCjWuTXQY5s9dr
	 F6P6UbxL7fIF+1KJp9rXFcAYktrYRDQbT1wbJdGDpjnFnGKPg1XUEEO6BiwRiNCVk6
	 gvEqE1hZOJ+VByvzGHnPTncAUnw2Cf3IGcLy5lRXQcdgpJOTBtiFbJEHaXLMgeal0F
	 RHoay27oMFkmzhTo748OUwCsXAhoRjw7ACGQPPAgLvN3clX6AmLedoB4CdjA+ooVeN
	 qZGkbPyn4onbQ==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XMfyV0wW3z2kv;
	Mon,  7 Oct 2024 09:24:50 -0400 (EDT)
Message-ID: <812121c6-734d-4f68-b808-d3fa7c380604@efficios.com>
Date: Mon, 7 Oct 2024 09:22:52 -0400
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
 <6e7812f7-c94a-46ba-ba4d-cf4b7b1f60c9@efficios.com>
 <20241007104244.GC4879@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241007104244.GC4879@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-07 12:42, Peter Zijlstra wrote:
> On Sat, Oct 05, 2024 at 02:56:26PM -0400, Mathieu Desnoyers wrote:
>> On 2024-10-05 18:07, Peter Zijlstra wrote:
>>> On Sat, Oct 05, 2024 at 06:04:44PM +0200, Peter Zijlstra wrote:
>>>> On Fri, Oct 04, 2024 at 02:27:33PM -0400, Mathieu Desnoyers wrote:
>>>
>>>>> +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
>>>>> +	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr))
>>>>> +{
>>>>> +	int cpu;
>>>>> +
>>>>> +	/*
>>>>> +	 * Store A precedes hp_scan(): it unpublishes addr (sets it to
>>>>> +	 * NULL or to a different value), and thus hides it from hazard
>>>>> +	 * pointer readers.
>>>>> +	 */
>>>
>>> This should probably assert we're in a preemptible context. Otherwise
>>> people will start using this in non-preemptible context and then we get
>>> to unfuck things later.
>>
>> Something like this ?
>>
>> +       /* Should only be called from preemptible context. */
>> +       WARN_ON_ONCE(in_atomic());
> 
> 	lockdep_assert_preemption_enabled();
> 
> that also checks local IRQ state IIRC.

I'll use this instead, thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

