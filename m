Return-Path: <SRS0=65p9=BK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9407C433E0
	for <rcu@archiver.kernel.org>; Fri, 31 Jul 2020 03:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08DB208E4
	for <rcu@archiver.kernel.org>; Fri, 31 Jul 2020 03:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596167306;
	bh=r0905SOBnmpQMVEbvend0u/6eg1GHliF8EiBpEwbut4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xOy4i7XxO0ZBM27UYu2JFgvzBkMxz6eithtzvmm7FD0X3RUE2GnOMwqZNsiXm311G
	 nHJ0ZRRdGl6hCWFthSqUikoIkon3qyRWSt/MaCsePyfHhDdAMcs4FDzOC9ItKNzqap
	 dx820Ke5BJPhAWxKYJfOqr7ofbqpp1g2WW0IqwrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbgGaDs0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jul 2020 23:48:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731165AbgGaDs0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jul 2020 23:48:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79EA820829;
        Fri, 31 Jul 2020 03:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596167305;
        bh=r0905SOBnmpQMVEbvend0u/6eg1GHliF8EiBpEwbut4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g7eDudtJo2qR+/Zy7Jt6DA450rVnd41ddQqbDMvavch46nmN+kB+tQvI0u76OS43P
         XtIyD1U+D0hTchG9Q/o9N2ACBFqiR/lGVHP+kq1BQ27SZ4cCSzm7bLLytrIDzDA3oA
         CbLMjP8G+hX9aXfl8KerDCszA0T7L37P5HZ1mmqE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5218D3521361; Thu, 30 Jul 2020 20:48:25 -0700 (PDT)
Date:   Thu, 30 Jul 2020 20:48:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] rcu/tree: Add a warning if CPU being onlined did not
 report QS already
Message-ID: <20200731034825.GI9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200730030221.705255-1-joel@joelfernandes.org>
 <20200730162159.GZ9247@paulmck-ThinkPad-P72>
 <20200731014222.GA2349603@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731014222.GA2349603@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 30, 2020 at 09:42:22PM -0400, Joel Fernandes wrote:
> On Thu, Jul 30, 2020 at 09:21:59AM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 29, 2020 at 11:02:20PM -0400, Joel Fernandes (Google) wrote:
> > > Add a warning if CPU being onlined did not report QS already. This is to
> > > simplify the code in the CPU onlining path and also to make clear about
> > > where QS is reported. The act of QS reporting in CPU onlining path is
> > > is likely unnecessary as shown by code reading and testing with
> > > rcutorture's TREE03 and hotplug parameters.
> > 
> > How about something like this for the commit log?
> > 
> > ------------------------------------------------------------------------
> > 
> > Currently, rcu_cpu_starting() checks to see if the RCU core expects a
> > quiescent state from the incoming CPU.  However, the current interaction
> > between RCU quiescent-state reporting and CPU-hotplug operations should
> > mean that the incoming CPU never needs to report a quiescent state.
> > First, the outgoing CPU reports a quiescent state if needed.  Second,
> > the race where the CPU is leaving just as RCU is initializing a new
> > grace period is handled by an explicit check for this condition.  Third,
> > the CPU's leaf rcu_node structure's ->lock serializes these checks.
> > 
> > This means that if rcu_cpu_starting() ever feels the need to report
> > a quiescent state, then there is a bug somewhere in the CPU hotplug
> > code or the RCU grace-period handling code.  This commit therefore
> > adds a WARN_ON_ONCE() to bring that bug to everyone's attention.
> > 
> > ------------------------------------------------------------------------
> > 
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > ---
> > >  kernel/rcu/tree.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 65e1b5e92319..1e51962b565b 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3996,7 +3996,19 @@ void rcu_cpu_starting(unsigned int cpu)
> > >  	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
> > >  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> > >  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> > > -	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
> > > +
> > > +	/*
> > > +	 * Delete QS reporting from here, by June 2021, if warning does not
> > > +	 * fire. Let us make the rules for reporting QS for an offline CPUs
> > > +	 * more explicit. The CPU onlining path does not need to report QS for
> > > +	 * an offline CPU. Either the QS should have reported during CPU
> > > +	 * offlining, or during rcu_gp_init() if it detected a race with either
> > > +	 * CPU offlining or task unblocking on previously offlined CPUs. Note
> > > +	 * that the FQS loop also does not report QS for an offline CPU any
> > > +	 * longer (unless it splats due to an offline CPU blocking the GP for
> > > +	 * too long).
> > > +	 */
> > 
> > Let's leave at least the WARN_ON_ONCE() indefinitely.  If you don't
> > believe me, remove this code in your local tree, have someone give you
> > several branches, some with bugs injected, and then try to figure out
> > which have the bugs and then try to find those bugs.
> > 
> > This is not a fastpath, so the overhead of the check is not a concern.
> > Believe me, the difficulty of bug location without this check is a very
> > real concern!  ;-)
> > 
> > On the other hand, I fully agree with the benefits of documenting the
> > design rules.  But is this really the best place to do that from the
> > viewpoint of someone who is trying to figure out how RCU works?
> 
> I can move this comment to: "Hotplug CPU" section in
> Documentation/RCU/Design/Requirements/Requirements.rst

That sounds like a better place for it, very good!

> And I could make the comment here as:
> 	/*
> 	 * Delete QS reporting from here, by June 2021, if the warning does not
>  	 * fire. Leave the warning indefinitely. Check RCU design requirements
> 	 * in Documentation/RCU/ about CPU hotplug requirements.
> 	 */

Rather than decide for our future selves, could we please just suggest
reviewing this on June 2021?  Or, given enterprise distro schedules,
2024.  :-/

							Thanx, Paul

> I will post my v3 with changes to the requirements document.
> 
> Let me know any other comments, thanks,
> 
>  - Joel
> 
