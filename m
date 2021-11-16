Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CC5C433F5
	for <rcu@archiver.kernel.org>; Tue, 16 Nov 2021 08:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2787961B49
	for <rcu@archiver.kernel.org>; Tue, 16 Nov 2021 08:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhKPI2U (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhKPI2S (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Nov 2021 03:28:18 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF14BC061570
        for <rcu@vger.kernel.org>; Tue, 16 Nov 2021 00:25:21 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i12so502010pfd.6
        for <rcu@vger.kernel.org>; Tue, 16 Nov 2021 00:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hqFMIdJyaJEShckULa2FgjRnQWIhP9aK8GPkMVQJLb4=;
        b=It4SAbMnf2QadM4I4MSYROpfIQvR7YP1qg2P/fZRxoCaG76NW7tSt+4uw9fOnTVNQr
         jnpz89RB4/RhBf6iPztS5ZRXfE5zIOoIm92XY8Vv6V+4cy3dpT+Kk8xIWpV2F2bZagVF
         b3oU2RMn+hs56siMzUspt4VnlJTAZX0XBSLrHpnMznTUDOUPia4Nsvu7cAFLexIemRW1
         LRRMHAVMX5LCgODKMvZqGEqQCs1hazZouE/NYC9SaEdrJEcBPLKuhYQHZSIuk7Ai4Rut
         WSP7kcqP91pP4/pqFBnN7hsP0d6QhsJ3z/OqyXgjRwnxj9NQ2w/Uag/WSN8/kVa3iiFe
         EPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqFMIdJyaJEShckULa2FgjRnQWIhP9aK8GPkMVQJLb4=;
        b=te1sUShLRD3KqIndvQPF5Xy/YdQi1ce0SQANaq8r479qEhFI24gcGyYx/M40pEg1+D
         hG9ZRfRomJJtOfDFKNPr5Pi5yqJ38wGXIyPLMfJrqdj37A9hhQD0lewtgtic7rC2t3cK
         5aiLyzFPDlzX2w5PN+TsMWm7Bg+JrPUgJ7PctyMK3w0+72oRFIzU6GH/EEsTJ7ot/vhp
         Q/nDZ2oIOXJKtM/WLPIudDZSCu1y7SDZVYYfVH5mBSJ7PereKs+OdJK70ZvESLG0ccai
         /G22BtsNiCRoMa0t8oN901gAIky0QiL+F6jBpJ7X1uLGtDdntfRiPCw+S7lfA1ITGN5r
         sUxg==
X-Gm-Message-State: AOAM533VBbjhXPy/u7Ms2cR5HaTbnQAiAT3U++/6SJE4lw2p7bfZYjX7
        EXpSL7CkRVrXFzH6Z5LqpA==
X-Google-Smtp-Source: ABdhPJxv0DVZZb6FhubzM7YyR1ApCXK8IqOIdPyd5tZXRxwWzCc8NeH0UAwvpJZmnjBFXsDisloaFQ==
X-Received: by 2002:aa7:9257:0:b0:4a2:b444:ac33 with SMTP id 23-20020aa79257000000b004a2b444ac33mr16391813pfp.20.1637051121427;
        Tue, 16 Nov 2021 00:25:21 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 11sm17104011pfl.41.2021.11.16.00.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 00:25:21 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>, rcu@vger.kernel.org
Subject: [PATCHv3 1/4] arm64: entry: judge nmi ealier to avoid deadlock in RCU
Date:   Tue, 16 Nov 2021 16:24:47 +0800
Message-Id: <20211116082450.10357-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116082450.10357-1-kernelfans@gmail.com>
References: <20211116082450.10357-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Linux kernel places strict semantics between NMI and maskable interrupt.
So does the RCU component, else deadlock may happen. But the current
arm64 entry code can partially breach this rule through calling
rcu_nmi_enter().

***  how a deadlock can happen if NMI mistaken as IRQ  ***

    rcu_nmi_enter()
    {

        if (rcu_dynticks_curr_cpu_in_eqs()) {

        	if (!in_nmi())
        		rcu_dynticks_task_exit();
                ...
        	if (!in_nmi()) {
        		instrumentation_begin();
        		rcu_cleanup_after_idle();
        		instrumentation_end();
        	}
                ...
        } else if (!in_nmi()) {
        	instrumentation_begin();
        	rcu_irq_enter_check_tick();
        }

    }

If a NMI is mistaken as a maskable interrupt, rcu_irq_enter_check_tick()
can hit a deadlock, which is demonstrated by the following scenario:

    note_gp_changes() runs in a task context
    {
       local_irq_save(flags); // this protects against irq, but not NMI
       rnp = rdp->mynode;
       ...
       raw_spin_trylock_rcu_node(rnp)
                                  -------> broken in by (p)NMI, without taking __nmi_enter()
                                           rcu_nmi_enter()
                                            ->__rcu_irq_enter_check_tick()
                                               ->raw_spin_lock_rcu_node(rdp->mynode);
                                                   deadlock happens!!!

    }

*** On arm64, how pNMI mistaken as IRQ ***

On arm64, pNMI is an analogue to NMI. In essence, it is a higher
priority interrupt but not disabled by local_irq_disable().

In current implementation
1) If a pNMI from a context where IRQs were masked, it can be recognized
   as nmi, and calls __nmi_enter() immediately. This is no problem.

2) But it causes trouble if a pNMI from a context where IRQs were
   unmasked, and temporarily regarded as maskable interrupt.  It is not
   treated as NMI, i.e. calling nmi_enter() until reading from GIC.

    __el1_irq()
    {
      irq_enter_rcu()   ----> hit the deadlock bug
        gic_handle_nmi()
          nmi_enter()
          nmi_exit()
      irq_exit_rcu()
    }

*** Remedy ***

If the irqchip level exposes an interface for detecting pNMI to arch level
code, it can meet the requirement at this early stage. That is the
interface (*interrupt_is_nmi)() in this patch.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
Cc: rcu@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/irq.h     |  1 +
 arch/arm64/kernel/entry-common.c | 10 +++++++++-
 arch/arm64/kernel/irq.c          | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index fac08e18bcd5..f3eb13bfa65e 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -11,6 +11,7 @@ struct pt_regs;
 int set_handle_irq(void (*handle_irq)(struct pt_regs *));
 #define set_handle_irq	set_handle_irq
 int set_handle_fiq(void (*handle_fiq)(struct pt_regs *));
+int set_nmi_discriminator(bool (*discriminator)(void));
 
 static inline int nr_legacy_irqs(void)
 {
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index f7408edf8571..5a1a5dd66d04 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -260,6 +260,14 @@ static void do_interrupt_handler(struct pt_regs *regs,
 
 extern void (*handle_arch_irq)(struct pt_regs *);
 extern void (*handle_arch_fiq)(struct pt_regs *);
+extern bool (*interrupt_is_nmi)(void);
+
+static inline bool is_in_pnmi(struct pt_regs *regs)
+{
+	if (!interrupts_enabled(regs) || (*interrupt_is_nmi)())
+		return true;
+	return false;
+}
 
 static void noinstr __panic_unhandled(struct pt_regs *regs, const char *vector,
 				      unsigned int esr)
@@ -454,7 +462,7 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
 {
 	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
 
-	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
+	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && is_in_pnmi(regs))
 		__el1_pnmi(regs, handler);
 	else
 		__el1_irq(regs, handler);
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index bda49430c9ea..fabed09ed966 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -81,8 +81,14 @@ static void default_handle_fiq(struct pt_regs *regs)
 	panic("FIQ taken without a root FIQ handler\n");
 }
 
+static bool default_nmi_discriminator(void)
+{
+	return false;
+}
+
 void (*handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
 void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init = default_handle_fiq;
+bool (*interrupt_is_nmi)(void) __ro_after_init = default_nmi_discriminator;
 
 int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
@@ -104,6 +110,18 @@ int __init set_handle_fiq(void (*handle_fiq)(struct pt_regs *))
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI)
+
+int __init set_nmi_discriminator(bool (*discriminator)(void))
+{
+	if (interrupt_is_nmi != default_nmi_discriminator)
+		return -EBUSY;
+
+	interrupt_is_nmi = discriminator;
+	return 0;
+}
+#endif
+
 void __init init_IRQ(void)
 {
 	init_irq_stacks();
-- 
2.31.1

