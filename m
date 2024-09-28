Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2581DA23;
	Sat, 28 Sep 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536294; cv=none; b=aMCMU6VvByNnMYssQ/8ve/HwLq/RtiBkd8wytWw7OXhsf5fmmsyXFy2M+zkejuhLTrvr1GLe3paZxBKLiW4PmyyhVbMCe/aLyhF86H3yND67K8qGUDjzm6cR5MqGUUm2D/FI36MPhEF3dJnBd1g79adqSDFL9h85xtzHaA13CGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536294; c=relaxed/simple;
	bh=7EhSBLm++teZ5B5B8sOr60qGu3XijdnlCICI3JnBOpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+Re3DOfJLywYSxr9ikW/XkC7fhLHUHAvb4HMquFNM2ULoyzCNaN3JG9TtWXNoMeyRU9Vm46b4dKUgV4zsQZKyswZ1TyQxQqm88Z6NbFMT7WvMIf+g2WBIaDOKdBfJy7ZvERmbU4gv13MV9bPfvf2juUoaZaY6CSfpEwraNfytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HVqpFPE8; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HVqpFPE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727536290;
	bh=7EhSBLm++teZ5B5B8sOr60qGu3XijdnlCICI3JnBOpQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HVqpFPE8Pinekdiy/+zU2/vzbzTXwomNYxRYwhXSq1i53GanPxwXz6r3jFOsaTN5k
	 tmeDwPUFbPAxEqHiPyVmEjqLzu5vJMaGtgbBwLy0+AaNi4ybiKoqZurZLV19gwYJzi
	 t86UNHeI9Er0fOSEmi635AEsN1FC47JQ0MT4mUo7G4ECvYuZSBvaKxRpG9QMeLbSA/
	 7LjnjGG5c4eM4YwSuFFyNHrk3vvVhdMmNJI/4n+5rsQVoOCT2YdDodArAYBrQnN60Q
	 UPjvqWanIFErdZ5Wc4hKDZEP5aB7OZ7YIGhBvXAc5MqXPWOZaEdVi/PosAnJy1Tdk9
	 eZe9Yuzs8QAzw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XG9lk3gfqz1c9q;
	Sat, 28 Sep 2024 11:11:30 -0400 (EDT)
Message-ID: <a22aa208-19c8-46fa-99aa-10f6ed32d484@efficios.com>
Date: Sat, 28 Sep 2024 11:09:27 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: RCU: Refer to ptr_eq()
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
 <20240928135128.991110-3-mathieu.desnoyers@efficios.com>
 <7b50a773-9d5b-4ff4-8de2-b491f3b91f52@rowland.harvard.edu>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <7b50a773-9d5b-4ff4-8de2-b491f3b91f52@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-28 16:58, Alan Stern wrote:
> On Sat, Sep 28, 2024 at 09:51:28AM -0400, Mathieu Desnoyers wrote:
[...]
>> --	Be very careful about comparing pointers obtained from
>> -	rcu_dereference() against non-NULL values.  As Linus Torvalds
>> -	explained, if the two pointers are equal, the compiler could
>> -	substitute the pointer you are comparing against for the pointer
>> -	obtained from rcu_dereference().  For example::
>> +-	Use relational operators which preserve address dependencies
>> +	(such as "ptr_eq()") to compare pointers obtained from
> 
> Nit: ptr_eq() is an inline function, not a relational operator.  Say
> "operations that" instead of "relational operators which".
> 
>> +	rcu_dereference() against non-NULL values or against pointers

Note: here I need to update the wording as well:

+-      Use operations that preserve address dependencies (such as
+       "ptr_eq()") to compare pointers obtained from rcu_dereference()
+       against non-NULL pointers. As Linus Torvalds explained, if the
+       two pointers are equal, the compiler could substitute the
+       pointer you are comparing against for the pointer obtained from
+       rcu_dereference().  For example::


>> +	obtained from prior loads. As Linus Torvalds explained, if the
>> +	two pointers are equal, the compiler could substitute the
>> +	pointer you are comparing against for the pointer obtained from
>> +	rcu_dereference().  For example::
>>   
>>   		p = rcu_dereference(gp);
>>   		if (p == &default_struct)
>> @@ -125,6 +127,23 @@ readers working properly:
>>   	On ARM and Power hardware, the load from "default_struct.a"
>>   	can now be speculated, such that it might happen before the
>>   	rcu_dereference().  This could result in bugs due to misordering.
>> +	Performing the comparison with "ptr_eq()" ensures the compiler
>> +	does not perform such transformation.
>> +
>> +	If the comparison is against a pointer obtained from prior
>> +	loads, the compiler is allowed to use either register for the
> 
> This is true even when the comparison is against a pointer obtained from
> a later load.  Just say "another pointer" instead of "a pointer obtained
> from prior loads".  (And why would someone need multiple loads to
> obtain a single pointer?)
> 
> Also, say "pointer" instead of "register".

OK.

> 
>> +	following accesses, which loses the address dependency and
>> +	allows weakly-ordered architectures such as ARM and PowerPC
>> +	to speculate the address-dependent load before rcu_dereference().
>> +	For example::
>> +
>> +		p1 = READ_ONCE(gp);
>> +		p2 = rcu_dereference(gp);
>> +		if (p1 == p2)
>> +			do_default(p2->a);
> 
> Here you should say that the compiler could use p1->a rather than p2->a,
> destroying the address dependency.  That's the whole point of this; you
> shouldn't skip over it.

OK.

> 
>> +
>> +	Performing the comparison with "ptr_eq()" ensures the compiler
>> +	preserves the address dependencies.
>>   
>>   	However, comparisons are OK in the following cases:
>>   
>> @@ -204,6 +223,11 @@ readers working properly:
>>   		comparison will provide exactly the information that the
>>   		compiler needs to deduce the value of the pointer.
>>   
>> +	When in doubt, use relational operators that preserve address
> 
> Again, "operations" instead of "relational operators".

OK. Will fix in my next round.

Thanks,

Mathieu

> 
> Alan Stern
> 
>> +	dependencies (such as "ptr_eq()") to compare pointers obtained
>> +	from rcu_dereference() against non-NULL values or against
>> +	pointers obtained from prior loads.
>> +
>>   -	Disable any value-speculation optimizations that your compiler
>>   	might provide, especially if you are making use of feedback-based
>>   	optimizations that take data collected from prior runs.  Such
>> -- 
>> 2.39.2
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

