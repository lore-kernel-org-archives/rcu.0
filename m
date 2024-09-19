Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE136B11;
	Thu, 19 Sep 2024 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726777860; cv=none; b=LBAK1nrfySYTJsgSoqulgMRAbMkeNmpxo9EI/rLsUatDCOPX0WmrCpGTdmoT2cwxoBYq56p9vg/dy3o0EA9aqyI8+Pm29cPmBdH1osrIbRfnJrY0oCqGdnb7k5V4vnkiFxFk3DrJK2LyPsibhD6HGNygH3RYGjbNBqWYQ3k0c9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726777860; c=relaxed/simple;
	bh=QOg9SSVk+762Jv4vk+oIinpIn6nCAa6YYARFpckLiEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMSrMSD6oVkrJiRt7UoI0y9Plvv1azJRQBg9O2bwnA1yxrYmkSLg5nBexSgWtmw6BpIOOQi7PZNyGuIBC9/A9j/t3sBWCTMixJqfLGFqS+no64/H+3sNESGN57tZBuOMDQPoZKFZm9uRB6iDaEMYVDnNIT01jeNSLri9lKKfnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X8mqk5nMBz9v7Hv;
	Fri, 20 Sep 2024 04:11:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 417F51401F1;
	Fri, 20 Sep 2024 04:30:54 +0800 (CST)
Received: from [10.81.207.148] (unknown [10.81.207.148])
	by APP1 (Coremail) with SMTP id LxC2BwAXqTDsiexm4cs+AQ--.1103S2;
	Thu, 19 Sep 2024 21:30:53 +0100 (CET)
Message-ID: <abf4a899-e53e-41ac-91d6-1865ffeff5c6@huaweicloud.com>
Date: Thu, 19 Sep 2024 22:30:34 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
To: Jann Horn <jannh@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>, lkmm@lists.linux.dev
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
 <CAG48ez0VN8oZcqhdzkWQgNv6bwUN=MUu5EacLg5iPvMQL+R-Qg@mail.gmail.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <CAG48ez0VN8oZcqhdzkWQgNv6bwUN=MUu5EacLg5iPvMQL+R-Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXqTDsiexm4cs+AQ--.1103S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur18XrW3urWxZw4ftFyDtrb_yoWrAF48pr
	WUKF1jyF4vywn2k34DZw42q3s7Gr1fZFy5G3s5K34UA3y5uF1SvFy3KrWa9FWkur4vyw10
	vrsxZas7tr98JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jxCztUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/




Am 9/19/2024 um 2:12 AM schrieb Jann Horn:
> On Tue, Sep 17, 2024 at 4:33 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>> Hazard pointers [1] provide a way to dynamically distribute refcounting
>> and can be used to improve the scalability of refcounting without
>> significant space cost.
> 
>> +static inline void *__hazptr_tryprotect(hazptr_t *hzp,
>> +                                       void *const *p,
>> +                                       unsigned long head_offset)
>> +{
>> +       void *ptr;
>> +       struct callback_head *head;
>> +
>> +       ptr = READ_ONCE(*p);
>> +
>> +       if (ptr == NULL)
>> +               return NULL;
>> +
>> +       head = (struct callback_head *)(ptr + head_offset);
>> +
>> +       WRITE_ONCE(*hzp, head);
>> +       smp_mb();
>> +
>> +       ptr = READ_ONCE(*p); // read again
>> +
>> +       if (ptr + head_offset != head) { // pointer changed
>> +               WRITE_ONCE(*hzp, NULL);  // reset hazard pointer
>> +               return NULL;
>> +       } else
>> +               return ptr;
>> +}
> 
> I got nerdsniped by the Plumbers talk. So, about that smp_mb()...
> 
> I think you should be able to avoid the smp_mb() using relaxed atomics
> (on architectures that have those), at the cost of something like a
> cmpxchg-acquire sandwiched between a load-acquire and a relaxed load?
> I'm not sure how their cost compares to an smp_mb() though.



We have done a similar scheme before, and on some architectures (not 
x86) the RMW is slightly cheaper than the mb.

Your reasoning is a bit simplified because it seems to assume a stronger 
concept of ordering than LKMM has, but even with LKMM's ordering your 
code seems fine.

I feel it can even be simplified a little, the hazard bit does not seem 
necessary.

Assuming atomic operations for everything racy, relaxed unless stated 
otherwise:

(R)eader:

    old = read p // I don't think this needs acq, because of address 
dependencies (*)
    haz ||=_acq old
    if (read p != old) retry;
    *old

(W)riter:

    p =_??? ... // assuming we don't set it to null this needs a rel
    --- mb ---
    haz ||= 0
    while (read_acq haz == old) retry;
    delete old


In order to get a use-after-free, both of the  R:read p  need to read 
before  W:p = ... , so because of the W:mb, they execute before  W:haz||=0 .

Also, for the use-after-free,  W:read_acq haz  needs to read before (the 
write part of)  R:haz||=_acq old .


Then the  W:haz ||= 0  also needs to read before (the write part of) 
R:haz||=_acq old  because of coherence on the same location.

Since both of them are atomic RMW, the  W:haz||= 0  also needs to write 
before (the write part of)  R:haz||=_acq old , and in the absence of 
non-RMW writes (so assuming no thread will just store to the hazard 
pointer), this implies that the latter reads-from an rmw-sequence-later 
store than  W:haz||=0 , which therefore executes before  R:haz||=_acq old .

But because of the acquire barrier,  R:haz||=_acq old  executes before 
the second  R:read p .


This gives a cycle
    (2nd)R:read p  ->xb  W:haz||=0  ->xb  R:haz||=_acq  ->xb  (2nd)R:read p

and therefore is forbidden.

Note that in this argument, the two  R:read p  are not necessarily 
reading from the same store. Because of ABA, it can happen that they 
read from distinct stores and see the same value.

It does require clearing hazard pointers with an RMW like atomic_and(0) 
(**). The combination of the two RMW (for setting & clearing the hazard 
pointer) might in total be slower again than an mb.


(I took the liberty to add an acquire barrier in the writer's while loop 
for the case where we read from the (not shown) release store of the 
reader that clears the hazard pointer. It's arguable whether that acq is 
needed since one could argue that a delete is a kind of store, in which 
case control dependency would handle it.)

have fun,
   jonas


(*
   you talk about sandwiching, and the data dependency does guarantee 
some weaker form of sandwiching than the acq, but I don't think 
sandwiching is required at all. If you happened to be able to set the 
hazard pointer before reading the pointer, that would just extend the 
protected area, wouldn't it?
)

(**
I think if you clear the pointer with a store, the hazard bit does not 
help. You could be overwriting the hazard bit, and the RMWs that set the 
hazard bit might never propagate to your CPU.

Also in your code you probably meant to clear the whole hazard pointer 
in the retry code of the reader, not just the hazard bit.)

