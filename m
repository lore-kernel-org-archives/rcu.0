Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2E2C64EC4
	for <rcu@archiver.kernel.org>; Wed,  8 Mar 2023 17:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCHRPD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCHROb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 8 Mar 2023 12:14:31 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB152901
        for <rcu@vger.kernel.org>; Wed,  8 Mar 2023 09:13:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso1589050wms.5
        for <rcu@vger.kernel.org>; Wed, 08 Mar 2023 09:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678295618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W52wEjM0mHEImMyCikVowjMrBLWr/NXovNQ5aX5mqUY=;
        b=kcOdNyCeTFR2SbHYsRYV428AbwFrF0OCVjxB6V8zAK9Ejm0LoOL2KIm9wsWBZg6VBw
         BG2Ha4rB9baS+gRUevyQ7Jg6mvM7Kz2RoQ5rDvygxcOoRxsLmfGHzS7hodAK60oQ8zxz
         3E/okykjk9vXDSQN1pjc9fJq9KM3W5rVy/s2xA2suhX2fVQyJq1draiy5GPLNb2KwiN8
         q/QCErigfIrROqXnlUUJCm74QfZwAM4HtSaAiiPmDqkFJOg2Ouyrnb9SNoO/IUkRNLD6
         bmONMc8HquzU/jjDlFa2gDuZPIGunb7Hf7jRAZju3L6og1pgyvwzoALMOdPX2kcDTRiG
         N49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W52wEjM0mHEImMyCikVowjMrBLWr/NXovNQ5aX5mqUY=;
        b=Sf9ZvMXTd6YSCbyoeebvIKCkD7Bd2cMByHkIHWtidfEI9E5oK306Z23sVccQNSirm9
         tlGU8u223SF2foEABB8eWrn3GzEG3VOnEtFn0KDzXY6fVk1hgmLY6AICBE5/VF5bOvih
         2zel9haZ8YykWDcLpmxRZThjJfYl2PiJqpXB3EBv77rghlq6Gk0yGfo3V/OqrApYRjdI
         l74wqDYTjEx2sBDX8+nNK/C8avSyGJLOf3SnbnqydhwGGZGGpUUF5kRxALAczdtKlwb3
         x3QfmoGHx+Zh9Yq1Lzu/DtNoBOQtFw0r6C5wVwUXNgrLD5u+rjVN1fEg8DOW6qeT/qSo
         S+ew==
X-Gm-Message-State: AO0yUKWS/keBEIjlerJwj0vAMZigUe/RHCfhzEyWLZC6AtFIHH/3le8N
        G/xiImJvv3eaJkktaCxD1pm2yw==
X-Google-Smtp-Source: AK7set8512C94Ko/KANEw3v6bQJuElQY45ZXYcbwBgiewNgfiEiMjEDPW/7bn+A/NdP+KQuyyWM66w==
X-Received: by 2002:a05:600c:4f0c:b0:3e2:1368:e3a0 with SMTP id l12-20020a05600c4f0c00b003e21368e3a0mr17001018wmq.18.1678295618710;
        Wed, 08 Mar 2023 09:13:38 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:fe40:3ba4:afe4:4609])
        by smtp.gmail.com with ESMTPSA id l15-20020a1c790f000000b003e0238d9101sm11668wme.31.2023.03.08.09.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:13:38 -0800 (PST)
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
Subject: [PATCH v14 08/12] x86/smpboot: Remove initial_gs
Date:   Wed,  8 Mar 2023 17:13:24 +0000
Message-Id: <20230308171328.1562857-9-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308171328.1562857-1-usama.arif@bytedance.com>
References: <20230308171328.1562857-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Brian Gerst <brgerst@gmail.com>

Given its CPU#, each CPU can find its own per-cpu offset, and directly set
GSBASE accordingly. The global variable can be eliminated.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/x86/include/asm/realmode.h |  1 -
 arch/x86/kernel/acpi/sleep.c    |  1 -
 arch/x86/kernel/head_64.S       | 22 ++++++++--------------
 arch/x86/kernel/smpboot.c       |  2 --
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index a336feef0af1..f6a1737c77be 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -59,7 +59,6 @@ extern struct real_mode_header *real_mode_header;
 extern unsigned char real_mode_blob_end[];
 
 extern unsigned long initial_code;
-extern unsigned long initial_gs;
 extern unsigned long initial_stack;
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern unsigned long initial_vc_handler;
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index de89bb4719d0..1328c221af30 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -127,7 +127,6 @@ int x86_acpi_suspend_lowlevel(void)
 	 * value is in the actual %rsp register.
 	 */
 	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
-	initial_gs = per_cpu_offset(smp_processor_id());
 	smpboot_control = smp_processor_id();
 #endif
 	initial_code = (unsigned long)wakeup_long64;
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index a5b46c2fba05..6a8238702eab 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -66,18 +66,10 @@ SYM_CODE_START_NOALIGN(startup_64)
 
 	leaq	_text(%rip), %rdi
 
-	/*
-	 * initial_gs points to initial fixed_percpu_data struct with storage for
-	 * the stack protector canary. Global pointer fixups are needed at this
-	 * stage, so apply them as is done in fixup_pointer(), and initialize %gs
-	 * such that the canary can be accessed at %gs:40 for subsequent C calls.
-	 */
+	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
-	movq	initial_gs(%rip), %rax
-	movq	$_text, %rdx
-	subq	%rdx, %rax
-	addq	%rdi, %rax
-	movq	%rax, %rdx
+	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+	movl	%edx, %eax
 	shrq	$32,  %rdx
 	wrmsr
 
@@ -294,8 +286,11 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movl	initial_gs(%rip),%eax
-	movl	initial_gs+4(%rip),%edx
+#ifndef CONFIG_SMP
+	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+#endif
+	movl	%edx, %eax
+	shrq	$32, %rdx
 	wrmsr
 
 	/* Setup and Load IDT */
@@ -437,7 +432,6 @@ SYM_CODE_END(vc_boot_ghcb)
 	__REFDATA
 	.balign	8
 SYM_DATA(initial_code,	.quad x86_64_start_kernel)
-SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a22460a07cf8..b04520085582 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1084,8 +1084,6 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 #ifdef CONFIG_X86_32
 	/* Stack for startup_32 can be just as for start_secondary onwards */
 	per_cpu(pcpu_hot.top_of_stack, cpu) = task_top_of_stack(idle);
-#else
-	initial_gs = per_cpu_offset(cpu);
 #endif
 	return 0;
 }
-- 
2.25.1

