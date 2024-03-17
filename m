Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB41B7F7
	for <rcu@vger.kernel.org>; Sun, 17 Mar 2024 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710712506; cv=none; b=ihSbmd3q/AEtQYG8tsi0vNGfzIMme2jrr05bqcDYPKx3Z1JrazZ5tpZTqs8U7uxNEb+UQYlhaYI/ZO8vctlbIYx6THpstpvDWPg29/BximyPP55wbirKyVKylRbpIGpcQNJTiFPmYvCrHeq52IqBSR3Nbh+VhslK4z4x22G9+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710712506; c=relaxed/simple;
	bh=bmHPZnpEeh88KjQRhUANavCdLAiqBsQfZUBAtRHfOHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPbQzAaJeyXV865DGvAUdjrS9vJH7HyMiLPu6lE8xND8oau/GxwFF5k6xpDudTCKoPyE4NO6GlNlXZ4czLMQBKRZ1ktIBX13a3IqHVAsLdd5i28416SjWF1nUHIZcaaDDGrkDKXnzE/thry3eHAysqwG1JCbSxoEsBfuR1XFiFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRal4fPo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRal4fPo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A35FC433F1;
	Sun, 17 Mar 2024 21:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710712505;
	bh=bmHPZnpEeh88KjQRhUANavCdLAiqBsQfZUBAtRHfOHs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eRal4fPo79J6L5Qmvr5T7LAy3TaHD48cKgIBu9j/0DVejozZYhCkp3A/TzU0zMeux
	 jh0fA3iDOrSfvzdvnCiv7ekysBX48HDKi07V5JYAEnd023w2UBE9goJlM/2gzkBhak
	 Dy+gntx9IgBcZ0sEFKeVy6PGLtyD36KMS5eG4gy1EIEVZlBv6AGYO8A98ikSEPae1w
	 /j/TnQD/vQTva/nIkizQ6euAOnXihZYCxDMDwOgSWgD7Y76ed/8BxldaubmUnVlyNq
	 H0jeJOh/lU1Ufa9WlNmn2eLLlX6eOvoJIZCmAASLOq4jH42TPQQf1Bkk4w3UOcfiMJ
	 W8NcltJHjJSxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7745CE0D83; Sun, 17 Mar 2024 14:55:01 -0700 (PDT)
Date: Sun, 17 Mar 2024 14:55:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: rcu@vger.kernel.org, kasan-dev@googlegroups.com, dvyukov@google.com,
	glider@google.com
Subject: Re: [PATCH RFC rcu] Inform KCSAN of one-byte cmpxchg() in
 rcu_trc_cmpxchg_need_qs()
Message-ID: <67baae71-da4f-4eda-ace7-e4f61d2ced0c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop>
 <CANpmjNO+0d82rPCQ22xrEEqW_3sk7T28Dv95k1jnB7YmG3amjA@mail.gmail.com>
 <53a68e29-cd33-451e-8cf0-f6576da40ced@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a68e29-cd33-451e-8cf0-f6576da40ced@paulmck-laptop>

On Fri, Mar 08, 2024 at 02:31:53PM -0800, Paul E. McKenney wrote:
> On Fri, Mar 08, 2024 at 11:02:28PM +0100, Marco Elver wrote:
> > On Fri, 8 Mar 2024 at 22:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > Tasks Trace RCU needs a single-byte cmpxchg(), but no such thing exists.
> > 
> > Because not all architectures support 1-byte cmpxchg?
> > What prevents us from implementing it?
> 
> Nothing that I know of, but I didn't want to put up with the KCSAN report
> in the interim.

And here is a lightly tested patch to emulate one-byte and two-byte
cmpxchg() for architectures that do not support it.  This is just the
emulation, and would be followed up with patches to make the relevant
architectures make use of it.

The one-byte emulation has been lightly tested on x86.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit d72e54166b56d8b373676e1e92a426a07d53899a
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sun Mar 17 14:44:38 2024 -0700

    lib: Add one-byte and two-byte cmpxchg() emulation functions
    
    Architectures are required to provide four-byte cmpxchg() and 64-bit
    architectures are additionally required to provide eight-byte cmpxchg().
    However, there are cases where one-byte and two-byte cmpxchg()
    would be extremely useful.  Therefore, provide cmpxchg_emu_u8() and
    cmpxchg_emu_u16() that emulated one-byte and two-byte cmpxchg() in terms
    of four-byte cmpxchg().
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Marco Elver <elver@google.com>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
    Cc: Douglas Anderson <dianders@chromium.org>
    Cc: Petr Mladek <pmladek@suse.com>
    Cc: <linux-arch@vger.kernel.org>

diff --git a/arch/Kconfig b/arch/Kconfig
index 154f994547632..eef11e9918ec7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1506,4 +1506,7 @@ config FUNCTION_ALIGNMENT
 	default 4 if FUNCTION_ALIGNMENT_4B
 	default 0
 
+config ARCH_NEED_CMPXCHG_1_2_EMU
+	bool
+
 endmenu
diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
new file mode 100644
index 0000000000000..fee8171fa05eb
--- /dev/null
+++ b/include/linux/cmpxchg-emu.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Emulated 1-byte and 2-byte cmpxchg operations for architectures
+ * lacking direct support for these sizes.  These are implemented in terms
+ * of 4-byte cmpxchg operations.
+ *
+ * Copyright (C) 2024 Paul E. McKenney.
+ */
+
+#ifndef __LINUX_CMPXCHG_EMU_H
+#define __LINUX_CMPXCHG_EMU_H
+
+uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
+uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);
+
+#endif /* __LINUX_CMPXCHG_EMU_H */
diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e619..fecd7b8c09cbd 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -238,6 +238,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
+obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_2_EMU) += cmpxchg-emu.o
 
 obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
 #ensure exported functions have prototypes
diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
new file mode 100644
index 0000000000000..508b55484c2b6
--- /dev/null
+++ b/lib/cmpxchg-emu.c
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Emulated 1-byte and 2-byte cmpxchg operations for architectures
+ * lacking direct support for these sizes.  These are implemented in terms
+ * of 4-byte cmpxchg operations.
+ *
+ * Copyright (C) 2024 Paul E. McKenney.
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/instrumented.h>
+#include <linux/atomic.h>
+#include <asm-generic/rwonce.h>
+
+union u8_32 {
+	u8 b[4];
+	u32 w;
+};
+
+/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
+uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
+{
+	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
+	int i = ((uintptr_t)p) & 0x3;
+	union u8_32 old32;
+	union u8_32 new32;
+	u32 ret;
+
+	old32.w = READ_ONCE(*p32);
+	do {
+		if (old32.b[i] != old)
+			return old32.b[i];
+		new32.w = old32.w;
+		new32.b[i] = new;
+		instrument_atomic_read_write(p, 1);
+		ret = cmpxchg(p32, old32.w, new32.w);
+	} while (ret != old32.w);
+	return old;
+}
+EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
+
+union u16_32 {
+	u16 h[2];
+	u32 w;
+};
+
+/* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
+uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
+{
+	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x1);
+	int i = ((uintptr_t)p) & 0x1;
+	union u16_32 old32;
+	union u16_32 new32;
+	u32 ret;
+
+	old32.w = READ_ONCE(*p32);
+	do {
+		if (old32.h[i] != old)
+			return old32.h[i];
+		new32.w = old32.w;
+		new32.h[i] = new;
+		instrument_atomic_read_write(p, 2);
+		ret = cmpxchg(p32, old32.w, new32.w);
+	} while (ret != old32.w);
+	return old;
+}
+EXPORT_SYMBOL_GPL(cmpxchg_emu_u16);
