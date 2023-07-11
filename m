Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF59EB64DD
	for <rcu@archiver.kernel.org>; Tue, 11 Jul 2023 15:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGKPJ7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Jul 2023 11:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjGKPJp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Jul 2023 11:09:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4425D172C;
        Tue, 11 Jul 2023 08:09:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6686a05bc66so3349957b3a.1;
        Tue, 11 Jul 2023 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689088176; x=1691680176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3erbx8Ek7C3mi08Ez8LVuYLzSHs+cA9FhcR7r2Ld+0w=;
        b=pvyUVlXtrWavcgEIXtrtM71P9zbj5hacUserQfeUqt4Qr7fNz7g9TE9v4GBUo9D7WB
         /AD24XiPw/1+GcR3nNV5Tl65Bg52lIKkTIHjDre1KCL/I4/tjihig4M+ldxE21xt8Jae
         rVcrVPD51H3D7LtNHbk/jkVtzN7FIwe+rHyauIdAHKjLWRyo17Fq0cIOLSP1hI54TBNo
         gNVvtrsrOWZUJXwDIv0H7a+BeKF+RXsnbu7oXcEoN/W6NyVAqLqn1TQLaY4pg3E/DBlz
         fToEL2X9US+xnLY/qQUXNYjoq24f4w5deelblfJiQDnZKHfWQLatYPbvf+df5CaxxeTk
         RmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689088176; x=1691680176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3erbx8Ek7C3mi08Ez8LVuYLzSHs+cA9FhcR7r2Ld+0w=;
        b=mEeY5BikdaH9UyL9y0U5SPwG5ZVstIL6/T2hBf2pbG5DqWEw3iU3PrFck9+z7+KIWQ
         5HBR+nTfAJMsMNNdpYLObnhfryeLVNoyXJEQHQUSC5AAQibVsF7n4BAo14hcFkxbNsSQ
         H8gO8gwjCVCIMXZQTNuLzagPuoAvOXnBnAvldYmtXPHz1Vgd4WKNpOB0JpzyL2XrPhFG
         FVR59mwDs+KNYom87peOP4Qqq65Q81oVknYX6Iutnw1JSQKBdV3DMLlunRnQ2aAG1eoh
         98H8BF5jOeis/LU4oZvp4cIKqoVW+boOHnyPBS7ifqLvr9dChCg5cVY6iB+knM/oZzs+
         4mtw==
X-Gm-Message-State: ABy/qLbl7dtfazvqVXxbIF3r5x6sQcURN5M0OfyYhwEflWq8uv1sxeQ4
        X9EoLEJ6/3wFf2Rifl/HLO8=
X-Google-Smtp-Source: APBJJlF75Wfb6isvNccaAKvO3PJuQZKLoRopLlIWqeqY2LuD+11w4fiyC2buXqLnguTTTriQ9vSCJw==
X-Received: by 2002:a17:902:a60f:b0:1b9:cca6:551b with SMTP id u15-20020a170902a60f00b001b9cca6551bmr7934365plq.7.1689088176414;
        Tue, 11 Jul 2023 08:09:36 -0700 (PDT)
Received: from localhost ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id g12-20020a63ad0c000000b00553d42a7cb5sm1701753pgf.68.2023.07.11.08.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:09:32 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, corbet@lwn.net
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH v2] docs/RCU: Bring back smp_wmb()
Date:   Tue, 11 Jul 2023 15:09:06 +0000
Message-Id: <20230711150906.466434-1-mmpgouride@gmail.com>
X-Mailer: git-send-email 2.34.1
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
Changelog:
  v1 -> v2: Use _ONCE to protect obj->key.

 Documentation/RCU/rculist_nulls.rst | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 21e40fcc08de..2a9f5a63d334 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -47,7 +47,7 @@ objects, which is having below type.
     * reuse these object before the RCU grace period, we
     * must check key after getting the reference on object
     */
-    if (obj->key != key) { // not the object we expected
+    if (READ_ONCE(obj->key) != key) { // not the object we expected
       put_ref(obj);
       rcu_read_unlock();
       goto begin;
@@ -64,10 +64,10 @@ but a version with an additional memory barrier (smp_rmb())
   {
     struct hlist_node *node, *next;
     for (pos = rcu_dereference((head)->first);
-         pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
+         pos && ({ next = READ_ONCE(pos->next); smp_rmb(); prefetch(next); 1; }) &&
          ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
          pos = rcu_dereference(next))
-      if (obj->key == key)
+      if (READ_ONCE(obj->key) == key)
         return obj;
     return NULL;
   }
@@ -111,8 +111,13 @@ detect the fact that it missed following items in original chain.
    */
   obj = kmem_cache_alloc(...);
   lock_chain(); // typically a spin_lock()
-  obj->key = key;
-  atomic_set_release(&obj->refcnt, 1); // key before refcnt
+  WRITE_ONCE(obj->key, key);
+  /*
+   * We need to make sure obj->key is updated before obj->obj_node.next
+   * and obj->refcnt.
+   */
+  smp_wmb();
+  atomic_set(&obj->refcnt, 1);
   hlist_add_head_rcu(&obj->obj_node, list);
   unlock_chain(); // typically a spin_unlock()
 
@@ -165,12 +170,12 @@ Note that using hlist_nulls means the type of 'obj_node' field of
   begin:
   rcu_read_lock();
   hlist_nulls_for_each_entry_rcu(obj, node, head, obj_node) {
-    if (obj->key == key) {
+    if (READ_ONCE(obj->key) == key) {
       if (!try_get_ref(obj)) { // might fail for free objects
 	rcu_read_unlock();
         goto begin;
       }
-      if (obj->key != key) { // not the object we expected
+      if (READ_ONCE(obj->key) != key) { // not the object we expected
         put_ref(obj);
 	rcu_read_unlock();
         goto begin;
@@ -206,7 +211,7 @@ hlist_add_head_rcu().
    */
   obj = kmem_cache_alloc(cachep);
   lock_chain(); // typically a spin_lock()
-  obj->key = key;
+  WRITE_ONCE(obj->key, key);
   atomic_set_release(&obj->refcnt, 1); // key before refcnt
   /*
    * insert obj in RCU way (readers might be traversing chain)
-- 
2.34.1

