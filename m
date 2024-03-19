Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EADC64CCE
	for <rcu@vger.kernel.org>; Tue, 19 Mar 2024 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710813583; cv=none; b=bBU6lOUJ9WtDu1LoNuhggtLgqs9j0MABWAnfS0MVTyM14vDVVur1h8KFCtlMD4Z99uKSn+QfpFMGSOcT8OarhVmPyM2OxAgL4C8ndx86riiPld6cZYVKWP+xwWDhJVHgpCD0lg37ZuuAc1YUwqV8HgTprLpkFP4oIRWminPkme8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710813583; c=relaxed/simple;
	bh=a/8DvZ9X8c9aNYGSZxTDSm7trB6UU+sFas83vgJM+eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXGSSsltE4EqJyTTWuUQj2OAgUFy1YsN6pih7UhUgisb+yo4iXini6UZEyYAblHFfIqquZQg8o62/IVoW+Sd0/HNXidgdwmqK9btQNHIrRlWlP4LygS1hDBkj1P5Mgvn1Af+tiTacHoKlTt+BcFszsxufN/ZDhiIoiyqky4ephM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAp7+5Xn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAp7+5Xn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3631C433C7;
	Tue, 19 Mar 2024 01:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710813583;
	bh=a/8DvZ9X8c9aNYGSZxTDSm7trB6UU+sFas83vgJM+eQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pAp7+5XnUGpY3k4gicPcZTlGcyPQVt7pdgXBE1ScOqZCdFrFsH6LyU07PFk/RXKLv
	 OC61IdhDuBNCkLOnA89EJKjx5D8z4kPc0PsCiPr0RWaDEPQsCdG8GyBqDKFJ3XTDwj
	 DektPzN0iFemUAD9QxB1CjGty9osvAfXsTbopc8Scvw4Z1uoNOdkholzj7yHAzalEK
	 BezpvN99snLNhyVhTkeTWdnQmuTSueisbiWTarOYdoYmtTZhBR7cUl5nynbz1OFJIz
	 P6kt3uwKSAevsaRBNNlAt3jKRfS+lHjcr3a9bAIykpScxBA9P+hiK0PPShi3K79B8s
	 KjJmNx60dRpMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 688EACE0D20; Mon, 18 Mar 2024 18:59:41 -0700 (PDT)
Date: Mon, 18 Mar 2024 18:59:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: rcu@vger.kernel.org, kasan-dev@googlegroups.com, dvyukov@google.com,
	glider@google.com
Subject: Re: [PATCH RFC rcu] Inform KCSAN of one-byte cmpxchg() in
 rcu_trc_cmpxchg_need_qs()
Message-ID: <5e6fdf1d-e84c-463c-b47b-f42500930b28@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop>
 <CANpmjNO+0d82rPCQ22xrEEqW_3sk7T28Dv95k1jnB7YmG3amjA@mail.gmail.com>
 <53a68e29-cd33-451e-8cf0-f6576da40ced@paulmck-laptop>
 <67baae71-da4f-4eda-ace7-e4f61d2ced0c@paulmck-laptop>
 <CANpmjNOmpOCfaFyMUnMtc3TT=VuTpWC4c85FW_u4dobmtikHtQ@mail.gmail.com>
 <CANpmjNNLXR1kC8XAqFjEO3N0P3scRott8Z1OcW2yoKu5BEDaYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNLXR1kC8XAqFjEO3N0P3scRott8Z1OcW2yoKu5BEDaYQ@mail.gmail.com>

On Mon, Mar 18, 2024 at 04:43:38PM +0100, Marco Elver wrote:
> On Mon, 18 Mar 2024 at 11:01, Marco Elver <elver@google.com> wrote:
> >
> > On Sun, 17 Mar 2024 at 22:55, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Fri, Mar 08, 2024 at 02:31:53PM -0800, Paul E. McKenney wrote:
> > > > On Fri, Mar 08, 2024 at 11:02:28PM +0100, Marco Elver wrote:
> > > > > On Fri, 8 Mar 2024 at 22:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > Tasks Trace RCU needs a single-byte cmpxchg(), but no such thing exists.
> > > > >
> > > > > Because not all architectures support 1-byte cmpxchg?
> > > > > What prevents us from implementing it?
> > > >
> > > > Nothing that I know of, but I didn't want to put up with the KCSAN report
> > > > in the interim.
> > >
> > > And here is a lightly tested patch to emulate one-byte and two-byte
> > > cmpxchg() for architectures that do not support it.  This is just the
> > > emulation, and would be followed up with patches to make the relevant
> > > architectures make use of it.
> > >
> > > The one-byte emulation has been lightly tested on x86.
> > >
> > > Thoughts?
> > >
> > >                                                         Thanx, Paul
> > >
> > > ------------------------------------------------------------------------
> > >
> > > commit d72e54166b56d8b373676e1e92a426a07d53899a
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Sun Mar 17 14:44:38 2024 -0700
> > >
> > >     lib: Add one-byte and two-byte cmpxchg() emulation functions
> > >
> > >     Architectures are required to provide four-byte cmpxchg() and 64-bit
> > >     architectures are additionally required to provide eight-byte cmpxchg().
> > >     However, there are cases where one-byte and two-byte cmpxchg()
> > >     would be extremely useful.  Therefore, provide cmpxchg_emu_u8() and
> > >     cmpxchg_emu_u16() that emulated one-byte and two-byte cmpxchg() in terms
> > >     of four-byte cmpxchg().
> > >
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >     Cc: Marco Elver <elver@google.com>
> > >     Cc: Andrew Morton <akpm@linux-foundation.org>
> > >     Cc: Thomas Gleixner <tglx@linutronix.de>
> > >     Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > >     Cc: Douglas Anderson <dianders@chromium.org>
> > >     Cc: Petr Mladek <pmladek@suse.com>
> > >     Cc: <linux-arch@vger.kernel.org>
> > >
> > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > index 154f994547632..eef11e9918ec7 100644
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -1506,4 +1506,7 @@ config FUNCTION_ALIGNMENT
> > >         default 4 if FUNCTION_ALIGNMENT_4B
> > >         default 0
> > >
> > > +config ARCH_NEED_CMPXCHG_1_2_EMU
> > > +       bool
> > > +
> > >  endmenu
> > > diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
> > > new file mode 100644
> > > index 0000000000000..fee8171fa05eb
> > > --- /dev/null
> > > +++ b/include/linux/cmpxchg-emu.h
> > > @@ -0,0 +1,16 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +/*
> > > + * Emulated 1-byte and 2-byte cmpxchg operations for architectures
> > > + * lacking direct support for these sizes.  These are implemented in terms
> > > + * of 4-byte cmpxchg operations.
> > > + *
> > > + * Copyright (C) 2024 Paul E. McKenney.
> > > + */
> > > +
> > > +#ifndef __LINUX_CMPXCHG_EMU_H
> > > +#define __LINUX_CMPXCHG_EMU_H
> > > +
> > > +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> > > +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);
> > > +
> > > +#endif /* __LINUX_CMPXCHG_EMU_H */
> > > diff --git a/lib/Makefile b/lib/Makefile
> > > index 6b09731d8e619..fecd7b8c09cbd 100644
> > > --- a/lib/Makefile
> > > +++ b/lib/Makefile
> > > @@ -238,6 +238,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
> > >  lib-$(CONFIG_GENERIC_BUG) += bug.o
> > >
> > >  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> > > +obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_2_EMU) += cmpxchg-emu.o
> >
> > Since you add instrumentation explicitly, we need to suppress
> > instrumentation somehow. For the whole file this can be done with:
> >
> > KCSAN_SANITIZE_cmpxchg-emu.o := n
> 
> Hrm, I recall this doesn't actually work as-is because it also
> disables instrument_read_write() instrumentation.
> 
> So I think the most reliable would be to use data_race() after all.
> It'll be a bit slower because of double-instrumenting, but I think
> that's not a major concern with an instrumented build anyway.

And I have added data_race(), thank you!

> > Note, since you use cmpxchg, which pulls in its own
> > instrument_read_write(), we can't use a function attribute (like
> > __no_kcsan) if the whole-file no-instrumentation seems like overkill.
> > Alternatively the cmpxchg could be wrapped into a data_race() (like
> > your original RCU use case was doing).
> >
> > But I think "KCSAN_SANITIZE_cmpxchg-emu.o := n" would be my preferred way.
> >
> > With the explicit "instrument_read_write()" also note that this would
> > do double-instrumentation with other sanitizers (KASAN, KMSAN). But I
> > think we actually want to instrument the whole real access with those
> > tools - would it be bad if we accessed some memory out-of-bounds, but
> > that memory isn't actually used? I don't have a clear answer to that.
> >
> > Also, it might be useful to have an alignment check somewhere, because
> > otherwise we end up with split atomic accesses (or whatever other bad
> > thing the given arch does if that happens).

Excellent point, added.

I also fixed an embarrassing pointer-arithmetic bug which the act of
coding the alignment check uncovered, so two for one!  ;-)

Please see below for a patch to the patched code.

							Thanx, Paul

> > Thanks,
> > -- Marco
> >
> > >  obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
> > >  #ensure exported functions have prototypes
> > > diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
> > > new file mode 100644
> > > index 0000000000000..508b55484c2b6
> > > --- /dev/null
> > > +++ b/lib/cmpxchg-emu.c
> > > @@ -0,0 +1,68 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +/*
> > > + * Emulated 1-byte and 2-byte cmpxchg operations for architectures
> > > + * lacking direct support for these sizes.  These are implemented in terms
> > > + * of 4-byte cmpxchg operations.
> > > + *
> > > + * Copyright (C) 2024 Paul E. McKenney.
> > > + */
> > > +
> > > +#include <linux/types.h>
> > > +#include <linux/export.h>
> > > +#include <linux/instrumented.h>
> > > +#include <linux/atomic.h>
> > > +#include <asm-generic/rwonce.h>
> > > +
> > > +union u8_32 {
> > > +       u8 b[4];
> > > +       u32 w;
> > > +};
> > > +
> > > +/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > > +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> > > +{
> > > +       u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> > > +       int i = ((uintptr_t)p) & 0x3;
> > > +       union u8_32 old32;
> > > +       union u8_32 new32;
> > > +       u32 ret;
> > > +
> > > +       old32.w = READ_ONCE(*p32);
> > > +       do {
> > > +               if (old32.b[i] != old)
> > > +                       return old32.b[i];
> > > +               new32.w = old32.w;
> > > +               new32.b[i] = new;
> > > +               instrument_atomic_read_write(p, 1);
> > > +               ret = cmpxchg(p32, old32.w, new32.w);
> > > +       } while (ret != old32.w);
> > > +       return old;
> > > +}
> > > +EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
> > > +
> > > +union u16_32 {
> > > +       u16 h[2];
> > > +       u32 w;
> > > +};
> > > +
> > > +/* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > > +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
> > > +{
> > > +       u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x1);
> > > +       int i = ((uintptr_t)p) & 0x1;
> > > +       union u16_32 old32;
> > > +       union u16_32 new32;
> > > +       u32 ret;
> > > +
> > > +       old32.w = READ_ONCE(*p32);
> > > +       do {
> > > +               if (old32.h[i] != old)
> > > +                       return old32.h[i];
> > > +               new32.w = old32.w;
> > > +               new32.h[i] = new;
> > > +               instrument_atomic_read_write(p, 2);
> > > +               ret = cmpxchg(p32, old32.w, new32.w);
> > > +       } while (ret != old32.w);
> > > +       return old;
> > > +}
> > > +EXPORT_SYMBOL_GPL(cmpxchg_emu_u16);

diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
index 508b55484c2b6..b904f954dd4fc 100644
--- a/lib/cmpxchg-emu.c
+++ b/lib/cmpxchg-emu.c
@@ -11,6 +11,8 @@
 #include <linux/export.h>
 #include <linux/instrumented.h>
 #include <linux/atomic.h>
+#include <linux/panic.h>
+#include <linux/bug.h>
 #include <asm-generic/rwonce.h>
 
 union u8_32 {
@@ -34,7 +36,7 @@ uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
 		new32.w = old32.w;
 		new32.b[i] = new;
 		instrument_atomic_read_write(p, 1);
-		ret = cmpxchg(p32, old32.w, new32.w);
+		ret = data_race(cmpxchg(p32, old32.w, new32.w));
 	} while (ret != old32.w);
 	return old;
 }
@@ -48,12 +50,13 @@ union u16_32 {
 /* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
 uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
 {
-	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x1);
-	int i = ((uintptr_t)p) & 0x1;
+	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
+	int i = (((uintptr_t)p) & 0x2) / 2;
 	union u16_32 old32;
 	union u16_32 new32;
 	u32 ret;
 
+	WARN_ON_ONCE(((uintptr_t)p) & 0x1);
 	old32.w = READ_ONCE(*p32);
 	do {
 		if (old32.h[i] != old)
@@ -61,7 +64,7 @@ uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
 		new32.w = old32.w;
 		new32.h[i] = new;
 		instrument_atomic_read_write(p, 2);
-		ret = cmpxchg(p32, old32.w, new32.w);
+		ret = data_race(cmpxchg(p32, old32.w, new32.w));
 	} while (ret != old32.w);
 	return old;
 }
