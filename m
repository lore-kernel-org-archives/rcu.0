Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61D17C988;
	Fri, 27 Sep 2024 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727475525; cv=none; b=Kt+wjXDT870o0VivS9erkKgpwXbn3U6tK2cF0JrlctNpQFgntncWPtUVXwfLnec6BRQxu9STu8QfP5OPKw5ZFT0z8vv3R0W4XOHcEruCV2oCfBQDWOgR79y4O391Bp8UvTeY81QZ3JVKop3+oNa7Cg6NEAj+/BTd7IWKFe+mxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727475525; c=relaxed/simple;
	bh=pDAq3jXFAuW/dqJmuTPIlpcyvVhpcj3PUSyb2x9xJJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caZvHzV/hGGqgq5kHZ3hfwfdKoXKHbqTeerDC9qRwPzTCfnVybdnWUuAY1oFOOfzYTr27k6nhzpy4M3TPPei0RluggtlSZRI8KqsqneYArRFq8ZJ40x2AOLGFWPW5BKGhD+jREwXhgWyE/MgEpPeRGf0H0CkFp6A0espHd/sgFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XFkr45RLHz9v7Hk;
	Sat, 28 Sep 2024 05:58:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 3424B1404A9;
	Sat, 28 Sep 2024 06:18:24 +0800 (CST)
Received: from [10.45.147.63] (unknown [10.45.147.63])
	by APP2 (Coremail) with SMTP id GxC2BwD3pscgL_dmmwLIAQ--.52307S2;
	Fri, 27 Sep 2024 23:18:23 +0100 (CET)
Message-ID: <4ed833df-54e6-454a-ab1a-73967cc51054@huaweicloud.com>
Date: Sat, 28 Sep 2024 00:18:03 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
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
 Kent Overstreet <kent.overstreet@gmail.com>, Vlastimil Babka
 <vbabka@suse.cz>, maged.michael@gmail.com,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>
References: <ZvPp4taB9uu__oSQ@boqun-archlinux>
 <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <ZvP_H_R43bXpmkMS@boqun-archlinux>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <bba2e656-4c3b-46db-b308-483de440b922@efficios.com>
 <ZvY2zBiluLkqRSkc@boqun-archlinux>
 <62508c1f-66ca-450d-abb6-236ca3b9096d@huaweicloud.com>
 <d86536d9-9c5a-48ab-abf3-3483e2e5e980@efficios.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <d86536d9-9c5a-48ab-abf3-3483e2e5e980@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwD3pscgL_dmmwLIAQ--.52307S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyxCFWkAr1rtw4DAFyUGFg_yoW8uw15pr
	1kKa1UWFZ8CFs7Ar17tr4jyFyYywn3Gas8XFyUWa4DA3yqqr1SvFWjgF90g3ZrCws5Jryj
	qr4UJr93uFWDAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	4xRDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 9/27/2024 um 10:10 PM schrieb Mathieu Desnoyers:
> On 2024-09-27 21:23, Jonas Oberhauser wrote:
> [...]
>> That idea seems to be confirmed by this (atrocious, not to be copied!) 
>> example:
>>
>> int fct_escape_address_of_b(void)
>> {
>>      int *a, *b;
>>
>>      do {
>>          a = READ_ONCE(p);
>>          asm volatile ("" : : : "memory");
>>          b = READ_ONCE(p);
>>      } while (a != b);
>>
>>      // really really hide b
>>      int **p = &b;
>>      OPTIMIZER_HIDE_VAR(p);
>>
>>      asm volatile ("" : : : "memory");
>>      return *b;
>> }
>>
>> This also does not generate any additional instructions, unlike just 
>> using OPTIMIZER_HIDE_VAR(b).
>>
>> What is the advantage of defining OPTIMIZE_HIDE_VAR the way it 
>> currently works instead of like above?
> 
> Did you try it on godbolt.org ? Does it have the intended effect ?

I certainly did try and certainly read it as having the intended effect, 
otherwise I wouldn't have written that it seems confirmed.

However, just because my eyes read it doesn't mean that's what happened, 
and even if it happened doesn't mean that it is guaranteed to happen.

> By the looks of it, you're just creating another version of @b called
> "p", which is then never used and would be discarded by further
> optimization. >
> I'm unsure what you are trying to achieve here.

Simply put I'm trying to let the compiler think that I leaked the 
address of b. After that, the memory barrier should let it think that 
the b after the memory barrier might not be the same as the one before 
it (which was equal to a), forcing it to read from b.

However, I suppose on second thought that that might not be enough, 
because the compiler could still simply do b = a right after exiting the 
while loop.

And that is true no matter what we put behind the while loop or before 
the condition, as long as the condition compares a and b, right after it 
the compiler can do b = a. Just took me a while to see :))

I'm not sure why gcc does the b=a with the normal OPTIMIZER_HIDE_VAR but 
(as far as I read the code) doesn't do it with the above. Maybe just a 
weird corner case...

Have fun,
   jonas

