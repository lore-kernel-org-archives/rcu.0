Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D39EB64D9
	for <rcu@archiver.kernel.org>; Thu,  6 Jul 2023 10:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjGFK3h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 6 Jul 2023 06:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjGFK3h (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 6 Jul 2023 06:29:37 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D41BD4;
        Thu,  6 Jul 2023 03:29:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6689430d803so359431b3a.0;
        Thu, 06 Jul 2023 03:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688639370; x=1691231370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXa/kRvaivKsZJZ49tsL8TqteMRykn/WK5NqJztc71Y=;
        b=llwTDWRS9JBUk6c7OcaMj4IvgMMFXCbhfdRIINelHzV0KP8UPCOziMrQ3casKnc4TW
         N6OQzRG0YqY7tT6GAPjF//gFR61B6wjnXCSnKqFY5ngsbcj23WYHboexvMPNbEy+3G4O
         zWR4sgv+Dycp72mBDw2msFKFbFCGs2GTmQQPv2sI8NCCt/KKjNkYmvFG3lwmVU2HSMDi
         WmTNOtlMtEkalkyCd485YwZFItqvPRoaDULzqed1uholrRCpkjEYBEBa6snrASHv6ApE
         cIan3TOXaXbWn2bHMqAvdnv3i7dMkUneLW7/kqWZG7O2PAbD5PXUmoZBFCO/hOmXTtMZ
         Nx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688639370; x=1691231370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXa/kRvaivKsZJZ49tsL8TqteMRykn/WK5NqJztc71Y=;
        b=EQ5IxC2IhAOq6Ht1qNGdyS2mf2JP1r6+1kVABzj0RqJ2N1sCSPTIsVh4PAN96dKQiZ
         AfGWY2feo9n8xYLMJb2m4ya9K4TZxzZ6R59XBKXTj2kLquYfMreTu96d9oOUyF5oM2d+
         XEsRhwOdfJCy3gExxWHFI58ONSx2yU0WlhA4P6aaPXaRZbVLo7i6J7SmLuCxSmrFoAG4
         B2VddGhi6IdjCRt5FRWmDyzMk8th//hN1R/wt9EdwFu5WceeVVXWXJfpCsfiuzvBHQlK
         NmbaT6e3dJIXtNMCB+LODG4IvSJOYrD9v7AspkLfRXYkmkWwwDPZMwo+oucjZRoVnm28
         tWNg==
X-Gm-Message-State: ABy/qLYohNQ5TkTDIqJrW7rkYxJw31BcNtKktPk3TkR3hwXKthWt4U9Q
        dyNInkZmoQv+IjlCBtutOyI=
X-Google-Smtp-Source: APBJJlH6rwCxUvgQcUF8OulBWj+asdlkhdqjegBBwX3eqsbhb8l3eL8LS58+a1EA9RUpcs3cI2fatA==
X-Received: by 2002:a05:6a00:1a89:b0:682:562a:39ae with SMTP id e9-20020a056a001a8900b00682562a39aemr1176651pfv.32.1688639369627;
        Thu, 06 Jul 2023 03:29:29 -0700 (PDT)
Received: from localhost ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b00663ab37ff74sm994162pfn.72.2023.07.06.03.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 03:29:29 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, corbet@lwn.net
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH 2/2] docs/RCU: Bring back smp_wmb()
Date:   Thu,  6 Jul 2023 10:28:49 +0000
Message-Id: <20230706102849.437687-3-mmpgouride@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706102849.437687-1-mmpgouride@gmail.com>
References: <20230706102849.437687-1-mmpgouride@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The objects are allocated with SLAB_TYPESAFE_BY_RCU, and there is
n->next = first within hlist_add_head_rcu() before rcu_assign_pointer(),
which modifies obj->obj_node.next. There may be readers holding the
reference of obj in lockless_lookup, and when updater modifies ->next,
readers can see the change immediately because of SLAB_TYPESAFE_BY_RCU.

There are two memory ordering required in the insertion algorithm,
we need to make sure obj->key is updated before obj->obj_node.next
and obj->refcnt, atomic_set_release is not enough to provide the
required memory barrier.

Signed-off-by: Alan Huang <mmpgouride@gmail.com>
---
 Documentation/RCU/rculist_nulls.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 21e40fcc08de..fa3729dc7e74 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -64,7 +64,7 @@ but a version with an additional memory barrier (smp_rmb())
   {
     struct hlist_node *node, *next;
     for (pos = rcu_dereference((head)->first);
-         pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
+         pos && ({ next = READ_ONCE(pos->next); smp_rmb(); prefetch(next); 1; }) &&
          ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
          pos = rcu_dereference(next))
       if (obj->key == key)
@@ -112,7 +112,12 @@ detect the fact that it missed following items in original chain.
   obj = kmem_cache_alloc(...);
   lock_chain(); // typically a spin_lock()
   obj->key = key;
-  atomic_set_release(&obj->refcnt, 1); // key before refcnt
+  /*
+   * We need to make sure obj->key is updated before obj->obj_node.next
+   * and obj->refcnt.
+   */
+  smp_wmb();
+  atomic_set(&obj->refcnt, 1);
   hlist_add_head_rcu(&obj->obj_node, list);
   unlock_chain(); // typically a spin_unlock()
 
-- 
2.34.1

