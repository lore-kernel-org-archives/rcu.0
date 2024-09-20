Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC98487AE;
	Fri, 20 Sep 2024 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726818264; cv=none; b=Nh3lml1jqelSSk8lC6pDH6Z7AS/lqJaIO96zdmIx3Q1Fv7J6fGylyuvZrNgc9NB99UFA78thG51Tztg3eshiymKh9q5VtNWaXtl6QtxisBYxI2p50lyMkHPACNo1RyJ+OWNBBBmbr1xLGn9CKZ7SzGV3RN8EIaMxzEr7v9FLBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726818264; c=relaxed/simple;
	bh=YWSUNT3mvy5KQhGTIciRDN7UKP2afgrsJvQq8zmHzK4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PufguUwz1/g8nS44aEMdaCftNrOkHCU9Qkp8KbjDf4tpmWteU8Rqec36WeouHMUkhDQG1Aw4xWg2V2EEvgiKQv9Th2W9Ih3FzrvmQdmxb4Dep/DPxkSAh+yykoRA2VfM//T9zV48mgwU5X4udfMoaZQeg4vB253zZkah0m9OqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X93f45jyVz9v7JM;
	Fri, 20 Sep 2024 15:18:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 4A055140F86;
	Fri, 20 Sep 2024 15:44:09 +0800 (CST)
Received: from [10.45.149.49] (unknown [10.45.149.49])
	by APP2 (Coremail) with SMTP id GxC2BwAHt8e6J+1m+mBJAQ--.61459S2;
	Fri, 20 Sep 2024 08:44:08 +0100 (CET)
Message-ID: <16c2aba7-212d-4612-8cea-50c64626d8f3@huaweicloud.com>
Date: Fri, 20 Sep 2024 09:43:52 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
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
 <abf4a899-e53e-41ac-91d6-1865ffeff5c6@huaweicloud.com>
In-Reply-To: <abf4a899-e53e-41ac-91d6-1865ffeff5c6@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAHt8e6J+1m+mBJAQ--.61459S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur15GryfGF17Kw43Kr4xXrb_yoW5AF13pr
	y8tF4UJryDJr1fAw1UXr1UX34UAr13J3WUJrn5WFyUJFWxGr1Igr1UXr1jgr1DAr4kJr1U
	tr1UXr9xZry5XrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jzE__UUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 9/19/2024 um 10:30 PM schrieb Jonas Oberhauser:
> 
> 
> 
> Am 9/19/2024 um 2:12 AM schrieb Jann Horn:
>> On Tue, Sep 17, 2024 at 4:33 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>>> Hazard pointers [1] provide a way to dynamically distribute refcounting
>>> and can be used to improve the scalability of refcounting without
>>> significant space cost.
>>
>>> +static inline void *__hazptr_tryprotect(hazptr_t *hzp,
>>> +                                       void *const *p,
>>> +                                       unsigned long head_offset)
>>> +{
>>> +       void *ptr;
>>> +       struct callback_head *head;
>>> +
>>> +       ptr = READ_ONCE(*p);
>>> +
>>> +       if (ptr == NULL)
>>> +               return NULL;
>>> +
>>> +       head = (struct callback_head *)(ptr + head_offset);
>>> +
>>> +       WRITE_ONCE(*hzp, head);
>>> +       smp_mb();
>>> +
>>> +       ptr = READ_ONCE(*p); // read again
>>> +
>>> +       if (ptr + head_offset != head) { // pointer changed
>>> +               WRITE_ONCE(*hzp, NULL);  // reset hazard pointer
>>> +               return NULL;
>>> +       } else
>>> +               return ptr;
>>> +}
>>
>> I got nerdsniped by the Plumbers talk. So, about that smp_mb()...
>>
>> I think you should be able to avoid the smp_mb() using relaxed atomics
>> (on architectures that have those), at the cost of something like a
>> cmpxchg-acquire sandwiched between a load-acquire and a relaxed load?
>> I'm not sure how their cost compares to an smp_mb() though.
> 
> 
> 
> We have done a similar scheme before, and on some architectures (not 
> x86) the RMW is slightly cheaper than the mb.
> 
> Your reasoning is a bit simplified because it seems to assume a stronger 
> concept of ordering than LKMM has, but even with LKMM's ordering your 
> code seems fine.
> 
> I feel it can even be simplified a little, the hazard bit does not seem 
> necessary.
> 
> Assuming atomic operations for everything racy, relaxed unless stated 
> otherwise:
> 
> (R)eader:
> 
>     old = read p // I don't think this needs acq, because of address 
> dependencies (*)
>     haz ||=_acq old
>     if (read p != old) retry;

I realized before going to bed that I copied a subtle mistake here from 
Jann's code, we need an address dependency from this read, or it is not 
ABA safe.
This can be done with the small detour that Boqun used:

      head = read p // I don't think this needs acq, because of address 
dependencies (*)
      haz ||=_acq head
      old = read p // again
      if (head != old) retry;
      barrier(); // ensure compiler does not use its knowledge that head 
== old to do *head instead!
      *old // definitely use the second read pointer so hardware can't 
speculatively dereference this before the second read!


Have a good time,
   jonas

