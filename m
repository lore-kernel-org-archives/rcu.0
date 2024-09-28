Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192A171A7;
	Sat, 28 Sep 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727537574; cv=none; b=JUfl6VnAOVhQSYpxPKYgVCJMocI7XvL60W/3fZZ/Wcr4tcf9mEG89+stzgPFEpUr1A11TqZT55/WesRQtr4iG7Lik3zGypl3m/9kamI8Yo+Y7eCWRBDXGX6NpC2xJqzRP1vQIscOdRx0XttI/+3YCdi697MoJRr9SlUtjuSMBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727537574; c=relaxed/simple;
	bh=qODK3D1TzkfHZd3mLIQ/9d2R+3FrtROj8weI9Fwm3Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obYcU0+yNG7170CRM5C6FxfHrP3SSH33BWcV2szNI2Jc95BTR5GhxnhWRbuKVQ3NfahVBBYj+uyp8bSoXBU+bpduMH6wrUFkra0eT6T+UtMXrjGocvjeXzWcj/1bkPYA6uqpqyI6wBFAcEC1Nzt1i/nYrCLVjDZFFGNsrpZkdcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ry2vMne4; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ry2vMne4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727537571;
	bh=qODK3D1TzkfHZd3mLIQ/9d2R+3FrtROj8weI9Fwm3Ks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ry2vMne4TQGJwkx0bJ2IjOP2Cb5Tgxr2ePDOIpQHTOkSk8osr3n0dAsiJmq14ORIL
	 ee2X1r783c167zydFF7NBhsAQKKYuu57tz66h7KzV8KpT/RJ4Dpc5cxrqeSTOuGIbU
	 T3hWymsEbvxEMk3v2+4B+ZG/xuhRZVxFUYvtAcMvO94HwJUK0FY2X+FzF8pstjXnfy
	 CuLFnhlCwaYMDVaP6idxJ1BKyoxfPBBrEXPqMWbnsUpxAxcGUT5eI1OUSM6RkI4NB+
	 5OmfD8g9Ni68aL5YfYbZzdwDYzkmVx2YpPb3+w1Lrdpx/xy+2uKuobYBHhlatblqEK
	 u1ijhgxJKB3Kg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XGBDM4sGZz1cc6;
	Sat, 28 Sep 2024 11:32:51 -0400 (EDT)
Message-ID: <2bb50d49-f1ce-4282-a03c-f52420c95dd1@efficios.com>
Date: Sat, 28 Sep 2024 11:30:48 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
To: Alan Stern <stern@rowland.harvard.edu>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
[...]
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
[...]
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
>> + * On weakly-ordered architectures, this lets CPU speculation use the
>> + * result from the first load to speculate "ldr w0, [x1]" before
>> + * "ldr x2, [x0]".
>> + * Based on the RCU documentation, the control dependency does not
>> + * prevent the CPU from speculating loads.
> 
> IMO, this lengthy explanation is not needed in the source code.  Just
> refer interested readers to the commit description.  You're repeating
> the same text verbatim, after all.
> 
> (Or if you firmly believe that this explanation _does_ belong in the
> code, then omit it from the commit description.  There's no need to say
> everything twice.)
> 

Linus asked for this code/asm example to be in the comment:

   https://lore.kernel.org/lkml/CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com/

I agree that it may be a bit verbose for the comment.

Linus, do you want the explanation wrt compiler barriers not being
enough (with C/asm example) in the comment above ptr_eq() or in
the commit message ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

