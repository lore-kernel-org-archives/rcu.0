Return-Path: <SRS0=by5p=DO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59B4C4363D
	for <rcu@archiver.kernel.org>; Wed,  7 Oct 2020 22:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609E420872
	for <rcu@archiver.kernel.org>; Wed,  7 Oct 2020 22:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602110080;
	bh=sx/VjOB0ybgwduTNkBYT/2oSEMq4ycAlzh8BUzdFrME=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=az1MPIPKd8Z71C0DVHUsKdWmSaLhpRxJHep2ISXyJ58lZPmoFfrjpXAXLC8V/Co1L
	 Pe9ZtZU/pvlASB1zFfPaiZfOfLYu4yQM4z1zM5TD7C8+hTDJGpyHMROM6HPU4NvI1n
	 UrZYoXAHNeQUboDuO1F5Uyj8nLitgX0dAoif568w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgJGWek (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 7 Oct 2020 18:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728742AbgJGWek (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 7 Oct 2020 18:34:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 289112083B;
        Wed,  7 Oct 2020 22:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602110079;
        bh=sx/VjOB0ybgwduTNkBYT/2oSEMq4ycAlzh8BUzdFrME=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mNqbCZAacr/ZHDCkgVirxcbCU2+3jrJ+1w2g9rNgNdwB1AySZhBRyUwgF7ri73poY
         ddpr876RNoOiackRqwjwS5bjHlNumiV5G/supNFVkhwzbEXHb8gVY0+ekmKvnZ/nm2
         es5LrW7xblXkt6aENm+wqM6TITJAY5mH+351jiDA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DAF403522FA4; Wed,  7 Oct 2020 15:34:38 -0700 (PDT)
Date:   Wed, 7 Oct 2020 15:34:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, neeraju@codeaurora.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] rcu/tree: nocb: Avoid raising softirq when there are
 ready to execute CBs
Message-ID: <20201007223438.GU29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201005021132.146534-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005021132.146534-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Oct 04, 2020 at 10:11:32PM -0400, Joel Fernandes (Google) wrote:
> During testing, I see it is possible that rcu_pending() returns 1 when
> offloaded callbacks are ready to execute thus raising the RCU softirq.
> 
> However, softirq does not execute offloaded callbacks. They are executed in a
> kthread which is awakened independent of the softirq.
> 
> This commit therefore avoids raising the softirq in the first place. That's
> probably a good thing considering that the purpose of callback offloading is to
> reduce softirq activity.
> 
> Passed 30 minute tests of TREE01 through TREE09 each.
> 
> On TREE08, I notice that there is atmost 150us from when the softirq was
> NOT raised when ready cbs were present, to when the ready callbacks were
> invoked by the rcuop thread. This also further confirms that there is no
> need to raise the softirq for ready cbs in the first place.
> 
> Cc: neeraju@codeaurora.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks good, applied, thank you!  I reworked things a bit based on
previous patches and to more precisely capture why this patch does
not cause additional problems.  Please let me know if I messed
anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 33847a34a2d261354a79b4a24d9d37222e8ec888
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Wed Oct 7 13:50:36 2020 -0700

    rcu/tree: nocb: Avoid raising softirq for offloaded ready-to-execute CBs
    
    Testing showed that rcu_pending() can return 1 when offloaded callbacks
    are ready to execute.  This invokes RCU core processing, for example,
    by raising RCU_SOFTIRQ, eventually resulting in a call to rcu_core().
    However, rcu_core() explicitly avoids in any way manipulating offloaded
    callbacks, which are instead handled by the rcuog and rcuoc kthreads,
    which work independently of rcu_core().
    
    One exception to this independence is that rcu_core() invokes
    do_nocb_deferred_wakeup(), however, rcu_pending() also checks
    rcu_nocb_need_deferred_wakeup() in order to correctly handle this case,
    invoking rcu_core() when needed.
    
    This commit therefore avoids needlessly invoking RCU core processing
    by checking rcu_segcblist_ready_cbs() only on non-offloaded CPUs.
    This reduces overhead, for example, by reducing softirq activity.
    
    This change passed 30 minute tests of TREE01 through TREE09 each.
    
    On TREE08, there is at most 150us from the time that rcu_pending() chose
    not to invoke RCU core processing to the time when the ready callbacks
    were invoked by the rcuoc kthread.  This provides further evidence that
    there is no need to invoke rcu_core() for offloaded callbacks that are
    ready to invoke.
    
    Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 85e3f29..bfd38f2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3716,7 +3716,8 @@ static int rcu_pending(int user)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
-	if (rcu_segcblist_ready_cbs(&rdp->cblist))
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
