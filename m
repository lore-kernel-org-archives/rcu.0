Return-Path: <SRS0=9/AT=DW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FF3C433E7
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 03:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFE720797
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 03:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1KeLzGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgJODxR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Oct 2020 23:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgJODxR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Oct 2020 23:53:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B149BC061755;
        Wed, 14 Oct 2020 20:53:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w21so864661plq.3;
        Wed, 14 Oct 2020 20:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PcE1kjCjEs+BJMqgFgiR6+M120Lae8WGd4rCIGF4zKg=;
        b=V1KeLzGMkjL2L6Sh63zOik1SQDi5CqI88GK3quUCW3fnij1Gkv5D9jSbAgPyxqWrXu
         Jj1R5hzT7be5QbHKegXGIVgzxb4/Ws5SXw7uXaOC2YCg85+iY6RQRzUfSzM4+Gqgoed4
         bIb0ZV+5KWsqJOujvl2qn+U5O9BZ7t1Rc7m/9epdfOacfjp2LVpXiEfCtqVNozB4Zmc9
         ABsLX1GgaN7+VSqjRBF6wI4Oqs5rbGkjc2z0aCNZ+emDKgDIMxei//3Trz+I5mvSAZdQ
         iz+4YLI+8c9kWbg2XlBvj8020FlgkU/eRSbX46f0hNRnO4k3rEmuGMgdsUI/ndQNKeW3
         ZKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PcE1kjCjEs+BJMqgFgiR6+M120Lae8WGd4rCIGF4zKg=;
        b=uRpmzGz+TRYPzAPeaTS0bh3Qo43oTBLxE1mWcjIip8K0gWD57ehuthtOQV/Zx3rgWJ
         yGtkrJfb7kGUXVNptvAbe9QiDLs5gFs6aMnGDevHq6YmZrig4z9fpyMLe2ko3i2jtQw7
         JdeMsrKRSY0LIaV2Wjf1N8Aim9zds9+779TwxyW0CT9iaF4GmPmogFRmc6Tpcvash4Y1
         W6Hf4898fGW49aLBcjBJPYhlB4r8q2U/DDAweUwStWS680jVF9UlXMmUBsvvM1i3I61d
         R3vs/DXqtErEnvw2cIz72IJig7fs0+Z0Xaj0Fy9Mh1pALbFs3UvR/tldK3t2bgCRbL/R
         rCDw==
X-Gm-Message-State: AOAM533iWUZD72UVdCZ5KFmaKIIFq2HdP+OPqBz65O01KVNZovnWAfik
        CBXNvo5wFia9PaKNSBzBQGA=
X-Google-Smtp-Source: ABdhPJwr29XBysw6kW6RuqKql+4mcUOEIwWI8lUNGoKJKjixGNZkuSRrmx6q6QJAJcvv9CUE+mtvCg==
X-Received: by 2002:a17:90b:305:: with SMTP id ay5mr2410073pjb.129.1602733995223;
        Wed, 14 Oct 2020 20:53:15 -0700 (PDT)
Received: from localhost.localdomain ([154.223.142.197])
        by smtp.gmail.com with ESMTPSA id p16sm1320212pfq.63.2020.10.14.20.53.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 20:53:14 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] RCU: fix a typo in comments of rcu_blocking_is_gp
Date:   Thu, 15 Oct 2020 03:53:03 +0000
Message-Id: <1602733983-9803-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There is a tiny typo in comment of function rcu_blocking_is_gp.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 kernel/rcu/tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f78ee75..4cca03f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3512,7 +3512,7 @@ void __init kfree_rcu_scheduler_running(void)
  * During early boot, any blocking grace-period wait automatically
  * implies a grace period.  Later on, this is never the case for PREEMPTION.
  *
- * Howevr, because a context switch is a grace period for !PREEMPTION, any
+ * However, because a context switch is a grace period for !PREEMPTION, any
  * blocking grace-period wait automatically implies a grace period if
  * there is only one CPU online at any point time during execution of
  * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
-- 
1.7.1

