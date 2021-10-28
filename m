Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365C1C433EF
	for <rcu@archiver.kernel.org>; Thu, 28 Oct 2021 19:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1573460F38
	for <rcu@archiver.kernel.org>; Thu, 28 Oct 2021 19:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJ1TGF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhJ1TGF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Oct 2021 15:06:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC71661039;
        Thu, 28 Oct 2021 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635447818;
        bh=XFL+IiyK0VxySKVbyojyK6/yEkJccBt+6OjX6dEJ03k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gHjHdfpRW34gcKoUVzXf76psozpX/oq97eZsZ4jwCjkqSzM6fOWtWplVLmgKB0zNq
         VnSqjJBXBTDYvA3698qC5UEf79m+xu3aMs2fr+KZQZKP1vCwyYVseKxF1KrSWoMn/Z
         faWtVLCSQ3SYtamY5Rhshd8Q+sXkPTkpddhaq7FsZ3e/y+8xn23B9zzLNT31bUnq6y
         wMpr/fBKpU6miXHczBe8gnNnx4e7twlPKCyDhO4V7n+uBgPOMrp5AVXAKiL1+j/VzW
         HFff2mVdhek7HW47CHwdENXeFPL2gpF4y1VXKmcPMU1p24jRhVII4tlQ8EPgyTFVgv
         jdE5h2nSL0XSA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C03155C04B3; Thu, 28 Oct 2021 12:03:36 -0700 (PDT)
Date:   Thu, 28 Oct 2021 12:03:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Add refcount analogy to What is RCU
Message-ID: <20211028190336.GI880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <163468470814.17149.17892190693057737430@noble.neil.brown.name>
 <YW9fMt04JqsaComr@casper.infradead.org>
 <163522389176.8576.4035743192114423983@noble.neil.brown.name>
 <163522401820.8576.12018728185388125664@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163522401820.8576.12018728185388125664@noble.neil.brown.name>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 26, 2021 at 03:53:38PM +1100, NeilBrown wrote:
> 
> The reader-writer-lock analogy is a useful way to think about RCU, but
> it is not always applicable.  It is useful to have other analogies to
> work with, and particularly to emphasise that no single analogy is
> perfect.
> 
> This patch add a "RCU as reference count" to the "what is RCU" document.
> 
> See https://lwn.net/Articles/872559/
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Queued and pushed, and thank you all!

I could not resist the urge to do a small amount of wordsmithing, so
please check below in case I messed something up.

							Thanx, Paul

-------------------------------------------------------------------------

commit 25ce7d081265ce4d29cb2a537a932813df1b7697
Author: NeilBrown <neilb@suse.de>
Date:   Tue Oct 26 15:53:38 2021 +1100

    Documentation: Add refcount analogy to What is RCU
    
    The reader-writer-lock analogy is a useful way to think about RCU, but
    it is not always applicable.  It is useful to have other analogies to
    work with, and particularly to emphasise that no single analogy is
    perfect.
    
    This patch add a "RCU as reference count" to the "what is RCU" document.
    
    See https://lwn.net/Articles/872559/
    
    Signed-off-by: NeilBrown <neilb@suse.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 17e95ab2a201..798f92c050cc 100644
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
 
@@ -872,7 +874,78 @@ be used in place of synchronize_rcu().
 
 .. _7_whatisRCU:
 
-7.  FULL LIST OF RCU APIs
+7.  ANALOGY WITH REFERENCE COUNTING
+-----------------------------------
+
+The reader-writer analogy (illustrated by the previous section) is not
+always the best way to think about using RCU.  Another helpful analogy
+considers RCU a effective reference count on everything which is protected
+by RCU.
+
+A reference count typically does not prevent the referenced object's
+values from changing, but does prevent changes to type - particularly the
+gross change of type that happens when that object's memory is freed and
+re-allocated for some other purpose.  Once a type-safe reference to the
+object is obtained, some other mechanism is needed to ensure consistent
+access to the data in the object.  This could involve taking a spinlock,
+but with RCU the typical approach is to perform reads with SMP-aware
+operations such as smp_load_acquire(), to perform updates with atomic
+read-modify-write operations, and to provide the necessary ordering.
+RCU provides a number of support functions that embed the required
+operations and ordering, such as the list_for_each_entry_rcu() macro
+used in the previous section.
+
+A more focused view of the reference counting behaviour is that,
+between rcu_read_lock() and rcu_read_unlock(), any reference taken with
+rcu_dereference() on a pointer marked as ``__rcu`` can be treated as
+though a reference-count on that object has been temporarily increased.
+This prevents the object from changing type.  Exactly what this means
+will depend on normal expectations of objects of that type, but it
+typically includes that spinlocks can still be safely locked, normal
+reference counters can be safely manipulated, and ``__rcu`` pointers
+can be safely dereferenced.
+
+Some operations that one might expect to see on an object for
+which an RCU reference is held include:
+ - Copying out data that is guaranteed to be stable by the object's type.
+ - Using kref_get_unless_zero() or similar to get a longer-term
+   reference.  This may fail of course.
+ - Acquiring a spinlock in the object, and checking if the object still
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
@@ -1035,9 +1108,9 @@ g.	Otherwise, use RCU.
 Of course, this all assumes that you have determined that RCU is in fact
 the right tool for your job.
 
-.. _8_whatisRCU:
+.. _9_whatisRCU:
 
-8.  ANSWERS TO QUICK QUIZZES
+9.  ANSWERS TO QUICK QUIZZES
 ----------------------------
 
 Quick Quiz #1:
