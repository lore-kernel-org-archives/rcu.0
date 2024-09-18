Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB0139CF2;
	Wed, 18 Sep 2024 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648097; cv=none; b=aTlCDcqqU8eNwlSa3gm3jjwtbvf5UScz/P6ypoz+66zM+1JN0Qw3DIzmEx7OhjvVz8YGK2ltV9XnDwaJQs0JUngrJnKqkli1qKbrdQ6bKONl06DPAQ1Sj+u1b/U0q3EgC1us+KzGwVT3mLPhN+k/1hzYI7oxDN0B9fbnxtzHlHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648097; c=relaxed/simple;
	bh=gj+snmJa6J2gK8ly7gvfAw16z7opi86SetN3fVDwwUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4oypyOxkFhOKYM/FqK1IOtiMkVNCO6JzHyyxMBXhiwSZFp5p8e9o3vlNZ4SMXuaiEB+UD5HdpyvlmnqCGlcBMBUZjsO8XttpcfcR/roVPvc1xFo3hdnt8FPwIYaV2UKXnIss7MmKpiEfZRbvBXA9OFg3OITylzdqJlbcOH2qng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=nMmmJ7Bt; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nMmmJ7Bt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1726648093;
	bh=gj+snmJa6J2gK8ly7gvfAw16z7opi86SetN3fVDwwUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nMmmJ7BtqPmuSmMdtrDlyApSjl0y9HM3tLOIMDRPJJpkTD9cFcM7ZPkA3FxSzC0x/
	 Waf9avlGmiwTe1lKuKFEvPwKGE8d3XGvPHvP0Dk9oOLMDZQBs/UiEljpbgTFJ7THMg
	 d/7tja34AtLpEnc4nznn6qVNb/N3lgkLzJ/0qQKtu+3fgR5YPuLdQqif5soy31iHRI
	 Bj0+0mD5XCVYWpttdOiGQCdLKACDPqG/Q6nBwQS1PHfsqIabaXjc3//zQf0Bg87NHi
	 rEsG3OYuDSZH1iVa9e6CSqvCUWEVne1IgLR/zc6BEI8KdDO2RahuysAbYNvxhr/QY1
	 vPp1kk3Dx7bIw==
Received: from [10.134.0.250] (unknown [83.68.141.146])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X7sGh5m0Bz1LFT;
	Wed, 18 Sep 2024 04:27:56 -0400 (EDT)
Message-ID: <fb85f280-a5b1-487e-a8fa-5e97441991fb@efficios.com>
Date: Wed, 18 Sep 2024 10:27:01 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240917143402.930114-2-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-17 16:33, Boqun Feng wrote:
[...]
> 
> The synchronization between readers and updaters is built around "hazard
> pointer slots": a slot readers can use to store a pointer value.
> 
> Reader side protection:
> 
> 1.	Read the value of a pointer to the target data element.
> 2.	Store it to a hazard pointer slot.
> 3.	Enforce full ordering (e.g. smp_mb()).
> 4.	Re-read the original pointer, reset the slot and retry if the
> 	value changed.
> 5.	Otherwise, the continued existence of the target data element
> 	is guaranteed.
> 
> Updater side check:
> 
> 1.	Unpublish the target data element (e.g. setting the pointer
> 	value to NULL).
> 2.	Enforce full ordering.
> 3.	Read the value from a hazard pointer slot.
> 4.	If the value doesn't match the target data element, then this
> 	slot doesn't represent a reference to it.
> 5.	Otherwise, updater needs to re-check (step 3).

Cool! I look forward to see where this is meant to be used. I would
expect it to be a useful tool to speed up reference counting of
things like the mm_struct and for TLB flush IPIs.

On a related note, with a userspace port in mind, the membarrier(2)
syscall can be useful to turn the smp_mb() in (3) from the reader
side into a simple compiler barrier, assuming (2) from the updater
is using membarrier. If IPIs are acceptable (or already required) for
some kernel use-cases, this means a similar asymmetric fence scheme
could be used to speed up readers.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

