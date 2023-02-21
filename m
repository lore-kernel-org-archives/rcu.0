Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82232C61DA3
	for <rcu@archiver.kernel.org>; Tue, 21 Feb 2023 22:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjBUWgP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjBUWgN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Feb 2023 17:36:13 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C377432E50
        for <rcu@vger.kernel.org>; Tue, 21 Feb 2023 14:35:48 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r7so5835327wrz.6
        for <rcu@vger.kernel.org>; Tue, 21 Feb 2023 14:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OivBWw2fC0XPAqVFrKNNGqM4Zo9U9YwXqHaW8wBeEGc=;
        b=z3Fc7VSK0hAVPFyhWY67Ud9SKIKhW7P69ArBPqHJvMF8jQXPeCUbwgWcJOQoPOvDKm
         d/btCYbWUb4chK7DYYDm6QDx35AIHdLcD6JmgHHFL6K8NwJcriIWSuPSHfTuptSDucGr
         9in6tq5eKudItevevBU3ijvkd0QtzObPRbeMMNZ7AsxYOKO7p0bxrEgIg2Fir48N3YIi
         +9TiiIKFHXMavVJtzXQb9fqMgj7tNUEXQVkoSrZSSydpH4EU+yfjvMAkAu7fp9zJKYFU
         tnuQowMDiTe1erC5MIPLy78SBXdSW/lWB29TiGYAVtfgHR+PTieJr2Gkd5CSvTRvv/Ex
         HkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OivBWw2fC0XPAqVFrKNNGqM4Zo9U9YwXqHaW8wBeEGc=;
        b=CeshkTvRQxbgO8c7ui+y6sn/RLPjRFQ1mEuzHMRPuDNPg7VtwEZENAfTACYOn2Nu+V
         3r/Epzdju0wbCNIcOtvf/xzNQRX22oRaBWRaDHM0LVDHS2xf0ml5EhblURh06WwSl5x6
         Ou+euq0PVmuTJM/a/PdoKfp+tmMblxkjUl01XK/a1/vxMDRInjvtxMDtyZALHIMPVGkX
         SMn1lZ9EoXIbCjwt8GQ9pBh/5iatImd5GJhACVvf6Y1p6Wc5252wstHOZhwbRm9fAlKY
         GKtIcYKVQNghZ6cSEo+bVMWsAqdCgwx+SAuvQuE9fLmLhfArtCOxXvb9xk+bkc/Y6ewA
         OK2Q==
X-Gm-Message-State: AO0yUKUoWfhIWonlOPPguIDO0+oFHf0Ycuiu1LN5Ru+rOZX45lPUUGxW
        rHg283p542j5LaR6il9YKP4c6Q==
X-Google-Smtp-Source: AK7set8MsscgVAJWMQTGh/j2UuO41+bCVPbk9ziZk8IWlJC9ACXmswl6i/IsbtfHw8xfT94Z6MhdWw==
X-Received: by 2002:a5d:458a:0:b0:2c5:57d4:2c9a with SMTP id p10-20020a5d458a000000b002c557d42c9amr5803866wrq.25.1677018947305;
        Tue, 21 Feb 2023 14:35:47 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:1a14:8be6:b3a9:a95e])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d434d000000b002c55ec7f661sm4501254wrr.5.2023.02.21.14.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 14:35:47 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com
Cc:     piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v10 4/8] x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
Date:   Tue, 21 Feb 2023 22:33:48 +0000
Message-Id: <20230221223352.2288528-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221223352.2288528-1-usama.arif@bytedance.com>
References: <20230221223352.2288528-1-usama.arif@bytedance.com>
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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
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

