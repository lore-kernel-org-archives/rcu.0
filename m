Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1270CC8;
	Tue, 26 Mar 2024 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457078; cv=none; b=TuWwnEaHlOLM2QYxtH6hsFFhoDnEJZGFfF2uxsizq2PDXaQ8b+F/2Vqp+tm/JMMkBn9gNScBr49t0rfHIlcrLn6Dpow+euldWKAoxURD4mBy9/xrPeglfSzTFh+14Z7dZYLvjc5iEJ0tqFXNq2LHHa0uRa2CbMKYUOKeyszWJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457078; c=relaxed/simple;
	bh=yLArL6EzQjD6rN2Aj7zC8Mt5ZkKc5FSEg4+GU5NkICA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HCGM17o6QARkk9vcfsT/xIrZ/4fyG0wV68REtlRA6Fijvp81snzIQuldlJ0Bc2IXCiitzFP2VzzWYveF01ZCIHzww4aRMpwXVULXzcpxV6AmzAkqBXtBSmcXKbK+hYrXT+WuqpN0GikHCCjEU7yQpVFb+0bX+pNEeFBoGLUyiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFsccjEm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFsccjEm"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0025ef1efso34355785ad.1;
        Tue, 26 Mar 2024 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711457076; x=1712061876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=irHeV37wUtDsPRRRODv8UUmG2Zg8XlgC92IuTPtkaec=;
        b=mFsccjEmwRu211kiElKhVA9XlYBwVZOTslsRvfV2/r04fDiLbbzfDCJyx9LcQebwzK
         WlZHrX13u5j+IH65Wr/IYxtHZUqTnxaJp7m7mjoXNWYEW7HV7sBokb6i5HcUnGgsG9zs
         dqxeLTLxoPVcVitsfawd1BQ11HQ5pVDIKxl3+tdF9XQvYKHg4dgflomtZnT3RiNxc00D
         JSOOrnzpOe6n3SsGuCxorzZt4Cjaz7bUy9Lw1rE2kJQKLt3U/GaCQyHbUQxNRHedSc6d
         Q6MwemXw/yTLuutBuBPIn+EkryaKR9K5n7InmXS7aZ4mNglblWxJdveH7kfecVC/+p8X
         OxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711457076; x=1712061876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irHeV37wUtDsPRRRODv8UUmG2Zg8XlgC92IuTPtkaec=;
        b=Y8veOaSVYIEZyLFd/uB0s/A4QqDoMsOk1VX/i2zf9+nd0HUTS11fQ67FnYlMmEWGXX
         q42TDDrmBKoBQT6/sWjLTO7lLlNqojLd3iJvOtqnGSdU4DtJtWCcYRq0nx32uhxJQ+KE
         JJKsIxPCSnFpr2zPH1y6/8wUcA14oC4AxaRIJu57H3o55IijUbLPXbRC12GDkY/aBLqf
         2SgqoloLzVCGEc46CQJoCjkb8Ql6VY9H1bjm6PoDKZ9U+gQqUgwVlFqZ3zjt8k2OitRu
         w2fCIwe0pZXG+kOV511Z5liR350hnD6fQ2RKD7NeLLiB5u4zP5OT10CuVEbHAUSxlu71
         7TMw==
X-Forwarded-Encrypted: i=1; AJvYcCVfWSlaiqM1TiZdynYEfpxSluIjcP+qn0dGwB0xZXflQM4+5KxwF4utxAAXeVGTmhby3Qx2G6S2iRl6Qny5ejE+jUHQFiRDeFCa
X-Gm-Message-State: AOJu0YzTSxWK0p6kjfZ79iCpHptfB1FKcpJ2K9AJ5mSblRMpYyqPjT+3
	F38TVO95bxmSeOrE3xgyXtfq/1EPubO2poWAjlBrNa2kwR17X0re
X-Google-Smtp-Source: AGHT+IEFweVLORfj1rODrrHJga/1xZoO6FFBb47XP0V2dYd+NOJUisWY/6da1T7IjWI+gEr4PfKiIg==
X-Received: by 2002:a17:902:b20d:b0:1e0:a1c2:2697 with SMTP id t13-20020a170902b20d00b001e0a1c22697mr800912plr.22.1711457076002;
        Tue, 26 Mar 2024 05:44:36 -0700 (PDT)
Received: from localhost ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id k20-20020a63f014000000b005d8b89bbf20sm7364102pgh.63.2024.03.26.05.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:44:35 -0700 (PDT)
From: Alan Huang <mmpgouride@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	qiang.zhang1211@gmail.com,
	corbet@lwn.net
Cc: rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH v4] docs/RCU: Bring back smp_wmb()
Date: Tue, 26 Mar 2024 12:44:31 +0000
Message-Id: <20240326124431.77430-1-mmpgouride@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The objects are allocated with SLAB_TYPESAFE_BY_RCU, and there is
n->next = first within hlist_add_head_rcu() before rcu_assign_pointer(),
which modifies obj->obj_node.next. We need to make sure obj->key is
updated before obj->obj_node.next and obj->refcnt, atomic_set_release
is not enough to provide the required memory barrier.

In addition, the example was broken as noted by Paul[1], this patch
also fixes the broken example and includes wording to explain how the
the back-pointer[2] works.

[1] https://lore.kernel.org/all/9eaf506f-cc14-4da6-9efc-057c0c3e56b0@paulmck-laptop/
[2] https://lore.kernel.org/all/02a84e4b-a322-4c43-ad9d-1832ce277c2f@paulmck-laptop/

Signed-off-by: Alan Huang <mmpgouride@gmail.com>
---
Paul, apologies for the long delay :)

Changelog:
 V3 -> V4: Fixes the broken example.
           Add wording to explain how the back-pointer works.
           Remove the _ONCE added before since the access happens after
           we get the reference of the object.

 V2 -> V3: Use compute_slot to detect whether the object has been
           moved. Remove the broken lockless_lookup, use macro instead.

 v1 -> v2: Use _ONCE to protect obj->key.

 Documentation/RCU/rculist_nulls.rst | 149 +++++++++++++++++++++-------
 1 file changed, 113 insertions(+), 36 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 21e40fcc08de..ee1f2458e07e 100644
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
+  obj_for_each_entry_rcu(obj, pos, head, next) {
     if (!try_get_ref(obj)) { // might fail for free objects
       rcu_read_unlock();
       goto begin;
     }
     /*
-    * Because a writer could delete object, and a writer could
-    * reuse these object before the RCU grace period, we
-    * must check key after getting the reference on object
-    */
-    if (obj->key != key) { // not the object we expected
+     * Because a writer could delete object, and a writer could
+     * reuse these object before the RCU grace period, we must check
+     * whether this object has been moved. The smp_wmb() in insertion
+     * algorithm and the smp_rmb() in obj_for_each_entry_rcu() ensure
+     * that if we read the new 'obj->obj_node.next' value, we will also
+     * read the new 'obj->key'.
+     */
+    if (compute_slot(obj->key) != slot) {
       put_ref(obj);
       rcu_read_unlock();
       goto begin;
     }
+    if (obj->key != key) // not the object we expected
+      put_ref(obj);
+    else
+      goto out;
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
 
@@ -140,7 +145,7 @@ very very fast (before the end of RCU grace period)
 Avoiding extra smp_rmb()
 ========================
 
-With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup().
+With hlist_nulls we can avoid extra smp_rmb() in obj_for_each_entry_rcu().
 
 For example, if we choose to store the slot number as the 'nulls'
 end-of-list marker for each slot of the hash table, we can detect
@@ -165,18 +170,14 @@ Note that using hlist_nulls means the type of 'obj_node' field of
   begin:
   rcu_read_lock();
   hlist_nulls_for_each_entry_rcu(obj, node, head, obj_node) {
-    if (obj->key == key) {
-      if (!try_get_ref(obj)) { // might fail for free objects
-	rcu_read_unlock();
-        goto begin;
-      }
-      if (obj->key != key) { // not the object we expected
-        put_ref(obj);
-	rcu_read_unlock();
-        goto begin;
-      }
-      goto out;
+    if (!try_get_ref(obj)) { // might fail for free objects
+      rcu_read_unlock();
+      goto begin;
     }
+    if (obj->key != key) // not the object we expected
+      put_ref(obj);
+    else
+      goto out;
   }
 
   // If the nulls value we got at the end of this lookup is
@@ -213,3 +214,79 @@ hlist_add_head_rcu().
    */
   hlist_nulls_add_head_rcu(&obj->obj_node, list);
   unlock_chain(); // typically a spin_unlock()
+
+
+
+--------------------------------------------------------------------------
+
+Using Back-pointer
+==================
+
+It is possible to detect a move mid-list, which can reduce the search time.
+To achieve this, we store a back-pointer in every element that points to the
+head of its chain. It is worth noting that we can also utilize 'compute_slot'
+to detect this, which involves a tradeoff between time and space.
+
+::
+
+  struct object {
+    struct hlist_nulls_node obj_node;
+    strcut hlist_nulls_head *backptr;
+    atomic_t refcnt;
+    unsigned int key;
+  };
+
+
+1) lookup algorithm
+-------------------
+
+::
+
+  head = &table[slot];
+  begin:
+  rcu_read_lock();
+  hlist_nulls_for_each_entry_rcu(obj, node, head, obj_node) {
+    if (!try_get_ref(obj)) { // might fail for free objects
+      rcu_read_unlock();
+      goto begin;
+    }
+    if (obj->backptr != head) { // object is moved
+      put_ref(obj);
+      rcu_read_unlock();
+      goto begin;
+    }
+    if (obj->key != key) // not the object we expected
+      put_ref(obj);
+    else
+      goto out;
+  }
+
+  if (get_nulls_value(node) != slot) {
+    put_ref(obj);
+    rcu_read_unlock();
+    goto begin;
+  }
+  obj = NULL;
+
+  out:
+  rcu_read_unlock();
+
+2) Insert algorithm
+-------------------
+
+::
+
+  /*
+   * Please note that new inserts are done at the head of list,
+   * not in the middle or end.
+   */
+  obj = kmem_cache_alloc(cachep);
+  lock_chain(); // typically a spin_lock()
+  obj->key = key;
+  obj->backptr = list;
+  atomic_set_release(&obj->refcnt, 1); // key and backptr before refcnt
+  /*
+   * insert obj in RCU way (readers might be traversing chain)
+   */
+  hlist_nulls_add_head_rcu(&obj->obj_node, list);
+  unlock_chain(); // typically a spin_unlock()
\ No newline at end of file
-- 
2.34.1

