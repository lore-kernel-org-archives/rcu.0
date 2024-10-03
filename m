Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED616E886;
	Thu,  3 Oct 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965270; cv=none; b=li9oe0+wyVjns/s4x/zXp1PdoiIHgovnnIA9yl+NRDJhdaj3KoOizF5bQISuMsSAnHpNjZ7+iFU9O2h6lDmb1K3UMh56D+kvmKGJPxBvtxgTZRTlhrbCVhTwF6WOSgfNvK/zRhaSK61+jnuYGdzx809fwWJIwZ8b7qfG7Q7NJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965270; c=relaxed/simple;
	bh=CGnfdcDnXLM248wKeLz3YsGWDhDT7TOOh166t7wY+uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=io3teJ99fs+UgxqsY1vp8GDU1ZiINqbAq1K7vjww980MijbOhp7MpZ3/CXyhwhK9TOZ9w2xzbYMMGSan3hyipxgx8khpK9qKgaZWnQLvJyglm5ZMcEoGkERTZpBQ5C9Sovr9MUkXkdjPBHbt4IX9WVkP1M19et4yuV5db3/I1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=xJ9KALNM; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="xJ9KALNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727965267;
	bh=CGnfdcDnXLM248wKeLz3YsGWDhDT7TOOh166t7wY+uo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xJ9KALNMcGMevAx9+lNF070s7mlbSEA8awVfo6Hp8UCXB5siihboA9Gs8PO2FWHHZ
	 ZlTSfIhSFTF5LJQmt6rFYnxWRN0bFcQ0tzRaZDyTDJB/IPd6UtGTAeRVxTqABsTK0m
	 z4NAE/29P3ULxX+aVZ2VszPnlmSw8/Rxdd9ffCiYYaNUOrsbwee3OHPJ6jQlFSzwVu
	 64ohJZdZlaxw0ZjfAumQ+tHk6IEV1C3qp1WAKhCCM2esv81+yLDQ7fU8FU0lCIq9Ec
	 W4FIQ2l2Qx99GsrfvJgBpRY+FmhJyt/PE2C5zjW+KQBfUP0wCD1UjFm+hMYjXLjdCB
	 kVHlHVUz6q5Vg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKDPG3wvwz59p;
	Thu,  3 Oct 2024 10:21:06 -0400 (EDT)
Message-ID: <7cc83ffc-c9cc-4e87-a3ee-bb62588a594c@efficios.com>
Date: Thu, 3 Oct 2024 10:19:05 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] compiler.h: Introduce ptr_eq() to preserve
 address dependency
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Alan Stern <stern@rowland.harvard.edu>,
 John Stultz <jstultz@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org,
 linux-mm@kvack.org, lkmm@lists.linux.dev, Gary Guo <gary@garyguo.net>,
 Nikita Popov <github@npopov.com>, llvm@lists.linux.dev
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
 <20241002010205.1341915-2-mathieu.desnoyers@efficios.com>
 <20241003000843.GA192403@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241003000843.GA192403@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-03 02:08, Joel Fernandes wrote:
> On Tue, Oct 01, 2024 at 09:02:02PM -0400, Mathieu Desnoyers wrote:
>> Compiler CSE and SSA GVN optimizations can cause the address dependency
>> of addresses returned by rcu_dereference to be lost when comparing those
>> pointers with either constants or previously loaded pointers.
>>
>> Introduce ptr_eq() to compare two addresses while preserving the address
>> dependencies for later use of the address. It should be used when
>> comparing an address returned by rcu_dereference().
>>
>> This is needed to prevent the compiler CSE and SSA GVN optimizations
>> from using @a (or @b) in places where the source refers to @b (or @a)
>> based on the fact that after the comparison, the two are known to be
>> equal, which does not preserve address dependencies and allows the
>> following misordering speculations:
>>
>> - If @b is a constant, the compiler can issue the loads which depend
>>    on @a before loading @a.
>> - If @b is a register populated by a prior load, weakly-ordered
>>    CPUs can speculate loads which depend on @a before loading @a.
>>
>> The same logic applies with @a and @b swapped.
>>
> [...]
>> +/*
>> + * Compare two addresses while preserving the address dependencies for
>> + * later use of the address. It should be used when comparing an address
>> + * returned by rcu_dereference().
>> + *
>> + * This is needed to prevent the compiler CSE and SSA GVN optimizations
>> + * from using @a (or @b) in places where the source refers to @b (or @a)
>> + * based on the fact that after the comparison, the two are known to be
>> + * equal, which does not preserve address dependencies and allows the
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
> I could reproduce this in compiler explorer, but I'm curious what flags are
> you using? For me it does a bunch of usage of the stack for temporary storage
> (still incorrectly returns *a though as you pointed).

You are probably missing "-O2".


> 
> Interestingly, if I just move the comparison into an an __always_inline__
> function like below, but without the optimizer hide stuff, gcc 14.2 on arm64
> does generate the correct code:

Make sure you compile in -O2. Based on a quick check here the hide var
is needed to make sure the compiler does the intended behavior in O2.

> 
> static inline __attribute__((__always_inline__)) int ptr_eq(const volatile void *a, const volatile void *b)
> {
>      /* No OPTIMIZER_HIDE_VAR */
>      return a == b;
> }
> 
> volatile int *p = 0;
> 
> int fct_2_volatile_barriers()
> {
>      int *a, *b;
> 
>      do {
>          a = READ_ONCE(p);
>          asm volatile ("" : : : "memory");
>          b = READ_ONCE(p);
>      } while (!ptr_eq(a, b));
>      asm volatile ("" : : : "memory");  // barrier()
>      return *b;
> }
> 
> But not sure if it fixes the speculation issue you referred to.

Not in -O2.

> 
> Putting back the OPTIMIZER_HIDE_VAR() then just seems to pass the a and b
> stored on the stack through a washing machine:
> 
>          ldr     x0, [sp, 8]
>          str     x0, [sp, 8]
>          ldr     x0, [sp]
>          str     x0, [sp]

That washing machine looks like the result of -O0.

> 
> And here I thought the "" in OPTIMIZER_HIDE_VAR was not supposed to generate
> any code but I guess it is still a NOOP.

The hide var will only emit an extra register movement to copy the
register to a temporary. That's one extra instruction but not as bad
as what you observe in -O0.

> 
> Anyway, as such this LGTM since whether OPTIMIZER_HIDE_VAR() used or not, it
> does fix the problem.

hide var is needed in O2.

> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Please double-check with -O2, and let me know if you still agree with
the patch :)

Thanks,

Mathieu


> 
> thanks,
> 
>   - Joel
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

