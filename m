Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305E449997
	for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139811; cv=pass; b=mwRzOK9HT1NmiMa4FZzYAJYXd74tgQ2EMlLdnTzCn4jcjXPeQRonomxqUr5gBpbmye8TZDaN/gLmF3lMKkBERT7CUjIoVJqnZKoVveHZQ+WCGC8sNlgbWd1lnYMm26G6WJyrntxFz1XuAcXgCuZ9eAduw9atllE3V5YMuq3Z5so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139811; c=relaxed/simple;
	bh=YGxrPNmKo+Cu2MYeesggWlBjJm+RWBe5YXtDpPU+Wk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwlNuBDcfGx+gzS2FBDbiRnL+02UpPWrIzD8XQEPZyTkl5Ew1lIF8jpjcX2StxU2gXlHOWRYeUXER6BEcXcXxDRLIDF/XRzkzt8s7vjmScON0ZfBRSpL09bpvxYdXHgkirzOGmarJ7EMMAJJvprsfTkA7EIa9HgCN6i/Af9Xdgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqhsdzYx; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqhsdzYx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso894299066b.1
        for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 01:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792139804; cv=none;
        d=google.com; s=arc-20260327;
        b=Z+a0TkM8L+UHDJBo/nBWYiP9+hpS3QY0v6Wr+bCc6Pu8cvT5tPPFux2UEY751tp4lt
         Lb0ltOc/dSmC1tYJCBXm4k99/teSKLLS5SGfAs0RxcVRyfNIgaMUJc6Blut/FMh7Bf//
         rG1VmHcZFqoZc0ONBmj6020lsTnNfwyI1Nnn3x2+RgXn+a96X0dDDEaHJrgkqQiwMJvH
         jTymdYxXQSoI+uKpXkVymrIANgExQdZJDamM8CNIl56MVZ0d8LzdOMf3LuatMT+KZbmK
         nFPfOTO/1V5RsRWJhdcwwQxaffi7Rbnt+WL70r1cXvIY1kgBVXMJMJs0LVZ0FDUCh0t0
         SN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ko2nFEKzryM0Joy0DntqtRQJcRZwX6j2MQIGWblaJQ0=;
        fh=E6kNr5lICEgMvr2/GQcOoEjqq7by6OAyF+Vf3iC1pdg=;
        b=bw/aSjbRmsN/QOmbSwjvJj8bt+KZ5empyAEoGgqCvklXPxmdp+OrlnMlQ5F4C1wxba
         EY6U7gs33HuF9Zf+K2QVw/9JW2/riBXE/JXEiSlPGOaBkE5q/6Uj/rodRXdP3I9Ywfml
         duxVxFb/bFKg58AZQa1pUvvIvCajlFPe8vQywvXYnhGFayWSZEY35HkHXusvAYFA4JFf
         DCee8xxxTwAjzemCqraAwO8cTq9NsFQPrHqr+PdO+wsY8ZVISl+nhkuvPQuezVu5I3P0
         t+uMt7OaL9T0MBtnLdUnqRMKCvN2M2upcboMgroC/FODXhfLB81vM+OYkkspWuszwBU5
         iuxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792139804; x=1792744604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ko2nFEKzryM0Joy0DntqtRQJcRZwX6j2MQIGWblaJQ0=;
        b=lqhsdzYxORC5/P5DIurlFwjMDo/C81fWfdmZdWHC5qZM7kxHa7E1XMysN28TUGCY/3
         fLhIx0LCwFymdrvoU1VTzBbbN2fac3kfz2D9mEyFFD1xjpSu6xUBlFceBAvpBcTjk/Y1
         ijspVC++y5RlBedH9WebDUHdhZ6MsDRBag6qEabjOiHiX50anEUTm9OJ0Z00Sm+H0ekr
         rJh3tHJWr3DSyoPYUJYdIibXNz6VWG02Z1hcd2LpSEZ6stpd7bCI20QOT3kGFa+TUgv6
         3vc7h1+DWmIym6BFDHtbLlEcS0gr8kmw8qiJsUno+ai9h9gLqsv7fURPb/qeDFLv2Dhs
         5RKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792139804; x=1792744604;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ko2nFEKzryM0Joy0DntqtRQJcRZwX6j2MQIGWblaJQ0=;
        b=e+oRzAGFm8P9b7VMcFrXH8SilG1ek+60oAxm9gdABfJl9e8ABh6jqSUjjvQ4owyZFU
         W9q++PzvJUbzc7ZYGfpd6+b9qqqmnshSYXgljjF9O6v6yTxWDs68mPoRDmMRebae9DSo
         +A/vQJq2OZUgTUffZY1ians6P6InXQiALt+T/yvjuargJMgNMpnPLe1QRnQuXGpPitYn
         iWhF2Bvyz7w+J++VWrq/kNd2Exd6i/wLs2fLFDKBIDzSNPyKWcauXAOiURFgMwywGh85
         POh/r6GyBoVijsAoW4IjDamf56b4S5p2FCVooG2LXP+ElxxqDd/VB0b3pdNbgZRgy32W
         JxQg==
X-Forwarded-Encrypted: i=1; AKwUvByYI3D3rDZhaBWOEEi/VggFnwYGSPV1sEgft5j990FClOmfVOE9ndW7+RuPa21ph0b1sVQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKn0UWaJZM6MrdUpmZ96hKzcH90zrIr+C0yNvVYjgDCJ+NfuW8G
	6emcdkwG3ziskZ6btI8sIVBZgdhjETx4eTLDzlPz0zqUzUjE2HY/UcR7OH9ZKzUMKyZM9oLhLf7
	z6d1Sw9iGi2/UmunnZpMgrh2+1WPPjiw=
X-Gm-Gg: AYBFou14vHXEj4Ohk21u2jtYterv8GfLLdKKl/0xfotm1OQmjotrkfP714x6PrB7SI/
	+6VE3JDT4zZCuCoPXSR9bZgmXxYJ1Fn1XQR38VkRq2ZcNy3ZJEKVhGu5jNqR+90LXHH417FQS7J
	O/WMYbXJyadfxmOGvgGuLs9UZ43FifVf8Zp6yXV3Ni82b6Ljn0bu+GUwbP/7secGv5l82D2rl+i
	VWz4NlgJ4LW1o7XYBBLIsPKEOIDDdT31r0O9MeXYH6MX90OxGGNYbNZ9oFv1jzBJ5XdMSuTAkVf
	/y1Br977D1MhzMKXVeZxvaJ0JEJA1dvPsOCGrm7AeA3ySfFqxEujETGd
X-Received: by 2002:a05:6938:a082:10b0:c3e:f39b:2286 with SMTP id
 a640c23a62f3a-c3ef39b2474mr293285166b.0.1792139803822; Fri, 16 Oct 2026
 01:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011194902.97364-1-mathieu.desnoyers@efficios.com> <20261011194902.97364-3-mathieu.desnoyers@efficios.com>
In-Reply-To: <20261011194902.97364-3-mathieu.desnoyers@efficios.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 16 Oct 2026 16:36:31 +0800
X-Gm-Features: AclHuK999gbk47tvgPj7S_99XIxJx7kM0oNSpmR7D65tPGL3PLvLQleVMZhU9_g
Message-ID: <CAN_Opa_aBH0iP+q_GoG=2JhVaCpgu6_K5S7hPDhLQ4u1jw=jqg@mail.gmail.com>
Subject: Re: [PATCH hazptr v3 2/4] ptr_eq.h: Introduce ptr_eq() to preserve
 address dependency
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, 
	John Stultz <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik <mjguzik@gmail.com>, 
	Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev, Nikita Popov <github@npopov.com>, llvm@lists.linux.dev, 
	Lian Wang <lianux.mm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

I checked both implementations of ptr_eq().

The x86 version uses inline asm for the comparison, so
the compiler cannot reason about it as an ordinary C
pointer comparison.

The generic version uses OPTIMIZER_HIDE_VAR() before
the comparison to prevent the compiler from propagating
the original pointer values through it. I verified this
with GCC 13.3 on ARM64: the generated code uses the
second load's result for the dependent access, rather
than reusing the first load's result.

Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

Thanks,
Kunwu

On Mon, Oct 12, 2026 at 3:49=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Compiler CSE and SSA GVN optimizations can cause the address dependency
> of addresses returned by rcu_dereference to be lost when comparing those
> pointers with either constants or previously loaded pointers.
>
> Introduce ptr_eq() to compare two addresses while preserving the address
> dependencies for later use of the address. It should be used when
> comparing an address returned by rcu_dereference().
>
> This is needed to prevent the compiler CSE and SSA GVN optimizations
> from using @a (or @b) in places where the source refers to @b (or @a)
> based on the fact that after the comparison, the two are known to be
> equal, which does not preserve address dependencies and allows the
> following misordering speculations:
>
> - If @b is a constant, the compiler can issue the loads which depend
>   on @a before loading @a.
> - If @b is a register populated by a prior load, weakly-ordered
>   CPUs can speculate loads which depend on @a before loading @a.
>
> The same logic applies with @a and @b swapped.
>
> The header "linux/ptr_eq.h" is the expected include target. It
> contains the documentation of the ptr_eq() API.
>
> An architecture specific implementation of the pointer comparison
> can be implemented by each architecture as asm/ptr_eq.h. The x86
> implementation is provided initially. If no implementation header is
> present for the architecture, an arch-agnostic fallback based on
> OPTIMIZER_HIDE_VAR is included from asm-generic.
>
> The arguments to ptr_eq() are const volatile to take advantage of
> implicit conversion that adds cv-qualifiers, which are thus added
> implicitly.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: John Stultz <jstultz@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: maged.michael@gmail.com
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: rcu@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: lkmm@lists.linux.dev
> Cc: Nikita Popov <github@npopov.com>
> Cc: llvm@lists.linux.dev
> Cc: Lian Wang <lianux.mm@gmail.com>
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> ---
> Changes since v2:
> - Rename ptreq.h to ptr_eq.h (x86, asm-generic and linux headers).
>   Adapt the include guards accordingly.
>
> Changes since v1:
> - Move to linux/ptreq.h, implement x86-specific comparison
>   and asm-generic header (fallback).
>
> Changes since v0:
> - Include feedback from Alan Stern.
> ---
>  arch/x86/include/asm/ptr_eq.h | 16 +++++++++
>  include/asm-generic/Kbuild    |  1 +
>  include/asm-generic/ptr_eq.h  | 16 +++++++++
>  include/linux/ptr_eq.h        | 63 +++++++++++++++++++++++++++++++++++
>  4 files changed, 96 insertions(+)
>  create mode 100644 arch/x86/include/asm/ptr_eq.h
>  create mode 100644 include/asm-generic/ptr_eq.h
>  create mode 100644 include/linux/ptr_eq.h
>
> diff --git a/arch/x86/include/asm/ptr_eq.h b/arch/x86/include/asm/ptr_eq.=
h
> new file mode 100644
> index 000000000000..8e521cabe24b
> --- /dev/null
> +++ b/arch/x86/include/asm/ptr_eq.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_PTR_EQ_H
> +#define _ASM_X86_PTR_EQ_H
> +
> +#include <linux/types.h>
> +#include <asm/asm.h>
> +
> +static __always_inline
> +bool ptr_eq(const volatile void *a, const volatile void *b)
> +{
> +       bool ret;
> +       asm(__ASM_SIZE(cmp) " %1,%2" : "=3D@ccz" (ret) : "r" (a), "r" (b)=
);
> +       return ret;
> +}
> +
> +#endif /* _ASM_X86_PTR_EQ_H */
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index 2bc00c67dc54..86cee0dfd47f 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -47,6 +47,7 @@ mandatory-y +=3D percpu.h
>  mandatory-y +=3D percpu_types.h
>  mandatory-y +=3D pgalloc.h
>  mandatory-y +=3D preempt.h
> +mandatory-y +=3D ptr_eq.h
>  mandatory-y +=3D rqspinlock.h
>  mandatory-y +=3D runtime-const.h
>  mandatory-y +=3D rwonce.h
> diff --git a/include/asm-generic/ptr_eq.h b/include/asm-generic/ptr_eq.h
> new file mode 100644
> index 000000000000..2bd1c3b8a56f
> --- /dev/null
> +++ b/include/asm-generic/ptr_eq.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_GENERIC_PTR_EQ_H
> +#define __ASM_GENERIC_PTR_EQ_H
> +
> +#include <linux/types.h>
> +#include <linux/compiler.h>
> +
> +static __always_inline
> +bool ptr_eq(const volatile void *a, const volatile void *b)
> +{
> +       OPTIMIZER_HIDE_VAR(a);
> +       OPTIMIZER_HIDE_VAR(b);
> +       return a =3D=3D b;
> +}
> +
> +#endif /* __ASM_GENERIC_PTR_EQ_H */
> diff --git a/include/linux/ptr_eq.h b/include/linux/ptr_eq.h
> new file mode 100644
> index 000000000000..7a2bbf6e64b3
> --- /dev/null
> +++ b/include/linux/ptr_eq.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PTR_EQ_H
> +#define _LINUX_PTR_EQ_H
> +
> +/*
> + * Compare two addresses while preserving the address dependencies for
> + * later use of the address. It should be used when comparing an address
> + * returned by rcu_dereference().
> + *
> + * This is needed to prevent the compiler CSE and SSA GVN optimizations
> + * from using @a (or @b) in places where the source refers to @b (or @a)
> + * based on the fact that after the comparison, the two are known to be
> + * equal, which does not preserve address dependencies and allows the
> + * following misordering speculations:
> + *
> + * - If @b is a constant, the compiler can issue the loads which depend
> + *   on @a before loading @a.
> + * - If @b is a register populated by a prior load, weakly-ordered
> + *   CPUs can speculate loads which depend on @a before loading @a.
> + *
> + * The same logic applies with @a and @b swapped.
> + *
> + * Return value: true if pointers are equal, false otherwise.
> + *
> + * The compiler barrier() is ineffective at fixing this issue. It does
> + * not prevent the compiler CSE from losing the address dependency:
> + *
> + * int fct_2_volatile_barriers(void)
> + * {
> + *     int *a, *b;
> + *
> + *     do {
> + *         a =3D READ_ONCE(p);
> + *         asm volatile ("" : : : "memory");
> + *         b =3D READ_ONCE(p);
> + *     } while (a !=3D b);
> + *     asm volatile ("" : : : "memory");  <-- barrier()
> + *     return *b;
> + * }
> + *
> + * With gcc 14.2 (arm64):
> + *
> + * fct_2_volatile_barriers:
> + *         adrp    x0, .LANCHOR0
> + *         add     x0, x0, :lo12:.LANCHOR0
> + * .L2:
> + *         ldr     x1, [x0]  <-- x1 populated by first load.
> + *         ldr     x2, [x0]
> + *         cmp     x1, x2
> + *         bne     .L2
> + *         ldr     w0, [x1]  <-- x1 is used for access which should depe=
nd on b.
> + *         ret
> + *
> + * On weakly-ordered architectures, this lets CPU speculation use the
> + * result from the first load to speculate "ldr w0, [x1]" before
> + * "ldr x2, [x0]".
> + * Based on the RCU documentation, the control dependency does not
> + * prevent the CPU from speculating loads.
> + */
> +
> +#include <asm/ptr_eq.h>
> +
> +#endif /* _LINUX_PTR_EQ_H */
> --
> 2.43.0
>
