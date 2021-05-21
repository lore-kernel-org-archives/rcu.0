Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDB2C4707A
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 17:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCCB6138C
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 17:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhEUR6Q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 May 2021 13:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231834AbhEUR6Q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 May 2021 13:58:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1933961004;
        Fri, 21 May 2021 17:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621619813;
        bh=hauk+XeK6pS8iQR0Fx35PsTMXg2GrguRiVOBfyFfYO8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bvzh47vr4UyN4V4xpS8bEqme8XKTQtpYi0gy5mfT9KBAJZehR6hSTl0XeACImAJDW
         wb1m7jWF5GhjK3Dyl574+X4K8qCDcnjLA1TNORJTFp+OIOvx3myK2PKSfweONv5d7X
         QVLPEDhE8xM52hHO1//ebl/JmKedjy85YwG1GbAKZO4HoGIIUrxPGfxDbCfdFjMp8i
         AHRZ1Nb2Mc12DFh4q0xxfKSIXr2SaB3OHuj//NUnoJRWRIIzPiYFYNd+mnIPf8DGIR
         1Z0C4C9DBH+ZSw7wkC5jJfuPH2MP2n0buLb6ygPiiDWjHDxFgbvxal+hP+vZE4CdWI
         OlGeI8ujVldLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E02535C018D; Fri, 21 May 2021 10:56:52 -0700 (PDT)
Date:   Fri, 21 May 2021 10:56:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: unify documentation about missing
 list_empty_rcu()
Message-ID: <20210521175652.GC4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210521100829.257385-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521100829.257385-1-jwi@linux.ibm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 21, 2021 at 12:08:29PM +0200, Julian Wiedmann wrote:
> We have two separate sections that talk about why list_empty_rcu()
> is not needed, consolidate them.
> 
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

Good catch, thank you!  As usual, I could not resist the urge to further
wordsmith, resulting in the following.  Please let me know if I messed
anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 6e9da58a4b391035e1ce77b8d867cdcdc73521b2
Author: Julian Wiedmann <jwi@linux.ibm.com>
Date:   Fri May 21 12:08:29 2021 +0200

    rculist: Unify documentation about missing list_empty_rcu()
    
    We have two separate sections that talk about why list_empty_rcu()
    is not needed, so this commit consolidates them.
    
    Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
    [ paulmck: The usual wordsmithing. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index f8633d37e358..d29740be4833 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -10,15 +10,6 @@
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 
-/*
- * Why is there no list_empty_rcu()?  Because list_empty() serves this
- * purpose.  The list_empty() function fetches the RCU-protected pointer
- * and compares it to the address of the list head, but neither dereferences
- * this pointer itself nor provides this pointer to the caller.  Therefore,
- * it is not necessary to use rcu_dereference(), so that list_empty() can
- * be used anywhere you would want to use a list_empty_rcu().
- */
-
 /*
  * INIT_LIST_HEAD_RCU - Initialize a list_head visible to RCU readers
  * @list: list to be initialized
@@ -318,21 +309,29 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 /*
  * Where are list_empty_rcu() and list_first_entry_rcu()?
  *
- * Implementing those functions following their counterparts list_empty() and
- * list_first_entry() is not advisable because they lead to subtle race
- * conditions as the following snippet shows:
+ * They do not exist because they would lead to subtle race conditions:
  *
  * if (!list_empty_rcu(mylist)) {
  *	struct foo *bar = list_first_entry_rcu(mylist, struct foo, list_member);
  *	do_something(bar);
  * }
  *
- * The list may not be empty when list_empty_rcu checks it, but it may be when
- * list_first_entry_rcu rereads the ->next pointer.
- *
- * Rereading the ->next pointer is not a problem for list_empty() and
- * list_first_entry() because they would be protected by a lock that blocks
- * writers.
+ * The list might be non-empty when list_empty_rcu() checks it, but it
+ * might have become empty by the time that list_first_entry_rcu() rereads
+ * the ->next pointer, which would result in a SEGV.
+ *
+ * When not using RCU, it is OK for list_first_entry() to re-read that
+ * pointer because both functions should be protected by some lock that
+ * blocks writers.
+ *
+ * When using RCU, list_empty() uses READ_ONCE() to fetch the
+ * RCU-protected ->next pointer and then compares it to the address of the
+ * list head.  However, it neither dereferences this pointer nor provides
+ * this pointer to its caller.  Thus, READ_ONCE() suffices (that is,
+ * rcu_dereference() is not needed), which means that list_empty() can be
+ * used anywhere you would want to use list_empty_rcu().  Just don't
+ * expect anything useful to happen if you do a subsequent lockless
+ * call to list_first_entry_rcu()!!!
  *
  * See list_first_or_null_rcu for an alternative.
  */
