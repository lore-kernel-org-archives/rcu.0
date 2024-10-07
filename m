Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A87A1DA26;
	Mon,  7 Oct 2024 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312853; cv=none; b=hOocJ4yOlq7FSY3lSpQkZt75kJzBpvPAe/43cg+0nOw97Iv9llgo3Q01pShneylo/fdmhqzONDVWErFlowqsXDI65aK/9SzSnoy3iA3CtXdgYu3Yf7HhtWKNoy+WJz5CxdsUjVeehJKlGc271D4swWurfoRIQqO3zNtckmp1tR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312853; c=relaxed/simple;
	bh=sihbyG/v8McdrExFlMF4l5W4opSu7i5ut7iK0mpnEh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ek3Z9MxGOur2utUXPR7uYCeHQPZP1cdvPezlFyD6VmsPfLWVEXN1VzHT4lQ7/cDu3l6SCCImHn4CjjfOIsY+Z4d2jwICaQHiVMoxtovrulCOYT8OxyimfER5oBznZdOIsRf6LcHEHoSqUKdszfMW/mbwlGSB6vowkj9d8MdWwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VVbZsMaT; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VVbZsMaT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728312850;
	bh=sihbyG/v8McdrExFlMF4l5W4opSu7i5ut7iK0mpnEh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VVbZsMaTm+kJ+mJ61HRGRpZ1hTwl6/ALHHgD0lC47SzwRONtiKJDP/owbxPIJ+I1t
	 GYhhI0in/OnM8yY6y+4C4JufX3rNF6tnmGUFxS34BeyhyE4zscpqNdh/LogWI9pG70
	 j7L26qV3xBABIsUZOHvjrGFRO/NKwbYhUdT9Bg8wzlnGYm4eq7ZMhreaqgZ1t9JqhX
	 E6ucijPLbq5BlRs+yPP4gInxeIHHwJgDBxfmhI4Kk346JdqkkhEI72IFYXlFwpZ3eZ
	 e9hEEOIF9AqQSTpznimryYAmopYOU4GA1EUTF/ZNC0QBOGBsCgbfUz45hQ6ici00a3
	 dnk+p+fdadBCQ==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XMhxZ2Smtz3DX;
	Mon,  7 Oct 2024 10:54:10 -0400 (EDT)
Message-ID: <cd41b389-6374-4f84-996c-0fe778962a47@efficios.com>
Date: Mon, 7 Oct 2024 10:52:12 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] hp: Implement Hazard Pointers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
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
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
 <20241002010205.1341915-4-mathieu.desnoyers@efficios.com>
 <Zv3kP477pGeOxuu9@boqun-archlinux>
 <bb890ea6-742f-40b7-ad3d-aa28f658fa3d@efficios.com>
 <ZwPmc_CXW15ilRaK@boqun-archlinux>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ZwPmc_CXW15ilRaK@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-07 15:47, Boqun Feng wrote:
> On Thu, Oct 03, 2024 at 09:30:53AM -0400, Mathieu Desnoyers wrote:
> [...]
>>>> +	/*
>>>> +	 * Use RCU dereference without lockdep checks, because
>>>> +	 * lockdep is not aware of HP guarantees.
>>>> +	 */
>>>> +	addr2 = rcu_access_pointer(*addr_p);	/* Load A */
>>>
>>> Why rcu_access_pointer() instead of READ_ONCE()? Because you want to
>>> mark the head of address dependency?
>>
>> Yes, the intent here is to mark the address dependency and provide
>> a publication guarantee similar to RCU pairing rcu_assign_pointer
>> and rcu_dereference. Do you see any reason why READ_ONCE() would
>> suffice here ?
> 
> READ_ONCE() also provides address dependencies. See the "DEPENDENCY
> RELATIONS: data, addr, and ctrl" section in
> tools/memory-model/Documentation/explanantion.txt.

Fair point, so let's use READ_ONCE() then.

Thanks,

Mathieu

> 
> Regards,
> Boqun
> 
>>
>> Thanks,
>>
>> Mathieu
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

