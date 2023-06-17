Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBC3EB64D9
	for <rcu@archiver.kernel.org>; Sat, 17 Jun 2023 11:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjFQLHP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Jun 2023 07:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFQLHO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Jun 2023 07:07:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62B010D;
        Sat, 17 Jun 2023 04:07:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e97fcc60so506497b3a.3;
        Sat, 17 Jun 2023 04:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687000032; x=1689592032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhpY0RwqwHbZiwoJYp4Rqo6qZ2feyVpNaQrxVK7a/N0=;
        b=IwygCn8giTzXhLQ87bisS6fBvSruFs1A/TuZ7cKl6CtQKBmwUXz8kttUmAuFG/qCKW
         epK3DY0zD7Jh7kv6mTgGNVawIxA21KHkQvzO1nCBKupET1ZOoX7zpUdOaNsdW65epM5S
         +C5t4MlU+cRcPPUo0YSG7/IECEH+i9WAEG43tXvci5CdkptJ8oFgjbdZeusHtkhz3vX1
         J4MD4iB9EuLyfIaf/1xbSEaYp751THRUOHa4r0790PBMqNhTnY2SI8NjYORv9rApSwVT
         +URcteoInj5SXiw9ljLqZPL5qd2z9F+3x4mFXUR8/8VyQNpi5eIlNRZHsxb9u0/0MhBP
         12FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687000032; x=1689592032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhpY0RwqwHbZiwoJYp4Rqo6qZ2feyVpNaQrxVK7a/N0=;
        b=aMZpJGNY/NKykpGP9FUnJfoNp6CZSupyM/DZCunIncUy2eqi9DDbIs71a6fKsJ95T2
         tx672T/NqJtn/zR5eiYXeL3dbYpaAgHJ++A36+O1OIgQd+aFUGZrncLN3ztqRTaiOZZG
         55DNQAMbCm5WJczOWBsHAV1MNQVh5+18VwbJkOydZW2zuw1pybb8KJ7qG+ybBFKe05MZ
         ez3QDVn27tvwO/pPS/Cf4xwSgiuSJL+c7akaNUTDokXF5ZfH5xUak1ljkRBfjYArKZ9R
         jjaKkAf/g6ZXOsb3QUwdIW8VYqM+MIKEIZDZ7war+xEJIL4kqGQ36+F+bmD569hylGPQ
         l3jA==
X-Gm-Message-State: AC+VfDyqeTWxBdIWExdkUxOkNw+bGoJU+I/I5XnKA9CXKkIX8mD5lacn
        M0l6TN4Bgr7kDeUA/UymO2I=
X-Google-Smtp-Source: ACHHUZ6wYJi/XN4fwYyCqPgqdm1gZEcxRI5zLxDY+iLcML4SILlCwH6KeLQXavnBDVPiosBa/92u2Q==
X-Received: by 2002:a05:6a20:3d8f:b0:11d:235f:af93 with SMTP id s15-20020a056a203d8f00b0011d235faf93mr4017155pzi.44.1687000032108;
        Sat, 17 Jun 2023 04:07:12 -0700 (PDT)
Received: from localhost ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b001b526ec4a84sm3320101plh.279.2023.06.17.04.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 04:07:11 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
To:     paulmck@kernel.org
Cc:     joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH] docs/RCU: Bring smp_wmb() back
Date:   Sat, 17 Jun 2023 11:07:06 +0000
Message-Id: <20230617110706.28941-1-mmpgouride@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There are two memory ordering required in the insertion algorithm,
we need wo make obj->key is updated before obj->obj_node.next
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

