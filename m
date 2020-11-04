Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A47C2D0A3
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 14:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6299220735
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604500398;
	bh=NnJp6WqQ75IUkNYbLiM6d+6tCT5wOFaumDU8S+0D34c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z7TQVUxGdFY6aXvDlqxDoi8otF5MyTvKDrABbdVsNymIsiKkQT6h2czYVBXcP0GUg
	 1DZLvaw5WzE41lOPEQllPbjh8HpxOK3RR2lbla0ovBPXC99OR9BJmdPkkLUo0LqPJL
	 ZeLNu99jMPQmy70e3la8w/5pdWpprVxXMi5RoW8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgKDOdS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:33:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgKDOdR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Nov 2020 09:33:17 -0500
Received: from localhost (bag30-h01-176-173-247-136.dsl.sta.abo.bbox.fr [176.173.247.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15C4120709;
        Wed,  4 Nov 2020 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604500397;
        bh=NnJp6WqQ75IUkNYbLiM6d+6tCT5wOFaumDU8S+0D34c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SP5EY6nH1v+xZDf2xOWaLYt3eAFZDnPEjYfODepKd5fniGVt42rqj5ApSyYJAAnu3
         zLpgg6sDJcK22r3XemA1/t2lAvIbdhCplWA6d7zCLE2vNDTfsVBqHieAIuh1czXWzm
         C4w0zQJiiEU8P9vBnRdbv5sTsZB1zBVav4hAj5K0=
Date:   Wed, 4 Nov 2020 15:33:14 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
Message-ID: <20201104143314.GC467220@lothringen>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-5-joel@joelfernandes.org>
 <20201103151731.GB432431@lothringen>
 <20201104140807.GG3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104140807.GG3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 04, 2020 at 06:08:07AM -0800, Paul E. McKenney wrote:
> On Tue, Nov 03, 2020 at 04:17:31PM +0100, Frederic Weisbecker wrote:
> > On Tue, Nov 03, 2020 at 09:26:00AM -0500, Joel Fernandes (Google) wrote:
> > > +/*
> > > + * Return how many CBs each segment along with their gp_seq values.
> > > + *
> > > + * This function is O(N) where N is the number of segments. Only used from
> > > + * tracing code which is usually disabled in production.
> > > + */
> > > +#ifdef CONFIG_RCU_TRACE
> > > +static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> > > +			 int cbcount[RCU_CBLIST_NSEGS],
> > > +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> > > +		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
> > > +		gpseq[i] = rsclp->gp_seq[i];
> > > +	}
> > > +}
> > > +
> > > +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context)
> > > +{
> > > +	int cbs[RCU_CBLIST_NSEGS];
> > > +	unsigned long gps[RCU_CBLIST_NSEGS];
> > > +
> > > +	if (!trace_rcu_segcb_stats_enabled())
> > > +		return;
> > 
> > Yes, very good!
> > 
> > Paul just told me that RCU_TRACE can be used in production so that confirms that we
> > wanted to avoid this loop of 8 iterations when tracing is disabled.
> 
> RCU's "don't try this in production" Kconfig option is PROVE_RCU.
> 
> I would be looking for checks that the sum of the segment lengths
> match the overall ->len or checks that all of the segment lengths
> are zero when ->cblist is empty to be guarded by something like
> IS_ENABLED(CONFIG_PROVE_RCU).  Of course, checks of this sort need to
> be confined to those portions of rcu_do_batch() that are excluding other
> accesses to ->cblist.

Right.

> 
> But if rcu_segcblist_countseq() is invoked only when a specific trace
> event is enabled, it should be OK to have it guarded only by RCU_TRACE.

Indeed, so I think we are good.

Thanks.
