Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894722;
	b=t/NplhBOk1dBLr5vQVd1Ue8jBC090iFNIYd9LEXLDiFb8qZO0nPaZcYoL11dGraQEy65
	 5xQZKVPkPpDp9GyNEsFPepLkcLFXoaQ2eK3pBgvQbgGRFVezeTsOkQMs1giZBtFzzeDeU
	 715uxgDiCFtgLHqQLgW7t/HPczshYTNcTjY2GpqcMzZ8+HHgOKCBuYFwYPraXgwpVSXAg
	 Q/AYuWo6xm6KpcNP0lSYVmxlfEJGd/24DZIZCcRFNzXq9hY1ss4Utm4JSv4w1XQOwxG9B
	 Kiz+OAgjykk91HWZjCEIk/VxnJIEKEMcrHLYhfuKNpnZUUWRKixiUP0BrZMXk67vEmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=hrWwQk1vvVJQ8IZXmN6X9EQnk2Oab/KtlMHCQvuppJk=;
	b=XAlT1nZvPyItaPJ41E8Wtq51Q+L2AlSkt0FXuV1NUkpOrmddr07cp2FZKiqKb2RKebP2
	 w2o4zBz4XFtRpnEB3gVRUfeq/eOQczI6lhuZofNF+CAFI3+RoedP6LYQcnpI6NB2K6Jkg
	 n1g2xTk8N/gDMy9RZ21oO/2mIzBBAH1MP9c9+KDyYvXiGmBdcfPoabKp1FwLtRgUkNR2K
	 sLImJdJ6AEjyIlfsHFncZ8pVTsJA3J4mgQ4TfBDI+tkqEpEWdYPjM6TfTiBRotc0w3obu
	 9YO/B18vD+sJ8/iu77iEFCwTXkQpr7sDVDKGk4smXrhyX9/u3BUTG22Gk0sBF3+FQqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oBUbjQ0+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E63606A338
	for <rcu@vger.kernel.org>; Thu,  5 Nov 2026 16:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25E63606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oBUbjQ0+
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d1b35dc42so177752666b.0
        for <rcu@vger.kernel.org>; Thu, 05 Nov 2026 08:05:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793894720; cv=none;
        d=google.com; s=arc-20260327;
        b=UVi2P3dpLWL4oXwUR/tNoa/7JuiWTJr5aCdSyxPvjoMKNhqPA/XdddNFkBD1E3qEPL
         3+QY8h5Z6Dpkhh06VrqrRyoIBnPAfscBFQWpynvRHawYbNS/OMBeE8sSX90G7bra7D6u
         P++DJ+5cGHianH2rPjqZyT8rS22fbs6ILhJdd2JwFKEWoopcvVW1P12o0gLQlvtN0JQN
         5TVYgvnJDeHVOJ+PSHO29s8vvdLgVHxi2IS2xd8Fey2AXWOfHb3bbq7cLfJ1B9sp202g
         pUKkFioBhW3Tcopew74sGPyaOc8wNLyMXtQgStawlRqBKiP0Am9o1fdtTxd0g7QP4ZIq
         XlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hrWwQk1vvVJQ8IZXmN6X9EQnk2Oab/KtlMHCQvuppJk=;
        fh=oTY8Qdg+sPl2au/8yS7KptN0aCe2pjlb3OOb1yUuR08=;
        b=pDQzDNUxDbs+i1eqNAY4sL/43h9dNt+sfYD0c25TCNYlpQMmPU8jJIbLm2TjPPU+rL
         DaKNJJCISd+Os1ADenH60PlBrM3V6NsoJoSmH7JgRMTFastgNp25EczfN5m3movRCp6K
         wYgb2Q4FOZaGNEQvUcP9RlD4FzxFEg1GNl6SRQCEcs+TH1B4Pm+dNH5pSTnhIPH4W4PO
         nev+kjWOGrjDeDTn9pXQPWNgu0b4PhNPUbP8KkKtfRTTNebxFyrDOzMyXqWISf5Glt1p
         Nyar1A0bFrh6SKnZ41iADLaKp3PwCVR8FZRSzxAd/5O9FbzMx9D7/6F7h5ZULbKJsX8V
         k79w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793894720; x=1794499520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hrWwQk1vvVJQ8IZXmN6X9EQnk2Oab/KtlMHCQvuppJk=;
        b=oBUbjQ0+YcNka5X1mebmgvREiIqteZTCnNmygdz6yjTtkcvQCBSvlAY5mwgUQqvob3
         GlzPuUdY//r1N07tES6TTNLuouZGnSieW1/uWTW/E55U590GNxi74kHyOTEKxN9WHQDN
         wNjxYpaLRBK7UQfwRAMX2aJJA28Ycw9ng8hUblr5RpONngcptZ46+sysaIid0G8n/cJv
         ip44VxL4H9OMOReCyBYxpboOCXSDz72G+rc2YyfYWk3Ht10x4ZgIt4hCN63WlvRsu7xI
         XvzgHbFFisUc5C4lgQBk33WN6PntcNsuoEsKcqpMno3tZD8AB4gdsFTZ+AHFVNESep8l
         Hb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793894720; x=1794499520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hrWwQk1vvVJQ8IZXmN6X9EQnk2Oab/KtlMHCQvuppJk=;
        b=HMSNYp74FcWdcWy7kx7uLVI9Q6p/54dduKzNX7Gcnwm6kjVJtfEGE2dP/dQG7n2XdZ
         A4fi/udONrcDV202lvG1XFl8j2x5IEbHBlOZjo07sh5TRNJ0j4LmHDY0XeQtjlSu66hF
         xZfkMHCgpcppj4808CXEWi7lWN0ZM7xtdekBs4VEBO3YUlOmBVZNu1Cxu8Snp3kBmeuh
         JmIMZ8x42/IEjtjSoDHdQQBO3lpBdLvtji6TWpC848Y5hozd0aVVhLCNQTwrUJlenwcF
         EkYkldnAOAQNrrT2KizOtuSm5aUAQDLZJ5efaFvZkegcZSu2kuSYnxywgJhaIGJtbw0E
         3aXA==
X-Gm-Message-State: APuU4Z9/lYJUCFIUmNG93rDKLpL5vILS20B9OOP4USPSx4Ym4npCa9hs
	fkHbVy0jQrBJu02+fnVxXTMpZ5/BsXSauJDNqQpFWpeYd6RJGK56CdM8FygHkpU33QlOLcwVJCT
	u0zPHF0fHG24ZevQQuQL/rr+MGIsALiA=
X-Gm-Gg: AYBFou1pGDf/E0IpZqYEk6eT41lLfNCSa5PmYnBQP4th8j31ucNJ6lWAXXTPPc2j2qF
	GAKmVm5nGhGDXKaT7sgthtbUVGv9G9I/4Dkbr/G8pD41zmxNHXaU7f/iHEfE3yHhSzkNCw/MOWZ
	sECGltS3cPvyD7Opd1JMNykYr/58kuxuk/aC6FuJj3NpLFqTcZ2DAXqMavSeap2i3fyj1BKq8Mb
	AxafzjP5x1frxYtC2QR9PpxbUT/OrfdU1ayr6KMHbaIdw+YK6l2KAobdhEi6D9eO+2AmGXDzwQ8
	GU1gonMsjisXFoazCLufcE/UeGUyyxDemGayEPTN6/Y1TXtvX/31AI6eukHN5AHfF1IEA55BU7f
	kh7vzhbjkiXetq3fP4mYF4bWtAW6eAKdtthXrkFe0oYnQAtNReKnQ
X-Received: by 2002:a17:906:c102:b0:c46:d493:47be with SMTP id
 a640c23a62f3a-c4d206aede3mr259492666b.19.1793894720150; Thu, 05 Nov 2026
 08:05:20 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104144408.GA250870@joelbox>
In-Reply-To: <20261104144408.GA250870@joelbox>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 5 Nov 2026 16:05:08 +0000
X-Gm-Features: AclHuK_2KUcAZnGsjVWzFroGILAwh7g5KucLo2TwA1RSHJaJuvXlj6kLz2Pzh3I
Message-ID: <CANk7y0jW4LHuT+-nWwbx-n9Cz+Lg3_hidAcm_CeBcALzXo-zEA@mail.gmail.com>
Subject: Re: Possible debug objects issue with: rcu: Make call_rcu() safe to
 call from any context
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 2:44=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.co=
m> wrote:
>
> Hello Puranjay,
>
> My local LLM flagged a debug objects issue with the Make call_rcu() safe =
to
> call patch.
>
> Apparently, it is possible that a double call_rcu can result in corruptio=
n
> of the deferred list before debug_objects gets a chance to look at it.
>
> Can you take a look at my AI slop patch below that fixes this, and do som=
e
> testing on this if it is a real issue and send a proper patch? Thank you =
so
> much.

Thanks for finding this, I will look into it and send a patch soon.

Thanks,
Puranjay

>
> ---8<-----------------------
>
> From 1a550f5c8386761aa9c5c5bf2ec28dcd74ecebec Mon Sep 17 00:00:00 2001
> From: Joel Fernandes <joelagnelf@nvidia.com>
> Date: Wed, 28 Oct 2026 06:50:58 -0400
> Subject: [PATCH] [TBC] rcu: Preserve deferred lists while checking duplic=
ate
>  callbacks
>
> The deferred call_rcu() path uses the callback head as its lockless list
> node. Registering that head twice can self-link the list and lose other
> callbacks before rcu_do_enqueue() checks for duplicates. The IRQ-disabled
> object_debug test reports a missing valid callback on both Tree and Tiny
> RCU, and an invoked duplicate on Tiny RCU.
>
> With DEBUG_OBJECTS_RCU_HEAD, stage callbacks in independent entries so
> duplicate heads cannot corrupt the list before the existing checker
> runs. Keep the checker in the drain instead of moving its blocking locks
> into NMI/reentrant registration. Use kmalloc_nolock()/kfree_nolock() for
> the entries, and drain them through the existing irq_work, barrier and
> CPU-offline paths. Match Tree RCU's leak callback handling in Tiny RCU.
>
> This costs one small allocation per deferred registration in debug
> builds. If metadata cannot be allocated, retain the original intrusive
> path rather than dropping valid callbacks. Duplicate containment is
> therefore best-effort in that fallback, as with failed debug tracking.
> Non-debug builds do not allocate entries.
>
> Fixes: af78eca13b03 ("rcu: Make call_rcu() safe to call from any context"=
)
> Fixes: 0ed912d346fd ("rcu: Make Tiny call_rcu() safe to call from any con=
text")
> Not-Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/rcu.h  | 30 ++++++++++++++++++++++++++++++
>  kernel/rcu/tiny.c | 28 ++++++++++++++++++++++++++--
>  kernel/rcu/tree.c | 25 ++++++++++++++++++++++---
>  kernel/rcu/tree.h |  1 +
>  4 files changed, 79 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index d60444bf3a02..07613693e567 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -10,6 +10,7 @@
>  #ifndef __LINUX_RCU_H
>  #define __LINUX_RCU_H
>
> +#include <linux/llist.h>
>  #include <linux/slab.h>
>  #include <trace/events/rcu.h>
>
> @@ -583,6 +584,35 @@ static inline bool should_rcu_defer(void)
>                rcu_scheduler_active !=3D RCU_SCHEDULER_INACTIVE;
>  }
>
> +/*
> + * Debug checking must run after deferral, where it can take locks.  Use=
 a
> + * separate list node so duplicate heads cannot corrupt the deferred lis=
t
> + * before debug_rcu_head_queue() gets a chance to reject them.
> + * Allocation failure falls back to the intrusive list to preserve valid
> + * callbacks; duplicate containment is best-effort in that case.
> + */
> +struct rcu_defer_entry {
> +       struct llist_node node;
> +       struct rcu_head *head;
> +       rcu_callback_t func;
> +};
> +
> +static inline struct rcu_defer_entry *rcu_defer_entry_alloc(struct rcu_h=
ead *head,
> +                                                         rcu_callback_t =
func)
> +{
> +       struct rcu_defer_entry *entry;
> +
> +       if (!IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD))
> +               return NULL;
> +
> +       entry =3D kmalloc_nolock(sizeof(*entry), 0, NUMA_NO_NODE);
> +       if (entry) {
> +               entry->head =3D head;
> +               entry->func =3D func;
> +       }
> +       return entry;
> +}
> +
>  /* Drain an outgoing CPU's deferred SRCU callbacks; see rcutree_migrate_=
callbacks(). */
>  void srcu_offline_drain(int cpu);
>
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index ef0b0474f207..3efd151d30b1 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -48,14 +48,17 @@ static struct rcu_ctrlblk rcu_ctrlblk =3D {
>  /*
>   * The callback list is only accessed with interrupts disabled, so a cal=
l_rcu()
>   * that arrives with interrupts off stages the callback on a lockless li=
st that
> - * an irq_work re-issues later.  One global list and irq_work suffice, a=
s Tiny
> - * RCU is uniprocessor.
> + * an irq_work re-issues later.  Tiny RCU is uniprocessor, so the normal=
 and
> + * debug lists share one global irq_work.
>   */
>  static void rcu_defer_drain(struct irq_work *iw);
>  static LLIST_HEAD(rcu_defer_list);
> +static LLIST_HEAD(rcu_defer_debug_list);
>  static struct irq_work rcu_defer_iw =3D IRQ_WORK_INIT_HARD(rcu_defer_dra=
in);
>  static bool rcu_defer_draining;
>
> +static void rcu_leak_callback(struct rcu_head *head) { }
> +
>  /*
>   * Also called by __rcu_defer_drain() to re-issue a deferred callback, s=
o it
>   * must not re-check the deferral condition.
> @@ -70,6 +73,7 @@ static void rcu_do_enqueue(struct rcu_head *head, rcu_c=
allback_t func)
>                         pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __=
func__, head, head->func);
>                         mem_dump_obj(head);
>                 }
> +               WRITE_ONCE(head->func, rcu_leak_callback);
>                 return;
>         }
>
> @@ -108,6 +112,17 @@ static void __rcu_defer_drain(void)
>                 rcu_do_enqueue(head, head->func);
>                 drained =3D true;
>         }
> +       if (IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD)) {
> +               llist_for_each_safe(node, next, llist_del_all(&rcu_defer_=
debug_list)) {
> +                       struct rcu_defer_entry *entry;
> +
> +                       entry =3D llist_entry(node, struct rcu_defer_entr=
y, node);
> +
> +                       rcu_do_enqueue(entry->head, entry->func);
> +                       kfree_nolock(entry);
> +                       drained =3D true;
> +               }
> +       }
>         local_irq_restore(flags);
>
>         if (drained)
> @@ -124,12 +139,21 @@ static void rcu_defer_drain(struct irq_work *iw)
>
>  static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
>  {
> +       struct rcu_defer_entry *entry;
> +
>         /* A re-entrant call_rcu() during the drain would livelock it; dr=
op it. */
>         if (READ_ONCE(rcu_defer_draining) && !in_nmi()) {
>                 WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
>                           "call_rcu() re-entered during callback drain; l=
eaking callback\n");
>                 return;
>         }
> +       entry =3D rcu_defer_entry_alloc(head, func);
> +       if (entry) {
> +               if (llist_add(&entry->node, &rcu_defer_debug_list))
> +                       irq_work_queue(&rcu_defer_iw);
> +               return;
> +       }
> +       /* Keep valid callbacks working even if debug metadata cannot be =
allocated. */
>         head->func =3D func;
>         if (llist_add((struct llist_node *)head, &rcu_defer_list))
>                 irq_work_queue(&rcu_defer_iw);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a8ede50dbeff..9674cc44618b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3229,6 +3229,16 @@ static void __rcu_defer_drain(struct rcu_data *rdp=
)
>                 head->next =3D NULL;
>                 rcu_do_enqueue(head, head->func, false);
>         }
> +       if (IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD)) {
> +               llist_for_each_safe(node, next, llist_del_all(&rdp->defer=
_debug_head)) {
> +                       struct rcu_defer_entry *entry;
> +
> +                       entry =3D llist_entry(node, struct rcu_defer_entr=
y, node);
> +
> +                       rcu_do_enqueue(entry->head, entry->func, false);
> +                       kfree_nolock(entry);
> +               }
> +       }
>         raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
>  }
>
> @@ -3248,12 +3258,13 @@ static void rcu_defer_drain(struct irq_work *iw)
>  }
>
>  /*
> - * Stage @head for this CPU's irq_work to re-issue once interrupts are o=
n.  Only
> - * the drain side takes a lock, so this stays safe from NMI.
> + * Stage @head for this CPU's irq_work to re-issue once interrupts are o=
n.
> + * Allocation uses nonblocking trylocks, and list insertion is lockless.
>   */
>  static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
>  {
>         struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
> +       struct rcu_defer_entry *entry;
>
>         /*
>          * Instrumentation on the enqueue path can re-enter here from ins=
ide the
> @@ -3265,6 +3276,13 @@ static void call_rcu_defer(struct rcu_head *head, =
rcu_callback_t func)
>                           "call_rcu() re-entered during callback drain; l=
eaking callback\n");
>                 return;
>         }
> +       entry =3D rcu_defer_entry_alloc(head, func);
> +       if (entry) {
> +               if (llist_add(&entry->node, &rdp->defer_debug_head))
> +                       irq_work_queue(&rdp->defer_work);
> +               return;
> +       }
> +       /* Keep valid callbacks working even if debug metadata cannot be =
allocated. */
>         head->func =3D func;
>         if (llist_add((struct llist_node *)head, &rdp->defer_head))
>                 irq_work_queue(&rdp->defer_work);
> @@ -4345,6 +4363,7 @@ rcu_boot_init_percpu_data(int cpu)
>         rdp->last_sched_clock =3D jiffies;
>         rdp->cpu =3D cpu;
>         init_llist_head(&rdp->defer_head);
> +       init_llist_head(&rdp->defer_debug_head);
>         raw_spin_lock_init(&rdp->defer_lock);
>         rdp->defer_work =3D IRQ_WORK_INIT_HARD(rcu_defer_drain);
>         rcu_boot_init_nocb_percpu_data(rdp);
> @@ -4646,7 +4665,7 @@ void rcutree_migrate_callbacks(int cpu)
>
>         /*
>          * Callbacks deferred past the point the outgoing CPU's irq_work =
can run
> -        * sit on ->defer_head, which the ->cblist migration below does n=
ot
> +        * sit on the deferred lists, which the ->cblist migration below =
does not
>          * cover.  Drain them here, before the early returns.
>          */
>         __rcu_defer_drain(rdp);
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index b7cac7a13b4f..da1f29c7c238 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -231,6 +231,7 @@ struct rcu_data {
>
>         /* Deferral of an NMI/reentrant call_rcu(); see __call_rcu_common=
(). */
>         struct llist_head defer_head;
> +       struct llist_head defer_debug_head;
>         struct irq_work defer_work;
>         raw_spinlock_t defer_lock;
>         bool defer_draining;
> --
> 2.54.0
>
