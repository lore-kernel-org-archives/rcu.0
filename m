Return-Path: <SRS0=SldO=A6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5409C433E0
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 04:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA54207DD
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 04:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jnSHP1yD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgGSESo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Jul 2020 00:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGSESo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 19 Jul 2020 00:18:44 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05C2C0619D2
        for <rcu@vger.kernel.org>; Sat, 18 Jul 2020 21:18:43 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g13so10651739qtv.8
        for <rcu@vger.kernel.org>; Sat, 18 Jul 2020 21:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/2tEPQlqXBxZM+444TkCgs0VB7X/X2HRdlgq/mAVgQ8=;
        b=jnSHP1yDm3o1QZdW+OLmr0fJtzyKiXx8z6sUvoIDk9g0eLp2CLM2HqYYJXk9qfAzus
         fDxgBhjfH2qvzOAcDUgfue3ArPX10fx+hs//v97IRwdXKI+t6xiMvgx3x7904p+ATrKK
         kCqKsHPIFPRKN+gXlT+EAIjKpPSzoBfalx7L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/2tEPQlqXBxZM+444TkCgs0VB7X/X2HRdlgq/mAVgQ8=;
        b=IjZP4jpMdiLePyKcTD+SssOez3nNkW9xaSIjaMH72VvJyp4Vwo/UB7G3QK62KXbJgs
         P2qKEcTmDEld43EniXbfiJUa560TlmmdPUgFg2k+NTpLgtgYTWjouTRnxKksYztyJCrw
         tco4SchaPo0o0yDnbG0ojowtEDOnYoed49iv78o0e25QJr39eCGwLsT4nhGDAY5IBW1D
         OmoDKki4nQTBgXnFw0Htxgwa94K5gXiaTaKzY8+npUAQL8PVVnL1pO4e+bP34sHPQMzz
         cd1tYF/W8iOOB0ye/NZ640zQlYyTftwc3zUYyOnELR6MNbsvCFndKwWSFAY0LWaZ1DWa
         gQeQ==
X-Gm-Message-State: AOAM532gu7X0g3WSB7jb1kMGWzIlqpTNHUWRR/kRNKZbhQyXN/NrnZ1n
        hnh6miixpqNRDk2jdrYmCNoFwA==
X-Google-Smtp-Source: ABdhPJzj8AIozjn1grKgj08X8tPxHOlNWe6A9yG6Bm3gg9lP2YKQxDNcbiZSPvUkGbCgyhIY9fZJUw==
X-Received: by 2002:ac8:4788:: with SMTP id k8mr18559028qtq.120.1595132322760;
        Sat, 18 Jul 2020 21:18:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id i19sm2546845qkk.68.2020.07.18.21.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 21:18:42 -0700 (PDT)
Date:   Sun, 19 Jul 2020 00:18:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v2] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200719041841.GA2398236@google.com>
References: <20200719035518.2386828-1-joel@joelfernandes.org>
 <CAEXW_YQhYiYQZOJ95dqBcu_fAZ_6k7HGbrw53eTgPrgXU+5few@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQhYiYQZOJ95dqBcu_fAZ_6k7HGbrw53eTgPrgXU+5few@mail.gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jul 19, 2020 at 12:06:28AM -0400, Joel Fernandes wrote:
> On Sat, Jul 18, 2020 at 11:55 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> [...]
> >         /* If no callbacks moved, nothing more need be done. */
> > @@ -419,10 +494,9 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
> >          * callbacks.  The overall effect is to copy down the later pointers
> >          * into the gap that was created by the now-ready segments.
> >          */
> > -       for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++, j++) {
> > -               if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
> > -                       break;  /* No more callbacks. */
> > +       for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL && j < RCU_NEXT_TAIL; i++, j++) {
> >                 WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
> > +               rcu_segcblist_move_seglen(rsclp, i, j);
> >                 rsclp->gp_seq[j] = rsclp->gp_seq[i];
> >         }
> 
> Unfortunately I broke this code, _sigh_.  I need to reinstate the
> if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL]) , I completely
> misunderstood that.

And hopefully, third time's a charm with various extra newlines removed:

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v3] rcu/segcblist: Add counters to segcblist datastructure

Add counting of segment lengths of segmented callback list.

This will be useful for a number of things such as knowing how big the
ready-to-execute segment have gotten. The immediate benefit is ability
to trace how the callbacks in the segmented callback list change.

Tested by profusely reading traces when segcblist counts updated.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

v1->v3: minor nits.
---
 include/linux/rcu_segcblist.h |  2 +
 kernel/rcu/rcu_segcblist.c    | 77 +++++++++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index b36afe7b22c9..d462ae5e340a 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -69,8 +69,10 @@ struct rcu_segcblist {
 	unsigned long gp_seq[RCU_CBLIST_NSEGS];
 #ifdef CONFIG_RCU_NOCB_CPU
 	atomic_long_t len;
+	atomic_long_t seglen[RCU_CBLIST_NSEGS];
 #else
 	long len;
+	long seglen[RCU_CBLIST_NSEGS];
 #endif
 	u8 enabled;
 	u8 offloaded;
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 9a0f66133b4b..c5841efcd38e 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -88,6 +88,57 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
 #endif
 }
 
+/* Get the length of a segment of the rcu_segcblist structure. */
+static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	return atomic_long_read(&rsclp->seglen[seg]);
+#else
+	return READ_ONCE(rsclp->seglen[seg]);
+#endif
+}
+
+/* Set the length of a segment of the rcu_segcblist structure. */
+static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	atomic_long_set(&rsclp->seglen[seg], v);
+#else
+	WRITE_ONCE(rsclp->seglen[seg], v);
+#endif
+}
+
+/* Return number of callbacks in a segment of the segmented callback list. */
+static void rcu_segcblist_add_seglen(struct rcu_segcblist *rsclp, int seg, long v)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	smp_mb__before_atomic(); /* Up to the caller! */
+	atomic_long_add(v, &rsclp->seglen[seg]);
+	smp_mb__after_atomic(); /* Up to the caller! */
+#else
+	smp_mb(); /* Up to the caller! */
+	WRITE_ONCE(rsclp->seglen[seg], rsclp->seglen[seg] + v);
+	smp_mb(); /* Up to the caller! */
+#endif
+}
+
+/* Move from's segment length to to's segment. */
+static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
+{
+	long len = rcu_segcblist_get_seglen(rsclp, from);
+
+	if (!len || from == to)
+		return;
+	rcu_segcblist_add_seglen(rsclp, to, len);
+	rcu_segcblist_set_seglen(rsclp, from, 0);
+}
+
+/* Increment segment's length. */
+static void rcu_segcblist_inc_seglen(struct rcu_segcblist *rsclp, int seg)
+{
+	rcu_segcblist_add_seglen(rsclp, seg, 1);
+}
+
 /*
  * Increase the numeric length of an rcu_segcblist structure by the
  * specified amount, which can be negative.  This can cause the ->len
@@ -149,8 +200,10 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 	BUILD_BUG_ON(RCU_NEXT_TAIL + 1 != ARRAY_SIZE(rsclp->gp_seq));
 	BUILD_BUG_ON(ARRAY_SIZE(rsclp->tails) != ARRAY_SIZE(rsclp->gp_seq));
 	rsclp->head = NULL;
-	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
 		rsclp->tails[i] = &rsclp->head;
+		rcu_segcblist_set_seglen(rsclp, i, 0);
+	}
 	rcu_segcblist_set_len(rsclp, 0);
 	rsclp->enabled = 1;
 }
@@ -245,6 +298,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp)
 {
 	rcu_segcblist_inc_len(rsclp);
+	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
 	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
 	rhp->next = NULL;
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
@@ -274,6 +328,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] != rsclp->tails[i - 1])
 			break;
+	rcu_segcblist_inc_seglen(rsclp, i);
 	WRITE_ONCE(*rsclp->tails[i], rhp);
 	for (; i <= RCU_NEXT_TAIL; i++)
 		WRITE_ONCE(rsclp->tails[i], &rhp->next);
@@ -307,6 +362,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rcu_segcblist_ready_cbs(rsclp))
 		return; /* Nothing to do. */
+	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);
 	*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, *rsclp->tails[RCU_DONE_TAIL]);
 	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
@@ -314,6 +370,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
 			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
+	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
 }
 
 /*
@@ -330,11 +387,16 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rcu_segcblist_pend_cbs(rsclp))
 		return; /* Nothing to do. */
+	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
+		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
+		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
 	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
 	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
 	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
-	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++)
+	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
+		rcu_segcblist_set_seglen(rsclp, i, 0);
+	}
 }
 
 /*
@@ -359,6 +421,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rclp->head)
 		return; /* No callbacks to move. */
+	rcu_segcblist_add_seglen(rsclp, RCU_DONE_TAIL, rclp->len);
 	*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, rclp->head);
 	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
@@ -379,6 +442,8 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 {
 	if (!rclp->head)
 		return; /* Nothing to do. */
+
+	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
 }
@@ -403,6 +468,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
 			break;
 		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
 	}
 
 	/* If no callbacks moved, nothing more need be done. */
@@ -423,6 +489,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
 			break;  /* No more callbacks. */
 		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, j);
 		rsclp->gp_seq[j] = rsclp->gp_seq[i];
 	}
 }
@@ -444,7 +511,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
  */
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	int i;
+	int i, j;
 
 	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
 	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
@@ -479,6 +546,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	if (++i >= RCU_NEXT_TAIL)
 		return false;
 
+	/* Accounting: everything below i is about to get merged into i. */
+	for (j = i + 1; j <= RCU_NEXT_TAIL; j++)
+		rcu_segcblist_move_seglen(rsclp, j, i);
+
 	/*
 	 * Merge all later callbacks, including newly arrived callbacks,
 	 * into the segment located by the for-loop above.  Assign "seq"
-- 
2.28.0.rc0.105.gf9edc3c819-goog

