Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1EC1D094D;
	Wed,  2 Oct 2024 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882913; cv=none; b=uJfWB7QR2fua1q/ZZbRwmZJU1A/To0l7YlOZTg0XBbxBuZTT5/Tj5KDDHxCQjGZau4NNir2T/+K1lhiORn5LfCyC33XliJzBuHF1BMPLAq7KA8UtcS+RZD22L4aJrQalNgiqO+ejKUsvL4oNwyOmapRQyHgXtpR5GFpPSfp2RBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882913; c=relaxed/simple;
	bh=m6x6cBfk9F17zG/g86DW4bf8U8vx2DG18BjVP9nwpJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqzilN23FEpTHi0xSH9viUML47/S6YkMwDNyHFuIrilyN/5YMmHf+Mo9uOVAh6BcNmkFVil/o6cqk3j3ODJ1skbOPbcb3KSpsHzUHhpGZPn+2a1mdG/y4C7k3AfOBLtJhp0pivolKzzWOmoaLntRKcLMyty26c5mTyl3WgS0ENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mApOV1gP; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mApOV1gP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727882909;
	bh=m6x6cBfk9F17zG/g86DW4bf8U8vx2DG18BjVP9nwpJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mApOV1gPdSUXOkzxliDA+7pVLwWwrr6hHdRzQVoXiK/Reqdn4IoYuAV1Tc3SDUlbL
	 VIKh9rdKWepMeaE3O+94gDMX5xcWni0+ijd91beIKBDblop2j0z5nWRdgSNdob6+jq
	 yQ7xUsA0MFH61TkSNvc8jxrRZYZDxkAcesyvg6I3/1RerbTgihPN8K4+yXZ7pRFESH
	 vAuuppj4SGTQXhcWWUmarQ5Z6JZafgpWHCnTPyJgjjrNScvQ6CphyZkflkJzsdyI2L
	 GUbp6ouhjE3+6LK9kv39isVgh1CbxOh+Uuzm7h4WlXHNhRxcSnQuLlF634//J9bRGP
	 wUeYNBEIT6OKg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XJdxT09ctzqq6;
	Wed,  2 Oct 2024 11:28:29 -0400 (EDT)
Message-ID: <d412fa7e-6348-4e51-89e8-4c740184cb2f@efficios.com>
Date: Wed, 2 Oct 2024 11:26:27 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] sched+mm: Track lazy active mm existence with
 hazard pointers
To: paulmck@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <cfcf9c05-c639-4757-a3ac-6504d154cdfe@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-02 16:09, Paul E. McKenney wrote:
> On Tue, Oct 01, 2024 at 09:02:01PM -0400, Mathieu Desnoyers wrote:
>> Hazard pointers appear to be a good fit for replacing refcount based lazy
>> active mm tracking.
>>
>> Highlight:
>>
>> will-it-scale context_switch1_threads
>>
>> nr threads (-t)     speedup
>>      24                +3%
>>      48               +12%
>>      96               +21%
>>     192               +28%
> 
> Impressive!!!
> 
> I have to ask...  Any data for smaller numbers of CPUs?

Sure, but they are far less exciting ;-)

nr threads (-t)     speedup
      1                -0.2%
      2                +0.4%
      3                +0.2%
      6                +0.6%
     12                +0.8%
     24                +3%
     48               +12%
     96               +21%
    192               +28%
    384                +4%
    768                -0.6%

Thanks,

Mathieu

> 
> 							Thanx, Paul
> 
>> I'm curious to see what the build bots have to say about this.
>>
>> This series applies on top of v6.11.1.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: John Stultz <jstultz@google.com>
>> Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Cc: Joel Fernandes <joel@joelfernandes.org>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Uladzislau Rezki <urezki@gmail.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>> Cc: Zqiang <qiang.zhang1211@gmail.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Waiman Long <longman@redhat.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: maged.michael@gmail.com
>> Cc: Mateusz Guzik <mjguzik@gmail.com>
>> Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
>> Cc: rcu@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: lkmm@lists.linux.dev
>>
>> Mathieu Desnoyers (4):
>>    compiler.h: Introduce ptr_eq() to preserve address dependency
>>    Documentation: RCU: Refer to ptr_eq()
>>    hp: Implement Hazard Pointers
>>    sched+mm: Use hazard pointers to track lazy active mm existence
>>
>>   Documentation/RCU/rcu_dereference.rst |  38 ++++++-
>>   Documentation/mm/active_mm.rst        |   9 +-
>>   arch/Kconfig                          |  32 ------
>>   arch/powerpc/Kconfig                  |   1 -
>>   arch/powerpc/mm/book3s64/radix_tlb.c  |  23 +---
>>   include/linux/compiler.h              |  63 +++++++++++
>>   include/linux/hp.h                    | 154 ++++++++++++++++++++++++++
>>   include/linux/mm_types.h              |   3 -
>>   include/linux/sched/mm.h              |  71 +++++-------
>>   kernel/Makefile                       |   2 +-
>>   kernel/exit.c                         |   4 +-
>>   kernel/fork.c                         |  47 ++------
>>   kernel/hp.c                           |  46 ++++++++
>>   kernel/sched/sched.h                  |   8 +-
>>   lib/Kconfig.debug                     |  10 --
>>   15 files changed, 346 insertions(+), 165 deletions(-)
>>   create mode 100644 include/linux/hp.h
>>   create mode 100644 kernel/hp.c
>>
>> -- 
>> 2.39.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

