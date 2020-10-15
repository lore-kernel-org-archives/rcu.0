Return-Path: <SRS0=9/AT=DW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C23C43457
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 01:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF6122257
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 01:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bJzkxm0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbgJOBZD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgJOBYh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Oct 2020 21:24:37 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224B5C00458A
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 17:05:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k25so1988215ioh.7
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 17:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RaJUMBdT2vxBU1j2obI4LFP8P80zs2l0P5aAqZ2WLF0=;
        b=bJzkxm0K/IzzvatIMWA1ysFrNM6taqwwEYD+cYIhm1P6swAyEUV6ofOSn+al809XUp
         XkrherYBHYP0//YIcRFWvVVk1p8sAQdQzxcjZ/UxGYzlbfgiZN6eD/QctzEa1AQ9zz6h
         N0xuTdcJuLzxBtLAs4a6ckvC+WrNdJMRgTVc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RaJUMBdT2vxBU1j2obI4LFP8P80zs2l0P5aAqZ2WLF0=;
        b=T0zNDIPThECSktQEJyhZEIiC7sDEfQDXMSOHF3Da4+4eaaOsAJQMQ/SZbcDGiZfMg4
         1Gy2kMtl6ulfdc6EtUqHUp+kMUiX8gGkGgXU5/D8lAaNlGBZE/ypBH/0XpPTArNY6CZt
         jzS59k3whWPXcTvCGMs0dFm4ffYQGbajfj23YsiZLg+rYUVsxgo7FPXrKooBwaKasakq
         Pi3SIp3KlK+fYNdJ4//gEnA+Vex6j9FRpv1mEfsIO2UXrgW9V9nIfm6cXhqE0ofYMJH0
         dD5HwF30Ae86+hQGSPHdV3/+Pq0KfQ1j+ZQN+dqiidT9dL6JKvr0JPHLM77pvkgegs0f
         alhQ==
X-Gm-Message-State: AOAM531vwY++A3AjJJ5kFMSsiKEJN/YRm973rV0YY2269tNL8uYT15DF
        +LMUxJtzkDN/THAjxy3WKbDwjQ==
X-Google-Smtp-Source: ABdhPJznhnFyOcbseZmoYi9B7OzTng6gMty30H4KjVxABrz1sNj/Ie0R8K7RiLBDROggp+Qdf+O8Yw==
X-Received: by 2002:a5d:96ce:: with SMTP id r14mr1360757iol.146.1602720304339;
        Wed, 14 Oct 2020 17:05:04 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id b17sm974121ilo.86.2020.10.14.17.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:05:03 -0700 (PDT)
Date:   Wed, 14 Oct 2020 20:05:03 -0400
From:   joel@joelfernandes.org
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH v6 3/4] rcu/trace: Add tracing for how segcb list changes
Message-ID: <20201015000503.GB4025103@google.com>
References: <20200923152211.2403352-1-joel@joelfernandes.org>
 <20200923152211.2403352-4-joel@joelfernandes.org>
 <be9eb8bc-b776-e122-2182-ca2aac2d1e20@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be9eb8bc-b776-e122-2182-ca2aac2d1e20@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 14, 2020 at 08:52:17PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 9/23/2020 8:52 PM, Joel Fernandes (Google) wrote:
> > Track how the segcb list changes before/after acceleration, during
> > queuing and during dequeuing.
> > 
> > This has proved useful to discover an optimization to avoid unwanted GP
> > requests when there are no callbacks accelerated. The overhead is minimal as
> > each segment's length is now stored in the respective segment.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >   include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
> >   kernel/rcu/rcu_segcblist.c | 34 ++++++++++++++++++++++++++++++++++
> >   kernel/rcu/rcu_segcblist.h |  5 +++++
> >   kernel/rcu/tree.c          |  9 +++++++++
> >   4 files changed, 73 insertions(+)
> > 
> > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > index 155b5cb43cfd..7b84df3c95df 100644
> > --- a/include/trace/events/rcu.h
> > +++ b/include/trace/events/rcu.h
> > @@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
> >   		  __entry->qlen)
> >   );
> > +TRACE_EVENT_RCU(rcu_segcb,
> > +
> > +		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),
> > +
> > +		TP_ARGS(ctx, cb_count, gp_seq),
> > +
> > +		TP_STRUCT__entry(
> > +			__field(const char *, ctx)
> > +			__array(int, cb_count, 4)
> > +			__array(unsigned long, gp_seq, 4)
> 
> Use RCU_CBLIST_NSEGS in place of 4 ?

Done.

> > +		),
> > +
> > +		TP_fast_assign(
> > +			__entry->ctx = ctx;
> > +			memcpy(__entry->cb_count, cb_count, 4 * sizeof(int));
> > +			memcpy(__entry->gp_seq, gp_seq, 4 * sizeof(unsigned long));
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
> > index 0e6d19bd3de9..df0f31e30947 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -13,6 +13,7 @@
> >   #include <linux/rcupdate.h>
> >   #include "rcu_segcblist.h"
> > +#include "rcu.h"
> >   /* Initialize simple callback list. */
> >   void rcu_cblist_init(struct rcu_cblist *rclp)
> > @@ -343,6 +344,39 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
> >   	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
> >   }
> > +/*
> > + * Return how many CBs each segment along with their gp_seq values.
> > + *
> > + * This function is O(N) where N is the number of callbacks. Only used from
> 
> N is number of segments?

Yes, will fix.

> > + * tracing code which is usually disabled in production.
> > + */
> > +#ifdef CONFIG_RCU_TRACE
> > +static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> > +			 int cbcount[RCU_CBLIST_NSEGS],
> > +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
> > +		cbcount[i] = 0;
> > +
> 
> What is the reason for initializing to 0?

You are right, not needed. I'll remove.

> > +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> > +		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
> > +		gpseq[i] = rsclp->gp_seq[i];
> > +	}
> > +}
> > +
> > +void trace_rcu_segcb_list(struct rcu_segcblist *rsclp, char *context)
> > +{
> > +	int cbs[RCU_CBLIST_NSEGS];
> > +	unsigned long gps[RCU_CBLIST_NSEGS];
> > +
> > +	rcu_segcblist_countseq(rsclp, cbs, gps);
> > +
> > +	trace_rcu_segcb(context, cbs, gps);
> > +}
> > +#endif
> > +
> >   /*
> >    * Extract only those callbacks still pending (not yet ready to be
> >    * invoked) from the specified rcu_segcblist structure and place them in
> > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > index 3e0eb1056ae9..15c10d30f88c 100644
> > --- a/kernel/rcu/rcu_segcblist.h
> > +++ b/kernel/rcu/rcu_segcblist.h
> > @@ -103,3 +103,8 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
> >   bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
> >   void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
> >   			 struct rcu_segcblist *src_rsclp);
> > +#ifdef CONFIG_RCU_TRACE
> > +void trace_rcu_segcb_list(struct rcu_segcblist *rsclp, char *context);
> > +#else
> > +#define trace_rcu_segcb_list(...)
> > +#endif
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 50af465729f4..e3381ff67fc6 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1492,6 +1492,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
> >   	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
> >   		return false;
> > +	trace_rcu_segcb_list(&rdp->cblist, "SegCbPreAcc");
> 
> Use TPS("SegCbPreAcc") ?

Fixed, thanks!

thanks,

 - Joel

> 
> 
> Thanks
> Neeraj
> 
> > +
> >   	/*
> >   	 * Callbacks are often registered with incomplete grace-period
> >   	 * information.  Something about the fact that getting exact
> > @@ -1512,6 +1514,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
> >   	else
> >   		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
> > +	trace_rcu_segcb_list(&rdp->cblist, "SegCbPostAcc");
> > +
> >   	return ret;
> >   }
> > @@ -2469,6 +2473,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >   	/* Invoke callbacks. */
> >   	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
> >   	rhp = rcu_cblist_dequeue(&rcl);
> > +
> > +	trace_rcu_segcb_list(&rdp->cblist, "SegCbDequeued");
> > +
> >   	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> >   		rcu_callback_t f;
> > @@ -2982,6 +2989,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
> >   		trace_rcu_callback(rcu_state.name, head,
> >   				   rcu_segcblist_n_cbs(&rdp->cblist));
> > +	trace_rcu_segcb_list(&rdp->cblist, "SegCBQueued");
> > +
> >   	/* Go handle any RCU core processing required. */
> >   	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> >   	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
> > 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> the Code Aurora Forum, hosted by The Linux Foundation
