Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D3CC636D4
	for <rcu@archiver.kernel.org>; Wed,  1 Feb 2023 20:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjBAUqK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBAUph (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Feb 2023 15:45:37 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FCB7A4B5
        for <rcu@vger.kernel.org>; Wed,  1 Feb 2023 12:44:56 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t18so18527107wro.1
        for <rcu@vger.kernel.org>; Wed, 01 Feb 2023 12:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si9kzr7Ck9J5FJkWCPsjkhUgmegMqi5GAbSuKxlmi/Y=;
        b=sXMxj/CKJBGFdLzPqQuDQiOPwKF/J04CKNI5iVbGlsHYa+yHZsQXZ/welJivcDAh78
         03XN/aIk9smRRSJBbVcD8A7xCJQW537kgAuRtyai14FS8t0ukXFaqkwlkudC99dkmvdN
         rtlhlvW0kPQwaNg8Yz96FxnRXUt/hZZ4kDgRUlcTj6wrqyrl6sv/drdH7ZlZp7N0xpgr
         7/F+R8t/koV++BDvOKRHqSKkhTRC4E1+ivjSfL+Y8IvbVH6WudoBt9K7CLfIp39iEZO0
         iRMQLwcQy13UYZ9od7HzZ4VJNpiv6qQnkv1bEA/lGY/7VjTyfJn1TzJcGWgdw61ICEHi
         8K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Si9kzr7Ck9J5FJkWCPsjkhUgmegMqi5GAbSuKxlmi/Y=;
        b=ccdB6L+GrE/gX/56uTaYqkmnY/+9l9I7ex0m9sNt1Oc9A+kEyoxUUadQ5m/eNrkOYu
         0rCZKoZ9MPsozawOM5wCSVCzBNLNjSdBgiAit3EBt9zSZS8A/xWW2ahJlALXfTZXy0Ec
         QaxuYA4FCme5u372e926CjIX/2mavTLlev3ZKjMINBD6ywoI/VqBTuwPst1Q6B2+GJ4S
         aGDerw0uRBDMqYAEd5ebmnJIey6fjjXvVq3TatN0j4I3P3hxZ3otkXoQPaFiKaomTUjb
         aqfpJmAzhWeRKx6I0W3o2dTTWfrCJg9cl5c9FS/qg187SryLKPghGMDez034f77en3qD
         dBww==
X-Gm-Message-State: AO0yUKW10And+Tt+S13QiMCczVH2BrPCC+bpN3NpO1WvsatTjoT4FBbh
        IxIcqcApjChcL8ZdhTrvJSKBLA==
X-Google-Smtp-Source: AK7set/CwFq4yq21SPwqQ75tLHpsn8i9sDNtMo1urKN3i7lFWEBvGKN2/cx1n6sFd6WcKFjNEuGwpg==
X-Received: by 2002:adf:fb8f:0:b0:2c1:28dc:1566 with SMTP id a15-20020adffb8f000000b002c128dc1566mr99026wrr.41.1675284294722;
        Wed, 01 Feb 2023 12:44:54 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:7611:c340:3d8d:d46c])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b002bdff778d87sm19993584wri.34.2023.02.01.12.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:44:54 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 8/9] x86/mtrr: Avoid repeated save of MTRRs on boot-time CPU bringup
Date:   Wed,  1 Feb 2023 20:43:37 +0000
Message-Id: <20230201204338.1337562-9-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201204338.1337562-1-usama.arif@bytedance.com>
References: <20230201204338.1337562-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

There's no need to repeatedly save the BSP's MTRRs for each AP we bring
up at boot time. And there's no need to use smp_call_function_single()
even for the one time we *do* want to do it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 2746cac9d8a9..2884017586f1 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -814,11 +814,20 @@ void mtrr_ap_init(void)
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

