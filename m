Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB064C433F5
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 08:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9DD761151
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 08:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhJ2ITS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Oct 2021 04:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhJ2ITR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Oct 2021 04:19:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC3C061570;
        Fri, 29 Oct 2021 01:16:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p40so3734621pfh.8;
        Fri, 29 Oct 2021 01:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rwHjSY/cIlbtqQVAcWlOBWpWZPSvPDUi4YnTufeOxfE=;
        b=l4xLWYFe6PEoqC2W4ufA+jiyMjUP4+X+IWp+xdudDLruZILvhhpzeQWymqevTrp9ew
         otEciA2p2af+tpHt9LXDJFuFCmhCGL/pUJgv+s9PXXmGQjtYyxxbxGNUz4wWi/kPGG4Z
         l+Ra4bwpJ9n+Cdl4mSkbTdvQXcdxNE1krPoNKvfwOhuJIxSkn2/WCwrXGhXwhAefoBjf
         mQZ3FkP87f/T9bvytKmnBDPCEXSlR21caiNbRU3ly76qYu1r029qCeqwWH2qWlsQEJS+
         UazM4wKCrpQFY+1zTCvYcVJUEh8XdogfUAQ8qsE2ojdscg2J7avWB7teC8tpNPYZlUnh
         6TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rwHjSY/cIlbtqQVAcWlOBWpWZPSvPDUi4YnTufeOxfE=;
        b=uO69AyleZm0Rau+LuCajjo85ECIgeFJ5/CPmA0GUn9IGfvj3LSl5LWEopmVbNGh6FS
         hSb8fkHCA3NU3oWknprvIV/0aebsS6IqU/ghyVVTZ1PXgMHRaTm5p6GrJwTecGaQqqPI
         56SRaBhGhlQ480JkjAEijlC6yLQp/CSE5ReatyK2LhyEJ/3h1wO2eJhaMAoF185j+cgM
         aY+g00tNtcoQgld3osHs6qTvAOGIortWMA/JLQe1Hx9q991alGNHfVZKoThWlGV9JScj
         6eEGsAx5EnU8Vm7MSZe52sjZIU2vxrvVd5837w9FhvvQmCIeasN19rUY8VvQKHX3LvM2
         QkFA==
X-Gm-Message-State: AOAM532dyoMe9Urrn3JrYkDT/3OGBeyJYfmJF/bfGzAFcorZ7rVuYFOu
        WI60e9Dh17nZ56qKr00m0oA=
X-Google-Smtp-Source: ABdhPJwfvn0CW9oa8XXT9H4P5gkDzknSI+94obOmUHw5Taf9nJAY0fRjSUavSlOt8KppCI98nJj9Eg==
X-Received: by 2002:aa7:8892:0:b0:47e:6ad0:6a6e with SMTP id z18-20020aa78892000000b0047e6ad06a6emr2695139pfe.6.1635495409252;
        Fri, 29 Oct 2021 01:16:49 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l14sm9818242pjq.13.2021.10.29.01.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 01:16:48 -0700 (PDT)
To:     paulmck@kernel.org, neilb@suse.de
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org, rcu@vger.kernel.org,
        willy@infradead.org
References: <20211028190336.GI880162@paulmck-ThinkPad-P17-Gen-1>
Subject: Re: [PATCH v2] Documentation: Add refcount analogy to What is RCU
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <ac66a5f3-da2a-db13-1e6f-d498108dab95@gmail.com>
Date:   Fri, 29 Oct 2021 17:16:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028190336.GI880162@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul, Hello Neil,

Please find inline comments below on minor issues I noticed while
testing "make htmldocs" on this patch.

Thu, Thu, 28 Oct 2021 12:03:36 -0700
Paul E. McKenney wrote:
> I could not resist the urge to do a small amount of wordsmithing, so
> please check below in case I messed something up.
> 
> 							Thanx, Paul
> 
> -------------------------------------------------------------------------
> 
> commit 25ce7d081265ce4d29cb2a537a932813df1b7697
> Author: NeilBrown <neilb@suse.de>
> Date:   Tue Oct 26 15:53:38 2021 +1100
> 
>     Documentation: Add refcount analogy to What is RCU
>     
>     The reader-writer-lock analogy is a useful way to think about RCU, but
>     it is not always applicable.  It is useful to have other analogies to
>     work with, and particularly to emphasise that no single analogy is
                                     emphasize

>     perfect.
>     
>     This patch add a "RCU as reference count" to the "what is RCU" document.
>     
>     See https://lwn.net/Articles/872559/
>     
>     Signed-off-by: NeilBrown <neilb@suse.de>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index 17e95ab2a201..798f92c050cc 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -39,9 +39,11 @@ different paths, as follows:
>  
>  :ref:`6.	ANALOGY WITH READER-WRITER LOCKING <6_whatisRCU>`
>  
> -:ref:`7.	FULL LIST OF RCU APIs <7_whatisRCU>`
> +:ref:`7.	ANALOGY WITH REFERENCE COUNTING <7_whatisRCU>'                                                             `  (:ref:`...`)

>  
> -:ref:`8.	ANSWERS TO QUICK QUIZZES <8_whatisRCU>`
> +:ref:`8.	FULL LIST OF RCU APIs <8_whatisRCU>`
> +
> +:ref:`9.	ANSWERS TO QUICK QUIZZES <9_whatisRCU>`
>  
>  People who prefer starting with a conceptual overview should focus on
>  Section 1, though most readers will profit by reading this section at
> @@ -677,7 +679,7 @@ Quick Quiz #1:
>  		occur when using this algorithm in a real-world Linux
>  		kernel?  How could this deadlock be avoided?
>  
> -:ref:`Answers to Quick Quiz <8_whatisRCU>`
> +:ref:`Answers to Quick Quiz <9_whatisRCU>`
>  
>  5B.  "TOY" EXAMPLE #2: CLASSIC RCU
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> @@ -732,7 +734,7 @@ Quick Quiz #2:
>  		Give an example where Classic RCU's read-side
>  		overhead is **negative**.
>  
> -:ref:`Answers to Quick Quiz <8_whatisRCU>`
> +:ref:`Answers to Quick Quiz <9_whatisRCU>`
>  
>  .. _quiz_3:
>  
> @@ -741,7 +743,7 @@ Quick Quiz #3:
>  		critical section, what the heck do you do in
>  		CONFIG_PREEMPT_RT, where normal spinlocks can block???
>  
> -:ref:`Answers to Quick Quiz <8_whatisRCU>`
> +:ref:`Answers to Quick Quiz <9_whatisRCU>`
>  
>  .. _6_whatisRCU:
>  
> @@ -872,7 +874,78 @@ be used in place of synchronize_rcu().
>  
>  .. _7_whatisRCU:
>  
> -7.  FULL LIST OF RCU APIs
> +7.  ANALOGY WITH REFERENCE COUNTING
> +-----------------------------------
> +
> +The reader-writer analogy (illustrated by the previous section) is not
> +always the best way to think about using RCU.  Another helpful analogy
> +considers RCU a effective reference count on everything which is protected
                 an

> +by RCU.
> +
> +A reference count typically does not prevent the referenced object's
> +values from changing, but does prevent changes to type - particularly the
                                                          -- (convention in this doc)

> +gross change of type that happens when that object's memory is freed and
> +re-allocated for some other purpose.  Once a type-safe reference to the
> +object is obtained, some other mechanism is needed to ensure consistent
> +access to the data in the object.  This could involve taking a spinlock,
> +but with RCU the typical approach is to perform reads with SMP-aware
> +operations such as smp_load_acquire(), to perform updates with atomic
> +read-modify-write operations, and to provide the necessary ordering.
> +RCU provides a number of support functions that embed the required
> +operations and ordering, such as the list_for_each_entry_rcu() macro
> +used in the previous section.
> +
> +A more focused view of the reference counting behaviour is that,
                                                 behavior (American spelling)

> +between rcu_read_lock() and rcu_read_unlock(), any reference taken with
> +rcu_dereference() on a pointer marked as ``__rcu`` can be treated as
> +though a reference-count on that object has been temporarily increased.
> +This prevents the object from changing type.  Exactly what this means
> +will depend on normal expectations of objects of that type, but it
> +typically includes that spinlocks can still be safely locked, normal
> +reference counters can be safely manipulated, and ``__rcu`` pointers
> +can be safely dereferenced.
> +
> +Some operations that one might expect to see on an object for
> +which an RCU reference is held include:

Without an empty line here, "make htmldocs" will complain. 

> + - Copying out data that is guaranteed to be stable by the object's type.
> + - Using kref_get_unless_zero() or similar to get a longer-term
> +   reference.  This may fail of course.
> + - Acquiring a spinlock in the object, and checking if the object still
> +   is the expected object and if so, manipulating it freely.
> +
> +The understanding that RCU provides a reference that only prevents a
> +change of type is particularly visible with objects allocated from a
> +slab cache marked ``SLAB_TYPESAFE_BY_RCU``.  RCU operations may yield a
> +reference to an object from such a cache that has been concurrently
> +freed and the memory reallocated to a completely different object,
> +though of the same type.  In this case RCU doesn't even protect the
> +identity of the object from changing, only its type.  So the object
> +found may not be the one expected, but it will be one where it is safe
> +to take a reference or spinlock and then confirm that the identity
> +matches the expectations.
> +
> +With traditional reference counting - such as that implemented by the
                                       --

> +kref library in Linux - there is typically code that runs when the last
                         --

> +reference to an object is dropped.  With kref, this is the function
> +passed to kref_put().  When RCU is being used such finalization code
                          When RCU is being used, such finalization code

> +must not be run until all ``__rcu`` pointers referencing the object have
> +been updated, and then a grace period has passed.  Every remaining
> +globally visible pointer to the object must be considered to be a
> +potential counted reference, and the finalization code it typically run
                                                          is (???)
> +using call_rcu() only after all those pointers have been changed.
> +
> +To see how to choose between there two analogies - of RCU as a
                                these               --

> +reader-writer lock and RCU as a reference counting system - it is useful
                                                             --

> +to reflect on the scale of the thing being protected.  The reader-writer
> +lock analogy looks at larger multi-part objects such as a linked list
> +and shows how RCU can facilitate concurrency while elements are added
> +to, and removed from, the list.  The reference-count analogy looks at
> +the individual objects and looks at how they can be accessed safely
> +within whatever whole they are a part of.

Hope this helps.

With these comments addressed, please feel free to add:

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

       Thanks, Akira

> +
> +.. _8_whatisRCU:
> +
> +8.  FULL LIST OF RCU APIs
>  -------------------------
>  
>  The RCU APIs are documented in docbook-format header comments in the
> @@ -1035,9 +1108,9 @@ g.	Otherwise, use RCU.
>  Of course, this all assumes that you have determined that RCU is in fact
>  the right tool for your job.
>  
> -.. _8_whatisRCU:
> +.. _9_whatisRCU:
>  
> -8.  ANSWERS TO QUICK QUIZZES
> +9.  ANSWERS TO QUICK QUIZZES
>  ----------------------------
>  
>  Quick Quiz #1:

