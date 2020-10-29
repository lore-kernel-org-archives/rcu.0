Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D69C55179
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F26120FC3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIvphrFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgJ2Quv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgJ2Qut (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D66DC0613D7;
        Thu, 29 Oct 2020 09:50:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d25so3813420ljc.11;
        Thu, 29 Oct 2020 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXgzbe5U4XFLjsPCkUNXib2Ktv+heUH4fugO2/UuzAo=;
        b=eIvphrFb6Q5RrUDDTUMSr/ZMno55i9Sfn6olZ6eliCMHBduQPnRptiLXYdthVxFvpy
         40beSO4pwApyCVPB67+ZLXrtP+oKd9oSCWMwLlyaVoBF8DgHOUi/iGn0KwKNULCU3JZs
         ibpE30pqivMWX++pWEmP6KCu/MnfbpIqlsl6dCoiMw7nNysmGBSaUo3OfpiC0lHCpCwj
         u6X7+x46SycUEbttqtwdKRjgiRCTsQFF0AtfOW0IiEWPVndIJZoSXQg6NwcnPXSjTb5O
         ofQGURp3/KMyOs38KtkMg14y6oQ/DrWOsOm4qtk9eh/vtZffhJTzVPzSxp7kH1NBQW1R
         5QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXgzbe5U4XFLjsPCkUNXib2Ktv+heUH4fugO2/UuzAo=;
        b=i2WguML6x7TdoJZlIiilHQDkLoPwEpNGK3Ub34/nAZ4Tw/ESz/nRkzsBen5AyijbcT
         F9fKuBZw/JracYGYfiXiohezwBiz3cbc+rP3+vk0MCsfPGLqItWJpb0tx61oplL6gCwV
         mDBzG3tXLpFl0VIEvJvHSgpGW6OHL4gfA7GHwgH5Y+sZnJyzZrbtj04K26AQtrDLof2I
         pRgh57XJQ/zenJeKKppvp1X4Rb1LRmZ3gtPmE6bjCUHIwm+z5bN8uPEmz6/90wYcFGTm
         eiV58ZKvNBg2NBmaQMdT4oDAfA2oFSDfKHM2i4/hdjWMVNlghhH/P1K7ad2UC3Y96qQ/
         IrGA==
X-Gm-Message-State: AOAM533kix6HpDIcB/W00Gkn0tA5UXOAnjz//EqIWkw0JqHDsrDQDQIr
        nU0ZaZZ3wbQnLDQOtdxA5oVzIjkHxNOq4A==
X-Google-Smtp-Source: ABdhPJz/xfeA78PUVoSA71gyzWBpq4L4DajkrXaeh+qAnK7jcOb73wLBU+fe54cuz73BS52PPDMjjw==
X-Received: by 2002:a2e:80d7:: with SMTP id r23mr2361375ljg.390.1603990247550;
        Thu, 29 Oct 2020 09:50:47 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:46 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/16] ARM: Cleanup PREEMPT_COUNT leftovers
Date:   Thu, 29 Oct 2020 17:50:13 +0100
Message-Id: <20201029165019.14218-10-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 arch/arm/include/asm/assembler.h   | 11 -----------
 arch/arm/kernel/iwmmxt.S           |  2 --
 arch/arm/mach-ep93xx/crunch-bits.S |  2 --
 3 files changed, 15 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index feac2c8b86f2..fce52eedc6e1 100644
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
index 0dcae787b004..1f845be78c43 100644
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
index fb2dbf76f09e..0aabcf4ebe8e 100644
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
2.20.1

