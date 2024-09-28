Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5032770D;
	Sat, 28 Sep 2024 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727522561; cv=none; b=K2z2QeHCMBTo84XmzjHGQY981LRZJpI48Xym7wXXkueN7IQuNykn02jg+bI+KvQNWN03Djip8pmZZttYdffcm/kf5lf41NqBAZfoLV2HqX14cS5kvQWru3l3C5NeyBMdLaSbufr19vo+q8UCLhOLUVODfLJue7r2dn7fHOmqJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727522561; c=relaxed/simple;
	bh=wNEmwxiMl2rmgfv7NUN4h0Pde3A1T3VjLDKpW1era8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVXfuF52dmwi1JLEMmGlWLpHggQFyt2fFJn2tJRfF0PHqDrfxyixrBgCdNq9Cy9rt18B4Tilhs5bhDEdtFqGH8sUtYR8iWbICWu1ylxqsiLAw/TISzCtqCx1X29jBKEYTkQb4ebOJTYdsHLiTjxWrQ+BMKpyyz6eI3rOrlxKcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XG4Dk2bnkz9v7J3;
	Sat, 28 Sep 2024 19:02:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 12D9B141018;
	Sat, 28 Sep 2024 19:22:34 +0800 (CST)
Received: from [10.81.205.100] (unknown [10.81.205.100])
	by APP2 (Coremail) with SMTP id GxC2BwAn18fr5vdmdwnRAQ--.57386S2;
	Sat, 28 Sep 2024 12:22:33 +0100 (CET)
Message-ID: <db17633f-354d-428e-97c2-bcd455766c3a@huaweicloud.com>
Date: Sat, 28 Sep 2024 13:22:18 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] hpref: Hazard Pointers with Reference Counter
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Alan Stern
 <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev
References: <20240921164210.256278-1-mathieu.desnoyers@efficios.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20240921164210.256278-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAn18fr5vdmdwnRAQ--.57386S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1rCw17uFyxWrykZrWDArb_yoW8Jw13pa
	yUKay2yFW8Jr4fC3yvv3WUC3sakFs8JFsrX3y0vrWfZ398Wa1rAF10kayjyF93CrZ5Ww45
	ZrWYqwsxCF9FqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Two more questions below:

Am 9/21/2024 um 6:42 PM schrieb Mathieu Desnoyers:
> +#define NR_PERCPU_SLOTS_BITS	3

Have you measured any advantage of this multi-slot version vs a version 
with just one normal slot and one emergency slot?
With just one normal slot, the normal slot version would always be zero, 
and there'd be no need to increment etc., which might make the common 
case (no conflict) faster.

Either way I recommend stress testing with just one normal slot to 
increase the chance of conflict (and hence triggering corner cases) 
during stress testing.

> +retry:
> +	node = uatomic_load(node_p, CMM_RELAXED);
> +	if (!node)
> +		return false;
> +	/* Use rseq to try setting current slot hp. Store B. */
> +	if (rseq_load_cbne_store__ptr(RSEQ_MO_RELAXED, RSEQ_PERCPU_CPU_ID,
> +				(intptr_t *) &slot->node, (intptr_t) NULL,
> +				(intptr_t) node, cpu)) {
> +		slot = &cpu_slots->slots[HPREF_EMERGENCY_SLOT];
> +		use_refcount = true;
> +		/*
> +		 * This may busy-wait for another reader using the
> +		 * emergency slot to transition to refcount.
> +		 */
> +		caa_cpu_relax();
> +		goto retry;
> +	}

I'm not familiar with Linux' preemption model. Can this deadlock if a 
low-interrupt-level thread is occupying the EMERGENCY slot and a 
higher-interrupt-level thread is also trying to take it?




Best wishes,
   jonas

