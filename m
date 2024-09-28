Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3418030;
	Sat, 28 Sep 2024 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727539048; cv=none; b=ajl8WZv5U4sFgMIL2ExAK6vwXoIT4cVX853qJutTShhqFiDWbw7++JXgFCeVD2cAJDIbXGaLGrqnPuFN37zvXt3dpLkq9wZOpoirCCMbdCBinrTj16/tAva38l/ss0Nkh1sm9Vcp0nwnmFl/LAqWtTi41jdzV9eGweIOvJnNZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727539048; c=relaxed/simple;
	bh=OT5+a5qZ1o8omlaCZ7kGSp45uaSP88DQUWgurlZRS/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3ORAYraQJjIDP30FFIF6Bl1TY7zSPCjI21YRTVYVEwhUbXrtVVWQehrf/AKQ+Ijeg8574yMRjSNWs/H2uY4sKxcfiSqxNky5s64Cy+sSQLAo4ZWGrBelkduY5FyzP8e3lam1sy2Q/oVY5V9xKw+mkUWjase6/er2JaW6Gs6Lz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=FvoaUoVC; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FvoaUoVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727539045;
	bh=OT5+a5qZ1o8omlaCZ7kGSp45uaSP88DQUWgurlZRS/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FvoaUoVCkk1vlFwGKRn1BPSxesgO2ojACv9ZacAleSmS6TGVCqaZ/OfDlT1chVCAS
	 HDGh65+0A0LCmXPkguJXDQXtB9Cos7jWdqq/QE1HYCVHOqYrJerKBsQzC+JKphGByf
	 82dhG6UawKRMs+Xitf2UKZGQEn676aHJuo87ix9Edj2EVTTQD38F4VnqH86NF9/2mG
	 2Ff8V3pD9kpPIFI6MG/yytZ75PH/ZPCLXProkF32hqn+XNuSbAk37I+vwypQ7z+IUz
	 ljxDZ9Efm3tCoGa2fuLhiPLt3S70NJM3TZUjosE1XilIFYcs0rlw3StbWdIb2MVC6k
	 XFx3z5WbkG/Aw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XGBmj27MNz1ccf;
	Sat, 28 Sep 2024 11:57:25 -0400 (EDT)
Message-ID: <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
Date: Sat, 28 Sep 2024 11:55:22 -0400
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
 <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
 <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-28 17:49, Alan Stern wrote:
> On Sat, Sep 28, 2024 at 11:32:18AM -0400, Mathieu Desnoyers wrote:
>> On 2024-09-28 16:49, Alan Stern wrote:
>>> On Sat, Sep 28, 2024 at 09:51:27AM -0400, Mathieu Desnoyers wrote:
>>>> equality, which does not preserve address dependencies and allows the
>>>> following misordering speculations:
>>>>
>>>> - If @b is a constant, the compiler can issue the loads which depend
>>>>     on @a before loading @a.
>>>> - If @b is a register populated by a prior load, weakly-ordered
>>>>     CPUs can speculate loads which depend on @a before loading @a.
>>>
>>> It shouldn't matter whether @a and @b are constants, registers, or
>>> anything else.  All that matters is that the compiler uses the wrong
>>> one, which allows weakly ordered CPUs to speculate loads you wouldn't
>>> expect it to, based on the source code alone.
>>
>> I only partially agree here.
>>
>> On weakly-ordered architectures, indeed we don't care whether the
>> issue is caused by the compiler reordering the code (constant)
>> or the CPU speculating the load (registers).
>>
>> However, on strongly-ordered architectures, AFAIU, only the constant
>> case is problematic (compiler reordering the dependent load), because
> 
> I thought you were trying to prevent the compiler from using one pointer
> instead of the other, not trying to prevent it from reordering anything.
> Isn't this the point the documentation wants to get across when it says
> that comparing pointers can be dangerous?

The motivation for introducing ptr_eq() is indeed because the
compiler barrier is not sufficient to prevent the compiler from
using one pointer instead of the other.

But it turns out that ptr_eq() is also a good tool to prevent the
compiler from reordering loads in case where the comparison is
done against a constant.

> 
>> CPU speculating the loads across the control dependency is not an
>> issue.
>>
>> So am I tempted to keep examples that clearly state whether
>> the issue is caused by compiler reordering instructions, or by
>> CPU speculation.
> 
> Isn't it true that on strongly ordered CPUs, a compiler barrier is
> sufficient to prevent the rcu_dereference() problem?  So the whole idea
> behind ptr_eq() is that it prevents the problem on all CPUs.

Correct. But given that we have ptr_eq(), it's good to show how it
equally prevents the compiler from reordering address-dependent loads
(comparison with constant) *and* prevents the compiler from using
one pointer rather than the other (comparison between two non-constant
pointers) which affects speculation on weakly-ordered CPUs.

> You can make your examples as specific as you like, but the fact remains
> that ptr_eq() is meant to prevent situations where both:
> 
> 	The compiler uses the wrong pointer for a load, and
> 
> 	The CPU performs the load earlier than you want.
> 
> If either one of those doesn't hold then the problem won't arise.

Correct.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

