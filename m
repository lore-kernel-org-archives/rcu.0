Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B959C2D0A3
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 15:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE04F20739
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 15:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qOfgss0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgKDPGA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgKDPGA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Nov 2020 10:06:00 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE723C061A4A
        for <rcu@vger.kernel.org>; Wed,  4 Nov 2020 07:05:59 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id i21so18790166qka.12
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2020 07:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fx8WINTs3s9jcRpT27JUsSTP0o0MYBOovbzWfiytbXI=;
        b=qOfgss0GjHaALDQNx8nvu9Cz8QPms1xyvcE46wJgsPZEfjbLgCyKdEMuOdu5PxpV5B
         EshE7qunlPpxyTYeYvw1DeLcoVwLtvrEbTvUeeTulaMMjHuqoR+m24F6q+1btETEtGgd
         Oa8i4GzymXVa43QQrlaYs0caxL5HAn9wuFahU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fx8WINTs3s9jcRpT27JUsSTP0o0MYBOovbzWfiytbXI=;
        b=Ch7/UJQWwJPrmaQD/X1+/oD/s/lxIzPPxpMtiTkX+MU4fyDDygwUEaIKfgyYkmUrML
         /hyPuiIHRPwwwzLF0HgJCQ4+hosPtTW5UJm8pdXnYoi0Hn2T1HpiMGydZsAPrp5KItid
         FYmiQTt+uhKH1tT8WmR2qKilD5LJ++Zhen96xXViuHFEdXjyMWnBbpA0jXH4YYhHZ8mk
         a5Qt+kNcoUn8R+lLFNC1iy4e1I+4t3628zFnXLAHakynmae1pW6/lEhgoOwmU9eTLzow
         8BO+eamEGUrI0aB123181fnbzBAVuOMdOI4iy/E/xxS/UghZVEc4z+XJsfFkQgeVVNYG
         SBpg==
X-Gm-Message-State: AOAM530573u0xVvMX1iHbIatjNoJ4IIXD9drxmYz6bIpbUe4B9ZJtQY5
        BFQFz/Wbzkf3W6iTIHgiw22rKw==
X-Google-Smtp-Source: ABdhPJzmc6/NJff0Sm3rbmqK1nxAsS4Dop9m6dDQ/g6IQL92H1Yi9bEtreP48/OEf/wIlvwcFgTZEA==
X-Received: by 2002:a37:8984:: with SMTP id l126mr24770919qkd.443.1604502358803;
        Wed, 04 Nov 2020 07:05:58 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c12sm269499qtp.14.2020.11.04.07.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:05:57 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:05:57 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 4/7] rcu/trace: Add tracing for how segcb list changes
Message-ID: <20201104150557.GC2313912@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-5-joel@joelfernandes.org>
 <58c89893-1bf7-29bb-7f97-2e48755e8dd7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c89893-1bf7-29bb-7f97-2e48755e8dd7@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 04, 2020 at 07:10:17PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 11/3/2020 7:56 PM, Joel Fernandes (Google) wrote:
> > Track how the segcb list changes before/after acceleration, during
> > queuing and during dequeuing.
> > 
> > This has proved useful to discover an optimization to avoid unwanted GP
> > requests when there are no callbacks accelerated. The overhead is minimal as
> > each segment's length is now stored in the respective segment.
> > 
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >   include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
> >   kernel/rcu/rcu_segcblist.c | 34 ++++++++++++++++++++++++++++++++++
> >   kernel/rcu/rcu_segcblist.h |  5 +++++
> >   kernel/rcu/tree.c          |  9 +++++++++
> >   4 files changed, 73 insertions(+)
> > 
> > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > index 155b5cb43cfd..5f8f2ee1a936 100644
> > --- a/include/trace/events/rcu.h
> > +++ b/include/trace/events/rcu.h
> > @@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
> >   		  __entry->qlen)
> >   );
> > +TRACE_EVENT_RCU(rcu_segcb_stats,
> > +
> > +		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),
> 
> I think we need to use long[] instead of int[] for cb_count everywhere in
> this patch?

More than 4 billion callbacks on a single cblist sounds like a bug though so
int should work. Plus I prefer to keep the tracepoint size small (on 64-bit
systems, long is 64 bits, int is 32 bits).

Thanks for all the reviews on this and other patches!

 - Joel


> 
> 
> Thanks
> Neeraj
> 
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
> >   /*
> >    * Tracepoint for the registration of a single RCU callback of the special
> >    * kvfree() form.  The first argument is the RCU type, the second argument
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 357c19bbcb00..2a03949d0b82 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/types.h>
> >   #include "rcu_segcblist.h"
> > +#include "rcu.h"
> >   /* Initialize simple callback list. */
> >   void rcu_cblist_init(struct rcu_cblist *rclp)
> > @@ -328,6 +329,39 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
> >   	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
> >   }
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
> > +
> > +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context)
> > +{
> > +	int cbs[RCU_CBLIST_NSEGS];
> > +	unsigned long gps[RCU_CBLIST_NSEGS];
> > +
> > +	if (!trace_rcu_segcb_stats_enabled())
> > +		return;
> > +
> > +	rcu_segcblist_countseq(rsclp, cbs, gps);
> > +
> > +	trace_rcu_segcb_stats(context, cbs, gps);
> > +}
> > +#endif
> > +
> >   /*
> >    * Extract only those callbacks still pending (not yet ready to be
> >    * invoked) from the specified rcu_segcblist structure and place them in
> > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > index cd35c9faaf51..7750734fa116 100644
> > --- a/kernel/rcu/rcu_segcblist.h
> > +++ b/kernel/rcu/rcu_segcblist.h
> > @@ -103,3 +103,8 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
> >   bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
> >   void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
> >   			 struct rcu_segcblist *src_rsclp);
> > +#ifdef CONFIG_RCU_TRACE
> > +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context);
> > +#else
> > +#define __trace_rcu_segcb_stats(...)
> > +#endif
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 24c00020ab83..f6c6653b3ec2 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1497,6 +1497,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
> >   	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
> >   		return false;
> > +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPreAcc"));
> > +
> >   	/*
> >   	 * Callbacks are often registered with incomplete grace-period
> >   	 * information.  Something about the fact that getting exact
> > @@ -1517,6 +1519,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
> >   	else
> >   		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
> > +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPostAcc"));
> > +
> >   	return ret;
> >   }
> > @@ -2466,11 +2470,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >   	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
> >   	if (offloaded)
> >   		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
> > +
> > +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
> >   	rcu_nocb_unlock_irqrestore(rdp, flags);
> >   	/* Invoke callbacks. */
> >   	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
> >   	rhp = rcu_cblist_dequeue(&rcl);
> > +
> >   	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> >   		rcu_callback_t f;
> > @@ -2983,6 +2990,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
> >   		trace_rcu_callback(rcu_state.name, head,
> >   				   rcu_segcblist_n_cbs(&rdp->cblist));
> > +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
> > +
> >   	/* Go handle any RCU core processing required. */
> >   	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
> >   		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
> > 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> the Code Aurora Forum, hosted by The Linux Foundation
