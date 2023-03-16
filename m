Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9447BC6FD1F
	for <rcu@archiver.kernel.org>; Thu, 16 Mar 2023 07:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCPHLM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCPHLJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Mar 2023 03:11:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF819ACBB0
        for <rcu@vger.kernel.org>; Thu, 16 Mar 2023 00:10:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a2so766690plm.4
        for <rcu@vger.kernel.org>; Thu, 16 Mar 2023 00:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678950616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=181jNcZjo2XcmF/l5Vr9WoihrbDX3mDcNfqzcSqO7xY=;
        b=qPUchVyq3S/vwqjktA8TE8LILAS6CvrlYIpdLY1j2i0+6ojFphGM80FkTqE3+etCSB
         vwa0GUjxxyS7MkH8ZRmhdzjyo97oZYFsiFmnQCZbHKQxYG28L41EKhrG3yZ6GKiZdvP/
         j92NyF7cwWd8G9WRPYM6CjBkXOC8M9E9HYqA2k1RYUOFA/+MCMXRzdabHV4V6FgN35Pm
         WYNenoCYLNGLjqrktcrmpinFhnpACWYw0kevd1LrzYdt9q3ceUeOgrN+ZisV0LrNsXag
         CLGFpvXhWJrQPDpjXfMCiooHAPK4ltqmeKQPcJH701W85lkZCXCMlqaMr6DDXNBm9dCG
         d1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678950616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=181jNcZjo2XcmF/l5Vr9WoihrbDX3mDcNfqzcSqO7xY=;
        b=vYmmaV7+NiaYwzOIqIRgyw5o5ivJ4QV86RdSfN6P4TUOqyLnUrp3G3MOBWMwGoA0A+
         EillOXhUO9zkngY+dpfTcM2Rjmuh12u2pRuLAN5ACOGkbCkKfMr2CTvUvAN8N8Rn4oUm
         fwIXbOxeN1bpqpkNdh7P0b7PNg4Xmp9vpFYPC2UmPvsQvHvC0IpszT1m54uNVUMUqQQG
         6VLqDQ9mCisLWB3Bs2BSgvmsV1NnssmI4Fw9EqcUiUlpFuQAZDf0z0GdanJuG3AoiqPi
         3cJBgfATPv8S7WoMBg86Oc8xy1uPsFMTyQxuII6CaBpXaBPfsE+Q+kv0cIvod7IAXQT6
         OsJg==
X-Gm-Message-State: AO0yUKWf6GCwTUH8Ka2l3v8LJSyueOLv2dLXwXP79ZCES8Gj9Jc3lLNU
        lGtUAlk8J1seBzd3/L1hAGQ=
X-Google-Smtp-Source: AK7set9zM5ikPlRUv/F3o7+PZLGFqF2cFwFex9URVAgljHFz7TkVNbGmDAAMRASET/KFgfS6ls3GAg==
X-Received: by 2002:a17:90b:4f48:b0:23d:198c:a5ec with SMTP id pj8-20020a17090b4f4800b0023d198ca5ecmr2668232pjb.39.1678950615921;
        Thu, 16 Mar 2023 00:10:15 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-198-98.dynamic-ip.hinet.net. [220.143.198.98])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090a9c0e00b0023d270929bbsm2438986pjp.49.2023.03.16.00.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 00:10:15 -0700 (PDT)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] docs: RCU: typo fix
Date:   Thu, 16 Mar 2023 15:09:36 +0800
Message-Id: <20230316070936.733-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

It should be "Please note that ..." instead of "Please not that ...".

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 Documentation/RCU/checklist.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index cc361fb01ed4..bd3c58c44bef 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -70,7 +70,7 @@ over a rather long period of time, but improvements are always welcome!
 	can serve as rcu_read_lock_sched(), but is less readable and
 	prevents lockdep from detecting locking issues.
 
-	Please not that you *cannot* rely on code known to be built
+	Please note that you *cannot* rely on code known to be built
 	only in non-preemptible kernels.  Such code can and will break,
 	especially in kernels built with CONFIG_PREEMPT_COUNT=y.
 
-- 
2.34.1

