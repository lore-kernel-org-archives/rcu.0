Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E33FFF9D
	for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139077; cv=pass; b=j2Af5pynllYb3e6DsBJwpGO/N/KUoBMnCYqc8i42CUkenIeSReHUaETWclppvT+E/1uj3e4ttKW2I2bmVNl+44oikn58kQvUUNusM7pCtk51zUDTXY/URrDzunjU+sTYPIqpg+W2WGDexmlXeoK/LSjah7wwj56fRQQzNWqSgaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139077; c=relaxed/simple;
	bh=zFZtjuMJCKAH5rWRVMQCBJBw5Fu75jP8ohWlhoXBSfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWtKVhV2WAmEpLuD07bSHmeY9KKeLv2wkcVYuPId4zfl/zdKf2UwS9CMoXr5P8wHcCV0+25XHvwYwD8XB0+M76+SnAs/LjwMQsVoTCUYSrVUWqTjn7Z7YQpgKaeHRipbooJ0WXj5geY3GMaQDt+6wzjbMUKm5r3pPxEDKao2SXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wsu4ti1e; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsu4ti1e"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a17baef589so25921005e9.0
        for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 01:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792139074; cv=none;
        d=google.com; s=arc-20260327;
        b=PZqzp65sWSV1L5oXggJW76aODYJHdcXOHLUrhiQOgrRKHBpQ3Qwv2+cbUbYJW6GEkB
         mQA8QnmHuyd9YLePQqbCL1nEzwTy22PtVz3gn6oNFTg4H8oa9uJg3qSn7zjo25Dm25si
         kDCMEuWwU1CgZKK0kPYOV4wf8rFqpLuwZXMbdZdkhUhxSxTC+9En1KaC5wGSiyR9HMm5
         NqE8xXK2zVkctBG6Qov9Im6vbeiK9rHR+uVGgCMtuQ1wjPbxYM+7/DCZUAID2MxD8bJp
         Tcg5IHUMGPAjdLXl5Ro99Qj2Ose/Ibw568hTHwzDY4v/NdbViEjRpZSwkkxqexlNcm4/
         oJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E8gxo2ExdAcC67lQx6KTJbVCAq98YK23bGoiwCanXEA=;
        fh=q0rQv56H0SK1Z9TB+lzK814CEnO8xVf+7xlCNtkq2zc=;
        b=Mko06IDRo1WqwemdN0VTiyu+58ozj5HWZyYYae2QAcP/6aBxF/2lKJn4m99j4v4bhr
         iBu04e/lyQFi9tV+HhtXbAn4IB3ivmoTvcb/S98uyWRHfpZw0dB/bEpjmBO1MNpSb5Pv
         Q3wVAChKvMtHmgecol5cXI7XMzqe5RE3Abl2nNtcgFTGPCD8ERTlR8nY7zt3zA4Meuhf
         PVvLe0h6/KMQMf0AcdmJPbEPkUZ6tvWKrsnmrn8WncwbU8zgkiL7hEX47Y/Ise50brX8
         DpZrNboMJAugKnXgEMg4KNp6YX1b73g3fbf5FF3VNIEYCqOm9LTcW4qQ+Enq5V7/uggd
         R3og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792139074; x=1792743874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E8gxo2ExdAcC67lQx6KTJbVCAq98YK23bGoiwCanXEA=;
        b=Wsu4ti1ePP0d7doCMycz1W/aBkhlYYhV+NgNAAHZ58vK28dT7jgKi3bsTOlHFd6rlJ
         0QQ9CkbanVZOlWhNlDxA1/cCnO6ExwvTnIP08CNCq5zPTJEF7IkPpWjVUfnHSzXeEsVB
         fN79kKSTPR5LvnR7PhQtClGLkI0RsHCt1TTKTRTRj8WaiH1oTAbiiWauHlrhkY4ktIAX
         t8OfaZJmrMAdKjVe3G5jZ8ApsA3NN5hNQ4YAEnxn1d0vX0gCJeRe1zpcLxMQg882m6ZZ
         UcSIbzezUaM419w5TLa/wr1C9+Iw+z4dhpo6GkodK73RBywm866jMq2k5GzWwS90KQ1C
         eghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792139074; x=1792743874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E8gxo2ExdAcC67lQx6KTJbVCAq98YK23bGoiwCanXEA=;
        b=AkILSxk64S6kCAa7mm33OfmK0PuABSkBcvnFMhZtjfi5ZMzOvOdXk1b71UXX+kHYqz
         bN1EUhv/6w7df9V2J2yaoKXm3uurrSjuPLFJTVIZeluLGo5+dINpu9OABK5vHxkGBHq4
         3CqAVe0qhX3b5iqEPDA5Zl0tUkoc0PEQt1Pkb5aWSoznESPX+QXfAnJqWS0KFFh28ZXH
         oDX/d1/ElBMIoTQPd0qOZuEtaZ+LkdwYm7NDCCup3/w3NobdirFW8LnymL27GYDqD/59
         Y/2kWQDmLH7CooknUId3Vdx2C5cQjr0S0LdQ02sscKtp6r9D6R2aYCQqs83CNqXAP7jy
         OKCA==
X-Forwarded-Encrypted: i=1; AKwUvBzJDpuu73u+D/4nmYcslOFtnr6uK1xYVovFO3lJyOhwL7ZR3H7vRznX5j2hE0LCHYllFXI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBkLn9qaxqWi7PUEKPXwzA4zdwPzx0Fo2MhBUwchl1wAR3b0kL
	zrfyZ/KeUxLVCsgK5JkmBNcVESNqzB829hBPkbU7X3FrktUTDKqjrOGnccPZB03gENfvQPx2ytg
	T6Cuq4ipeNqyA26TWUveyssVecQ49b/E=
X-Gm-Gg: AYBFou15KDuNPYUbzrciqevujm9vrdNmF3yDn/wZKKOeTDfopVM65fSS7yOuvEEmWLi
	WBbTXPdBJEog3TCxjh1UJzc0/r9Oc/FlT5finGccfTX/HF02ViK07QJCjzhuaNldtd0SRy77p6e
	A0G7k0Xi7Jj8DtvPBFjsRwm6EwaPkAHTf+3Sbgkv2UPV1NetUyIbS0cvp9RsvHCTgBYsTvylbrR
	WirTOJXm8dOYA0hCo95ZEfEB8sZygWFw0xLeh18I3jLav4n4+0qD7sQewNGGB456b5xlrKpcaK8
	M3QrAYJP1fgC6tiNXMr5YCLsHaw8vL3ahzRfMxQ18ZXSmoK6D/XqMLeN
X-Received: by 2002:a05:600d:82c1:b0:4a1:6a10:4dc8 with SMTP id
 5b1f17b1804b1-4a1bd175fa1mr146577265e9.28.1792139073577; Fri, 16 Oct 2026
 01:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011194902.97364-1-mathieu.desnoyers@efficios.com> <20261011194902.97364-2-mathieu.desnoyers@efficios.com>
In-Reply-To: <20261011194902.97364-2-mathieu.desnoyers@efficios.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 16 Oct 2026 16:24:21 +0800
X-Gm-Features: AclHuK_PTuneKkOgmgJaVDS6GjsvRFKMkj_6VcBtfZcfMgJ14F3yG1rp3naG8VE
Message-ID: <CAN_Opa-zH=+By+Qrsrg3W0prQPNv17xCCh_n0CzfimUB9__obA@mail.gmail.com>
Subject: Re: [PATCH hazptr v3 1/4] hazptr: Fix two-phase hazptr_synchronize
 race with detach
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>, 
	rcu@vger.kernel.org, lkmm@lists.linux.dev, Lian Wang <lianux.mm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

Scanning all per-CPU slots before the overflow lists
addresses the race where a backup slot can be moved to
a list that has already been scanned.

Using a separate overflow-list phase also decouples list
selection from the wildcard phase.


Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

Thanks,
Kunwu

On Mon, Oct 12, 2026 at 3:49=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Boqun Feng pointed out that a detach happening concurrently with
> hazptr_synchronize can miss a slot. Indeed, scanning the per-CPU
> slots needs to be done *before* scanning the overflow lists. Fix the
> implementation accordingly.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reported-by: Boqun Feng <boqun@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Bradley Morgan <brads@mainlining.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: <rcu@vger.kernel.org>
> Cc: <lkmm@lists.linux.dev>
> Cc: Lian Wang <lianux.mm@gmail.com>
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> ---
> Changes since v0:
> - Load the new overflow list phase word in "hazptr_chain_backup_slot".
> - Rename the lock to hazptr_phase_lock to make it clear that it
>   protects both the wildcard and the overflow list phases.
> ---
>  kernel/hazptr.c | 50 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> index d3d1050d92cf..13faa5ba7677 100644
> --- a/kernel/hazptr.c
> +++ b/kernel/hazptr.c
> @@ -13,6 +13,8 @@
>  #include <linux/list.h>
>  #include <linux/export.h>
>
> +static DEFINE_MUTEX(hazptr_phase_lock);        /* Protect the wildcard a=
nd list phase flip. */
> +
>  /*
>   * The current hazard pointer wildcard. Flips between 1UL and 2UL to gua=
rantee
>   * hazptr_synchronize forward progress even with a steady stream of read=
ers.
> @@ -20,10 +22,12 @@
>   * This also affects the overflow list selection: the current list used =
by
>   * readers is array[(unsigned long) hazptr_wildcard - 1].
>   */
> -static DEFINE_MUTEX(hazptr_wildcard_lock);     /* Protect the wildcard f=
lip. */
>  void *hazptr_wildcard =3D (void *) 1UL;
>  EXPORT_SYMBOL_GPL(hazptr_wildcard);
>
> +/* The current overflow list phase. */
> +static unsigned int hazptr_overflow_list_phase;
> +
>  struct hazptr_overflow_list {
>         raw_spinlock_t lock;            /* Lock protecting overflow list =
and list generation. */
>         struct hlist_head head;         /* Overflow list head. */
> @@ -53,6 +57,12 @@ void *flip_wildcard(void *wildcard)
>         return ((unsigned long) wildcard =3D=3D 1UL) ? (void *) 2UL : (vo=
id *) 1UL;
>  }
>
> +static
> +unsigned int flip_list_phase(unsigned int phase)
> +{
> +       return 1 - phase;
> +}
> +
>  static
>  bool is_wildcard(void *addr)
>  {
> @@ -178,15 +188,12 @@ void hazptr_synchronize_cpu_slots(int cpu, void *ad=
dr, void *scan_wildcard)
>  }
>
>  static
> -void hazptr_scan_period(void *addr, void *scan_wildcard)
> +void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
>  {
> -       unsigned int scan_idx =3D (unsigned long) scan_wildcard - 1;
>         int cpu;
>
>         /* Scan all CPUs slots. */
>         for_each_possible_cpu(cpu) {
> -               struct hazptr_overflow_list_flip *overflow_list_flip =3D =
per_cpu_ptr(&percpu_overflow_list_flip, cpu);
> -
>                 /*
>                  * Scan CPU slots.
>                  * Forward progress against recurring wildcards is guaran=
teed
> @@ -199,6 +206,17 @@ void hazptr_scan_period(void *addr, void *scan_wildc=
ard)
>                  * to acquire that same hazard pointer value.
>                  */
>                 hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
> +       }
> +}
> +
> +static
> +void hazptr_scan_overflow_list_period(void *addr, unsigned int scan_idx)
> +{
> +       int cpu;
> +
> +       /* Scan all CPUs overflow lists. */
> +       for_each_possible_cpu(cpu) {
> +               struct hazptr_overflow_list_flip *overflow_list_flip =3D =
per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>
>                 /*
>                  * Scan backup slots in percpu overflow lists.
> @@ -218,6 +236,7 @@ void hazptr_scan_period(void *addr, void *scan_wildca=
rd)
>   */
>  void hazptr_synchronize(void *addr)
>  {
> +       unsigned int scan_list_phase;
>         void *scan_wildcard;
>
>         /*
> @@ -235,18 +254,29 @@ void hazptr_synchronize(void *addr)
>         /* Memory ordering: Store A before Load B. */
>         smp_mb();
>
> -       guard(mutex)(&hazptr_wildcard_lock);
> +       guard(mutex)(&hazptr_phase_lock);
> +
> +       /* Scan per-CPU slots. */
>         scan_wildcard =3D flip_wildcard(hazptr_wildcard);
> -       hazptr_scan_period(addr, scan_wildcard);
> -       WRITE_ONCE(hazptr_wildcard, scan_wildcard);     /* Flip the curre=
nt wildcard. */
> -       hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
> +       hazptr_scan_cpu_slots_period(addr, scan_wildcard);
> +       WRITE_ONCE(hazptr_wildcard, scan_wildcard);                     /=
* Flip the current wildcard. */
> +       hazptr_scan_cpu_slots_period(addr, flip_wildcard(scan_wildcard));
> +
> +       /*
> +        * Scan overflow lists *after* scanning per-CPU slots. See
> +        * hazptr_promote_to_backup_slot() for scan ordering requirement.
> +        */
> +       scan_list_phase =3D flip_list_phase(hazptr_overflow_list_phase);
> +       hazptr_scan_overflow_list_period(addr, scan_list_phase);
> +       WRITE_ONCE(hazptr_overflow_list_phase, scan_list_phase);        /=
* Flip the current list phase. */
> +       hazptr_scan_overflow_list_period(addr, flip_list_phase(scan_list_=
phase));
>  }
>  EXPORT_SYMBOL_GPL(hazptr_synchronize);
>
>  struct hazptr_slot *hazptr_chain_backup_slot(struct hazptr_ctx *ctx)
>  {
>         struct hazptr_overflow_list_flip *overflow_list_flip =3D this_cpu=
_ptr(&percpu_overflow_list_flip);
> -       unsigned int list_idx =3D (unsigned long) READ_ONCE(hazptr_wildca=
rd) - 1;
> +       unsigned int list_idx =3D READ_ONCE(hazptr_overflow_list_phase);
>         struct hazptr_overflow_list *overflow_list =3D &overflow_list_fli=
p->array[list_idx];
>         struct hazptr_slot *slot =3D &ctx->backup_slot.slot;
>
> --
> 2.43.0
>
