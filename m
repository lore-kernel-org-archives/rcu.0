Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A61AE852;
	Wed, 25 Sep 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265599; cv=none; b=G+VYzuma0atCxLhiOCNe9Mzs+a9mSNKZktzhxzv0vQPLIEswBH4j+pFIqJwIAQ1pOlD0Vl8fdTFUFaAPzCziWWJEbqTIcB8wGsvjfKWoxBxGnOTwGcZbw9yX/z2JPfUWVFvFmnIizx/Y5n2QIlWwuXsMMzlUFkH3r6dyRONyytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265599; c=relaxed/simple;
	bh=W7bIXX4Xs7iiomVoHGKvUg62JxTlQSuNM0jVYBKFCDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5ZYqKTQKHuzQ/D1E0VhU+SttNkUAnt5oyNdVnowqtWJDnQRzNBhKT9n1+3MW4uV9MSt0OB3ia1w35FEYlbL5uPnvuVlCCffZP1kWipBbg5bFkmA/3RpOjAS9tOMRhEomKo4+5Fc7nx8/1x7kNKIXmRGbHwKDEUBEfxE2Bh3ljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rlH3JZhc; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rlH3JZhc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727265597;
	bh=W7bIXX4Xs7iiomVoHGKvUg62JxTlQSuNM0jVYBKFCDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rlH3JZhcD0hlsfIxRSykteKfS6UP3flhZBIz8ovXjkbvQLJd+/79GkBaccpm5Fj2K
	 FNuQRXMZWCvYk/pch6SL1JjRWEL41u8xgsaFaTUNEfUVx3VFzY/WHMs9uNHnCn2IOC
	 mdmu7H83iP/OQYf+vQgD+VFtqo0GnaloIgd6RkjSCu07mPbU3mMsTNFCop69HDAGIf
	 lK3iWa4juqjRlwR5+5VI2g+gk6Y3eAO8kZjP8rA68im2ODFtxgSSnGEpbf1c+CNY5Q
	 FRAzb6JGfxHV5zpjz2I71YvCyrqt8vZxufganosyz82TgmUFiHRKqnNcuMAZn/d0nR
	 hYqYFGRm/Qlog==
Received: from [192.168.126.112] (unknown [147.75.204.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XDFdt4nT3z1M9F;
	Wed, 25 Sep 2024 07:59:46 -0400 (EDT)
Message-ID: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
Date: Wed, 25 Sep 2024 13:59:06 +0200
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
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
 <55975a55-302f-4c45-bfcc-192a8a1242e9@huaweicloud.com>
 <ZvPfmAp_2mDkI3ss@boqun-archlinux>
 <f5aeeeda-c725-422a-9481-4795bd3ade0f@huaweicloud.com>
 <ZvPp4taB9uu__oSQ@boqun-archlinux>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ZvPp4taB9uu__oSQ@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-25 12:45, Boqun Feng wrote:
> On Wed, Sep 25, 2024 at 12:11:52PM +0200, Jonas Oberhauser wrote:
>>
>>
>> Am 9/25/2024 um 12:02 PM schrieb Boqun Feng:
>>> Hi Jonas,
>>>
>>> Of
>>> course, if we are really worried about compilers being too "smart"
>>
>> Ah, I see you know me better and better...
>>
>>> we can always do the comparison in asm code, then compilers don't know
>>> anything of the equality between 'ptr' and 'head - head_offset'.
>> Yes, but then a simple compiler barrier between the comparison and returning
>> ptr would also do the trick, right? And maybe easier on the eyes.
>>
> 
> The thing about putting a compiler barrier is that it will prevent all
> compiler reorderings, and some of the reordering may contribute to
> better codegen. (I know in this case, we have a smp_mb(), but still
> compilers can move unrelated code upto the second load for optimization
> purpose). Asm comparison is cheaper in this way. But TBH, compilers
> should provide a way to compare pointer values without using the result
> for pointer equality proof, if "convert to unsigned long" doesn't work,
> some other ways should work.
> 

Based on Documentation/RCU/rcu_dereference.rst :

-       Be very careful about comparing pointers obtained from
         rcu_dereference() against non-NULL values.  As Linus Torvalds
         explained, if the two pointers are equal, the compiler could
         substitute the pointer you are comparing against for the pointer
         obtained from rcu_dereference().  For example::

                 p = rcu_dereference(gp);
                 if (p == &default_struct)
                         do_default(p->a);

         Because the compiler now knows that the value of "p" is exactly
         the address of the variable "default_struct", it is free to
         transform this code into the following::

                 p = rcu_dereference(gp);
                 if (p == &default_struct)
                         do_default(default_struct.a);

         On ARM and Power hardware, the load from "default_struct.a"
         can now be speculated, such that it might happen before the
         rcu_dereference().  This could result in bugs due to misordering.

So I am not only concerned about compiler proofs here, as it appears
that the speculation done by the CPU can also cause issues on some
architectures.

Thanks,

Mathieu

> Regards,
> Boqun
> 
>>
>> Have fun,
>>     jonas
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

