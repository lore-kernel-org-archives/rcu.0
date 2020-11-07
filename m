Return-Path: <SRS0=tft6=EN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D94C2D0A3
	for <rcu@archiver.kernel.org>; Sat,  7 Nov 2020 00:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7848E20867
	for <rcu@archiver.kernel.org>; Sat,  7 Nov 2020 00:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="o+89ZlxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgKGAFg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Nov 2020 19:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgKGAFf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Nov 2020 19:05:35 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8904FC0613CF
        for <rcu@vger.kernel.org>; Fri,  6 Nov 2020 16:05:35 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f93so2075766qtb.10
        for <rcu@vger.kernel.org>; Fri, 06 Nov 2020 16:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JorTLQYfJmqKUvOKFo8KKJVtVEGA/9Yc7a4QfxtP1Lo=;
        b=o+89ZlxTW1nJ5BQd7qa2XH1DGDfxbEDia6wyJzH083Qv2aSev2juVUV88JQp5hkd5I
         EJilrpTPdgGPgJ+ByU5CNt7P78xCKqnEWstoF0y7W0eGRELTdxNHvxVm1fPpNR9Ux2k+
         2E9oUQTZwIxifM1LVM0C0nyUfsrucm9L9m1jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JorTLQYfJmqKUvOKFo8KKJVtVEGA/9Yc7a4QfxtP1Lo=;
        b=SgqyonXBZgQ7KV4Wy3TE76aW6h1J7lJotbsoqk2ZO9yod1RHb24vXHr/RZxoh5wPcG
         OsbfNYzPwRa0nqvGjgLCLYeCdfF2UhCdfCFa4eec2o8wTBnAm+1t0BPhWBzzqI/SwwcR
         fe5V8cxu5zFryETCkUZRDoiAmqpEJpdVGJ3q00sOK00bEL6L05bcVsJvlxg94UkcJ5dt
         olaDpKzsRdSsmzL7OBpcXHGCWZTrIKC1ZXHQzuBzI+QC6H6MrdK99sLQ2yIzUKLHea8E
         siAuYR1fzP0ahOuZ9o8S7gecg6Z3CDQ4cKE5qe129PEBXBlO6vj166cOUN0T1pkDOG0o
         RZjg==
X-Gm-Message-State: AOAM531FKqocPO74+25NZVoZNDL9QKWADExrGfQR0TbNDLxjs4uncMVq
        z22Q4L9n9Kc+qFZRX8125lBtAQ==
X-Google-Smtp-Source: ABdhPJxPCQLg9SA4ml8yJIvefMevgu24JnPmsyw88DCcDEU7GoWFoQkcYXpNISvIb0uW4UfPpYx1iw==
X-Received: by 2002:aed:22bc:: with SMTP id p57mr4087920qtc.242.1604707534667;
        Fri, 06 Nov 2020 16:05:34 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d48sm1682236qta.26.2020.11.06.16.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 16:05:33 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:05:33 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 4/7] rcu/trace: Add tracing for how segcb list changes
Message-ID: <20201107000533.GC1397669@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-5-joel@joelfernandes.org>
 <20201103151731.GB432431@lothringen>
 <20201104140807.GG3249@paulmck-ThinkPad-P72>
 <20201104143314.GC467220@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104143314.GC467220@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 04, 2020 at 03:33:14PM +0100, Frederic Weisbecker wrote:
> On Wed, Nov 04, 2020 at 06:08:07AM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 03, 2020 at 04:17:31PM +0100, Frederic Weisbecker wrote:
> > > On Tue, Nov 03, 2020 at 09:26:00AM -0500, Joel Fernandes (Google) wrote:
> > > > +/*
> > > > + * Return how many CBs each segment along with their gp_seq values.
> > > > + *
> > > > + * This function is O(N) where N is the number of segments. Only used from
> > > > + * tracing code which is usually disabled in production.
> > > > + */
> > > > +#ifdef CONFIG_RCU_TRACE
> > > > +static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> > > > +			 int cbcount[RCU_CBLIST_NSEGS],
> > > > +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> > > > +		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
> > > > +		gpseq[i] = rsclp->gp_seq[i];
> > > > +	}
> > > > +}
> > > > +
> > > > +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context)
> > > > +{
> > > > +	int cbs[RCU_CBLIST_NSEGS];
> > > > +	unsigned long gps[RCU_CBLIST_NSEGS];
> > > > +
> > > > +	if (!trace_rcu_segcb_stats_enabled())
> > > > +		return;
> > > 
> > > Yes, very good!
> > > 
> > > Paul just told me that RCU_TRACE can be used in production so that confirms that we
> > > wanted to avoid this loop of 8 iterations when tracing is disabled.
> > 
> > RCU's "don't try this in production" Kconfig option is PROVE_RCU.
> > 
> > I would be looking for checks that the sum of the segment lengths
> > match the overall ->len or checks that all of the segment lengths
> > are zero when ->cblist is empty to be guarded by something like
> > IS_ENABLED(CONFIG_PROVE_RCU).  Of course, checks of this sort need to
> > be confined to those portions of rcu_do_batch() that are excluding other
> > accesses to ->cblist.
> 
> Right.
> 
> > 
> > But if rcu_segcblist_countseq() is invoked only when a specific trace
> > event is enabled, it should be OK to have it guarded only by RCU_TRACE.
> 
> Indeed, so I think we are good.

Thanks, so the only changes are to patches 2/7 and 4/7 which I will work on.
1/7 was already taken by Paul. For 7/7, it sounds like I did not understand
Paul's reworks on the comments and we're still discussing it; but some
comments are better than none, so I am Ok with Pauls version of it.

thanks,

 - Joel

