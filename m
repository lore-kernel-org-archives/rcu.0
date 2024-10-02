Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0851D0BBC;
	Wed,  2 Oct 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885053; cv=none; b=azW7xNB3zorBc4OwoK6ln/nRE2qbTI2XqkbfKtag29ucUkg5HIDMT1uf3l/R3u6hwVNC2fiXrhXwgD4VP6ecxcNWW79//TyXQ3PBpqXXjFTrCWJB4NOwHtwUjduAALk6R0Y3nwXzfoPGYSOySblLBB7ulOSqIp7zD+f1crG8zsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885053; c=relaxed/simple;
	bh=6wCd0ATWAk93Kx57rpnE5VXXFxLzQSM30u/zKePBA54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1G/Unx8WsqUSyDCaiiY9sxGVmYoWpPLGzm61crbufjga+Bop96cFulMbPqtBrQmg6Ylz3y2dG+xd825bARPkcS3sJenjnTa2i3hAaTwwrpFvdX75cds9G625ddtTeFQCzV9IMwQo5BnRnmKLjtAOvWMVDF90guxldo6qKk7d8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=CF4TT7KN; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CF4TT7KN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727885051;
	bh=6wCd0ATWAk93Kx57rpnE5VXXFxLzQSM30u/zKePBA54=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CF4TT7KN2aoCAboqXU5D8MWNSeePl8xG/MHqpYyQ212rBgmpTpFjfD5r4BRQNq0RS
	 gVATUx01l7XqL2gCevSVNpFjfRsPN6ENFq/dD400shDwgrP+/K8/XEyzvBxW3UILWf
	 CZ8mKzFpD7+Xs6byUdcmhHlgq5NBUbfBwx+9EfeIo814UG+HSpGGj6Uf1ddzHVrOBz
	 5G6h/54iLgpS9VKr1aS01C/fvTrrc/qEYyoVCcbFLxY9J69Vh3E66T/1/Rr7VYrL4K
	 MaSrzEKbQk2Hgp2MsyNYe5jhHSvGi0co3XllN0VStegfheeIgvDeHFsfMiRf22Jdw0
	 xf0Gl4X0FOevA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XJfkf5Sz2zrZ0;
	Wed,  2 Oct 2024 12:04:10 -0400 (EDT)
Message-ID: <f2b6f19e-0dea-4568-b3b0-832cfc950160@efficios.com>
Date: Wed, 2 Oct 2024 12:02:09 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] sched+mm: Track lazy active mm existence with
 hazard pointers
To: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>
Cc: paulmck@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
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
 <cfcf9c05-c639-4757-a3ac-6504d154cdfe@paulmck-laptop>
 <d412fa7e-6348-4e51-89e8-4c740184cb2f@efficios.com>
 <Zv1n0VeM3ZSVPyyE@casper.infradead.org>
 <d788c6aa-c8b9-41b8-b4fb-ac126a4f053f@efficios.com>
 <8a627fc7-cc62-40e6-ad28-c730d4a8f7d6@efficios.com>
 <579bdbbf-82a7-4330-9a5e-495d89befbac@kernel.dk>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <579bdbbf-82a7-4330-9a5e-495d89befbac@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-02 17:58, Jens Axboe wrote:
> On 10/2/24 9:53 AM, Mathieu Desnoyers wrote:
>> On 2024-10-02 17:36, Mathieu Desnoyers wrote:
>>> On 2024-10-02 17:33, Matthew Wilcox wrote:
>>>> On Wed, Oct 02, 2024 at 11:26:27AM -0400, Mathieu Desnoyers wrote:
>>>>> On 2024-10-02 16:09, Paul E. McKenney wrote:
>>>>>> On Tue, Oct 01, 2024 at 09:02:01PM -0400, Mathieu Desnoyers wrote:
>>>>>>> Hazard pointers appear to be a good fit for replacing refcount based lazy
>>>>>>> active mm tracking.
>>>>>>>
>>>>>>> Highlight:
>>>>>>>
>>>>>>> will-it-scale context_switch1_threads
>>>>>>>
>>>>>>> nr threads (-t)     speedup
>>>>>>>        24                +3%
>>>>>>>        48               +12%
>>>>>>>        96               +21%
>>>>>>>       192               +28%
>>>>>>
>>>>>> Impressive!!!
>>>>>>
>>>>>> I have to ask...  Any data for smaller numbers of CPUs?
>>>>>
>>>>> Sure, but they are far less exciting ;-)
>>>>
>>>> How many CPUs in the system under test?
>>>
>>> 2 sockets, 96-core per socket:
>>>
>>> CPU(s):                   384
>>>     On-line CPU(s) list:    0-383
>>> Vendor ID:                AuthenticAMD
>>>     Model name:             AMD EPYC 9654 96-Core Processor
>>>       CPU family:           25
>>>       Model:                17
>>>       Thread(s) per core:   2
>>>       Core(s) per socket:   96
>>>       Socket(s):            2
>>>       Stepping:             1
>>>       Frequency boost:      enabled
>>>       CPU(s) scaling MHz:   68%
>>>       CPU max MHz:          3709.0000
>>>       CPU min MHz:          400.0000
>>>       BogoMIPS:             4800.00
>>>
>>> Note that Jens Axboe got even more impressive speedups testing this
>>> on his 512-hw-thread EPYC [1] (390% speedup for 192 threads). I've
>>> noticed I had schedstats and sched debug enabled in my config, so I'll have to re-run my tests.
>>
>> A quick re-run of the 128-thread case with schedstats and sched debug
>> disabled still show around 26% speedup, similar to my prior numbers.
>>
>> I'm not sure why Jens has much better speedups on a similar system.
>>
>> I'm attaching my config in case someone spots anything obvious. Note
>> that my BIOS is configured to show 24 NUMA nodes to the kernel (one
>> NUMA node per core complex).
> 
> Here's my .config - note it's from the stock kernel run, which is why it
> still has:
> 
> CONFIG_MMU_LAZY_TLB_REFCOUNT=y
> 
> set. Have the same numa configuration as you, just end up with 32 nodes
> on this box.

Just to make sure: did you use other command line options when starting
the test program (other than -t N ?).

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

