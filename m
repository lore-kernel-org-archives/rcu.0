Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FA1C388F7
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 02:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935F520757
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 02:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j1izakXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391344AbgJ2CeX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391341AbgJ2CeW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Oct 2020 22:34:22 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D557C0613D1
        for <rcu@vger.kernel.org>; Wed, 28 Oct 2020 19:34:22 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n15so1048740otl.8
        for <rcu@vger.kernel.org>; Wed, 28 Oct 2020 19:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfhlQfEFInfQ3atHQjjksOFf+qtDTs9/oV6yszXiSKI=;
        b=j1izakXZ6e1uwDZkEieNsENHOkPTe0Mkrq4UW9+OkbU55j7m3R+khlE6j+1OkXRgP6
         xo+GvNuMV8EKtV2FiB0QtquU0ax2fqmQyIliSun6gaHC9AxBzWy7ItX6mJhUl5tyE1ld
         0zEQm9LryOlZy/uMUGRssS7SZKkgTnjIh/t2psjcqPB+mdYJyNZFopk/No/AeMua+IOq
         fYRuxgTM0Uzp0ozHAlb4VOsIISTtxUmUTn+S5cB0qNzL8r93taBUAvGqM5vmAYKFW2FK
         GyD2EcXKlPhP5el0djs6Udnlt4vc+Nw8G//gdlRjwWEFg2wslHimBeXgMdKJ3BpnT50I
         9CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfhlQfEFInfQ3atHQjjksOFf+qtDTs9/oV6yszXiSKI=;
        b=scvWN4DUtSjexjk9so1zjytzF4D4W+TwCxsWOLgaCpTXgbCJbPqOCNAnYDphK7DkLi
         ahQ+jOayECkUsflawZ4B5XJMg6pqMP8e7edqHuGg6aBNPRzTEgbwAvzOCT5G29AGUZgO
         RlDqCKYmlwUyQsWMQItKpAlmVVOotWLK4Y1DfbT2HuphyZr05OauxL+nDfF+BFxHVPsP
         iieegOuQ5sOcYePXkdypMh9pSIA7VN2XWOBeIrRx3CzWyL3BF1or4JxTs3cfACgRDKBJ
         FXH6dVbGzBH8hUNSQxkdQzFAf2JaguFATeXeB6TxyiVDJdjT9nbRMs0jqkrKhJ3UrpBg
         Zi8Q==
X-Gm-Message-State: AOAM533lYI+4kJrLrPY96+VsuTev+Q+y90RPWIXgBSuJMVNLRJGmPsSg
        8VvECr/oRbX3DMK14cF9ETuSFsDpRjziS6gCdtdeqg==
X-Google-Smtp-Source: ABdhPJzG0USy5ERlP8Kog/M2N4C60AgQhqPla8TS+vyLvPQLkWwgXxqXm1myOHgzFqZ8ZRMpZNM3P/KT8GNo3tNA498=
X-Received: by 2002:a9d:bb2:: with SMTP id 47mr1698842oth.160.1603938861370;
 Wed, 28 Oct 2020 19:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201021073839.43935-1-zong.li@sifive.com> <CAJF2gTTnGSYAc3AZKCPvhNJsPm_TchPjPrtqc_WzaK7K5eNt+w@mail.gmail.com>
 <CAOnJCULN8h0Jk3H-vskgbaXhgBTgTTAT5Dji0qHi6yHoXGePvg@mail.gmail.com>
In-Reply-To: <CAOnJCULN8h0Jk3H-vskgbaXhgBTgTTAT5Dji0qHi6yHoXGePvg@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 29 Oct 2020 10:34:10 +0800
Message-ID: <CANXhq0q_fOg7vsniVMtNd8VezW1yymf55FYRc61WMkXMOtZpgA@mail.gmail.com>
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Guo Ren <guoren@kernel.org>, Paul McKenney <paulmck@kernel.org>,
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
>
> Few of these functions may be inlined by compiler. Can we depend on that ?
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

It seems to me that the problem happens on the waiting threads, it
doesn't cause the issue on the patching code thread, so it is OK that
these functions are traceable. I probably don't figure out all
possible situations, do you find any issue and reason to change the
annotation of these functions?

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
