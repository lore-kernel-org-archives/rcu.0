Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947BA1D0B87;
	Wed,  2 Oct 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883494; cv=none; b=p+vlQYx+1FlQGe38r0MImsojQeRmM7RwXqhEHxfeJROzVrQS5qk0cyRkhmcsZQwSzxIV14Ij91wN5dLioxo1i1uJ8ozibGtbZWvgwI0LAjHjVUR5REHqnayOG4MOGj2o+8APSG9U0ABbuVMBq3t0kERnHPUQRpPgkS4Qz5NB9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883494; c=relaxed/simple;
	bh=YXyDxH8qGnLuB6XlPuK2t9QnxxGXsE8JJbeqjNsJmkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfQYw/uOqw5iFTfEYs3L253G4sFfRilHSaAu5GRit8vCLYD2aSvC0fej7/wjzrYt/EDnjmRwSbD2I/bpTZ9GGmoOFvzKcEEYSVk4Mnet1fOn6AbIoXOUJFgANwkG702MEFh4QNJci2jajy5T+Ni4xh0GKQXASIAiuGssmU4etZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=j3jJyrWH; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="j3jJyrWH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727883491;
	bh=YXyDxH8qGnLuB6XlPuK2t9QnxxGXsE8JJbeqjNsJmkk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j3jJyrWHZaV9YyyPVgDQs/U1mSWZ76BACDf7YJ6ew9JfPiS0CYdQG1MQKfa0CIK2b
	 qcQWuZjL4YbTa2u4Z36XGOjm5QS+hqu4688uS1o9Z5333FlXK4oDvXp9K9O2hxm3ve
	 M9mQnDaAsqb4rRVFTErfSamVTkUIXWoN6G/ss7Ahm27gsBDpFJrOibWFV76TKj4XYF
	 J+wTK7uoO3ks+3iWeUtHcwkFrMQ7Q9FyuumIx3oetN56/Ieihv/w5A2W1XOKqxn5Bd
	 G5qWrJZw/DplkiCuTWB7WjJp+Hfz6Qr2gVIQbXzGJzX9bDaWjQ7QxMg7nThjtE0Hna
	 3OiCCZyzww4xg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XJf8g0YLfzrSw;
	Wed,  2 Oct 2024 11:38:11 -0400 (EDT)
Message-ID: <d788c6aa-c8b9-41b8-b4fb-ac126a4f053f@efficios.com>
Date: Wed, 2 Oct 2024 11:36:09 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] sched+mm: Track lazy active mm existence with
 hazard pointers
To: Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: paulmck@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
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
 <cfcf9c05-c639-4757-a3ac-6504d154cdfe@paulmck-laptop>
 <d412fa7e-6348-4e51-89e8-4c740184cb2f@efficios.com>
 <Zv1n0VeM3ZSVPyyE@casper.infradead.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <Zv1n0VeM3ZSVPyyE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-02 17:33, Matthew Wilcox wrote:
> On Wed, Oct 02, 2024 at 11:26:27AM -0400, Mathieu Desnoyers wrote:
>> On 2024-10-02 16:09, Paul E. McKenney wrote:
>>> On Tue, Oct 01, 2024 at 09:02:01PM -0400, Mathieu Desnoyers wrote:
>>>> Hazard pointers appear to be a good fit for replacing refcount based lazy
>>>> active mm tracking.
>>>>
>>>> Highlight:
>>>>
>>>> will-it-scale context_switch1_threads
>>>>
>>>> nr threads (-t)     speedup
>>>>       24                +3%
>>>>       48               +12%
>>>>       96               +21%
>>>>      192               +28%
>>>
>>> Impressive!!!
>>>
>>> I have to ask...  Any data for smaller numbers of CPUs?
>>
>> Sure, but they are far less exciting ;-)
> 
> How many CPUs in the system under test?

2 sockets, 96-core per socket:

CPU(s):                   384
   On-line CPU(s) list:    0-383
Vendor ID:                AuthenticAMD
   Model name:             AMD EPYC 9654 96-Core Processor
     CPU family:           25
     Model:                17
     Thread(s) per core:   2
     Core(s) per socket:   96
     Socket(s):            2
     Stepping:             1
     Frequency boost:      enabled
     CPU(s) scaling MHz:   68%
     CPU max MHz:          3709.0000
     CPU min MHz:          400.0000
     BogoMIPS:             4800.00

Note that Jens Axboe got even more impressive speedups testing this
on his 512-hw-thread EPYC [1] (390% speedup for 192 threads). I've
noticed I had schedstats and sched debug enabled in my config, so I'll 
have to re-run my tests.

Thanks,

Mathieu

[1] https://discuss.systems/@axboe@fosstodon.org/113238297041686326

> 
>> nr threads (-t)     speedup
>>       1                -0.2%
>>       2                +0.4%
>>       3                +0.2%
>>       6                +0.6%
>>      12                +0.8%
>>      24                +3%
>>      48               +12%
>>      96               +21%
>>     192               +28%
>>     384                +4%
>>     768                -0.6%
>>
>> Thanks,
>>
>> Mathieu
>>
>>>
>>> 							Thanx, Paul
>>>
>>>> I'm curious to see what the build bots have to say about this.
>>>>
>>>> This series applies on top of v6.11.1.
>>>>
>>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>>> Cc: Alan Stern <stern@rowland.harvard.edu>
>>>> Cc: John Stultz <jstultz@google.com>
>>>> Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>>> Cc: Frederic Weisbecker <frederic@kernel.org>
>>>> Cc: Joel Fernandes <joel@joelfernandes.org>
>>>> Cc: Josh Triplett <josh@joshtriplett.org>
>>>> Cc: Uladzislau Rezki <urezki@gmail.com>
>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>>>> Cc: Zqiang <qiang.zhang1211@gmail.com>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Waiman Long <longman@redhat.com>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>>> Cc: maged.michael@gmail.com
>>>> Cc: Mateusz Guzik <mjguzik@gmail.com>
>>>> Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
>>>> Cc: rcu@vger.kernel.org
>>>> Cc: linux-mm@kvack.org
>>>> Cc: lkmm@lists.linux.dev
>>>>
>>>> Mathieu Desnoyers (4):
>>>>     compiler.h: Introduce ptr_eq() to preserve address dependency
>>>>     Documentation: RCU: Refer to ptr_eq()
>>>>     hp: Implement Hazard Pointers
>>>>     sched+mm: Use hazard pointers to track lazy active mm existence
>>>>
>>>>    Documentation/RCU/rcu_dereference.rst |  38 ++++++-
>>>>    Documentation/mm/active_mm.rst        |   9 +-
>>>>    arch/Kconfig                          |  32 ------
>>>>    arch/powerpc/Kconfig                  |   1 -
>>>>    arch/powerpc/mm/book3s64/radix_tlb.c  |  23 +---
>>>>    include/linux/compiler.h              |  63 +++++++++++
>>>>    include/linux/hp.h                    | 154 ++++++++++++++++++++++++++
>>>>    include/linux/mm_types.h              |   3 -
>>>>    include/linux/sched/mm.h              |  71 +++++-------
>>>>    kernel/Makefile                       |   2 +-
>>>>    kernel/exit.c                         |   4 +-
>>>>    kernel/fork.c                         |  47 ++------
>>>>    kernel/hp.c                           |  46 ++++++++
>>>>    kernel/sched/sched.h                  |   8 +-
>>>>    lib/Kconfig.debug                     |  10 --
>>>>    15 files changed, 346 insertions(+), 165 deletions(-)
>>>>    create mode 100644 include/linux/hp.h
>>>>    create mode 100644 kernel/hp.c
>>>>
>>>> -- 
>>>> 2.39.2
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

