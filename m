Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F623C61DA4
	for <rcu@archiver.kernel.org>; Thu, 23 Feb 2023 19:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBWTMz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjBWTMv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Feb 2023 14:12:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0065C17F
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 11:12:26 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r7so11399962wrz.6
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 11:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ydn+N8Ta2/l5mmEEZ9zQwSQU4fOYRVeCJFh5IKZvP2o=;
        b=XMP+3c7uJ0e3rUuqE3xP3n2bcdkHaye4xq0doQzwnAtiZpHBt0EhXEMjBGyfdkJC8L
         XdmwsDBHG5CJlyC7g/3t/QfN3zXpeVAwxeCVNr5p+a6HiWka/VvuOsIibLUKaMN3eYz7
         A+Z5tUhdCDd9x2Tetmn6oO8DU3AUjzxV5kNC4yA1qaEmjknk3zJoKfv6pCtCJ6dG25Y1
         LzKe2S/ieY3a+EZQCkkI2msPad7Kphbtlfo/Aum/h/WBHYqyeLQR4CUZRxjypWZcVWwl
         fCaY119EFubhBbWFfX3bJEW3UWJotvmlglZvJHStOoUXGebQaJZWF7P0X7ZOnIZvFLJT
         0DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ydn+N8Ta2/l5mmEEZ9zQwSQU4fOYRVeCJFh5IKZvP2o=;
        b=rC4SNt4kho9dAzrs9GGrS/v93NrO5Y1IkGEXDr7TL4sCWVBZnBj+ngQGjgQO+k+HKI
         GbBoTevA5kzUmhiFJvsR8or0fyFsUOmHbPHrUnCT8AdO4YxZVVdmy164P0DiJE4HeutO
         lIoVepTUhHbcUrszxm/wzBgDQY/B3q70LWlQRtJcL7+itxDE44Vi8IDQDKtysA5Qm+0M
         EDHJnnN8xxcxpjg1mwRYPhLzJwL7af2SownFz8BGrn+omjsj7ugRf5mdV+4qWpcweZr+
         9o6siK0zOwtBE7setkhOdkx71O0TyVce3JTmJ/7VbumQ7W/NlDlZyQ24p4TIY9LMLlWg
         L0eA==
X-Gm-Message-State: AO0yUKXDcJuwrC39BpJvrU784mxSplCZ3MV5epcZq3f30L1o0P8GakE2
        pdVbcfXLUXVWKSla+d24zrpOOA==
X-Google-Smtp-Source: AK7set+RzpW2Z067J+esL8OAcAyTvdMn1W6zmBe1bpVMCdOkL8SWAErbcP2lhujxblJRKjS5mOkVBQ==
X-Received: by 2002:a05:6000:1007:b0:2c3:da8a:192 with SMTP id a7-20020a056000100700b002c3da8a0192mr10542698wrx.15.1677179512258;
        Thu, 23 Feb 2023 11:11:52 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:5ee0:5af0:64bd:6198])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b002c561805a4csm12957286wrt.45.2023.02.23.11.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:11:51 -0800 (PST)
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
Subject: [PATCH v11 10/12] x86/smpboot: Remove early_gdt_descr on 64-bit
Date:   Thu, 23 Feb 2023 19:11:38 +0000
Message-Id: <20230223191140.4155012-11-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230223191140.4155012-1-usama.arif@bytedance.com>
References: <20230223191140.4155012-1-usama.arif@bytedance.com>
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
---
 arch/x86/kernel/acpi/sleep.c |  2 --
 arch/x86/kernel/head_64.S    | 19 +++++++------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 008fda8b1982..6538ddb55f28 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -114,8 +114,6 @@ int x86_acpi_suspend_lowlevel(void)
 #else /* CONFIG_64BIT */
 #ifdef CONFIG_SMP
 	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
-	early_gdt_descr.address =
-			(unsigned long)get_cpu_gdt_rw(smp_processor_id());
 	initial_gs = per_cpu_offset(smp_processor_id());
 	/* Force the startup into boot mode */
 	saved_smpboot_ctrl = xchg(&smpboot_control, 0);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index f7905ba4b992..0dd57d573a0e 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -245,7 +245,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 #ifdef CONFIG_SMP
 	/*
 	 * Is this the boot CPU coming up? If so everything is available
-	 * in initial_gs and early_gdt_descr.
+	 * in initial_gs.
 	 */
 	movl	smpboot_control(%rip), %edx
 	testl	$STARTUP_SECONDARY, %edx
@@ -313,11 +313,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/* Save it for GS BASE setup */
 	movq	%rbx, initial_gs(%rip)
 
-	/* Calculate the GDT address */
-	movq	$gdt_page, %rcx
-	addq	%rbx, %rcx
-	movq	%rcx, early_gdt_descr_base(%rip)
-
 	movq	%rbx, %rdx
 #else
 	xorl	%edx, %edx
@@ -339,7 +334,12 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
@@ -754,11 +754,6 @@ SYM_DATA_END(level1_fixmap_pgt)
 
 	.data
 	.align 16
-
-SYM_DATA(early_gdt_descr,		.word GDT_ENTRIES*8-1)
-SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
-
-	.align 16
 SYM_DATA(smpboot_control,		.long 0)
 
 	.align 16
-- 
2.25.1

