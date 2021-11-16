Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8491DC433F5
	for <rcu@archiver.kernel.org>; Tue, 16 Nov 2021 08:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647F461B2A
	for <rcu@archiver.kernel.org>; Tue, 16 Nov 2021 08:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhKPI2Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhKPI2X (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Nov 2021 03:28:23 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD58C061570
        for <rcu@vger.kernel.org>; Tue, 16 Nov 2021 00:25:27 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so2184911pjb.5
        for <rcu@vger.kernel.org>; Tue, 16 Nov 2021 00:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wk9eWki6Vbr1g31d7LZ5+7G/iNYTD2zJddi+RKAgoB0=;
        b=qbQgqz/6Q4V2kYlnnIy4Cm0ACd+yZ6NY9vHiRejN/0QP3DdiFmCNfBsvlwNNiAcAQR
         evQve1SXuMG27TeaKq9uqwfbMziTpF0Ono9iNzytndm5pxxNEynJYkYc5XS1sqvbzlJA
         Qk7rHY51WRAWfnsW53QfEWaTAj+ygL+hbZRMrJaVlSOZnboNjmP+K5wXSbA9QP6eTjWt
         L9KzIruwbF2d0tFIKUleW8iQye3lK7UckJthsUCirZgKW/0dNb/pyRv/JLtIo7+RmDAM
         uPir8R09bq01bEgE05LPkD95Bo83PelkxEtR2kVqJ+FA4bcHmt2nCoUEf29TFw5HkTGC
         7UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wk9eWki6Vbr1g31d7LZ5+7G/iNYTD2zJddi+RKAgoB0=;
        b=4ku93/N0acl9+Ul8ax1VpqWmv/YlhbdClUAS/MfuT7wnQAviook8S+DmJfIvVyqyJ3
         ffqgBw/n0CQcLUsg3MLkBZHjPl10w6Esz0C3bxz+V1s8+1uUerdAYfxU2JgRlSsDRy/C
         IAzF4nmbU1u5hedjNzBYztZw14LfWMz3TDAsuaEY1ytzy23STgoiRt7YNrkcOaEWMRRm
         n9vJPN7q7jSOXa1qlto0CLvM9t7xr+VIjCGtjoc5jbeSTRcZLOa5FBYbHwsx1DZpifaN
         WOgy7q5m5oBHEXRIL1MjC9k1Dc+VXE5dGNrH7fR6DfqUiMT74XGUoJefaBgo92KWkdgk
         igSg==
X-Gm-Message-State: AOAM533FlMH57gLtgUccFfi8/YGUYO2ukg4AnchkIT1rhI67ni4csxNF
        h2+gHKuzKDAky9aqJQD3bg==
X-Google-Smtp-Source: ABdhPJy/K+gtd8EEbXE7wMYw1LqoOMvVTVeuoRYSX4WAXNtZ2IJko0ykR48BE85DAsBHQeQcm+FwAA==
X-Received: by 2002:a17:902:ce85:b0:141:de7d:514e with SMTP id f5-20020a170902ce8500b00141de7d514emr42952552plg.0.1637051126766;
        Tue, 16 Nov 2021 00:25:26 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 11sm17104011pfl.41.2021.11.16.00.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 00:25:26 -0800 (PST)
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
Subject: [PATCHv3 2/4] arm64: entry: distinguish pNMI earlier in el0 interrupt
Date:   Tue, 16 Nov 2021 16:24:48 +0800
Message-Id: <20211116082450.10357-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116082450.10357-1-kernelfans@gmail.com>
References: <20211116082450.10357-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

For ease of unifying code, it is helpful to lift nmi_{enter,exit}()
housekeeping from gic_handle_nmi() to el0_interrupt(). Because
gic_handle_nmi() is called by either el1 interrupt or el0, and the
housekeeping has already been done in arch level code when el1
interrupt.

Note about the original code, which calls enter_from_user_mode() in pNMI
context. Although it is weird to call rcu_eqs_exit() in the pseudo NMI
context, it has no problem. This is due to the essentiality of pNMI, a
higher priority interrupt but not akin to NMI, which allows a break-in
at any time.

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
 arch/arm64/kernel/entry-common.c | 35 ++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 5a1a5dd66d04..afcde43f1b73 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -429,7 +429,7 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
 	}
 }
 
-static __always_inline void __el1_pnmi(struct pt_regs *regs,
+static __always_inline void __pnmi_handler_common(struct pt_regs *regs,
 				       void (*handler)(struct pt_regs *))
 {
 	arm64_enter_nmi(regs);
@@ -437,6 +437,12 @@ static __always_inline void __el1_pnmi(struct pt_regs *regs,
 	arm64_exit_nmi(regs);
 }
 
+static __always_inline void __el1_pnmi(struct pt_regs *regs,
+				       void (*handler)(struct pt_regs *))
+{
+	__pnmi_handler_common(regs, handler);
+}
+
 static __always_inline void __el1_irq(struct pt_regs *regs,
 				      void (*handler)(struct pt_regs *))
 {
@@ -673,21 +679,34 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
 	}
 }
 
-static void noinstr el0_interrupt(struct pt_regs *regs,
-				  void (*handler)(struct pt_regs *))
+static __always_inline void __el0_pnmi(struct pt_regs *regs,
+				       void (*handler)(struct pt_regs *))
+{
+	__pnmi_handler_common(regs, handler);
+}
+
+static __always_inline void __el0_irq(struct pt_regs *regs,
+				       void (*handler)(struct pt_regs *))
 {
 	enter_from_user_mode(regs);
+	irq_enter_rcu();
+	do_interrupt_handler(regs, handler);
+	irq_exit_rcu();
+	exit_to_user_mode(regs);
+}
 
+static void noinstr el0_interrupt(struct pt_regs *regs,
+				  void (*handler)(struct pt_regs *))
+{
 	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
 
 	if (regs->pc & BIT(55))
 		arm64_apply_bp_hardening();
 
-	irq_enter_rcu();
-	do_interrupt_handler(regs, handler);
-	irq_exit_rcu();
-
-	exit_to_user_mode(regs);
+	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && is_in_pnmi(regs))
+		__el0_pnmi(regs, handler);
+	else
+		__el0_irq(regs, handler);
 }
 
 static void noinstr __el0_irq_handler_common(struct pt_regs *regs)
-- 
2.31.1

