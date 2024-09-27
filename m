Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F70139D1B;
	Fri, 27 Sep 2024 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465025; cv=none; b=clQmnjYEFzjyv2LASUmNkMeS0PgVYHLj2p7aIXIS31Jmh5ph67N9uSI6+HUW9dEKn8TdS3HEIRpX9AKCh4Vl7AzC9Rkgz+1ixH2/DqPv8OSlg7ihCWN3hYFez6xDitZ3Q9sWfIfEcn9URuSJjwPIS2LmmTJEdtBgt4zE9UOQRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465025; c=relaxed/simple;
	bh=GM2PMzkiugJoiVXHiXF3aEICP/a8rNLrEmgoYpGtqoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3/7A0w5EQaMkeFwSoMxHlsWhGt4TvB4h/dFBlpWU5JXv78Qyf02dL9tTsdXHVamEJ0qKq2BnRVuZucslkKNY7cWQo5cLIsDsvgNmlAjR23ZdhdtWMktsLnSoxwBRiCYj6ADji2aPox6BNiXtLxRUZa1VICTMxZ024Dw0O58k/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XFfyJ0cLGz9v7NM;
	Sat, 28 Sep 2024 03:03:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id EDE42140496;
	Sat, 28 Sep 2024 03:23:37 +0800 (CST)
Received: from [10.81.203.162] (unknown [10.81.203.162])
	by APP2 (Coremail) with SMTP id GxC2BwBnFscqBvdmpgHGAQ--.52397S2;
	Fri, 27 Sep 2024 20:23:37 +0100 (CET)
Message-ID: <62508c1f-66ca-450d-abb6-236ca3b9096d@huaweicloud.com>
Date: Fri, 27 Sep 2024 21:23:20 +0200
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
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <ZvY2zBiluLkqRSkc@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBnFscqBvdmpgHGAQ--.52397S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF48Zw4Duw13Kr45ZFyDGFg_yoW8ZF1kpr
	WagF1YgF4kAr4Syr1Ivr4UZFyFyrn3Grn8Cw10gryqv3W3GF4xuF4fK3y7CF9rCrn3Cr1j
	qr129a4S9wsxZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
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

Two comments inline,

Am 9/27/2024 um 6:38 AM schrieb Boqun Feng:

> compilers can replace 'ptr' with 'head' because of the equality, and
> even putting barrier() here cannot prevent compiler to rewrite the else
> branch into:
> 
> 	else {
> 		barrier();
> 		return head;
> 	}
> 
> because that's just using a different register, unrelated to memory
> accesses.

Yeah, that was the solution I had in mind. My reasoning was that from 
the C abstract machine, head is still a memory access, and the barrier() 
should make the compiler forget everything it knew about the value of 
head from before the barrier().

So I had a gap in my understanding of the strength of barrier(). Can I 
understand it to mean that the compiler can do escape analysis to reason 
that a volatile asm code with ::memory can't possibly be manipulating 
some variables (like head in this case)?

That idea seems to be confirmed by this (atrocious, not to be copied!) 
example:

int fct_escape_address_of_b(void)
{
     int *a, *b;

     do {
         a = READ_ONCE(p);
         asm volatile ("" : : : "memory");
         b = READ_ONCE(p);
     } while (a != b);

     // really really hide b
     int **p = &b;
     OPTIMIZER_HIDE_VAR(p);

     asm volatile ("" : : : "memory");
     return *b;
}

This also does not generate any additional instructions, unlike just 
using OPTIMIZER_HIDE_VAR(b).

What is the advantage of defining OPTIMIZE_HIDE_VAR the way it currently 
works instead of like above?



 > On Fri, Sep 27, 2024 at 03:20:40AM +0200, Mathieu Desnoyers wrote:

>> I have a set of examples below that show gcc use the result of the
>> first load, and clang use the result of the second load (on
>> both x86-64 and aarch64). Likewise when a load-acquire is used as
>> second load, which I find odd. 

Note that if you use acquire on the second load, the code is correct 
even if the compiler uses the result of the first load.

That is because the acquire load will still synchronize sufficiently 
with the second publishing store after the ABA, and then we can get the 
right data even from the old address.

Best wishes,

   jonas

