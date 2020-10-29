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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2387BC56201
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA533214F1
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN1oW/d4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgJ2Quh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgJ2Qug (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:36 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34BEC0613D7;
        Thu, 29 Oct 2020 09:50:35 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id f9so4211177lfq.2;
        Thu, 29 Oct 2020 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHL2eYUsujP9E8SR7vff4NMNPp6D9uQpGZ5m3wNLfHw=;
        b=LN1oW/d4hWrBp6khasc6RACi+3/FBYXPMmq72CNVMG3a9uditPhQgM0qBgoyMIC2PI
         RbiAzQ6SdRnN3ke1sMPXcQy++s/N2EkN9xhV7PAZYSoTXtpqhuRi9Iy0nsEo5L6NGUsT
         iOTfaDKCPMuUT84ocDJXinBO5vtaWwNL6upFZKXfWkHxB0uEtqu6nIWIGOXC9aCkRR/V
         ISkLyi/WPjK36b/VzbFECpr3QWsEmkd3jHNG6J/NNopGDtLAEMKkKyM9ManCy+Y0YTj7
         XCBi+YEbuMpqGE6hRQVxM5I8i53UonDHeND1WHm3jU/qkXyUM1u0OyfQBCy52NrA4KJr
         VmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHL2eYUsujP9E8SR7vff4NMNPp6D9uQpGZ5m3wNLfHw=;
        b=T8B3MZMGAYHD2advvOTjEezAuOMqSsgcJnSt05WUk5ycc2yb3YSuKUSZBerAt20auW
         eGrlSOjfCE1OCwoN3NOY4XoJ1teWqCScmKH3FvDtrzvYNddN511SjfrmeuRPj36xJafB
         ZsSLBCjtTZldc1ZAqNjiMhe0yf94j2cj1sdpc917GefdpJHZ33YBpf8u7SZdPrJAJhSo
         Z6ZxInV8hfpBOGPw+aU2P2ef/d+vlVLcYNkyaOEEjwcgWrSzTZLj+0XoZq8ArC6SLTfb
         O4cjIoZpRcZcgc9J8d47DnOPn3Ef+5tl9i7Q+c1mjTkUHgnPlKyuwHiI2Oelv4IvcQWs
         zY7w==
X-Gm-Message-State: AOAM5326Y98mHr6t2afl71WJqkOoDAkcsV+HSfIL2TVH2OZI6KxFHg5e
        CioOJBjFNz6j6ZKckojCn2MF1eUINiimbA==
X-Google-Smtp-Source: ABdhPJy+5N16E4omrgOC0yoactJMKdnJxc7BoiCeeMzYl6fyiSgbE/MT6s/9lKXRtyR85LDEMcVbOw==
X-Received: by 2002:a19:c92:: with SMTP id 140mr1793876lfm.186.1603990233717;
        Thu, 29 Oct 2020 09:50:33 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:32 -0700 (PDT)
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 02/16] lib/debug: Remove pointless ARCH_NO_PREEMPT dependencies
Date:   Thu, 29 Oct 2020 17:50:05 +0100
Message-Id: <20201029165019.14218-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

ARCH_NO_PREEMPT disables the selection of CONFIG_PREEMPT_VOLUNTARY and
CONFIG_PREEMPT, but architectures which set this config option still
support preempt count for hard and softirq accounting.

There is absolutely no reason to prevent lockdep from using the preempt
counter nor is there a reason to prevent the enablement of
CONFIG_DEBUG_ATOMIC_SLEEP on such architectures.

Remove the dependencies.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d7a7bc3b6098..89c9a177fb9b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1159,7 +1159,7 @@ config PROVE_LOCKING
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
-	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
+	select PREEMPT_COUNT
 	select TRACE_IRQFLAGS
 	default n
 	help
@@ -1321,7 +1321,6 @@ config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
 	select PREEMPT_COUNT
 	depends on DEBUG_KERNEL
-	depends on !ARCH_NO_PREEMPT
 	help
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called inside atomic sections: when a spinlock is
-- 
2.20.1

