Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC2180A80;
	Mon, 30 Sep 2024 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686697; cv=none; b=DvudLOkSm1XA43EVDKWYYFjOfDIyY0jP0WP7kGNYqrZBwWt7SVvEqdhPsCQYXQbtDmUVYqP2CFlK8yxBYlJ2HWCpO/8AWoz7f5Ovt+iBRPsPiGonp+rygojWiOtwEWCRHrT6yKjJTxLURo/NxO4cMnJGNYJO4GwJcqS7Fw8z48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686697; c=relaxed/simple;
	bh=pK9BBmAz7pGForOQWbZmxWWr5mRMu1MTSBFFRLgbCTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsK9JJWno8MUdM1v59lKeBdr/ycX7Ai5bXJwZHimikEXIPhC6MR6F7ap/wU35c8G0UpqcOlw8RHT8ptBp4sAI8+Xi6fgdFZ1lE1KrdCt8Im76QD3DYV6B2PhVl99Obry/LeDg7CE7vtF443EeIxO/CVd9L2QXo18GhLtEbBNEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XHDpG46QJz9v7JV;
	Mon, 30 Sep 2024 16:32:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id D7AF8140519;
	Mon, 30 Sep 2024 16:57:56 +0800 (CST)
Received: from [10.81.211.60] (unknown [10.81.211.60])
	by APP2 (Coremail) with SMTP id GxC2BwCXRscEaPpmNIbwAQ--.5120S2;
	Mon, 30 Sep 2024 09:57:56 +0100 (CET)
Message-ID: <8d20cf79-9fa5-4ced-aa91-232ccd545b59@huaweicloud.com>
Date: Mon, 30 Sep 2024 10:57:37 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
To: Alan Huang <mmpgouride@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 John Stultz <jstultz@google.com>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
 RCU <rcu@vger.kernel.org>, linux-mm@kvack.org, lkmm@lists.linux.dev
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
 <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
 <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
 <D31AF4E7-B9D5-4D2F-A4B9-1E12B5E69549@gmail.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <D31AF4E7-B9D5-4D2F-A4B9-1E12B5E69549@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCXRscEaPpmNIbwAQ--.5120S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyrGr4xCFykJF4Duw45KFg_yoW5AF4DpF
	W7Ka17KF4kJF1akr90y348uFy5trn7tFyYv3Z5tr1xCws0gF1fZr43tFyYkasxCwn7t34j
	vr1Yv3sIvasxAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIF
	4iUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 9/29/2024 um 12:26 AM schrieb Alan Huang:
> 2024年9月28日 23:55，Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote：
>>
>> On 2024-09-28 17:49, Alan Stern wrote:
>>> On Sat, Sep 28, 2024 at 11:32:18AM -0400, Mathieu Desnoyers wrote:
>>>> On 2024-09-28 16:49, Alan Stern wrote:
>>>>> On Sat, Sep 28, 2024 at 09:51:27AM -0400, Mathieu Desnoyers wrote:
>>>>>> equality, which does not preserve address dependencies and allows the
>>>>>> following misordering speculations:
>>>>>>
>>>>>> - If @b is a constant, the compiler can issue the loads which depend
>>>>>>     on @a before loading @a.
>>>>>> - If @b is a register populated by a prior load, weakly-ordered
>>>>>>     CPUs can speculate loads which depend on @a before loading @a.
>>>>>
>>>>> It shouldn't matter whether @a and @b are constants, registers, or
>>>>> anything else.  All that matters is that the compiler uses the wrong
>>>>> one, which allows weakly ordered CPUs to speculate loads you wouldn't
>>>>> expect it to, based on the source code alone.
>>>>
>>>> I only partially agree here.
>>>>
>>>> On weakly-ordered architectures, indeed we don't care whether the
>>>> issue is caused by the compiler reordering the code (constant)
>>>> or the CPU speculating the load (registers).
>>>>
>>>> However, on strongly-ordered architectures, AFAIU, only the constant
>>>> case is problematic (compiler reordering the dependent load), because
>>> I thought you were trying to prevent the compiler from using one pointer
>>> instead of the other, not trying to prevent it from reordering anything.
>>> Isn't this the point the documentation wants to get across when it says
>>> that comparing pointers can be dangerous?
>>
>> The motivation for introducing ptr_eq() is indeed because the
>> compiler barrier is not sufficient to prevent the compiler from
>> using one pointer instead of the other.
> 
> barrier_data(&b) prevents that.

I don't think one barrier_data can garantuee preventing this, because 
right after doing the comparison, the compiler still could do b=a.

In that case you would be guaranteed to use the value in b, but that 
value is not the value loaded into b originally but rather the value 
loaded into a, and hence your address dependency goes to the wrong load 
still.

However, doing

barrier_data(&b);
if (a == b) {
    barrier();
    foo(*b);
}

might maybe prevent it, because after the address of b is escaped, the 
compiler might no longer be allowed to just do b=a;, but I'm not sure if 
that is completely correct, since the compiler knows b==a and no other 
thread can be concurrently modifying a or b. Therefore, given that the 
compiler knows the hardware, it might know that assigning b=a would not 
cause any  race-related issues even if another thread was reading b 
concurrently.

Finally, it may be only a combination of barrier_data and making b 
volatile could be guaranteed to solve the issue, but the code will be 
very obscure compared to using ptr_eq.

   jonas

