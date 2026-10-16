Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D445D923
	for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141568; cv=pass; b=e9qObq5eNehKtF+iMRWWsz7AzFy8/Zmw4i6/eJ8KU1FwqcAZ0GHKI1sLbHoKWFgKaZP+f1pkC8tSttXgy1J0p6u5LIPtxs4euzujml+4N0vE26KNw8A+xMb9AhZSMtSsL0q0ElCA+f2L4vWRAdrzy0GJxuQtxS8QsTCl4nYyJK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141568; c=relaxed/simple;
	bh=BXbx+k+gRCTzCXhzZBVUm354yXkcy6k273wglLho4lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyfZqd1u4z+X8aGTiAhT3a6/tTlLG1HD/N+WA+IXKfIUJV4tAnatzVaMcHq9/nGW7rJ3HH7u/1zTzNImkxkN3x1N/P/c9n96Mk/vId4IEUdk/210NtHCk5uhVIN7sZ3F98uiON/VGpxxnkxGMbRvxNV22TVdqiw081vR5fodjSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWtBoJCt; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWtBoJCt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so55294975e9.1
        for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 02:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792141564; cv=none;
        d=google.com; s=arc-20260327;
        b=oSWGWpuxtfk5AN9WD3OPg0N9Kk3RzJkpmzm4btGl9vVPUhraRFI6o9L9iWb760bGHr
         E0maVHtlNTrcW3M2mK2H4BHGgYN1HghFsgDKVYi0WRi/03ywnJKelNxXavZPux3wxZqu
         F3VnWiIRawS5aFzN6hzjpBCM9CW/aaNWnKuy9lK6IiRg2KY3AZIYdiWceALXABIksaAe
         XJtwWOwBBr9XSLhLgxeZQGKUmLR3V4ObNRgHGYHTS5tKijqzaEYYzJ70vPmXR6frUwU9
         i9VoaeQWl5nBqAxFY4Wx2v3vf8NVHzPb+iVrPl/MWCYMTY2DjSEV3iD1qR/f50DhgIFH
         l4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2LEH07s2kL9GwAoS4T2na4sZ8j5YL32YKkSlnGI6hcE=;
        fh=XI0C1Ng4U/CI+7ORcWd850L0UVG/y0OKkGDCmwzjLaY=;
        b=PLPtTds+qGW4UBgXOWUjmm64iV3RTl5oNnMp6jFO0h/xX3NmDsEmwymis/rOKvSfff
         GmfqFmSAXZRMEHjrlw5LvMShYJrSZ96Y0QmDPj1XjXgUA6KTZ672IuyUW1S7v9Cf0GEQ
         sgkl1kF9AuTB2mWdzaVlr7U5Xv43HwWisP6cFzkbfkbHQ8QeiW2/zgrOda7ScA59vUM9
         8I6WLeA5PpUAUN7buZ7wbuvOqguYjUlcxcNo9B0jAhxlQyMIMwwg3OVl48xOrWe+2D2e
         h0E2qDRMlsKKhLwAo46pZfmRboGnmybJ98xlEvS1JHqAWCPkULnpSZAUjNwUvA2dR6SJ
         IiJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792141564; x=1792746364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2LEH07s2kL9GwAoS4T2na4sZ8j5YL32YKkSlnGI6hcE=;
        b=oWtBoJCtNPf7LSLgdGYMpeyrkJ7KRAFl2bq486EBhW2/tGCEakwF03geHRLsinzu1d
         CEVhUH7M83zoqknrW//diyLNS7NuKjGJnuam3CbQZz34shYvf5hSr7bik5KabElhEjKb
         oL0fWZHnOw49JlJDtvkwOFY++yrxQnOAvJcdiPS6OEVHfHFC+vfnrhKFoHb0L7n0zHx4
         f3BbF1mggnsIwytGfGo/iw5ge5GOsrhehCkLu6VN162GjuV1cgmHWT1a+0vVSgC7aUPk
         UaSIMIn47xOcqi7vrvNau+AOckvh4+GopSNS/8tcDQBwjcyb8TIf4EWKN3OEycCd2oCE
         C3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141564; x=1792746364;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2LEH07s2kL9GwAoS4T2na4sZ8j5YL32YKkSlnGI6hcE=;
        b=QeIApXNxpr8cRGeK8S0xOHJXOCQFN5raHfyy+VvIVsjikRIEQ4fka4JOa6UmKVrt4k
         CDKZJ+lJ/d8Q8BThrE3hH90XmrbWuoEB6a1E3LGORQZMFo/1iU2fjo+rdeVu0iewCWRb
         MAQNy4SBBfhr3yZ2ayDlZ7xUFr0QZOpynVI93hOfDOoLsLtBdX3XUe2R5ocnNY8roVTu
         Skul7SglKSY5cM4o1Dn9ZGkn5ynmI+ww94AHiNOqtbBgKdJ3dfMBNR2WP4wRRdCsVM8W
         egGMdv9n+QSjuZBkPMTCZWronaFGxw+i5Jawarkb/RscFc76TCtkfNQ2164kD52QFgnk
         k14g==
X-Forwarded-Encrypted: i=1; AKwUvBw3xOhkDYm+kndp7bM2rF+io07RDH4mE2ZAI6IzAfZ3/QiyZEzQIShstetgQjkVXikij0c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLO4VcC5P7YDLbJY0xUiU2Q40Dn5uPXKUzlZlhQVQxLUk+SBuR2
	fCUKhDqf8z9OR5J5f0D+aEQOtpqTsAyVwdENgcegjN07iSn1GcPv1D4PVeearoppNnjnzy0SJtF
	MGlYV1Pijbw+sMh5dwBjBe9DvgQR57lE=
X-Gm-Gg: AYBFou1VGBut3RedMNJshPQu1K4twDD84V4bP4YHuIA3GwVXnhiF+7uNSPbpUKRMXtS
	tKlRFlP5rQlOrM6czDJdEk1bw3+M3eAGDL35JrSvvsOXKTi4KcdNxaz1amaUQRbnwfnSZuPV/Sj
	LhhtqG9r6pP4dqLzpNMDknXK05l1vOJPEGlSJjsNxYpYeD6J5+uIyqWm+yQnPXFssp7xboBd541
	FqWauImmwo4b7/gZSVZKSeMCLlulopgdARhk6tH+Yzz5yYhbHDU7YUls680Ik692kjE7dTn6yRF
	Xknt0M0GPjqAYdXwJb0hsMi+sH8oYPIv5ABY2afukbdFiXxBaFVBS367
X-Received: by 2002:a05:600c:4747:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4a18e49d65dmr431980475e9.5.1792141564143; Fri, 16 Oct 2026
 02:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011194902.97364-1-mathieu.desnoyers@efficios.com> <20261011194902.97364-5-mathieu.desnoyers@efficios.com>
In-Reply-To: <20261011194902.97364-5-mathieu.desnoyers@efficios.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 16 Oct 2026 17:05:50 +0800
X-Gm-Features: AclHuK9TGMgfjwEU9EKSY5YHfK8bole7662-739K9PfOz7whVLhdUDulNqOvJ8I
Message-ID: <CAN_Opa-bydkF8N+w-iYWBRnMHBf8iwpkfg6ncvDRQV=dr66zFQ@mail.gmail.com>
Subject: Re: [PATCH hazptr v3 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, 
	Gary Guo <gary@garyguo.net>, Boqun Feng <boqun@kernel.org>, 
	Bradley Morgan <brads@mainlining.org>, rcu@vger.kernel.org, lkmm@lists.linux.dev, 
	Lian Wang <lianux.mm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

I checked the try-acquire protocol and the changes to
wildcard handling.

The Store B / smp_mb() / Load A sequence checks that the
early and verification loads return the same pointer
value, with ptr_eq() used for the comparison.

With wildcard handling removed from per-CPU slots, the
per-CPU scan no longer needs the two-phase wildcard
check. The overflow-list scan still handles
HAZPTR_WILDCARD.

Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

Thanks,
Kunwu

On Mon, Oct 12, 2026 at 3:49=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Introduce a "try acquire" hazard pointer fast path, which performs an
> early load of the address to store it into the hazard pointer slot, and
> then re-loads that address after a barrier to check whether it has
> changed meanwhile.
>
> On comparison failure, rather than re-try, guarantee forward progress by
> falling back to the __hazptr_acquire slow path on failure.
>
> The acquire slow path attempts a try-acquire for any available per-CPU
> slot. If that fails, it chains the backup slot into the overflow list,
> therefore guaranteeing forward progress for both hazard pointer
> read-side and synchronize:
>
> - Readers set the wildcard, and then proceed to set the more
>   specific address to replace the wildcard.
>
> - One synchronize alternates between two overflow list periods,
>   scanning each one while readers are added to the other period,
>   thus preventing a steady flow of readers from preventing
>   synchronize forward progress.
>
> With this change, the scan on per-CPU slots don't need to expect a
> wildcard anymore, because none can be produced by readers. Wildcards are
> only expected within overflow lists.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Link: https://lore.kernel.org/lkmm/DLK9MW1N86KD.2GRWUAD2NX4FU@garyguo.net=
/
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Bradley Morgan <brads@mainlining.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: <rcu@vger.kernel.org>
> Cc: <lkmm@lists.linux.dev>
> Cc: Lian Wang <lianux.mm@gmail.com>
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> ---
> Changes since v2:
> - Adapt include to rename from ptreq.h to ptr_eq.h.
> ---
>  include/linux/hazptr.h |  48 +++++++++++--------
>  kernel/hazptr.c        | 103 ++++++++++++++++++++---------------------
>  2 files changed, 77 insertions(+), 74 deletions(-)
>
> diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
> index d1670121947a..90d8d5a3d244 100644
> --- a/include/linux/hazptr.h
> +++ b/include/linux/hazptr.h
> @@ -25,13 +25,11 @@
>  #include <linux/types.h>
>  #include <linux/cleanup.h>
>  #include <linux/sched.h>
> +#include <linux/ptr_eq.h>
>
>  /* 4 slots (each sizeof(hazptr_slot_item)) fit in a single 64-byte cache=
 line. */
>  #define NR_HAZPTR_PERCPU_SLOTS 4
>
> -/* The current hazard pointer wildcard. */
> -extern void *hazptr_wildcard;
> -
>  /*
>   * Hazard pointer slot.
>   */
> @@ -190,6 +188,31 @@ void hazptr_note_context_switch(void)
>         }
>  }
>
> +/* Try hazard pointer protection. */
> +static inline
> +void *__hazptr_try_acquire(struct hazptr_ctx *ctx, void * const *addr_p,=
 struct hazptr_slot *slot)
> +{
> +       void *early_addr, *addr;
> +
> +       if (unlikely(slot->addr))
> +               return NULL;
> +       early_addr =3D READ_ONCE(*addr_p);        /* Early load. */
> +       WRITE_ONCE(slot->addr, early_addr);     /* Store B */
> +       /* Memory ordering: Store B before Load A. */
> +       smp_mb();
> +       addr =3D READ_ONCE(*addr_p);              /* Load A */
> +       /*
> +        * Validate that address did not change between Early load and Lo=
ad A.
> +        * Use ptr_eq() to make sure that result from Load A is returned =
to the
> +        * caller to preserve address dependency.
> +        */
> +       if (unlikely(!ptr_eq(addr, early_addr))) {
> +               WRITE_ONCE(slot->addr, NULL);
> +               return NULL;
> +       }
> +       return addr;
> +}
> +
>  /**
>   * hazptr_acquire - Load pointer at address and protect with hazard poin=
ter.
>   *
> @@ -245,24 +268,9 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * =
const *addr_p)
>         ctx->acquire_cpu =3D smp_processor_id();
>         ctx->acquire_caller =3D _THIS_IP_;
>  #endif
> -       if (unlikely(slot->addr))
> +       addr =3D __hazptr_try_acquire(ctx, addr_p, slot);
> +       if (unlikely(!addr))
>                 return __hazptr_acquire(ctx, addr_p);
> -       WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));     /* Store =
B */
> -
> -       /* Memory ordering: Store B before Load A. */
> -       smp_mb();
> -
> -       /*
> -        * Load @addr_p after storing wildcard to the hazard pointer slot=
.
> -        */
> -       addr =3D READ_ONCE(*addr_p);      /* Load A */
> -
> -       /*
> -        * We don't care about ordering of Store C. It will simply
> -        * replace the wildcard by a more specific address. If addr is
> -        * NULL, we simply store NULL into the slot.
> -        */
> -       WRITE_ONCE(slot->addr, addr);   /* Store C */
>         slot_item->ctx.ctx =3D ctx;
>         ctx->slot =3D slot;
>         return addr;
> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> index 13faa5ba7677..3ca73b56a5c2 100644
> --- a/kernel/hazptr.c
> +++ b/kernel/hazptr.c
> @@ -13,17 +13,9 @@
>  #include <linux/list.h>
>  #include <linux/export.h>
>
> -static DEFINE_MUTEX(hazptr_phase_lock);        /* Protect the wildcard a=
nd list phase flip. */
> +#define HAZPTR_WILDCARD        ((void *) 1UL)
>
> -/*
> - * The current hazard pointer wildcard. Flips between 1UL and 2UL to gua=
rantee
> - * hazptr_synchronize forward progress even with a steady stream of read=
ers.
> - * This wildcard value is used by acquire to temporarily tag the per-CPU=
 slots.
> - * This also affects the overflow list selection: the current list used =
by
> - * readers is array[(unsigned long) hazptr_wildcard - 1].
> - */
> -void *hazptr_wildcard =3D (void *) 1UL;
> -EXPORT_SYMBOL_GPL(hazptr_wildcard);
> +static DEFINE_MUTEX(hazptr_phase_lock);        /* Protect the list phase=
 flip. */
>
>  /* The current overflow list phase. */
>  static unsigned int hazptr_overflow_list_phase;
> @@ -41,6 +33,10 @@ struct hazptr_overflow_list {
>   * successively iterates on both lists. Therefore, only list removals
>   * can cause the iteration to retry, and the number of removals is
>   * limited to the number of list elements.
> + *
> + * Due to the overflow list raw spin lock, the hazard pointer readers ar=
e
> + * blocking, starvation-free with bounded waiting, assuming bounded crit=
ical
> + * sections and no NMI or virtualization-induced holder preemption.
>   */
>  struct hazptr_overflow_list_flip {
>         struct hazptr_overflow_list array[2];
> @@ -51,26 +47,12 @@ static DEFINE_PER_CPU(struct hazptr_overflow_list_fli=
p, percpu_overflow_list_fli
>  DEFINE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
>  EXPORT_PER_CPU_SYMBOL_GPL(hazptr_percpu_slots);
>
> -static
> -void *flip_wildcard(void *wildcard)
> -{
> -       return ((unsigned long) wildcard =3D=3D 1UL) ? (void *) 2UL : (vo=
id *) 1UL;
> -}
> -
>  static
>  unsigned int flip_list_phase(unsigned int phase)
>  {
>         return 1 - phase;
>  }
>
> -static
> -bool is_wildcard(void *addr)
> -{
> -       if ((unsigned long) addr =3D=3D 1UL || (unsigned long) addr =3D=
=3D 2UL)
> -               return true;
> -       return false;
> -}
> -
>  static
>  struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
>  {
> @@ -96,16 +78,36 @@ struct hazptr_slot *hazptr_get_free_percpu_slot(struc=
t hazptr_ctx *ctx)
>   */
>  void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
>  {
> -       struct hazptr_slot *slot =3D hazptr_get_free_percpu_slot(ctx);
> +       struct hazptr_slot *slot;
>         void *addr;
>
>         /*
> -        * If all the per-CPU slots are already in use, fallback
> -        * to the backup slot.
> +        * In case we are called due to nested use of hazard pointers,
> +        * try a slot protection with per-CPU slots.
>          */
> -       if (unlikely(!slot))
> -               slot =3D hazptr_chain_backup_slot(ctx);
> -       WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));     /* Store =
B */
> +       slot =3D hazptr_get_free_percpu_slot(ctx);
> +       if (likely(slot)) {
> +               addr =3D __hazptr_try_acquire(ctx, addr_p, slot);
> +               if (addr) {
> +                       ctx->slot =3D slot;
> +                       return addr;
> +               }
> +       }
> +
> +       /*
> +        * The backup slot overflow list guarantees forward progress of b=
oth
> +        * hazard pointer readers and synchronize:
> +        *
> +        * - Readers set the wildcard, and then proceed to set the more
> +        *   specific address to replace the wildcard.
> +        *
> +        * - One synchronize alternates between two overflow list periods=
,
> +        *   scanning each one while readers are added to the other perio=
d,
> +        *   thus preventing a steady flow of readers from preventing
> +        *   synchronize forward progress.
> +        */
> +       slot =3D hazptr_chain_backup_slot(ctx);
> +       WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);        /* Store B */
>
>         /* Memory ordering: Store B before Load A. */
>         smp_mb();
> @@ -121,20 +123,21 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void=
 * const *addr_p)
>          * NULL, we simply store NULL into the slot.
>          */
>         WRITE_ONCE(slot->addr, addr);   /* Store C */
> +
>         ctx->slot =3D slot;
> -       if (!addr && hazptr_slot_is_backup(ctx, slot))
> +       if (!addr)
>                 hazptr_unchain_backup_slot(ctx);
>         return addr;
>  }
>  EXPORT_SYMBOL_GPL(__hazptr_acquire);
>
>  /*
> - * Perform piecewise iteration on overflow list waiting until "addr" is
> - * not present. Raw spinlock is released and taken between each list
> - * item and busy loop iteration. The overflow list generation is checked
> - * each time the lock is taken to validate that the list has not changed
> - * before resuming iteration or busy wait. If the generation has
> - * changed, retry the entire list traversal.
> + * Perform piecewise iteration on overflow list waiting until "addr" and
> + * wildcard are not present. Raw spinlock is released and taken between =
each
> + * list item and busy loop iteration. The overflow list generation is ch=
ecked
> + * each time the lock is taken to validate that the list has not changed=
 before
> + * resuming iteration or busy wait. If the generation has changed, retry=
 the
> + * entire list traversal.
>   */
>  static
>  void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overf=
low_list, void *addr)
> @@ -147,13 +150,11 @@ void hazptr_synchronize_overflow_list(struct hazptr=
_overflow_list *overflow_list
>  retry:
>         snapshot_gen =3D overflow_list->gen;
>         hlist_for_each_entry(backup_slot, &overflow_list->head, overflow_=
node) {
> -               /* Busy-wait if node is found. */
> +               /* Busy-wait if addr or wildcard are found. */
>                 for (;;) {
>                         void *load_addr =3D smp_load_acquire(&backup_slot=
->slot.addr);    /* Load B */
>
> -                       /* We don't expect wildcards in overflow list. */
> -                       WARN_ON_ONCE(is_wildcard(load_addr));
> -                       if (load_addr !=3D addr)
> +                       if (load_addr !=3D addr && load_addr !=3D HAZPTR_=
WILDCARD)
>                                 break;
>                         raw_spin_unlock_irqrestore(&overflow_list->lock, =
flags);
>                         cpu_relax();
> @@ -174,7 +175,7 @@ void hazptr_synchronize_overflow_list(struct hazptr_o=
verflow_list *overflow_list
>  }
>
>  static
> -void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildca=
rd)
> +void hazptr_synchronize_cpu_slots(int cpu, void *addr)
>  {
>         struct hazptr_percpu_slots *percpu_slots =3D per_cpu_ptr(&hazptr_=
percpu_slots, cpu);
>         unsigned int idx;
> @@ -182,13 +183,13 @@ void hazptr_synchronize_cpu_slots(int cpu, void *ad=
dr, void *scan_wildcard)
>         for (idx =3D 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
>                 struct hazptr_slot_item *item =3D &percpu_slots->items[id=
x];
>
> -               /* Busy-wait if node is found. */
> -               smp_cond_load_acquire(&item->slot.addr, VAL !=3D addr && =
VAL !=3D scan_wildcard); /* Load B */
> +               /* Busy-wait if addr is found. */
> +               smp_cond_load_acquire(&item->slot.addr, VAL !=3D addr); /=
* Load B */
>         }
>  }
>
>  static
> -void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
> +void hazptr_scan_cpu_slots(void *addr)
>  {
>         int cpu;
>
> @@ -196,16 +197,13 @@ void hazptr_scan_cpu_slots_period(void *addr, void =
*scan_wildcard)
>         for_each_possible_cpu(cpu) {
>                 /*
>                  * Scan CPU slots.
> -                * Forward progress against recurring wildcards is guaran=
teed
> -                * by scanning for one wildcard while new elements use th=
e
> -                * other wildcard value (1UL vs 2UL).
>                  * Forward progress against recurring single hazard point=
er
>                  * values is guaranteed by the fact that a hazard pointer
>                  * is not reclaimed nor reused until the scan for that ha=
zard
>                  * pointer completes, which prevents a steady flow of rea=
ders
>                  * to acquire that same hazard pointer value.
>                  */
> -               hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
> +               hazptr_synchronize_cpu_slots(cpu, addr);
>         }
>  }
>
> @@ -237,7 +235,6 @@ void hazptr_scan_overflow_list_period(void *addr, uns=
igned int scan_idx)
>  void hazptr_synchronize(void *addr)
>  {
>         unsigned int scan_list_phase;
> -       void *scan_wildcard;
>
>         /*
>          * Busy-wait should only be done from preemptible context.
> @@ -251,16 +248,14 @@ void hazptr_synchronize(void *addr)
>          */
>         if (!addr)
>                 return;
> +
>         /* Memory ordering: Store A before Load B. */
>         smp_mb();
>
>         guard(mutex)(&hazptr_phase_lock);
>
>         /* Scan per-CPU slots. */
> -       scan_wildcard =3D flip_wildcard(hazptr_wildcard);
> -       hazptr_scan_cpu_slots_period(addr, scan_wildcard);
> -       WRITE_ONCE(hazptr_wildcard, scan_wildcard);                     /=
* Flip the current wildcard. */
> -       hazptr_scan_cpu_slots_period(addr, flip_wildcard(scan_wildcard));
> +       hazptr_scan_cpu_slots(addr);
>
>         /*
>          * Scan overflow lists *after* scanning per-CPU slots. See
> --
> 2.43.0
>
