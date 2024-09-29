Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B83C00;
	Sun, 29 Sep 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727606303; cv=none; b=kVyjV+TYULcA/jLr478tunHLBqBhnFBYiiYAs2dYfx4EwY/PJFMUvqx9VvRbYvFJHwJM9r6MCjpBnUTVUwx7oDHXww3s0I0yReXoBSssMb//J5DD/Zo0L0m+bOypS+RzNQSUly1O2cpyGTnGeX1igSYbDpCi+2yPBQtW4QpRzbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727606303; c=relaxed/simple;
	bh=SgF4pgZTLOl0dKajqPfd5secSNAVBGqHN0Padipl/bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSDov5mj6D42xDi3lNwhG/J9Iohb3YBXkcmoXXX5hledluRi8UnkmKliKkbq5n44gMsKSMXkjXMp8t1OVsfssPtdlRW6GLa1RXGpe6kGnsUgSeXD9zccGhouA8Qs61U6WOgsKFSB81S/WztJbe9Vg5csCWeq93W1tu58dp9at64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=X5bJR1wU; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="X5bJR1wU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727606299;
	bh=SgF4pgZTLOl0dKajqPfd5secSNAVBGqHN0Padipl/bE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X5bJR1wU6nTuItl/6Bx8LS4ISjasrXYFGCAnO+trklYufxKHm7oTuKBrSCiTPYEAG
	 gjSz09XT8eaXAyT2kK6N7N/BZG2q8QqxnGw4XAXjWGQnJprTBiVSKQWKjenDdAGbxW
	 Np5WPSNuPzQbfBzq3ltpWRxceuCCSr21XfRQC1jMEUpEp1SivzVOPLuPnK7r4asxds
	 JNuvoIPtwIGTp/pXiyfIawItlMWUU6twY/ZFjs+IYUZ/sV+5MloofWsGzrEOhMAyDj
	 cNc0SxdFqoI/7s7cZo5zm/VIH8DReE+8tgn41bHSaISGhp9Hc8BD3Yx0hEjqjP0c0j
	 fIin0/arVPmMw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XGgf31s3Dz65S;
	Sun, 29 Sep 2024 06:38:19 -0400 (EDT)
Message-ID: <229ac2ba-dd5b-4735-af93-8ef8efb6fa02@efficios.com>
Date: Sun, 29 Sep 2024 06:36:16 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
To: Gary Guo <gary@garyguo.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
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
 linux-mm@kvack.org, lkmm@lists.linux.dev, github@npopov.com,
 llvm@lists.linux.dev
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <20240929002428.38f37f54.gary@garyguo.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240929002428.38f37f54.gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-29 01:24, Gary Guo wrote:
> Cc: Nikita Popov <github@npopov.com>
> Cc: llvm@lists.linux.dev
> 
> On Sat, 28 Sep 2024 09:51:27 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Compiler CSE and SSA GVN optimizations can cause the address dependency
>> of addresses returned by rcu_dereference to be lost when comparing those
>> pointers with either constants or previously loaded pointers.
>>
>> Introduce ptr_eq() to compare two addresses while preserving the address
>> dependencies for later use of the address. It should be used when
>> comparing an address returned by rcu_dereference().
>>
>> This is needed to prevent the compiler CSE and SSA GVN optimizations
>> from replacing the registers holding @a or @b based on their
>> equality, which does not preserve address dependencies and allows the
>> following misordering speculations:
>>
>> - If @b is a constant, the compiler can issue the loads which depend
>>    on @a before loading @a.
>> - If @b is a register populated by a prior load, weakly-ordered
>>    CPUs can speculate loads which depend on @a before loading @a.
>>
>> The same logic applies with @a and @b swapped.
>>
>> The compiler barrier() is ineffective at fixing this issue.
>> It does not prevent the compiler CSE from losing the address dependency:
>>
>> int fct_2_volatile_barriers(void)
>> {
>>      int *a, *b;
>>
>>      do {
>>          a = READ_ONCE(p);
>>          asm volatile ("" : : : "memory");
>>          b = READ_ONCE(p);
>>      } while (a != b);
>>      asm volatile ("" : : : "memory");  <----- barrier()
>>      return *b;
>> }
>>
>> With gcc 14.2 (arm64):
>>
>> fct_2_volatile_barriers:
>>          adrp    x0, .LANCHOR0
>>          add     x0, x0, :lo12:.LANCHOR0
>> .L2:
>>          ldr     x1, [x0]    <------ x1 populated by first load.
>>          ldr     x2, [x0]
>>          cmp     x1, x2
>>          bne     .L2
>>          ldr     w0, [x1]    <------ x1 is used for access which should depend on b.
>>          ret
>>
>> On weakly-ordered architectures, this lets CPU speculation use the
>> result from the first load to speculate "ldr w0, [x1]" before
>> "ldr x2, [x0]".
>> Based on the RCU documentation, the control dependency does not prevent
>> the CPU from speculating loads.
> 
> I recall seeing Nikita Popov (nikic) doing work related to this to LLVM
> so it respects pointer provenances much better and doesn't randomly
> replace pointers with others if they compare equal. So I tried to
> reproduce this example on clang, which seems to generate the correct
> code, loading from *b instead of *a.
> 
> The generated code with "ptr_eq" however produces one extra move
> instruction which is not necessary.
> 
> I digged into the LLVM source code to see if this behaviour is that we
> can rely on, and found that the GVN in use is very careful with
> replacing pointers [1].
> 
> Essentially:
> * null can be replaced
> * constant addresses can be replaced <-- bad for this use case
> * pointers originate from the same value (getUnderlyingObject).
> 
> So it appears to me that if we can ensure that neither a or b come
> from a constant address then the OPTIMIZER_HIDE_VAR might be
> unnecessary for clang? This should be testable with __builtin_constant_p.
> 
> Not necessary worth additional complexity handling clang specially, but
> I think this is GCC/clang difference is worth pointing out.

Thanks for the thorough analysis of the clang GVN behavior. It confirms
my observations.

AFAIU, your proposal is to add a clang-specific #ifdef to eliminate one
mov from register to register (and thus free one register) when ptr_eq()
is used.

I'm not sure the gain (removing this extra mov) is worth it if what we
lose is robustness.

This would make the code dependent on current clang GVN optimization
design choices which are really specific to the compiler implementation
rather than guaranteed by the C standard. How can we be sure it won't
subtly break with a future clang version ?

If we think about it purely from a compiler optimization perspective,
using the content of the earliest loaded register allows weakly-ordered
CPUs to speculate following loads sooner. It's only when address
dependencies are needed (e.g. RCU) that this is unwanted. Am I missing
other cases where it is preferable to preserve address dependencies ?

Thanks,

Mathieu

> 
> I cc'ed nikic and clang-built-linux mailing list, please correct me if
> I'm wrong.
> 
> [1]: https://github.com/llvm/llvm-project/blob/6558e5615ae9e6af6168b0a363808854fd66663f/llvm/lib/Analysis/Loads.cpp#L777-L788
> 
> Best,
> Gary
> 
>>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>> Acked-by: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: John Stultz <jstultz@google.com>
>> Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
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
>> Cc: Gary Guo <gary@garyguo.net>
>> Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
>> Cc: rcu@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: lkmm@lists.linux.dev
>> ---
>>   include/linux/compiler.h | 62 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index 2df665fa2964..f26705c267e8 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -186,6 +186,68 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>>   	__asm__ ("" : "=r" (var) : "0" (var))
>>   #endif
>>   
>> +/*
>> + * Compare two addresses while preserving the address dependencies for
>> + * later use of the address. It should be used when comparing an address
>> + * returned by rcu_dereference().
>> + *
>> + * This is needed to prevent the compiler CSE and SSA GVN optimizations
>> + * from replacing the registers holding @a or @b based on their
>> + * equality, which does not preserve address dependencies and allows the
>> + * following misordering speculations:
>> + *
>> + * - If @b is a constant, the compiler can issue the loads which depend
>> + *   on @a before loading @a.
>> + * - If @b is a register populated by a prior load, weakly-ordered
>> + *   CPUs can speculate loads which depend on @a before loading @a.
>> + *
>> + * The same logic applies with @a and @b swapped.
>> + *
>> + * Return value: true if pointers are equal, false otherwise.
>> + *
>> + * The compiler barrier() is ineffective at fixing this issue. It does
>> + * not prevent the compiler CSE from losing the address dependency:
>> + *
>> + * int fct_2_volatile_barriers(void)
>> + * {
>> + *     int *a, *b;
>> + *
>> + *     do {
>> + *         a = READ_ONCE(p);
>> + *         asm volatile ("" : : : "memory");
>> + *         b = READ_ONCE(p);
>> + *     } while (a != b);
>> + *     asm volatile ("" : : : "memory");  <-- barrier()
>> + *     return *b;
>> + * }
>> + *
>> + * With gcc 14.2 (arm64):
>> + *
>> + * fct_2_volatile_barriers:
>> + *         adrp    x0, .LANCHOR0
>> + *         add     x0, x0, :lo12:.LANCHOR0
>> + * .L2:
>> + *         ldr     x1, [x0]  <-- x1 populated by first load.
>> + *         ldr     x2, [x0]
>> + *         cmp     x1, x2
>> + *         bne     .L2
>> + *         ldr     w0, [x1]  <-- x1 is used for access which should depend on b.
>> + *         ret
>> + *
> 
>> + * On weakly-ordered architectures, this lets CPU speculation use the
>> + * result from the first load to speculate "ldr w0, [x1]" before
>> + * "ldr x2, [x0]".
>> + * Based on the RCU documentation, the control dependency does not
>> + * prevent the CPU from speculating loads.
>> + */
>> +static __always_inline
>> +int ptr_eq(const volatile void *a, const volatile void *b)
>> +{
>> +	OPTIMIZER_HIDE_VAR(a);
>> +	OPTIMIZER_HIDE_VAR(b);
>> +	return a == b;
>> +}
>> +
>>   #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>>   
>>   /**
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

