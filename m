Return-Path: <SRS0=nBXm=AA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C00C433DF
	for <rcu@archiver.kernel.org>; Fri, 19 Jun 2020 17:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E1420B80
	for <rcu@archiver.kernel.org>; Fri, 19 Jun 2020 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592588402;
	bh=8eUHNLmvhmim6eclqWu5Pxp7ZOi1GizQWqzrGiXVChg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=sADZCW29KrZ9/UGCVsCuYHU3szwcv1U19Ruk9C/njGiKfpGIoU9D+YFE8uv5tnRA2
	 8FEHqj7alI6Qlw4G+A0DeXTBDNiOasFHwv1h09Il+HQqqYl3JIvxkolMuHzL+rQWMa
	 04UkiQN4rDvWYneLjmO++h6yFwMzJNimXBBuwb+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389648AbgFSRkC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730934AbgFSRkB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Jun 2020 13:40:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79245207FC;
        Fri, 19 Jun 2020 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592588401;
        bh=8eUHNLmvhmim6eclqWu5Pxp7ZOi1GizQWqzrGiXVChg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0A0Q74+EQLCzH1+u9v3USntPaedM1Y8C0e8jIkZUG3OrVu2MS0y2vwO/Nxa7pK5s2
         cX0GmUnKXJ66EWJYch76o7L/NUHhz/OErFgv+eO+onhdyLqQhIE0lyxp60/jly0oZa
         L71pPCZcJYE4Zhn0OzZip10o4WxkWVdohZbTJdFw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 527C03522B50; Fri, 19 Jun 2020 10:40:01 -0700 (PDT)
Date:   Fri, 19 Jun 2020 10:40:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 3/3] rcu/trace: Add name of the source for gp_seq to
 prevent confusion
Message-ID: <20200619174001.GL2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200619013641.63453-1-joel@joelfernandes.org>
 <20200619013641.63453-3-joel@joelfernandes.org>
 <20200619020718.GA74764@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619020718.GA74764@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 10:07:18PM -0400, Joel Fernandes wrote:
> On Thu, Jun 18, 2020 at 09:36:41PM -0400, Joel Fernandes (Google) wrote:
> [...]
> > @@ -2019,7 +2019,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
> >  			cond_resched_tasks_rcu_qs();
> >  			WRITE_ONCE(rcu_state.gp_activity, jiffies);
> >  			WARN_ON(signal_pending(current));
> > -			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> > +			trace_rcu_grace_period(rcu_state.name, TPS("rsp"), rcu_state.gp_seq,
> >  					       TPS("reqwaitsig"));
> >  		}
> >  
> > @@ -2263,7 +2263,7 @@ int rcutree_dying_cpu(unsigned int cpu)
> >  		return 0;
> >  
> >  	blkd = !!(rnp->qsmask & rdp->grpmask);
> > -	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
> > +	trace_rcu_grace_period(rcu_state.name, TPS("rsp"), READ_ONCE(rnp->gp_seq),
> 
> This should be: TPS("rnp")  :-(
> 
> Happy to fix it up and resend if you'd like. Thanks!

I queued and pushed 1/2 and 2/2, but again, I am still not at all
convinced by 3/3.  If you want to make RCU trace output human
readable, post-processing will be needed.

						Thanx, Paul
