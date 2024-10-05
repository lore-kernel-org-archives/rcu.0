Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB8D1537C3;
	Sat,  5 Oct 2024 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144312; cv=none; b=TeeKQ59QrzCzUKdUChisXiKg5h3kKNMR7gO/6zcQKi0y731p0qIJ37shUqRivT6KCHt2iqCyGwdusVzTSEKv8hEXTlSfluaMBLmtJ7nZURzONrwI48mDm0v76bEIS1DYizlqq3PPkCMUbF34bGxaqo+a/Egqexu8QAciRcz46GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144312; c=relaxed/simple;
	bh=hgRbDOM9wLcgKCQw9mLkHdmH4m6NtTBcRJ8rOUMZrzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s46BMghkOCdX9TdpUhh5g0Jyo/AI3ww/K/HjaNKHXFLAxE/Ki+jBA17HNAUBP1kpAU2lI6aHTi/OjLiVOacYZsSZd79rlguDD59/juUcUGmdYqNUlOgMcN7mcijniBLTpvxLKhRk37x3hDoGNQCRrEw+NISkwBrMcFH6yDmZbKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JzVe3MKM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JzVe3MKM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4KIERTcyxCtPE+r337tQWEVOYM2iePWuMmqGmmdDWTE=; b=JzVe3MKMqi654mbCDMS0KxSxY1
	VonDI86HmKykf3DmK76Pe0GQNBehSTti2vjiznCSzTreUrG+0zxNVkM5WJtIB66E34dot/rBU48SQ
	5TU/I5DYFgTQpYGueBHjOISd9POuHLUV8179Ok2UZXmBDaLdt/ryqmGsMoXr3jQIjL4lHOJFFN1Nm
	DHIlTi6rak0xMX+lw8oUzR6QuMx0hf47h4ioXUi2d1OUMhmemWDOjYjPMPdQV9Gzfj0ETuQaG3lwY
	e7Ys8wxeuuoADEoe/qSY+sDPA3Nif4IlMo1NEEF62ArN/IXXL5mBUuFEwhpxaiapI2mkJcqWK3/+z
	6IRCnZXg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sx7Gv-0000000DAdH-0Xwy;
	Sat, 05 Oct 2024 16:04:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C8509300777; Sat,  5 Oct 2024 18:04:44 +0200 (CEST)
Date: Sat, 5 Oct 2024 18:04:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH v2 3/4] hp: Implement Hazard Pointers
Message-ID: <20241005160444.GA18071@noisy.programming.kicks-ass.net>
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
 <20241004182734.1761555-4-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004182734.1761555-4-mathieu.desnoyers@efficios.com>

On Fri, Oct 04, 2024 at 02:27:33PM -0400, Mathieu Desnoyers wrote:
>  include/linux/hp.h | 158 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/Makefile    |   2 +-
>  kernel/hp.c        |  46 +++++++++++++
>  3 files changed, 205 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/hp.h
>  create mode 100644 kernel/hp.c
> 
> diff --git a/include/linux/hp.h b/include/linux/hp.h
> new file mode 100644
> index 000000000000..e85fc4365ea2
> --- /dev/null
> +++ b/include/linux/hp.h
> @@ -0,0 +1,158 @@
> +// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> +//
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +
> +#ifndef _LINUX_HP_H
> +#define _LINUX_HP_H
> +
> +/*
> + * HP: Hazard Pointers
> + *
> + * This API provides existence guarantees of objects through hazard
> + * pointers.
> + *
> + * It uses a fixed number of hazard pointer slots (nr_cpus) across the
> + * entire system for each HP domain.
> + *
> + * Its main benefit over RCU is that it allows fast reclaim of
> + * HP-protected pointers without needing to wait for a grace period.
> + *
> + * It also allows the hazard pointer scan to call a user-defined callback
> + * to retire a hazard pointer slot immediately if needed. This callback
> + * may, for instance, issue an IPI to the relevant CPU.
> + *
> + * References:
> + *
> + * [1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
> + *      lock-free objects," in IEEE Transactions on Parallel and
> + *      Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
> + */
> +
> +#include <linux/rcupdate.h>
> +
> +/*
> + * Hazard pointer slot.
> + */
> +struct hp_slot {
> +	void *addr;
> +};
> +
> +/*
> + * Hazard pointer context, returned by hp_use().
> + */
> +struct hp_ctx {
> +	struct hp_slot *slot;
> +	void *addr;
> +};
> +
> +/*
> + * hp_scan: Scan hazard pointer domain for @addr.
> + *
> + * Scan hazard pointer domain for @addr.
> + * If @retire_cb is NULL, wait to observe that each slot contains a value
> + * that differs from @addr.
> + * If @retire_cb is non-NULL, invoke @callback for each slot containing
> + * @addr.
> + */
> +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
> +	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr));

struct hp_domain {
	struct hp_slot __percpu *slots
};

might clarify things a wee little.

> +
> +/* Get the hazard pointer context address (may be NULL). */
> +static inline
> +void *hp_ctx_addr(struct hp_ctx ctx)
> +{
> +	return ctx.addr;
> +}

From where I'm sitting this seems like superfluous fluff, what's wrong
with ctx.addr ?

> +/*
> + * hp_allocate: Allocate a hazard pointer.
> + *
> + * Allocate a hazard pointer slot for @addr. The object existence should
> + * be guaranteed by the caller. Expects to be called from preempt
> + * disable context.
> + *
> + * Returns a hazard pointer context.

So you made the WTF'o'meter crack, this here function does not allocate
nothing. Naming is bad. At best this is something like
try-set-hazard-pointer or somesuch.

> + */
> +static inline
> +struct hp_ctx hp_allocate(struct hp_slot __percpu *percpu_slots, void *addr)
> +{
> +	struct hp_slot *slot;
> +	struct hp_ctx ctx;
> +
> +	if (!addr)
> +		goto fail;
> +	slot = this_cpu_ptr(percpu_slots);
> +	/*
> +	 * A single hazard pointer slot per CPU is available currently.
> +	 * Other hazard pointer domains can eventually have a different
> +	 * configuration.
> +	 */
> +	if (READ_ONCE(slot->addr))
> +		goto fail;
> +	WRITE_ONCE(slot->addr, addr);	/* Store B */
> +	ctx.slot = slot;
> +	ctx.addr = addr;
> +	return ctx;
> +
> +fail:
> +	ctx.slot = NULL;
> +	ctx.addr = NULL;
> +	return ctx;
> +}
> +
> +/*
> + * hp_dereference_allocate: Dereference and allocate a hazard pointer.
> + *
> + * Returns a hazard pointer context. Expects to be called from preempt
> + * disable context.
> + */

More terrible naming. Same as above, but additionally, I would expect a
'dereference' to actually dereference the pointer and have a return
value of the dereferenced type.

This function seems to double check and update the hp_ctx thing. I'm not
at all sure yet wtf this is doing -- and the total lack of comments
aren't helping.

> +static inline
> +struct hp_ctx hp_dereference_allocate(struct hp_slot __percpu *percpu_slots, void * const * addr_p)
> +{
> +	void *addr, *addr2;
> +	struct hp_ctx ctx;
> +
> +	addr = READ_ONCE(*addr_p);
> +retry:
> +	ctx = hp_allocate(percpu_slots, addr);
> +	if (!hp_ctx_addr(ctx))
> +		goto fail;
> +	/* Memory ordering: Store B before Load A. */
> +	smp_mb();
> +	/*
> +	 * Use RCU dereference without lockdep checks, because
> +	 * lockdep is not aware of HP guarantees.
> +	 */
> +	addr2 = rcu_access_pointer(*addr_p);	/* Load A */
> +	/*
> +	 * If @addr_p content has changed since the first load,
> +	 * clear the hazard pointer and try again.
> +	 */
> +	if (!ptr_eq(addr2, addr)) {
> +		WRITE_ONCE(ctx.slot->addr, NULL);
> +		if (!addr2)
> +			goto fail;
> +		addr = addr2;
> +		goto retry;
> +	}
> +	/*
> +	 * Use addr2 loaded from rcu_access_pointer() to preserve
> +	 * address dependency ordering.
> +	 */
> +	ctx.addr = addr2;
> +	return ctx;
> +
> +fail:
> +	ctx.slot = NULL;
> +	ctx.addr = NULL;
> +	return ctx;
> +}
> +
> +/* Retire the hazard pointer in @ctx. */
> +static inline
> +void hp_retire(const struct hp_ctx ctx)
> +{
> +	smp_store_release(&ctx.slot->addr, NULL);
> +}
> +
> +#endif /* _LINUX_HP_H */
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 3c13240dfc9f..ec16de96fa80 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -7,7 +7,7 @@ obj-y     = fork.o exec_domain.o panic.o \
>  	    cpu.o exit.o softirq.o resource.o \
>  	    sysctl.o capability.o ptrace.o user.o \
>  	    signal.o sys.o umh.o workqueue.o pid.o task_work.o \
> -	    extable.o params.o \
> +	    extable.o params.o hp.o \
>  	    kthread.o sys_ni.o nsproxy.o \
>  	    notifier.o ksysfs.o cred.o reboot.o \
>  	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
> diff --git a/kernel/hp.c b/kernel/hp.c
> new file mode 100644
> index 000000000000..b2447bf15300
> --- /dev/null
> +++ b/kernel/hp.c
> @@ -0,0 +1,46 @@
> +// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> +//
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +
> +/*
> + * HP: Hazard Pointers
> + */
> +
> +#include <linux/hp.h>
> +#include <linux/percpu.h>
> +
> +/*
> + * hp_scan: Scan hazard pointer domain for @addr.
> + *
> + * Scan hazard pointer domain for @addr.
> + * If @retire_cb is non-NULL, invoke @callback for each slot containing
> + * @addr.
> + * Wait to observe that each slot contains a value that differs from
> + * @addr before returning.
> + */
> +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
> +	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr))
> +{
> +	int cpu;
> +
> +	/*
> +	 * Store A precedes hp_scan(): it unpublishes addr (sets it to
> +	 * NULL or to a different value), and thus hides it from hazard
> +	 * pointer readers.
> +	 */
> +
> +	if (!addr)
> +		return;
> +	/* Memory ordering: Store A before Load B. */
> +	smp_mb();
> +	/* Scan all CPUs slots. */
> +	for_each_possible_cpu(cpu) {
> +		struct hp_slot *slot = per_cpu_ptr(percpu_slots, cpu);
> +
> +		if (retire_cb && smp_load_acquire(&slot->addr) == addr)	/* Load B */
> +			retire_cb(cpu, slot, addr);

Is retirce_cb allowed to cmpxchg the thing?

> +		/* Busy-wait if node is found. */
> +		while ((smp_load_acquire(&slot->addr)) == addr)	/* Load B */
> +			cpu_relax();

This really should be using smp_cond_load_acquire()

> +	}
> +}
