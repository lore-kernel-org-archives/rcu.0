Return-Path: <SRS0=7B7l=BU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE19C433E0
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 17:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90BE208E4
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 17:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597082239;
	bh=k3MjZ6XxaVvaOS3cbVAXkz+PUn0Cc+I/FN8m/6d5GPA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=h4LDPInoo8x7p+2Lns1Rnf37p0dM/5hdk5bfXLm5y1V/3IrnTu5XWoBVXB2euVQUH
	 y1DPHRzcHyJ3LePN+2n1TPaPvs4RQZP+74EIga8MHHaJAZviLojtR15qF7NbVOxzAO
	 63YSNiSo87neCI7Ixx4V99vAH6ulpC6TwSxaAKhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgHJR5T (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgHJR5T (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Aug 2020 13:57:19 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A6B620866;
        Mon, 10 Aug 2020 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597082238;
        bh=k3MjZ6XxaVvaOS3cbVAXkz+PUn0Cc+I/FN8m/6d5GPA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PX4NIdaDL9nliQXjykosBBnoC2HgYkGI2QIGSsLZaAgZRP71kueVIZPomm0JpBra/
         d5MCf+/Cxf6n2h2WmviE/Q6RVnTaEHN+2pj5yoCxE3WLglbqhWycWs+7lX/VPDHH4Q
         0moOWyIfb0PEzJUHFX8QiZmbdzbMh9K79CIRV4Ng=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B277135228C7; Mon, 10 Aug 2020 10:57:17 -0700 (PDT)
Date:   Mon, 10 Aug 2020 10:57:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        peterz@infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, vineethrp@gmail.com
Subject: Re: [PATCH v4 1/5] rcu/tree: Add a warning if CPU being onlined did
 not report QS already
Message-ID: <20200810175717.GM4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200807170722.2897328-1-joel@joelfernandes.org>
 <20200807170722.2897328-2-joel@joelfernandes.org>
 <20200810154654.GJ4295@paulmck-ThinkPad-P72>
 <20200810173931.GB2253395@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810173931.GB2253395@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 10, 2020 at 01:39:31PM -0400, Joel Fernandes wrote:
> On Mon, Aug 10, 2020 at 08:46:54AM -0700, Paul E. McKenney wrote:
> > On Fri, Aug 07, 2020 at 01:07:18PM -0400, Joel Fernandes (Google) wrote:
> > > Currently, rcu_cpu_starting() checks to see if the RCU core expects a
> > > quiescent state from the incoming CPU.  However, the current interaction
> > > between RCU quiescent-state reporting and CPU-hotplug operations should
> > > mean that the incoming CPU never needs to report a quiescent state.
> > > First, the outgoing CPU reports a quiescent state if needed.  Second,
> > > the race where the CPU is leaving just as RCU is initializing a new
> > > grace period is handled by an explicit check for this condition.  Third,
> > > the CPU's leaf rcu_node structure's ->lock serializes these checks.
> > > 
> > > This means that if rcu_cpu_starting() ever feels the need to report
> > > a quiescent state, then there is a bug somewhere in the CPU hotplug
> > > code or the RCU grace-period handling code.  This commit therefore
> > > adds a WARN_ON_ONCE() to bring that bug to everyone's attention.
> > > 
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 65e1b5e92319..a49fa3b60faa 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3996,7 +3996,14 @@ void rcu_cpu_starting(unsigned int cpu)
> > >  	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
> > >  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> > >  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> > > -	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
> > > +
> > > +	/*
> > > +	 * XXX: The following rcu_report_qs_rnp() is redundant. If the below
> > > +	 * warning does not fire, consider replacing it with the "else" block,
> > > +	 * by June 2021 or so (while keeping the warning). Refer to RCU's
> > > +	 * Requirements documentation for the rationale.
> > 
> > Let's suppose that this change is made, and further that in a year or
> > two the "if" statement below is replaced with its "else" block.
> > 
> > Now let's suppose that (some years after that) a hard-to-trigger bug
> > makes its way into RCU's CPU-hotplug code that would have resulted in
> > the WARN_ON_ONCE() triggering, but that this bug turns out to be not so
> > hard to trigger in certain large production environments.
> > 
> > Let's suppose further that you have moved on to where you are responsible
> > for one of these large production environments.  How would this
> > hypothetical RCU/CPU-hotplug bug manifest?
> 
> It could manifest as an RCU stall (after the warning triggers) since RCU
> would wait forever.
> 
> Were you thinking it is not worth doing this? I thought we wanted to remove
> the reundant rcu_report_qs_rnp here to solidify everyone's understanding of
> the code and fail early if there's something misunderstood (since such
> misunderstanding could mean there are other hidden bugs somewhere). The
> counter-argument to that being, making the code robust is more important for
> the large production failure scenario where failures are costly.

The benefits of removing code that is in theory redundant was my thought
at one point, but sleeping on this several times since has made me much
less favorable to this change.  And perhaps my experiences with my new
employer have affected my views on this as well.  You never know!  ;-)

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 							Thanx, Paul
> > 
> > > +	 */
> > > +	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
> > >  		rcu_disable_urgency_upon_qs(rdp);
> > >  		/* Report QS -after- changing ->qsmaskinitnext! */
> > >  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> > > -- 
> > > 2.28.0.236.gb10cc79966-goog
> > > 
