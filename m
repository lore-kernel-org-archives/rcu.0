Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F7CC433F5
	for <rcu@archiver.kernel.org>; Tue, 16 Nov 2021 08:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD1461B49
	for <rcu@archiver.kernel.org>; Tue, 16 Nov 2021 08:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhKPI2c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhKPI22 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Nov 2021 03:28:28 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BFC061570
        for <rcu@vger.kernel.org>; Tue, 16 Nov 2021 00:25:31 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p18so16687847plf.13
        for <rcu@vger.kernel.org>; Tue, 16 Nov 2021 00:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//SVuRQZNeICMM4rTHo9U8V7XTbAQzXJNXUlaXcEOp8=;
        b=nesmj2WHSb3eH7fuMb6p0CAcsMNDE4wLALbctRqOAlUtjb5/q80zeF9v6MX8XCLhiR
         CZmm4TXu8QOXLYGj3KHW/rUPmu9foWHOfTy7+WU9VSMVqKAmRFWOQKsFuJooexa7ljLW
         eVxBzLPBhCGMEeIT5dZmEcVqPj2aP6R2JTafiBqaWMneqRU44ucCuqT5AvnDRZS75Mq2
         FpYrODPSOLr2la4mOvGvR/NLzybziOy4+yQnDoID8zKelwmPVKEm/qPQjMBLg1+UdY8t
         tGEu4FGxyJplAolFRIpg+nSKMvooaFv+7BZVyaBnC7er44JCxSBtL6+AJM+lKw5vkCVG
         lX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//SVuRQZNeICMM4rTHo9U8V7XTbAQzXJNXUlaXcEOp8=;
        b=U2/y4pWOSL3vaci8i17TrqqNYTu0hCnwbsV0gL8rgaQe9kJDKBVRSPD1aGVYo8zwqP
         l3uC+SFFNTHZNKyogLBpYxD2ch0CjWD7N1/xFWW1Yqy8676zB53fzAWwm+abtRRzIlZ4
         TNp2DeG6P23lmLx4Turz0TP0Mi8VdURf/UA7LZrxAtBxaUAlZwXA5yWl8t+oM4hoZ9tC
         R6+Ie1zJC7+fsILGTf+C6qhaQJN5jg5+USoG6oG6PCOt28L7ooLK1u2q+kllPkXct210
         poeLQncMNTbpOLxQHEQUxeVem1glX/uFG0O8W8mcXrC0mysoMGItAau7Fv0HUQ6uHtWE
         f3fA==
X-Gm-Message-State: AOAM532v9QEDhOJdxBVg1iWcZ+NFv8ZuijDUWYgpJaOMkaE8qrz/eJK6
        vrQSLb9t9huEfiGntpxSKCokoBkOLw==
X-Google-Smtp-Source: ABdhPJxrh7wztctEh4f9+votntRIdsRQs/MJFo9pbLgf8IjPdGR+xL1sJ39r13+T8Q5bSBByYOPnog==
X-Received: by 2002:a17:903:2305:b0:142:1bca:72eb with SMTP id d5-20020a170903230500b001421bca72ebmr42454407plh.67.1637051131392;
        Tue, 16 Nov 2021 00:25:31 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 11sm17104011pfl.41.2021.11.16.00.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 00:25:31 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>, rcu@vger.kernel.org
Subject: [PATCHv3 3/4] irqchip: GICv3: expose pNMI discriminator
Date:   Tue, 16 Nov 2021 16:24:49 +0800
Message-Id: <20211116082450.10357-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116082450.10357-1-kernelfans@gmail.com>
References: <20211116082450.10357-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Arch level code is ready to take over the nmi_enter()/nmi_exit()
housekeeping.

GICv3 can expose the pNMI discriminator, then simply remove the
housekeeping.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
Cc: rcu@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 drivers/irqchip/irq-gic-v3.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index daec3309b014..aa2bcb47b47e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -646,12 +646,8 @@ static void gic_deactivate_unhandled(u32 irqnr)
 
 static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
 {
-	bool irqs_enabled = interrupts_enabled(regs);
 	int err;
 
-	if (irqs_enabled)
-		nmi_enter();
-
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_write_eoir(irqnr);
 	/*
@@ -664,8 +660,6 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
 	if (err)
 		gic_deactivate_unhandled(irqnr);
 
-	if (irqs_enabled)
-		nmi_exit();
 }
 
 static u32 do_read_iar(struct pt_regs *regs)
@@ -702,6 +696,15 @@ static u32 do_read_iar(struct pt_regs *regs)
 	return iar;
 }
 
+static bool gic_is_in_nmi(void)
+{
+	if (gic_supports_nmi() &&
+	    unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(GICD_INT_NMI_PRI)))
+		return true;
+
+	return false;
+}
+
 static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
@@ -1791,6 +1794,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	}
 
 	set_handle_irq(gic_handle_irq);
+#if IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI)
+	set_nmi_discriminator(gic_is_in_nmi);
+#endif
 
 	gic_update_rdist_properties();
 
-- 
2.31.1

