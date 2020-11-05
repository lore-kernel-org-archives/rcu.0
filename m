Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A816BC4741F
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 18:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D39E2078E
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 18:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604602553;
	bh=U+eY0oLiAL3X7oMRMsfRt2ooI6apLfHOdcCodZm3Cd0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hQoPUEBOX0HTzWi7PxkDfu1atmSxfrWL+/omEUq1FNo1S9Z2OvsutTToAQDc6O5mK
	 qfoliqQ6d6n422vt2QUdrhiAhhK1/Lr0HLQXaIW075+/wIYpzDjLQmQ9slkrNNXEIX
	 EoBwQIe1HiHUgkvABcUa0fH5YcYBk16XtpRoZOzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgKESzx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 13:55:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbgKESzw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 13:55:52 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CAD6206D9;
        Thu,  5 Nov 2020 18:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604602551;
        bh=U+eY0oLiAL3X7oMRMsfRt2ooI6apLfHOdcCodZm3Cd0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=T8taIkA4GHyEXl6/ZlIFQv2zZTw2VS/QNzYbk5SWkni8TDMFjWEWhuILMNGrmhhFc
         nnhKXVVktNiA2w4o16npSW3myiTi6vNMxIKqdgZ2nxbyxE4uOlSxN0RJFdB5jQALj6
         bLecqsnthydqr9SpyxptdVInwmtwoRgmFcyf07Do=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 32B6F352265A; Thu,  5 Nov 2020 10:55:51 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:55:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 7/7] rcu/segcblist: Add additional comments to explain
 smp_mb()
Message-ID: <20201105185551.GO3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-8-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103142603.1302207-8-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 03, 2020 at 09:26:03AM -0500, Joel Fernandes (Google) wrote:
> Memory barriers are needed when updating the full length of the
> segcblist, however it is not fully clearly why one is needed before and
> after. This patch therefore adds additional comments to the function
> header to explain it.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks good, thank you!  As always, I could not resist the urge to
do a bit of wordsmithing, so that the queued commit is as shown
below.  Please let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 7dac7adefcae7558b3a85a16f51186d621623733
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Tue Nov 3 09:26:03 2020 -0500

    rcu/segcblist: Add additional comments to explain smp_mb()
    
    One counter-intuitive property of RCU is the fact that full memory
    barriers are needed both before and after updates to the full
    (non-segmented) length.  This patch therefore helps to assist the
    reader's intuition by adding appropriate comments.
    
    [ paulmck:  Wordsmithing. ]
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index bb246d8..b6dda7c 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -94,17 +94,77 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
  * field to disagree with the actual number of callbacks on the structure.
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
+ *
+ * So why on earth is a memory barrier required both before and after
+ * the update to the ->len field???
+ *
+ * The reason is that rcu_barrier() locklessly samples each CPU's ->len
+ * field, and if a given CPU's field is zero, avoids IPIing that CPU.
+ * This can of course race with both queuing and invoking of callbacks.
+ * Failng to correctly handle either of these races could result in
+ * rcu_barrier() failing to IPI a CPU that actually had callbacks queued
+ * which rcu_barrier() was obligated to wait on.  And if rcu_barrier()
+ * failed to wait on such a callback, unloading certain kernel modules
+ * would result in calls to functions whose code was no longer present in
+ * the kernel, for but one example.
+ *
+ * Therefore, ->len transitions from 1->0 and 0->1 have to be carefully
+ * ordered with respect with both list modifications and the rcu_barrier().
+ *
+ * The queuing case is CASE 1 and the invoking case is CASE 2.
+ *
+ * CASE 1: Suppose that CPU 0 has no callbacks queued, but invokes
+ * call_rcu() just as CPU 1 invokes rcu_barrier().  CPU 0's ->len field
+ * will transition from 0->1, which is one of the transitions that must be
+ * handled carefully.  Without the full memory barriers before the ->len
+ * update and at the beginning of rcu_barrier(), the following could happen:
+ *
+ * CPU 0				CPU 1
+ *
+ * call_rcu().
+ *                      		rcu_barrier() sees ->len as 0.
+ * set ->len = 1.
+ *                      		rcu_barrier() does nothing.
+ *					module is unloaded.
+ * callback invokes unloaded function!
+ *
+ * With the full barriers, any case where rcu_barrier() sees ->len as 0 will
+ * have unambiguously preceded the return from the racing call_rcu(), which
+ * means that this call_rcu() invocation is OK to not wait on.  After all,
+ * you are supposed to make sure that any problematic call_rcu() invocations
+ * happen before the rcu_barrier().
+ *
+ *
+ * CASE 2: Suppose that CPU 0 is invoking its last callback just as CPU 1 invokes
+ * rcu_barrier().  CPU 0's ->len field will transition from 1->0, which is one
+ * of the transitions that must be handled carefully.  Without the full memory
+ * barriers after the ->len update and at the end of rcu_barrier(), the following
+ * could happen:
+ * 
+ * CPU 0				CPU 1
+ *
+ * start invoking last callback
+ * set ->len = 0 (reordered)
+ *                      		rcu_barrier() sees ->len as 0
+ *                      		rcu_barrier() does nothing.
+ *					module is unloaded
+ * callback executing after unloaded!
+ *
+ * With the full barriers, any case where rcu_barrier() sees ->len as 0
+ * will be fully ordered after the completion of the callback function,
+ * so that the module unloading operation is completely safe.
+ * 
  */
 void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
-	smp_mb__before_atomic(); /* Up to the caller! */
+	smp_mb__before_atomic(); // Read header comment above.
 	atomic_long_add(v, &rsclp->len);
-	smp_mb__after_atomic(); /* Up to the caller! */
+	smp_mb__after_atomic();  // Read header comment above.
 #else
-	smp_mb(); /* Up to the caller! */
+	smp_mb(); // Read header comment above.
 	WRITE_ONCE(rsclp->len, rsclp->len + v);
-	smp_mb(); /* Up to the caller! */
+	smp_mb(); // Read header comment above.
 #endif
 }
 
