Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9614D71D;
	Thu, 26 Sep 2024 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366063; cv=none; b=NQlrv/LP6nujGaWQHkTzxXQ/HROli+LQth/SPRhk0zFK7pFtMjGxmE8cx4fSu7+3HZxQ3ye+vELQoz4vJDrYa6b6HKexe100nJfAUMMD0i12REfPk/JLUVvK3ehhPrJj2B7So9QqM4rh0dZexlXa2lHVd4qfPGJJqwVqjgZNzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366063; c=relaxed/simple;
	bh=pcqEBfLkgGYCPeXstyQ0w7L6Flkbx892UwEEqSHOm/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NERMkpaJqlrU9cexNczhSi/4H9HgPdn46CiTnO1YwmBE4zG+QnIcd+Dfc41lJc1jtV2gb7EDQlr9DZZA/nNHu3HUPqLrwmgVPSTMHkZtxK9XEBEsR8BkFvu/e05UvJlDPGlFkTL0gDYRRqqkPd2AOKZe611v8bjO6pb02IyIVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XDyM66vpFz9v7J8;
	Thu, 26 Sep 2024 23:34:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 8F143140392;
	Thu, 26 Sep 2024 23:54:02 +0800 (CST)
Received: from [10.45.145.4] (unknown [10.45.145.4])
	by APP2 (Coremail) with SMTP id GxC2BwAniMiLg_VmEOyyAQ--.33525S2;
	Thu, 26 Sep 2024 16:54:02 +0100 (CET)
Message-ID: <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
Date: Thu, 26 Sep 2024 17:53:44 +0200
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
 <ZvP_H_R43bXpmkMS@boqun-archlinux>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAniMiLg_VmEOyyAQ--.33525S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4xWFy3Jw17Kw4kAr48Xrb_yoW8AFy8pr
	4ftFWxXFWkua1rKwn7ta1UuFW5Jr4xJay5uF95JF18Ars5XF10qF12qryYga4fCr4kX34U
	tFW5Xry3ZasxJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



Am 9/26/2024 um 8:16 AM schrieb Mathieu Desnoyers:
> On 2024-09-25 15:20, Mathieu Desnoyers wrote:
> [...]
>> static inline
>> bool same_ptr(void *a, void *b)
>> {
>>      asm goto (
>>          "cmpq %[a], %[b]\n\t"
>>          "jne %l[ne]\n\t"
>>          : : [a] "r" (a), [b] "r" (b)
>>          : : ne);
>>      return true;
>> ne:
>>      return false;
>> }
> 
> Based on the information provided in this email thread,
> it appears the only concern when it comes to comparing a
> pointer loaded by rcu_dereference() with another pointer
> is the possibility of compiler optimizations.
> 
> In the specific case of hazard pointer hpref_hp_get(), this
> function does both loads which are then compared with one
> another. Therefore, it is not possible for the user to
> provide a comparison value known at compile-time, except
> in the unlikely scenario where the hazard pointer would
> be const, which does not really make much sense.
> 
> Therefore, just using rcu_dereference() for the second
> load should be fine.
> 
> Thanks,
> 
> Mathieu
> 

No, the issue introduced by the compiler optimization (or by your 
original patch) is that the CPU can speculatively load from the first 
pointer as soon as it has completeled the load of that poitner:


node = ...
// t's value can be computed here, since the value of node is known
...
node2 = ...
if (node == node2) // just a control dependency, doesn't prevent 
speculatively loading node
    t = *node

if we can force the compiler's hand, it will generate this code which 
provides the necessary ordering at hardware level:

node = ...
// t can't be computed here since the value of node2 is not known here
...
node2 = ...
// t can be computed here
if (node == node2)
    t = *node2


Kind regards,

   jonas

