Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB592CCB3
	for <rcu@vger.kernel.org>; Mon, 18 Mar 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756103; cv=none; b=bTMJF6498sxXE9JkKrPF28q1nuTov828R/Asl0dWNTAJNGnjvv8G5REgGStTfN6Qwwnjs6KPzDLLUZEyqZN+w9wPcIXwX+mQShBqQGBstNraj2ZdldHclCB/RykGHecHAxGT+wTtptPjr/lPbvcMgTr0k7t9t0di1A/Xw7npzE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756103; c=relaxed/simple;
	bh=sxebygDQ0QV0N5PVOlJxDncEKkualXBOVuiJnO4HvhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aw1LQMpwl/Vyqzt2LKt3Ksbk19p0j1VbSKd49rZoYg5PAOgi0bZxJdMPHr0t2omZhgBh+H7Aa1MITVoGjNqsVyliR3K7NH7Em1uefli7eWP1Dd4vJh7PQwvmuo99Ee7zMmVx9NcqS83PEwRbvet7W4YNVbZm6vZmn6DH4zwJqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OwPAdm+R; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OwPAdm+R"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7de1f4be3f1so744031241.2
        for <rcu@vger.kernel.org>; Mon, 18 Mar 2024 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710756101; x=1711360901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NkcFjWrPC/z/IWM9mtgoQ+vuIaa1qEaVEiYJ1GABHoE=;
        b=OwPAdm+RjQpC45/jS49VQPZv/Kn+tDjc6Qn2oJByetdjtHzRXlhBaRh412kOk3vZB9
         8hKDQaavhIwPpYa2h5LCvRGRfO8ct39MCzbydQrbHP5DzM4FtP4yH7P0pqKeJHz98Y+R
         KvM5D0WCKqbiNkzcO9uFIrLuqyz5ZT/BDjCn6vbhxn+WSAjFcnUOLxHRF9I1WpodUSy/
         Ie12e8UOBPPxmRxNlfQtDbstIj5HelIWR/AhGUagD35L9M7Tl4XiQ61+4S1mDVRdn2Rs
         KRwFpvBJsEGgUrZG+vYmr2kGTpXCDAO8yZqhlBId76a16gkt0mLBQM2DeFSXcIW44gmG
         +/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710756101; x=1711360901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkcFjWrPC/z/IWM9mtgoQ+vuIaa1qEaVEiYJ1GABHoE=;
        b=USQixrMamx7dB0mbgw3n8hk5MwYkYpArMiaCWFXe5XYuSvcQjz0D5YCbhmg1tu1i2A
         q3APbUGDv+dpuMGwMt+tTNqQ4FP7zmadBW4P30i66C7xvolDzXtoRMaC7uQLN1zSThty
         NT/4rAn5aPnbhwbLSRcN3pdqjwcwjrnHe5QPOyPNdDN8aYn5xhNBcNjaZI7HVWhhdVGs
         f2MincaZRReKuabcGPpXP+HG2GV/xfdj78ck0q417QhIciWjVLIhYJrhbGZu8CY/syy7
         Wqi6KS0rDAN//ZdLEzVtvmhqHWHjWCPYHHai4vCLdPpPZWDmWn9dYtCGnHbNn9nWN4P8
         fV/A==
X-Gm-Message-State: AOJu0Yz4yvM2Uo3hW3WLIc4GYNLEkBMNpKjRLX7QNaFk63Wfv0h3pWvg
	fkZkcg3NDw65TAJZ0v0kdMIxBYe5immK6qe8HLffmJtpPpA4TTEYfI+Itv9WxYddZWJMdjTkUj7
	/VRL/TfWNOUF9iESau64te/TsnYN6Il+VNkAe
X-Google-Smtp-Source: AGHT+IHuQBKnNgJpR4WoxHxuDnHeaxZCb/z97X2UNVI9+k60IgWbAX1ALDgT4NgKszrXgl7GzrID4RGMw0PZJDDPzVI=
X-Received: by 2002:a05:6102:2265:b0:472:9ce3:dccb with SMTP id
 v5-20020a056102226500b004729ce3dccbmr9426917vsd.30.1710756100583; Mon, 18 Mar
 2024 03:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop>
 <CANpmjNO+0d82rPCQ22xrEEqW_3sk7T28Dv95k1jnB7YmG3amjA@mail.gmail.com>
 <53a68e29-cd33-451e-8cf0-f6576da40ced@paulmck-laptop> <67baae71-da4f-4eda-ace7-e4f61d2ced0c@paulmck-laptop>
In-Reply-To: <67baae71-da4f-4eda-ace7-e4f61d2ced0c@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Mon, 18 Mar 2024 11:01:03 +0100
Message-ID: <CANpmjNOmpOCfaFyMUnMtc3TT=VuTpWC4c85FW_u4dobmtikHtQ@mail.gmail.com>
Subject: Re: [PATCH RFC rcu] Inform KCSAN of one-byte cmpxchg() in rcu_trc_cmpxchg_need_qs()
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, kasan-dev@googlegroups.com, dvyukov@google.com, 
	glider@google.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Mar 2024 at 22:55, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Mar 08, 2024 at 02:31:53PM -0800, Paul E. McKenney wrote:
> > On Fri, Mar 08, 2024 at 11:02:28PM +0100, Marco Elver wrote:
> > > On Fri, 8 Mar 2024 at 22:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > Tasks Trace RCU needs a single-byte cmpxchg(), but no such thing exists.
> > >
> > > Because not all architectures support 1-byte cmpxchg?
> > > What prevents us from implementing it?
> >
> > Nothing that I know of, but I didn't want to put up with the KCSAN report
> > in the interim.
>
> And here is a lightly tested patch to emulate one-byte and two-byte
> cmpxchg() for architectures that do not support it.  This is just the
> emulation, and would be followed up with patches to make the relevant
> architectures make use of it.
>
> The one-byte emulation has been lightly tested on x86.
>
> Thoughts?
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit d72e54166b56d8b373676e1e92a426a07d53899a
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Sun Mar 17 14:44:38 2024 -0700
>
>     lib: Add one-byte and two-byte cmpxchg() emulation functions
>
>     Architectures are required to provide four-byte cmpxchg() and 64-bit
>     architectures are additionally required to provide eight-byte cmpxchg().
>     However, there are cases where one-byte and two-byte cmpxchg()
>     would be extremely useful.  Therefore, provide cmpxchg_emu_u8() and
>     cmpxchg_emu_u16() that emulated one-byte and two-byte cmpxchg() in terms
>     of four-byte cmpxchg().
>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Marco Elver <elver@google.com>
>     Cc: Andrew Morton <akpm@linux-foundation.org>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>     Cc: Douglas Anderson <dianders@chromium.org>
>     Cc: Petr Mladek <pmladek@suse.com>
>     Cc: <linux-arch@vger.kernel.org>
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 154f994547632..eef11e9918ec7 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1506,4 +1506,7 @@ config FUNCTION_ALIGNMENT
>         default 4 if FUNCTION_ALIGNMENT_4B
>         default 0
>
> +config ARCH_NEED_CMPXCHG_1_2_EMU
> +       bool
> +
>  endmenu
> diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
> new file mode 100644
> index 0000000000000..fee8171fa05eb
> --- /dev/null
> +++ b/include/linux/cmpxchg-emu.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Emulated 1-byte and 2-byte cmpxchg operations for architectures
> + * lacking direct support for these sizes.  These are implemented in terms
> + * of 4-byte cmpxchg operations.
> + *
> + * Copyright (C) 2024 Paul E. McKenney.
> + */
> +
> +#ifndef __LINUX_CMPXCHG_EMU_H
> +#define __LINUX_CMPXCHG_EMU_H
> +
> +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);
> +
> +#endif /* __LINUX_CMPXCHG_EMU_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index 6b09731d8e619..fecd7b8c09cbd 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -238,6 +238,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
>  lib-$(CONFIG_GENERIC_BUG) += bug.o
>
>  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> +obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_2_EMU) += cmpxchg-emu.o

Since you add instrumentation explicitly, we need to suppress
instrumentation somehow. For the whole file this can be done with:

KCSAN_SANITIZE_cmpxchg-emu.o := n

Note, since you use cmpxchg, which pulls in its own
instrument_read_write(), we can't use a function attribute (like
__no_kcsan) if the whole-file no-instrumentation seems like overkill.
Alternatively the cmpxchg could be wrapped into a data_race() (like
your original RCU use case was doing).

But I think "KCSAN_SANITIZE_cmpxchg-emu.o := n" would be my preferred way.

With the explicit "instrument_read_write()" also note that this would
do double-instrumentation with other sanitizers (KASAN, KMSAN). But I
think we actually want to instrument the whole real access with those
tools - would it be bad if we accessed some memory out-of-bounds, but
that memory isn't actually used? I don't have a clear answer to that.

Also, it might be useful to have an alignment check somewhere, because
otherwise we end up with split atomic accesses (or whatever other bad
thing the given arch does if that happens).

Thanks,
-- Marco

>  obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
>  #ensure exported functions have prototypes
> diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
> new file mode 100644
> index 0000000000000..508b55484c2b6
> --- /dev/null
> +++ b/lib/cmpxchg-emu.c
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Emulated 1-byte and 2-byte cmpxchg operations for architectures
> + * lacking direct support for these sizes.  These are implemented in terms
> + * of 4-byte cmpxchg operations.
> + *
> + * Copyright (C) 2024 Paul E. McKenney.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/export.h>
> +#include <linux/instrumented.h>
> +#include <linux/atomic.h>
> +#include <asm-generic/rwonce.h>
> +
> +union u8_32 {
> +       u8 b[4];
> +       u32 w;
> +};
> +
> +/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> +{
> +       u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> +       int i = ((uintptr_t)p) & 0x3;
> +       union u8_32 old32;
> +       union u8_32 new32;
> +       u32 ret;
> +
> +       old32.w = READ_ONCE(*p32);
> +       do {
> +               if (old32.b[i] != old)
> +                       return old32.b[i];
> +               new32.w = old32.w;
> +               new32.b[i] = new;
> +               instrument_atomic_read_write(p, 1);
> +               ret = cmpxchg(p32, old32.w, new32.w);
> +       } while (ret != old32.w);
> +       return old;
> +}
> +EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
> +
> +union u16_32 {
> +       u16 h[2];
> +       u32 w;
> +};
> +
> +/* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
> +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
> +{
> +       u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x1);
> +       int i = ((uintptr_t)p) & 0x1;
> +       union u16_32 old32;
> +       union u16_32 new32;
> +       u32 ret;
> +
> +       old32.w = READ_ONCE(*p32);
> +       do {
> +               if (old32.h[i] != old)
> +                       return old32.h[i];
> +               new32.w = old32.w;
> +               new32.h[i] = new;
> +               instrument_atomic_read_write(p, 2);
> +               ret = cmpxchg(p32, old32.w, new32.w);
> +       } while (ret != old32.w);
> +       return old;
> +}
> +EXPORT_SYMBOL_GPL(cmpxchg_emu_u16);
