Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5B3C55179
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1E3206DD
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603987362;
	bh=wb3pPizZZfMH5cW3NB5Y7TK0TfRPzwPOwodEzm1t1QU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z+5Hau+flIGAoEnhjdaArXZj59th0kC6rMQ8LJDOGWIWNq5rk4VpVHELQ2xj3mXfV
	 gGw4Rhl4L8oBDhbrTf3YzNlId1jRiJLm1Tb4c1j06IxLhbaysjaOL3QArf/HPhyAJ0
	 DbAlJ5tuVNgI99m6h8872OVdn40J66Z8PqyZxY+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgJ2QCi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:32868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgJ2QCh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:02:37 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1793320838;
        Thu, 29 Oct 2020 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603987327;
        bh=wb3pPizZZfMH5cW3NB5Y7TK0TfRPzwPOwodEzm1t1QU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VCInQJ843bo3sb4IVbkFEV3fTHvVkjXHQnleoDpEkH2JC8HmMaSDlXfvRdTTJld34
         EY2EN1ZLH5bEkKN1RYzxal3QuEitd8qVxI8KeajVHNDZbaCi28lG+BWDA+buPqOIJZ
         W0PvaAdmsvFx/HnJNn4xvVt/hh1W0/Spp9u0HViY=
Received: by mail-lf1-f53.google.com with SMTP id j30so3986187lfp.4;
        Thu, 29 Oct 2020 09:02:06 -0700 (PDT)
X-Gm-Message-State: AOAM530JPKLl52nqv56tSSzTfQ89nOtxIROpbbf7r+QroIcybOJRCXUY
        qr0rWdEf+mpu0Q1JaB/s3tBa6hrjsU2RDHUcgNU=
X-Google-Smtp-Source: ABdhPJzRQd5oVokMF8qnnwpi8kmRg5KK9lHYoDB0cHJERPZL2zZBPBjdTnN/dXqCg6EQiMrg0X1iuUa34YN4c/hNrxo=
X-Received: by 2002:a19:3f52:: with SMTP id m79mr1760570lfa.58.1603987325064;
 Thu, 29 Oct 2020 09:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201021073839.43935-1-zong.li@sifive.com> <CAJF2gTTnGSYAc3AZKCPvhNJsPm_TchPjPrtqc_WzaK7K5eNt+w@mail.gmail.com>
 <CAOnJCULN8h0Jk3H-vskgbaXhgBTgTTAT5Dji0qHi6yHoXGePvg@mail.gmail.com>
In-Reply-To: <CAOnJCULN8h0Jk3H-vskgbaXhgBTgTTAT5Dji0qHi6yHoXGePvg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 30 Oct 2020 00:01:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT=oDWesWe0JVWvTpGi60-gpbNhYLdFWN_5EbyeqoEDdw@mail.gmail.com>
Message-ID: <CAJF2gTT=oDWesWe0JVWvTpGi60-gpbNhYLdFWN_5EbyeqoEDdw@mail.gmail.com>
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

On Thu, Oct 29, 2020 at 8:23 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Wed, Oct 28, 2020 at 8:44 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > Hi Zong & Atish,
> >
> > In our 2 harts c910 chip, we found:
> >
> > echo function > /sys/kernel/debug/tracing/current_tracer
> > echo function_graph > /sys/kernel/debug/tracing/current_tracer
> > echo function > /sys/kernel/debug/tracing/current_tracer
> > echo function_graph > /sys/kernel/debug/tracing/current_tracer
> >
> > Then one core halted at stop_machine_yield:
> > arch_cpu_idle () at arch/riscv/kernel/process.c:39
> > 39              local_irq_enable();
> > (gdb) i th
> >   Id   Target Id         Frame
> > * 1    Thread 1 (CPU#0)  arch_cpu_idle () at arch/riscv/kernel/process.c:39
> >   2    Thread 2 (CPU#1)  stop_machine_yield
> > (cpumask=0xffffffe001371fa8 <__cpu_online_mask>) at
> > ./arch/riscv/include/asm/vdso/processor.h:12
> > (gdb) thread 2
> > [Switching to thread 2 (Thread 2)]
> > #0  stop_machine_yield (cpumask=0xffffffe001371fa8
> > <__cpu_online_mask>) at ./arch/riscv/include/asm/vdso/processor.h:12
> > 12              __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> >
> > With your patch, it's solved. For this patch, I'll give:
> > Tested by: Guo Ren <guoren@kernel.org>
> >
> > But that's not enough, we still need:
> >
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index 226ccce..12b8808 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -376,7 +376,7 @@ EXPORT_SYMBOL(sbi_send_ipi);
> >   *
> >   * Return: None
> >   */
> > -void sbi_remote_fence_i(const unsigned long *hart_mask)
> > +void notrace sbi_remote_fence_i(const unsigned long *hart_mask)
> >  {
> >         __sbi_rfence(SBI_EXT_RFENCE_REMOTE_FENCE_I,
> >                      hart_mask, 0, 0, 0, 0);
> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > index 400b945d..9467d987 100644
> > --- a/arch/riscv/mm/cacheflush.c
> > +++ b/arch/riscv/mm/cacheflush.c
> > @@ -9,12 +9,12 @@
> >
> >  #include <asm/sbi.h>
> >
> > -static void ipi_remote_fence_i(void *info)
> > +static void notrace ipi_remote_fence_i(void *info)
> >  {
> >         return local_flush_icache_all();
> >  }
> >
> > -void flush_icache_all(void)
> > +void notrace flush_icache_all(void)
> >  {
> >         if (IS_ENABLED(CONFIG_RISCV_SBI))
> >                 sbi_remote_fence_i(NULL);
> >
>
> Did you see any issue if these functions are not marked as notrace ?

Welcome to Buildroot
buildroot login: root
#
# cat /proc/cpuinfo
processor       : 0
hart            : 0
isa             : rv64imafdcsu
mmu             : sv39
#
#
# echo function > /sys/kernel/debug/tracing/current_tracer
[   45.234334] Unable to handle kernel paging request at virtual
address ffffffd38ae80900
[   45.242313] Oops [#1]
[   45.244600] Modules linked in:
[   45.247678] CPU: 0 PID: 11 Comm: migration/0 Not tainted
5.9.0-00025-g9b7db83-dirty #215
[   45.255797] epc: ffffffe00021689a ra : ffffffe00021718e sp : ffffffe01afabb58
[   45.262955]  gp : ffffffe00136afa0 tp : ffffffe01af94d00 t0 :
0000000000000002
[   45.270200]  t1 : 0000000000000000 t2 : 0000000000000001 s0 :
ffffffe01afabc08
[   45.277443]  s1 : ffffffe0013718a8 a0 : 0000000000000000 a1 :
ffffffe01afabba8
[   45.284686]  a2 : 0000000000000000 a3 : 0000000000000000 a4 :
c4c16ad38ae80900
[   45.291929]  a5 : 0000000000000000 a6 : 0000000000000000 a7 :
0000000052464e43
[   45.299173]  s2 : 0000000000000001 s3 : ffffffe000206a60 s4 :
ffffffe000206a60
[   45.306415]  s5 : 00000000000009ec s6 : ffffffe0013718a8 s7 :
c4c16ad38ae80900
[   45.313658]  s8 : 0000000000000004 s9 : 0000000000000001 s10:
0000000000000001
[   45.320902]  s11: 0000000000000003 t3 : 0000000000000001 t4 :
ffffffffd192fe79
[   45.328144]  t5 : ffffffffb8f80000 t6 : 0000000000040000
[   45.333472] status: 0000000200000100 badaddr: ffffffd38ae80900
cause: 000000000000000f
[   45.341514] ---[ end trace d95102172248fdcf ]---
[   45.346176] note: migration/0[11] exited with preempt_count 1

(gdb) x /2i $pc
=> 0xffffffe00021689a <__do_proc_dointvec+196>: sd      zero,0(s7)
   0xffffffe00021689e <__do_proc_dointvec+200>: li      s11,0

(gdb) bt
#0  __do_proc_dointvec (tbl_data=0x0, table=0xffffffe01afabba8,
write=0, buffer=0x0, lenp=0x7bf897061f9a0800, ppos=0x4, conv=0x0,
data=0x52464e43) at kernel/sysctl.c:581
#1  0xffffffe00021718e in do_proc_dointvec (data=<optimized out>,
conv=<optimized out>, ppos=<optimized out>, lenp=<optimized out>,
buffer=<optimized out>, write=<optimized out>, table=<optimized out>)
at kernel/sysctl.c:964
#2  proc_dointvec_minmax (ppos=<optimized out>, lenp=<optimized out>,
buffer=<optimized out>, write=<optimized out>, table=<optimized out>)
at kernel/sysctl.c:964
#3  proc_do_static_key (table=<optimized out>, write=1, buffer=0x0,
lenp=0x0, ppos=0x7bf897061f9a0800) at kernel/sysctl.c:1643
#4  0xffffffe000206792 in ftrace_make_call (rec=<optimized out>,
addr=<optimized out>) at arch/riscv/kernel/ftrace.c:109
#5  0xffffffe0002c9c04 in __ftrace_replace_code
(rec=0xffffffe01ae40c30, enable=3) at kernel/trace/ftrace.c:2503
#6  0xffffffe0002ca0b2 in ftrace_replace_code (mod_flags=<optimized
out>) at kernel/trace/ftrace.c:2530
#7  0xffffffe0002ca26a in ftrace_modify_all_code (command=5) at
kernel/trace/ftrace.c:2677
#8  0xffffffe0002ca30e in __ftrace_modify_code (data=<optimized out>)
at kernel/trace/ftrace.c:2703
#9  0xffffffe0002c13b0 in multi_cpu_stop (data=0x0) at kernel/stop_machine.c:224
#10 0xffffffe0002c0fde in cpu_stopper_thread (cpu=<optimized out>) at
kernel/stop_machine.c:491
#11 0xffffffe0002343de in smpboot_thread_fn (data=0x0) at kernel/smpboot.c:165
#12 0xffffffe00022f8b4 in kthread (_create=0xffffffe01af0c040) at
kernel/kthread.c:292
#13 0xffffffe000201fac in handle_exception () at arch/riscv/kernel/entry.S:236

   0xffffffe00020678a <+114>:   auipc   ra,0xffffe
   0xffffffe00020678e <+118>:   jalr    -118(ra) # 0xffffffe000204714
<patch_text_nosync>
   0xffffffe000206792 <+122>:   snez    a0,a0

(gdb) disassemble patch_text_nosync
Dump of assembler code for function patch_text_nosync:
   0xffffffe000204714 <+0>:     addi    sp,sp,-32
   0xffffffe000204716 <+2>:     sd      s0,16(sp)
   0xffffffe000204718 <+4>:     sd      ra,24(sp)
   0xffffffe00020471a <+6>:     addi    s0,sp,32
   0xffffffe00020471c <+8>:     auipc   ra,0x0
   0xffffffe000204720 <+12>:    jalr    -384(ra) # 0xffffffe00020459c
<patch_insn_write>
   0xffffffe000204724 <+16>:    beqz    a0,0xffffffe00020472e
<patch_text_nosync+26>
   0xffffffe000204726 <+18>:    ld      ra,24(sp)
   0xffffffe000204728 <+20>:    ld      s0,16(sp)
   0xffffffe00020472a <+22>:    addi    sp,sp,32
   0xffffffe00020472c <+24>:    ret
   0xffffffe00020472e <+26>:    sd      a0,-24(s0)
   0xffffffe000204732 <+30>:    auipc   ra,0x4
   0xffffffe000204736 <+34>:    jalr    -1464(ra) # 0xffffffe00020817a
<flush_icache_all>
   0xffffffe00020473a <+38>:    ld      a0,-24(s0)
   0xffffffe00020473e <+42>:    ld      ra,24(sp)
   0xffffffe000204740 <+44>:    ld      s0,16(sp)
   0xffffffe000204742 <+46>:    addi    sp,sp,32
   0xffffffe000204744 <+48>:    ret

(gdb) disassemble flush_icache_all-4
Dump of assembler code for function flush_icache_all:
   0xffffffe00020817a <+0>:     addi    sp,sp,-8
   0xffffffe00020817c <+2>:     sd      ra,0(sp)
   0xffffffe00020817e <+4>:     auipc   ra,0xfffff
   0xffffffe000208182 <+8>:     jalr    -1822(ra) # 0xffffffe000206a60
<ftrace_caller>
   0xffffffe000208186 <+12>:    ld      ra,0(sp)
   0xffffffe000208188 <+14>:    addi    sp,sp,8
   0xffffffe00020818a <+0>:     addi    sp,sp,-16
   0xffffffe00020818c <+2>:     sd      s0,0(sp)
   0xffffffe00020818e <+4>:     sd      ra,8(sp)
   0xffffffe000208190 <+6>:     addi    s0,sp,16
   0xffffffe000208192 <+8>:     li      a0,0
   0xffffffe000208194 <+10>:    auipc   ra,0xfffff
   0xffffffe000208198 <+14>:    jalr    -410(ra) # 0xffffffe000206ffa
<sbi_remote_fence_i>
   0xffffffe00020819c <+18>:    ld      s0,0(sp)
   0xffffffe00020819e <+20>:    ld      ra,8(sp)
   0xffffffe0002081a0 <+22>:    addi    sp,sp,16
   0xffffffe0002081a2 <+24>:    ret

(gdb) frame 5
#5  0xffffffe0002c9c04 in __ftrace_replace_code
(rec=0xffffffe01ae40c30, enable=3) at kernel/trace/ftrace.c:2503
2503                    return ftrace_make_call(rec, ftrace_addr);
(gdb) p /x rec->ip
$2 = 0xffffffe00020817a -> flush_icache_all !

Look when we modify flush_icache_all's patchable-entry with ftrace_caller:
1. Insert ftrace_caller at flush_icache_all entry.
2. Call flush_icache_all to sync I/Dcache, but flush_icache_all is
just we've modified not ready to be called!

>
> As per Zong's explanation, the issue was that the other harts already
> fetched the next 2 nops and
> executed 1 while kernel patching replaced other with one of the auipc
> + jalr pair.
>
> @Zong can correct me if I am wrong.
>
> These functions are too far ahead. Can it cause such issues ? If yes,
> then we need to mark each and every function
> that can be invoked from patch_text_nosync and are not inlined.
>
> That includes copy_to_kernel_nofault, __sbi_rfence_v02,
> __sbi_rfence_v02_call, sbi_ecall.
Yes, mark all of them.

>
> Few of these functions may be inlined by compiler. Can we depend on that ?
It works, but we'd better give notrace for them.

>
> > Because:
> > (gdb) bt
> > #0  flush_icache_all () at arch/riscv/mm/cacheflush.c:20
> > #1  0xffffffe00020473a in patch_text_nosync (addr=<optimized out>, insns=
> >     <optimized out>, len=<optimized out>) at arch/riscv/kernel/patch.c:96
> > #2  0xffffffe000206792 in ftrace_make_call (rec=<optimized out>,
> > addr=<optimized out>) at arch/riscv/kernel/ftrace.c:109
> > #3  0xffffffe0002c9be4 in __ftrace_replace_code (rec=0xffffffe01ae40020, e
> >     nable=true) at kernel/trace/ftrace.c:2503
> > #4  0xffffffe0002ca092 in ftrace_replace_code (mod_flags=<optimized
> >     out>) at kernel/trace/ftrace.c:2530
> > #5  0xffffffe0002ca24a in ftrace_modify_all_code (command=9) at kernel
> >    /trace/ftrace.c:2677
> > #6  0xffffffe0002ca2ee in __ftrace_modify_code (data=<optimized out>) at
> >    kernel/trace/ftrace.c:2703
> > #7  0xffffffe0002c1390 in multi_cpu_stop (data=0x0) at kernel/stop_machin
> >    e.c:224
> > #8  0xffffffe0002c0fbe in cpu_stopper_thread (cpu=<optimized out>) at kern
> >    el/stop_machine.c:491
> > #9  0xffffffe0002343be in smpboot_thread_fn (data=0x0) at kernel/smpboot.
> >    c:165
> > #10 0xffffffe00022f894 in kthread (_create=0xffffffe01af13040) at kern
> >    el/kthread.c:292
> > #11 0xffffffe000201fac in handle_exception () at arch/riscv/kernel/entry.S:236
> >
> > On Wed, Oct 21, 2020 at 3:38 PM Zong Li <zong.li@sifive.com> wrote:
> > >
> > > Like the commit cb9d7fd51d9f ("watchdog: Mark watchdog touch functions
> > > as notrace"), some architectures assume that the stopped CPUs don't make
> > > function calls to traceable functions when they are in the stopped
> > > state. For example, it causes unexpected kernel crashed when switching
> > > tracer on RISC-V.
> > >
> > > The following patches added calls to these two functions, fix it by
> > > adding the notrace annotations.
> > >
> > > Fixes: 4ecf0a43e729 ("processor: get rid of cpu_relax_yield")
> > > Fixes: 366237e7b083 ("stop_machine: Provide RCU quiescent state in
> > > multi_cpu_stop()")
> > >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > ---
> > >  kernel/rcu/tree.c     | 2 +-
> > >  kernel/stop_machine.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 06895ef85d69..2a52f42f64b6 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -409,7 +409,7 @@ bool rcu_eqs_special_set(int cpu)
> > >   *
> > >   * The caller must have disabled interrupts and must not be idle.
> > >   */
> > > -void rcu_momentary_dyntick_idle(void)
> > > +notrace void rcu_momentary_dyntick_idle(void)
> > >  {
> > >         int special;
> > >
> > > diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> > > index 865bb0228ab6..890b79cf0e7c 100644
> > > --- a/kernel/stop_machine.c
> > > +++ b/kernel/stop_machine.c
> > > @@ -178,7 +178,7 @@ static void ack_state(struct multi_stop_data *msdata)
> > >                 set_state(msdata, msdata->state + 1);
> > >  }
> > >
> > > -void __weak stop_machine_yield(const struct cpumask *cpumask)
> > > +notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
> > >  {
> > >         cpu_relax();
> > >  }
> > > --
> > > 2.28.0
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
>
>
>
> --
> Regards,
> Atish



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
