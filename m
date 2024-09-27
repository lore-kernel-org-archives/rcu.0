Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4013D889;
	Fri, 27 Sep 2024 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434870; cv=none; b=esbLC/P4tHQn5C0ni/pS5BWg74itNiTsGd8IAHdA5sVGpFEBn25xAR8x5bQa+a0UJxTMzVrz7iytRetVWsYDUVI9E1MYGhMnFtGjFzzZMMS8FPkdbwJaMhc0URQXL0WQgjF58oNp6yvrp8y5Vyl02MnFQIr0CU0RQDzIJnpuSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434870; c=relaxed/simple;
	bh=w+koXmB7BOFclIQM2otysNtBd+8qkrsHPTo5gWSR9w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvCQ8Sy5usDxqFf8XrAG1tgCOGnpniIgrRO01x67r6qUnHJgSfZKj2+Y6HWvOoWmjHlNNWin6WR05Z0gGNTtw5n7w6TXmAWPw8ncTd4l844z6QCg6h0B5m9ta8AnS+q8OZXElk7Y6hGIQewOMAEG+exVgEblv/W8aQUlOrRpEIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=P9OowQtc; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="P9OowQtc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727434866;
	bh=w+koXmB7BOFclIQM2otysNtBd+8qkrsHPTo5gWSR9w0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P9OowQtcg/QxmmMSafMStk7GwzfeXc0VlR4KwNBDSBeU9FcEPgC+OORMGH0KNgxEI
	 80IVtAE4VvFyERUYPQwMwDGyQVqa4diNUZ3iTTWC9iUvIUG7HlTMng5UvPsNcLm3vx
	 LWTaYRGt1Wq95ppZ3Syp3hzgWHbjTWLAm7k+vlz5FvAWwPmAzoBETI8LbX9UtizMgz
	 aSMVNjXoHUWD5HTyBeGYAR/aEC3ZZCrXwtkqCUTQKik2gWlLwmysnSB3XAgcmwAsVb
	 Od+NdeO+Gu9NBati/W1zCdsLNvNBB9B1NLaKQc7oH/FXFlk0vJ6K0OtrHMcmS+hAgP
	 Arw3Innm1ID9g==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XFSFG1pQRz1MqK;
	Fri, 27 Sep 2024 07:01:06 -0400 (EDT)
Message-ID: <8aceaf4f-5578-4fca-8be7-3448d7b89721@efficios.com>
Date: Fri, 27 Sep 2024 12:59:33 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
To: Boqun Feng <boqun.feng@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>, Vlastimil Babka
 <vbabka@suse.cz>, maged.michael@gmail.com,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>
References: <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com>
 <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux>
 <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com>
 <ZvY0gG2dCJApPbp5@boqun-archlinux>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ZvY0gG2dCJApPbp5@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-27 06:28, Boqun Feng wrote:
> On Fri, Sep 27, 2024 at 09:37:50AM +0800, Boqun Feng wrote:
>>
>>
>> On Fri, Sep 27, 2024, at 9:30 AM, Mathieu Desnoyers wrote:
>>> On 2024-09-27 02:01, Boqun Feng wrote:
>>>> 	#define ADDRESS_EQ(var, expr)							\
>>>> 	({										\
>>>> 		bool _____cmp_res = (unsigned long)(var) == (unsigned long)(expr);	\
>>>> 											\
>>>> 		OPTIMIZER_HIDE_VAR(var);						\
>>>> 		_____cmp_res;								\
>>>> 	})
>>>
>>> If the goal is to ensure gcc uses the register populated by the
>>> second, I'm afraid it does not work. AFAIU, "hiding" the dependency
>>> chain does not prevent the SSA GVN optimization from combining the
> 
> Note it's not hiding the dependency, rather the equality,
> 
>>> registers as being one and choosing one arbitrary source. "hiding"
> 
> after OPTIMIZER_HIDE_VAR(var), compiler doesn't know whether 'var' is
> equal to 'expr' anymore, because OPTIMIZER_HIDE_VAR(var) uses "=r"(var)
> to indicate the output is overwritten. So when 'var' is referred later,
> compiler cannot use the register for a 'expr' value or any other
> register that has the same value, because 'var' may have a different
> value from the compiler's POV.
> 
>>> the dependency chain before or after the comparison won't help here.
>>>
>>> int fct_hide_var_compare(void)
>>> {
>>>       int *a, *b;
>>>
>>>       do {
>>>           a = READ_ONCE(p);
>>>           asm volatile ("" : : : "memory");
>>>           b = READ_ONCE(p);
>>>       } while (!ADDRESS_EQ(a, b));
>>
>> Note that ADDRESS_EQ() only hide first parameter, so this should be ADDRESS_EQ(b, a).
>>
> 
> I replaced ADDRESS_EQ(a, b) with ADDRESS_EQ(b, a), and the compile
> result shows it can prevent the issue:

I see, yes. It prevents the issue by making the compiler create
a copy of the value "modified" by the asm before doing the equality
comparison.

This means the compiler cannot derive the value for b from the first
load when b is used after after the equality comparison.

The only downside of OPTIMIZER_HIDE_VAR() is that it adds an extra
"mov" instruction to move the content across registers. I don't think
it matters performance wise though, so that solution is appealing
because it is arch-agnostic.

One small improvement over your proposed solution would be to apply
OPTIMIZER_HIDE_VAR() on both inputs. Because this is not a volatile
asm, it is simply optimized away if var1 or var2 is unused following
the equality comparison. It is more convenient to prevent replacement
of both addresses being compared by the other rather than providing
the guarantee only on a single parameter:

#define OPTIMIZER_HIDE_VAR(var)			\
         __asm__ ("" : "+r" (var))

#define ADDRESS_EQ(var1, var2)			\
({						\
	bool _____cmp_res = (var1) == (var2);	\
						\
	OPTIMIZER_HIDE_VAR(var1);		\
	OPTIMIZER_HIDE_VAR(var2);		\
	_____cmp_res;				\
})

Thanks,

Mathieu

> 
> gcc 14.2 x86-64:
> 
> fct_hide_var_compare:
> .L2:
>          mov     rcx, QWORD PTR p[rip]
>          mov     rdx, QWORD PTR p[rip]
>          mov     rax, rdx
>          cmp     rcx, rdx
>          jne     .L2
>          mov     eax, DWORD PTR [rax]
>          ret
> 
> gcc 14.2.0 ARM64:
> 
> fct_hide_var_compare:
>          adrp    x2, p
>          add     x2, x2, :lo12:p
> .L2:
>          ldr     x3, [x2]
>          ldr     x1, [x2]
>          mov     x0, x1
>          cmp     x3, x1
>          bne     .L2
>          ldr     w0, [x0]
>          ret
> 
> Link to godbolt:
> 
> 	https://godbolt.org/z/a7jsfzjxY-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

