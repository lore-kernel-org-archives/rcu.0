Return-Path: <SRS0=by5p=DO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC6EC4363D
	for <rcu@archiver.kernel.org>; Wed,  7 Oct 2020 23:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F8620882
	for <rcu@archiver.kernel.org>; Wed,  7 Oct 2020 23:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602112430;
	bh=/Le/feVywHw0Rh7iKUPEtO7jaKG1ZxqCavXeD9xdVAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U+KzcIA7j+LCHRm6boTyBYnHZ+QNw4BheBYrQriqIYVWKqKQ272XwS7S1fGi7vBGE
	 oZQhXuOeuaoeH3p6jxqFxMUHxuT2aLnbQO2fQYzalUKeNE2x8Ej+rXaHofSv/jMH7j
	 8q4Wcx7vz20cwoWpgnQo21Tg01j+DinwqupQA1q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgJGXNu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 7 Oct 2020 19:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbgJGXNu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 7 Oct 2020 19:13:50 -0400
Received: from localhost (unknown [176.177.115.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5A12083B;
        Wed,  7 Oct 2020 23:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602112429;
        bh=/Le/feVywHw0Rh7iKUPEtO7jaKG1ZxqCavXeD9xdVAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMkC7GKd9lWjJMb10Amx3MeHOeJKsQPE8nL45Vbga+BQDWYGvpHizBEHj5fiDhHDV
         BzR9Pjr9Xh6cPNg6Mz37TIGcUlZRagLcYIrHxQavkg8bLjfpeAbvfskLGghgvYdXWf
         Owuimp5Wk7wA+ET77EHzm8C/MqN63dFosWv7zztc=
Date:   Thu, 8 Oct 2020 01:13:46 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, neeraju@codeaurora.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] rcu/tree: nocb: Avoid raising softirq when there are
 ready to execute CBs
Message-ID: <20201007231346.GA58749@lothringen>
References: <20201005021132.146534-1-joel@joelfernandes.org>
 <20201007223438.GU29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007223438.GU29330@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 07, 2020 at 03:34:38PM -0700, Paul E. McKenney wrote:
> On Sun, Oct 04, 2020 at 10:11:32PM -0400, Joel Fernandes (Google) wrote:
> > During testing, I see it is possible that rcu_pending() returns 1 when
> > offloaded callbacks are ready to execute thus raising the RCU softirq.
> > 
> > However, softirq does not execute offloaded callbacks. They are executed in a
> > kthread which is awakened independent of the softirq.
> > 
> > This commit therefore avoids raising the softirq in the first place. That's
> > probably a good thing considering that the purpose of callback offloading is to
> > reduce softirq activity.
> > 
> > Passed 30 minute tests of TREE01 through TREE09 each.
> > 
> > On TREE08, I notice that there is atmost 150us from when the softirq was
> > NOT raised when ready cbs were present, to when the ready callbacks were
> > invoked by the rcuop thread. This also further confirms that there is no
> > need to raise the softirq for ready cbs in the first place.
> > 
> > Cc: neeraju@codeaurora.org
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Looks good, applied, thank you!  I reworked things a bit based on
> previous patches and to more precisely capture why this patch does
> not cause additional problems.  Please let me know if I messed
> anything up.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 33847a34a2d261354a79b4a24d9d37222e8ec888
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Wed Oct 7 13:50:36 2020 -0700
> 
>     rcu/tree: nocb: Avoid raising softirq for offloaded ready-to-execute CBs
>     
>     Testing showed that rcu_pending() can return 1 when offloaded callbacks
>     are ready to execute.  This invokes RCU core processing, for example,
>     by raising RCU_SOFTIRQ, eventually resulting in a call to rcu_core().
>     However, rcu_core() explicitly avoids in any way manipulating offloaded
>     callbacks, which are instead handled by the rcuog and rcuoc kthreads,
>     which work independently of rcu_core().
>     
>     One exception to this independence is that rcu_core() invokes
>     do_nocb_deferred_wakeup(), however, rcu_pending() also checks
>     rcu_nocb_need_deferred_wakeup() in order to correctly handle this case,
>     invoking rcu_core() when needed.
>     
>     This commit therefore avoids needlessly invoking RCU core processing
>     by checking rcu_segcblist_ready_cbs() only on non-offloaded CPUs.
>     This reduces overhead, for example, by reducing softirq activity.
>     
>     This change passed 30 minute tests of TREE01 through TREE09 each.
>     
>     On TREE08, there is at most 150us from the time that rcu_pending() chose
>     not to invoke RCU core processing to the time when the ready callbacks
>     were invoked by the rcuoc kthread.  This provides further evidence that
>     there is no need to invoke rcu_core() for offloaded callbacks that are
>     ready to invoke.
>     
>     Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

