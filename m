Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07D018E29;
	Thu, 19 Sep 2024 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726769290; cv=none; b=T/FqRu0/ZtUixwV3gjLjehroagimcc0xSxsLU0QNqOklGpepRgCakR3nki7VVWBhhZHKLMrOxev/i39NIgLNlf+9SF2TKkQfzT1R1Oum/QoGcBxvT7A6SBk8m71XxPxLkbDLe6trFwYVrrECMYRWU0k0J8VnzFB9ZnWLmhoDRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726769290; c=relaxed/simple;
	bh=VpC6Z/47eQxpdIMlA69QxhaCcEiM6gKkuzmPhgwQNiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lL8fa3WJw0OolmY8YY8C0+OjwVgRGFfPDFUUsq2SJKsjYLpZ8VvL/POXnDK6Ytg0+BjMJ+s3ac7RaX5k2AL+iPJYLBwhlH+zSs/zLZkz55UMy2mBBKCuRWrwlg06vojCBint9u8FdOe1Z/1yCsdnLbNrqROiGEwjEc0w9E71u7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X8jfw0y6Xz9v7Hl;
	Fri, 20 Sep 2024 01:48:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 26451140E75;
	Fri, 20 Sep 2024 02:07:51 +0800 (CST)
Received: from [10.81.207.148] (unknown [10.81.207.148])
	by APP2 (Coremail) with SMTP id GxC2BwAXespnaOxmyP8_AQ--.55647S2;
	Thu, 19 Sep 2024 19:07:50 +0100 (CET)
Message-ID: <9de1c243-8299-4587-8661-7773cef31a05@huaweicloud.com>
Date: Thu, 19 Sep 2024 20:07:32 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
To: Boqun Feng <boqun.feng@gmail.com>, Alan Huang <mmpgouride@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
 linux-mm@kvack.org, lkmm@lists.linux.dev,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Neeraj upadhyay <neeraj.upadhyay@amd.com>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
 <CA757E86-2AE4-4077-A07A-679E3BFDBC34@gmail.com>
 <ZuvLHxH33-p8ki1d@boqun-archlinux>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <ZuvLHxH33-p8ki1d@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAXespnaOxmyP8_AQ--.55647S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw47uF15XryrKFWUKw4UJwb_yoWDGrg_C3
	Zrua4vkr1UGF4DXr4rtr18Kr12qF4UZw1qqwn8Jr47Z34rAFWrA3Wvyr95uws3Ja10y34a
	9r90v34ava47XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	4xRDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 9/19/2024 um 8:56 AM schrieb Boqun Feng:
> On Wed, Sep 18, 2024 at 11:17:37PM +0800, Alan Huang wrote:
> [...]
>>> +#define hazptr_tryprotect(hzp, gp, field) (typeof(gp))__hazptr_tryprotect(hzp, (void **)&(gp), offsetof(typeof(*gp), field))
>>> +#define hazptr_protect(hzp, gp, field) ({ \
>>> + typeof(gp) ___p; \
>>> + \
>>> + ___p = hazptr_tryprotect(hzp, gp, field); \
>>> + BUG_ON(!___p); \
>>
>> hazptr_tryprotect might return NULL, do you need a loop here?
>>
> 
> Thanks for the review. It's me who didn't do a good job here on the
> documentation. hazptr_protect() is supposed to use for the case where
> readers know the gp won't change.
> 
> Regards,
> Boqun
> 
>>> + ___p; \
>>> +})
>>> +

Oh, disregard my other e-mail, I hadn't seen this discussion.

Do you have any specific use case of this in mind? If you know that the 
pointer can't change, I would assume you can also just read the pointer 
normally and assign to the hazard pointer without a fence, no?

have fun, jonas

