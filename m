Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCDC266B66
	for <rcu@vger.kernel.org>; Wed, 25 Jun 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866733; cv=none; b=eJ8qbhLgAZZ8wlFEbjfgJc/Kaet6diU2kpArHqioAvREMoYHwf6cijnO5HXYIjcE/oLQqhMF8yyWcOKMVD2CDZsXEVSHR0bz/HjyRb6yci/MXE8Gp3vn+PavSv9+faPTIBa0CPd26xbZcjQ0nRMKiR24u05zQWEgM3Au2F8Lm7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866733; c=relaxed/simple;
	bh=2dEZxA9znoi4/j5ZU/wsEM4CqiVDW+cT8z82gn8Ynjg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KZkpJ+o4Qn0OGc7C3jaqUdFqS6blZ9A2DpV4zOiPL8Z12058SRxfzGYJhtbsbJSRXibWEcN7fVhwCi8w+qLOLCby7OJxlOW4xCQT0k9lQPH3br1DlEXF6Nksx0cX1VL4ivLeN8WXsE3AFshyOJkZ/HvEdkPn1iXAyeygufttgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcXOWu11; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcXOWu11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750866731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UprNKi29neeOtDuoBhXpguAmiHeVIiz0UMx6QLlk6uM=;
	b=HcXOWu11s0hnBTKUJZLd6Ur8dGbEx+CT9iktYnp4HJovc02caL12KHuoF+YmaUCmQ/vTaL
	v5YzygEyzklEko0BPbp3QfNa9cPToVMlEdEvesCYb9MFivDJXJi3OVHGuy/b9obNNI6hf6
	qrYkudeAizNLD57wYyrYkomO0QNULUY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-4Mlc6LHiNsihy91ohF8nsA-1; Wed, 25 Jun 2025 11:52:08 -0400
X-MC-Unique: 4Mlc6LHiNsihy91ohF8nsA-1
X-Mimecast-MFC-AGG-ID: 4Mlc6LHiNsihy91ohF8nsA_1750866728
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311d670ad35so6353583a91.3
        for <rcu@vger.kernel.org>; Wed, 25 Jun 2025 08:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750866728; x=1751471528;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UprNKi29neeOtDuoBhXpguAmiHeVIiz0UMx6QLlk6uM=;
        b=N0KJ5F7HCPL/n2uuurKB0KYsfK0bQ5KLXVbHsZ8DRtvJIzTcuzOpYrP/qUbGukjfdn
         ISj23KIW320RmMJ7D9IvFr+gMXr50fKrigB23Y2udYftEXtEfqHjLEkq9gBOE07wcUKZ
         SznlgGnYIjo+Rx7HeLX0NT+r2PhwNb3mNpgp/ImsHQMJxHDG6vp1bxHjDUTTAtRQ5r6C
         vSXsn+5gbyCMeYOmR73b8/b7tcE+eMncr4Brx0LAlVVgA7dew11rfvV4DS0G5+4Lo12I
         bEmCFyDoRR+3WsbevU9VjznhPCspB/RwEFgkMAuuU9WYnFRzoD5+FTdHWCUXWa4mk/yB
         HtAg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Io11rdNN1ANun9jxUBQqwt1iUf7LFR1Y4WM0BDwbzypBAchfjUDOQyDBadi74QbebMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7HvlqU29sZbZ/JZ+Hu3godyWoW50EEdOK8rCrgbF0jS+fb2FM
	yljnBryIJs8pinrd7kiwddK4i3+RGvN9KMF5ZgQQ8lrKSceue3WiUZ72Y4Sior0GJ8yuCT3XSao
	I9WzQShL3oJjj9mKnLKoxlObHfZq7SYP0/7oQGR7AOPZ1Mo2Ez89gRw==
X-Gm-Gg: ASbGncvWk+zO3ae76uP4ARW5KhCqcsL4bfd0UYzO9vs0AMhpAzJl6300sRX590BjlQh
	Z812aDTCID/Kc9VO/A4oqMKI3tLpxk8JcRfJyS5cPjs0LR3EC9PaqDKOzAo8wWFaeHDM2Va1o6I
	NkB2Fqk1kAK4MRlxQDzsHNXBGqJ6KOtOzkZUsW2g/YzlFTRD7mBxhOWlCvQl1wbjG8grxC/zQ0l
	7xd5Y/+B3bmWfkI4b3ojAfWweVQ56nDhYi1CH7dj5C0UqwFoELIvMva6NqDdF4V5gQyNMZNKFCI
	ojIusj25Vq54V5s988J4BA/sbGtlIB1HQsVL4/4M7TxbTQAupxYxlrQzNu0/EKZV31FR
X-Received: by 2002:a17:90b:1fce:b0:312:e731:5a6b with SMTP id 98e67ed59e1d1-315f269fa68mr4355055a91.32.1750866727506;
        Wed, 25 Jun 2025 08:52:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGglaSDui+roskZocwG9xuSyfP0Kpa0z0xiQ8gfEl8NwUolpzM/PIXW3EJfCfspj5HFPWW0bw==
X-Received: by 2002:a17:90b:1fce:b0:312:e731:5a6b with SMTP id 98e67ed59e1d1-315f269fa68mr4355024a91.32.1750866727029;
        Wed, 25 Jun 2025 08:52:07 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f53ea827sm2146576a91.41.2025.06.25.08.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 08:52:05 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c649c8ec-6c1b-41a3-90c5-43c0feed7803@redhat.com>
Date: Wed, 25 Jun 2025 11:52:04 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] Introduce simple hazard pointers
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, lkmm@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Breno Leitao <leitao@debian.org>, aeh@meta.com, netdev@vger.kernel.org,
 edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
 Erik Lundgren <elundgren@meta.com>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-2-boqun.feng@gmail.com>
Content-Language: en-US
In-Reply-To: <20250625031101.12555-2-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/24/25 11:10 PM, Boqun Feng wrote:
> As its name suggests, simple hazard pointers (shazptr) is a
> simplification of hazard pointers [1]: it has only one hazard pointer
> slot per-CPU and is targeted for simple use cases where the read-side
> already has preemption disabled. It's a trade-off between full features
> of a normal hazard pointer implementation (multiple slots, dynamic slot
> allocation, etc.) and the simple use scenario.
>
> Since there's only one slot per-CPU, so shazptr read-side critical
> section nesting is a problem that needs to be resolved, because at very
> least, interrupts and NMI can introduce nested shazptr read-side
> critical sections. A SHAZPTR_WILDCARD is introduced to resolve this:
> SHAZPTR_WILDCARD is a special address value that blocks *all* shazptr
> waiters. In an interrupt-causing shazptr read-side critical section
> nesting case (i.e. an interrupt happens while the per-CPU hazard pointer
> slot being used and tries to acquire a hazard pointer itself), the inner
> critical section will switch the value of the hazard pointer slot into
> SHAZPTR_WILDCARD, and let the outer critical section eventually zero the
> slot. The SHAZPTR_WILDCARD still provide the correct protection because
> it blocks all the waiters.
>
> It's true that once the wildcard mechanism is activated, shazptr
> mechanism may be downgrade to something similar to RCU (and probably
> with a worse implementation), which generally has longer wait time and
> larger memory footprint compared to a typical hazard pointer
> implementation. However, that can only happen with a lot of users using
> hazard pointers, and then it's reasonable to introduce the
> fully-featured hazard pointer implementation [2] and switch users to it.
>
> Note that shazptr_protect() may be added later, the current potential
> usage doesn't require it, and a shazptr_acquire(), which installs the
> protected value to hazard pointer slot and proves the smp_mb(), is
> enough for now.
>
> [1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
>       lock-free objects," in IEEE Transactions on Parallel and
>       Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
>
> Link: https://lore.kernel.org/lkml/20240917143402.930114-1-boqun.feng@gmail.com/ [2]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>   include/linux/shazptr.h  | 73 ++++++++++++++++++++++++++++++++++++++++
>   kernel/locking/Makefile  |  2 +-
>   kernel/locking/shazptr.c | 29 ++++++++++++++++
>   3 files changed, 103 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/shazptr.h
>   create mode 100644 kernel/locking/shazptr.c
>
> diff --git a/include/linux/shazptr.h b/include/linux/shazptr.h
> new file mode 100644
> index 000000000000..287cd04b4be9
> --- /dev/null
> +++ b/include/linux/shazptr.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Simple hazard pointers
> + *
> + * Copyright (c) 2025, Microsoft Corporation.
> + *
> + * Author: Boqun Feng <boqun.feng@gmail.com>
> + *
> + * A simple variant of hazard pointers, the users must ensure the preemption
> + * is already disabled when calling a shazptr_acquire() to protect an address.
> + * If one shazptr_acquire() is called after another shazptr_acquire() has been
> + * called without the corresponding shazptr_clear() has been called, the later
> + * shazptr_acquire() must be cleared first.
> + *
> + * The most suitable usage is when only one address need to be protected in a
> + * preemption disabled critical section.
> + */
> +
> +#ifndef _LINUX_SHAZPTR_H
> +#define _LINUX_SHAZPTR_H
> +
> +#include <linux/cleanup.h>
> +#include <linux/percpu.h>
> +
> +/* Make ULONG_MAX the wildcard value */
> +#define SHAZPTR_WILDCARD ((void *)(ULONG_MAX))
> +
> +DECLARE_PER_CPU_SHARED_ALIGNED(void *, shazptr_slots);
> +
> +/* Represent a held hazard pointer slot */
> +struct shazptr_guard {
> +	void **slot;
> +	bool use_wildcard;
> +};
> +
> +/*
> + * Acquire a hazptr slot and begin the hazard pointer critical section.
> + *
> + * Must be called with preemption disabled, and preemption must remain disabled
> + * until shazptr_clear().
> + */
> +static inline struct shazptr_guard shazptr_acquire(void *ptr)
> +{
> +	struct shazptr_guard guard = {
> +		/* Preemption is disabled. */
> +		.slot = this_cpu_ptr(&shazptr_slots),
> +		.use_wildcard = false,
> +	};
> +
> +	if (likely(!READ_ONCE(*guard.slot))) {
> +		WRITE_ONCE(*guard.slot, ptr);
> +	} else {
> +		guard.use_wildcard = true;
> +		WRITE_ONCE(*guard.slot, SHAZPTR_WILDCARD);
> +	}
Is it correct to assume that shazptr cannot be used in a mixed context 
environment on the same CPU like a task context and an interrupt context 
trying to acquire it simultaneously because the current check isn't 
atomic with respect to that?
> +
> +	smp_mb(); /* Synchronize with smp_mb() at synchronize_shazptr(). */
> +
> +	return guard;
> +}
> +
> +static inline void shazptr_clear(struct shazptr_guard guard)
> +{
> +	/* Only clear the slot when the outermost guard is released */
> +	if (likely(!guard.use_wildcard))
> +		smp_store_release(guard.slot, NULL); /* Pair with ACQUIRE at synchronize_shazptr() */
> +}

Is it better to name it shazptr_release() to be conformant with our 
current locking convention?

Cheers,
Longman

