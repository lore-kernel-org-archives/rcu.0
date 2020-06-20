Return-Path: <SRS0=jbur=AB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C6C433DF
	for <rcu@archiver.kernel.org>; Sat, 20 Jun 2020 15:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF3A20786
	for <rcu@archiver.kernel.org>; Sat, 20 Jun 2020 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592667919;
	bh=KahgNShgI+rYus9N9esjq/Bo8FVrHZeP7m0+5CCnMsI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xyBVZ/zH/Kdy+KA/6HHi++GG9SMjSyuc3eKJ3vUtFfVIydgDUwaFzERYeNHLw8/6Y
	 tRpMIkMtwptGbIkBzAvFZRGT4nlYy6w3+LrR9QSZ9YagMvgAEWGMOQwLuaLeLGjbkv
	 6/hqtUIfxCDbcZQh3gMA3mJErinjOYOjcRZgeKaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgFTPpT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 20 Jun 2020 11:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgFTPpS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 20 Jun 2020 11:45:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECD7820706;
        Sat, 20 Jun 2020 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592667918;
        bh=KahgNShgI+rYus9N9esjq/Bo8FVrHZeP7m0+5CCnMsI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QIC8IeVdwoIztnWGw4mc7Bo4cycDl5ubesDoouGrsd5aSTuNr8zDZPbBwqoTmGr3b
         3WX0Lb9t1TLrz2AqoF27iOFTF7nUM1kDO+Mv1scJ5VUYwVIxOL3wg1jMlbD1raNAhs
         9GuJYCQfmnUzQ2Jx0SicZOzqZewUJhawdkbSoOaU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D1A503522658; Sat, 20 Jun 2020 08:45:17 -0700 (PDT)
Date:   Sat, 20 Jun 2020 08:45:17 -0700
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
Message-ID: <20200620154517.GA14328@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200619013641.63453-1-joel@joelfernandes.org>
 <20200619013641.63453-3-joel@joelfernandes.org>
 <20200619020718.GA74764@google.com>
 <20200619174001.GL2723@paulmck-ThinkPad-P72>
 <20200620053608.GC9005@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620053608.GC9005@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jun 20, 2020 at 01:36:08AM -0400, Joel Fernandes wrote:
> On Fri, Jun 19, 2020 at 10:40:01AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 18, 2020 at 10:07:18PM -0400, Joel Fernandes wrote:
> > > On Thu, Jun 18, 2020 at 09:36:41PM -0400, Joel Fernandes (Google) wrote:
> > > [...]
> > > > @@ -2019,7 +2019,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
> > > >  			cond_resched_tasks_rcu_qs();
> > > >  			WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > > >  			WARN_ON(signal_pending(current));
> > > > -			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> > > > +			trace_rcu_grace_period(rcu_state.name, TPS("rsp"), rcu_state.gp_seq,
> > > >  					       TPS("reqwaitsig"));
> > > >  		}
> > > >  
> > > > @@ -2263,7 +2263,7 @@ int rcutree_dying_cpu(unsigned int cpu)
> > > >  		return 0;
> > > >  
> > > >  	blkd = !!(rnp->qsmask & rdp->grpmask);
> > > > -	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
> > > > +	trace_rcu_grace_period(rcu_state.name, TPS("rsp"), READ_ONCE(rnp->gp_seq),
> > > 
> > > This should be: TPS("rnp")  :-(
> > > 
> > > Happy to fix it up and resend if you'd like. Thanks!
> > 
> > I queued and pushed 1/2 and 2/2.
> 
> Thanks!
> 
> > but again, I am still not at all
> > convinced by 3/3.  If you want to make RCU trace output human
> > readable, post-processing will be needed.
> 
> Or I could post-process the code before building it since the pattern seems
> easy to parse ;-)

For this one thing, perhaps.  For most other information of interest,
doing so in-kernel would not be so good, for example, from a
lock-contention viewpoint.

							Thanx, Paul
