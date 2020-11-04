Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D37C2D0A3
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 14:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C502922280
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 14:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604498889;
	bh=Yvx2fvQyrz3qOckMm40aznFs4/Y5f0uOs+ZW1GEZBEA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=D3449d9IEzs7S/wnkcT+rpRucAHkbaYDgccJeW9wB0EveRAsugEeLWpmDUQRYsiEI
	 aY/t0vT0TZTX4huc2DVSaei2J5zEdJ2qfrEjA9Jj8E0w38EUZahetge9Ws2GUbpGZ+
	 tXD1aP7df0mDM5BWYYH6Or6Y7FMCppZTovTzzSwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgKDOIJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgKDOII (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Nov 2020 09:08:08 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E23821734;
        Wed,  4 Nov 2020 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498888;
        bh=Yvx2fvQyrz3qOckMm40aznFs4/Y5f0uOs+ZW1GEZBEA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wW6kBfrVC3gwxm3yJ6vQj6FKNi/EiXR4kQ1OS51RNJexL9W0MwcRrpDUa77WCvX7Z
         zVERx2xtJLZBsDjhSpRdRLxG3X1lPqNhtlnMv7kecWMl2NBb3cuHYnDtYJ1aTZFz3k
         xZc/xTSl/BMLmExpz3LfIt956Y/SB8v5gGVG3/M0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B5A823523170; Wed,  4 Nov 2020 06:08:07 -0800 (PST)
Date:   Wed, 4 Nov 2020 06:08:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20201104140807.GG3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-5-joel@joelfernandes.org>
 <20201103151731.GB432431@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103151731.GB432431@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 03, 2020 at 04:17:31PM +0100, Frederic Weisbecker wrote:
> On Tue, Nov 03, 2020 at 09:26:00AM -0500, Joel Fernandes (Google) wrote:
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
> 
> Yes, very good!
> 
> Paul just told me that RCU_TRACE can be used in production so that confirms that we
> wanted to avoid this loop of 8 iterations when tracing is disabled.

RCU's "don't try this in production" Kconfig option is PROVE_RCU.

I would be looking for checks that the sum of the segment lengths
match the overall ->len or checks that all of the segment lengths
are zero when ->cblist is empty to be guarded by something like
IS_ENABLED(CONFIG_PROVE_RCU).  Of course, checks of this sort need to
be confined to those portions of rcu_do_batch() that are excluding other
accesses to ->cblist.

But if rcu_segcblist_countseq() is invoked only when a specific trace
event is enabled, it should be OK to have it guarded only by RCU_TRACE.

							Thanx, Paul
