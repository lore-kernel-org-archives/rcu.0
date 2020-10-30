Return-Path: <SRS0=2gH0=EF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A5CC4363A
	for <rcu@archiver.kernel.org>; Fri, 30 Oct 2020 03:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A8D20720
	for <rcu@archiver.kernel.org>; Fri, 30 Oct 2020 03:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604028497;
	bh=5bWbc+rk6iFjGM/ynMw2nwmBb0fImGIaV/wftktq57g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fIeq0eY98HwljF79k/MFF6pwFUHalm2WWX4r8HUpTpRaLxgoO7WlK5fVZ+6LSctGY
	 BTnFKjLRzWRVQ787Cf8UF1cG+aoLuHxEM2KIt9k2I06KnvfjiUGDr44PCmQDR61cD7
	 HIILpzces9VsJvxI+tGRfW3mfcCKNsHEW/h787PM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgJ3D2Q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgJ3D2P (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 23:28:15 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B23F20796;
        Fri, 30 Oct 2020 03:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604028494;
        bh=5bWbc+rk6iFjGM/ynMw2nwmBb0fImGIaV/wftktq57g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ImH+C2h6vvBgZxYYeXPtz3xhowPZh4CJNuPBb3tmmyrNnzBOWtxVMIHGREvPr3q9z
         0K6JvY0BBf/dsi8Z330a0B85AI05LSqm6+KO7zDufSlwYFItjLjylAt+vVFl+HOuo/
         1uinU4SFVPMNUB9ZcADQeKT9hPpweWbqsqSXiCw0=
Received: by mail-lj1-f171.google.com with SMTP id d25so5376636ljc.11;
        Thu, 29 Oct 2020 20:28:14 -0700 (PDT)
X-Gm-Message-State: AOAM532N/FZ7FK0IPfNQxvpJotmXwJYKTXe8otZ2g/becWoJCQCPuafm
        mvI4ay6vX+aDQYl3LMQvHcAWIBZHCPYB16HqR64=
X-Google-Smtp-Source: ABdhPJymmsta1af3Be4tZIeK2tuuwY/zbAZDHIq5ay5bW/EzniyTMq7KysPhNarwv4UQVjr6ntyqlqus/G9USrnLhZ0=
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr136001ljj.250.1604028492494;
 Thu, 29 Oct 2020 20:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201021073839.43935-1-zong.li@sifive.com> <CAJF2gTTnGSYAc3AZKCPvhNJsPm_TchPjPrtqc_WzaK7K5eNt+w@mail.gmail.com>
 <CAOnJCULN8h0Jk3H-vskgbaXhgBTgTTAT5Dji0qHi6yHoXGePvg@mail.gmail.com>
 <CANXhq0q_fOg7vsniVMtNd8VezW1yymf55FYRc61WMkXMOtZpgA@mail.gmail.com>
 <CAJF2gTR-_=_vDLsST9BVxRFC0OTR4_TYV-2=nH_Gux_zWDOk3Q@mail.gmail.com> <CAOnJCU+d5YQzKW2qs0NURJt1_5zrM6YXrkP4FzB_=zgbb-5DuA@mail.gmail.com>
In-Reply-To: <CAOnJCU+d5YQzKW2qs0NURJt1_5zrM6YXrkP4FzB_=zgbb-5DuA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 30 Oct 2020 11:28:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT9gZZftoUD4eMT0Th=oYOpsdYbrFdr=5kO2-N+ki51NA@mail.gmail.com>
Message-ID: <CAJF2gTT9gZZftoUD4eMT0Th=oYOpsdYbrFdr=5kO2-N+ki51NA@mail.gmail.com>
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
To:     Atish Patra <atishp@atishpatra.org>
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

On Fri, Oct 30, 2020 at 2:46 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Thu, Oct 29, 2020 at 9:06 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Thu, Oct 29, 2020 at 10:34 AM Zong Li <zong.li@sifive.com> wrote:
> > >
> > > On Thu, Oct 29, 2020 at 8:23 AM Atish Patra <atishp@atishpatra.org> wrote:
> > > >
> > > > On Wed, Oct 28, 2020 at 8:44 AM Guo Ren <guoren@kernel.org> wrote:
> > > > >
> > > > > Hi Zong & Atish,
> > > > >
> > > > > In our 2 harts c910 chip, we found:
> > > > >
> > > > > echo function > /sys/kernel/debug/tracing/current_tracer
> > > > > echo function_graph > /sys/kernel/debug/tracing/current_tracer
> > > > > echo function > /sys/kernel/debug/tracing/current_tracer
> > > > > echo function_graph > /sys/kernel/debug/tracing/current_tracer
> > > > >
> > > > > Then one core halted at stop_machine_yield:
> > > > > arch_cpu_idle () at arch/riscv/kernel/process.c:39
> > > > > 39              local_irq_enable();
> > > > > (gdb) i th
> > > > >   Id   Target Id         Frame
> > > > > * 1    Thread 1 (CPU#0)  arch_cpu_idle () at arch/riscv/kernel/process.c:39
> > > > >   2    Thread 2 (CPU#1)  stop_machine_yield
> > > > > (cpumask=0xffffffe001371fa8 <__cpu_online_mask>) at
> > > > > ./arch/riscv/include/asm/vdso/processor.h:12
> > > > > (gdb) thread 2
> > > > > [Switching to thread 2 (Thread 2)]
> > > > > #0  stop_machine_yield (cpumask=0xffffffe001371fa8
> > > > > <__cpu_online_mask>) at ./arch/riscv/include/asm/vdso/processor.h:12
> > > > > 12              __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> > > > >
> > > > > With your patch, it's solved. For this patch, I'll give:
> > > > > Tested by: Guo Ren <guoren@kernel.org>
> > > > >
> > > > > But that's not enough, we still need:
> > > > >
> > > > > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > > > > index 226ccce..12b8808 100644
> > > > > --- a/arch/riscv/kernel/sbi.c
> > > > > +++ b/arch/riscv/kernel/sbi.c
> > > > > @@ -376,7 +376,7 @@ EXPORT_SYMBOL(sbi_send_ipi);
> > > > >   *
> > > > >   * Return: None
> > > > >   */
> > > > > -void sbi_remote_fence_i(const unsigned long *hart_mask)
> > > > > +void notrace sbi_remote_fence_i(const unsigned long *hart_mask)
> > > > >  {
> > > > >         __sbi_rfence(SBI_EXT_RFENCE_REMOTE_FENCE_I,
> > > > >                      hart_mask, 0, 0, 0, 0);
> > > > > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > > > > index 400b945d..9467d987 100644
> > > > > --- a/arch/riscv/mm/cacheflush.c
> > > > > +++ b/arch/riscv/mm/cacheflush.c
> > > > > @@ -9,12 +9,12 @@
> > > > >
> > > > >  #include <asm/sbi.h>
> > > > >
> > > > > -static void ipi_remote_fence_i(void *info)
> > > > > +static void notrace ipi_remote_fence_i(void *info)
> > > > >  {
> > > > >         return local_flush_icache_all();
> > > > >  }
> > > > >
> > > > > -void flush_icache_all(void)
> > > > > +void notrace flush_icache_all(void)
> > > > >  {
> > > > >         if (IS_ENABLED(CONFIG_RISCV_SBI))
> > > > >                 sbi_remote_fence_i(NULL);
> > > > >
> > > >
> > > > Did you see any issue if these functions are not marked as notrace ?
> > > >
> > > > As per Zong's explanation, the issue was that the other harts already
> > > > fetched the next 2 nops and
> > > > executed 1 while kernel patching replaced other with one of the auipc
> > > > + jalr pair.
> > > >
> > > > @Zong can correct me if I am wrong.
> > > >
> > > > These functions are too far ahead. Can it cause such issues ? If yes,
> > > > then we need to mark each and every function
> > > > that can be invoked from patch_text_nosync and are not inlined.
> > > >
> > > > That includes copy_to_kernel_nofault, __sbi_rfence_v02,
> > > > __sbi_rfence_v02_call, sbi_ecall.
> > > >
> > > > Few of these functions may be inlined by compiler. Can we depend on that ?
> > > >
> > > > > Because:
> > > > > (gdb) bt
> > > > > #0  flush_icache_all () at arch/riscv/mm/cacheflush.c:20
> > > > > #1  0xffffffe00020473a in patch_text_nosync (addr=<optimized out>, insns=
> > > > >     <optimized out>, len=<optimized out>) at arch/riscv/kernel/patch.c:96
> > > > > #2  0xffffffe000206792 in ftrace_make_call (rec=<optimized out>,
> > > > > addr=<optimized out>) at arch/riscv/kernel/ftrace.c:109
> > > > > #3  0xffffffe0002c9be4 in __ftrace_replace_code (rec=0xffffffe01ae40020, e
> > > > >     nable=true) at kernel/trace/ftrace.c:2503
> > > > > #4  0xffffffe0002ca092 in ftrace_replace_code (mod_flags=<optimized
> > > > >     out>) at kernel/trace/ftrace.c:2530
> > > > > #5  0xffffffe0002ca24a in ftrace_modify_all_code (command=9) at kernel
> > > > >    /trace/ftrace.c:2677
> > > > > #6  0xffffffe0002ca2ee in __ftrace_modify_code (data=<optimized out>) at
> > > > >    kernel/trace/ftrace.c:2703
> > > > > #7  0xffffffe0002c1390 in multi_cpu_stop (data=0x0) at kernel/stop_machin
> > > > >    e.c:224
> > > > > #8  0xffffffe0002c0fbe in cpu_stopper_thread (cpu=<optimized out>) at kern
> > > > >    el/stop_machine.c:491
> > > > > #9  0xffffffe0002343be in smpboot_thread_fn (data=0x0) at kernel/smpboot.
> > > > >    c:165
> > > > > #10 0xffffffe00022f894 in kthread (_create=0xffffffe01af13040) at kern
> > > > >    el/kthread.c:292
> > > > > #11 0xffffffe000201fac in handle_exception () at arch/riscv/kernel/entry.S:236
> > > > >
> > >
> > > It seems to me that the problem happens on the waiting threads, it
> > No, that is the call trace to show ftrace_make_call ->
> > flush_icache_all and we should give notrace on the whole path.
> >
>
> Hmm. I am curious to understand how other architectures avoid this problem.

for arm64
static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
                              bool validate)
{
        u32 replaced;
...
        if (aarch64_insn_patch_text_nosync((void *)pc, new))
                return -EPERM;

int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
{
        u32 *tp = addr;
        int ret;

        /* A64 instructions must be word aligned */
        if ((uintptr_t)tp & 0x3)
                return -EINVAL;

        ret = aarch64_insn_write(tp, insn);
        if (ret == 0)
                __flush_icache_range((uintptr_t)tp,
                                     (uintptr_t)tp + AARCH64_INSN_SIZE);

Look at arm64, they __kprobes flag and I guess it would also prevent
ftrace call site.

__flush_icache_range is written in asm and no possible ftrace call site.

> Is it a bigger issue in RISC-V because we have to switch privilege
> mode to sync I/D cache ?
We should sync I/D cache at s-mode because we need virtual address.
For c910 we've added icache broadcast invalid instructions by physical
address and virtual address.

Current linux/arch/riscv I/D cache sync is so expensive.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
