Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25371C433F5
	for <rcu@archiver.kernel.org>; Tue, 26 Oct 2021 04:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C4F61074
	for <rcu@archiver.kernel.org>; Tue, 26 Oct 2021 04:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhJZE4H (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 26 Oct 2021 00:56:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57948 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhJZE4H (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 26 Oct 2021 00:56:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DDD681F770;
        Tue, 26 Oct 2021 04:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635224022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pCDyvfiZkWuACZLR/31VFGx8da5XUd2lnG2lagsKDc=;
        b=KbvBGMzYugy5iDlYeHTF6QTwEWX1kKyKxotP3cUtVPY6OWmhO0tuLwyWxZqsnm+dK+wQKL
        BJb529I0Aq0ni+ov/jJqpccBspA93b2MXt1NXzfazdEzDhv+iD3nnXw/+KngqtzEZ7EPuf
        8BhtjbrBmfcBKgQaiXSBg21u+unTh1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635224022;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pCDyvfiZkWuACZLR/31VFGx8da5XUd2lnG2lagsKDc=;
        b=xK1JX4e6KCCtCpX4pfNwC3wOEHmqKvxppTJNt6oYT1pLcYNoFO6fjceAIvbA676o/iU+oy
        PTUnCMBJLrShQaCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49BFD13B44;
        Tue, 26 Oct 2021 04:53:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RRLjAdWJd2HYDQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Oct 2021 04:53:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2] Documentation: Add refcount analogy to What is RCU
In-reply-to: <163522389176.8576.4035743192114423983@noble.neil.brown.name>
References: <163468470814.17149.17892190693057737430@noble.neil.brown.name>,
 <YW9fMt04JqsaComr@casper.infradead.org>,
 <163522389176.8576.4035743192114423983@noble.neil.brown.name>
Date:   Tue, 26 Oct 2021 15:53:38 +1100
Message-id: <163522401820.8576.12018728185388125664@noble.neil.brown.name>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


The reader-writer-lock analogy is a useful way to think about RCU, but
it is not always applicable.  It is useful to have other analogies to
work with, and particularly to emphasise that no single analogy is
perfect.

This patch add a "RCU as reference count" to the "what is RCU" document.

See https://lwn.net/Articles/872559/

Signed-off-by: NeilBrown <neilb@suse.de>
---
 Documentation/RCU/whatisRCU.rst | 90 ++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 17e95ab2a201..2baa0e4581cf 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -39,9 +39,11 @@ different paths, as follows:
 
 :ref:`6.	ANALOGY WITH READER-WRITER LOCKING <6_whatisRCU>`
 
-:ref:`7.	FULL LIST OF RCU APIs <7_whatisRCU>`
+:ref:`7.	ANALOGY WITH REFERENCE COUNTING <7_whatisRCU>'
 
-:ref:`8.	ANSWERS TO QUICK QUIZZES <8_whatisRCU>`
+:ref:`8.	FULL LIST OF RCU APIs <8_whatisRCU>`
+
+:ref:`9.	ANSWERS TO QUICK QUIZZES <9_whatisRCU>`
 
 People who prefer starting with a conceptual overview should focus on
 Section 1, though most readers will profit by reading this section at
@@ -677,7 +679,7 @@ Quick Quiz #1:
 		occur when using this algorithm in a real-world Linux
 		kernel?  How could this deadlock be avoided?
 
-:ref:`Answers to Quick Quiz <8_whatisRCU>`
+:ref:`Answers to Quick Quiz <9_whatisRCU>`
 
 5B.  "TOY" EXAMPLE #2: CLASSIC RCU
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -732,7 +734,7 @@ Quick Quiz #2:
 		Give an example where Classic RCU's read-side
 		overhead is **negative**.
 
-:ref:`Answers to Quick Quiz <8_whatisRCU>`
+:ref:`Answers to Quick Quiz <9_whatisRCU>`
 
 .. _quiz_3:
 
@@ -741,7 +743,7 @@ Quick Quiz #3:
 		critical section, what the heck do you do in
 		CONFIG_PREEMPT_RT, where normal spinlocks can block???
 
-:ref:`Answers to Quick Quiz <8_whatisRCU>`
+:ref:`Answers to Quick Quiz <9_whatisRCU>`
 
 .. _6_whatisRCU:
 
@@ -872,7 +874,79 @@ be used in place of synchronize_rcu().
 
 .. _7_whatisRCU:
 
-7.  FULL LIST OF RCU APIs
+7.  ANALOGY WITH REFERENCE COUNTING
+-----------------------------------
+
+The reader-writer analogy (illustrated by the previous section) is not
+always the best way to think about using RCU.  Another analogy which
+can be helpful is to consider RCU as providing an effective reference
+count on everything which is protected by RCU.
+
+A reference count typically does not prevent the referenced object from
+changes to values, but does prevent changes to type - particularly the
+gross change of type that happens when the memory used to store the
+object is freed and reclaimed for some other purpose.  Once a type-safe
+reference to the object is obtained, some other mechanism is needed to
+ensure consistent access to the data in the object.  This could involve
+taking a spinlock, but with RCU the typical approach is to perform reads
+with SMP-aware operations such as smp_load_acquire(), to perform updates
+with atomic read-modify-write operations, and to be careful of ordering
+the operations.  RCU provides a number of support functions that embed
+the required operations and ordering, such as
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
+slab cache marked ``SLAB_TYPESAFE_BY_RCU``.  RCU operations may yield a
+reference to an object from such a cache that has been concurrently
+freed and the memory reallocated to a completely different object,
+though of the same type.  In this case RCU doesn't even protect the
+identity of the object from changing, only its type.  So the object
+found may not be the one expected, but it will be one where it is safe
+to take a reference or spinlock and then confirm that the identity
+matches the expectations.
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
+and shows how RCU can facilitate concurrency while elements are added
+to, and removed from, the list.  The reference-count analogy looks at
+the individual objects and looks at how they can be accessed safely
+within whatever whole they are a part of.
+
+.. _8_whatisRCU:
+
+8.  FULL LIST OF RCU APIs
 -------------------------
 
 The RCU APIs are documented in docbook-format header comments in the
@@ -1035,9 +1109,9 @@ g.	Otherwise, use RCU.
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

