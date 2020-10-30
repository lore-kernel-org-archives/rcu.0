Return-Path: <SRS0=2gH0=EF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969FBC4742C
	for <rcu@archiver.kernel.org>; Fri, 30 Oct 2020 21:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308CC20727
	for <rcu@archiver.kernel.org>; Fri, 30 Oct 2020 21:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="Iuoe3TrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgJ3VsK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Oct 2020 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3VsJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Oct 2020 17:48:09 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C0C0613CF
        for <rcu@vger.kernel.org>; Fri, 30 Oct 2020 14:48:08 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id n5so7750351ile.7
        for <rcu@vger.kernel.org>; Fri, 30 Oct 2020 14:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2H6cPN0gnqQZAudY3hjr6N8uSef0pLDKUZk1I184RGs=;
        b=Iuoe3TrDQMXYgYBYoFwqatJLMHxMuM2piSNX8Ny+q2pX80tWo4LElHitBLDDbAYVXS
         sscYvyHpT0v9rwQQchtbt1McePjU14Ij5+lJ5QmFFswHp/Ip8zo1TXFcD0ibt/UqW44P
         +BRIaRIDeDNZAomnbqHwTB2ggHd4z/LUAqsWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2H6cPN0gnqQZAudY3hjr6N8uSef0pLDKUZk1I184RGs=;
        b=Gii/IOpcNep5ITo6RflAoK7rPPTfIJXgKNUF40p/KoxgRpMDoYLHxUTVAP18GyxIeK
         RJjSspJRu1hyxV5BodramKdj70tvJzdj16ZSHb6bYpWnziMePeNVgez4rzNM6pUcFYO7
         HroUjuVze+4iuQoooNemCAsx41GSabvZpDaJIgo6AI1KHu76vawqNOgh14Ri7N03+HKl
         qJ1J2oRFLjNvL5q6UgcK87hDxYLKZzAJ+KuKClRn9LUiuBRY9SeKl3SAyEqsXrY/I4Pb
         DT8ONtzuRYmtBy+WdTEqhCGRQQHXRVx7VY33G+QcNKBD4vGdcR0Xm27Weg5nHz3/pJ00
         uEIQ==
X-Gm-Message-State: AOAM5302eWxdoBhlFYaafin+YmK3kMYCP/+7IxLUFn5AwmqPilKwsVEI
        7SE9bvVvXBIu2xFlC1Uc5j1VntSPMWaGX6XpDajs
X-Google-Smtp-Source: ABdhPJx45HoI2f4RZvZCH7KAQELph+nUvcbrtm+d57rUNxmPQ2I0qcM3CMfoNbDCwl6XI9f7u0V4I5G/oUlUYGC8gpg=
X-Received: by 2002:a92:cf41:: with SMTP id c1mr2471028ilr.219.1604094487353;
 Fri, 30 Oct 2020 14:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201021073839.43935-1-zong.li@sifive.com> <CAJF2gTTnGSYAc3AZKCPvhNJsPm_TchPjPrtqc_WzaK7K5eNt+w@mail.gmail.com>
 <CAOnJCULN8h0Jk3H-vskgbaXhgBTgTTAT5Dji0qHi6yHoXGePvg@mail.gmail.com>
 <CANXhq0q_fOg7vsniVMtNd8VezW1yymf55FYRc61WMkXMOtZpgA@mail.gmail.com>
 <CAJF2gTR-_=_vDLsST9BVxRFC0OTR4_TYV-2=nH_Gux_zWDOk3Q@mail.gmail.com>
 <CAOnJCU+d5YQzKW2qs0NURJt1_5zrM6YXrkP4FzB_=zgbb-5DuA@mail.gmail.com> <CAJF2gTT9gZZftoUD4eMT0Th=oYOpsdYbrFdr=5kO2-N+ki51NA@mail.gmail.com>
In-Reply-To: <CAJF2gTT9gZZftoUD4eMT0Th=oYOpsdYbrFdr=5kO2-N+ki51NA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 30 Oct 2020 14:47:56 -0700
Message-ID: <CAOnJCULO7TuRhBcx6KUVr6t_jqouN-0rao9QXC1RgrU5ehutkw@mail.gmail.com>
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
To:     Guo Ren <guoren@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>, Paul McKenney <paulmck@kernel.org>,
        josh@joshtriplett.org, Steven Rostedt <rostedt@goodmis.org>,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, vincent.whitchurch@axis.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Colin Ian King <colin.king@canonical.com>,
        rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 29, 2020 at 8:28 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Fri, Oct 30, 2020 at 2:46 AM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Thu, Oct 29, 2020 at 9:06 AM Guo Ren <guoren@kernel.org> wrote:
> > >
> > > On Thu, Oct 29, 2020 at 10:34 AM Zong Li <zong.li@sifive.com> wrote:
> > > >
> > > > On Thu, Oct 29, 2020 at 8:23 AM Atish Patra <atishp@atishpatra.org> wrote:
> > > > >
> > > > > On Wed, Oct 28, 2020 at 8:44 AM Guo Ren <guoren@kernel.org> wrote:
> > > > > >
> > > > > > Hi Zong & Atish,
> > > > > >
> > > > > > In our 2 harts c910 chip, we found:
> > > > > >
> > > > > > echo function > /sys/kernel/debug/tracing/current_tracer
> > > > > > echo function_graph > /sys/kernel/debug/tracing/current_tracer
> > > > > > echo function > /sys/kernel/debug/tracing/current_tracer
> > > > > > echo function_graph > /sys/kernel/debug/tracing/current_tracer
> > > > > >
> > > > > > Then one core halted at stop_machine_yield:
> > > > > > arch_cpu_idle () at arch/riscv/kernel/process.c:39
> > > > > > 39              local_irq_enable();
> > > > > > (gdb) i th
> > > > > >   Id   Target Id         Frame
> > > > > > * 1    Thread 1 (CPU#0)  arch_cpu_idle () at arch/riscv/kernel/process.c:39
> > > > > >   2    Thread 2 (CPU#1)  stop_machine_yield
> > > > > > (cpumask=0xffffffe001371fa8 <__cpu_online_mask>) at
> > > > > > ./arch/riscv/include/asm/vdso/processor.h:12
> > > > > > (gdb) thread 2
> > > > > > [Switching to thread 2 (Thread 2)]
> > > > > > #0  stop_machine_yield (cpumask=0xffffffe001371fa8
> > > > > > <__cpu_online_mask>) at ./arch/riscv/include/asm/vdso/processor.h:12
> > > > > > 12              __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> > > > > >
> > > > > > With your patch, it's solved. For this patch, I'll give:
> > > > > > Tested by: Guo Ren <guoren@kernel.org>
> > > > > >
> > > > > > But that's not enough, we still need:
> > > > > >
> > > > > > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > > > > > index 226ccce..12b8808 100644
> > > > > > --- a/arch/riscv/kernel/sbi.c
> > > > > > +++ b/arch/riscv/kernel/sbi.c
> > > > > > @@ -376,7 +376,7 @@ EXPORT_SYMBOL(sbi_send_ipi);
> > > > > >   *
> > > > > >   * Return: None
> > > > > >   */
> > > > > > -void sbi_remote_fence_i(const unsigned long *hart_mask)
> > > > > > +void notrace sbi_remote_fence_i(const unsigned long *hart_mask)
> > > > > >  {
> > > > > >         __sbi_rfence(SBI_EXT_RFENCE_REMOTE_FENCE_I,
> > > > > >                      hart_mask, 0, 0, 0, 0);
> > > > > > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > > > > > index 400b945d..9467d987 100644
> > > > > > --- a/arch/riscv/mm/cacheflush.c
> > > > > > +++ b/arch/riscv/mm/cacheflush.c
> > > > > > @@ -9,12 +9,12 @@
> > > > > >
> > > > > >  #include <asm/sbi.h>
> > > > > >
> > > > > > -static void ipi_remote_fence_i(void *info)
> > > > > > +static void notrace ipi_remote_fence_i(void *info)
> > > > > >  {
> > > > > >         return local_flush_icache_all();
> > > > > >  }
> > > > > >
> > > > > > -void flush_icache_all(void)
> > > > > > +void notrace flush_icache_all(void)
> > > > > >  {
> > > > > >         if (IS_ENABLED(CONFIG_RISCV_SBI))
> > > > > >                 sbi_remote_fence_i(NULL);
> > > > > >
> > > > >
> > > > > Did you see any issue if these functions are not marked as notrace ?
> > > > >
> > > > > As per Zong's explanation, the issue was that the other harts already
> > > > > fetched the next 2 nops and
> > > > > executed 1 while kernel patching replaced other with one of the auipc
> > > > > + jalr pair.
> > > > >
> > > > > @Zong can correct me if I am wrong.
> > > > >
> > > > > These functions are too far ahead. Can it cause such issues ? If yes,
> > > > > then we need to mark each and every function
> > > > > that can be invoked from patch_text_nosync and are not inlined.
> > > > >
> > > > > That includes copy_to_kernel_nofault, __sbi_rfence_v02,
> > > > > __sbi_rfence_v02_call, sbi_ecall.
> > > > >
> > > > > Few of these functions may be inlined by compiler. Can we depend on that ?
> > > > >
> > > > > > Because:
> > > > > > (gdb) bt
> > > > > > #0  flush_icache_all () at arch/riscv/mm/cacheflush.c:20
> > > > > > #1  0xffffffe00020473a in patch_text_nosync (addr=<optimized out>, insns=
> > > > > >     <optimized out>, len=<optimized out>) at arch/riscv/kernel/patch.c:96
> > > > > > #2  0xffffffe000206792 in ftrace_make_call (rec=<optimized out>,
> > > > > > addr=<optimized out>) at arch/riscv/kernel/ftrace.c:109
> > > > > > #3  0xffffffe0002c9be4 in __ftrace_replace_code (rec=0xffffffe01ae40020, e
> > > > > >     nable=true) at kernel/trace/ftrace.c:2503
> > > > > > #4  0xffffffe0002ca092 in ftrace_replace_code (mod_flags=<optimized
> > > > > >     out>) at kernel/trace/ftrace.c:2530
> > > > > > #5  0xffffffe0002ca24a in ftrace_modify_all_code (command=9) at kernel
> > > > > >    /trace/ftrace.c:2677
> > > > > > #6  0xffffffe0002ca2ee in __ftrace_modify_code (data=<optimized out>) at
> > > > > >    kernel/trace/ftrace.c:2703
> > > > > > #7  0xffffffe0002c1390 in multi_cpu_stop (data=0x0) at kernel/stop_machin
> > > > > >    e.c:224
> > > > > > #8  0xffffffe0002c0fbe in cpu_stopper_thread (cpu=<optimized out>) at kern
> > > > > >    el/stop_machine.c:491
> > > > > > #9  0xffffffe0002343be in smpboot_thread_fn (data=0x0) at kernel/smpboot.
> > > > > >    c:165
> > > > > > #10 0xffffffe00022f894 in kthread (_create=0xffffffe01af13040) at kern
> > > > > >    el/kthread.c:292
> > > > > > #11 0xffffffe000201fac in handle_exception () at arch/riscv/kernel/entry.S:236
> > > > > >
> > > >
> > > > It seems to me that the problem happens on the waiting threads, it
> > > No, that is the call trace to show ftrace_make_call ->
> > > flush_icache_all and we should give notrace on the whole path.
> > >
> >
> > Hmm. I am curious to understand how other architectures avoid this problem.
>
> for arm64
> static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
>                               bool validate)
> {
>         u32 replaced;
> ...
>         if (aarch64_insn_patch_text_nosync((void *)pc, new))
>                 return -EPERM;
>
> int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
> {
>         u32 *tp = addr;
>         int ret;
>
>         /* A64 instructions must be word aligned */
>         if ((uintptr_t)tp & 0x3)
>                 return -EINVAL;
>
>         ret = aarch64_insn_write(tp, insn);
>         if (ret == 0)
>                 __flush_icache_range((uintptr_t)tp,
>                                      (uintptr_t)tp + AARCH64_INSN_SIZE);
>
> Look at arm64, they __kprobes flag and I guess it would also prevent
> ftrace call site.
>

Are you sure about that ? __kprobes puts the code in .kprobes.text section
which is under whitelist sections in recordmcount.pl & recordmcount.c.

> __flush_icache_range is written in asm and no possible ftrace call site.
>
> > Is it a bigger issue in RISC-V because we have to switch privilege
> > mode to sync I/D cache ?
> We should sync I/D cache at s-mode because we need virtual address.
> For c910 we've added icache broadcast invalid instructions by physical
> address and virtual address.
>
> Current linux/arch/riscv I/D cache sync is so expensive.
>

Yes. It is a known fact. Unfortunately, RISC-V specifications doesn't
allow any other method yet.
I hope the specification is modified to allow some method to sync I/D
cache from S-mode soon.

> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Regards,
Atish
