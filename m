Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C7CC5517A
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 13:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B9E2072C
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 13:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgKKNuI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgKKNtp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Nov 2020 08:49:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC5CC2072C;
        Wed, 11 Nov 2020 13:49:43 +0000 (UTC)
Date:   Wed, 11 Nov 2020 08:49:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        fweisbec@gmail.com, neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 4/7] rcu/trace: Add tracing for how segcb list
 changes
Message-ID: <20201111084941.1db1b324@gandalf.local.home>
In-Reply-To: <20201111003530.GA10251@paulmck-ThinkPad-P72>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
        <20201103142603.1302207-5-joel@joelfernandes.org>
        <20201111003530.GA10251@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 10 Nov 2020 16:35:30 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context)
> > +{
> > +	int cbs[RCU_CBLIST_NSEGS];
> > +	unsigned long gps[RCU_CBLIST_NSEGS];
> > +
> > +	if (!trace_rcu_segcb_stats_enabled())
> > +		return;  
> 
> Can't you rely on the trace system to enable and disable this trace
> event?  If the thought is to save instructions, then moving all this
> into TP_fast_assign() enables the trace system to deal with that as well.
> 
> > +	rcu_segcblist_countseq(rsclp, cbs, gps);
> > +
> > +	trace_rcu_segcb_stats(context, cbs, gps);
> > +}
> > +#endif

Yeah, I agree with Paul. I think it is possible to move this all into the
TP_fast_assign. If you have trouble doing so, let me know.

-- Steve
