Return-Path: <SRS0=7B7l=BU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DE3C433DF
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39474207FF
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 15:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597074422;
	bh=j8jGR2gpWSiHYnlpQ+t1j++8nxUJKE0a7/TRK6Ps85U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dyWixxsRTaQiK1JAcalB8V/V4LocFPOW8a/cgz4S8YnqfXzlOmoc9hZCZXjlIny8y
	 elKLt6KOABEOlDzAJPfiKNVbL6egc3G+sLA6tjAyrCZ+mooFhO6slCP3yVm8ixjMp9
	 SLo0NVzNYW55VFZPX7pb8/y/BqSi+ulLviaFnvKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHJPqz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgHJPqz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Aug 2020 11:46:55 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9E0B2078E;
        Mon, 10 Aug 2020 15:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597074414;
        bh=j8jGR2gpWSiHYnlpQ+t1j++8nxUJKE0a7/TRK6Ps85U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0X+l8s+tl0tCoIQqESJhcYWbW5WNuyg+PexmYrKIBVWBqLtkYyILa2ZQwcRwRL0Vx
         2nhRQy8UWf02p9p0IgW4FX76ZjJVqj27oGSNVkkfYEwwfIYEG4bZRXMIR6PyVYIpQP
         V//VbuJ/POjIz51hrVuZCU2cQc6AckeSy0GRv80I=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 795BA35228C7; Mon, 10 Aug 2020 08:46:54 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:46:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Message-ID: <20200810154654.GJ4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200807170722.2897328-1-joel@joelfernandes.org>
 <20200807170722.2897328-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807170722.2897328-2-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 07, 2020 at 01:07:18PM -0400, Joel Fernandes (Google) wrote:
> Currently, rcu_cpu_starting() checks to see if the RCU core expects a
> quiescent state from the incoming CPU.  However, the current interaction
> between RCU quiescent-state reporting and CPU-hotplug operations should
> mean that the incoming CPU never needs to report a quiescent state.
> First, the outgoing CPU reports a quiescent state if needed.  Second,
> the race where the CPU is leaving just as RCU is initializing a new
> grace period is handled by an explicit check for this condition.  Third,
> the CPU's leaf rcu_node structure's ->lock serializes these checks.
> 
> This means that if rcu_cpu_starting() ever feels the need to report
> a quiescent state, then there is a bug somewhere in the CPU hotplug
> code or the RCU grace-period handling code.  This commit therefore
> adds a WARN_ON_ONCE() to bring that bug to everyone's attention.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 65e1b5e92319..a49fa3b60faa 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3996,7 +3996,14 @@ void rcu_cpu_starting(unsigned int cpu)
>  	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
>  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
>  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> -	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
> +
> +	/*
> +	 * XXX: The following rcu_report_qs_rnp() is redundant. If the below
> +	 * warning does not fire, consider replacing it with the "else" block,
> +	 * by June 2021 or so (while keeping the warning). Refer to RCU's
> +	 * Requirements documentation for the rationale.

Let's suppose that this change is made, and further that in a year or
two the "if" statement below is replaced with its "else" block.

Now let's suppose that (some years after that) a hard-to-trigger bug
makes its way into RCU's CPU-hotplug code that would have resulted in
the WARN_ON_ONCE() triggering, but that this bug turns out to be not so
hard to trigger in certain large production environments.

Let's suppose further that you have moved on to where you are responsible
for one of these large production environments.  How would this
hypothetical RCU/CPU-hotplug bug manifest?

							Thanx, Paul

> +	 */
> +	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
>  		rcu_disable_urgency_upon_qs(rdp);
>  		/* Report QS -after- changing ->qsmaskinitnext! */
>  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> -- 
> 2.28.0.236.gb10cc79966-goog
> 
