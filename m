Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26501C433EF
	for <rcu@archiver.kernel.org>; Tue, 16 Nov 2021 08:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C08461B2A
	for <rcu@archiver.kernel.org>; Tue, 16 Nov 2021 08:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhKPI2e (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbhKPI2c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Nov 2021 03:28:32 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68815C061570
        for <rcu@vger.kernel.org>; Tue, 16 Nov 2021 00:25:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id np3so15121764pjb.4
        for <rcu@vger.kernel.org>; Tue, 16 Nov 2021 00:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/k7ZQTqFPkVe68fPluKvdaKWxmA9a158887sw7Su1/4=;
        b=gLogDyhZU9sK0BSc6HsmO9xUvr3Aa0msUi4iNIOMyKknMCxjkBZUFNTjDNE3ITZ4IU
         dxAEiZ/nHAyvE7WdRnGePxamCaPcSLfDfe+2HIv9vnWpQjuH098iXl/hi7I2Uomy4CT6
         vX53QncWyakrpgV6TIInfFmwpY3X8Jno43gPIZkA9ypMugvwZR0oEJF30lFkIpGbm7B3
         XBYkGdUute6bJNMM23cavnEtz1iX+r5did5r5aDa5Q8+QD7ICT9ePoS5vnekAlzSg3Dj
         AiobkzNHk//otAr/iVcQasZBYRb0DaXUxcXlbl0EdYo8sBY6CFNaz/6VveMCQU6EuIph
         eUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/k7ZQTqFPkVe68fPluKvdaKWxmA9a158887sw7Su1/4=;
        b=oQR98JQmvJVSSzz3D/koFMz8xGkDBB77MC2YrPGAF5VtnDTrjwFxlKAFRuQfS9Z1jr
         jT8niYbWVUt28Rj5xFEaWd2O6IQTAL9kMDcGm7NJCurgZEESKaqFbZnTlQUr2rrpx3PJ
         DNu2ITdUxlsWyKCqkhAgW7xXN8pljCp1oy7xYK0wSwy0UV59ao4uvq++bEZ9f9s0iHZ5
         J9UWoZf50GBSNRYj+U1s4Ye+9gGjyJGPjUjxI8WwxoMWzXGjDESBSVaMEqoXHYRGOkFv
         3TULjjX/XpfkhDBfUUdY+OaVyU2l3RRPqAhw5hTzBeqRLochjNSiAcof9sAGq3p1ZL4W
         QfKg==
X-Gm-Message-State: AOAM532AXsVM3U7/53Bh2OnfB/PzCdp222wUI0U54R1jQoZNwtTjkTKt
        4uFvi3YbyDR65WP/SP7Jcg==
X-Google-Smtp-Source: ABdhPJzmw70bzQWlkimM0FYveFOEKi10kbRk4Q8PEUVrScT8iKsxaUDdDV6cRHFB0t2eyRD8LqF2NA==
X-Received: by 2002:a17:90b:4b48:: with SMTP id mi8mr1126119pjb.214.1637051136061;
        Tue, 16 Nov 2021 00:25:36 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 11sm17104011pfl.41.2021.11.16.00.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 00:25:35 -0800 (PST)
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
Subject: [PATCHv3 4/4] arm64: entry: remove pNMI judgement in __el1_interrupt() path
Date:   Tue, 16 Nov 2021 16:24:50 +0800
Message-Id: <20211116082450.10357-5-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116082450.10357-1-kernelfans@gmail.com>
References: <20211116082450.10357-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Now, all pNMI can be detected before the dispatching of __el1_pnmi() or
__el1_interrupt(), and __el1_interrupt() will never be called in pNMI
context. As a result, the judgement of pNMI in
arm64_preempt_schedule_irq() becomes unnecessary.

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
 arch/arm64/kernel/entry-common.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index afcde43f1b73..57d654b915a5 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -224,15 +224,6 @@ static void __sched arm64_preempt_schedule_irq(void)
 {
 	lockdep_assert_irqs_disabled();
 
-	/*
-	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
-	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
-	 * using gic_arch_enable_irqs() for normal IRQs. If anything is set in
-	 * DAIF we must have handled an NMI, so skip preemption.
-	 */
-	if (system_uses_irq_prio_masking() && read_sysreg(daif))
-		return;
-
 	/*
 	 * Preempting a task from an IRQ means we leave copies of PSTATE
 	 * on the stack. cpufeature's enable calls may modify PSTATE, but
-- 
2.31.1

