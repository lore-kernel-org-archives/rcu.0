Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF864C678D5
	for <rcu@archiver.kernel.org>; Wed,  8 Mar 2023 17:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCHRN4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCHRNw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 8 Mar 2023 12:13:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1632FCE2
        for <rcu@vger.kernel.org>; Wed,  8 Mar 2023 09:13:36 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p26so10237353wmc.4
        for <rcu@vger.kernel.org>; Wed, 08 Mar 2023 09:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678295615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbZumu4dMY0Za38bxLjojwYOtrQ4rJ/sJrcRrt0N9M0=;
        b=O64WP2DRtVFcNc4IQE0SwpXBtLtDxnt2+hKQ7Ic3oyB6nA4LZQ4crGlcXofcwUiWaX
         oz2LblDsppUMDbOFUlMtjvynmJviJpQyvD7PX8ra1yToflb8ieDBL7flFaIEwZiSAKhf
         FN0/Fz8zg/Zl1GWMuza8Yo4jNJVD++IqzvobyGknpPhqCwM6bc3KqG6T/KHIYxFzBxvm
         7s6QWunEvCBTqgfULHZFKinWpZKLL0jp6FGU5qQZSjVJJBvvZEWAZhOU875+707E57hs
         +NPwtRHnFND2g4FnPZU2Sru5GgwTAE1NTDFenEeug9hTct6s/nKwltCA0v9gL+BvhOW8
         /mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbZumu4dMY0Za38bxLjojwYOtrQ4rJ/sJrcRrt0N9M0=;
        b=pq05IOosnt018XyW/XOpzQX8JE8nsoU/grRiT6FAxAbNTXttD33ifE4Hj2k6RkBozt
         gU99NlxukmBM1PFm7Tbiee7T/roL8vux/PFQSMvXhrVY3L6UENtTVXSDrDBOu+c8+E1z
         br3mHd/zId0z/5YlZgg5RDPrK0D4O1+3a0h4SNu76bvOcGX9rfsLplEKdtIT/vzh0vBq
         BQKtDoniWmX0zk28TmeMKMzrDmKvtYvrj8eGqebndpOLIJR5MBltPP0U4gNJ7KhKFrtI
         CGgNkPReOjzX2ZVt/NoN5ZGyBnyJ1gHkTKv+Afn5AbvPWHRiwGHnoVkFW/WVtshn71++
         0PSw==
X-Gm-Message-State: AO0yUKV/ChdKnn61+5jLSoFt8W0kfJ/ATYfar6uWOQsJRb99DLqeCUZC
        tKMPrjPYrxxihBny4cx9QnfCsg==
X-Google-Smtp-Source: AK7set/1jG/zuv0jJmUwg9/c+dC9eieTmxeSVBHf4tMyIk53SPyqs98hMN8AbWU7YvPLENvBfVCI/A==
X-Received: by 2002:a05:600c:4e92:b0:3e2:5c3:bcfc with SMTP id f18-20020a05600c4e9200b003e205c3bcfcmr17503117wmq.18.1678295614936;
        Wed, 08 Mar 2023 09:13:34 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:fe40:3ba4:afe4:4609])
        by smtp.gmail.com with ESMTPSA id l15-20020a1c790f000000b003e0238d9101sm11668wme.31.2023.03.08.09.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:13:34 -0800 (PST)
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
Subject: [PATCH v14 04/12] x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
Date:   Wed,  8 Mar 2023 17:13:20 +0000
Message-Id: <20230308171328.1562857-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308171328.1562857-1-usama.arif@bytedance.com>
References: <20230308171328.1562857-1-usama.arif@bytedance.com>
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

