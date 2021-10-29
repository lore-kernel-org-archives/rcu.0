Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DB9C433F5
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 14:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08FC61175
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 14:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhJ2O71 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhJ2O71 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Oct 2021 10:59:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63FAE610EA;
        Fri, 29 Oct 2021 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635519418;
        bh=HQco0MA/N9ybEMneHr2LWllpRNftupfQhvqVBVmnYOg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KcGd0ru7xdkxwbNNvLy8bweff7HCYHOWBFjlstnd4ipb8AdaTxennufY7juJjEIy9
         5gb2/oR7kQOlpDD7Sxdesme4JH6M1pce9CUBS+Nvz7XcBHwOffy6ETb74pH789csC+
         jBCulNHfVcS5XhKZgg+ImRe1E1Ukjk5f0wSYQFklQxqtNA98eOqC8Z+pmcfvZBB/fB
         FLtkoDZ6yyr4rmRRtXadXrDgcljJ4FpFyTxfAJbWmGVMMXY2GyF09xMLGWkxL1+RAd
         eKOLWlAGzVXpF9/Q2M6YdaYPMukKOybtxlMkocrnGGI07lxGx0bd8oacQoB0zvz0jP
         DY5MSgFHf5kdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A71605C051B; Fri, 29 Oct 2021 07:56:57 -0700 (PDT)
Date:   Fri, 29 Oct 2021 07:56:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     neilb@suse.de, corbet@lwn.net, linux-doc@vger.kernel.org,
        rcu@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v2] Documentation: Add refcount analogy to What is RCU
Message-ID: <20211029145657.GR880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211028190336.GI880162@paulmck-ThinkPad-P17-Gen-1>
 <ac66a5f3-da2a-db13-1e6f-d498108dab95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac66a5f3-da2a-db13-1e6f-d498108dab95@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 29, 2021 at 05:16:45PM +0900, Akira Yokosawa wrote:
> Hi Paul, Hello Neil,
> 
> Please find inline comments below on minor issues I noticed while
> testing "make htmldocs" on this patch.
> 
> Thu, Thu, 28 Oct 2021 12:03:36 -0700
> Paul E. McKenney wrote:
> > I could not resist the urge to do a small amount of wordsmithing, so
> > please check below in case I messed something up.
> > 
> > 							Thanx, Paul
> > 
> > -------------------------------------------------------------------------
> > 
> > commit 25ce7d081265ce4d29cb2a537a932813df1b7697
> > Author: NeilBrown <neilb@suse.de>
> > Date:   Tue Oct 26 15:53:38 2021 +1100
> > 
> >     Documentation: Add refcount analogy to What is RCU
> >     
> >     The reader-writer-lock analogy is a useful way to think about RCU, but
> >     it is not always applicable.  It is useful to have other analogies to
> >     work with, and particularly to emphasise that no single analogy is
>                                      emphasize

This is the proper Commonwealth spelling, last I knew, Neil lived in
Australia, and we do have a fair number of them, so I will let this
one be.  But yes, in perfbook, I would correct it.  ;-)

> >     perfect.
> >     
> >     This patch add a "RCU as reference count" to the "what is RCU" document.
> >     
> >     See https://lwn.net/Articles/872559/
> >     
> >     Signed-off-by: NeilBrown <neilb@suse.de>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> > index 17e95ab2a201..798f92c050cc 100644
> > --- a/Documentation/RCU/whatisRCU.rst
> > +++ b/Documentation/RCU/whatisRCU.rst
> > @@ -39,9 +39,11 @@ different paths, as follows:
> >  
> >  :ref:`6.	ANALOGY WITH READER-WRITER LOCKING <6_whatisRCU>`
> >  
> > -:ref:`7.	FULL LIST OF RCU APIs <7_whatisRCU>`
> > +:ref:`7.	ANALOGY WITH REFERENCE COUNTING <7_whatisRCU>'                                                             `  (:ref:`...`)

I confess .rst confusion.  I am not sure what this string is supposed
to replace nor what the "..." is supposed to be.  So could you please
send me a fixup patch for this change so that I can squash that patch
into Neil's original?

> > -:ref:`8.	ANSWERS TO QUICK QUIZZES <8_whatisRCU>`
> > +:ref:`8.	FULL LIST OF RCU APIs <8_whatisRCU>`
> > +
> > +:ref:`9.	ANSWERS TO QUICK QUIZZES <9_whatisRCU>`
> >  
> >  People who prefer starting with a conceptual overview should focus on
> >  Section 1, though most readers will profit by reading this section at
> > @@ -677,7 +679,7 @@ Quick Quiz #1:
> >  		occur when using this algorithm in a real-world Linux
> >  		kernel?  How could this deadlock be avoided?
> >  
> > -:ref:`Answers to Quick Quiz <8_whatisRCU>`
> > +:ref:`Answers to Quick Quiz <9_whatisRCU>`
> >  
> >  5B.  "TOY" EXAMPLE #2: CLASSIC RCU
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > @@ -732,7 +734,7 @@ Quick Quiz #2:
> >  		Give an example where Classic RCU's read-side
> >  		overhead is **negative**.
> >  
> > -:ref:`Answers to Quick Quiz <8_whatisRCU>`
> > +:ref:`Answers to Quick Quiz <9_whatisRCU>`
> >  
> >  .. _quiz_3:
> >  
> > @@ -741,7 +743,7 @@ Quick Quiz #3:
> >  		critical section, what the heck do you do in
> >  		CONFIG_PREEMPT_RT, where normal spinlocks can block???
> >  
> > -:ref:`Answers to Quick Quiz <8_whatisRCU>`
> > +:ref:`Answers to Quick Quiz <9_whatisRCU>`
> >  
> >  .. _6_whatisRCU:
> >  
> > @@ -872,7 +874,78 @@ be used in place of synchronize_rcu().
> >  
> >  .. _7_whatisRCU:
> >  
> > -7.  FULL LIST OF RCU APIs
> > +7.  ANALOGY WITH REFERENCE COUNTING
> > +-----------------------------------
> > +
> > +The reader-writer analogy (illustrated by the previous section) is not
> > +always the best way to think about using RCU.  Another helpful analogy
> > +considers RCU a effective reference count on everything which is protected
>                  an

Good catch, fixed!

> > +by RCU.
> > +
> > +A reference count typically does not prevent the referenced object's
> > +values from changing, but does prevent changes to type - particularly the
>                                                           -- (convention in this doc)

Fixed this as well, thank you!

> > +gross change of type that happens when that object's memory is freed and
> > +re-allocated for some other purpose.  Once a type-safe reference to the
> > +object is obtained, some other mechanism is needed to ensure consistent
> > +access to the data in the object.  This could involve taking a spinlock,
> > +but with RCU the typical approach is to perform reads with SMP-aware
> > +operations such as smp_load_acquire(), to perform updates with atomic
> > +read-modify-write operations, and to provide the necessary ordering.
> > +RCU provides a number of support functions that embed the required
> > +operations and ordering, such as the list_for_each_entry_rcu() macro
> > +used in the previous section.
> > +
> > +A more focused view of the reference counting behaviour is that,
>                                                  behavior (American spelling)

This one I did change.  Neil owns the commit log, but yes, the file
should be consistent.

> > +between rcu_read_lock() and rcu_read_unlock(), any reference taken with
> > +rcu_dereference() on a pointer marked as ``__rcu`` can be treated as
> > +though a reference-count on that object has been temporarily increased.
> > +This prevents the object from changing type.  Exactly what this means
> > +will depend on normal expectations of objects of that type, but it
> > +typically includes that spinlocks can still be safely locked, normal
> > +reference counters can be safely manipulated, and ``__rcu`` pointers
> > +can be safely dereferenced.
> > +
> > +Some operations that one might expect to see on an object for
> > +which an RCU reference is held include:
> 
> Without an empty line here, "make htmldocs" will complain. 

Fixed, thank you!

> > + - Copying out data that is guaranteed to be stable by the object's type.
> > + - Using kref_get_unless_zero() or similar to get a longer-term
> > +   reference.  This may fail of course.
> > + - Acquiring a spinlock in the object, and checking if the object still
> > +   is the expected object and if so, manipulating it freely.
> > +
> > +The understanding that RCU provides a reference that only prevents a
> > +change of type is particularly visible with objects allocated from a
> > +slab cache marked ``SLAB_TYPESAFE_BY_RCU``.  RCU operations may yield a
> > +reference to an object from such a cache that has been concurrently
> > +freed and the memory reallocated to a completely different object,
> > +though of the same type.  In this case RCU doesn't even protect the
> > +identity of the object from changing, only its type.  So the object
> > +found may not be the one expected, but it will be one where it is safe
> > +to take a reference or spinlock and then confirm that the identity
> > +matches the expectations.
> > +
> > +With traditional reference counting - such as that implemented by the
>                                        --

Fixed " - " globally, other than the bulleted list, thank you!

> > +kref library in Linux - there is typically code that runs when the last
>                          --
> 
> > +reference to an object is dropped.  With kref, this is the function
> > +passed to kref_put().  When RCU is being used such finalization code
>                           When RCU is being used, such finalization code

This one could be argued, but the extra comma helps.

> > +must not be run until all ``__rcu`` pointers referencing the object have
> > +been updated, and then a grace period has passed.  Every remaining
> > +globally visible pointer to the object must be considered to be a
> > +potential counted reference, and the finalization code it typically run
>                                                           is (???)

Looks that way to me, fixed.

> > +using call_rcu() only after all those pointers have been changed.
> > +
> > +To see how to choose between there two analogies - of RCU as a
>                                 these               --

Good eyes, fixed!

> > +reader-writer lock and RCU as a reference counting system - it is useful
>                                                              --
> 
> > +to reflect on the scale of the thing being protected.  The reader-writer
> > +lock analogy looks at larger multi-part objects such as a linked list
> > +and shows how RCU can facilitate concurrency while elements are added
> > +to, and removed from, the list.  The reference-count analogy looks at
> > +the individual objects and looks at how they can be accessed safely
> > +within whatever whole they are a part of.
> 
> Hope this helps.
> 
> With these comments addressed, please feel free to add:
> 
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

I have a squash commit pending.  Please send me a patch for the
table-of-contents ":ref:" change.  And it looks like I should make
another try at getting "make htmldocs" running again...

							Thanx, Paul

>        Thanks, Akira
> 
> > +
> > +.. _8_whatisRCU:
> > +
> > +8.  FULL LIST OF RCU APIs
> >  -------------------------
> >  
> >  The RCU APIs are documented in docbook-format header comments in the
> > @@ -1035,9 +1108,9 @@ g.	Otherwise, use RCU.
> >  Of course, this all assumes that you have determined that RCU is in fact
> >  the right tool for your job.
> >  
> > -.. _8_whatisRCU:
> > +.. _9_whatisRCU:
> >  
> > -8.  ANSWERS TO QUICK QUIZZES
> > +9.  ANSWERS TO QUICK QUIZZES
> >  ----------------------------
> >  
> >  Quick Quiz #1:
> 
