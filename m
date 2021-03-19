Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F1DC433DB
	for <rcu@archiver.kernel.org>; Fri, 19 Mar 2021 00:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0968B64EFD
	for <rcu@archiver.kernel.org>; Fri, 19 Mar 2021 00:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhCSATo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Mar 2021 20:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbhCSATZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Mar 2021 20:19:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBD8C06175F
        for <rcu@vger.kernel.org>; Thu, 18 Mar 2021 17:19:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e14so2116257plj.2
        for <rcu@vger.kernel.org>; Thu, 18 Mar 2021 17:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZKNqGcOFxnFSs+j920f1ACx3dBPREyNqpSB4Op9FM0=;
        b=Wwfmgkl3bG+O7E491clTkH0eDowPADxO1n6D+OrTTR30ODfRwtYMm7csN7XZ8yhHwe
         5UysRM0FEJhlAavRP3Ccc8I5S+SqKIWMXbYVp9FP/cG2khzhwhXccBOllTR7AzvmJ+JV
         GPjZc0oCqWIzH6bIP5JmKgyYnsuOMiH8dSETdpem0h0f+FcDIf5hA3sp9axDPaWGcKKj
         AG0b2z8KTb2IH+cwQaloDUAK/9BuLJTAbeiWySoiuNLXGZ98TGnzFypUTc/7x3Ka8r/r
         60eNhnzrHQEdkdiQ7uZBkeuYHaSZ4PHgjJFQw9YV5S5fpQ1HM8r3lAYCaX4MNhr9exMc
         wsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZKNqGcOFxnFSs+j920f1ACx3dBPREyNqpSB4Op9FM0=;
        b=OyM8xVLramszQnNTWzup6GEK7Z4S72WNlz/vT3PUgFGhI48tOi0/1Gaky+nRPt3q3V
         w4dxxn1GTQtcz2fRY3qGOCPyOkqWfCYiBUYLy9vcA/k5M5tdXnMi81dj46B4NRFIWWqh
         os9fPekXkTw54G+TDYOl56osdnXPx9LTO3Hllp/4m4skbl2UnOPPBnkwLgRqxazjgDVn
         2uyZXXkS9dDiRc+ZOR5EdhlG7O/knMRpW6JiUT54QwvuRyeztxJ0uZRqPbA0WMmWCRU1
         owSYW/MnnoptskQSXkl8PoYb9b8NQ2zPHcMj3Yg3LmdKEDrgqiKIkrwVCw8aGbX0xyeZ
         PKXQ==
X-Gm-Message-State: AOAM531jswRWVxsnvd4r19U0Jh/lJ34xvKkcBCcl/86Cs30AZQCDq7zW
        hqnUEZVYYWLJHesJzBj2mKYTgQ==
X-Google-Smtp-Source: ABdhPJy+uyjOXGMNwa+7j/841CLC8G7jeCZfYyhN4rmIXFvOQI92oX+2B9aundDKnp/uxMnfeJiY1A==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr6869944pjv.113.1616113164491;
        Thu, 18 Mar 2021 17:19:24 -0700 (PDT)
Received: from hermes.local (76-14-218-44.or.wavecable.com. [76.14.218.44])
        by smtp.gmail.com with ESMTPSA id 3sm3404458pfh.13.2021.03.18.17.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 17:19:23 -0700 (PDT)
From:   Stephen Hemminger <stephen@networkplumber.org>
X-Google-Original-From: Stephen Hemminger <sthemmin@microsoft.com>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] docs: Use my proper surname
Date:   Thu, 18 Mar 2021 17:19:16 -0700
Message-Id: <20210319001916.136666-1-sthemmin@microsoft.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>

Fix my name in the RCU background file. I don't use Steve.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 Documentation/RCU/RTFP.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
index 3b0876c77355..588d97366a46 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -847,7 +847,7 @@ Symposium on Distributed Computing}
 	'It's entirely possible that the current user could be replaced
 	by RCU and/or seqlocks, and we could get rid of brlocks entirely.'
 	.
-	Steve Hemminger responds by replacing them with RCU.
+	Stephen Hemminger responds by replacing them with RCU.
 }
 }
 
-- 
2.30.2

