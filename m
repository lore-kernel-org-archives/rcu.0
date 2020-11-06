Return-Path: <SRS0=Bh/h=EM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729F3C388F7
	for <rcu@archiver.kernel.org>; Fri,  6 Nov 2020 02:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1054820782
	for <rcu@archiver.kernel.org>; Fri,  6 Nov 2020 02:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604630670;
	bh=u+MZqpvWInkjbiTiRhNhcfi5HyG0jDJfzIXf8mkzRTg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z3bmTcb2E6/ojFIMWJtqBKy7L0DJH7GdIKNxLp4cFR+Cu6UG48Vp0yJJCo3lgWHuW
	 HTpz3TNfqxM5sMQV6rBTEwX4Kb45R68aCkIUYHkqEZFNs1MFYr67IGhO2DTRL+Lqrk
	 TWNDK5KFw2rOyEmGPZzhUod/orrRIeDQUpd7fufQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgKFCo3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:44:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgKFCo3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 21:44:29 -0500
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C1962222A;
        Fri,  6 Nov 2020 02:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604630668;
        bh=u+MZqpvWInkjbiTiRhNhcfi5HyG0jDJfzIXf8mkzRTg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ei7E9EzWODWPV5ah0DiLrbW98dz4Cu/ApdiQXCoX3LOtv1wbjOROSXudjGF1vCpAs
         uaeVkcFwBVPYT7bkgoH41JFxsOpSF1ksEI4PRLHEyisritj0RpfeZRN2ubENGk5RHh
         ERomM+zEfTpynT4hYmTGzjaW6f7BmQoRI5mx6nJQ=
Received: by mail-lj1-f170.google.com with SMTP id m16so3744946ljo.6;
        Thu, 05 Nov 2020 18:44:28 -0800 (PST)
X-Gm-Message-State: AOAM533vm1MaQdFLRLrWbJc/CGei6r/Wynlm37tKKq6Rjl27ptY3Ilyn
        A6+m9mxywaZeMm/8UlBeGmlcjK8AlEF+xPhnMt4=
X-Google-Smtp-Source: ABdhPJygcmtXpwwUOt5cFszLO+Swf0jXQj/bnAh7umzjDgoyTuTZq8xPiq75eXRw8JqKV+Z6dB6H8inuGQP2qfdDmng=
X-Received: by 2002:a2e:b00d:: with SMTP id y13mr1855504ljk.346.1604630666154;
 Thu, 05 Nov 2020 18:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20201021073839.43935-1-zong.li@sifive.com> <CAJF2gTTnGSYAc3AZKCPvhNJsPm_TchPjPrtqc_WzaK7K5eNt+w@mail.gmail.com>
 <CAOnJCULN8h0Jk3H-vskgbaXhgBTgTTAT5Dji0qHi6yHoXGePvg@mail.gmail.com>
 <CANXhq0q_fOg7vsniVMtNd8VezW1yymf55FYRc61WMkXMOtZpgA@mail.gmail.com>
 <CAJF2gTR-_=_vDLsST9BVxRFC0OTR4_TYV-2=nH_Gux_zWDOk3Q@mail.gmail.com>
 <CAOnJCU+d5YQzKW2qs0NURJt1_5zrM6YXrkP4FzB_=zgbb-5DuA@mail.gmail.com>
 <CAJF2gTT9gZZftoUD4eMT0Th=oYOpsdYbrFdr=5kO2-N+ki51NA@mail.gmail.com>
 <CAOnJCULO7TuRhBcx6KUVr6t_jqouN-0rao9QXC1RgrU5ehutkw@mail.gmail.com>
 <20201030202818.72070cbd@oasis.local.home> <CAJF2gTSaSzvo2G7prqqtEOueGhERcrcM7VDjK=WeqtePhhZ+dg@mail.gmail.com>
 <CAOnJCU+kMJCrwJ5MD2pYRoub1TpVGgpfX=6nNG2uFB6PNJLEiA@mail.gmail.com>
In-Reply-To: <CAOnJCU+kMJCrwJ5MD2pYRoub1TpVGgpfX=6nNG2uFB6PNJLEiA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 6 Nov 2020 10:44:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSM866cg07Rhpj5fOrx7GsX1W5xT=LLXTZ_RuA+T9u_BQ@mail.gmail.com>
Message-ID: <CAJF2gTSM866cg07Rhpj5fOrx7GsX1W5xT=LLXTZ_RuA+T9u_BQ@mail.gmail.com>
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Zong Li <zong.li@sifive.com>,
        Paul McKenney <paulmck@kernel.org>, josh@joshtriplett.org,
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

On Tue, Nov 3, 2020 at 11:33 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Sat, Oct 31, 2020 at 12:42 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Sat, Oct 31, 2020 at 8:28 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Fri, 30 Oct 2020 14:47:56 -0700
> > > Atish Patra <atishp@atishpatra.org> wrote:
> > >
> > > > > Look at arm64, they __kprobes flag and I guess it would also prevent
> > > > > ftrace call site.
> > > > >
> > > >
> > > > Are you sure about that ? __kprobes puts the code in .kprobes.text section
> > > > which is under whitelist sections in recordmcount.pl & recordmcount.c.
> > >
> > > Correct, ftrace can trace functions marked with __kprobes. That said,
> > I guess wrong, thx for correct me.
> >
> > > the instruction you are looking at here, is in a file that is
> > > blacklisted from recordmcount.
> > >
> > >   CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
> > >
> > > All ftrace flags are removed from the compiling of insn.c, and every
> > > function in that file will not be traced.
> > Yes, arm64 prevents the whole file from ftrace. My patch just use
> > notrace flag setting on some functions.
> >
> > @Atish How do think:
> > CFLAGS_REMOVE_cacheflush.o = $(CC_FLAGS_FTRACE)
> > CFLAGS_REMOVE_sbi.o = $(CC_FLAGS_FTRACE)
> >
>
> Looks good to me. What should be done for copy_to_kernel_nofault ?
> That is also in the calling path.

There is no nops' entry in the prologue of copy_to_kernel_nofault.
>>>>
000000000000007c <.LVL6>:
}
  7c:   6105                    addi    sp,sp,32
  7e:   8082                    ret

0000000000000080 <copy_to_user_nofault>:
 *
 * Safely write to address @dst from the buffer at @src.  If a kernel fault
 * happens, handle that and return -EFAULT.
 */
long copy_to_user_nofault(void __user *dst, const void *src, size_t size)
{
  80:   1101                    addi    sp,sp,-32
  82:   e822                    sd      s0,16(sp)
  84:   ec06                    sd      ra,24(sp)
  86:   e426                    sd      s1,8(sp)
  88:   e04a                    sd      s2,0(sp)
  8a:   1000                    addi    s0,sp,32
<<<<
>>>>
cmd_mm/maccess.o :=
/root/source/riscv-tools/install_64gc/bin/riscv64-unknown-linux-gnu-gcc
-Wp,-MMD,mm/.maccess.o.d  -nostdinc -isystem
/root/source/riscv-tools/install_64gc/bin/../lib/gcc/riscv64-unknown-linux-gnu/8.4.0/include
-I./arch/riscv/include -I./arch/riscv/include/generated  -I./include
-I./arch/riscv/include/uapi -I./arch/riscv/include/generated/uapi
-I./include/uapi -I./include/generated/uapi -include
./include/linux/kconfig.h -include ./include/linux/compiler_types.h
-D__KERNEL__ ***-DCC_USING_PATCHABLE_FUNCTION_ENTRY*** -Wall -Wundef
-Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -fshort-wchar -fno-PIE
-Werror=implicit-function-declaration -Werror=implicit-int
-Wno-format-security -std=gnu89 -mabi=lp64 -march=rv64imac
-mno-save-restore -DCONFIG_PAGE_OFFSET=0xffffffe000000000
-mcmodel=medany -fno-omit-frame-pointer -mstrict-align
-fno-delete-null-pointer-checks -Wno-frame-address
-Wno-format-truncation -Wno-format-overflow -O2
--param=allow-store-data-races=0 -Wframe-larger-than=2048
-fstack-protector-strong -Wno-unused-but-set-variable
-Wimplicit-fallthrough -Wno-unused-const-variable
-fno-omit-frame-pointer -fno-optimize-sibling-calls
-fno-var-tracking-assignments -g ***-fpatchable-function-entry=8***
-Wdeclaration-after-statement -Wvla -Wno-pointer-sign
-Wno-stringop-truncation -Wno-array-bounds -Wno-stringop-overflow
-Wno-restrict -Wno-maybe-uninitialized -fno-strict-overflow
-fno-merge-all-constants -fmerge-constants -fno-stack-check
-fconserve-stack -Werror=date-time -Werror=incompatible-pointer-types
-Werror=designated-init -fmacro-prefix-map=./= -Wno-packed-not-aligned
   -DKBUILD_MODFILE='"mm/maccess"' -DKBUILD_BASENAME='"maccess"'
-DKBUILD_MODNAME='"maccess"' -c -o mm/maccess.o mm/maccess.c
<<<<

But copy_from_user_nofault has:
000000000000007c <.LVL6>:
}
  7c:   6105                    addi    sp,sp,32
  7e:   8082                    ret

0000000000000080 <copy_to_user_nofault>:
 *
 * Safely write to address @dst from the buffer at @src.  If a kernel fault
 * happens, handle that and return -EFAULT.
 */
long copy_to_user_nofault(void __user *dst, const void *src, size_t size)
{
  80:   1101                    addi    sp,sp,-32
  82:   e822                    sd      s0,16(sp)
  84:   ec06                    sd      ra,24(sp)
  86:   e426                    sd      s1,8(sp)
  88:   e04a                    sd      s2,0(sp)
  8a:   1000                    addi    s0,sp,32


I think it's a gcc problem, but satisfy our ftrace requirement.





--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
