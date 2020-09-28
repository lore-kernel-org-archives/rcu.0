Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98433C4727F
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651102076A
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601335892;
	bh=/M6aOJivvPIdAQhbwu27MlHHlosSgfXplSqgr0JOZCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IOmE5fYru6WGWFxzyx+4mBZCHRvCBgBEyBrdqnfIWwlhqPCBHs/ReM84C7KvKHGfr
	 YqYMPD5Fqsji0cTb27bIMl4Gr2HTRn34Tr8abRBp1t0zyLQWtHXXI7HO2VCIt5oT0x
	 0NVfxaXTMrjWF6Qm4062J1i7kfwyQ0n7zK2fdnpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgI1XbY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbgI1XbH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41F7F221F0;
        Mon, 28 Sep 2020 23:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335866;
        bh=/M6aOJivvPIdAQhbwu27MlHHlosSgfXplSqgr0JOZCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bia3xpdNCo94eUc8NlGuMBeeV2GiqCLFKuiUuYKGa50jWn44ILMEILwtQvMu4FIdk
         ex/W9oaFbAcDTc2H/edHbjh3/t+ybv8/OY58zcvClaI+ARyhfYVhdkXQozL6hOxImv
         wQgaSMz1AUo1X/TR5uSUXKVRigX18feWbMQioz4c=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/15] ARM: Cleanup PREEMPT_COUNT leftovers
Date:   Mon, 28 Sep 2020 16:30:56 -0700
Message-Id: <20200928233102.24265-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200928233041.GA23230@paulmck-ThinkPad-P72>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/arm/include/asm/assembler.h   | 11 -----------
 arch/arm/kernel/iwmmxt.S           |  2 --
 arch/arm/mach-ep93xx/crunch-bits.S |  2 --
 3 files changed, 15 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index feac2c8..fce52eed 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -212,7 +212,6 @@
 /*
  * Increment/decrement the preempt count.
  */
-#ifdef CONFIG_PREEMPT_COUNT
 	.macro	inc_preempt_count, ti, tmp
 	ldr	\tmp, [\ti, #TI_PREEMPT]	@ get preempt count
 	add	\tmp, \tmp, #1			@ increment it
@@ -229,16 +228,6 @@
 	get_thread_info \ti
 	dec_preempt_count \ti, \tmp
 	.endm
-#else
-	.macro	inc_preempt_count, ti, tmp
-	.endm
-
-	.macro	dec_preempt_count, ti, tmp
-	.endm
-
-	.macro	dec_preempt_count_ti, ti, tmp
-	.endm
-#endif
 
 #define USERL(l, x...)				\
 9999:	x;					\
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index 0dcae78..1f845be 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -94,9 +94,7 @@ ENTRY(iwmmxt_task_enable)
 	mov	r2, r2				@ cpwait
 	bl	concan_save
 
-#ifdef CONFIG_PREEMPT_COUNT
 	get_thread_info r10
-#endif
 4:	dec_preempt_count r10, r3
 	ret	r9				@ normal exit from exception
 
diff --git a/arch/arm/mach-ep93xx/crunch-bits.S b/arch/arm/mach-ep93xx/crunch-bits.S
index fb2dbf7..0aabcf4 100644
--- a/arch/arm/mach-ep93xx/crunch-bits.S
+++ b/arch/arm/mach-ep93xx/crunch-bits.S
@@ -191,9 +191,7 @@ crunch_load:
 	cfldr64		mvdx15, [r0, #CRUNCH_MVDX15]
 
 1:
-#ifdef CONFIG_PREEMPT_COUNT
 	get_thread_info r10
-#endif
 2:	dec_preempt_count r10, r3
 	ret	lr
 
-- 
2.9.5

