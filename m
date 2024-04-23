Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B713666F
	for <rcu@vger.kernel.org>; Tue, 23 Apr 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895760; cv=none; b=D0xkyf5UH9AXL6tV4UCzfjzf9PpiWTwIAVPV1sOKmtbE8thtm9jU6CerqOC4ns2g5vF1NgaAFXD4hRmxzufg9Q10LOP2agK3sJV95XPqrMz+C+hXWThoFvfcoAtnyQWovBjMEqxLM+ORCpdCQFWtA+8DKufRiuvdlcbBuJPCCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895760; c=relaxed/simple;
	bh=oHr4V0B2KflqCc0Ka3IbL9iOQa60OfEeAqPCKm/aUVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyaQur1YzF0O64QILFfssILfTNESLD5wfIVoAXPxAEYr6Aqk+7ofgwxmjvWwdarVtIlgGuDlCqvM7S2Let3/YZOKk+qG9pLSCMtqEXnpuJ8b/jKzkcYoCu2dVg0teLpU8c+lKyxvFu9PX5xGOvyC3A7L1BbbFvCcPl7GfZur0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=LO8UzzYJ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LO8UzzYJ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2dd041acff1so46338061fa.1
        for <rcu@vger.kernel.org>; Tue, 23 Apr 2024 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1713895756; x=1714500556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIJNaEMv/4rmQZaBdsoVMDghW+jCtKelSwdikaTLbBE=;
        b=LO8UzzYJqgnQDqZ6Ra2y3m9p9nby8V/t69UWS/K2hIpGBRGOPUcxkvWpX/sZwMo304
         We0racFTh6YKanm7IJu4hU3isYHwBNqs+U6yCvl1NGaA4guI0zD93DgKc13PGkoAsRrT
         wmPY11eIZqFlWtWLHAYP5g8biSXqsATYSIRzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895756; x=1714500556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIJNaEMv/4rmQZaBdsoVMDghW+jCtKelSwdikaTLbBE=;
        b=uX0AczEboUewODYuCjgBXpjxI0lhVmU/GfyDy1m3ZTxpxu3FlOhS32jPhyFdpmboBQ
         hxWOJHho+U/5/sMMaiqHQM5NYZipkoZWy/dHjYNgEhLZgl0aVEMTuLYH4nrjxHVpxqyo
         dKkEpSbetwpR6XH7kESibQrEgMHB8/FNse/dUHPJuk1iXWHK7Z7deIDK7JfAc2oYDMTC
         xmDsAoxYQmd2yWL6RkrYykoYB0kf1QUM75ykJ5ZobzgRGeGVUdrWMiyHeLn3Sv0tPB5a
         WkKcO4gP2le8cjFW/XWuitItg9D9ZxKzBZwc24NckrzpVMC+2WxDMRi7/2fXCVcp2hsW
         AcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWwrZjKOTLrzWXH1DmAedNbgyr66eUFNdGr5IxUKXwCyMciC9s+FGdxxJMavdjzgijskdVQoooHFAbJbOqew4HkKFF
X-Gm-Message-State: AOJu0YyaHvKUN6eiw7BjKTC1Czzi/OLZfVut/mxSEWMb22jnV6LKooQW
	PBO9Ir2U/Kl4GMNV0PJvKz9OsOuUiriRxIEb5LZ6Y3ZZeQ2PzCkwpG3oDt5N5h1LwXG9By+bPsi
	16IpGFc/vxlveVijkem4qldRYf7SpES8AJTasjQ==
X-Google-Smtp-Source: AGHT+IHH0toDmiKEgZ+Oi1Xjq6HwMaXiK5Puk/ytGD4pZ77NlsuSVA2xPYuc6UoBKumI0D+B73PdFPiYibAPE4xphx4=
X-Received: by 2002:a2e:93c5:0:b0:2da:15cf:1e23 with SMTP id
 p5-20020a2e93c5000000b002da15cf1e23mr28753ljh.17.1713895756037; Tue, 23 Apr
 2024 11:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407090558.3395-1-jiangshanlai@gmail.com> <20240407090558.3395-11-jiangshanlai@gmail.com>
In-Reply-To: <20240407090558.3395-11-jiangshanlai@gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 23 Apr 2024 14:09:03 -0400
Message-ID: <CAEXW_YQUuGazgpLbERz7Y3nOq5nEkR+kx_Us9E30x1diiE2-eQ@mail.gmail.com>
Subject: Re: [PATCH V2 10/11] x86/rcu: Add rcu_preempt_count
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 5:06=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.co=
m> wrote:
>
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> Implement PCPU_RCU_PREEMPT_COUNT for x86.
> Mainly copied from asm/preempt.h
>
> Make rcu_read_[un]lock() inlined for rcu-preempt.

Changelog is wrong. You inlined rcu_read_[un]lock in previous patch,
not this one?

- Joel

> Make rcu_read_lock() only one instruction.
> Make rcu_read_unlock() only two instructions in the fast path.
>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/Kconfig                   |   1 +
>  arch/x86/include/asm/current.h     |   3 +
>  arch/x86/include/asm/rcu_preempt.h | 107 +++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/common.c       |   4 ++
>  4 files changed, 115 insertions(+)
>  create mode 100644 arch/x86/include/asm/rcu_preempt.h
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4fff6ed46e90..e805cac3763d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -256,6 +256,7 @@ config X86
>         select HAVE_OBJTOOL                     if X86_64
>         select HAVE_OPTPROBES
>         select HAVE_PAGE_SIZE_4KB
> +       select HAVE_PCPU_RCU_PREEMPT_COUNT
>         select HAVE_PCSPKR_PLATFORM
>         select HAVE_PERF_EVENTS
>         select HAVE_PERF_EVENTS_NMI
> diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/curren=
t.h
> index bf5953883ec3..dcc2ef784120 100644
> --- a/arch/x86/include/asm/current.h
> +++ b/arch/x86/include/asm/current.h
> @@ -24,6 +24,9 @@ struct pcpu_hot {
>                         unsigned long           top_of_stack;
>                         void                    *hardirq_stack_ptr;
>                         u16                     softirq_pending;
> +#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +                       int                     rcu_preempt_count;
> +#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
>  #ifdef CONFIG_X86_64
>                         bool                    hardirq_stack_inuse;
>  #else
> diff --git a/arch/x86/include/asm/rcu_preempt.h b/arch/x86/include/asm/rc=
u_preempt.h
> new file mode 100644
> index 000000000000..cb25ebe038a5
> --- /dev/null
> +++ b/arch/x86/include/asm/rcu_preempt.h
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_RCU_PREEMPT_H
> +#define __ASM_RCU_PREEMPT_H
> +
> +#include <asm/rmwcc.h>
> +#include <asm/percpu.h>
> +#include <asm/current.h>
> +
> +#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +
> +/* We use the MSB mostly because its available */
> +#define RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED    0x80000000
> +
> +/*
> + * We use the RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED bit as an inverted
> + * current->rcu_read_unlock_special.s such that a decrement hitting 0
> + * means we can and should call rcu_read_unlock_special().
> + */
> +#define RCU_PREEMPT_INIT       (0 + RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED)
> +
> +/*
> + * We mask the RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED bit so as not to
> + * confuse all current users that think a non-zero value indicates we
> + * are in a critical section.
> + */
> +static inline int pcpu_rcu_preempt_count(void)
> +{
> +       return raw_cpu_read_4(pcpu_hot.rcu_preempt_count) & ~RCU_PREEMPT_=
UNLOCK_SPECIAL_INVERTED;
> +}
> +
> +static inline void pcpu_rcu_preempt_count_set(int count)
> +{
> +       int old, new;
> +
> +       old =3D raw_cpu_read_4(pcpu_hot.rcu_preempt_count);
> +       do {
> +               new =3D (old & RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED) |
> +                       (count & ~RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED);
> +       } while (!raw_cpu_try_cmpxchg_4(pcpu_hot.rcu_preempt_count, &old,=
 new));
> +}
> +
> +/*
> + * We fold the RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED bit into the RCU
> + * preempt count such that rcu_read_unlock() can decrement and test for
> + * the need of unlock-special handling with a single instruction.
> + *
> + * We invert the actual bit, so that when the decrement hits 0 we know
> + * we both reach a quiescent state (no rcu preempt count) and need to
> + * handle unlock-special (the bit is cleared), normally to report the
> + * quiescent state immediately.
> + */
> +
> +static inline void pcpu_rcu_preempt_special_set(void)
> +{
> +       raw_cpu_and_4(pcpu_hot.rcu_preempt_count, ~RCU_PREEMPT_UNLOCK_SPE=
CIAL_INVERTED);
> +}
> +
> +static inline void pcpu_rcu_preempt_special_clear(void)
> +{
> +       raw_cpu_or_4(pcpu_hot.rcu_preempt_count, RCU_PREEMPT_UNLOCK_SPECI=
AL_INVERTED);
> +}
> +
> +static inline bool pcpu_rcu_preempt_special_test(void)
> +{
> +       return !(raw_cpu_read_4(pcpu_hot.rcu_preempt_count) & RCU_PREEMPT=
_UNLOCK_SPECIAL_INVERTED);
> +}
> +
> +static inline void pcpu_rcu_preempt_switch(int count, bool special)
> +{
> +       if (likely(!special))
> +               raw_cpu_write(pcpu_hot.rcu_preempt_count, count | RCU_PRE=
EMPT_UNLOCK_SPECIAL_INVERTED);
> +       else
> +               raw_cpu_write(pcpu_hot.rcu_preempt_count, count);
> +}
> +
> +/*
> + * The various rcu_preempt_count add/sub methods
> + */
> +
> +static __always_inline void pcpu_rcu_preempt_count_add(int val)
> +{
> +       raw_cpu_add_4(pcpu_hot.rcu_preempt_count, val);
> +}
> +
> +static __always_inline void pcpu_rcu_preempt_count_sub(int val)
> +{
> +       raw_cpu_add_4(pcpu_hot.rcu_preempt_count, -val);
> +}
> +
> +/*
> + * Because we keep RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED set when we do
> + * _not_ need to handle unlock-special for a fast-path decrement.
> + */
> +static __always_inline bool pcpu_rcu_preempt_count_dec_and_test(void)
> +{
> +       return GEN_UNARY_RMWcc("decl", __my_cpu_var(pcpu_hot.rcu_preempt_=
count), e,
> +                              __percpu_arg([var]));
> +}
> +
> +#define pcpu_rcu_read_unlock_special()                                  =
       \
> +do {                                                                    =
       \
> +       rcu_read_unlock_special();                                       =
       \
> +} while (0)
> +
> +#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +
> +#endif /* __ASM_RCU_PREEMPT_H */
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 5c1e6d6be267..918b1f5cb75d 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1995,6 +1995,10 @@ DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) =
=3D {
>         .current_task   =3D &init_task,
>         .preempt_count  =3D INIT_PREEMPT_COUNT,
>         .top_of_stack   =3D TOP_OF_INIT_STACK,
> +
> +#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +       .rcu_preempt_count      =3D RCU_PREEMPT_INIT,
> +#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
>  };
>  EXPORT_PER_CPU_SYMBOL(pcpu_hot);
>  EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
> --
> 2.19.1.6.gb485710b
>
>
