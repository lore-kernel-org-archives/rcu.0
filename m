Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5963EC07E9A
	for <rcu@archiver.kernel.org>; Tue, 13 Jul 2021 00:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0166101D
	for <rcu@archiver.kernel.org>; Tue, 13 Jul 2021 00:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhGMA74 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Jul 2021 20:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhGMA74 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Jul 2021 20:59:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91589C0613DD;
        Mon, 12 Jul 2021 17:57:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p17so9666024plf.12;
        Mon, 12 Jul 2021 17:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7772Xan/ik/wF4AknIJNRSnTyGg4NRQcBL8wB3gfbmE=;
        b=Lsss++Zjtoro8sf32sfTiocEl3TjC8HaOXbx5wNuGl5I4kQ6561HG5W/593+2FYRIm
         jIhmREqydFzpn+igwM/vL+7C/cc5LoRBRP4xyk0AoS/ZHEOOmuQol/YCkv52eKJQrgJL
         PtcTpQ2j+pKjSkw8TNWnhRuadnQ/fcwcenrHSCBw5oqeKS9Sk1JcV4BI2baEA9G8RAHE
         7X76A2ypUC0ujuOmtO0pL0Wlb2i5ZKZWbe9Vq4DXLO/eFf0w+11k7ozHAsQzDWAhXJr7
         i8+IKgNZBIFjxuGHGh3brtXtHR+UuaO+l2UiRHxD4EnKB0PXhdiX/pYVa3BNFQ2qkkRb
         NklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7772Xan/ik/wF4AknIJNRSnTyGg4NRQcBL8wB3gfbmE=;
        b=rUT2dpH9y1n9jAd/WTa3GYYIQ/SZu6YBaWC1+0ZGsx7rgegFnOBNFJhIktnJ3phmpN
         9RyqrwvoIlPH77+1yCX1M9I1znNHtHSGjHwmiLZLTQZF/gFED2D5ExJ3AH+OF/SrLMXr
         WQRePAR+yj3A8I+BtNFe1QJwI1EUcbeiRlNAetr3LjxhQAHx0vBZc3MH9cA6fyS9HEXH
         b0ZgCBycKY/Sy9Edb8BnWvvfOouAsHItpPRgBqFnpK1Ycgs9dAVdzBWcb06r8lvHXyoT
         TAvaHPkAPoZ/y3zltSBi9FX3uiCfUNPZt4TS3gHZl69qDsJViG/bPDMJDyViVizLe858
         1MXQ==
X-Gm-Message-State: AOAM531t12fxNGEDp45xaU1n2nOVTZmQZjncmz/uIF0Cmzpc3I+eHyDp
        gZRm0kaGVlhq1z97F+/cCqw=
X-Google-Smtp-Source: ABdhPJyMq0NSx0CT82c2/4C4xib7ishMjAm6WA93r1AVUKmTZoQXzT5yZ7mN5krpLyGgg04nqnfSLg==
X-Received: by 2002:a17:902:9f93:b029:104:9bae:f56a with SMTP id g19-20020a1709029f93b02901049baef56amr1284851plq.75.1626137826100;
        Mon, 12 Jul 2021 17:57:06 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.174])
        by smtp.gmail.com with ESMTPSA id u16sm20124122pgh.53.2021.07.12.17.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 17:57:05 -0700 (PDT)
From:   zhouzhouyi@gmail.com
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
Date:   Tue, 13 Jul 2021 08:56:45 +0800
Message-Id: <20210713005645.8565-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

Hi Paul,

During my studying of RCU, I did a grep in the kernel source tree.
I found there are 3 places where the macro name CONFIG_TASKS_RCU_TRACE
should be CONFIG_TASKS_TRACE_RCU instead.

Without memory fencing, the idle/userspace task inspection may not
be so accurate.

Thanks for your constant encouragement for my studying.

Best Wishes
Zhouyi

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 include/linux/rcupdate.h | 2 +-
 kernel/rcu/tree_plugin.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d9680b798b21..955c82b4737c 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -167,7 +167,7 @@ void synchronize_rcu_tasks(void);
 # define synchronize_rcu_tasks synchronize_rcu
 # endif
 
-# ifdef CONFIG_TASKS_RCU_TRACE
+# ifdef CONFIG_TASKS_TRACE_RCU
 # define rcu_tasks_trace_qs(t)						\
 	do {								\
 		if (!likely(READ_ONCE((t)->trc_reader_checked)) &&	\
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index de1dc3bb7f70..6ce104242b23 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2982,17 +2982,17 @@ static void noinstr rcu_dynticks_task_exit(void)
 /* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
 static void rcu_dynticks_task_trace_enter(void)
 {
-#ifdef CONFIG_TASKS_RCU_TRACE
+#ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
 		current->trc_reader_special.b.need_mb = true;
-#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
+#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
 /* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
 static void rcu_dynticks_task_trace_exit(void)
 {
-#ifdef CONFIG_TASKS_RCU_TRACE
+#ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
 		current->trc_reader_special.b.need_mb = false;
-#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
+#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
-- 
2.25.1

