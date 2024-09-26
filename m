Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193DB158D6A;
	Thu, 26 Sep 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368867; cv=none; b=mqGTo5T8a2EQpdktJO+ungQvT7OYQ7EwdRFMp2cB72GBkOpYBHKVVTnXX+W0p590LzcAehdH2LhUBjfYNS9g6znXPq51dPMFc6kPxWNHiGVL48Bx5VsSqpdEnC7KftsxdMMYf+8C1jVIfeGRulOOUITadhytK/h5fSOdiyGFGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368867; c=relaxed/simple;
	bh=Kg5x5O4BfdUTahZxxZiCOthqbANwjhEgzSdKitxzKC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ozg9+FTqYXZ9TG6QmIzR9epMq3mFIyQxjayGlW/0pvSH4BXHa5JYo64ypEKw930QTv6qsOVEn8oxhdmOQEr3PII2PHUCMgJxTTfgC1+eTACw2xviz8Y3DIHhqEmGkR8OHSDuo+RSdLXcVpvuR/d8z3n7YGoh6oAVOzF7vvA/yOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XDzNy6HMzz9v7Hp;
	Fri, 27 Sep 2024 00:21:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id AE558140877;
	Fri, 27 Sep 2024 00:40:49 +0800 (CST)
Received: from [10.45.145.4] (unknown [10.45.145.4])
	by APP2 (Coremail) with SMTP id GxC2BwAniMiBjvVmk3azAQ--.33772S2;
	Thu, 26 Sep 2024 17:40:49 +0100 (CET)
Message-ID: <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com>
Date: Thu, 26 Sep 2024 18:40:30 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev,
 "Paul E. McKenney" <paulmck@kernel.org>,
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
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAniMiBjvVmk3azAQ--.33772S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy7KF4kWF4UAF43KFy5CFg_yoW8tr15pr
	W5KF48KF4kXayYkwn7tw47ury5AaykJFW7uF95WrykArn8Wr1Skr1SkFy7Zas5Cws3Xry2
	yrWSvry7Xa4ayaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



Am 9/26/2024 um 6:12 PM schrieb Linus Torvalds:
> On Thu, 26 Sept 2024 at 08:54, Jonas Oberhauser
> <jonas.oberhauser@huaweicloud.com> wrote:
>>
>> No, the issue introduced by the compiler optimization (or by your
>> original patch) is that the CPU can speculatively load from the first
>> pointer as soon as it has completed the load of that pointer:
> 
> You mean the compiler can do it.

What I mean is that if we only use rcu_dereference for the second load 
(and not either some form of compiler barrier or an acquire load), then 
the compiler can transform the second program from my previous e-mail 
(which if mapped 1:1 to hardware would be correct because hardware 
ensures the ordering based on the address dependency) into the first one 
(which is incorrect).

In particular, the compiler can change

  if (node == node2) t = *node2;

into

  if (node == node2) t = *node;

and then the CPU can speculatively read *node before knowing the value 
of node2.

The compiler can also speculatively read *node in this case, but that is 
not what I meant.

The code in Mathieu's original patch is already like the latter one and 
is broken even if the compiler does not do any optimizations.


> The inline asm has no impact on what
> the CPU does. The conditional isn't a barrier for the actual hardware.
> But once the compiler doesn't try to do it, the data dependency on the
> address does end up being an ordering constraint on the hardware too

Exactly. The inline asm would prevent the compiler from doing the 
transformation though, which would mean that the address dependency 
appears in the final compiler output.

> Just use a barrier.  Or make sure to use the proper ordered memory
> accesses when possible. 
 >
> Don't use an inline asm for the compare - we
> don't even have anything insane like that as a portable helper, and we
> shouldn't have it.

I'm glad you say that :))

I would also just use a barrier before returing the pointer.

Boqun seems to be unhappy with a barrier though, because it would 
theoretically also forbid unrelated optimizations.
But I have not seen any evidence that there are any unrelated 
optimizations going on in the first place that would be forbidden by this.

Have fun,
   jonas

