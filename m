Return-Path: <SRS0=5+Ir=4P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B11C35E1C
	for <rcu@archiver.kernel.org>; Thu, 27 Feb 2020 18:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32173246A1
	for <rcu@archiver.kernel.org>; Thu, 27 Feb 2020 18:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGpGyAnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbgB0SDn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:03:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37468 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB0SDm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 27 Feb 2020 13:03:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so217696pfn.4;
        Thu, 27 Feb 2020 10:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yo/6zTJwv1CEgXTNldxHhJmkmbn3jw4xocyTMxdbW40=;
        b=KGpGyAnTK7rs3wkQoSfsVkApE02Kn4qslahJwDNmhj+YjsVp3bys8IUIlOrMPRwvXK
         idRcfRcI4P3Bhvu63ao+EypufA4jkbDecWgqfCLs1QkqdKY69z1ykouP9txpg50m3e0C
         VGZzIlpNzBsd9zrIZsalSs2R4ZLbZEIEwqAfO0WZ+GzDi+pXOy1R1XIIcWQKxSOsT8rr
         cQdXgPjZT0iiRkelirNBT8QRMX8FEZgfA0Yf9LUwCzV/cR2TILVtYXpDB2MMo50T9r2r
         b3gCc9fE1RDhTBX+H6ECSCtCswweFKt9FdhwZBzyZU24l6CXicfqRXCmmXqGDjUPf7vk
         +ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yo/6zTJwv1CEgXTNldxHhJmkmbn3jw4xocyTMxdbW40=;
        b=BU1zuBg10CJkXZRpqZa78pO3qjlEAJK2IBeWKlY++7kSfr/tHALBIhzIQOVc6ukYsk
         2S/A1nY9ekBQG3zDYsQKIjplEO6Dy8/o8nKU1kWBFQoVfQhdlWXkkWrOObL07va0mY86
         syXnh99KMfo0L4CY/Q9FIAFVnt/qFC0/SlBPl+hoppm+x+u2E2WhXjRDCVD2MRyn9g4d
         Wj5LmSFyFdL8Z+OIoK7YhNTNO8lHjg4uLyOv5YNYePvAcb7yxQ4k6DH0t1fAwL/9Ddlt
         rcJJru4JF5GteRsyCwk0/ReC/68HQZoHzOMZRnHojiwyOax1R4nRBvUINhH1nud7lwB1
         Y9XA==
X-Gm-Message-State: APjAAAXPyspme5HESO9tMAe3vIafDFTjCACk/u2k13fkDJEApU8JRBeB
        nwAKfPGpMfHoOvSQinHzUT8=
X-Google-Smtp-Source: APXvYqwMsjN6cqxmneTfLyh2DCmz7nyUHSU1f/AoBHJhMFNypdcxOGCxAiM0YnmuOA5HUamGl9ZGtA==
X-Received: by 2002:a62:1b4f:: with SMTP id b76mr161859pfb.163.1582826620389;
        Thu, 27 Feb 2020 10:03:40 -0800 (PST)
Received: from localhost.localdomain ([103.46.201.58])
        by smtp.gmail.com with ESMTPSA id m71sm9312579pje.0.2020.02.27.10.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:03:39 -0800 (PST)
From:   Aman Sharma <amanharitsh123@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        amanharitsh123@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH v2] doc: Convert rculist_nulls.txt to rculist_nulls.rst
Date:   Thu, 27 Feb 2020 23:33:11 +0530
Message-Id: <20200227180314.14211-1-amanharitsh123@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This patch converts rculist_nulls from .txt to .rst format, and also adds
it to the index.rst file.

Major changes includes:
1) Addition of section headers and subsection headers.
2) Addition of literal blocks which contains all the codes.
3) Making enumerated list item by changing X) to X. where X is number
   like 1,2,3 etc.2) Addition of literal blocks which contains all the
codes.

Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
---
 Documentation/RCU/index.rst         |   1 +
 Documentation/RCU/rculist_nulls.rst | 179 ++++++++++++++++++++++++++++
 Documentation/RCU/rculist_nulls.txt | 172 --------------------------
 3 files changed, 180 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/RCU/rculist_nulls.rst
 delete mode 100644 Documentation/RCU/rculist_nulls.txt

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index d60eb4ba2cd0..2cf55bd141b3 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -10,6 +10,7 @@ RCU concepts
    arrayRCU
    rcubarrier
    rcu_dereference
+   rculist_nulls
    checklist
    whatisRCU
    rcu
diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
new file mode 100644
index 000000000000..8e04de44fe3d
--- /dev/null
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -0,0 +1,179 @@
+.. _rculist_nulls_doc:
+
+Using hlist_nulls to protect read-mostly linked lists and objects using SLAB_TYPESAFE_BY_RCU allocations.
+=========================================================================================================
+
+Please read the basics in Documentation/RCU/listRCU.rst
+
+Using special makers (called 'nulls') is a convenient way
+to solve following problem :
+
+A typical RCU linked list managing objects which are
+allocated with SLAB_TYPESAFE_BY_RCU kmem_cache can
+use following algos :
+
+1. Lookup algo
+--------------
+::
+
+   rcu_read_lock()
+   begin:
+   obj = lockless_lookup(key);
+   if (obj) {
+   if (!try_get_ref(obj)) // might fail for free objects
+      goto begin;
+   /*
+      * Because a writer could delete object, and a writer could
+      * reuse these object before the RCU grace period, we
+      * must check key after getting the reference on object
+      */
+   if (obj->key != key) { // not the object we expected
+      put_ref(obj);
+      goto begin;
+      }
+   }
+   rcu_read_unlock();
+
+Beware that lockless_lookup(key) cannot use traditional hlist_for_each_entry_rcu()
+but a version with an additional memory barrier (smp_rmb()) ::
+
+   lockless_lookup(key)
+   {
+      struct hlist_node *node, *next;
+      for (pos = rcu_dereference((head)->first);
+            pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
+            ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
+            pos = rcu_dereference(next))
+         if (obj->key == key)
+            return obj;
+      return NULL;
+
+And note the traditional hlist_for_each_entry_rcu() misses this smp_rmb() ::
+
+   struct hlist_node *node;
+   for (pos = rcu_dereference((head)->first);
+		pos && ({ prefetch(pos->next); 1; }) &&
+		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
+		pos = rcu_dereference(pos->next))
+      if (obj->key == key)
+         return obj;
+   return NULL;
+}
+
+Quoting Corey Minyard :
+
+"If the object is moved from one list to another list in-between the
+ time the hash is calculated and the next field is accessed, and the
+ object has moved to the end of a new list, the traversal will not
+ complete properly on the list it should have, since the object will
+ be on the end of the new list and there's not a way to tell it's on a
+ new list and restart the list traversal.  I think that this can be
+ solved by pre-fetching the "next" field (with proper barriers) before
+ checking the key."
+
+2. Insert algo
+----------------
+
+We need to make sure a reader cannot read the new 'obj->obj_next' value
+and previous value of 'obj->key'. Or else, an item could be deleted
+from a chain, and inserted into another chain. If new chain was empty
+before the move, 'next' pointer is NULL, and lockless reader can
+not detect it missed following items in original chain ::
+
+   /*
+   * Please note that new inserts are done at the head of list,
+   * not in the middle or end.
+   */
+   obj = kmem_cache_alloc(...);
+   lock_chain(); // typically a spin_lock()
+   obj->key = key;
+   /*
+   * we need to make sure obj->key is updated before obj->next
+   * or obj->refcnt
+   */
+   smp_wmb();
+   atomic_set(&obj->refcnt, 1);
+   hlist_add_head_rcu(&obj->obj_node, list);
+   unlock_chain(); // typically a spin_unlock()
+
+
+3. Remove algo
+--------------
+Nothing special here, we can use a standard RCU hlist deletion.
+But thanks to SLAB_TYPESAFE_BY_RCU, beware a deleted object can be reused
+very very fast (before the end of RCU grace period) ::
+
+   if (put_last_reference_on(obj) {
+      lock_chain(); // typically a spin_lock()
+      hlist_del_init_rcu(&obj->obj_node);
+      unlock_chain(); // typically a spin_unlock()
+      kmem_cache_free(cachep, obj);
+   }
+
+
+
+With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup()
+and extra smp_wmb() in insert function.
+
+For example, if we choose to store the slot number as the 'nulls'
+end-of-list marker for each slot of the hash table, we can detect
+a race (some writer did a delete and/or a move of an object
+to another chain) checking the final 'nulls' value if
+the lookup met the end of chain. If final 'nulls' value
+is not the slot number, then we must restart the lookup at
+the beginning. If the object was moved to the same chain,
+then the reader doesn't care : It might eventually
+scan the list again without harm.
+
+
+1. lookup algo
+--------------
+::
+
+   head = &table[slot];
+   rcu_read_lock();
+   begin:
+   hlist_nulls_for_each_entry_rcu(obj, node, head, member) {
+      if (obj->key == key) {
+         if (!try_get_ref(obj)) // might fail for free objects
+            goto begin;
+         if (obj->key != key) { // not the object we expected
+            put_ref(obj);
+            goto begin;
+         }
+   goto out;
+   }
+   /*
+   * if the nulls value we got at the end of this lookup is
+   * not the expected one, we must restart lookup.
+   * We probably met an item that was moved to another chain.
+   */
+   if (get_nulls_value(node) != slot)
+      goto begin;
+   obj = NULL;
+
+   out:
+   rcu_read_unlock();
+
+2. Insert function
+------------------
+
+::
+
+   /*
+   * Please note that new inserts are done at the head of list,
+   * not in the middle or end.
+   */
+   obj = kmem_cache_alloc(cachep);
+   lock_chain(); // typically a spin_lock()
+   obj->key = key;
+   /*
+   * changes to obj->key must be visible before refcnt one
+   */
+   smp_wmb();
+   atomic_set(&obj->refcnt, 1);
+   /*
+   * insert obj in RCU way (readers might be traversing chain)
+   */
+   hlist_nulls_add_head_rcu(&obj->obj_node, list);
+   unlock_chain(); // typically a spin_unlock()
diff --git a/Documentation/RCU/rculist_nulls.txt b/Documentation/RCU/rculist_nulls.txt
deleted file mode 100644
index 23f115dc87cf..000000000000
--- a/Documentation/RCU/rculist_nulls.txt
+++ /dev/null
@@ -1,172 +0,0 @@
-Using hlist_nulls to protect read-mostly linked lists and
-objects using SLAB_TYPESAFE_BY_RCU allocations.
-
-Please read the basics in Documentation/RCU/listRCU.rst
-
-Using special makers (called 'nulls') is a convenient way
-to solve following problem :
-
-A typical RCU linked list managing objects which are
-allocated with SLAB_TYPESAFE_BY_RCU kmem_cache can
-use following algos :
-
-1) Lookup algo
---------------
-rcu_read_lock()
-begin:
-obj = lockless_lookup(key);
-if (obj) {
-  if (!try_get_ref(obj)) // might fail for free objects
-    goto begin;
-  /*
-   * Because a writer could delete object, and a writer could
-   * reuse these object before the RCU grace period, we
-   * must check key after getting the reference on object
-   */
-  if (obj->key != key) { // not the object we expected
-     put_ref(obj);
-     goto begin;
-   }
-}
-rcu_read_unlock();
-
-Beware that lockless_lookup(key) cannot use traditional hlist_for_each_entry_rcu()
-but a version with an additional memory barrier (smp_rmb())
-
-lockless_lookup(key)
-{
-   struct hlist_node *node, *next;
-   for (pos = rcu_dereference((head)->first);
-          pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
-          ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
-          pos = rcu_dereference(next))
-      if (obj->key == key)
-         return obj;
-   return NULL;
-
-And note the traditional hlist_for_each_entry_rcu() misses this smp_rmb() :
-
-   struct hlist_node *node;
-   for (pos = rcu_dereference((head)->first);
-		pos && ({ prefetch(pos->next); 1; }) &&
-		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
-		pos = rcu_dereference(pos->next))
-      if (obj->key == key)
-         return obj;
-   return NULL;
-}
-
-Quoting Corey Minyard :
-
-"If the object is moved from one list to another list in-between the
- time the hash is calculated and the next field is accessed, and the
- object has moved to the end of a new list, the traversal will not
- complete properly on the list it should have, since the object will
- be on the end of the new list and there's not a way to tell it's on a
- new list and restart the list traversal.  I think that this can be
- solved by pre-fetching the "next" field (with proper barriers) before
- checking the key."
-
-2) Insert algo :
-----------------
-
-We need to make sure a reader cannot read the new 'obj->obj_next' value
-and previous value of 'obj->key'. Or else, an item could be deleted
-from a chain, and inserted into another chain. If new chain was empty
-before the move, 'next' pointer is NULL, and lockless reader can
-not detect it missed following items in original chain.
-
-/*
- * Please note that new inserts are done at the head of list,
- * not in the middle or end.
- */
-obj = kmem_cache_alloc(...);
-lock_chain(); // typically a spin_lock()
-obj->key = key;
-/*
- * we need to make sure obj->key is updated before obj->next
- * or obj->refcnt
- */
-smp_wmb();
-atomic_set(&obj->refcnt, 1);
-hlist_add_head_rcu(&obj->obj_node, list);
-unlock_chain(); // typically a spin_unlock()
-
-
-3) Remove algo
---------------
-Nothing special here, we can use a standard RCU hlist deletion.
-But thanks to SLAB_TYPESAFE_BY_RCU, beware a deleted object can be reused
-very very fast (before the end of RCU grace period)
-
-if (put_last_reference_on(obj) {
-   lock_chain(); // typically a spin_lock()
-   hlist_del_init_rcu(&obj->obj_node);
-   unlock_chain(); // typically a spin_unlock()
-   kmem_cache_free(cachep, obj);
-}
-
-
-
---------------------------------------------------------------------------
-With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup()
-and extra smp_wmb() in insert function.
-
-For example, if we choose to store the slot number as the 'nulls'
-end-of-list marker for each slot of the hash table, we can detect
-a race (some writer did a delete and/or a move of an object
-to another chain) checking the final 'nulls' value if
-the lookup met the end of chain. If final 'nulls' value
-is not the slot number, then we must restart the lookup at
-the beginning. If the object was moved to the same chain,
-then the reader doesn't care : It might eventually
-scan the list again without harm.
-
-
-1) lookup algo
-
- head = &table[slot];
- rcu_read_lock();
-begin:
- hlist_nulls_for_each_entry_rcu(obj, node, head, member) {
-   if (obj->key == key) {
-      if (!try_get_ref(obj)) // might fail for free objects
-         goto begin;
-      if (obj->key != key) { // not the object we expected
-         put_ref(obj);
-         goto begin;
-      }
-  goto out;
- }
-/*
- * if the nulls value we got at the end of this lookup is
- * not the expected one, we must restart lookup.
- * We probably met an item that was moved to another chain.
- */
- if (get_nulls_value(node) != slot)
-   goto begin;
- obj = NULL;
-
-out:
- rcu_read_unlock();
-
-2) Insert function :
---------------------
-
-/*
- * Please note that new inserts are done at the head of list,
- * not in the middle or end.
- */
-obj = kmem_cache_alloc(cachep);
-lock_chain(); // typically a spin_lock()
-obj->key = key;
-/*
- * changes to obj->key must be visible before refcnt one
- */
-smp_wmb();
-atomic_set(&obj->refcnt, 1);
-/*
- * insert obj in RCU way (readers might be traversing chain)
- */
-hlist_nulls_add_head_rcu(&obj->obj_node, list);
-unlock_chain(); // typically a spin_unlock()
-- 
2.20.1

