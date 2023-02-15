Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFCBC636CC
	for <rcu@archiver.kernel.org>; Wed, 15 Feb 2023 14:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjBOOyn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBOOyl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Feb 2023 09:54:41 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97E339CE7
        for <rcu@vger.kernel.org>; Wed, 15 Feb 2023 06:54:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y1so19446429wru.2
        for <rcu@vger.kernel.org>; Wed, 15 Feb 2023 06:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+woZryxcmbb99mupmnna5okozeg16DDHF5Mj8G3upM=;
        b=JRokBhNiWe7Y/h+u2FZ5CkBubYME683ey0UWpdaSILNGaAsASJ37C/R5IanD/HbmRR
         +hzGlun4CtH+CBtRYw4rDmLhVCRRZmmEU189H4VM6PaX095JhUN+KU8JTcWsajctBZhp
         /kqS/YbNGo4EpKnZkXYuuwRmOJh/H7jVem17DGVyRH5SJ3ZrTi3f8ZesZE8DtaaEnD2C
         e9r/uSW7LW6FskT3FkHiDoDPBX9EWmhTlmBnU0jc8S0bBuGMoPoCxzA2Bb1jUnMbQ/ri
         IpDtTVMkB62W/cjYHnMZnxFqyiadZS+iGFxlbd2g01Esy0uuZRkaVEV8uNsx5JhmYbHX
         bXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+woZryxcmbb99mupmnna5okozeg16DDHF5Mj8G3upM=;
        b=3HFcFGUHz+9MV3Dchzu6EunpVoEIczV8KGRTUsvgB4q8Ksl/OR+fquP+RLqRaRTJa9
         AGixI49gq/gwkiYEHuKef90sPPkrBVHEsmLJp/0MNIUeW3+oNecO2VtPdb8o4fVjoz2d
         GEaPlcwf4dykVoiOsmz4YQ3qsuJI7/czgX/25kfMvtwDWThb7FejCrLl3K34epE4S6iu
         oVAxXRQMzk1Rg7I0/71nM9UDjK44kcbjg/7k1cYCFu1ZdaS4r4ndvpOefrDKjqT1L7jr
         jxtVDdIe6Bkqe7zYW5X217bmtK1mTVVHmE5K8ZJOJe0/wjd4USASvUw9OAjUN7DpszXs
         JtoA==
X-Gm-Message-State: AO0yUKWrx5UDM4xtF5GYoaJ4mGbC0TnqLLYze9s3m5Jfq4lGr0WCuY6X
        KvPPqA6qSeTC2o7DZgIqAttfNg==
X-Google-Smtp-Source: AK7set9BrBnpCstfUCDx0aGuY3lcnvjud1haFt2Wp+nw387jfta4pX5lyCMoer1YCoUD3YYnbZHy9w==
X-Received: by 2002:a5d:4d87:0:b0:2c5:585e:334f with SMTP id b7-20020a5d4d87000000b002c5585e334fmr1780837wru.41.1676472872371;
        Wed, 15 Feb 2023 06:54:32 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:8487:6a9a:3a67:11aa])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe44d000000b002c557f82e27sm8495508wrm.99.2023.02.15.06.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:54:32 -0800 (PST)
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
Subject: [PATCH v9 4/8] x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
Date:   Wed, 15 Feb 2023 14:54:21 +0000
Message-Id: <20230215145425.420125-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215145425.420125-1-usama.arif@bytedance.com>
References: <20230215145425.420125-1-usama.arif@bytedance.com>
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

