Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFDEC001DE
	for <rcu@archiver.kernel.org>; Sat, 15 Jul 2023 10:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGOKjk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 15 Jul 2023 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGOKji (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 15 Jul 2023 06:39:38 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E18535AA;
        Sat, 15 Jul 2023 03:39:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6682909acadso1954541b3a.3;
        Sat, 15 Jul 2023 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689417576; x=1692009576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkkbOsG5a5/O8531sLbibG1Jh/zjE8LtxfebLVzSHEQ=;
        b=RVYs47VBfRzr4yR63PtPKTr8LxYyzLWAm36K0T71CjTOSFeDkmY1FdKDNykLa8diEP
         39lhtO+Qdheoipkz2xdnp/fgJgwJGIBe/MTnA69d785djW+bAPiDXwSe7E/iNkXG6rT+
         /NN08QTp8IyQAH4Vrm1oHAmalS0AFKJBQYyK+A6/SFFJ8/+b9M1L8r8IOHQCE834QUSg
         ZU6IgFGzu7v6C9L4F02JE6TiZhkqE13a2qPIZsEQjx6tWusBPZcU1XlJUf6ciGZa/uFc
         jfYuV8uEam/YB7WFEeg+RGvfEpaaNEK6VvJ+xsETrXhYYUFp+qZnQMzHUyjCPKaXAtS7
         K+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689417576; x=1692009576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkkbOsG5a5/O8531sLbibG1Jh/zjE8LtxfebLVzSHEQ=;
        b=WJNOFG7V4LaJNnJ8nkFvjJjfUE72yq4A6O8KOS5cpgieMzObZgp9RWURejnd02Nhx6
         eq4IQiDMTz0ThpplLOi+RvG7pI0ysJf8ahPx70E2qSft4WQj0ClUMIFiklCAswgeGp81
         pvDYmvz6T8MQQgUAOAGl8tutCn3qbnGyU4MpLWlO1JEwmqdaWYSrefC/tYuWktkr92u+
         TpoRfkVjApLPepmI9feU4jLqhdj5HRXcjKS+3fGzv2WlFWwmdzpvOCppd679+C08CtJh
         qj51Z8azrc5rybpSNHI+HdyJqdDalOusJl9wTc9pt+2Lojueau0kP3PZqePlpRrWJjvG
         bnvw==
X-Gm-Message-State: ABy/qLYtEtmGldlz0YEG/EqtY1g3qbeWj3I31R/vNg6lbRk/crs/7aou
        uv5rEhyGaQ9+JbDiEi+tZh0=
X-Google-Smtp-Source: APBJJlFhDW+2w9DH5WJv6VeHG45E9uq4g+tz5w9EufrX8ox8j57ccn30JZXhOZVek//u3ROyzKHpjQ==
X-Received: by 2002:a05:6a00:a82:b0:643:aa8d:8cd7 with SMTP id b2-20020a056a000a8200b00643aa8d8cd7mr9238053pfl.32.1689417576477;
        Sat, 15 Jul 2023 03:39:36 -0700 (PDT)
Received: from localhost ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id 18-20020aa79212000000b0064fd4a6b306sm8524733pfo.76.2023.07.15.03.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 03:39:36 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, corbet@lwn.net
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH v3] docs/RCU: Bring back smp_wmb()
Date:   Sat, 15 Jul 2023 10:39:22 +0000
Message-Id: <20230715103922.472171-1-mmpgouride@gmail.com>
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

Also use compute_slot to detect whether the object has been moved.

Signed-off-by: Alan Huang <mmpgouride@gmail.com>
---
Changelog:
 V2 -> V3: Use compute_slot to detect whether the object has been
           moved. Remove the broken lockless_lookup, use macro instead.

 v1 -> v2: Use _ONCE to protect obj->key.

 Documentation/RCU/rculist_nulls.rst | 73 +++++++++++++++--------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 21e40fcc08de..9d39394602b0 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -34,54 +34,54 @@ objects, which is having below type.
 
 ::
 
+  object *obj;
+  struct hlist_node *pos, *next;
+  slot = compute_slot(key);
+  head = &table[slot];
   begin:
   rcu_read_lock();
-  obj = lockless_lookup(key);
-  if (obj) {
-    if (!try_get_ref(obj)) { // might fail for free objects
+  obj_for_each_entry_rcu(obj, pos, head, next) {
+    if (compute_slot(READ_ONCE(obj->key)) != slot) { // object is moved
       rcu_read_unlock();
       goto begin;
     }
-    /*
-    * Because a writer could delete object, and a writer could
-    * reuse these object before the RCU grace period, we
-    * must check key after getting the reference on object
-    */
-    if (obj->key != key) { // not the object we expected
-      put_ref(obj);
-      rcu_read_unlock();
-      goto begin;
+    if (READ_ONCE(obj->key) == key) {
+      if (!try_get_ref(obj)) { // might fail for free objects
+        rcu_read_unlock();
+        goto begin;
+      }
+      /*
+      * Because a writer could delete object, and a writer could
+      * reuse these object before the RCU grace period, we
+      * must check key after getting the reference on object
+      */
+      if (READ_ONCE(obj->key) != key) { // not the object we expected
+        put_ref(obj);
+        rcu_read_unlock();
+        goto begin;
+      }
+      goto out;
     }
   }
+  out:
   rcu_read_unlock();
 
-Beware that lockless_lookup(key) cannot use traditional hlist_for_each_entry_rcu()
+Beware that obj_for_each_entry_rcu() cannot use traditional hlist_for_each_entry_rcu()
 but a version with an additional memory barrier (smp_rmb())
 
 ::
 
-  lockless_lookup(key)
-  {
-    struct hlist_node *node, *next;
-    for (pos = rcu_dereference((head)->first);
-         pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
-         ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
-         pos = rcu_dereference(next))
-      if (obj->key == key)
-        return obj;
-    return NULL;
-  }
+  for (pos = rcu_dereference((head)->first);
+       pos && ({ next = READ_ONCE(pos->next); smp_rmb(); prefetch(next); 1; }) &&
+       ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
+       pos = rcu_dereference(next))
 
 And note the traditional hlist_for_each_entry_rcu() misses this smp_rmb()::
 
-  struct hlist_node *node;
   for (pos = rcu_dereference((head)->first);
        pos && ({ prefetch(pos->next); 1; }) &&
        ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
        pos = rcu_dereference(pos->next))
-    if (obj->key == key)
-      return obj;
-  return NULL;
 
 Quoting Corey Minyard::
 
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
 
@@ -140,7 +145,7 @@ very very fast (before the end of RCU grace period)
 Avoiding extra smp_rmb()
 ========================
 
-With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup().
+With hlist_nulls we can avoid extra smp_rmb() in obj_for_each_entry_rcu().
 
 For example, if we choose to store the slot number as the 'nulls'
 end-of-list marker for each slot of the hash table, we can detect
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

