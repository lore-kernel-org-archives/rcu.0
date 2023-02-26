Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3E4C7EE2D
	for <rcu@archiver.kernel.org>; Sun, 26 Feb 2023 11:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBZLIO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 26 Feb 2023 06:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBZLIN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 26 Feb 2023 06:08:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882A5E3A3
        for <rcu@vger.kernel.org>; Sun, 26 Feb 2023 03:08:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r18so3455549wrx.1
        for <rcu@vger.kernel.org>; Sun, 26 Feb 2023 03:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OivBWw2fC0XPAqVFrKNNGqM4Zo9U9YwXqHaW8wBeEGc=;
        b=VxCrwOsO5d51D+qxGU56U12/Bi1oSWb2V8N/WSXUn/RfWrQ6Ei6ewkTrmwmzWXtlEf
         5PWKmXL//w+gNJ2lBwzUfLYDtc4Nljo6tLaTFo0UimNjQT0Agj4KY1YVu0iHm4b7uqM7
         q2aS+BoZEGmMeqk7lq/8cDQvl6gJe3R/50HoLK9X79Ap54V0GqPfCvrJRVPrsg5N3e3v
         GzPn5YVhsu7Ox6p1K3jcqvLMPshqVmLucNu8EWcjGlK5lnyETbXiQtf0dp3EygPOIsRk
         YrwYlukZIIGQTeKCOhY9l0lf5gm5uvndbv58YwfVyOdobjwp/nkuyUZMli2uW6KQU1Nx
         uh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OivBWw2fC0XPAqVFrKNNGqM4Zo9U9YwXqHaW8wBeEGc=;
        b=UTfFMH/4rD6ywjXxkD2Y7UlYU0nsB5EC7IaIB6nKXxD0eKChPL6QOdcMYo/dM93bZw
         SaVT4t9H6bcgRiOumjiO1pUtnqamgjZXxP14wBEXNaNy3KK7cA06xU5M93nmhweLjLld
         fA7rjunMah5+KSUj/Jru2mtmQyQpuBklZe0Q5IX+MbPPq3LzEoMaJvtN97thyRcGlWur
         eEu9fCZMqNg6IXPpG3GbxEgii761BjEu1+HcpGDqPmMahyCH7an9vTkp1HhhY/uCH0z+
         MGQ4Ral39BUOIcvxHVEECys5rvVz08cmFlGMQE4/a6dMpHlShA1sCJg+EFlxWgiZWyY2
         TDCA==
X-Gm-Message-State: AO0yUKWiZHahMbLcu8nvxh0hX/aszDt9YbsIVXC/wkrT5/PSKAyR3KsN
        Dzsyn9quFaxe7EH/sviL0B+Ebw==
X-Google-Smtp-Source: AK7set+FTyurnhSGpCNcSuxWbPpEYuaf59S7DEc2Wp/E7rxmeIf77xGqg7zaTwWoSGONF3klerWcLQ==
X-Received: by 2002:a5d:45c6:0:b0:2c7:aed:b981 with SMTP id b6-20020a5d45c6000000b002c70aedb981mr12298110wrs.30.1677409688797;
        Sun, 26 Feb 2023 03:08:08 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:df7b:4668:3e23:d0c9])
        by smtp.gmail.com with ESMTPSA id v22-20020a1cf716000000b003e1fee8baacsm9157318wmh.25.2023.02.26.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 03:08:08 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com,
        brgerst@gmail.com
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
Subject: [PATCH v12 04/11] x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
Date:   Sun, 26 Feb 2023 11:07:55 +0000
Message-Id: <20230226110802.103134-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230226110802.103134-1-usama.arif@bytedance.com>
References: <20230226110802.103134-1-usama.arif@bytedance.com>
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

