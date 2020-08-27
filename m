Return-Path: <SRS0=+yOZ=CF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E569C433E6
	for <rcu@archiver.kernel.org>; Thu, 27 Aug 2020 22:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3421020848
	for <rcu@archiver.kernel.org>; Thu, 27 Aug 2020 22:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="op2Qm5am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgH0WzV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgH0WzV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 27 Aug 2020 18:55:21 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C78C061264
        for <rcu@vger.kernel.org>; Thu, 27 Aug 2020 15:55:20 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dd12so3535060qvb.0
        for <rcu@vger.kernel.org>; Thu, 27 Aug 2020 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NHx4KMeBVqAEMcvmg+uxPNQTDNwjuyTGo6Fp5UGmNpc=;
        b=op2Qm5amYr8FYy6AuUQgIYoKgfozkFQUdmXFahqeVChi+S5KQKAk/L/TC/Xz1QTH45
         emVS3RzguX4GrJD4kBbApfD9YazKWBZ/W+Oni0NXbPTudwJJgOIEt0wvFjjN34g1+t6q
         +gFvS6+xsog892OIkzvs+Q4XH0AxJUev0UnLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NHx4KMeBVqAEMcvmg+uxPNQTDNwjuyTGo6Fp5UGmNpc=;
        b=goH3rBIAj9o55q+NSVXSXKkg7LiqUgWhrPpDmeOUW/HUuvg4ZEnRHsDKnzGO2/ehAp
         ChHrjQCVgfferDMjAEEvN1vnUv5DTJfZ7APebHCfOE/WxUtlA1zbZDI1edogVtdbH3Pp
         7P3t+Qiq8Cm8RNbwwvyuussf4XKHJM6MHYOqKeEpCo7uvvrnrKAiZaRAxhSgeBsjTbw5
         fmDiJFqwVxaqTS4r4ICtLHuGmWV2FloRD5A+lIOyKn8hgYptDfBMEBa6EIhSP7ivI4AR
         k9nq3nReIACUXpj9OAvl5vbfVmqciZ8ndHguawMjwbxwYzTSyaKXWYp9iN/2lkGwRsK5
         0UUg==
X-Gm-Message-State: AOAM533/DJlTyiowNHIiRKwhFyQCDcZtjy6YZnHtO3gg6wwKJJ2vtkJx
        DIwI8F0W47AMhi2QbfkwfjM8LA==
X-Google-Smtp-Source: ABdhPJwWphO4IpBJnpjSbzSjba1dtuBPtZWmRrMTNz5wxGv2ycBixUQUHchwLW2z8lY+RwcnzUjOdw==
X-Received: by 2002:ad4:4dc5:: with SMTP id cw5mr21218710qvb.238.1598568919791;
        Thu, 27 Aug 2020 15:55:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id u41sm3232432qth.42.2020.08.27.15.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 15:55:19 -0700 (PDT)
Date:   Thu, 27 Aug 2020 18:55:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dave@stgolabs.net, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: Re: [PATCH v4 -rcu 1/4] rcu/segcblist: Do not depend on rcl->len to
 store the segcb len during merge
Message-ID: <20200827225518.GB3821640@google.com>
References: <20200825024842.3408659-1-joel@joelfernandes.org>
 <20200825024842.3408659-2-joel@joelfernandes.org>
 <20200825200809.GW2855@paulmck-ThinkPad-P72>
 <20200825224723.GB579506@google.com>
 <20200826142028.GN2855@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826142028.GN2855@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 26, 2020 at 07:20:28AM -0700, Paul E. McKenney wrote:
[...]
> > > Or better yet, please see below, which should allow getting rid of both
> > > of them.
> > > 
> > > >  	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
> > > >  	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
> > > > -	rcu_segcblist_insert_count(dst_rsclp, &donecbs);
> > > > +
> > > > +	rcu_segcblist_add_len(dst_rsclp, src_len);
> > > >  	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
> > > >  	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
> > > 
> > > Rather than adding the blank lines, why not have the rcu_cblist structures
> > > carry the lengths?  You are already adjusting one of the two call sites
> > > that care (rcu_do_batch()), and the other is srcu_invoke_callbacks().
> > > That should shorten this function a bit more.  And make callback handling
> > > much more approachable, I suspect.
> > 
> > Sorry, I did not understand. The rcu_cblist structure already has a length
> > field. I do modify rcu_segcblist_extract_done_cbs() and
> > rcu_segcblist_extract_pend_cbs() to carry the length already, in a later
> > patch.
> > 
> > Just to emphasize, this patch is just a small refactor to avoid an issue in
> > later patches. It aims to keep current functionality unchanged.
> 
> True enough.  I am just suggesting that an equally small refactor in
> a slightly different direction should get to a better place.  The key
> point enabling this slightly different direction is that this code is
> an exception to the "preserve ->cblist.len" rule because it is invoked
> only from the CPU hotplug code.
> 
> So you could use the rcu_cblist .len field to update the ->cblist.len
> field, thus combining the _cbs and _count updates.  One thing that helps
> is that setting th e rcu_cblist .len field doesn't hurt the other use
> cases that require careful handling of ->cblist.len.

Thank you for the ideas. I am trying something like this on top of this
series based on the ideas. One thing I concerned a bit is if getting rid of
the rcu_segcblist_xchg_len() function (which has memory barriers in them)
causes issues in the hotplug path. I am now directly updating the length
without additional memory barriers. I will test it more and try to reason
more about it as well.

---8<-----------------------

From: Joel Fernandes <joelaf@google.com>
Date: Thu, 27 Aug 2020 18:30:25 -0400
Subject: [PATCH] fixup! rcu/segcblist: Do not depend on donecbs ->len to store
 the segcb len during merge

Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 kernel/rcu/rcu_segcblist.c | 38 ++++----------------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 79c2cbe388c5..c33abbc97a07 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -175,26 +175,6 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
 	rcu_segcblist_add_len(rsclp, 1);
 }
 
-/*
- * Exchange the numeric length of the specified rcu_segcblist structure
- * with the specified value.  This can cause the ->len field to disagree
- * with the actual number of callbacks on the structure.  This exchange is
- * fully ordered with respect to the callers accesses both before and after.
- */
-static long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
-{
-#ifdef CONFIG_RCU_NOCB_CPU
-	return atomic_long_xchg(&rsclp->len, v);
-#else
-	long ret = rsclp->len;
-
-	smp_mb(); /* Up to the caller! */
-	WRITE_ONCE(rsclp->len, v);
-	smp_mb(); /* Up to the caller! */
-	return ret;
-#endif
-}
-
 /*
  * Initialize an rcu_segcblist structure.
  */
@@ -361,6 +341,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
 			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
 	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
+	rcu_segcblist_add_len(rsclp, -(rclp->len));
 }
 
 /*
@@ -414,17 +395,7 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
 		rcu_segcblist_set_seglen(rsclp, i, 0);
 	}
-}
-
-/*
- * Insert counts from the specified rcu_cblist structure in the
- * specified rcu_segcblist structure.
- */
-void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
-				struct rcu_cblist *rclp)
-{
-	rcu_segcblist_add_len(rsclp, rclp->len);
-	rclp->len = 0;
+	rcu_segcblist_add_len(rsclp, -(rclp->len));
 }
 
 /*
@@ -448,6 +419,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 			break;
 	rclp->head = NULL;
 	rclp->tail = &rclp->head;
+	rcu_segcblist_add_len(rsclp, rclp->len);
 }
 
 /*
@@ -463,6 +435,7 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
+	rcu_segcblist_add_len(rsclp, rclp->len);
 }
 
 /*
@@ -601,16 +574,13 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 {
 	struct rcu_cblist donecbs;
 	struct rcu_cblist pendcbs;
-	long src_len;
 
 	rcu_cblist_init(&donecbs);
 	rcu_cblist_init(&pendcbs);
 
-	src_len = rcu_segcblist_xchg_len(src_rsclp, 0);
 	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
 	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
 
-	rcu_segcblist_add_len(dst_rsclp, src_len);
 	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
 	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
 
-- 
2.28.0.402.g5ffc5be6b7-goog

