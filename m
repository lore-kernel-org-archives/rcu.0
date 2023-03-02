Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A35C6FA8E
	for <rcu@archiver.kernel.org>; Thu,  2 Mar 2023 11:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCBLM7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Mar 2023 06:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCBLM6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Mar 2023 06:12:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CB04742E
        for <rcu@vger.kernel.org>; Thu,  2 Mar 2023 03:12:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r18so16157185wrx.1
        for <rcu@vger.kernel.org>; Thu, 02 Mar 2023 03:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOzxufV8eJROu56F5G4QV++Rv00ag9T1YDu3ndS0Q6s=;
        b=dZmv8LhI0y3X3nVHO3NBCMEg4ItmPFiHO3zVCS5sPaxFIQ6U86GlCeW61eNPMPZGFs
         YvTOry9sW4YmYz7G+ByO4XdKkcqowHAgC/+uccbAuI+NFHX8ZXfhrj/M6yKouGGXcjFL
         mMBTDoktsBDoCHNMLvezwz4o8pChr5Cu9cQeeWO5SdQKd89DrT0SKo2qD/rscYKWXZVP
         9RarvYHvjY6EdWULIzYH9jwkaoaG/cKwmeonmxnNHgFiHS1H+yIuAtRjofOZgbILrE8N
         NJYbc5mmqIV8zguGs5yp2cEXWSfd4T6O1qRA2yvfpnR9iRTTOcdJZHRe4Di1dgz4XUHE
         TuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOzxufV8eJROu56F5G4QV++Rv00ag9T1YDu3ndS0Q6s=;
        b=MrRZHFGtw6W9AZ2ruNFVwA50iwQh844l75bXDQGU6kIxPvV1ab2QnYgQVR+15X9dif
         88nD2LRcjE4RwFYYLhrGOc+Mp8eRqLQHJ0r0W3Eby+UItWIyhZSJ3x8u0nCpvTY4qQTD
         +mN2muL8VWuJrJStpQoTkKVPi4aPwOp9wz0l0xduOQ0039x4JTaO4tW+3Tn7mlvXoHfD
         afinbvCQauRjFNcsCdugs/lW8ePABEJr7JzsZli34X0oUFc7Df0HPZ99Q2VjEAOnBRrO
         jeBRP2ZMNxCgDh2tMYCIO8T1HVoaDPjacUQEg9SHqwnEwN5nfmutD2wTXt02zbLgfcjb
         IGIQ==
X-Gm-Message-State: AO0yUKWJYPSJac8syM4xmXYWV0pAxAOxLY70q2s3XnHO98vzwbpvFOiM
        OGiRIvW0mKmKzFuTsUq7L0Bxow==
X-Google-Smtp-Source: AK7set+joum9P7f2p3+hKtmXYuVMjYGJrXykJAeowuAiZxfMruPOWeS1XPfnVVZrHsVm8JOdJG5tPA==
X-Received: by 2002:a5d:4b8b:0:b0:2c5:60e6:eac with SMTP id b11-20020a5d4b8b000000b002c560e60eacmr7463082wrt.24.1677755557466;
        Thu, 02 Mar 2023 03:12:37 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:11aa:3c13:d3e:eb29])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d4565000000b002c3f81c51b6sm14724830wrc.90.2023.03.02.03.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 03:12:37 -0800 (PST)
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
Subject: [PATCH v13 07/11] x86/smpboot: Remove early_gdt_descr on 64-bit
Date:   Thu,  2 Mar 2023 11:12:23 +0000
Message-Id: <20230302111227.2102545-8-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302111227.2102545-1-usama.arif@bytedance.com>
References: <20230302111227.2102545-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Brian Gerst <brgerst@gmail.com>

Build the GDT descriptor on the stack instead.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/x86/kernel/acpi/sleep.c |  2 --
 arch/x86/kernel/head_64.S    | 11 ++++++-----
 arch/x86/kernel/smpboot.c    |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 1b4c43d0819a..de89bb4719d0 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -127,8 +127,6 @@ int x86_acpi_suspend_lowlevel(void)
 	 * value is in the actual %rsp register.
 	 */
 	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
-	early_gdt_descr.address =
-			(unsigned long)get_cpu_gdt_rw(smp_processor_id());
 	initial_gs = per_cpu_offset(smp_processor_id());
 	smpboot_control = smp_processor_id();
 #endif
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index cc1b145055ac..a5b46c2fba05 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -265,7 +265,12 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * addresses where we're currently running on. We have to do that here
 	 * because in 32bit we couldn't load a 64bit linear address.
 	 */
-	lgdt	early_gdt_descr(%rip)
+	subq	$16, %rsp
+	movw	$(GDT_SIZE-1), (%rsp)
+	leaq	gdt_page(%rdx), %rax
+	movq	%rax, 2(%rsp)
+	lgdt	(%rsp)
+	addq	$16, %rsp
 
 	/* set up data segments */
 	xorl %eax,%eax
@@ -667,10 +672,6 @@ SYM_DATA_END(level1_fixmap_pgt)
 	.data
 	.align 16
 
-SYM_DATA(early_gdt_descr,		.word GDT_ENTRIES*8-1)
-SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
-
-	.align 16
 SYM_DATA(smpboot_control,		.long 0)
 
 	.align 16
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 62e3bf37f0b8..a22460a07cf8 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1110,10 +1110,10 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		start_ip = real_mode_header->trampoline_start64;
 #endif
 	idle->thread.sp = (unsigned long)task_pt_regs(idle);
-	early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 	initial_code = (unsigned long)start_secondary;
 
 	if (IS_ENABLED(CONFIG_X86_32)) {
+		early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 		initial_stack  = idle->thread.sp;
 	} else {
 		smpboot_control = cpu;
-- 
2.25.1

