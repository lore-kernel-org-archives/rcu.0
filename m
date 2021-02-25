Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE619C43381
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 20:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C6264EC8
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 20:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBYU60 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Feb 2021 15:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234612AbhBYU42 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Feb 2021 15:56:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BEBF64E28;
        Thu, 25 Feb 2021 20:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614286544;
        bh=xp+Ya1f7eA0CAwrMV+RyvxCVmV65qyl6ZQeqq3b5zNI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FN8t790iSgUqSVAwJ5xFvuQfXmE8LFx3NH8isZ7HAShyGbefJENPRs63HLBoiS9rX
         xlVF41e9KHpMnw/PpHKjAz4v6+PKbLi6KAS9B6t9WWQOwtBG/QJjIGSVrRASijHvID
         CB3LOETUstUTBnrrYXDR6J+E+1HndkENtoawB2H3eExnrECE009ambM6Q3HS2FJyRV
         1Q+Q7Lbwln/G2YTDgdOAtG6W5veLOC877MiGQUSGw4I+h70EMQc1Em/bf2UiJtCdCu
         /nUjz6z+EpF3XARZQ+0sy0lLDziumw1s5D24r6ESlhnGCvdH0CpNJMYD27fB4Zawjk
         K/Bm8z3Sfnphg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F39EE35227D5; Thu, 25 Feb 2021 12:55:43 -0800 (PST)
Date:   Thu, 25 Feb 2021 12:55:43 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Subject: Re: tasks-trace RCU: question about grace period forward progress
Message-ID: <20210225205543.GV2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <354598689.4868.1614262968890.JavaMail.zimbra@efficios.com>
 <20210225153656.GQ2743@paulmck-ThinkPad-P72>
 <47558398.5024.1614268052985.JavaMail.zimbra@efficios.com>
 <20210225183321.GT2743@paulmck-ThinkPad-P72>
 <2096901411.5697.1614284434230.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2096901411.5697.1614284434230.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 25, 2021 at 03:20:34PM -0500, Mathieu Desnoyers wrote:
> ----- On Feb 25, 2021, at 1:33 PM, paulmck paulmck@kernel.org wrote:
> [...]
> > commit 581f79546b6be406a9c7280b2d3511b60821efe0
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Feb 25 10:26:00 2021 -0800
> > 
> >    rcu-tasks: Add block comment laying out RCU Tasks Trace design
> >    
> >    This commit adds a block comment that gives a high-level overview of
> >    how RCU tasks trace grace periods progress.  It also adds a note about
> >    how exiting tasks are handles, plus it gives an overview of the memory
> 
> handles -> handled

Good eyes, fixed!

> >    ordering.
> >    
> >    Reported-by: Peter Zijlstra <peterz@infradead.org>
> >    Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 17c8ebe..f818357 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -726,6 +726,42 @@ EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
> > // flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
> > // readers can operate from idle, offline, and exception entry/exit in no
> > // way allows rcu_preempt and rcu_sched readers to also do so.
> > +//
> > +// The implementation uses rcu_tasks_wait_gp(), which relies on function
> > +// pointers in the rcu_tasks structure.  The rcu_spawn_tasks_trace_kthread()
> > +// function sets these function pointers up so that rcu_tasks_wait_gp()
> > +// invokes these functions in this order:
> > +//
> > +// rcu_tasks_trace_pregp_step():
> > +//	Initialize the count of readers and block CPU-hotplug operations.
> > +// rcu_tasks_trace_pertask(), invoked on every non-idle task:
> > +//	Initialize per-task state and attempt to identify an immediate
> > +//	quiescent state for that task, or, failing that, attempt to set
> > +//	that task's .need_qs flag so that that task's next outermost
> > +//	rcu_read_unlock_trace() will report the quiescent state (in which
> > +//	case the count of readers is incremented).  If both attempts fail,
> > +//	the task is added to a "holdout" list.
> > +// rcu_tasks_trace_postscan():
> > +//	Initialize state and attempt to identify an immediate quiescent
> > +//	state as above (but only for idle tasks), unblock CPU-hotplug
> > +//	operations, and wait for an RCU grace period to avoid races with
> > +//	tasks that are in the process of exiting.
> > +// check_all_holdout_tasks_trace(), repeatedly until holdout list is empty:
> > +//	Scans the holdout list, attempting to identify a quiescent state
> > +//	for each task on the list.  If there is a quiescent state, the
> > +//	corresponding task is removed from the holdout list.
> > +// rcu_tasks_trace_postgp():
> > +//	Wait for the count of readers do drop to zero, reporting any stalls.
> > +//	Also execute full memory barriers to maintain ordering with code
> > +//	executing after the grace period.
> > +//
> > +// The exit_tasks_rcu_finish_trace() synchronizes with exiting tasks.
> > +//
> > +// Pre-grace-period update-side code is ordered before the grace
> > +// period via the ->cbs_lock and barriers in rcu_tasks_kthread().
> > +// Pre-grace-period read-side code is ordered before the grace period by
> > +// atomic_dec_and_test() of the count of readers (for IPIed readers) and by
> > +// scheduler context-switch ordering (for locked-down non-running readers).
> 
> The rest looks good, thanks!

Thank you for looking it over!

							Thanx, Paul
