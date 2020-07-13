Return-Path: <SRS0=XkjU=AY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C55C433E0
	for <rcu@archiver.kernel.org>; Mon, 13 Jul 2020 17:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E455C20791
	for <rcu@archiver.kernel.org>; Mon, 13 Jul 2020 17:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qt1TWq5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgGMRtB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbgGMRtB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Jul 2020 13:49:01 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C050C061755;
        Mon, 13 Jul 2020 10:49:01 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so6332304pgg.10;
        Mon, 13 Jul 2020 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X/UxR11zWpZM3dbb73YevVQANqUAYVi8RjwQuOTkMCo=;
        b=qt1TWq5QiAZsW+kN/girNvQwxa3x0b4OAYSIpoeUCUafTZd4E5czr1zKjYGoCJFSub
         kjTJtt6rwWcQdZGl+rcusVj1KS387Fz5RnTthae1+U6pj4QrQwsBTriLvFsPyNOSGN2a
         ngUzt+ukykhkRKLN/Qv06eR8AlUbiq2qZlaUK7Kh74YiCqjihvyH7shr+F5FwfGsHgma
         b3FYbJXy07F+N/I2PQ01CQugQ/aXuchwgjwgkGJ0Rr8E7RbeAms+f7ubcsJI9Yb0a3n9
         WvUQB0a1hFtmMKe+4YY+00KfsTuDl2E2CcRC4l5w2FtfxgBg4qXuvMRj1+38fCaHjzET
         yOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X/UxR11zWpZM3dbb73YevVQANqUAYVi8RjwQuOTkMCo=;
        b=b+tHvHRNT8rVdtCN0OX6BpDfeMZ07pON5fftLtusT11uOdwR0f8sm9ccNxMWYn0CvU
         2fe5HZMBUqxfulOQmyyLFlUWH9zdzVUtYV1Xga4FhrWG2EeYEol2+pm5U9ZHUDYz5FBP
         67mOId8sEmm1aCQSN0qcV2CC6e0jenOfMPrQgmoBAW81OLu39QXtswgg13/0mQ//vKCU
         DgAXIMxNrfTk4amFKoqc5KLqG0fKSnrOGQQqYBwRB1ikIhvF5n3jntluXUy6LuTjwrjb
         0Kl/LPqFBbQtI4NDvgNzHreKlwpW/YNb6uSmkujba+zDFI6F0nVZ3LB0rB1lqr+5R450
         4UFA==
X-Gm-Message-State: AOAM5326OcyD/YzqOqHKy898QYWEROXfG9bpdOVXo0OUMOPle+4U2QXN
        L25vBxfWSC2kxqUgCUeq5A==
X-Google-Smtp-Source: ABdhPJw936w1c/xiB+NeR+z/vaLStkZCWsDmuwxIveK4yIDPUBtWVB3kDrhG/GkdlS48rj+DKoqHfQ==
X-Received: by 2002:a63:1119:: with SMTP id g25mr287078pgl.126.1594662540867;
        Mon, 13 Jul 2020 10:49:00 -0700 (PDT)
Received: from localhost.localdomain ([2409:4071:200a:9520:4919:edd3:5dbd:ffec])
        by smtp.gmail.com with ESMTPSA id e10sm230186pjw.22.2020.07.13.10.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:48:59 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     paulmck@kernel.org
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] rculist: Fix _list_check_srcu() macro
Date:   Mon, 13 Jul 2020 23:18:46 +0530
Message-Id: <20200713174846.8681-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch fixes the macro _list_check_srcu() for CONFIG_PROVE_RCU_LIST =
False.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 include/linux/rculist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 516b4feb2682..a435ad62b90b 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -73,7 +73,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
 #define __list_check_rcu(dummy, cond, extra...)				\
 	({ check_arg_count_one(extra); })
 
-#define __list_check_srcu(cond)
+#define __list_check_srcu(cond)	TRUE
 #endif
 
 /*
-- 
2.17.1

