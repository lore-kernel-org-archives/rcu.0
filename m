Return-Path: <SRS0=+AtR=DP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B94C433E7
	for <rcu@archiver.kernel.org>; Thu,  8 Oct 2020 18:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB39221FE
	for <rcu@archiver.kernel.org>; Thu,  8 Oct 2020 18:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602182191;
	bh=2GXG3GuLUL5ZoId9Sz7UU0zv3izFwQZZ1EKkkHF8x4Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ynuUUYo+HmRQNSCb4hE9nnjw4HinXK7PuTPOZ1LNpcjW34FCesQmcz1Witysd0Xq/
	 F9OdrKcZFKhGURixRW1+2rvOeMo3nUFI2vCF8KfNugdJGRSUoLDttQuaEXhiE1Lrki
	 9vE+pKFRiKQfayA2A8C5YgQIUy7zO1DIGku10NNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgJHSgb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbgJHSgb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 8 Oct 2020 14:36:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7814221FC;
        Thu,  8 Oct 2020 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602182190;
        bh=2GXG3GuLUL5ZoId9Sz7UU0zv3izFwQZZ1EKkkHF8x4Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a1QUb6X8I6Sdp4M7ZfIM+/ytgT87kr9Bua40+12giW0DK3VRkz13ef9yA0lgyE41+
         B2g6TVLLA3nwVrjgNDVj8F8vV1AqsWUBkuZHoYfEVAseESkoaIayZBYlrwIkg5I+g3
         9EWwkQfestfc7NfVfDPMoGn+4ijOEcH05Ed7Z6UE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7ED3D35228D5; Thu,  8 Oct 2020 11:36:29 -0700 (PDT)
Date:   Thu, 8 Oct 2020 11:36:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] rcu/tree: nocb: Avoid raising softirq when there are
 ready to execute CBs
Message-ID: <20201008183629.GA29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201005021132.146534-1-joel@joelfernandes.org>
 <20201007223438.GU29330@paulmck-ThinkPad-P72>
 <7fb89900-18e3-f438-ec31-2bce21c02afe@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb89900-18e3-f438-ec31-2bce21c02afe@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 08, 2020 at 12:49:40PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 10/8/2020 4:04 AM, Paul E. McKenney wrote:
> > On Sun, Oct 04, 2020 at 10:11:32PM -0400, Joel Fernandes (Google) wrote:
> > > During testing, I see it is possible that rcu_pending() returns 1 when
> > > offloaded callbacks are ready to execute thus raising the RCU softirq.
> > > 
> > > However, softirq does not execute offloaded callbacks. They are executed in a
> > > kthread which is awakened independent of the softirq.
> > > 
> > > This commit therefore avoids raising the softirq in the first place. That's
> > > probably a good thing considering that the purpose of callback offloading is to
> > > reduce softirq activity.
> > > 
> > > Passed 30 minute tests of TREE01 through TREE09 each.
> > > 
> > > On TREE08, I notice that there is atmost 150us from when the softirq was
> > > NOT raised when ready cbs were present, to when the ready callbacks were
> > > invoked by the rcuop thread. This also further confirms that there is no
> > > need to raise the softirq for ready cbs in the first place.
> > > 
> > > Cc: neeraju@codeaurora.org
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Looks good, applied, thank you!  I reworked things a bit based on
> > previous patches and to more precisely capture why this patch does
> > not cause additional problems.  Please let me know if I messed
> > anything up.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 33847a34a2d261354a79b4a24d9d37222e8ec888
> > Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Date:   Wed Oct 7 13:50:36 2020 -0700
> > 
> >      rcu/tree: nocb: Avoid raising softirq for offloaded ready-to-execute CBs
> >      Testing showed that rcu_pending() can return 1 when offloaded callbacks
> >      are ready to execute.  This invokes RCU core processing, for example,
> >      by raising RCU_SOFTIRQ, eventually resulting in a call to rcu_core().
> >      However, rcu_core() explicitly avoids in any way manipulating offloaded
> >      callbacks, which are instead handled by the rcuog and rcuoc kthreads,
> >      which work independently of rcu_core().
> >      One exception to this independence is that rcu_core() invokes
> >      do_nocb_deferred_wakeup(), however, rcu_pending() also checks
> >      rcu_nocb_need_deferred_wakeup() in order to correctly handle this case,
> >      invoking rcu_core() when needed.
> >      This commit therefore avoids needlessly invoking RCU core processing
> >      by checking rcu_segcblist_ready_cbs() only on non-offloaded CPUs.
> >      This reduces overhead, for example, by reducing softirq activity.
> >      This change passed 30 minute tests of TREE01 through TREE09 each.
> >      On TREE08, there is at most 150us from the time that rcu_pending() chose
> >      not to invoke RCU core processing to the time when the ready callbacks
> >      were invoked by the rcuoc kthread.  This provides further evidence that
> >      there is no need to invoke rcu_core() for offloaded callbacks that are
> >      ready to invoke.
> >      Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> >      Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> 
> Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>

Applied, thank you!

							Thanx, Paul

> Thanks
> Neeraj
> 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 85e3f29..bfd38f2 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3716,7 +3716,8 @@ static int rcu_pending(int user)
> >   		return 1;
> >   	/* Does this CPU have callbacks ready to invoke? */
> > -	if (rcu_segcblist_ready_cbs(&rdp->cblist))
> > +	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
> > +	    rcu_segcblist_ready_cbs(&rdp->cblist))
> >   		return 1;
> >   	/* Has RCU gone idle with this CPU needing another grace period? */
> > 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> the Code Aurora Forum, hosted by The Linux Foundation
