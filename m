Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5489FC4363A
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B040920FC3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvJz5+TX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgJ2Qvi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgJ2Qul (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:41 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DBEC0613D7;
        Thu, 29 Oct 2020 09:50:40 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j30so4188474lfp.4;
        Thu, 29 Oct 2020 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXgbWcwa6utwMfSYm+EGe8syji0uw+8lveLyjRVMmAY=;
        b=YvJz5+TXH9up8sxBtGDamlPqMUs3kitJR2OVQGvWMftK3WAQSGBhpwr4ostZZ+Ep9w
         Acl1F1blOq5fZzIkKr645SQix4ldwvSQKmKJhSaZenHezg0AVFFb4097Mu5K2nowlxJ1
         WuBFWYbIuEXJc16+M5DpWQL6F4L3iXNs0Z0i9gBS+ouxfgqZktZ1imH+XcaVUksNzYf7
         QrUsiX9cfJfaDjAh+eTOOALcz7zvbH0Dmvw0LweFpPwRinYiHYYY3oxfhOJiwmaLUcJa
         J67VqHL+KxJu0w5JwjsE6dcwHuPRaVGMlGansmE/H2HzYBE5V/9snYqDPTcTeVY1oRdp
         ZrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXgbWcwa6utwMfSYm+EGe8syji0uw+8lveLyjRVMmAY=;
        b=V5wEmjw7rmFUtkWnMFJGQ6NZIS/8fLjtG4QAXrO+ZOw5G9otrf6U64P1rNc8vJqVlZ
         Nk132ZSFcd1W4uEDs4CMVjjkGSUH2FWpo25WML+KboYDd/QiKm9rWtOu1/EiLpcrCwTV
         ghpurnx3DgCKBpxVwdMgM8cN2OlpwKYjuv9VA+qiKbB0AueW5zR2s/657e9vflMp2HbX
         aosq0Un9fSGV2+C7L3CfUOxkKLBe9WuC8UlSy3pVRJAl5Nx9l/s1+2dwYHyRuSiLO6Y6
         Nf3P/bGnSYLUkgzBYU7cna+X/QlFBlSSROHD6jXiC2I7u4H8hMn5YvcYmYi2PojxoVhL
         lH0A==
X-Gm-Message-State: AOAM532/+j0Uuw51tSnvooPZIpfTKupQdsi54Wv4fMvK9vhhQobE7igz
        tc5J7mpIL+6/zb2J/fUwR6eUBwGATcmV8w==
X-Google-Smtp-Source: ABdhPJwxcl7TqQvpSoAKmo9nKx9OzjAt1dh35PKWNaEY1BF9cS0NkgY8n3BtQhvRWBii6lupm58dOw==
X-Received: by 2002:ac2:4903:: with SMTP id n3mr1844855lfi.490.1603990238983;
        Thu, 29 Oct 2020 09:50:38 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:38 -0700 (PDT)
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
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 05/16] lockdep: Cleanup PREEMPT_COUNT leftovers
Date:   Thu, 29 Oct 2020 17:50:08 +0100
Message-Id: <20201029165019.14218-5-urezki@gmail.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
[ Rezki: Adopted for 5.10.0-rc1 kernel. ]
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/lockdep.h | 6 ++----
 lib/Kconfig.debug       | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index f5594879175a..d05db575f60f 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -580,16 +580,14 @@ do {									\
 
 #define lockdep_assert_preemption_enabled()				\
 do {									\
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     __lockdep_enabled			&&		\
+	WARN_ON_ONCE(__lockdep_enabled			&&		\
 		     (preempt_count() != 0		||		\
 		      !this_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #define lockdep_assert_preemption_disabled()				\
 do {									\
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     __lockdep_enabled			&&		\
+	WARN_ON_ONCE(__lockdep_enabled			&&		\
 		     (preempt_count() == 0		&&		\
 		      this_cpu_read(hardirqs_enabled)));		\
 } while (0)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 89c9a177fb9b..03a85065805e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1159,7 +1159,6 @@ config PROVE_LOCKING
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
-	select PREEMPT_COUNT
 	select TRACE_IRQFLAGS
 	default n
 	help
-- 
2.20.1

