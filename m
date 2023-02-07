Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC2C636D4
	for <rcu@archiver.kernel.org>; Tue,  7 Feb 2023 23:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjBGXFV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBGXFL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Feb 2023 18:05:11 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70863D084
        for <rcu@vger.kernel.org>; Tue,  7 Feb 2023 15:04:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bk16so15070657wrb.11
        for <rcu@vger.kernel.org>; Tue, 07 Feb 2023 15:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+woZryxcmbb99mupmnna5okozeg16DDHF5Mj8G3upM=;
        b=I6OGmp/zf+SXm16RpuuHG0Cs0grAvvCacNPO9dKsk1CnGRmdMFu6+0NJdJhyZFTM4X
         t222CAl7UR84WcZsi9vxKoozrPUuo3JLOzCIH9sxnbaS2E1xVnpxE5522R2XhnSGXoAq
         H4dMxa2K3aJcC4yIroI+hFKQ3ShkEp8NGiIlepnXYdQeZXr63YjWL9GWbYxgDjB8SqFq
         6hSMRm3TCfJwjZPwZVHhxdN9/3ajo3kOYvz8TDCXvwpUD7+G2VBebFw/w20A52rvxJgq
         tohCQW4m433T31Ja45QB9CYTeV4/Ljp7ac0MTuuxzvTX9xUgS2fkFqmLhmlrsnEBHe/T
         tISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+woZryxcmbb99mupmnna5okozeg16DDHF5Mj8G3upM=;
        b=OvnREcsRMNUZBd7X575J/NivH7O63g9EK3zOCGnBHyui8mKu1meUG0XjEJn/xUMBPp
         YOCpfNN9W+13j7jcAG8EbmI/szpSmepdigNZbHozgaIIG0UUxgTkEwhPDsCfmKZLoFEI
         ipiuyYBowznYznvki+jw+Yz4DnOfRAhl7fQKs18/FagDEeFt8ThiVB9Luyq3p5LPtZ7i
         ivIIm+m9rhIDHWoe34VnbaPCS4JAqfkT2yBg6MAdymZT0eTZmiRCV6rbMZ/rFL7JSv0q
         jhEb1v7OsmtIV3HM3D7JogPw0MjZqwZayS55FfzZg4GuN//9xzcfxBBY05UtwYDFHmS1
         xVlw==
X-Gm-Message-State: AO0yUKXBEEmH6FOrolIABiDH1Sb6f6u0M45LoSWqWf42XrhLEhIk4dGi
        dd6x0OQicnMw/lLnnYECsxOLbw==
X-Google-Smtp-Source: AK7set+kviHpO/dgYo6fG95FwmeukrqggqusKN5eb8Q4daAsLpnqIvfLT8PSlOVWaMCGZUHBCi1JdQ==
X-Received: by 2002:a5d:5183:0:b0:2bf:b5ec:4844 with SMTP id k3-20020a5d5183000000b002bfb5ec4844mr4689320wrv.19.1675811084196;
        Tue, 07 Feb 2023 15:04:44 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:c04f:2463:c151:8b87])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b003dcc82ce53fsm146485wmq.38.2023.02.07.15.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:04:43 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com
Cc:     arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v7 4/9] x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
Date:   Tue,  7 Feb 2023 23:04:31 +0000
Message-Id: <20230207230436.2690891-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207230436.2690891-1-usama.arif@bytedance.com>
References: <20230207230436.2690891-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

When bringing up a secondary CPU from do_boot_cpu(), the warm reset flag
is set in CMOS and the starting IP for the trampoline written inside the
BDA at 0x467. Once the CPU is running, the CMOS flag is unset and the
value in the BDA cleared.

To allow for parallel bringup of CPUs, add a reference count to track the
number of CPUs currently bring brought up, and clear the state only when
the count reaches zero.

Since the RTC spinlock is required to write to the CMOS, it can be used
for mutual exclusion on the refcount too.

[Usama Arif: fixed rebase conflict]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/kernel/smpboot.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 55cad72715d9..3a793772a2aa 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -121,17 +121,20 @@ int arch_update_cpu_topology(void)
 	return retval;
 }
 
+
+static unsigned int smpboot_warm_reset_vector_count;
+
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&rtc_lock, flags);
-	CMOS_WRITE(0xa, 0xf);
+	if (!smpboot_warm_reset_vector_count++) {
+		CMOS_WRITE(0xa, 0xf);
+		*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_HIGH)) = start_eip >> 4;
+		*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = start_eip & 0xf;
+	}
 	spin_unlock_irqrestore(&rtc_lock, flags);
-	*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_HIGH)) =
-							start_eip >> 4;
-	*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =
-							start_eip & 0xf;
 }
 
 static inline void smpboot_restore_warm_reset_vector(void)
@@ -143,10 +146,12 @@ static inline void smpboot_restore_warm_reset_vector(void)
 	 * to default values.
 	 */
 	spin_lock_irqsave(&rtc_lock, flags);
-	CMOS_WRITE(0, 0xf);
+	if (!--smpboot_warm_reset_vector_count) {
+		CMOS_WRITE(0, 0xf);
+		*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
+	}
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
-	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
 }
 
 /*
-- 
2.25.1

