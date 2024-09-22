Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2315572B;
	Sun, 22 Sep 2024 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726991327; cv=none; b=apZfuvrU/KbWRj8dqAUWg1LURUGHpBpJ7/UnLNGCb/FCk3LJ/vYJJs0qb5oGrGUgA5llfgN503BAatOz67XcdxG78uW6OIH7g1D8BE1oNjugOSNYuyA1Rq0+/CXEOT2ukxRGC2+LK70pOW7Pd126h7wyoxc3M7jGQWQm1Jv7/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726991327; c=relaxed/simple;
	bh=vj89NnEO3dY9ymXcJzbHblA4gmtlMtSWhJT/+5TqzD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ue5VM3kzXzMknz5l5htQDdiQzENLkIKe3qPVvKbYFpkCcLDNJCvA4apB4GUtTTOgUITMp1i2kWJA+GUJpG2yV1+Zt3TEBkKLgi5vmJHJb95qH5ynLfFt6I9ZZR1ESKikLgrOx/7ofdTLKegjqybP8+L2+K8CGzre3v1wn6bV9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ZdPaISEe; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZdPaISEe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1726991322;
	bh=vj89NnEO3dY9ymXcJzbHblA4gmtlMtSWhJT/+5TqzD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZdPaISEemDKOOHayARAO5nS+VbU1ofrn5bcbePIQOVWcLhZ4HhVZRYpeGk9HY/TSa
	 lG//+kwIWsQbu1p+8lDZM+S1yEGkOs7iLaEAlvO8z8D/d5U4pBf9L9OJxglypYg2Xy
	 H4a4tgsyF5gv3FevVw9uug7Y6J372T4QT0N5a9cbXblTwYXLljxQxJPesROpXNvg1Z
	 rsvBuN133yFnn/Qj13GkUfvxEjuQwNn8yowXKnJCT5nEup+H4rsGDcMEZcWL9z9SIg
	 zSlSSMyRsJc8Pm09Hv+L+prx9QeQmFvGTMj6gkFtjXXoZCjimnuBKdt3fOaZsGd8m+
	 LMLteOSGKL61w==
Received: from [172.17.2.162] (unknown [178.208.16.192])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XBJCX3vk2z1LPp;
	Sun, 22 Sep 2024 03:48:40 -0400 (EDT)
Message-ID: <8185fa8b-f6de-4bed-9fd1-73b72fc6d716@efficios.com>
Date: Sun, 22 Sep 2024 09:47:56 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] hpref: Hazard Pointers with Reference Counter
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <20240921164210.256278-1-mathieu.desnoyers@efficios.com>
 <CAJhGHyBOwwBhCW96MyFGPVWed2ko37mLeHzta2BzL6T-TzUnmg@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAJhGHyBOwwBhCW96MyFGPVWed2ko37mLeHzta2BzL6T-TzUnmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-21 23:07, Lai Jiangshan wrote:
>> +/*
>> + * hpref_hp_get: Obtain a reference to a stable object, protected either
>> + *               by hazard pointer (fast-path) or using reference
>> + *               counter as fall-back.
>> + */
>> +static inline
>> +bool hpref_hp_get(struct hpref_node **node_p, struct hpref_ctx *ctx)
>> +{
>> +       int cpu = rseq_current_cpu_raw();
>> +       struct hpref_percpu_slots *cpu_slots = rseq_percpu_ptr(hpref_percpu_slots, cpu);
>> +       struct hpref_slot *slot = &cpu_slots->slots[cpu_slots->current_slot];
>> +       bool use_refcount = false;
>> +       struct hpref_node *node, *node2;
>> +       unsigned int next_slot;
>> +
>> +retry:
>> +       node = uatomic_load(node_p, CMM_RELAXED);
>> +       if (!node)
>> +               return false;
>> +       /* Use rseq to try setting current slot hp. Store B. */
>> +       if (rseq_load_cbne_store__ptr(RSEQ_MO_RELAXED, RSEQ_PERCPU_CPU_ID,
>> +                               (intptr_t *) &slot->node, (intptr_t) NULL,
>> +                               (intptr_t) node, cpu)) {
>> +               slot = &cpu_slots->slots[HPREF_EMERGENCY_SLOT];
> 
> Can @cpu be possibly changed? if it can, it seems @cpu and @cpu_slots
> should be updated first.

Indeed, if migration happens between rseq_current_cpu_raw() and
execution of rseq_load_cbne_store__ptr(), it will cause this
second operation to fail. This in turn could cause the reader
to retry for a long time (possibly forever) until it finally
migrates back to the original CPU. As you suggest, we should
re-load cpu and cpu_slots after failure here. More specifically,
we should re-load those when the rseq c.s. fails with -1, which
means it was abort or there was a cpu number mismatch. If the
rseq c.s. returns 1, this means the slot did not contain NULL,
so all we need to do is move over to the next slot.

While applying your suggested change, I noticed that I can
improve the fast-path by removing the notion of "current_slot"
number, and thus remove increment of this hint from the
fast path. The fast path will instead just scan all 8 slots
trying to find a NULL one. This also lessens the odds that
the fast-path must fallback to refcount in case of concurrent
use. It provides a 50% performance improvement for the fast
path with barrier/membarrier pairing.

I've updated the https://github.com/compudj/userspace-rcu-dev/tree/hpref
volatile feature branch with these changes. I'll give others some
time to provide feedback on the overall idea before sending out
an updated patch.

Thanks for your feedback!

Mathieu

> 
>> +               use_refcount = true;
>> +               /*
>> +                * This may busy-wait for another reader using the
>> +                * emergency slot to transition to refcount.
>> +                */
>> +               caa_cpu_relax();
>> +               goto retry;
>> +       }

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

