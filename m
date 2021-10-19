Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DA1C433EF
	for <rcu@archiver.kernel.org>; Tue, 19 Oct 2021 23:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6E26112D
	for <rcu@archiver.kernel.org>; Tue, 19 Oct 2021 23:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhJSXH2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:07:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49196 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhJSXH2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Oct 2021 19:07:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B58BA21A68;
        Tue, 19 Oct 2021 23:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634684713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=edPWi4QNjr3rGhgEVoIehJJC1w1N/fslMyFCwd0XhfM=;
        b=VwGiTD0AGIXTC/55ntv2s8KP5NKu8YY89uuNotGVGeFr5V0HDznfYe6IliuQJKbalhpLby
        5sKbBdXX9nszxkaG1uEE983xYbE1ajyMPd3SS4bZEdnkXApBBk6s3FfoOuKh2q7m3ekc3q
        HGTqJt+K+FoBha4ev5c8Qg8pQKXm0dU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634684713;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=edPWi4QNjr3rGhgEVoIehJJC1w1N/fslMyFCwd0XhfM=;
        b=qjxRwCWoAFWVUE6ywnIMSU68hCvXB+8fcrooi7klc6/DjfHtuI/dWV019cjjr3NtFNm4oT
        ctmTzTqYD/xeJxCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14F3B13B21;
        Tue, 19 Oct 2021 23:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lWYRLSdPb2FeIQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 19 Oct 2021 23:05:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: Add refcount analogy to What is RCU
Date:   Wed, 20 Oct 2021 10:05:08 +1100
Message-id: <163468470814.17149.17892190693057737430@noble.neil.brown.name>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


The reader-writer-lock analogy is a useful way to think about RCU, but
it is not always applicable.  It is useful to have other analogies to
work with, and particularly to emphasise that no single analogy is
perfect.

This patch adds a "RCU as reference count" to the "what is RCU" document.

See https://lwn.net/Articles/872559/

Signed-off-by: NeilBrown <neilb@suse.de>
---
 Documentation/RCU/whatisRCU.rst | 78 +++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 17e95ab2a201..836b3c0bbf2e 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -872,7 +872,79 @@ be used in place of synchronize_rcu().
 
 .. _7_whatisRCU:
 
-7.  FULL LIST OF RCU APIs
+7.  ANALOGY WITH REFERENCE COUNTING
+-----------------------------------
+
+Many uses of RCU do not look so much like reader-writer locking as
+illustrated by the previous section and so it can be helpful to have
+other analogies to draw on.  One such analogy involves thinking of its
+behaviour as similar to reference counting: RCU effectively provides a
+temporary protected reference on "everything".
+
+A reference count typically does not prevent the referenced object from
+changes to values, but does prevent changes to type - particularly the
+gross change of type that happens when the memory used to store the
+object is freed and reclaimed for some other purpose.  Once a
+type-safe reference to the object is obtained some other mechanism is
+needed to ensure consistent access to the data in the object.  This
+could involve taking a spinlock, but with RCU the typical approach is to
+perform reads with SMP-aware operations such as smp_load_acquire(), to
+perform updates with atomic read-modify-write operations, and to be
+careful of ordering the operations.  RCU provides a number of support
+functions that embedded the required operations and ordering, such as the
+list_for_each_entry_rcu() in the example of the previous section.
+
+A more precise statement of the reference counting behaviour is that,
+between rcu_read_lock() and rcu_read_unlock(), any reference taken with
+rcu_dereference() on a pointer marked as ``__rcu`` can be treated as
+though a reference-count on that object has been temporarily increased.
+This prevents the object from changing type.  Exactly what this means
+will depend on normal expectations of objects of that type, but it
+typically includes that spinlocks can still be safely locked, normal
+reference counters can be safely manipulated, and ``__rcu`` pointers can
+be safely dereferenced.
+
+Some operations that one might expect to see on an object for
+which an RCU reference is held include:
+ - copying out data that is guaranteed to be stable by the type of the
+   object.
+ - Using kref_get_unless_zero() or similar to get a longer-term 
+   reference.  This may fail of course.
+ - Claiming a spinlock in the object, and checking if the object still
+   is the expected object and if so, manipulating it freely.
+
+The understanding that RCU provides a reference that only prevents a
+change of type is particularly visible with objects allocated from a
+slab cache marked SLAB_TYPESAFE_BY_RCU.  RCU operations may yield a
+reference to and object from such a cache that has been concurrently
+freed and reallocated to a completely different object, though of the
+same type.  In this case RCU doesn't even protect the identity of the
+object from changing, only its type.  So the object found may not be the
+one expected, but it will be one where it is safe to take a reference or
+spinlock and then confirm that the identity matches the expectations.
+
+With traditional reference counting - such as that implemented by the
+kref library in Linux - there is typically code that runs when the last
+reference to an object is dropped.  With kref, this is the function
+passed to kref_put().  When RCU is being used such finalization code
+must not be run until all ``__rcu`` pointers referencing the object have
+been updated, and then a grace period has passed.  Every remaining
+globally visible pointer to the object must be considered to be a
+potential counted reference, and the finalization code it typically run
+using call_rcu() only after all those pointers have been changed.
+
+To see how to choose between there two analogies - of RCU as a
+reader-writer lock and RCU as a reference counting system - it is useful
+to reflect on the scale of the thing being protected.  The reader-writer
+lock analogy looks at larger multi-part objects such as a linked list
+and shows how RCU can facilitate concurrency while elements are add to,
+and removed from, the list.  The reference-count analogy looks at the
+individual objects and looks at how they can be accessed safely within
+whatever whole they are a part of.
+
+.. _8_whatisRCU:
+
+8.  FULL LIST OF RCU APIs
 -------------------------
 
 The RCU APIs are documented in docbook-format header comments in the
@@ -1035,9 +1107,9 @@ g.	Otherwise, use RCU.
 Of course, this all assumes that you have determined that RCU is in fact
 the right tool for your job.
 
-.. _8_whatisRCU:
+.. _9_whatisRCU:
 
-8.  ANSWERS TO QUICK QUIZZES
+9.  ANSWERS TO QUICK QUIZZES
 ----------------------------
 
 Quick Quiz #1:
-- 
2.33.1

