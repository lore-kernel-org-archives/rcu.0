Return-Path: <SRS0=Hkx7=5Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8898BC2BA2B
	for <rcu@archiver.kernel.org>; Thu,  9 Apr 2020 13:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B53E2072F
	for <rcu@archiver.kernel.org>; Thu,  9 Apr 2020 13:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMnuGV6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgDINYx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:24:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33858 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDINYx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 9 Apr 2020 09:24:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so11942601wrl.1;
        Thu, 09 Apr 2020 06:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zR3DgcYcoajS3pcsVxvtvANl1Kh4/a0YhER6iD47AD0=;
        b=oMnuGV6jAHRKHKiPIvQvIbwOGDU1/0yfjWlf0LNYpFEscQ1jpuzGoDioXq0lIDTArc
         J9C7hZsyiZz+VVdS0xYc2IBVULFGPrILqi+G9Mg5MLIgBxLzat4+rJmnJXQbWBFesQVV
         1JiaTXUGwWDBTGDiLfxC0TZ5RiD/Iaa+Bb0yGoW63vrP/TI32tCWg7VuuYItslSnywJF
         7ALv60h270KVr5aEjhsmmLuHZnJJNAF0FryF10oQ6DQrRy2b1KDH5mUTBnZTgRFuBIWI
         W4j9mTC+uU8vOZmqGlOAYuAGHi+Ilr8vPpM0y2NdlPqwBzrSorkFCFnE6bJ+Z5skkP/A
         frxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zR3DgcYcoajS3pcsVxvtvANl1Kh4/a0YhER6iD47AD0=;
        b=KLHc+Q+zzmvYTdX8Jnu+8QHBCD1Cv3EfNy50NSaq7tmd0l5aKcJahnTAH1Oyg65uyl
         /Akmt+meupDOYOLVpBGM+sAU9FamKDv34NB+ScK6D3LbTpIQd6AfFPp8JXBp22EvXSeU
         DMe8ckw32WXzGf1aYORRMSNYJpDejMEN5rrz+GnHN9WS5LaVHQjmjObEKHAz4WWpmoPa
         EE2xN5f+VHc7IIdhROA1mP1Gy+WvddzSFJuEXnW4IM1sbAvD+vewymVggsnkweatGu69
         NDe1yLvWOoKpurhV+c0zQyXS7jM5ZyWIo+qEUQ0TUW89fwLynX/E5kjaYOXH8zA7DY6F
         GciA==
X-Gm-Message-State: AGi0Pubj34qAz9ss/yRIXBt/tW1hkBgeIRpSI9oIHC/llI6nrUkA8udN
        ew+wapVdVCAi1Z1KO5WftWerSOZ4
X-Google-Smtp-Source: APiQypLgfXjRhDnVyixYJ5YvrSl+qGIm21xTqHg1cZwGAewjz0n0Ex1TKgcmmOmA9ayZPkR2GmTtHw==
X-Received: by 2002:adf:e942:: with SMTP id m2mr14106646wrn.364.1586438692044;
        Thu, 09 Apr 2020 06:24:52 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w18sm17411040wrn.55.2020.04.09.06.24.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Apr 2020 06:24:51 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] Documentation/rcu: fix a typo in RTFP
Date:   Thu,  9 Apr 2020 13:24:37 +0000
Message-Id: <20200409132437.11531-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If I am correct, this character should be 'u'.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 Documentation/RCU/RTFP.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
index 9bccf16736f7..261eeb501ba5 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -1,4 +1,4 @@
-Read the Fscking Papers!
+Read the Fucking Papers!
 
 
 This document describes RCU-related publications, and is followed by
-- 
2.23.0

