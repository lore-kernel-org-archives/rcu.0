Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3C7DA6F;
	Mon, 30 Sep 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689363; cv=none; b=EBe6wCXi4ehUrfH0vMhQaZE5UJo6z680shDo7JxolI1kmv/o9pYagW0W1nymTUCbiuW7NiRCNkSlnh314igMiGkkttgz5ZGzUmRRxDswo5EqH3m0l1GxC3CbMP/qpbjP2X6m59+VtHhXyCgIoIXdjaYWtXCNzljDbRf3SZ0k95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689363; c=relaxed/simple;
	bh=9W8nIrUOmbOmuENo8g1JQ4uOsruDintbvPRye4u2hD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqFuzUixXxBQEPd7Pt1KMEraV+0LO7c9k5KSOyZcuMRwT6XfTa1VcEHBCioN/HHeDsfuKPrwmZW3bR2fjQD7TXpwInMn0iGB6kHp9pRTCsxGsb54kBcB9/4nqKibyB9tNJhBJEYNsHc4VVv/Lug+ILTmbF7jmKbU9myMF5P7o4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XHFwS1sKyz9v7JC;
	Mon, 30 Sep 2024 17:22:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 86280140590;
	Mon, 30 Sep 2024 17:42:28 +0800 (CST)
Received: from [10.81.211.60] (unknown [10.81.211.60])
	by APP2 (Coremail) with SMTP id GxC2BwAn18d1cvpmZwzxAQ--.6356S2;
	Mon, 30 Sep 2024 10:42:27 +0100 (CET)
Message-ID: <f635f9ce-fef4-4a9e-bee1-70dbc24a82ad@huaweicloud.com>
Date: Mon, 30 Sep 2024 11:42:11 +0200
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
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
 <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
 <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
 <25344f33-b8dc-43fb-a394-529eff03d979@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <25344f33-b8dc-43fb-a394-529eff03d979@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAn18d1cvpmZwzxAQ--.6356S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1DKr13GFyxZrykXw43ZFb_yoW8Jw47pr
	ZrKF4qkF4vyFWYvFW7Zw48Ca4jyw1ktFyFkrykKr47uryFqFyfuF42yr15ZFy5Ar1xX34Y
	yrWFq3W2gasxJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xU4R6zUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 9/28/2024 um 11:15 PM schrieb Alan Stern:
> On Sat, Sep 28, 2024 at 11:55:22AM -0400, Mathieu Desnoyers wrote:
>> On 2024-09-28 17:49, Alan Stern wrote:
>>> Isn't it true that on strongly ordered CPUs, a compiler barrier is
>>> sufficient to prevent the rcu_dereference() problem?  So the whole idea
>>> behind ptr_eq() is that it prevents the problem on all CPUs.
>>
>> Correct. But given that we have ptr_eq(), it's good to show how it
>> equally prevents the compiler from reordering address-dependent loads
>> (comparison with constant) *and* prevents the compiler from using
>> one pointer rather than the other (comparison between two non-constant
>> pointers) which affects speculation on weakly-ordered CPUs.
> 
> I don't see how these two things differ from each other.  In the
> comparison-with-a-constant case, how is the compiler reordering
> anything?  Isn't it just using the constant address rather than the
> loaded pointer and thereby breaking the address dependency?

I also currently don't see any major difference between the constant and 
register case. The point is that the address is known before loading 
into b, and hence the compiler + hardware can speculatively load *b 
before loading into b.

The only difference is how far before loading into b the address is known.

Best wishes,
   jonas

