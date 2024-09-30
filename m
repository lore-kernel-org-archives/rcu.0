Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00254765;
	Mon, 30 Sep 2024 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715943; cv=none; b=qM9Sw0hJQRxlnYQqTE2fBfcGPmKrVTWN/Ah6wPAXzVWbx5RG+2suEgCBGlqgkQztt15IiqjpgeSIsdSBcQ74sCJ2DsJa40IGMaWCsbL7wi7SkQ++Wgn0o3soB8m1L5ByyB7UYsk6A8OUVcsejbxFTUEptc0qOPGXOd4vUVs1VMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715943; c=relaxed/simple;
	bh=RILc8DXqlujmScmAB8dI/uIvf3KRk+SNjPvRDlWDEdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D91DZo62ytlyI25N+zMl8NyAG0Yos8NowzpJ1IE+G7e+fJ39A0fznW4d3SHXCmEtC5KMnJs8xDSkJxk14Lef2xb+XouAYuw+Y0tN0r+Lp/KnUrR+Ct40jQEUMtfeWar/Iu/Edx6IiT5gn0vQ9eI6FituTtw0yEocEMeonixHy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XHRch6Q2Pz9v7JN;
	Tue,  1 Oct 2024 00:39:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 201F7140B63;
	Tue,  1 Oct 2024 01:05:27 +0800 (CST)
Received: from [10.81.209.28] (unknown [10.81.209.28])
	by APP1 (Coremail) with SMTP id LxC2BwAnuC9G2vpmEMjxAQ--.62409S2;
	Mon, 30 Sep 2024 18:05:26 +0100 (CET)
Message-ID: <5d7d8a59-57f5-4125-95bb-fda9c193b9cf@huaweicloud.com>
Date: Mon, 30 Sep 2024 19:05:06 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
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
 <9539c551-5c91-42db-8ac1-cff1d6d7c293@huaweicloud.com>
 <2cdda043-1ad9-40cf-a157-0c16a0ffb046@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <2cdda043-1ad9-40cf-a157-0c16a0ffb046@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwAnuC9G2vpmEMjxAQ--.62409S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4xJr1fCF4kCF1fKr17Jrb_yoW8Zryfpr
	Z8ta15KF4kGw13Crs0yw15ZFWa9an3KFy5Wrn7XrW0kan09FyfKF47KFy5uF9xZ34fJrWj
	y3yUurWfuFy3JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



Am 9/30/2024 um 6:43 PM schrieb Alan Stern:
> On Mon, Sep 30, 2024 at 01:26:53PM +0200, Jonas Oberhauser wrote:
>>
>>
>> Am 9/28/2024 um 4:49 PM schrieb Alan Stern:
>>> On Sat, Sep 28, 2024 at 09:51:27AM -0400, Mathieu Desnoyers wrote:
>>>> Compiler CSE and SSA GVN optimizations can cause the address dependency
>>>> of addresses returned by rcu_dereference to be lost when comparing those
>>>> pointers with either constants or previously loaded pointers.
>>>>
>>>> Introduce ptr_eq() to compare two addresses while preserving the address
>>>> dependencies for later use of the address. It should be used when
>>>> comparing an address returned by rcu_dereference().
>>>>
>>>> This is needed to prevent the compiler CSE and SSA GVN optimizations
>>>> from replacing the registers holding @a or @b based on their
>>>
>>> "Replacing" isn't the right word.  What the compiler does is use one
>>> rather than the other.  Furthermore, the compiler can play these games
>>> even with values that aren't in registers.
>>>
>>> You should just say: "... from using @a (or @b) in places where the
>>> source refers to @b (or @a) (based on the fact that after the
>>> comparison, the two are known to be equal), which does not ..."
>>
>> I should also point out that it is not enough to prevent the compiler from
>> using @a instead of @b.
>>
>> It must also be prevented from assigning @b=@a, which it is often allowed to
>> do after finding @a==@b.
> 
> Wouldn't that be a bug? 

That's why I said that it is often allowed to do it. In your case it 
wouldn't, but it is often possible when a and b are non-atomic & 
non-volatile (and haven't escaped, and I believe sometimes even then).

It happens for example here with GCC 14.1.0 -O3:

int fct_hide(void)
{
     int *a, *b;

     do {
         a = READ_ONCE(p);
         asm volatile ("" : : : "memory");
         b = READ_ONCE(p);
     } while (a != b);
     OPTIMIZER_HIDE_VAR(b);
     return *b;
}



         ldr     r1, [r2]
         ldr     r3, [r2]
         cmp     r1, r3
         bne     .L6
         mov     r3, r1   // nay...
         ldr     r0, [r3] // yay!
         bx      lr


Have fun,

    jonas

