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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7A0C2D0A3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81532214DB
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBOMyDEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgJ2QvQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgJ2Qu4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C461EC0613D6;
        Thu, 29 Oct 2020 09:50:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c21so3895216ljj.0;
        Thu, 29 Oct 2020 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7ld8JTNLAaP/tRnYtprPtHt3mKysFQ98EZPtA8qIlM=;
        b=hBOMyDEdLbKNAtCfB06fRU4P/UAadZibd6hSo63AFf/DdwYPD2T8JyW6bbjDvPaAZC
         Tu130fpAFNtqZkmm9mHnhrNH0RLLAPGK/pO7z1hiHMILlx24fY53gyosCGslA3MeuY5z
         SklwEjp+6C4pgyQB3lkrYF/97Jt/RWNkwkCbHFT+eYzpu0o5WybI6lheimTTq49NR0uD
         YqgVajI8BKrd1FdRaeF4/wwxyDqzFAIZXmo0unBdFd5OosCZSl+v34yI3CGBBPic2+tM
         qMb5fW6+LzoGrq26LKNP/UsAbkHiuLLwsxc0OiUkjVb5PZrd6lNOAwyxIZgH42xhR0Ca
         LhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7ld8JTNLAaP/tRnYtprPtHt3mKysFQ98EZPtA8qIlM=;
        b=lcNblh6K0z/quQitowTxzBNe5VAAHayVQ44SH64JwX0DDcfWlWJZquqYmaol/gIsfx
         /eUvCz+qW4voqXTqNyzazEQXyS33Bv218Rwj9XXse85X1GeCG8D+pm6nOBjx12xr9Cgw
         VQSgT//GlUs9imneJvAAJkYmF/PgETWLSRYqWeDomRUIcMdFTPPWHJSGg9/Itd6Qu18C
         5deevVRVsk1dAb/HycV7CH2nzQIPMqpJhQU5n/IAIX8G6QktiJSx1LKLAu1wbXpx8xwW
         V/hwB/kPdat0/IFCS5I2XJiD8v/J6WpgNAThGWQdvQPf1Dmb0LXtmcuqTFpqPrx3WOkJ
         awLg==
X-Gm-Message-State: AOAM532O1qw4U5G9Sen1qocmPB2EyIqmnGWY/Mr8+LmrqOZpHYIb6KJl
        GGlMekB31gZOD/ag8OckzqgT/WKWoFHxgg==
X-Google-Smtp-Source: ABdhPJyvHkHewNHFrSrHTaN9R1v5AFIiW0XtSCXzasLk5JybhLP9fIXbQZ2D0JvXcIJb0ZxFsFlH5A==
X-Received: by 2002:a2e:b8c7:: with SMTP id s7mr2096678ljp.374.1603990253897;
        Thu, 29 Oct 2020 09:50:53 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:53 -0700 (PDT)
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
Subject: [PATCH 14/16] preempt: Remove PREEMPT_COUNT from Kconfig
Date:   Thu, 29 Oct 2020 17:50:17 +0100
Message-Id: <20201029165019.14218-14-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

All conditionals and irritations are gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/Kconfig.preempt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 3f4712ff073b..120b63f0c55a 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -74,8 +74,5 @@ config PREEMPT_RT
 
 endchoice
 
-config PREEMPT_COUNT
-       def_bool y
-
 config PREEMPTION
        bool
-- 
2.20.1

