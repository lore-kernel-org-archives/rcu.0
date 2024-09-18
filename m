Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA102172BDE;
	Wed, 18 Sep 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672715; cv=none; b=JcrAqARY3YoaNnM4v1DxtGTkB7hFNGW6vqV7Ecc7c1NvsFPFWoamaYCf0qgx2l+g3FLWA7/eT2PaAa2Gua/zZUbymYq3QeNrNcQQkr3EeV956K5xu1SFQm2/vlSo3us8f9f/Vs5gU75opZKGitmAGyvxO9hoALay2WmydcP/oP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672715; c=relaxed/simple;
	bh=eiOVr1KjUZJfHIxTdoeTn3I0MLzAfIJhvC0GCaO5Gww=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p7gxPi+gw3zlCQ8Abpjp77JmujYL/kDeEXU4Ol/uOOXSmzIg2uqe26/SqSkKCLaLK/ANTh/qdtpz/RPs+YB6XhN+Ce/igYF7py+Xw/OVtFiTB0JuFKIp45IgseJRLeiWXwOHmmfcLxMSsCXA7jsfb//cUBBNJoqb4uppDkM+54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgESlKeM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgESlKeM"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc47abc040so55347985ad.0;
        Wed, 18 Sep 2024 08:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726672713; x=1727277513; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqgA+sTRNKFt7kJwz2AYQsR+DV2hOD5PAynK/E9kx9s=;
        b=NgESlKeMJ74uNTqn7hthDmmoOo1bDLo+7UZpEwbkbo6Mw95e33bm74Pqc4JmINwlJJ
         Dk/02k+ptSlJGcCanHixMfRm/oWfVpYRxDk74BErWXHZP5OjA8LCOBuht/wzaeocV4F6
         tuRVUFyYmhDhrvC8K7qo4WPQ8pOXdvSlQrXkJTIJSnbZplCbLFYP6nwxuj3+4byS0lMt
         2iPdjgbND7tIdnA9ReSFeKUwv+yOHjUWZy3F0RDfRHeMNIYoolscj6X2Y1yEuO5/SMbD
         kkipJGwo3vz23uv+RTEpAK6gdqo0Wni/zqe7I40C8R1S5Yfep5GT9W8ubekNgXqKWp4j
         HIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726672713; x=1727277513;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqgA+sTRNKFt7kJwz2AYQsR+DV2hOD5PAynK/E9kx9s=;
        b=btS48CUlcir7GUF6lJC3Rl+UdOcgTi6M27lglDB2Mq+07uq185+NMNKqlD9Zgam0EE
         a2EtY6bZSGbIptAM7iVBL9DUQrMd+1KckXOxvPWB4kHDXyjAyNs8j6p2251j+hWXzYch
         hM5Q2nlBwOTiYTx5tQwZU/japhJ7vSz85buLiRNdLFdzvN7ukIOW4NEJQCfelTFWvk8C
         TTEZaFb4GmjS1WCqFPcg0nGh8dqn/4Z4UfQgbPsJyEIxfctms39v4qY4cFa/N+P49stj
         /R5yZ2q1tZckjyDfQDMZZETEHkjKOanB0w4J3Le3jUhN+0PQBs6+Y+4vvReE5s2aB7qK
         hG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAarSYFLN+9JJFCcQC+EMLlgK1jnzfzBoe7T2y/8EU9IB6jpiGsRz94CgToTotodDLWo5Z@vger.kernel.org, AJvYcCUTP9Ww5S344ibXIi4mMM1Beg6z8LaSU7F43zQZiYu8zDHiFzNlUqF5VcleOjiJ4Bn3OtCF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cRIz62vPxu0hh4s9pFddz8krjCxnnH5+KQX7nmgwNfcreF0q
	7AS5JzOJAp+7pjd4sJgSQ83TIVMLt+5Sj+/d48B4xtF4kb4/nNNP
X-Google-Smtp-Source: AGHT+IExl19k8pFIgXKd5vFT9x957NhrrTdGitsfPnSJ2V1z0Qf4GTGKvQbqdZwBteVLH7XjPZz2Kg==
X-Received: by 2002:a17:902:ea01:b0:207:db0:cb6c with SMTP id d9443c01a7336-2076e3aec92mr301426455ad.34.1726672712777;
        Wed, 18 Sep 2024 08:18:32 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079460102dsm66356665ad.80.2024.09.18.08.18.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2024 08:18:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20240917143402.930114-2-boqun.feng@gmail.com>
Date: Wed, 18 Sep 2024 23:17:37 +0800
Cc: LKML <linux-kernel@vger.kernel.org>,
 RCU <rcu@vger.kernel.org>,
 linux-mm@kvack.org,
 lkmm@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,
 Neeraj upadhyay <neeraj.upadhyay@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA757E86-2AE4-4077-A07A-679E3BFDBC34@gmail.com>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)

2024=E5=B9=B49=E6=9C=8817=E6=97=A5 22:33=EF=BC=8CBoqun Feng =
<boqun.feng@gmail.com> wrote=EF=BC=9A
>=20
> Hazard pointers [1] provide a way to dynamically distribute =
refcounting
> and can be used to improve the scalability of refcounting without
> significant space cost.
>=20
> Hazard pointers are similar to RCU: they build the synchronization
> between two part, readers and updaters. Readers are refcount users, =
they
> acquire and release refcount. Updaters cleanup objects when there are =
no
> reader referencing them (via call_hazptr()). The difference is instead
> of waiting for a grace period, hazard pointers can free an object as
> long as there is no one referencing the object. This means for a
> particular workload, hazard pointers may have smaller memory footprint
> due to fewer pending callbacks.
>=20
> The synchronization between readers and updaters is built around =
"hazard
> pointer slots": a slot readers can use to store a pointer value.
>=20
> Reader side protection:
>=20
> 1. Read the value of a pointer to the target data element.
> 2. Store it to a hazard pointer slot.
> 3. Enforce full ordering (e.g. smp_mb()).
> 4. Re-read the original pointer, reset the slot and retry if the
> value changed.
> 5. Otherwise, the continued existence of the target data element
> is guaranteed.
>=20
> Updater side check:
>=20
> 1. Unpublish the target data element (e.g. setting the pointer
> value to NULL).
> 2. Enforce full ordering.
> 3. Read the value from a hazard pointer slot.
> 4. If the value doesn't match the target data element, then this
> slot doesn't represent a reference to it.
> 5. Otherwise, updater needs to re-check (step 3).
>=20
> To distribute the accesses of hazptr slots from different contexts,
> hazptr_context is introduced. Users need to define/allocate their own
> hazptr_context to allocate hazard pointer slots.
>=20
> For the updater side to confirm no existing reference, it needs to =
scan
> all the possible slots, and to speed up this process, hazptr_context
> also contains an rbtree node for each slot so that updater can cache =
the
> reader-scan result in an rbtree. The rbtree nodes are pre-allocated in
> this way to prevent "allocate memory to free memory" in extreme cases.
>=20
> [1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
>     lock-free objects," in IEEE Transactions on Parallel and
>     Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
>=20
> Co-developed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Co-developed-by: Neeraj Upadhyay <neeraj.upadhyay@amd.com>
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@amd.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> include/linux/hazptr.h |  83 ++++++++
> kernel/Makefile        |   1 +
> kernel/hazptr.c        | 463 +++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 547 insertions(+)
> create mode 100644 include/linux/hazptr.h
> create mode 100644 kernel/hazptr.c
>=20
> diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
> new file mode 100644
> index 000000000000..4548ca8c75eb
> --- /dev/null
> +++ b/include/linux/hazptr.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_HAZPTR_H
> +#define _LINUX_HAZPTR_H
> +
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/rbtree.h>
> +
> +/* Hazard pointer slot. */
> +typedef void* hazptr_t;
> +
> +#define HAZPTR_SLOT_PER_CTX 8
> +
> +struct hazptr_slot_snap {
> + struct rb_node node;
> + hazptr_t slot;
> +};
> +
> +/*
> + * A set of hazard pointer slots for a context.
> + *
> + * The context can be a task, CPU or reader (depends on the use =
case). It may
> + * be allocated statically or dynamically. It can only be used after =
calling
> + * init_hazptr_context(), and users are also responsible to call
> + * cleaup_hazptr_context() when it's not used any more.
> + */
> +struct hazptr_context {
> + // The lock of the percpu context lists.
> + spinlock_t *lock;
> +
> + struct list_head list;
> + struct hazptr_slot_snap snaps[HAZPTR_SLOT_PER_CTX];
> + ____cacheline_aligned hazptr_t slots[HAZPTR_SLOT_PER_CTX];
> +};
> +
> +void init_hazptr_context(struct hazptr_context *hzcp);
> +void cleanup_hazptr_context(struct hazptr_context *hzcp);
> +hazptr_t *hazptr_alloc(struct hazptr_context *hzcp);
> +void hazptr_free(struct hazptr_context *hzcp, hazptr_t *hzp);
> +
> +#define hazptr_tryprotect(hzp, gp, field) =
(typeof(gp))__hazptr_tryprotect(hzp, (void **)&(gp), =
offsetof(typeof(*gp), field))
> +#define hazptr_protect(hzp, gp, field) ({ \
> + typeof(gp) ___p; \
> + \
> + ___p =3D hazptr_tryprotect(hzp, gp, field); \
> + BUG_ON(!___p); \

hazptr_tryprotect might return NULL, do you need a loop here?

> + ___p; \
> +})
> +
> +static inline void *__hazptr_tryprotect(hazptr_t *hzp,
> + void *const *p,
> + unsigned long head_offset)
> +{
> + void *ptr;
> + struct callback_head *head;
> +
> + ptr =3D READ_ONCE(*p);
> +
> + if (ptr =3D=3D NULL)
> + return NULL;
> +
> + head =3D (struct callback_head *)(ptr + head_offset);
> +
> + WRITE_ONCE(*hzp, head);
> + smp_mb();
> +
> + ptr =3D READ_ONCE(*p); // read again
> +
> + if (ptr + head_offset !=3D head) { // pointer changed
> + WRITE_ONCE(*hzp, NULL);  // reset hazard pointer
> + return NULL;
> + } else
> + return ptr;
> +}
> +
> +static inline void hazptr_clear(hazptr_t *hzp)
> +{
> + /* Pairs with smp_load_acquire() in reader scan. */
> + smp_store_release(hzp, NULL);
> +}
> +
> +void call_hazptr(struct callback_head *head, rcu_callback_t func);
> +#endif
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 3c13240dfc9f..7927264b9870 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -50,6 +50,7 @@ obj-y +=3D rcu/
> obj-y +=3D livepatch/
> obj-y +=3D dma/
> obj-y +=3D entry/
> +obj-y +=3D hazptr.o
> obj-$(CONFIG_MODULES) +=3D module/
>=20
> obj-$(CONFIG_KCMP) +=3D kcmp.o
> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> new file mode 100644
> index 000000000000..f22ccc2a4a62
> --- /dev/null
> +++ b/kernel/hazptr.c
> @@ -0,0 +1,463 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/spinlock.h>
> +#include <linux/cleanup.h>
> +#include <linux/hazptr.h>
> +#include <linux/percpu.h>
> +#include <linux/workqueue.h>
> +
> +#define HAZPTR_UNUSED (1ul)
> +
> +/* Per-CPU data for hazard pointer management. */
> +struct hazptr_percpu {
> + spinlock_t ctx_lock; /* hazptr context list lock */
> + struct list_head ctx_list; /* hazptr context list */
> + spinlock_t callback_lock; /* Per-CPU callback queue lock */
> + struct callback_head *queued; /* Per-CPU callback queue */
> + struct callback_head **tail;
> +};
> +
> +/*
> + * Per-CPU data contains context lists and callbacks, which are =
maintained in a
> + * per-CPU maner to reduce potential contention. This means a global =
scan (for
> + * readers or callbacks) has to take each CPU's lock, but it's less =
problematic
> + * because that's a slowpath.
> + */
> +DEFINE_PER_CPU(struct hazptr_percpu, hzpcpu);
> +
> +/* A RBTree that stores the reader scan result of all hazptr slot */
> +struct hazptr_reader_tree {
> + spinlock_t lock;
> + struct rb_root root;
> +};
> +
> +static void init_hazptr_reader_tree(struct hazptr_reader_tree *tree)
> +{
> + spin_lock_init(&tree->lock);
> + tree->root =3D RB_ROOT;
> +}
> +
> +static bool is_null_or_unused(hazptr_t slot)
> +{
> + return slot =3D=3D NULL || ((unsigned long)slot) =3D=3D =
HAZPTR_UNUSED;
> +}
> +
> +static int hazptr_node_cmp(const void *key, const struct rb_node =
*curr)
> +{
> + unsigned long slot =3D (unsigned long)key;
> + struct hazptr_slot_snap *curr_snap =3D container_of(curr, struct =
hazptr_slot_snap, node);
> + unsigned long curr_slot =3D (unsigned long)(curr_snap->slot);
> +
> + if (slot < curr_slot)
> + return -1;
> + else if (slot > curr_slot)
> + return 1;
> + else
> + return 0;
> +}
> +
> +static bool hazptr_node_less(struct rb_node *new, const struct =
rb_node *curr)
> +{
> + struct hazptr_slot_snap *new_snap =3D container_of(new, struct =
hazptr_slot_snap, node);
> +
> + return hazptr_node_cmp((void *)new_snap->slot, curr) < 0;
> +}
> +
> +/* Add the snapshot into a search tree. tree->lock must be held. */
> +static inline void reader_add_locked(struct hazptr_reader_tree *tree,
> +     struct hazptr_slot_snap *snap)
> +{
> + lockdep_assert_held(&tree->lock);
> + BUG_ON(is_null_or_unused(snap->slot));
> +
> + rb_add(&snap->node, &tree->root, hazptr_node_less);
> +}
> +
> +static inline void reader_add(struct hazptr_reader_tree *tree,
> +      struct hazptr_slot_snap *snap)
> +{
> + guard(spinlock_irqsave)(&tree->lock);
> +
> + reader_add_locked(tree, snap);
> +}
> +
> +/* Delete the snapshot from a search tree. tree->lock must be held. =
*/
> +static inline void reader_del_locked(struct hazptr_reader_tree *tree,
> +     struct hazptr_slot_snap *snap)
> +{
> + lockdep_assert_held(&tree->lock);
> +
> + rb_erase(&snap->node, &tree->root);
> +}
> +
> +static inline void reader_del(struct hazptr_reader_tree *tree,
> +      struct hazptr_slot_snap *snap)
> +{
> + guard(spinlock_irqsave)(&tree->lock);
> +
> + reader_del_locked(tree, snap);
> +}
> +
> +/* Find whether a read exists. tree->lock must be held. */
> +static inline bool reader_exist_locked(struct hazptr_reader_tree =
*tree,
> +       unsigned long slot)
> +{
> + lockdep_assert_held(&tree->lock);
> +
> + return !!rb_find((void *)slot, &tree->root, hazptr_node_cmp);
> +}
> +
> +static inline bool reader_exist(struct hazptr_reader_tree *tree,
> + unsigned long slot)
> +{
> + guard(spinlock_irqsave)(&tree->lock);
> +
> + return reader_exist_locked(tree, slot);
> +}
> +
> +/*
> + * Scan the readers from one hazptr context and update the global =
readers tree.
> + *
> + * Must be called with hzcp->lock held.
> + */
> +static void hazptr_context_snap_readers_locked(struct =
hazptr_reader_tree *tree,
> +       struct hazptr_context *hzcp)
> +{
> + lockdep_assert_held(hzcp->lock);
> +
> + for (int i =3D 0; i < HAZPTR_SLOT_PER_CTX; i++) {
> + /*
> + * Pairs with smp_store_release() in hazptr_{clear,free}().
> + *
> + * Ensure
> + *
> + * <reader> <updater>
> + *
> + * [access protected pointers]
> + * hazptr_clear();
> + *   smp_store_release()
> + * // in reader scan.
> + * smp_load_acquire(); // is null or unused.
> + * [run callbacks] // all accesses from
> + * // reader must be
> + * // observed.
> + */
> + hazptr_t val =3D smp_load_acquire(&hzcp->slots[i]);
> +
> + if (!is_null_or_unused(val)) {
> + struct hazptr_slot_snap *snap =3D &hzcp->snaps[i];
> +
> + // Already in the tree, need to remove first.
> + if (!is_null_or_unused(snap->slot)) {
> + reader_del(tree, snap);
> + }
> + snap->slot =3D val;
> + reader_add(tree, snap);
> + }
> + }
> +}
> +
> +/*
> + * Initialize a hazptr context.
> + *
> + * Must be called before using the context for hazptr allocation.
> + */
> +void init_hazptr_context(struct hazptr_context *hzcp)
> +{
> + struct hazptr_percpu *pcpu =3D this_cpu_ptr(&hzpcpu);
> +
> + for (int i =3D 0; i < HAZPTR_SLOT_PER_CTX; i++) {
> + hzcp->slots[i] =3D (hazptr_t)HAZPTR_UNUSED;
> + hzcp->snaps[i].slot =3D (hazptr_t)HAZPTR_UNUSED;
> + }
> +
> + guard(spinlock_irqsave)(&pcpu->ctx_lock);
> + list_add(&hzcp->list, &pcpu->ctx_list);
> + hzcp->lock =3D &pcpu->ctx_lock;
> +}
> +
> +struct hazptr_struct {
> + struct work_struct work;
> + bool scheduled;
> +
> + // list of callbacks, we move percpu queued callbacks into the =
global
> + // queued list in workqueue function.
> + spinlock_t callback_lock;
> + struct callback_head *queued;
> + struct callback_head **tail;
> +
> + struct hazptr_reader_tree readers;
> +};
> +
> +static struct hazptr_struct hazptr_struct;
> +
> +/*
> + * Clean up hazptr context.
> + *
> + * Must call before freeing the context. This function also removes =
any
> + * reference held by the hazard pointer slots in the context, even
> + * hazptr_clear() or hazptr_free() is not called previously.
> + */
> +void cleanup_hazptr_context(struct hazptr_context *hzcp)
> +{
> + if (hzcp->lock) {
> + scoped_guard(spinlock_irqsave, hzcp->lock) {
> + list_del(&hzcp->list);
> + hzcp->lock =3D NULL;
> + }
> +
> + for (int i =3D 0; i < HAZPTR_SLOT_PER_CTX; i++) {
> + struct hazptr_slot_snap *snap =3D &hzcp->snaps[i];
> +
> + if (!is_null_or_unused(snap->slot))
> + reader_del(&hazptr_struct.readers, snap);
> + }
> + }
> +}
> +
> +/*
> + * Allocate a hazptr slot from a hazptr_context.
> + *
> + * Return: NULL means fail to allocate, otherwise the address of the =
allocated
> + * slot.
> + */
> +hazptr_t *hazptr_alloc(struct hazptr_context *hzcp)
> +{
> + unsigned long unused;
> +
> + for (int i =3D 0; i < HAZPTR_SLOT_PER_CTX; i++) {
> + if (((unsigned long)READ_ONCE(hzcp->slots[i])) =3D=3D HAZPTR_UNUSED) =
{
> + unused =3D HAZPTR_UNUSED;
> +
> + /*
> + * rwm-sequence is relied on here.
> + *
> + * This is needed since in case of a previous reader:
> + *
> + * <reader 1> <reader 2> <updater>
> + * [access protected pointers]
> + * hazptr_free():
> + *   smp_store_release(); // hzptr =3D=3D UNUSED
> + * hazptr_alloc():
> + *  try_cmpxchg_relaxed(); // hzptr =3D=3D NULL
> + *
> + * // in reader scan
> + * smp_load_acquire(); // is null
> + * [run callbacks]
> + *
> + * Because of the rwm-sequence of release operations,
> + * when callbacks are run, accesses from reader 1 must
> + * be already observed by the updater.
> + */
> + if (try_cmpxchg_relaxed(&hzcp->slots[i], &unused, NULL)) {
> + return (hazptr_t *)&hzcp->slots[i];
> + }
> + }
> + }
> +
> + return NULL;
> +}
> +
> +/* Free a hazptr slot. */
> +void hazptr_free(struct hazptr_context *hzcp, hazptr_t *hzptr)
> +{
> + WARN_ON(((unsigned long)*hzptr) =3D=3D HAZPTR_UNUSED);
> +
> + /* Pairs with smp_load_acquire() in reader scan */
> + smp_store_release(hzptr, (void *)HAZPTR_UNUSED);
> +}
> +
> +/* Scan all possible readers, and update the global reader tree. */
> +static void check_readers(struct hazptr_struct *hzst)
> +{
> + int cpu;
> +
> + for_each_possible_cpu(cpu) {
> + struct hazptr_percpu *pcpu =3D per_cpu_ptr(&hzpcpu, cpu);
> + struct hazptr_context *ctx;
> +
> + guard(spinlock_irqsave)(&pcpu->ctx_lock);
> + list_for_each_entry(ctx, &pcpu->ctx_list, list)
> + hazptr_context_snap_readers_locked(&hzst->readers, ctx);
> + }
> +}
> +
> +/*
> + * Start the background work for hazptr callback handling if not =
started.
> + *
> + * Must be called with hazptr_struct lock held.
> + */
> +static void kick_hazptr_work(void)
> +{
> + if (hazptr_struct.scheduled)
> + return;
> +
> + queue_work(system_wq, &hazptr_struct.work);
> + hazptr_struct.scheduled =3D true;
> +}
> +
> +/*
> + * Check which callbacks are ready to be called.
> + *
> + * Return: a callback list that no reader is referencing the =
corresponding
> + * objects.
> + */
> +static struct callback_head *do_hazptr(struct hazptr_struct *hzst)
> +{
> + struct callback_head *tmp, **curr;
> + struct callback_head *todo =3D NULL, **todo_tail =3D &todo;
> +
> + // Currently, the lock is unnecessary, but maybe we will have =
multiple
> + // work_structs sharing the same callback list in the future;
> + guard(spinlock_irqsave)(&hzst->callback_lock);
> +
> + curr =3D &hzst->queued;
> +
> + while ((tmp =3D *curr)) {
> + // No reader, we can free the object.
> + if (!reader_exist(&hzst->readers, (unsigned long)tmp)) {
> + // Add tmp into todo.
> + *todo_tail =3D tmp;
> + todo_tail =3D &tmp->next;
> +
> + // Delete tmp from ->queued and move to the next entry.
> + *curr =3D tmp->next;
> + } else
> + curr =3D &tmp->next;
> + }
> +
> + hzst->tail =3D curr;
> +
> + // Keep checking if callback list is not empty.
> + if (hzst->queued)
> + kick_hazptr_work();
> +
> + *todo_tail =3D NULL;
> +
> + return todo;
> +}
> +
> +static void hazptr_work_func(struct work_struct *work)
> +{
> + struct hazptr_struct *hzst =3D container_of(work, struct =
hazptr_struct, work);
> + struct callback_head *todo;
> +
> + // Advance callbacks from hzpcpu to hzst
> + scoped_guard(spinlock_irqsave, &hzst->callback_lock) {
> + int cpu;
> +
> + hzst->scheduled =3D false;
> + for_each_possible_cpu(cpu) {
> + struct hazptr_percpu *pcpu =3D per_cpu_ptr(&hzpcpu, cpu);
> +
> + guard(spinlock)(&pcpu->callback_lock);
> +
> + if (pcpu->queued) {
> + *(hzst->tail) =3D pcpu->queued;
> + hzst->tail =3D pcpu->tail;
> + pcpu->queued =3D NULL;
> + pcpu->tail =3D &pcpu->queued;
> + }
> + }
> + }
> +
> + // Pairs with the smp_mb() on the reader side. This guarantees that =
if
> + // the hazptr work picked up the callback from an updater and the
> + // updater set the global pointer to NULL before enqueue the =
callback,
> + // the hazptr work must observe a reader that protects the hazptr =
before
> + // the updater.
> + //
> + // <reader> <updater> <hazptr work>
> + // ptr =3D READ_ONCE(gp);
> + // WRITE_ONCE(*hazptr, ptr);
> + // smp_mb(); // =3D> ->strong-fence
> + // tofree =3D gp;
> + // ptr =3D READ_ONCE(gp); // re-read, gp is not NULL
> + // // =3D> ->fre
> + // WRITE_ONCE(gp, NULL);
> + // call_hazptr(gp, ...):
> + //  lock(->callback_lock);
> + //  [queued the callback]
> + //  unlock(->callback_lock);// =3D> ->po-unlock-lock-po
> + // lock(->callback_lock);
> + // [move from hzpcpu to hzst]
> + //
> + // smp_mb(); =3D> ->strong-fence
> + // ptr =3D READ_ONCE(*hazptr);
> + // // ptr =3D=3D gp, otherwise =3D> ->fre
> + //
> + // If ptr !=3D gp, it means there exists a circle with the following
> + // memory ordering relationships:
> + // ->strong-fence ->fre ->po-unlock-lock-po ->strong-fence ->fre
> + // =3D> (due to the definition of prop)
> + // ->strong-fence ->prop ->strong-fence ->hb ->prop
> + // =3D> (rotate the circle)
> + // ->prop ->strong-fence ->prop ->strong-fence ->hb
> + // =3D> (due to the definition of pb)
> + // ->pb ->pb
> + // but pb is acyclic according to LKMM, so this cannot happen.
> + smp_mb();
> + check_readers(hzst);
> +
> + todo =3D do_hazptr(hzst);
> +
> + while (todo) {
> + struct callback_head *next =3D todo->next;
> + void (*func)(struct callback_head *) =3D todo->func;
> +
> + func(todo);
> +
> + todo =3D next;
> + }
> +}
> +
> +/*
> + * Put @head into the cleanup callback queue.
> + *
> + * @func(@head) will be called after no one is referencing the =
object. Caller
> + * must ensure the object has been unpublished before calling this.
> + */
> +void call_hazptr(struct callback_head *head, rcu_callback_t func)
> +{
> + struct hazptr_percpu *pcpu =3D this_cpu_ptr(&hzpcpu);
> +
> + head->func =3D func;
> + head->next =3D NULL;
> +
> + scoped_guard(spinlock_irqsave, &pcpu->callback_lock) {
> + *(pcpu->tail) =3D head;
> + pcpu->tail =3D &head->next;
> + }
> +
> + guard(spinlock_irqsave)(&hazptr_struct.callback_lock);
> + kick_hazptr_work();
> +}
> +
> +static int init_hazptr_struct(void)
> +{
> + int cpu;
> +
> + INIT_WORK(&hazptr_struct.work, hazptr_work_func);
> +
> + spin_lock_init(&hazptr_struct.callback_lock);
> + hazptr_struct.queued =3D NULL;
> + hazptr_struct.tail =3D &hazptr_struct.queued;
> +
> + for_each_possible_cpu(cpu) {
> + struct hazptr_percpu *pcpu =3D per_cpu_ptr(&hzpcpu, cpu);
> +
> + spin_lock_init(&pcpu->ctx_lock);
> + INIT_LIST_HEAD(&pcpu->ctx_list);
> +
> + spin_lock_init(&pcpu->callback_lock);
> + pcpu->queued =3D NULL;
> + pcpu->tail =3D &pcpu->queued;
> +
> + }
> +
> + init_hazptr_reader_tree(&hazptr_struct.readers);
> +
> + return 0;
> +}
> +
> +early_initcall(init_hazptr_struct);
> --=20
> 2.45.2
>=20
>=20

