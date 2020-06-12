Return-Path: <SRS0=lJWX=7Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92EAC433E0
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 05:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF72F20836
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 05:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591939858;
	bh=cYq4vqKHsesR3s5ajhm5S9PWZAD1eP2uMwW9ixQuVqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vu4upar9xGxQI7eBiP0n+Te4IJumDPJ+KGv/8arUYpp6axbVngvwqxoDyxgjHu2Zp
	 9R69kf126JEJByBemzITOcrXucg3D0lc66Qt60SY3wMaovVeJ+1V6S/rhB49Wy1rZ1
	 3p2LUSCIkLxF1fo+VcvbL0o46yHE/QHkBE8yFHi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFLFa6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgFLFa6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Jun 2020 01:30:58 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B7A20878
        for <rcu@vger.kernel.org>; Fri, 12 Jun 2020 05:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591939856;
        bh=cYq4vqKHsesR3s5ajhm5S9PWZAD1eP2uMwW9ixQuVqI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xblTg13JjgfCAJDp0JWxFiUwq2MhD1Edu5hG8hQcU06tqhiqf4EC4vs9sS3CtJKv+
         /Ogn6Q88hVnCbJKSUs0PR2pQQUsvJDwNwboL+2MxTW21jQDjl4AiUFG0LgoTt0gn9z
         5FQDrzQUBlbCv+aigaSPTqaDzAttk5ct4E7JykZs=
Received: by mail-wr1-f49.google.com with SMTP id r7so8428060wro.1
        for <rcu@vger.kernel.org>; Thu, 11 Jun 2020 22:30:56 -0700 (PDT)
X-Gm-Message-State: AOAM531qCEFGM6Zp8RBuMJc9wlooXTCgdZ5bFvjHUpmWKaM++b8hcOCh
        TOIeXJl1NyvQXZjajEQ+A8dp2fmmygeVdnTgpw0r8A==
X-Google-Smtp-Source: ABdhPJzR3kTxNV2SOoXBWgU11ExZSiCuIBgFGMBgRsShPvMN5LR4pslvf7zuof13gGNeLnnIa/r1MWo88LQR9bHNWGs=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr12758018wrm.75.1591939854768;
 Thu, 11 Jun 2020 22:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200611235305.GA32342@paulmck-ThinkPad-P72>
In-Reply-To: <20200611235305.GA32342@paulmck-ThinkPad-P72>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Jun 2020 22:30:42 -0700
X-Gmail-Original-Message-ID: <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com>
Message-ID: <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com>
Subject: Re: [PATCH RFC] x86/entry: Ask RCU if it needs rcu_irq_{enter,exit}()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 11, 2020 at 4:53 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> RCU needs to detect when one if its interrupt handlers interrupted an idle
> state, where an idle state is either the idle loop itself or nohz_full
> userspace execution.  When a CPU has been interrupted from one of these
> idle states, RCU can report a quiescent state, helping the current grace
> period to come to an end.
>
> However, there are optimized kernel-entry paths where handlers that
> would normally be executed in interrupt context are instead executed
> directly from the base process context, but with interrupts disabled.
> When such a directly-executed handler is followed by softirq processing
> (which re-enables interrupts), it is possible that one of RCU's interrupt
> handlers will interrupt this softirq processing.

Why is the softirq processing special?  ISTM the basic sequence of events is:

idle, RCU not watching, IRQs on because we're using a lousy idle
mechanism that requires IRQs on.

IRQ hits.  The ones you're describing are the
DEFINE_IDTENTRY_SYSVEC_SIMPLE ones, but I'm not sure why it would
matter.  IRQ does idtentry_enter_cond_rcu().

idtentry_entry_cond_rcu() sees __rcu_is_watching() return true and
does not do rcu_irq_enter().

softirq processing turns on IRQs, a new IRQ hits, and kaboom.

But this is a bit of a strange explanation.  The SYSVEC_SIMPLE paths
don't seem to do irq_exit_rcu(), so there's no softirq processing
unless I missed something.  But more importantly, what are we doing
making it through idtentry_enter_cond_rcu() with rcu not watching at
the end?  If we hit the idle loop, surely __rcu_is_watching() should
have returned false, right?

So I added a little warning to detect the case where your patch
actually changes something (I don't believe for a second that this
warning should be committed -- it's just to get the stack trace):

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index f0b657097a2a..77330b96d8e5 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -592,6 +592,8 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
                return true;
        }

+       WARN_ON_ONCE(system_state == SYSTEM_RUNNING && is_idle_task(current));
+
        /*
         * If RCU is watching then RCU only wants to check
         * whether it needs to restart the tick in NOHZ

And I get this:

[    1.054927] ------------[ cut here ]------------
[    1.054928] WARNING: CPU: 1 PID: 0 at arch/x86/entry/common.c:595
idtentry_enter_cond_rcu+0x86/0xa0
[    1.054929] Modules linked in:
[    1.054930] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.7.0+ #145
[    1.054931] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31
04/01/2014
[    1.054931] RIP: 0010:idtentry_enter_cond_rcu+0x86/0xa0
[    1.054933] Code: 7c 24 08 e8 3c 3e 00 00 e8 57 a5 6e ff e8 d2 49
00 00 84 c0 74 19 90 31 c0 5b c3 65 48 8b 04 25 c0 7e 01 00 f6 40 24
02 74 99 <0f> 0b 90 eb 94 0f 0b 90 eb e2 0f 0b 90 eb 9d 66 66 2e 0f 1f
84 00
[    1.054933] RSP: 0000:ffffc9000006bc10 EFLAGS: 00010002
[    1.054934] RAX: ffff88807d529800 RBX: ffffc9000006bc38 RCX: ffffffff81c01327
[    1.054935] RDX: 0000000000000000 RSI: ffffffff81c00f49 RDI: ffffc9000006bc38
[    1.054935] RBP: ffffc9000006bc38 R08: 0000000000000000 R09: 0000000000000000
[    1.054936] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    1.054936] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    1.054937] FS:  0000000000000000(0000) GS:ffff88807dd00000(0000)
knlGS:0000000000000000
[    1.054937] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.054938] CR2: 00000000ffffffff CR3: 0000000002620001 CR4: 0000000000360ee0
[    1.054938] Call Trace:
[    1.054939]  sysvec_call_function_single+0xa/0xd0
[    1.054939]  asm_sysvec_call_function_single+0x31/0x40
[    1.054940] RIP: 0010:__do_softirq+0xaa/0x437
[    1.054941] Code: 24 2c 0a 00 00 00 48 89 44 24 10 48 89 44 24 20
44 89 34 24 65 66 c7 05 22 b3 22 7e 00 00 e8 ad dc 40 ff fb 66 0f 1f
44 00 00 <b8> ff ff ff ff 48 c7 c6 00 51 60 82 0f bc 04 24 83 c0 01 49
89 f7
[    1.054941] RSP: 0000:ffffc9000006bd18 EFLAGS: 00000202
[    1.054942] RAX: 0000000000001a6e RBX: ffff88807d529800 RCX: 0000000000000000
[    1.054943] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff81e000a3
[    1.054944] RBP: ffffc9000006bdc8 R08: 0000000000000000 R09: 0000000000000000
[    1.054944] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[    1.054945] R13: 0000000000000000 R14: 0000000000000082 R15: 0000000000000000
[    1.054945]  ? __do_softirq+0xa3/0x437
[    1.054945]  ? __do_softirq+0xaa/0x437
[    1.054946]  ? __do_softirq+0xa3/0x437
[    1.054946]  ? update_ts_time_stats+0x4c/0x70
[    1.054947]  irq_exit_rcu+0xaf/0xc0
[    1.054947]  sysvec_apic_timer_interrupt+0x51/0xd0
[    1.054948]  asm_sysvec_apic_timer_interrupt+0x31/0x40
[    1.054948] RIP: 0010:native_safe_halt+0xe/0x10
[    1.054949] Code: 8b 00 a8 08 74 80 eb c2 cc cc cc cc e9 07 00 00
00 0f 00 2d 46 bf 4e 00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 36 bf 4e
00 fb f4 <c3> cc 41 54 55 53 48 83 ec 10 e8 43 b1 66 ff 65 8b 2d bc 07
4e 7e
[    1.054950] RSP: 0000:ffffc9000006bea0 EFLAGS: 00000206
[    1.054951] RAX: 0000000000001a69 RBX: 0000000000000001 RCX: 0000000000000000
[    1.054951] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff81b30789
[    1.054952] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[    1.054952] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88807d529800
[    1.054953] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88807d529800
[    1.054953]  ? default_idle+0x19/0x160
[    1.054954]  ? native_safe_halt+0xe/0x10
[    1.054954]  default_idle+0x1e/0x160
[    1.054955]  do_idle+0x1f5/0x270
[    1.054955]  ? _raw_spin_unlock_irqrestore+0x3a/0x50
[    1.054956]  ? trace_hardirqs_on+0x20/0xf0
[    1.054956]  cpu_startup_entry+0x14/0x20
[    1.054957]  start_secondary+0x147/0x170
[    1.054957]  secondary_startup_64+0xa4/0xb0

This is saying we were idle and __rcu_is_watching() correctly returned
false.  We got sysvec_apic_timer_interrupt(), which did
rcu_irq_enter() and then turned on IRQs for softirq processing.  Then
we got sysvec_call_function_single() inside that, and
sysvec_call_function_single() noticed that RCU was already watching
and did *not* call rcu_irq_enter().  And, if
sysvec_call_function_single() does rcu_is_cpu_rrupt_from_idle(), it
will return true.  So the issue is that RCU thinks that, since it


> +static __always_inline bool rcu_needs_irq_enter(void)
> +{
> +       return !IS_ENABLED(CONFIG_TINY_RCU) &&
> +               (context_tracking_enabled_cpu(smp_processor_id()) || is_idle_task(current));
> +}

x86 shouldn't need this context tracking check -- we won't even call
this if we came from user mode, and we make sure we never run with
IRQs on when we're in CONTEXT_USER.

I think my preference would be to fix this with something more like
tglx's patch but with an explanation:

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index f0b657097a2a..93fd9d6fe033 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -571,7 +571,7 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
                return false;
        }

-       if (!__rcu_is_watching()) {
+       if (!__rcu_is_watching() || is_idle_task(current)) {
                /*
                 * If RCU is not watching then the same careful
                 * sequence vs. lockdep and tracing is required
@@ -579,6 +579,18 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
                 *
                 * This only happens for IRQs that hit the idle
                 * loop, i.e. if idle is not using MWAIT.
+                *
+                * We also do this in nested IRQs in the idie task
+                * (e.g. we get an IRQ, we run softirqs with IRQs on after
+                * processing the IRQ, and we get another IRQ inside the
+                * softirq.)  This is because RCU wants to be able to tell
+                * whether it's running in an IRQ context directly inside
+                * idle (and hence interrupted a quiescent state) or
+                * interrupted kernel code that was coincidentally in the
+                * idle task (and hence the kernel was not quiescent).  RCU
+                * does this by counting rcu_irq_enter() levels.  This won't
+                * prevent scheduling in an otherwise schedulable context
+                * because the idle task can never schedule.
                 */
                WARN_ON_ONCE(!(regs->flags & X86_EFLAGS_IF));
                lockdep_hardirqs_off(CALLER_ADDR0);

Alternatively, perhaps rcu_is_cpu_rrupt_from_idle(void) could do something like:

if (softirq_count())
  return false;

if we believe that the only way this could happen was due to a softirq.
