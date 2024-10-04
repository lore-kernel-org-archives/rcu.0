Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373AF1AE00C
	for <rcu@vger.kernel.org>; Fri,  4 Oct 2024 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077130; cv=none; b=ckrhcIjBggSEcHriVv+VLOWZPl2la8Vd7ebxsMsMPam/ncr++B0pFoJlvooyDcpyVlKo7Cep4vX5DddXmCIeU+SdpucUhE5NA0Np8TH78Pa6wWaFUvj/6Vv3y0GdXoBtMIAP82WoIQc32K3v66XbT+B0Q+/DnocS5V0tLEWuKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077130; c=relaxed/simple;
	bh=Ziga90Shw6sI45+PTOi83WCFwE/36Y7V8YZi0earsOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nReEfkZuLcPZHJqA48qTK0CtP6xNXUNkdaBA3TLX6HaTrxUVr0sMTb3MJdVXu/4xLwgX+mQmHG/48XbfdY0DjRnRBVez/RtL0ynRAkpeDdSFqbqfO5uo3cQCp4SWa+qwtsNeEObCPejbPlSqw5Jt2CUeBBrYUCM3WYw8GwGZV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=owVnIkNi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="owVnIkNi"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6c3f1939d12so21190197b3.2
        for <rcu@vger.kernel.org>; Fri, 04 Oct 2024 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1728077127; x=1728681927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VY/vX/bFOTh9W1p1r+rO5zOmUIuqL5TOWyGjCo/iVjE=;
        b=owVnIkNirx3QnG9s+XEfQBlOYSev38DyQa0KFlA3+MdVqoXzDkDdtAm1cE3dRFo2wI
         FvP+5lirLA7WAODq3Ng0VJWWmV/HKQkmVvttPWmGLvPpCAncA3LVMvXDnKEFFOwq98GN
         IwT7B6OMJiM0C8N93glqUyN+fyF8CVic6bZzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728077127; x=1728681927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VY/vX/bFOTh9W1p1r+rO5zOmUIuqL5TOWyGjCo/iVjE=;
        b=iro2Qw7D/HXP22WXFPDNWfiwn7p1JeYXzvvoOEKfhFBDm3y00ZIJiGA14K0wlg5awR
         EBXTwIeBhpaYJHQNfaEyTL5lIuMBp7fCYSG60MqLb4DlUDUgrcNiu1FMtsHHuC65amJN
         kzlGXsC5OOupDrng4Lz9UNukf0nrBnpASaDp/urDCbArp3fpf9Y/FVBDPOrtxOm9c5RS
         +HhAvEECzjk6qMoHLGiTqBgjaHB/Jopisgb37uQKNkacADKBlqQ0UAk630B6X6wpVag8
         +boVwWDkRe0qyx3JZORjAsPIVm3upun1VoAIr7BpbtLX0UTe+sv9U9ItLcs3NitW4Rmt
         pJkA==
X-Forwarded-Encrypted: i=1; AJvYcCXatFG/DJJ7lwrPgpEy+NjDgt5V0FVkk63PtJ8nhbZZwjAUVBJrpM/podDjvHXzWz9irZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAiY0Uq179IWi40iFY1BYxHqlxMLY6SmSY47fbwZdPZDpcrVb8
	7eaT5bLLJIz5hzjGuo4NXJYxqVtGy9Motwgbj5ULO8RggmRM9I5SkLM9z3YdGaS9hu/FOpyF6xi
	FsQZpFsHryQf9rzARtAypxze3L2gim1szWAhJ9Q==
X-Google-Smtp-Source: AGHT+IG4dzdT+dwrRjzLGqEwPGzxdMKAYORd4LvnKjT+a7MKxe5B6QDsfMA7Z11kuWZtJ2eoPYvrx9RSappLuXALV5Q=
X-Received: by 2002:a05:690c:6504:b0:6dd:76ce:d6c9 with SMTP id
 00721157ae682-6e2c72a0474mr43316727b3.42.1728077127177; Fri, 04 Oct 2024
 14:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com> <20241004182734.1761555-4-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241004182734.1761555-4-mathieu.desnoyers@efficios.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 4 Oct 2024 17:25:16 -0400
Message-ID: <CAEXW_YQfyPapBwSuqvFfs+XzSPaSCC3FDKsvb_Up+h-dnqgXeA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] hp: Implement Hazard Pointers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Will Deacon <will@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	John Stultz <jstultz@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik <mjguzik@gmail.com>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:29=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> This API provides existence guarantees of objects through Hazard
> Pointers (HP). This minimalist implementation is specific to use
> with preemption disabled, but can be extended further as needed.
>
> Each HP domain defines a fixed number of hazard pointer slots (nr_cpus)
> across the entire system.
>
> Its main benefit over RCU is that it allows fast reclaim of
> HP-protected pointers without needing to wait for a grace period.
>
> It also allows the hazard pointer scan to call a user-defined callback
> to retire a hazard pointer slot immediately if needed. This callback
> may, for instance, issue an IPI to the relevant CPU.
>
> There are a few possible use-cases for this in the Linux kernel:
>
>   - Improve performance of mm_count by replacing lazy active mm by HP.
>   - Guarantee object existence on pointer dereference to use refcount:
>     - replace locking used for that purpose in some drivers,
>     - replace RCU + inc_not_zero pattern,
>   - rtmutex: Improve situations where locks need to be taken in
>     reverse dependency chain order by guaranteeing existence of
>     first and second locks in traversal order, allowing them to be
>     locked in the correct order (which is reverse from traversal
>     order) rather than try-lock+retry on nested lock.
>
> References:
>
> [1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
>      lock-free objects," in IEEE Transactions on Parallel and
>      Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
[ ... ]
> ---
> Changes since v0:
> - Remove slot variable from hp_dereference_allocate().
> ---
>  include/linux/hp.h | 158 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/Makefile    |   2 +-
>  kernel/hp.c        |  46 +++++++++++++

Just a housekeeping comment, ISTR Linus looking down on adding bodies
of C code to header files (like hp_dereference_allocate). I understand
maybe the rationale is that the functions included are inlined. But do
all of them have to be inlined? Such headers also hurt code browsing
capabilities in code browsers like clangd. clangd doesn't understand
header files because it can't independently compile them -- it uses
the compiler to generate and extract the AST for superior code
browsing/completion.

Also have you looked at the benefits of inlining for hp.h?
hp_dereference_allocate() seems large enough that inlining may not
matter much, but I haven't compiled it and looked at the asm myself.

Will continue staring at the code.

thanks,

  - Joel


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
> +// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@eff=
icios.com>
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
> + * It also allows the hazard pointer scan to call a user-defined callbac=
k
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
> +       void *addr;
> +};
> +
> +/*
> + * Hazard pointer context, returned by hp_use().
> + */
> +struct hp_ctx {
> +       struct hp_slot *slot;
> +       void *addr;
> +};
> +
> +/*
> + * hp_scan: Scan hazard pointer domain for @addr.
> + *
> + * Scan hazard pointer domain for @addr.
> + * If @retire_cb is NULL, wait to observe that each slot contains a valu=
e
> + * that differs from @addr.
> + * If @retire_cb is non-NULL, invoke @callback for each slot containing
> + * @addr.
> + */
> +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
> +            void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr)=
);
> +
> +/* Get the hazard pointer context address (may be NULL). */
> +static inline
> +void *hp_ctx_addr(struct hp_ctx ctx)
> +{
> +       return ctx.addr;
> +}
> +
> +/*
> + * hp_allocate: Allocate a hazard pointer.
> + *
> + * Allocate a hazard pointer slot for @addr. The object existence should
> + * be guaranteed by the caller. Expects to be called from preempt
> + * disable context.
> + *
> + * Returns a hazard pointer context.
> + */
> +static inline
> +struct hp_ctx hp_allocate(struct hp_slot __percpu *percpu_slots, void *a=
ddr)
> +{
> +       struct hp_slot *slot;
> +       struct hp_ctx ctx;
> +
> +       if (!addr)
> +               goto fail;
> +       slot =3D this_cpu_ptr(percpu_slots);
> +       /*
> +        * A single hazard pointer slot per CPU is available currently.
> +        * Other hazard pointer domains can eventually have a different
> +        * configuration.
> +        */
> +       if (READ_ONCE(slot->addr))
> +               goto fail;
> +       WRITE_ONCE(slot->addr, addr);   /* Store B */
> +       ctx.slot =3D slot;
> +       ctx.addr =3D addr;
> +       return ctx;
> +
> +fail:
> +       ctx.slot =3D NULL;
> +       ctx.addr =3D NULL;
> +       return ctx;
> +}
> +
> +/*
> + * hp_dereference_allocate: Dereference and allocate a hazard pointer.
> + *
> + * Returns a hazard pointer context. Expects to be called from preempt
> + * disable context.
> + */
> +static inline
> +struct hp_ctx hp_dereference_allocate(struct hp_slot __percpu *percpu_sl=
ots, void * const * addr_p)
> +{
> +       void *addr, *addr2;
> +       struct hp_ctx ctx;
> +
> +       addr =3D READ_ONCE(*addr_p);
> +retry:
> +       ctx =3D hp_allocate(percpu_slots, addr);
> +       if (!hp_ctx_addr(ctx))
> +               goto fail;
> +       /* Memory ordering: Store B before Load A. */
> +       smp_mb();
> +       /*
> +        * Use RCU dereference without lockdep checks, because
> +        * lockdep is not aware of HP guarantees.
> +        */
> +       addr2 =3D rcu_access_pointer(*addr_p);    /* Load A */
> +       /*
> +        * If @addr_p content has changed since the first load,
> +        * clear the hazard pointer and try again.
> +        */
> +       if (!ptr_eq(addr2, addr)) {
> +               WRITE_ONCE(ctx.slot->addr, NULL);
> +               if (!addr2)
> +                       goto fail;
> +               addr =3D addr2;
> +               goto retry;
> +       }
> +       /*
> +        * Use addr2 loaded from rcu_access_pointer() to preserve
> +        * address dependency ordering.
> +        */
> +       ctx.addr =3D addr2;
> +       return ctx;
> +
> +fail:
> +       ctx.slot =3D NULL;
> +       ctx.addr =3D NULL;
> +       return ctx;
> +}
> +
> +/* Retire the hazard pointer in @ctx. */
> +static inline
> +void hp_retire(const struct hp_ctx ctx)
> +{
> +       smp_store_release(&ctx.slot->addr, NULL);
> +}
> +
> +#endif /* _LINUX_HP_H */
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 3c13240dfc9f..ec16de96fa80 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -7,7 +7,7 @@ obj-y     =3D fork.o exec_domain.o panic.o \
>             cpu.o exit.o softirq.o resource.o \
>             sysctl.o capability.o ptrace.o user.o \
>             signal.o sys.o umh.o workqueue.o pid.o task_work.o \
> -           extable.o params.o \
> +           extable.o params.o hp.o \
>             kthread.o sys_ni.o nsproxy.o \
>             notifier.o ksysfs.o cred.o reboot.o \
>             async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
> diff --git a/kernel/hp.c b/kernel/hp.c
> new file mode 100644
> index 000000000000..b2447bf15300
> --- /dev/null
> +++ b/kernel/hp.c
> @@ -0,0 +1,46 @@
> +// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@eff=
icios.com>
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
> +            void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr)=
)
> +{
> +       int cpu;
> +
> +       /*
> +        * Store A precedes hp_scan(): it unpublishes addr (sets it to
> +        * NULL or to a different value), and thus hides it from hazard
> +        * pointer readers.
> +        */
> +
> +       if (!addr)
> +               return;
> +       /* Memory ordering: Store A before Load B. */
> +       smp_mb();
> +       /* Scan all CPUs slots. */
> +       for_each_possible_cpu(cpu) {
> +               struct hp_slot *slot =3D per_cpu_ptr(percpu_slots, cpu);
> +
> +               if (retire_cb && smp_load_acquire(&slot->addr) =3D=3D add=
r) /* Load B */
> +                       retire_cb(cpu, slot, addr);
> +               /* Busy-wait if node is found. */
> +               while ((smp_load_acquire(&slot->addr)) =3D=3D addr) /* Lo=
ad B */
> +                       cpu_relax();
> +       }
> +}
> --
> 2.39.2
>
