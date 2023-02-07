Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F594C6379F
	for <rcu@archiver.kernel.org>; Tue,  7 Feb 2023 23:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjBGXFF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjBGXFE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Feb 2023 18:05:04 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7918140BC0
        for <rcu@vger.kernel.org>; Tue,  7 Feb 2023 15:04:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so192172wmb.2
        for <rcu@vger.kernel.org>; Tue, 07 Feb 2023 15:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+ne+m/jA9f2Vf5iapwS72QpCbb1ZulqNbxU7adH9sw=;
        b=2C88stP2TFJvBZHdAdu647aiDvm7KBHA7Lu0B+BBWdqyCEQeJLMGUsMHlB2FlDhDqO
         wuXthNeCkcLssbQ7FMVcsFA4v0DApgjRF+5hhhVHKkZi69knw/IavDqXyj8ACKgbiBUk
         O6SNrNzgs36ODAGNF818joieBXKsBnFNJP03FfcvWq2ml1/pXOyJyxk1OgCglFR8V+I1
         YbEBq3CONDk/z/EWZrqQ675YTlmRwH6WmgQPS8PaRbeLNQbpnEUs4BgpFstOI3LxrE6/
         DWo3OVYj4bbQBFZ4rwqKvIbgC3sfUkq1+qMnZkBmWfAtbd4L9fUTuYhiQEZ2ZdLq02yx
         pW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+ne+m/jA9f2Vf5iapwS72QpCbb1ZulqNbxU7adH9sw=;
        b=4aKPPP6b6xudCAm/qM9vX+dz7/M+yy82k1COJcFjVxOOHqSpp2KBtOg+qo6LdUpOyN
         ZAhFxP67nplCEcZxuD1HRdgWbosWdw9h/qXAgXbyFXF1R6/ZuAQtUwrsuHzMWSkU0s0f
         T6OB7V+XzAyWHe0L8G9swX0RJ9lqtZ51RdStVqHDCVDccg4X36N9zP8I5EigbYuefn/M
         Uo/PZO3pC6Ym12I186TuFpIY8Ud+1q7NiWs1lMGPVYMMIdaHNvqAxoPZ2+5zLiYFBh2M
         5DwqkwL+Rxo+QTlUoDbWCEL2dyccTwhKBnQnq1GkxDFU7+C0iWKBqQj6rBZ+MxRXnlrj
         joqg==
X-Gm-Message-State: AO0yUKXSCP2frHuwP818XmvuOfiG0eUSaHjDB9S9zmofPlv0BHZyoOX8
        70jKYsqH+FHXI46CHuT85qsokQ==
X-Google-Smtp-Source: AK7set8R7TFeCNFMVqthzhKuOuRi/zDRcGceJ/mu872NRkxCtmm0DPIfG9hlntnmJKBJ1gRB90zVpQ==
X-Received: by 2002:a05:600c:807:b0:3dc:eaef:c1bb with SMTP id k7-20020a05600c080700b003dceaefc1bbmr4449336wmp.35.1675811088116;
        Tue, 07 Feb 2023 15:04:48 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:c04f:2463:c151:8b87])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b003dcc82ce53fsm146485wmq.38.2023.02.07.15.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:04:47 -0800 (PST)
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
Subject: [PATCH v7 8/9] x86/mtrr: Avoid repeated save of MTRRs on boot-time CPU bringup
Date:   Tue,  7 Feb 2023 23:04:35 +0000
Message-Id: <20230207230436.2690891-9-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207230436.2690891-1-usama.arif@bytedance.com>
References: <20230207230436.2690891-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

There's no need to repeatedly save the BSP's MTRRs for each AP being
brought up at boot time. And no need to use smp_call_function_single()
even for the one time they do need to be saved.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 783f3210d582..b6eae3ad4414 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -721,11 +721,20 @@ void __init mtrr_bp_init(void)
  */
 void mtrr_save_state(void)
 {
+	static bool mtrr_saved;
 	int first_cpu;
 
 	if (!mtrr_enabled())
 		return;
 
+	if (system_state < SYSTEM_RUNNING) {
+		if (!mtrr_saved) {
+			mtrr_save_fixed_ranges(NULL);
+			mtrr_saved = true;
+		}
+		return;
+	}
+
 	first_cpu = cpumask_first(cpu_online_mask);
 	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
 }
-- 
2.25.1

