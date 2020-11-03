Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D08C388F9
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 13:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28B421D91
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 13:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IPVCeJf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgKCNsd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 08:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgKCNrY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 08:47:24 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D0EC0617A6
        for <rcu@vger.kernel.org>; Tue,  3 Nov 2020 05:47:23 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id k9so14618367qki.6
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2020 05:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mDVc/Cp02Wi+ckhocWoIH2Hr0Dgbjtp/LWy0Mi63L3E=;
        b=IPVCeJf8vutgRX97RGX0CnOoGg4UB06rcHqEtxWxYTpRi1NUiqpyxwN/AkFlzn0Mr+
         /KUZBydcBbNP4zeNUKD5iGL3l14Y5/Z2ki1koDEqEmAosQLeQXAwXcu8yn9S+HT/uXoK
         qAwHtiL11SQrWZ9qilYfNvC5LytpLwxLN6c2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mDVc/Cp02Wi+ckhocWoIH2Hr0Dgbjtp/LWy0Mi63L3E=;
        b=oMvkurPSVEsKS1SvByYGDDEy6W64SxhQIVqFuG0qZ7pWbBAkQJjwtG0tFclnWCeelO
         l8ZAQNEHCa0Hz/MiDUEoS40x01DQsPVjfJ9CFqcfVOIAQYfkjk2/NX4WJDR8+G6HaJrK
         hED3zBLImtIVQp0LULPseuzWNE4lih5XyuU/n0mne5seg4k/pZZDk0SyClHIpNpqX0GN
         NpQ8XvELSBdlK243GpdRosu/lexZKvnJMHKmUQ/ym/WxGopz64gFBF52qsunjXj+/wXW
         CfVHrF6NrsnVZ2CeUAarCsN6qGAHKSCmZ0JmYrCyDjrHaighQjqNjN6aW/UvPp1AU9bQ
         zPFg==
X-Gm-Message-State: AOAM531VnaPa28dLaPYFjvh6whNpAX/frj8olQUNaoIqDZugGmZFKcxs
        59MpXiKCYhu3W8D3z1SYmxIndR9+dT0Q7A==
X-Google-Smtp-Source: ABdhPJyiG8bLKD1wmvkFfJqB/xUgp6CJ+thS8AwlZBRpn6XmMBW9yImCGt+8+H3GxRe2DRETKI7Kcg==
X-Received: by 2002:a37:814:: with SMTP id 20mr13401305qki.304.1604411242730;
        Tue, 03 Nov 2020 05:47:22 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id h125sm10255799qkc.36.2020.11.03.05.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 05:47:21 -0800 (PST)
Date:   Tue, 3 Nov 2020 08:47:21 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v8 3/6] rcu/trace: Add tracing for how segcb list changes
Message-ID: <20201103134721.GA796570@google.com>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
 <20201021190813.3005054-4-joel@joelfernandes.org>
 <20201026115913.GE104441@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026115913.GE104441@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 26, 2020 at 12:59:13PM +0100, Frederic Weisbecker wrote:
> On Wed, Oct 21, 2020 at 03:08:10PM -0400, Joel Fernandes (Google) wrote:
> > Track how the segcb list changes before/after acceleration, during
> > queuing and during dequeuing.
> > 
> > This has proved useful to discover an optimization to avoid unwanted GP
> > requests when there are no callbacks accelerated. The overhead is minimal as
> > each segment's length is now stored in the respective segment.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
> >  kernel/rcu/rcu_segcblist.c | 31 +++++++++++++++++++++++++++++++
> >  kernel/rcu/rcu_segcblist.h |  5 +++++
> >  kernel/rcu/tree.c          |  9 +++++++++
> >  4 files changed, 70 insertions(+)
> > 
> > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > index 155b5cb43cfd..9f2237d9b0c8 100644
> > --- a/include/trace/events/rcu.h
> > +++ b/include/trace/events/rcu.h
> > @@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
> >  		  __entry->qlen)
> >  );
> >  
> > +TRACE_EVENT_RCU(rcu_segcb,
> 
> You might extend the segcblist tracing in the future to trace queue/dequeue/merge whatever...
> Which would give trace_rcu_segcb_queue, trace_rcu_segcb_dequeue, etc...
> 
> So I suggest you rename this one to something like rcu_segcb_stats for precision.

Ok, I changed it to that and also changed the internal wrapper to
__rcu_segcb_stats. Full patch below.

> > +
> > +		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),
> > +
> > +		TP_ARGS(ctx, cb_count, gp_seq),
> > +
> > +		TP_STRUCT__entry(
> > +			__field(const char *, ctx)
> > +			__array(int, cb_count, RCU_CBLIST_NSEGS)
> > +			__array(unsigned long, gp_seq, RCU_CBLIST_NSEGS)
> > +		),
> > +
> > +		TP_fast_assign(
> > +			__entry->ctx = ctx;
> > +			memcpy(__entry->cb_count, cb_count, RCU_CBLIST_NSEGS * sizeof(int));
> > +			memcpy(__entry->gp_seq, gp_seq, RCU_CBLIST_NSEGS * sizeof(unsigned long));
> > +		),
> > +
> > +		TP_printk("%s cb_count: (DONE=%d, WAIT=%d, NEXT_READY=%d, NEXT=%d) "
> > +			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
> > +			  __entry->cb_count[0], __entry->cb_count[1], __entry->cb_count[2], __entry->cb_count[3],
> > +			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
> > +
> > +);
> > +
> >  /*
> >   * Tracepoint for the registration of a single RCU callback of the special
> >   * kvfree() form.  The first argument is the RCU type, the second argument
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 357c19bbcb00..b0aaa51e0ee6 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/types.h>
> >  
> >  #include "rcu_segcblist.h"
> > +#include "rcu.h"
> >  
> >  /* Initialize simple callback list. */
> >  void rcu_cblist_init(struct rcu_cblist *rclp)
> > @@ -328,6 +329,36 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
> >  	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
> >  }
> >  
> > +/*
> > + * Return how many CBs each segment along with their gp_seq values.
> > + *
> > + * This function is O(N) where N is the number of segments. Only used from
> > + * tracing code which is usually disabled in production.
> > + */
> > +#ifdef CONFIG_RCU_TRACE
> > +static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> > +			 int cbcount[RCU_CBLIST_NSEGS],
> > +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> > +		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
> > +		gpseq[i] = rsclp->gp_seq[i];
> > +	}
> > +}
> 
> So that is called all the time even if the trace event isn't enabled. The
> goal of trace events are also to avoid the overhead of tracing when its off.

The overhead is only if RCU_TRACE is enabled but I added the following to
keep that low. Is it Ok now? Full patch below.

> This should be moved inside the trace event definition. We can even avoid the
> loop altogether.

No you cannot move it into the definition. If you see the trace event
definition, it is not aware of the rcu segcblist struct internals. So we've
to retrieve the lengths and provide them to it. segcblist is internal to
kernel/rcu/.

I'll add your Reviewed-by tag to this patch but let me know if you object to
that. thanks!

 - Joel

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] rcu/trace: Add tracing for how segcb list changes

Track how the segcb list changes before/after acceleration, during
queuing and during dequeuing.

This has proved useful to discover an optimization to avoid unwanted GP
requests when there are no callbacks accelerated. The overhead is minimal as
each segment's length is now stored in the respective segment.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
 kernel/rcu/rcu_segcblist.c | 34 ++++++++++++++++++++++++++++++++++
 kernel/rcu/rcu_segcblist.h |  5 +++++
 kernel/rcu/tree.c          |  9 +++++++++
 4 files changed, 73 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 155b5cb43cfd..5f8f2ee1a936 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
 		  __entry->qlen)
 );
 
+TRACE_EVENT_RCU(rcu_segcb_stats,
+
+		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),
+
+		TP_ARGS(ctx, cb_count, gp_seq),
+
+		TP_STRUCT__entry(
+			__field(const char *, ctx)
+			__array(int, cb_count, RCU_CBLIST_NSEGS)
+			__array(unsigned long, gp_seq, RCU_CBLIST_NSEGS)
+		),
+
+		TP_fast_assign(
+			__entry->ctx = ctx;
+			memcpy(__entry->cb_count, cb_count, RCU_CBLIST_NSEGS * sizeof(int));
+			memcpy(__entry->gp_seq, gp_seq, RCU_CBLIST_NSEGS * sizeof(unsigned long));
+		),
+
+		TP_printk("%s cb_count: (DONE=%d, WAIT=%d, NEXT_READY=%d, NEXT=%d) "
+			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
+			  __entry->cb_count[0], __entry->cb_count[1], __entry->cb_count[2], __entry->cb_count[3],
+			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
+
+);
+
 /*
  * Tracepoint for the registration of a single RCU callback of the special
  * kvfree() form.  The first argument is the RCU type, the second argument
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 357c19bbcb00..2a03949d0b82 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 
 #include "rcu_segcblist.h"
+#include "rcu.h"
 
 /* Initialize simple callback list. */
 void rcu_cblist_init(struct rcu_cblist *rclp)
@@ -328,6 +329,39 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
 }
 
+/*
+ * Return how many CBs each segment along with their gp_seq values.
+ *
+ * This function is O(N) where N is the number of segments. Only used from
+ * tracing code which is usually disabled in production.
+ */
+#ifdef CONFIG_RCU_TRACE
+static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
+			 int cbcount[RCU_CBLIST_NSEGS],
+			 unsigned long gpseq[RCU_CBLIST_NSEGS])
+{
+	int i;
+
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
+		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
+		gpseq[i] = rsclp->gp_seq[i];
+	}
+}
+
+void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context)
+{
+	int cbs[RCU_CBLIST_NSEGS];
+	unsigned long gps[RCU_CBLIST_NSEGS];
+
+	if (!trace_rcu_segcb_stats_enabled())
+		return;
+
+	rcu_segcblist_countseq(rsclp, cbs, gps);
+
+	trace_rcu_segcb_stats(context, cbs, gps);
+}
+#endif
+
 /*
  * Extract only those callbacks still pending (not yet ready to be
  * invoked) from the specified rcu_segcblist structure and place them in
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index cd35c9faaf51..7750734fa116 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -103,3 +103,8 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
+#ifdef CONFIG_RCU_TRACE
+void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context);
+#else
+#define __trace_rcu_segcb_stats(...)
+#endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 24c00020ab83..f6c6653b3ec2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1497,6 +1497,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
 		return false;
 
+	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPreAcc"));
+
 	/*
 	 * Callbacks are often registered with incomplete grace-period
 	 * information.  Something about the fact that getting exact
@@ -1517,6 +1519,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	else
 		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
 
+	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPostAcc"));
+
 	return ret;
 }
 
@@ -2466,11 +2470,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
 	if (offloaded)
 		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
+
+	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Invoke callbacks. */
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	rhp = rcu_cblist_dequeue(&rcl);
+
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
@@ -2983,6 +2990,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
+
 	/* Go handle any RCU core processing required. */
 	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
-- 
2.29.1.341.ge80a0c044ae-goog

