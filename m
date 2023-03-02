Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF060C678D4
	for <rcu@archiver.kernel.org>; Thu,  2 Mar 2023 11:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjCBLNb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Mar 2023 06:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCBLND (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Mar 2023 06:13:03 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EBD47411
        for <rcu@vger.kernel.org>; Thu,  2 Mar 2023 03:12:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h11so4395995wrm.5
        for <rcu@vger.kernel.org>; Thu, 02 Mar 2023 03:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbZumu4dMY0Za38bxLjojwYOtrQ4rJ/sJrcRrt0N9M0=;
        b=R//11aKpZxnJ84W5/jenLPaya5L5StTTSawCO+Bk212Vh0tzmmd1+lfRpTKu5+Oi2/
         0rumVOeOGSHNkPUdqqOUH1xBQm76RTYcUXJJVzEVhJVx916BpgR5hfHTmP1ZA+8XvVO5
         +LSUV3OcKuiODkbZ2oYfKXThWspnmHR4j27clCJWcdthy154eGZwGkrHyQcPnTKLL/ZM
         HMnaDPzv/OkRJnaelUOiUyt3OLurJ4jIfnVUaBGSCwhqGQ2G36yI6+o+O2Glda0lHhGE
         vCTndLLfjb8sO5VYWDbARKmF82Iq3o3hgpjcZKWch0mvh6q+9Nd09pZ6JtLWzXbenUi6
         GlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbZumu4dMY0Za38bxLjojwYOtrQ4rJ/sJrcRrt0N9M0=;
        b=XOpP8eRI1r5BRVRA6EyBXnEccucDJvZX9r+GIWBXpUawFZukGLf5TVTZ8PploJ4P75
         mtlPOZUt+AyAvtMrPr5aRqpz1q6Bdv2Hy657mIsDeTO4cRYMEa2apNbkC+9PY18n7A9t
         kETImGDU5bIYm75yFLfFfAan6zXggsyLmyvX5vaIyO+gphGl6tI7WRyVGc4zlLoiyWas
         9PERrmUI/tLeDJCdJC7Vgy45adsKjJzn2UJ2W7l5x9Bywtn6MZhwxb5DpwCvZ5glWbFH
         n+EYwj6wL/WwLcqq68u9OxKd+/yQAqGI12ufZvZ6BfVWUlsmnQwDJP7TR6+dyrHrvi+b
         LbcA==
X-Gm-Message-State: AO0yUKUkkEFEMHdi3bmuuudazfs1IlI8txgHc5rG6ZZgjEKUQKlNRO8r
        ftbyg/EhgXmy1oqz9DHhQOSDlA==
X-Google-Smtp-Source: AK7set+2dnYqy8jzWaIa/tyb50qRFr/6tCdf48L6R64Qom86QnDLs6wUt/Lb4JGMf2qsZBOc+VB/kg==
X-Received: by 2002:a05:6000:108c:b0:2c7:760:2539 with SMTP id y12-20020a056000108c00b002c707602539mr7182126wrw.50.1677755554593;
        Thu, 02 Mar 2023 03:12:34 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:11aa:3c13:d3e:eb29])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d4565000000b002c3f81c51b6sm14724830wrc.90.2023.03.02.03.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 03:12:34 -0800 (PST)
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
        Usama Arif <usama.arif@bytedance.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v13 04/11] x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
Date:   Thu,  2 Mar 2023 11:12:20 +0000
Message-Id: <20230302111227.2102545-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302111227.2102545-1-usama.arif@bytedance.com>
References: <20230302111227.2102545-1-usama.arif@bytedance.com>
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
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
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

