Return-Path: <SRS0=HAhG=EB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36658C4363A
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 11:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7C022265
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 11:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603713557;
	bh=fSvCbWkOYAE55YrySkaKg42rvS6y1QT5lH2vxbsz9KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b3TmP8k5pP72mkT/eyNGYYDajbz/NReAri9f1nm3VOdDx7AoTHkx4lhgeP4C+kvyC
	 4pDxodMD2iNN3C07YyCfJWCH7ELf5o103zyX0c3DGGJ/1pkAx0Y/b3GPxyb9pi+Ee5
	 va34MgxS2mBRoQxKDUOnGQEf7aWkjC382MuJSI1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774102AbgJZL7Q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 26 Oct 2020 07:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768339AbgJZL7Q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 26 Oct 2020 07:59:16 -0400
Received: from localhost (unknown [176.177.109.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9567D22263;
        Mon, 26 Oct 2020 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603713556;
        bh=fSvCbWkOYAE55YrySkaKg42rvS6y1QT5lH2vxbsz9KA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWz8/Bl8lCNaNNrtXVx4kCA89iMjsDqAAayiF4V3CcAmVi1fBj8fx+GZjg4Axky2t
         riCp4lEZ+QLX85p6rbfm+MRRCz54qYBz7j9Vkp9cr4RsQy2bzpiEv+fiDM0U0MC/Gj
         K6BNLO1eIUMj+uBEsRhhoNtq6y93jUL86yFStpZ0=
Date:   Mon, 26 Oct 2020 12:59:13 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Message-ID: <20201026115913.GE104441@lothringen>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
 <20201021190813.3005054-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021190813.3005054-4-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 21, 2020 at 03:08:10PM -0400, Joel Fernandes (Google) wrote:
> Track how the segcb list changes before/after acceleration, during
> queuing and during dequeuing.
> 
> This has proved useful to discover an optimization to avoid unwanted GP
> requests when there are no callbacks accelerated. The overhead is minimal as
> each segment's length is now stored in the respective segment.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
>  kernel/rcu/rcu_segcblist.c | 31 +++++++++++++++++++++++++++++++
>  kernel/rcu/rcu_segcblist.h |  5 +++++
>  kernel/rcu/tree.c          |  9 +++++++++
>  4 files changed, 70 insertions(+)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 155b5cb43cfd..9f2237d9b0c8 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
>  		  __entry->qlen)
>  );
>  
> +TRACE_EVENT_RCU(rcu_segcb,

You might extend the segcblist tracing in the future to trace queue/dequeue/merge whatever...
Which would give trace_rcu_segcb_queue, trace_rcu_segcb_dequeue, etc...

So I suggest you rename this one to something like rcu_segcb_stats for precision.


> +
> +		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),
> +
> +		TP_ARGS(ctx, cb_count, gp_seq),
> +
> +		TP_STRUCT__entry(
> +			__field(const char *, ctx)
> +			__array(int, cb_count, RCU_CBLIST_NSEGS)
> +			__array(unsigned long, gp_seq, RCU_CBLIST_NSEGS)
> +		),
> +
> +		TP_fast_assign(
> +			__entry->ctx = ctx;
> +			memcpy(__entry->cb_count, cb_count, RCU_CBLIST_NSEGS * sizeof(int));
> +			memcpy(__entry->gp_seq, gp_seq, RCU_CBLIST_NSEGS * sizeof(unsigned long));
> +		),
> +
> +		TP_printk("%s cb_count: (DONE=%d, WAIT=%d, NEXT_READY=%d, NEXT=%d) "
> +			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
> +			  __entry->cb_count[0], __entry->cb_count[1], __entry->cb_count[2], __entry->cb_count[3],
> +			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
> +
> +);
> +
>  /*
>   * Tracepoint for the registration of a single RCU callback of the special
>   * kvfree() form.  The first argument is the RCU type, the second argument
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 357c19bbcb00..b0aaa51e0ee6 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  
>  #include "rcu_segcblist.h"
> +#include "rcu.h"
>  
>  /* Initialize simple callback list. */
>  void rcu_cblist_init(struct rcu_cblist *rclp)
> @@ -328,6 +329,36 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
>  }
>  
> +/*
> + * Return how many CBs each segment along with their gp_seq values.
> + *
> + * This function is O(N) where N is the number of segments. Only used from
> + * tracing code which is usually disabled in production.
> + */
> +#ifdef CONFIG_RCU_TRACE
> +static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> +			 int cbcount[RCU_CBLIST_NSEGS],
> +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> +{
> +	int i;
> +
> +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> +		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
> +		gpseq[i] = rsclp->gp_seq[i];
> +	}
> +}

So that is called all the time even if the trace event isn't enabled. The
goal of trace events are also to avoid the overhead of tracing when its off.

This should be moved inside the trace event definition. We can even avoid the
loop altogether.

Thanks.
