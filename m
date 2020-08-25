Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C43C433E1
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 22:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518E42075F
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 22:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BEu8CJSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHYWxP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgHYWxM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Aug 2020 18:53:12 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B3BC061574
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2020 15:53:12 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 92so3760qtb.6
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2020 15:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WEE3G9povgJWPCtYpPqFiQBf651eDMpa+71/slW/h98=;
        b=BEu8CJSVBli/z0qbfaqpochzBmN0GZzDkrHjJSWt89ZURiB0L2nUlQbj+fuo8tW1TT
         5/BBKHljCrW0hTKQK5nU0M59+rb/NPI1E+Elvt5t5HcF6lkkv/Bqrqm+0DrrAs4rCjXX
         XbGLNvOqk5K8KNTCFJ4zAlT1VVk5lGBMBfDKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WEE3G9povgJWPCtYpPqFiQBf651eDMpa+71/slW/h98=;
        b=r+J6pLiSMQhowLCPRZob37oLxGc6K6SWboycd2JITP9R7a2i+OSygdr9eShIUjqrs3
         +PwyMBuVpp2jfjVmF6Cp9CdwYkZU6IJYpUuuMCGzcFrKqYiMtGdjmA92q6jMPHPtFJVs
         +2qsKpRo5Zx5RUlmBkSY7BE0FkDBRj00+fkCLgHEeO/t9OcE+OvFL378nrc1FCEPMy5G
         O7Vkia9R8cDXgLlov54IUX9oTUuBuQEf+peL0rOY+7U5xP0nRsjYW8e4EY9VRVkkJVH1
         PYlo2i9gKoYIviK4ejYFglIm50y1xGHwTGIW5gLKy6r3FT9o4Fz2wWj1np6OIfv9/Ywc
         WoqA==
X-Gm-Message-State: AOAM530HwFODwi1RRpkP6O/ApW+l3qykzgsTTB7k1USvgkaoHDNvCtg/
        KZlSkDMf+TW8vAPobJ6r+woLfg==
X-Google-Smtp-Source: ABdhPJy/rtz/jM7D4+DuSv7oTaW8xYvaWG7TlTJV3jYQ2IVRSMNT+lcrvzaxz70DvqzIquKijC+STg==
X-Received: by 2002:ac8:6bc2:: with SMTP id b2mr11687288qtt.115.1598395991672;
        Tue, 25 Aug 2020 15:53:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id i14sm424928qtq.33.2020.08.25.15.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 15:53:11 -0700 (PDT)
Date:   Tue, 25 Aug 2020 18:53:10 -0400
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
Subject: Re: [PATCH v4 -rcu 4/4] rcu/trace: Add tracing for how segcb list
 changes
Message-ID: <20200825225310.GD579506@google.com>
References: <20200825024842.3408659-1-joel@joelfernandes.org>
 <20200825024842.3408659-5-joel@joelfernandes.org>
 <20200825215553.GB16846@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825215553.GB16846@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 25, 2020 at 02:55:53PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 24, 2020 at 10:48:42PM -0400, Joel Fernandes (Google) wrote:
> > Track how the segcb list changes before/after acceleration, during
> > queuing and during dequeuing.
> > 
> > This has proved useful to discover an optimization to avoid unwanted GP
> > requests when there are no callbacks accelerated. The overhead is minimal as
> > each segment's length is now stored in the respective segment.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Speaking of tracing, diagnostics, and debugging, a few instances of
> ASSERT_EXCLUSIVE_WRITER() in the previous patch might save a lot
> of debugging.  Help KCSAN help us.

Ok, I will look into it, thanks.

> >  include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
> >  kernel/rcu/rcu_segcblist.c | 27 +++++++++++++++++++++++++++
> >  kernel/rcu/rcu_segcblist.h |  7 +++++++
> >  kernel/rcu/tree.c          | 23 +++++++++++++++++++++++
> >  4 files changed, 82 insertions(+)
> > 
> > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > index 155b5cb43cfd..7b84df3c95df 100644
> > --- a/include/trace/events/rcu.h
> > +++ b/include/trace/events/rcu.h
> > @@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
> >  		  __entry->qlen)
> >  );
> >  
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
> >  /*
> >   * Tracepoint for the registration of a single RCU callback of the special
> >   * kvfree() form.  The first argument is the RCU type, the second argument
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 73a103464ea4..6419dbbaecde 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -378,6 +378,33 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
> >  	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
> >  }
> >  
> > +/*
> > + * Return how many CBs each segment along with their gp_seq values.
> > + *
> > + * This function is O(N) where N is the number of callbacks. Only used from
> > + * tracing code which is usually disabled in production.
> > + */
> > +#ifdef CONFIG_RCU_TRACE
> > +void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> > +			 int cbcount[RCU_CBLIST_NSEGS],
> > +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> > +{
> 
> Why not declare the arrays here and invoke the new trace event from
> here also?  That would simplify the usage and save a few lines of code.

True! I will do it that way.

thanks,

 - Joel

