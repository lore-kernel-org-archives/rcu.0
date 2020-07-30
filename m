Return-Path: <SRS0=zn4Z=BJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF47C433E0
	for <rcu@archiver.kernel.org>; Thu, 30 Jul 2020 16:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B977C20838
	for <rcu@archiver.kernel.org>; Thu, 30 Jul 2020 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596126120;
	bh=9cFcZnfkur34WPfSqhU2MSEk1J8+VuHGVPWpxsCK54w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ddWlW53lubGRJHzn9xuSSzIizBDCaV9FoJT9ObiaOaZ0DnFV4rzQY/j3ydZ+MxhzW
	 Lo2+3e4RKGmiZHv0n9Y/QS+ZixqfF+vU5c4GdyiQJiF8T59r6jxo8MPmKvTOrFD66K
	 6sfJdvRLn68Bj+ZLfQUuefoNcisjq1YA+cufXYeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgG3QWA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbgG3QWA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jul 2020 12:22:00 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605E72082E;
        Thu, 30 Jul 2020 16:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596126119;
        bh=9cFcZnfkur34WPfSqhU2MSEk1J8+VuHGVPWpxsCK54w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TncS1nvGzCSVxo7Sr9KeUFeJ9Hf7ZU3kLdn7SE8bAdJk0A0ZMURGgMlECP2pumm53
         6tWH0uMI2b1S14bMdB7abLeZ8a2DXC1NVJF7ufKI/L6OtfQZi2GVv7pssf6Xd4VYfE
         F76ZjRPJUR/396oUNHZmuovdnxoHygXq8vFc0meA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3E5EF3520751; Thu, 30 Jul 2020 09:21:59 -0700 (PDT)
Date:   Thu, 30 Jul 2020 09:21:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] rcu/tree: Add a warning if CPU being onlined did not
 report QS already
Message-ID: <20200730162159.GZ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200730030221.705255-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730030221.705255-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 29, 2020 at 11:02:20PM -0400, Joel Fernandes (Google) wrote:
> Add a warning if CPU being onlined did not report QS already. This is to
> simplify the code in the CPU onlining path and also to make clear about
> where QS is reported. The act of QS reporting in CPU onlining path is
> is likely unnecessary as shown by code reading and testing with
> rcutorture's TREE03 and hotplug parameters.

How about something like this for the commit log?

------------------------------------------------------------------------

Currently, rcu_cpu_starting() checks to see if the RCU core expects a
quiescent state from the incoming CPU.  However, the current interaction
between RCU quiescent-state reporting and CPU-hotplug operations should
mean that the incoming CPU never needs to report a quiescent state.
First, the outgoing CPU reports a quiescent state if needed.  Second,
the race where the CPU is leaving just as RCU is initializing a new
grace period is handled by an explicit check for this condition.  Third,
the CPU's leaf rcu_node structure's ->lock serializes these checks.

This means that if rcu_cpu_starting() ever feels the need to report
a quiescent state, then there is a bug somewhere in the CPU hotplug
code or the RCU grace-period handling code.  This commit therefore
adds a WARN_ON_ONCE() to bring that bug to everyone's attention.

------------------------------------------------------------------------

> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
>  kernel/rcu/tree.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 65e1b5e92319..1e51962b565b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3996,7 +3996,19 @@ void rcu_cpu_starting(unsigned int cpu)
>  	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
>  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
>  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> -	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
> +
> +	/*
> +	 * Delete QS reporting from here, by June 2021, if warning does not
> +	 * fire. Let us make the rules for reporting QS for an offline CPUs
> +	 * more explicit. The CPU onlining path does not need to report QS for
> +	 * an offline CPU. Either the QS should have reported during CPU
> +	 * offlining, or during rcu_gp_init() if it detected a race with either
> +	 * CPU offlining or task unblocking on previously offlined CPUs. Note
> +	 * that the FQS loop also does not report QS for an offline CPU any
> +	 * longer (unless it splats due to an offline CPU blocking the GP for
> +	 * too long).
> +	 */

Let's leave at least the WARN_ON_ONCE() indefinitely.  If you don't
believe me, remove this code in your local tree, have someone give you
several branches, some with bugs injected, and then try to figure out
which have the bugs and then try to find those bugs.

This is not a fastpath, so the overhead of the check is not a concern.
Believe me, the difficulty of bug location without this check is a very
real concern!  ;-)

On the other hand, I fully agree with the benefits of documenting the
design rules.  But is this really the best place to do that from the
viewpoint of someone who is trying to figure out how RCU works?

							Thanx, Paul

> +	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
>  		rcu_disable_urgency_upon_qs(rdp);
>  		/* Report QS -after- changing ->qsmaskinitnext! */
>  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> -- 
> 2.28.0.rc0.142.g3c755180ce-goog
> 
