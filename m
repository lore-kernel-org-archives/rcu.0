Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92053370
	for <rcu@vger.kernel.org>; Mon, 18 Mar 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776659; cv=none; b=TrBiR7R30jiB7J7/WkCWfWRPW0ZRXeW0XmYzormPuTmM7vXJRKfaics6qTHXV+Zd3zkqJhMgr5INUeLU9dr3Sx/WUQQu8EjTgx/9f5sXk5AeVnDf+xSm5JBcj0zWicgNSnWVUsnDYFlQ2dvXzXuSuA/BRwbeUAL7yAJMlaGC3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776659; c=relaxed/simple;
	bh=oR08WAKdXMlnDWICskmjHpHm/lh2Ma7Er2IVfOEhIyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uyq8XTJIkL++FPsMJmg9Qrf/cxFB3I8FQvu249BekgN4Y50+nB/7PlSbl95MpHgCLNMqpJ3Vm8RjOuAc+c0Qd+XNst9IpTvpcm2qdpcJuGZ1xPSuowSgfY0U7C5Q+jwmxfkHOHZ+qkRe9ro/Tj/FqlhSeACdueDdapqclVe8dYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tnGRLn9w; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnGRLn9w"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7e0408f1c30so603813241.0
        for <rcu@vger.kernel.org>; Mon, 18 Mar 2024 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710776656; x=1711381456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzbjB+Gs1Kwvcbil1vU+BLYNe1OnSHfExrWee+0iEgg=;
        b=tnGRLn9w/8o+EqX2pSYGtGzYuNb+jPmgkCbmrVBAPEfwtBxAyIXd9ze1bBDuObELWy
         qFE7txzRz4N3fRbFuU4M3jcf5QPRKbFX1vZxmbol0Q4kWutMFFiSPWl/8zyUL6OojSgA
         nlqFYUfcaRarSCWhT5krlmA2A0bFAtiJiWzb27Ey8BvvVZ7AgM97Cz7PSfwks/FfgdI3
         LKjV1FBLpxg1RHvcFb49F16MvplcYF1BzE7KZDMI5k5M9sUUFZHuf95UxGuZiVJ18w51
         AtRtK0e8pnRU4b4kt+crgYkmxe+3MMMSuxLXCHa5vvglwhKO2o44bT2s8LHnfutIYL8N
         FzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710776656; x=1711381456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzbjB+Gs1Kwvcbil1vU+BLYNe1OnSHfExrWee+0iEgg=;
        b=pNFAPBtqz5go0W8aJ54ElRbicybxjZBzUhSz6J2D3HEaqDsMiwWlbc1yVgyKvtuhRL
         wn5v1WhhLJ3TnqYQsiXw751Q4AECwCsL6Qu1LFezoitRSnflEV5eQ5qYbuhj51i8Xxtz
         mezKNaJ5BZvaA/hmxwFXoVbSwdo4WbflFf/tkL4YtaA82oPjWtAz4urWwNQfLMC/oIA6
         QZfUy39DkIB2uHhOQefHcxxrmf6bV6KXLa+qkC+3mLWAg8rZM+tU7ZqVIfNy71w1HyZk
         6G2Z8+F72dC/FireHRfFwpfz8VtBj11iGd0XgnFAdChYiUWyAclM7Zq3eRjTrKMyBdqL
         BCkw==
X-Gm-Message-State: AOJu0Yz5eh8CAk7t8GlCwAZL4GYmtUhNdIjfBV+yxfRE8Mc6VJ6heQ6I
	v28tLUOcPJPHCNiK+XfzBlcWHRvwVvp6oSxOJ20BFrnkA0tNvWOLEpwC4DXHWdLAYu345MnwQTb
	P+5x6VS3Kg9SaGNmmq3+k1uj1WcZPx2/1lb1w
X-Google-Smtp-Source: AGHT+IE+8UwIpYfv/eJCFSYjxQo8zGGNx8l3OnqAqpy3HqYw8FLrusH1em5tXQYizIDnuPrXu4CAQD5a2OBoOAuQJX0=
X-Received: by 2002:a05:6122:36a6:b0:4d3:362f:f9c1 with SMTP id
 ec38-20020a05612236a600b004d3362ff9c1mr8716909vkb.13.1710776656296; Mon, 18
 Mar 2024 08:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop>
 <CANpmjNO+0d82rPCQ22xrEEqW_3sk7T28Dv95k1jnB7YmG3amjA@mail.gmail.com>
 <53a68e29-cd33-451e-8cf0-f6576da40ced@paulmck-laptop> <67baae71-da4f-4eda-ace7-e4f61d2ced0c@paulmck-laptop>
 <CANpmjNOmpOCfaFyMUnMtc3TT=VuTpWC4c85FW_u4dobmtikHtQ@mail.gmail.com>
In-Reply-To: <CANpmjNOmpOCfaFyMUnMtc3TT=VuTpWC4c85FW_u4dobmtikHtQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 18 Mar 2024 16:43:38 +0100
Message-ID: <CANpmjNNLXR1kC8XAqFjEO3N0P3scRott8Z1OcW2yoKu5BEDaYQ@mail.gmail.com>
Subject: Re: [PATCH RFC rcu] Inform KCSAN of one-byte cmpxchg() in rcu_trc_cmpxchg_need_qs()
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, kasan-dev@googlegroups.com, dvyukov@google.com, 
	glider@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 11:01, Marco Elver <elver@google.com> wrote:
>
> On Sun, 17 Mar 2024 at 22:55, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Mar 08, 2024 at 02:31:53PM -0800, Paul E. McKenney wrote:
> > > On Fri, Mar 08, 2024 at 11:02:28PM +0100, Marco Elver wrote:
> > > > On Fri, 8 Mar 2024 at 22:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > Tasks Trace RCU needs a single-byte cmpxchg(), but no such thing exists.
> > > >
> > > > Because not all architectures support 1-byte cmpxchg?
> > > > What prevents us from implementing it?
> > >
> > > Nothing that I know of, but I didn't want to put up with the KCSAN report
> > > in the interim.
> >
> > And here is a lightly tested patch to emulate one-byte and two-byte
> > cmpxchg() for architectures that do not support it.  This is just the
> > emulation, and would be followed up with patches to make the relevant
> > architectures make use of it.
> >
> > The one-byte emulation has been lightly tested on x86.
> >
> > Thoughts?
> >
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit d72e54166b56d8b373676e1e92a426a07d53899a
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Sun Mar 17 14:44:38 2024 -0700
> >
> >     lib: Add one-byte and two-byte cmpxchg() emulation functions
> >
> >     Architectures are required to provide four-byte cmpxchg() and 64-bit
> >     architectures are additionally required to provide eight-byte cmpxchg().
> >     However, there are cases where one-byte and two-byte cmpxchg()
> >     would be extremely useful.  Therefore, provide cmpxchg_emu_u8() and
> >     cmpxchg_emu_u16() that emulated one-byte and two-byte cmpxchg() in terms
> >     of four-byte cmpxchg().
> >
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Cc: Marco Elver <elver@google.com>
> >     Cc: Andrew Morton <akpm@linux-foundation.org>
> >     Cc: Thomas Gleixner <tglx@linutronix.de>
> >     Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> >     Cc: Douglas Anderson <dianders@chromium.org>
> >     Cc: Petr Mladek <pmladek@suse.com>
> >     Cc: <linux-arch@vger.kernel.org>
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 154f994547632..eef11e9918ec7 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1506,4 +1506,7 @@ config FUNCTION_ALIGNMENT
> >         default 4 if FUNCTION_ALIGNMENT_4B
> >         default 0
> >
> > +config ARCH_NEED_CMPXCHG_1_2_EMU
> > +       bool
> > +
> >  endmenu
> > diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
> > new file mode 100644
> > index 0000000000000..fee8171fa05eb
> > --- /dev/null
> > +++ b/include/linux/cmpxchg-emu.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Emulated 1-byte and 2-byte cmpxchg operations for architectures
> > + * lacking direct support for these sizes.  These are implemented in terms
> > + * of 4-byte cmpxchg operations.
> > + *
> > + * Copyright (C) 2024 Paul E. McKenney.
> > + */
> > +
> > +#ifndef __LINUX_CMPXCHG_EMU_H
> > +#define __LINUX_CMPXCHG_EMU_H
> > +
> > +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> > +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);
> > +
> > +#endif /* __LINUX_CMPXCHG_EMU_H */
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 6b09731d8e619..fecd7b8c09cbd 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -238,6 +238,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
> >  lib-$(CONFIG_GENERIC_BUG) += bug.o
> >
> >  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> > +obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_2_EMU) += cmpxchg-emu.o
>
> Since you add instrumentation explicitly, we need to suppress
> instrumentation somehow. For the whole file this can be done with:
>
> KCSAN_SANITIZE_cmpxchg-emu.o := n

Hrm, I recall this doesn't actually work as-is because it also
disables instrument_read_write() instrumentation.

So I think the most reliable would be to use data_race() after all.
It'll be a bit slower because of double-instrumenting, but I think
that's not a major concern with an instrumented build anyway.

> Note, since you use cmpxchg, which pulls in its own
> instrument_read_write(), we can't use a function attribute (like
> __no_kcsan) if the whole-file no-instrumentation seems like overkill.
> Alternatively the cmpxchg could be wrapped into a data_race() (like
> your original RCU use case was doing).
>
> But I think "KCSAN_SANITIZE_cmpxchg-emu.o := n" would be my preferred way.
>
> With the explicit "instrument_read_write()" also note that this would
> do double-instrumentation with other sanitizers (KASAN, KMSAN). But I
> think we actually want to instrument the whole real access with those
> tools - would it be bad if we accessed some memory out-of-bounds, but
> that memory isn't actually used? I don't have a clear answer to that.
>
> Also, it might be useful to have an alignment check somewhere, because
> otherwise we end up with split atomic accesses (or whatever other bad
> thing the given arch does if that happens).
>
> Thanks,
> -- Marco
>
> >  obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
> >  #ensure exported functions have prototypes
> > diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
> > new file mode 100644
> > index 0000000000000..508b55484c2b6
> > --- /dev/null
> > +++ b/lib/cmpxchg-emu.c
> > @@ -0,0 +1,68 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Emulated 1-byte and 2-byte cmpxchg operations for architectures
> > + * lacking direct support for these sizes.  These are implemented in terms
> > + * of 4-byte cmpxchg operations.
> > + *
> > + * Copyright (C) 2024 Paul E. McKenney.
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/export.h>
> > +#include <linux/instrumented.h>
> > +#include <linux/atomic.h>
> > +#include <asm-generic/rwonce.h>
> > +
> > +union u8_32 {
> > +       u8 b[4];
> > +       u32 w;
> > +};
> > +
> > +/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> > +{
> > +       u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> > +       int i = ((uintptr_t)p) & 0x3;
> > +       union u8_32 old32;
> > +       union u8_32 new32;
> > +       u32 ret;
> > +
> > +       old32.w = READ_ONCE(*p32);
> > +       do {
> > +               if (old32.b[i] != old)
> > +                       return old32.b[i];
> > +               new32.w = old32.w;
> > +               new32.b[i] = new;
> > +               instrument_atomic_read_write(p, 1);
> > +               ret = cmpxchg(p32, old32.w, new32.w);
> > +       } while (ret != old32.w);
> > +       return old;
> > +}
> > +EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
> > +
> > +union u16_32 {
> > +       u16 h[2];
> > +       u32 w;
> > +};
> > +
> > +/* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
> > +{
> > +       u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x1);
> > +       int i = ((uintptr_t)p) & 0x1;
> > +       union u16_32 old32;
> > +       union u16_32 new32;
> > +       u32 ret;
> > +
> > +       old32.w = READ_ONCE(*p32);
> > +       do {
> > +               if (old32.h[i] != old)
> > +                       return old32.h[i];
> > +               new32.w = old32.w;
> > +               new32.h[i] = new;
> > +               instrument_atomic_read_write(p, 2);
> > +               ret = cmpxchg(p32, old32.w, new32.w);
> > +       } while (ret != old32.w);
> > +       return old;
> > +}
> > +EXPORT_SYMBOL_GPL(cmpxchg_emu_u16);
