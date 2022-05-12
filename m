Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E33C433EF
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbiELDFF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244299AbiELDFE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:04 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C197D1FE3CE
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:02 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 185so3742109qke.7
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6iRjJs/b10qWS973iRQCDfhG0rdBQpqDx7mITDoIFnQ=;
        b=DoI3pBi249bWsPQZbGGRoOL3nGoc4pzBY1UM02yWAL+Jx40INZHBcPy36V3xpZpxHN
         nHktj24BxoTKBxmNTygSNlHA91tkI78CDWtuEYWDVNrEDYdv7im1842GuVvO+PeOBjP/
         TN3orCb8HaCJyMvmQJDS5xI0UuEwjAbPt9gp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iRjJs/b10qWS973iRQCDfhG0rdBQpqDx7mITDoIFnQ=;
        b=0RqMusd48YPE++fInLQS8ex4Y71Rcz/ZgaM+yhJtFeMLYBtc/HbUjFiCH9vNYhpAFN
         ukzHROA0Yy9j56QMJ7WvA56ZpKxIFA/B0Uk9dX5EOycW49Eekr0dmd6jXE6FSG8NuMd1
         L66G36BFPKJYEk5iWhonTJ+S/KSZIEV0N72jinvX45yzPw2ZGKTRYM3nHEBOmW1f2Xhk
         Y/Tk4kDYJu+bieTqC0tg1Nw7DSQ0v0pt16mpBAmBx7DVhFoub0HXQ7EbzA2rX69c5T1E
         ogequ6mdZ3dCMU6i140Ul6sXjkThQRNwKOPz4o90wzdVHBBD+PH6ElQPpLEa1WQeuJ9u
         rO5A==
X-Gm-Message-State: AOAM531Is2pDDi9xTrkC4kAMNN+2LPcbj1lv5rcOwBfOPgdytm9Gmtx0
        Lf0/CWyG6jnGvn6BmhubirkVyOYaJ5PbtQ==
X-Google-Smtp-Source: ABdhPJyfR17mcxMbPisRHjZwHlS8+J0SwCgE73HA/4TvFiqQrYO7+vC4MeTRsxa8wz+Wm7IDacc7ug==
X-Received: by 2002:a05:620a:d4e:b0:69b:f2e5:b8cd with SMTP id o14-20020a05620a0d4e00b0069bf2e5b8cdmr20840842qkl.535.1652324701550;
        Wed, 11 May 2022 20:05:01 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:05:01 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 03/14] block/blk-ioc: Move call_rcu() to call_rcu_lazy()
Date:   Thu, 12 May 2022 03:04:31 +0000
Message-Id: <20220512030442.2530552-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is required to prevent callbacks triggering RCU machinery too
quickly and too often, which adds more power to the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 block/blk-ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 11f49f78db32..96d5de5df0b6 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -98,7 +98,7 @@ static void ioc_destroy_icq(struct io_cq *icq)
 	 */
 	icq->__rcu_icq_cache = et->icq_cache;
 	icq->flags |= ICQ_DESTROYED;
-	call_rcu(&icq->__rcu_head, icq_free_icq_rcu);
+	call_rcu_lazy(&icq->__rcu_head, icq_free_icq_rcu);
 }
 
 /*
-- 
2.36.0.550.gb090851708-goog

