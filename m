Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9FBC64EC5
	for <rcu@archiver.kernel.org>; Wed,  1 Feb 2023 20:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjBAUp3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjBAUpY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Feb 2023 15:45:24 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450DA7909C
        for <rcu@vger.kernel.org>; Wed,  1 Feb 2023 12:44:52 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m14so18029329wrg.13
        for <rcu@vger.kernel.org>; Wed, 01 Feb 2023 12:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6e9FsuHypszT7EvXQeEpKp5FLlszNay99UK4BoH4rM=;
        b=CwNSnHQiMWxYA/AjxMfHHlxHH6vbja8TRT1y9aTu12HxkVYye6Siks4+Jaoz8DdYxQ
         6BN+MgUbghZ8pXP0F5EbX5ssnDuePd0zdBTOYLLR8v22Ii2gWTUTGBprCQpHnhfHBWvk
         PqKjfY4iLnId8XY6A4ykMVbHrxoldwAKGVzmzZpkg0nn0wwbaSGA4cnQUaM1Ni9KbNaD
         2RK+CsdP0BEyIf9mghg++Zqpek1O2bkzOcfh8r5xI2mhqrPe10iuvsiCKyuusr9771iT
         mEc3DngzAFDNe3VmiJM4yva9zuZhtHvXT1kl2z1yXbyf2tDSPhRTgy3GdMVg7AI8NUti
         lpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6e9FsuHypszT7EvXQeEpKp5FLlszNay99UK4BoH4rM=;
        b=naO8C66rhsBN4JnVcRdC9ENzm8BtvvKNq5rF0DOfIt5IFjDGwQTvD6opgW/y5sdpgf
         CzU8zxQphfauyMfO+Hyi1U3tpjFVONXw5plxKWRcuJyw7LUvl5sqauv3s1ULrrdk0Jkg
         rJICM5Uqw2E6MgEbp7J0VKn6t81T43BnOOWT+Tv+gwcaicVwEGGCkOA38OOc9OaFd3cO
         u5buuwZPI9CqB2uAT+zSF3xB3D9bA2H13VvTEcQAyaPPseBMoozKaoG2Mum4lgMqRWlg
         Yu24kBiGpWg1ok1jCiyB2Xbd5uUyCM+SieV3mMTW7WrKz3kLqA8lYIH3OZT4h0+pU3uo
         Kl9g==
X-Gm-Message-State: AO0yUKUGzPCE+q661fsYZK2TK1MWatbeKlA/iq2KYSt7AO56FI0AE89R
        e6+0+kgU4InrRm/mCRRN710hZA==
X-Google-Smtp-Source: AK7set/pT3z74IzW2nBj02yK+QlfaSM8ms0sxco1W7xIC1ERUGrB3EahjT363MYdB+ER9YH03N5g7Q==
X-Received: by 2002:a5d:5643:0:b0:2c0:227d:ca48 with SMTP id j3-20020a5d5643000000b002c0227dca48mr3283516wrw.63.1675284290622;
        Wed, 01 Feb 2023 12:44:50 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:7611:c340:3d8d:d46c])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b002bdff778d87sm19993584wri.34.2023.02.01.12.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:44:50 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH 4/9] x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
Date:   Wed,  1 Feb 2023 20:43:33 +0000
Message-Id: <20230201204338.1337562-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201204338.1337562-1-usama.arif@bytedance.com>
References: <20230201204338.1337562-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

If we want to do parallel CPU bringup, we're going to need to set this up
and leave it until all CPUs are done. Might as well use the RTC spinlock
to protect the refcount, as we need to take it anyway.

[Usama Arif: fixed rebase conflict]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/kernel/smpboot.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index dd2f61c3797f..2d5014752dc4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -120,17 +120,22 @@ int arch_update_cpu_topology(void)
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
+		*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_HIGH)) =
+			start_eip >> 4;
+		*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =
+			start_eip & 0xf;
+	}
 	spin_unlock_irqrestore(&rtc_lock, flags);
-	*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_HIGH)) =
-							start_eip >> 4;
-	*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =
-							start_eip & 0xf;
 }
 
 static inline void smpboot_restore_warm_reset_vector(void)
@@ -142,10 +147,12 @@ static inline void smpboot_restore_warm_reset_vector(void)
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

