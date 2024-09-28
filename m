Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6F171A7;
	Sat, 28 Sep 2024 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727537664; cv=none; b=WekjFQmb7fuFXmrN0rJkqBhs54cUG8lYv/Mis9dnOJzgEwd424YEo1yGSxwUNVPvL41kXQd8XYQ8GQwQSa2HQCYxKePDvIYfj/X7Sb1zHCAntVaYuJhZYe3hM20ozwwTSk8TFvNCyfm6iMh3myYrZ/gZPaccZQPgffYMVmv+0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727537664; c=relaxed/simple;
	bh=NrUURg2qa5F4rEbHXvtVlrKaewXw7D0H1TL5+6bR/BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBuhn/+/dSWBQJn1N3k51L3prqQi2IMs2EvReypTRyTxoDTkXkrx1cP9WPpV+9DTZZ+677tdh0yF25IrjH67nWTlts91A9JO9QfNWqacPQu1oRX07pNgcE5EQNc7EATYCv/RShNlo3iXTcgXOBX+nePHt64z4a30ZiUXyAfUu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=NF/A0oUi; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NF/A0oUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727537661;
	bh=NrUURg2qa5F4rEbHXvtVlrKaewXw7D0H1TL5+6bR/BU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NF/A0oUi2fivzhVq8qk1HW0xQWMmESJB+bE8UZVx7MDYOXUurFEERhAxRmPdq3pbz
	 qbxLT/STRrsBJbc2g9m4IN6Mf9V2mbNbTELP/GL39LhGl2Nbp/82qvFO51ZfEsQzrZ
	 X1Ik/cURKydSKptIhnF/tXpVSTazDJxL6r2rbdNypCGizof3w8VoQ7YtFqf7zF+3of
	 sOYjkof8FBDRMFBEn54n4XRgcIvzMTFYK3CVMzsx4d9nLxx0+xkBiQRArCHOH5O4cq
	 9ykDHlawYDN7tiNYjefuumIXHAbBYbMWT/f5eYCvikR/M9IacdUARUCBP3ycR9rmra
	 ZbsL+jcCGiIQA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XGBG50P8Tz1cN3;
	Sat, 28 Sep 2024 11:34:21 -0400 (EDT)
Message-ID: <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
Date: Sat, 28 Sep 2024 11:32:18 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 John Stultz <jstultz@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org,
 linux-mm@kvack.org, lkmm@lists.linux.dev
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-28 16:49, Alan Stern wrote:
> On Sat, Sep 28, 2024 at 09:51:27AM -0400, Mathieu Desnoyers wrote:
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
> 
> "Replacing" isn't the right word.  What the compiler does is use one
> rather than the other.  Furthermore, the compiler can play these games
> even with values that aren't in registers.
> 
> You should just say: "... from using @a (or @b) in places where the
> source refers to @b (or @a) (based on the fact that after the
> comparison, the two are known to be equal), which does not ..."

OK.

> 
>> equality, which does not preserve address dependencies and allows the
>> following misordering speculations:
>>
>> - If @b is a constant, the compiler can issue the loads which depend
>>    on @a before loading @a.
>> - If @b is a register populated by a prior load, weakly-ordered
>>    CPUs can speculate loads which depend on @a before loading @a.
> 
> It shouldn't matter whether @a and @b are constants, registers, or
> anything else.  All that matters is that the compiler uses the wrong
> one, which allows weakly ordered CPUs to speculate loads you wouldn't
> expect it to, based on the source code alone.

I only partially agree here.

On weakly-ordered architectures, indeed we don't care whether the
issue is caused by the compiler reordering the code (constant)
or the CPU speculating the load (registers).

However, on strongly-ordered architectures, AFAIU, only the constant
case is problematic (compiler reordering the dependent load), because
CPU speculating the loads across the control dependency is not an
issue.

So am I tempted to keep examples that clearly state whether
the issue is caused by compiler reordering instructions, or by
CPU speculation.

> 
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
>>
[...]
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

Replacing with:

  * This is needed to prevent the compiler CSE and SSA GVN optimizations
  * from using @a (or @b) in places where the source refers to @b (or @a)
  * based on the fact that after the comparison, the two are known to be
  * equal, which does not preserve address dependencies and allows the
  * following misordering speculations:

>> + * following misordering speculations:
>> + *
>> + * - If @b is a constant, the compiler can issue the loads which depend
>> + *   on @a before loading @a.
>> + * - If @b is a register populated by a prior load, weakly-ordered
>> + *   CPUs can speculate loads which depend on @a before loading @a.
>> + *
>> + * The same logic applies with @a and @b swapped.
> 
> This could be more concise, and it should be more general (along the
> same lines as the description above).

As per my earlier comment, I would prefer to keep the examples specific
rather than general so it is clear which scenarios are problematic on
weakly vs strongly ordered architectures.

[...]

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

