Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB55D33D6FE
	for <rcu@vger.kernel.org>; Thu, 18 Dec 2025 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052926; cv=none; b=Vthubkn7KVcljtv2HhQNLeBjdZLTOlHdLrNb+U3tl4W+Hg4nGf04loxzIXtZ3hySISC8V/cLJSn7tfIAaRd9S8v5LYqvfxOINxMSXYaRYTnVtFwZHRxv70EqILvn7aFdNv4Z3JNjDhOaAApBuXQQH3Gg4MDuBazyq6cYiqlhIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052926; c=relaxed/simple;
	bh=OFB3gbABe1KlhZnviKU1jpiE1kE728pOWIC+ik+Bfs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJPhI15xz/yC31zvDpxDX/o6eZmCF1bpS0Eto3Q8vugTA9GlpuI2CxTT/QeHVRKHIqE99rpO/H1WtJsxHNz8YojCIq8zpC4knpDC2ETHsnRkkXDDPiK0teff7lqQ6l2OJBbhtiBepNB6FdX+WaHQbxu4N0+WHCjl9EMOJyBtDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8TtHSNv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8TtHSNv"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b2d6df99c5so154954685a.1
        for <rcu@vger.kernel.org>; Thu, 18 Dec 2025 02:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766052924; x=1766657724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJlukGe2XKQfRTopvmsYHxe3yWp3t9uPRnCG4ocU9Wc=;
        b=b8TtHSNvdyi7+p3Ka2NNtVLdcCeaendiKR+6YguEcStO7Z9lZ+fC2tYD3X+OaWoH2v
         3lXW4mHRuBFcXy1Krp7Uvf6QA4EMzEj87NEEESevJenqUi62I3sfXJv+Gwc+syueO3dy
         3Y1M/N3blSKoWzY+kOsalQ9JfjJoSXCdWqCYo2o2jNk35Vwe0QHyh5UzFtRwcTqlmwuc
         OBmJL3OhJMmm3hP9oE3xIjuf4HgRnod7yeUnEWFgj6GYaB0mcPO2qjPcqITrj7yPMw2j
         xEew27XN0XUPrHJZkp4Ixd8JeOUUxg6x/Fx9Pi/yBqm5906+z8oxdGmz+tTIGSVEpjQy
         0LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766052924; x=1766657724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJlukGe2XKQfRTopvmsYHxe3yWp3t9uPRnCG4ocU9Wc=;
        b=a/xis5F2EQSFpqL1CR8gTVdleYRlyXSGSh09hejbOqcGfgFquPI9lS2RM70CTJ5bwq
         GhrqbWQv0x7q4vpVhvjkOHU/nP3ZSTofw2De8RQUU8JxTYQ9my0A/IEkDUQuW8Lzjt/B
         HpvIWOCHjP8S5wMVn0Ff2KQjbvMbB28b1ZbLk7qIsNxZpL+7gIdbUZFluvB2Htj5358K
         2NOrO+4NtgdqsKjSGMliNHWt/mlkoAEuRdqF/vhdlQ0R0fI/Zy3aCg5q6LD8/Dabdb7k
         Zyr3F0y/HPjrjaWwmJNbaA1UN8+JoxswbRpuPWO4WjHfgOv/RIR7a8qGJE/y4gN82sAE
         IXBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmcINvDUbTYvvAltZ2pe1zrKmH28we/0/scprU/ZiwWnr02ZlE/Euuu8w36xqjHTnHAVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTRFs/O18O828Y6y0pG5fjuDsPbEYSFpWNGPwBsadjiMI3TeU7
	Xe5ISkbRfcKc/2jnNUH8usS7ScG2F30+sw7qQSjFGrVpKtPnSGLR59TzSe8xTUbkRkE=
X-Gm-Gg: AY/fxX5dpHnYFqLGOp+LfCanzETnPRY+Gfe2HeTnjdhGwfgpYRhN8aYHwg5kmBs2oa9
	Ud7Q7ITpJmqcZssB2THfLKRomOAU5tvm3G8LXw+0ClZbElFFUjHgTnBhKK11xjUUMX45eWhMKis
	UltIwDUIVAZChwTk8FySHZnGFsE36/h8RpeF8GIIpVjQ4jPI78VjenxEyRVhy4d+MwLMzlR4xuN
	8xcmMLywbAhwOOb20GUIEU1gaINb/bXfXshfF9yHOhyHEssgUgcsuYX8oqrnt8UlDYS5VKsGm/d
	7ne96h/qbqPvwlKt/3Ohj89VNVK/DgNizFEwBHayR8QpDmQRu9XSWHLZVL2bxcLNyRbZbk1xqLO
	/MeXIHzNGUqNHY2qhmGmoVNMyyU0cOS0EIvyvBFxSxIwk21wd1/PxQd/b77rnBRtGa84eZ3SV5j
	10XyDJWY5SBuxtCeDUp3j+HVrD5WA6J/JU9PGLvCvhRSbCEZN+Byhv3fqivE1CgoToMakVSAdTt
	a+J1vEZMVn7baU=
X-Google-Smtp-Source: AGHT+IH+TwsnAFhP1xQ+6J09p1YnquJxQF22NSdtr8d1wVnpvOYLPTtrp6BsTCMIvWuluMWUsctcHA==
X-Received: by 2002:a05:620a:454d:b0:8b8:7f8d:c33d with SMTP id af79cd13be357-8bee79e244fmr303524685a.45.1766047022651;
        Thu, 18 Dec 2025 00:37:02 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beeb5d5fb7sm128786985a.7.2025.12.18.00.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:37:02 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5FBEEF40068;
	Thu, 18 Dec 2025 03:37:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 18 Dec 2025 03:37:01 -0500
X-ME-Sender: <xms:Lb1DaeuxRH_5bPEcXeOn7DaCVUW1U0pAGUTwS0VKj1gCEZkZ6wurUg>
    <xme:Lb1DaQ-TjOZIozrgLukNb_thiqu0uQzXGBLB5Lp9rDvq7_5ruk1Y7hhhD8IieIt68
    8_-2rQPASmTVBW9XvvetqMz8vokMtwyn3zwCbGIr162dNpU2J5g>
X-ME-Received: <xmr:Lb1DaV0tQxRVC4p9LDovx9IzQtQSKy3UeToLuabGwIvov42tTET37kTjXTds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    feefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghthhhivghurdguvghsnh
    hohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehjohgvlhesjhhovghl
    fhgvrhhnrghnuggvshdrohhrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepghhrvghgkhhh
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghighgvrghshi
    eslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:Lb1DaWfGiBHAmTPYAevQ_wEFZMzzpe3ny5LHzAujMIFfpOjhO4w3Gg>
    <xmx:Lb1DaReFSi5kMZarEKuRO4VbN9q4bBzo-U6Ra1uquqvgF3y1UKzUWw>
    <xmx:Lb1Dac0PIZqbUws6P8df74Kbt5CuaCYOxhdt87ywXond2zyEitzjJw>
    <xmx:Lb1DaR56enoIcPkvmaTCGUaxmFxRR0KH9c28Hnemo5llICrfvWamzA>
    <xmx:Lb1DaTK_rJkYX-qFPNr4wvprOlNlu3LKtTQfZpL6DFMn9O-N2JshU6U5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 03:36:58 -0500 (EST)
Date: Thu, 18 Dec 2025 17:36:57 +0900
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,	linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,	rcu@vger.kernel.org,
 linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH v4 3/4] hazptr: Implement Hazard Pointers
Message-ID: <aUO9KRaP0FXpm_l9@tardis-2.local>
References: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
 <20251218014531.3793471-4-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218014531.3793471-4-mathieu.desnoyers@efficios.com>

On Wed, Dec 17, 2025 at 08:45:30PM -0500, Mathieu Desnoyers wrote:
[...]
> +static inline
> +struct hazptr_slot *hazptr_get_free_percpu_slot(void)
> +{
> +	struct hazptr_percpu_slots *percpu_slots = this_cpu_ptr(&hazptr_percpu_slots);
> +	unsigned int idx;
> +
> +	for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
> +		struct hazptr_slot *slot = &percpu_slots->slots[idx];
> +
> +		if (!READ_ONCE(slot->addr))
> +			return slot;
> +	}
> +	/* All slots are in use. */
> +	return NULL;
> +}
> +
> +static inline
> +bool hazptr_slot_is_backup(struct hazptr_ctx *ctx, struct hazptr_slot *slot)
> +{
> +	return slot == &ctx->backup_slot.slot;
> +}
> +
> +/*
> + * hazptr_acquire: Load pointer at address and protect with hazard pointer.
> + *
> + * Load @addr_p, and protect the loaded pointer with hazard pointer.
> + *
> + * Returns a non-NULL protected address if the loaded pointer is non-NULL.
> + * Returns NULL if the loaded pointer is NULL.
> + *
> + * On success the protected hazptr slot is stored in @ctx->slot.
> + */
> +static inline
> +void *hazptr_acquire(struct hazptr_ctx *ctx, void * const * addr_p)
> +{
> +	struct hazptr_slot *slot = NULL;
> +	void *addr, *addr2;
> +
> +	/*
> +	 * Load @addr_p to know which address should be protected.
> +	 */
> +	addr = READ_ONCE(*addr_p);
> +	for (;;) {
> +		if (!addr)
> +			return NULL;
> +		guard(preempt)();
> +		if (likely(!hazptr_slot_is_backup(ctx, slot))) {
> +			slot = hazptr_get_free_percpu_slot();

I need to continue share my concerns about this "allocating slot while
protecting" pattern. Here realistically, we will go over a few of the
per-CPU hazard pointer slots *every time* instead of directly using a
pre-allocated hazard pointer slot. Could you utilize this[1] to see a
comparison of the reader-side performance against RCU/SRCU?

> +			/*
> +			 * If all the per-CPU slots are already in use, fallback
> +			 * to the backup slot.
> +			 */
> +			if (unlikely(!slot))
> +				slot = hazptr_chain_backup_slot(ctx);
> +		}
> +		WRITE_ONCE(slot->addr, addr);	/* Store B */
> +
> +		/* Memory ordering: Store B before Load A. */
> +		smp_mb();
> +
> +		/*
> +		 * Re-load @addr_p after storing it to the hazard pointer slot.
> +		 */
> +		addr2 = READ_ONCE(*addr_p);	/* Load A */
> +		if (likely(ptr_eq(addr2, addr)))
> +			break;
> +		/*
> +		 * If @addr_p content has changed since the first load,
> +		 * release the hazard pointer and try again.
> +		 */
> +		WRITE_ONCE(slot->addr, NULL);
> +		if (!addr2) {
> +			if (hazptr_slot_is_backup(ctx, slot))
> +				hazptr_unchain_backup_slot(ctx);
> +			return NULL;
> +		}
> +		addr = addr2;
> +	}
> +	ctx->slot = slot;
> +	/*
> +	 * Use addr2 loaded from the second READ_ONCE() to preserve
> +	 * address dependency ordering.
> +	 */
> +	return addr2;
> +}
> +
> +/* Release the protected hazard pointer from @slot. */
> +static inline
> +void hazptr_release(struct hazptr_ctx *ctx, void *addr)
> +{
> +	struct hazptr_slot *slot;
> +
> +	if (!addr)
> +		return;
> +	slot = ctx->slot;
> +	WARN_ON_ONCE(slot->addr != addr);
> +	smp_store_release(&slot->addr, NULL);
> +	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
> +		hazptr_unchain_backup_slot(ctx);
> +}
> +
> +void hazptr_init(void);
> +
> +#endif /* _LINUX_HAZPTR_H */
> diff --git a/init/main.c b/init/main.c
> index 07a3116811c5..858eaa87bde7 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -104,6 +104,7 @@
>  #include <linux/pidfs.h>
>  #include <linux/ptdump.h>
>  #include <linux/time_namespace.h>
> +#include <linux/hazptr.h>
>  #include <net/net_namespace.h>
>  
>  #include <asm/io.h>
> @@ -1002,6 +1003,7 @@ void start_kernel(void)
>  	workqueue_init_early();
>  
>  	rcu_init();
> +	hazptr_init();
>  	kvfree_rcu_init();
>  
>  	/* Trace events are available after this */
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 9fe722305c9b..1178907fe0ea 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -7,7 +7,7 @@ obj-y     = fork.o exec_domain.o panic.o \
>  	    cpu.o exit.o softirq.o resource.o \
>  	    sysctl.o capability.o ptrace.o user.o \
>  	    signal.o sys.o umh.o workqueue.o pid.o task_work.o \
> -	    extable.o params.o \
> +	    extable.o params.o hazptr.o \
>  	    kthread.o sys_ni.o nsproxy.o nstree.o nscommon.o \
>  	    notifier.o ksysfs.o cred.o reboot.o \
>  	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> new file mode 100644
> index 000000000000..2ec288bc1132
> --- /dev/null
> +++ b/kernel/hazptr.c
> @@ -0,0 +1,150 @@
> +// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> +//
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +
> +/*
> + * hazptr: Hazard Pointers
> + */
> +
> +#include <linux/hazptr.h>
> +#include <linux/percpu.h>
> +#include <linux/spinlock.h>
> +#include <linux/list.h>
> +#include <linux/export.h>
> +
> +struct overflow_list {
> +	raw_spinlock_t lock;		/* Lock protecting overflow list and list generation. */
> +	struct list_head head;		/* Overflow list head. */
> +	uint64_t gen;			/* Overflow list generation. */
> +};
> +
> +static DEFINE_PER_CPU(struct overflow_list, percpu_overflow_list);
> +
> +DEFINE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
> +EXPORT_PER_CPU_SYMBOL_GPL(hazptr_percpu_slots);
> +
> +/*
> + * Perform piecewise iteration on overflow list waiting until "addr" is
> + * not present. Raw spinlock is released and taken between each list
> + * item and busy loop iteration. The overflow list generation is checked
> + * each time the lock is taken to validate that the list has not changed
> + * before resuming iteration or busy wait. If the generation has
> + * changed, retry the entire list traversal.
> + */
> +static
> +void hazptr_synchronize_overflow_list(struct overflow_list *overflow_list, void *addr)
> +{
> +	struct hazptr_backup_slot *backup_slot;
> +	uint64_t snapshot_gen;
> +
> +	raw_spin_lock(&overflow_list->lock);
> +retry:
> +	snapshot_gen = overflow_list->gen;
> +	list_for_each_entry(backup_slot, &overflow_list->head, node) {
> +		/* Busy-wait if node is found. */
> +		while (smp_load_acquire(&backup_slot->slot.addr) == addr) { /* Load B */
> +			raw_spin_unlock(&overflow_list->lock);
> +			cpu_relax();

I think we should prioritize the scan thread solution [2] instead of
busy waiting hazrd pointer updaters, because when we have multiple
hazard pointer usages we would want to consolidate the scans from
updater side. If so, the whole ->gen can be avoided.

However this ->gen idea does seem ot resolve another issue for me, I'm
trying to make shazptr critical section preemptive by using a per-task
backup slot (if you recall, this is your idea from the hallway
discussions we had during LPC 2024), and currently I could not make it
work because the following sequeue:

1. CPU 0 already has one pointer protected.

2. CPU 1 begins the updater scan, and it scans the list of preempted
   hazard pointer readers, no reader.

3. CPU 0 does a context switch, it stores the current hazard pointer
   value to the current task's ->hazard_slot (let's say the task is task
   A), and add it to the list of preempted hazard pointer readers.

4. CPU 0 clears its percpu hazptr_slots for the next task (B).

5. CPU 1 continues the updater scan, and it scans the percpu slot of
   CPU 0, and finds no reader.

in this situation, updater will miss a reader. But if we add a
generation snapshotting at step 2 and generation increment at step 3, I
think it'll work.

IMO, if we make this work, it's better than the current backup slot
mechanism IMO, because we only need to acquire the lock if context
switch happens. I will look into the implementation of this and if I
could get it down, I will send it in my next version of shazptr. Mention
it here just to add this option into the discussion.

[1]: https://lore.kernel.org/lkml/20250625031101.12555-3-boqun.feng@gmail.com/
[2]: https://lore.kernel.org/lkml/20250625031101.12555-5-boqun.feng@gmail.com/

Regards,
Boqun

> +			raw_spin_lock(&overflow_list->lock);
> +			if (overflow_list->gen != snapshot_gen)
> +				goto retry;
> +		}
> +		raw_spin_unlock(&overflow_list->lock);
> +		/*
> +		 * Release raw spinlock, validate generation after
> +		 * re-acquiring the lock.
> +		 */
> +		raw_spin_lock(&overflow_list->lock);
> +		if (overflow_list->gen != snapshot_gen)
> +			goto retry;
> +	}
> +	raw_spin_unlock(&overflow_list->lock);
> +}
> +
> +static
> +void hazptr_synchronize_cpu_slots(int cpu, void *addr)
> +{
> +	struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
> +	unsigned int idx;
> +
> +	for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
> +		struct hazptr_slot *slot = &percpu_slots->slots[idx];
> +
> +		/* Busy-wait if node is found. */
> +		smp_cond_load_acquire(&slot->addr, VAL != addr); /* Load B */
> +	}
> +}
> +
> +/*
> + * hazptr_synchronize: Wait until @addr is released from all slots.
> + *
> + * Wait to observe that each slot contains a value that differs from
> + * @addr before returning.
> + * Should be called from preemptible context.
> + */
> +void hazptr_synchronize(void *addr)
> +{
> +	int cpu;
> +
> +	/*
> +	 * Busy-wait should only be done from preemptible context.
> +	 */
> +	lockdep_assert_preemption_enabled();
> +
> +	/*
> +	 * Store A precedes hazptr_scan(): it unpublishes addr (sets it to
> +	 * NULL or to a different value), and thus hides it from hazard
> +	 * pointer readers.
> +	 */
> +	if (!addr)
> +		return;
> +	/* Memory ordering: Store A before Load B. */
> +	smp_mb();
> +	/* Scan all CPUs slots. */
> +	for_each_possible_cpu(cpu) {
> +		/* Scan CPU slots. */
> +		hazptr_synchronize_cpu_slots(cpu, addr);
> +		/* Scan backup slots in percpu overflow list. */
> +		hazptr_synchronize_overflow_list(per_cpu_ptr(&percpu_overflow_list, cpu), addr);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(hazptr_synchronize);
> +
> +struct hazptr_slot *hazptr_chain_backup_slot(struct hazptr_ctx *ctx)
> +{
> +	struct overflow_list *overflow_list = this_cpu_ptr(&percpu_overflow_list);
> +	struct hazptr_slot *slot = &ctx->backup_slot.slot;
> +
> +	slot->addr = NULL;
> +
> +	raw_spin_lock(&overflow_list->lock);
> +	overflow_list->gen++;
> +	list_add(&ctx->backup_slot.node, &overflow_list->head);
> +	ctx->backup_slot.cpu = smp_processor_id();
> +	raw_spin_unlock(&overflow_list->lock);
> +	return slot;
> +}
> +EXPORT_SYMBOL_GPL(hazptr_chain_backup_slot);
> +
> +void hazptr_unchain_backup_slot(struct hazptr_ctx *ctx)
> +{
> +	struct overflow_list *overflow_list = per_cpu_ptr(&percpu_overflow_list, ctx->backup_slot.cpu);
> +
> +	raw_spin_lock(&overflow_list->lock);
> +	overflow_list->gen++;
> +	list_del(&ctx->backup_slot.node);
> +	raw_spin_unlock(&overflow_list->lock);
> +}
> +EXPORT_SYMBOL_GPL(hazptr_unchain_backup_slot);
> +
> +void __init hazptr_init(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct overflow_list *overflow_list = per_cpu_ptr(&percpu_overflow_list, cpu);
> +
> +		raw_spin_lock_init(&overflow_list->lock);
> +		INIT_LIST_HEAD(&overflow_list->head);
> +	}
> +}
> -- 
> 2.39.5
> 
