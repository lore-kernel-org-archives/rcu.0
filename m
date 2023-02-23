Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ACEC64ED8
	for <rcu@archiver.kernel.org>; Thu, 23 Feb 2023 19:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjBWTNJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjBWTNC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Feb 2023 14:13:02 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4531E5C15B
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 11:12:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l25so11159023wrb.3
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 11:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OivBWw2fC0XPAqVFrKNNGqM4Zo9U9YwXqHaW8wBeEGc=;
        b=ZDG3NgABSuo3eKqXu8k0fCIFzS7x293O1xHnTdlbWTZzDzRsDo5w2fxICTyGIU9SZd
         La3hgbWjwAUViIFtj5nzdi9l286i+1BiiR8wgacSaNXsw/d9B2uf546kgw7pRzUOoU/O
         I9KjbX2NEBuvYhL7QbfZxgmJ52GtQy63SHB8mJdwQjIqrjEBSKFYLsgRjjr31IhELq8K
         +jVoVRVpaHAthXJtNr1V4FcLmQ+AKDPpCH7mcBHVUDKSMDSt9OamVRZ3xwxtubEoCSf2
         oIPFuxYBjE/iDAjsJ2hW8lj2oGMrSUTAZif/uT3Llh8ahCoiI45510hGVXSicsDBQ/he
         p4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OivBWw2fC0XPAqVFrKNNGqM4Zo9U9YwXqHaW8wBeEGc=;
        b=vpHITvAiMYQycNmGuLviiOmXQiOmGz8p1mx+Dtdp54C9K3Gqzl9TaE5MGRl4tcAN30
         K3vghvGpfJFcFvN9jFMxKMyHw5M86udzKMBpImj5KJrpm5Gm0Opa+lgy6xDl2nTT+kBl
         uBI8cdu4pXpFIzj5ZAt/R0cQAZ2qs5L2CjgZ/PhD6usIAtiDEzvwGwRv1cblIFHzKk71
         lBnPjEjUVJCS+bi0gxTnm1dQyODnar1oSpg43uCnJOghUOItuE3lplLbqn1CFSW1tkRZ
         ekef2XfcgDn0d3SyfDYcB6xP14+n7uaplocoqGRXe2ERuUCanWeAZDJYoVZhpM3WikpS
         lUKw==
X-Gm-Message-State: AO0yUKUbZfi5+BBxCsws9wMPeeQZ6S4hDuHdqqNlHmm5rZ3TxIAaLeaz
        n75kmTY5HKVaQnJZdJNSfXN5nQ==
X-Google-Smtp-Source: AK7set/NLgn5F6/GhEh/DEIwsyZth9V2XRLVxbC7O+VwR1a40tCKWH8Koc0WD22GsiFjFCrm49T0DQ==
X-Received: by 2002:adf:dd86:0:b0:2c7:e60:a41d with SMTP id x6-20020adfdd86000000b002c70e60a41dmr4335140wrl.61.1677179506858;
        Thu, 23 Feb 2023 11:11:46 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:5ee0:5af0:64bd:6198])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b002c561805a4csm12957286wrt.45.2023.02.23.11.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:11:46 -0800 (PST)
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
Subject: [PATCH v11 04/12] x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
Date:   Thu, 23 Feb 2023 19:11:32 +0000
Message-Id: <20230223191140.4155012-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230223191140.4155012-1-usama.arif@bytedance.com>
References: <20230223191140.4155012-1-usama.arif@bytedance.com>
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

