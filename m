Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980B487AE;
	Fri, 20 Sep 2024 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726818106; cv=none; b=LTW1pYPhardiqnNsJR2AgqkjbGBFRhibU4Nrdn5YABjtMwXDwpAyGkYn4ce7efUJH10FzyQFeHUVcF3n86bjedPHtBGSVimgpcDO00oWE/vfPzvIBmJP6Muxv5L3bWJuqh6hR7Yoeb/mbDzYpjLjZQX1cUw1pRzaqMo2vIC2pOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726818106; c=relaxed/simple;
	bh=mm5FE5CerJn4exUyitMt7FzApp/OUc8cXF1jNcij2IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gj1Wdc6O0UXDtpve7yGDki1I6iXpSTyOZZAQj7fR9v5IBOnT+WXXSqn9OHVNg2RtK78hlsbwi1CatigoP+xU90h3J7zQhC/vD12uivG3bNqqlZIKCXM7k2r4ki+703+pN5h7P6RzRQyIx0LFN0ox7NCgQKUYrs6zvXAYg+5LbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X93jj35Q1z9v7NM;
	Fri, 20 Sep 2024 15:22:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 7CFC11408CC;
	Fri, 20 Sep 2024 15:41:33 +0800 (CST)
Received: from [10.45.149.49] (unknown [10.45.149.49])
	by APP2 (Coremail) with SMTP id GxC2BwDnlsceJ+1mNllJAQ--.61641S2;
	Fri, 20 Sep 2024 08:41:32 +0100 (CET)
Message-ID: <55975a55-302f-4c45-bfcc-192a8a1242e9@huaweicloud.com>
Date: Fri, 20 Sep 2024 09:41:15 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
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
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20240917143402.930114-2-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwDnlsceJ+1mNllJAQ--.61641S2
X-Coremail-Antispam: 1UD129KBjvJXoW7try3Xw45KFyDJFyxGrW3ZFb_yoW8GrW8pr
	ZFqFyUCFs3JF4SyayDXw17urWv93Z3tFyDJas3uFykA3W5GrWrXF9rKryjvws5ArsY934Y
	qrW5KrZxAFyDuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
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



Am 9/17/2024 um 4:33 PM schrieb Boqun Feng:
> +static inline void *__hazptr_tryprotect(hazptr_t *hzp,
> +					void *const *p,
> +					unsigned long head_offset)
> +{
> +	void *ptr;
> +	struct callback_head *head;
> +
> +	ptr = READ_ONCE(*p);
> +
> +	if (ptr == NULL)
> +		return NULL;
> +
> +	head = (struct callback_head *)(ptr + head_offset);
> +
> +	WRITE_ONCE(*hzp, head);
> +	smp_mb();
> +
> +	ptr = READ_ONCE(*p); // read again
> +
> +	if (ptr + head_offset != head) { // pointer changed
> +		WRITE_ONCE(*hzp, NULL);  // reset hazard pointer
> +		return NULL;
> +	} else
> +		return ptr;
> +}

There is a subtle potential for ABA issues here.

If the compiler replaces 'return ptr;' with 'return head - 
head_offset;', then you do not have an address dependency from the 
second read.

In this case, in ABA, the first read can read from a stale store, then 
the second read reads the same value from a newer store but only 
establishes control-dependency based synchronization with that store; 
any reads from *ptr could be speculatively executed before doing the 
second ptr = READ_ONCE(*p).

Therefore you could read the object state before it is properly 
reinitialized by the second store.

I'm not sure what the most efficient fix is or if you just want to 
gamble that "the compiler will never do that".
I guess either READ_ONCE(ptr) or a compiler barrier before return ptr 
might do it?

Have fun,
    jonas

