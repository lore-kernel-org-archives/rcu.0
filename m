Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3D18308D;
	Wed, 25 Sep 2024 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266817; cv=none; b=kw0PDoV//t6fr6LIf3Pr2z8cjhVBhe99++yDG48rmwU+Gwcnl7LtJGXuUKVGGgYtB9JQBsnn3PrrTJ+6f8c8N6qmxW2p6YMWaDqoRQbMgSHcb+pOhRzRU8P/+OfCC9kizAHAvCXNW+LHwUOZud82vA4zPbGrNaa4Rkhk1V06QRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266817; c=relaxed/simple;
	bh=J2IKyiWtAdZ/KoQC8HE66y/Anyja9pvtlm9bo+qZz1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUJy/NCkc39y7T5RQDMThcZ2ohXbgkNkYpZPxVTNEoiBwFE37xcgOCNp84hqgEtEp/zfEaY2EP8LRlmg0n7DNiea7XluPps6cKeEWLxfQBRL8oLvbxxqOHJT5yu8jloiGjjf/ONoYHkiN+Ywt69Y271li7ZW/AHznb6G0GduMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XDFWp5vG0z9v7JW;
	Wed, 25 Sep 2024 19:54:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 86A8C140628;
	Wed, 25 Sep 2024 20:20:02 +0800 (CST)
Received: from [10.81.208.14] (unknown [10.81.208.14])
	by APP2 (Coremail) with SMTP id GxC2BwAniMjl__NmNLmfAQ--.24510S2;
	Wed, 25 Sep 2024 13:20:01 +0100 (CET)
Message-ID: <55ea84c8-92fd-4268-9732-6fac3a0e78b7@huaweicloud.com>
Date: Wed, 25 Sep 2024 14:19:47 +0200
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
 <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAniMjl__NmNLmfAQ--.24510S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF45Jw48Xw4xJFy8uw4Uurg_yoWrGFW3pr
	WkK3WUJFWDJr40kr1Utr1UAryYyr18J3W5Grn5JFyjyr4Ygr1jqr42qr1j9FyUAw4kXryj
	vr1Yq3srZF17XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jzE__UUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 9/25/2024 um 1:59 PM schrieb Mathieu Desnoyers:
> On 2024-09-25 12:45, Boqun Feng wrote:
>> On Wed, Sep 25, 2024 at 12:11:52PM +0200, Jonas Oberhauser wrote:
>>>
>>>
>>> Am 9/25/2024 um 12:02 PM schrieb Boqun Feng:
>>>> Hi Jonas,
>>>>
>>>> Of
>>>> course, if we are really worried about compilers being too "smart"
>>>
>>> Ah, I see you know me better and better...
>>>
>>>> we can always do the comparison in asm code, then compilers don't know
>>>> anything of the equality between 'ptr' and 'head - head_offset'.
>>> Yes, but then a simple compiler barrier between the comparison and 
>>> returning
>>> ptr would also do the trick, right? And maybe easier on the eyes.
>>>
>>
>> The thing about putting a compiler barrier is that it will prevent all
>> compiler reorderings, and some of the reordering may contribute to
>> better codegen. (I know in this case, we have a smp_mb(), but still
>> compilers can move unrelated code upto the second load for optimization
>> purpose). Asm comparison is cheaper in this way. But TBH, compilers
>> should provide a way to compare pointer values without using the result
>> for pointer equality proof, if "convert to unsigned long" doesn't work,
>> some other ways should work.
>>
> 
> Based on Documentation/RCU/rcu_dereference.rst :
> 
> -       Be very careful about comparing pointers obtained from
>          rcu_dereference() against non-NULL values.  As Linus Torvalds
>          explained, if the two pointers are equal, the compiler could
>          substitute the pointer you are comparing against for the pointer
>          obtained from rcu_dereference().  For example::
> 
>                  p = rcu_dereference(gp);
>                  if (p == &default_struct)
>                          do_default(p->a);
> 
>          Because the compiler now knows that the value of "p" is exactly
>          the address of the variable "default_struct", it is free to
>          transform this code into the following::
> 
>                  p = rcu_dereference(gp);
>                  if (p == &default_struct)
>                          do_default(default_struct.a);
> 
>          On ARM and Power hardware, the load from "default_struct.a"
>          can now be speculated, such that it might happen before the
>          rcu_dereference().  This could result in bugs due to misordering.
> 
> So I am not only concerned about compiler proofs here, as it appears
> that the speculation done by the CPU can also cause issues on some
> architectures.

No, this is only possible in this example because of the compiler first 
doing some other optimizations (like what I mentioned on Boqun's 
original patch).

If you can ensure that the instruction sequence corresponds to more or less

t = load p // again
// on alpha: dep fence
...

*t

then you can be sure that there is an address dependency which orders 
the access. This is guaranteed by LKMM, or if you don't trust LKMM, also 
by Arm, Power, Alpha etc.

The extra dep fence on alpha is automatically inserted if you use 
READ_ONCE as boqun did (and I assumed your uatomic_load or whatever is 
doing the same thing, but I didn't check).

Given that the hazard-pointer-protected object presumably is not a 
single static non-freeable object, but some dynamically allocated 
object, it is pretty much impossible for the compiler to guess the 
address like in the example you shared above.

Note that inside the if, the code after transform is 
do_default(default_struct.a);
which is an address that is known to the hardware before it loads from gp.

That would not be the case here (if the compiler optimization is ruled out).

jonas

