Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13425C43462
	for <rcu@archiver.kernel.org>; Wed, 21 Apr 2021 03:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9BD61415
	for <rcu@archiver.kernel.org>; Wed, 21 Apr 2021 03:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhDUDOJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Apr 2021 23:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbhDUDOF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Apr 2021 23:14:05 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA60C06138A;
        Tue, 20 Apr 2021 20:13:32 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id z25so7593693qtn.8;
        Tue, 20 Apr 2021 20:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZK3TPIqCDZ+2tlXzBCK7P9aXaldyR3nTbxjQuIWXyEU=;
        b=e6dW1MbVWD3LbIq6mWdhkkZ8aKhfroy+PbLAZvFXkirD8+6TATsQdLRQooJZfrez66
         2U3fpn5/WCbumUqz4KMr55D07daay5pcop6t/rg1aFOOakV+tVt2eR/kUiSW0PKguoM1
         WjvXUXvoG92xSvLrnRfQ/OLLOxoKuZYMXKAMhhiIIUNcivnyD0D+yKf2ZYkTTi0XIs2Z
         yJMlU6jE2wQYXkrctvVLelcH8W5x+8UuwMvJQLHOwmSuIVlKGjAYLbJpXpL0KziuxQLo
         HaXbKPuG5pHsmWomgkwWEp4XAd1lVdY852DyYW02m5CphunJZ9I8o0w/D5v8aPd3lzsK
         oRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZK3TPIqCDZ+2tlXzBCK7P9aXaldyR3nTbxjQuIWXyEU=;
        b=dX/8ePl8DMzx3aT6TEt44GMqNIuDvd8sIrEKnU8DqohIqtr3QsESeqoffYnhOHkWtZ
         P1M8Hrua4fpzfWVyhpZoZeM8AiYPUHBNpTkUfH58BxP1YRwdLnTCiXuA9cZ+G9bZKsPK
         YQAFjxIlyv15t9Z1LeWTOsHInIII1AxHEaeN5ZxuPf2ad+YRJ/TJaXRzduqCRGvCXQaH
         DaTLtUJK7i+VlnUfsQw4X9StrC/4C/DbpqyE60icpVKtC/aix2QT2kO+UTHcYg9REsjC
         ciXEh3K2GLJdo3cU88het+ENxIGkZ8opjmX5o266A0Mxgh9l8vSk3rtL2dfh4+ECbKzL
         qxTw==
X-Gm-Message-State: AOAM530P14FyPQdNr3+z6Lu5SThfBlMMfwTkIEqE/Umn4tm+HiyQr4KH
        18kYn/2C+MKcPaDj8o0qFLqWMwut2yA=
X-Google-Smtp-Source: ABdhPJyaTl+yU0Jx/CWE6XDyErrWYZ00ZTn7dAyuzm95taAQYb28uBOxuScf0yOOEA/9BexVpe8xTg==
X-Received: by 2002:ac8:7647:: with SMTP id i7mr8583419qtr.195.1618974811755;
        Tue, 20 Apr 2021 20:13:31 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id n6sm673356qtx.22.2021.04.20.20.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 20:13:31 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] rcu/tree_plugin: don't handle the case of 'all' CPU range
Date:   Tue, 20 Apr 2021 20:13:26 -0700
Message-Id: <20210421031326.72816-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210421031326.72816-1-yury.norov@gmail.com>
References: <20210421031326.72816-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The 'all' semantics is now supported by the bitmap_parselist() so we can
drop supporting it as a special case in RCU code. Since 'all' is properly
supported in core bitmap code, drop legacy comment in RCU for it.

This patch does not add any functional changes for existing users.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/rcu/tree_plugin.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 464b16132866..334eaf4d561f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1511,13 +1511,10 @@ static void rcu_cleanup_after_idle(void)
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (!strcasecmp(str, "all"))		/* legacy: use "0-N" instead */
+	if (cpulist_parse(str, rcu_nocb_mask)) {
+		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
 		cpumask_setall(rcu_nocb_mask);
-	else
-		if (cpulist_parse(str, rcu_nocb_mask)) {
-			pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
-			cpumask_setall(rcu_nocb_mask);
-		}
+	}
 	return 1;
 }
 __setup("rcu_nocbs=", rcu_nocb_setup);
-- 
2.25.1

