Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4745EEB64D9
	for <rcu@archiver.kernel.org>; Sat, 17 Jun 2023 14:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjFQOxy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Jun 2023 10:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQOxx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Jun 2023 10:53:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4761FD4;
        Sat, 17 Jun 2023 07:53:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b5018cb4dcso9400125ad.2;
        Sat, 17 Jun 2023 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687013632; x=1689605632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQGpsZl973+aZ0cqgbaRCZSxnbhm+w0YCdfxFvpgF7c=;
        b=Oq54Z86M0XOA8i0yCtYYA1pqWjYuX4g9Q4ZKY71G1KrkZHNXFaSV2yOWjkfe3NLSUF
         lL2mNUYrPN0dEgVG3PV2RSpvOYZI4CJrI7wVMSulWvvVZssWJzP87Bl/70fvlH6yqGiS
         /cHzd8ITyNdBy3B97EP0pneFoD34Y1IaA/z7vmspCcXeZO6D2i3vNEy2fFS2/yWfxrPH
         e9ZJIswLNSMoJndJCC9iyx3nQ83QGzH4aCVI/LLPDorCvsMQi4TGgrFGmcFb5fB0vuEI
         EKGhKM9re1OkG0wBY02XPX95DQI3wQ96t1KVjDQRXUMfcqTkf9s/0Ydv8gEW+n6+4D3e
         YdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687013632; x=1689605632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQGpsZl973+aZ0cqgbaRCZSxnbhm+w0YCdfxFvpgF7c=;
        b=GQnWJBluQjRjFF1Azv+RgHOcrxIZaHi4DIVx48YMDvDyPgglWSXJ24UZms0RNidHyR
         ZCREYM6xH16BnklmgEPMMBc/7kOVnexuLFcxv1kwrBXkeujwBeM+xB6Mm2l0f2Y1xFXQ
         sVzwDOhisF7o0t52e18beb0Q8dY6qHZmrH9xMepH5OlIysXwFvjpWyLQ/ndPuxj7w8wC
         +2MUalQD+06khsEUtChYrRJJ+dxqEOMRkVRBs/U92LbRCDVqvi8Qa0/zOllOsx+KxJbS
         ioFevePxlcqepC4wY8NTAASO6yJLgYB8DWM4gNrSBlXb0IzfZu+wnc5uDH8Q1Fk0vYGK
         RoDg==
X-Gm-Message-State: AC+VfDy6EKn2Ns4gx8W14dIQ2Cn8iPPokomQ+lV4dIdRMxIYlfIk6QXv
        aYSk7M6fhPaMn+R8KbJdAdY=
X-Google-Smtp-Source: ACHHUZ59QGQAfScvNJJtG6od4Ez84/FMZ4IH/1kpr81tmZadi7m+LW1/0yOHwt05Ey+6o7S7sDNClw==
X-Received: by 2002:a17:902:e884:b0:1b1:adb4:8fa8 with SMTP id w4-20020a170902e88400b001b1adb48fa8mr3982387plg.39.1687013632190;
        Sat, 17 Jun 2023 07:53:52 -0700 (PDT)
Received: from localhost ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id m16-20020a170902db1000b001b23ee9def8sm17477552plx.213.2023.06.17.07.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 07:53:51 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
To:     paulmck@kernel.org
Cc:     joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH v2] docs/RCU: Bring smp_wmb() back
Date:   Sat, 17 Jun 2023 14:53:46 +0000
Message-Id: <20230617145346.29009-1-mmpgouride@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There are two memory ordering required in the insertion algorithm,
we need to make sure obj->key is updated before obj->obj_node.next
and obj->refcnt, atomic_set_release is not enough to provide the
required memory barrier.

Signed-off-by: Alan Huang <mmpgouride@gmail.com>
---
 Documentation/RCU/rculist_nulls.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index e06ed40bb6..77244adbdf 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -98,7 +98,7 @@ Quoting Corey Minyard::
 ----------------------
 
 We need to make sure a reader cannot read the new 'obj->obj_node.next' value
-and previous value of 'obj->key'. Otherwise, an item could be deleted
+and previous value of 'obj->key' at the same time. Otherwise, an item could be deleted
 from a chain, and inserted into another chain. If new chain was empty
 before the move, 'next' pointer is NULL, and lockless reader can not
 detect the fact that it missed following items in original chain.
@@ -112,7 +112,12 @@ detect the fact that it missed following items in original chain.
   obj = kmem_cache_alloc(...);
   lock_chain(); // typically a spin_lock()
   obj->key = key;
-  atomic_set_release(&obj->refcnt, 1); // key before refcnt
+  /*
+  * we need to make sure obj->key is updated before obj->obj_node.next
+  * and obj->refcnt
+  */
+  smp_wmb();
+  atomic_set(&obj->refcnt, 1);
   hlist_add_head_rcu(&obj->obj_node, list);
   unlock_chain(); // typically a spin_unlock()
 
-- 
2.34.1

