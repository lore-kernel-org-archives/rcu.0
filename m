Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F4AC433E6
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 20:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB25464F4F
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 20:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhBYUVb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Feb 2021 15:21:31 -0500
Received: from mail.efficios.com ([167.114.26.124]:52342 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbhBYUVQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Feb 2021 15:21:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C18A631F6FB;
        Thu, 25 Feb 2021 15:20:34 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oDanPPviHs04; Thu, 25 Feb 2021 15:20:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6A4BE31F6FA;
        Thu, 25 Feb 2021 15:20:34 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6A4BE31F6FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614284434;
        bh=hHXH7cIIE+aDLHBcMP5ZT3pETwrKIyHHLK9KAKn917E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=C83s9BUjAiRYj2q6zbb7jRZhvAnFXmrcV6puxyvbiKduWufNSWxLqIq5RE6HoY3hX
         O8GBoT3BBKRrprN4kJt0XtRIOEfB4HMsUoFFUoAZWDCn0Mywls3gFt47CInKpZHoH7
         xRr8LIuZK5VSW5DXP2nHWMGoNaWjvszl+9r5JrrozbWpLueQ1qVNuN/h1yWmCABsmb
         kJgbCedHgWZYfXRHUx/DcMD67KfZ0OrX70UNNGTalQSFX8Iu8wbzinXF6VEHntIaY3
         Op7YjcCLAQYADH47CsQ2SQm+Iw86XqygTSWsHNi3rkgjllJK7sHq+IH6raVO3YAedI
         SMcE9sTWJPt+A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pJgGfKy6Upnn; Thu, 25 Feb 2021 15:20:34 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 568D331F676;
        Thu, 25 Feb 2021 15:20:34 -0500 (EST)
Date:   Thu, 25 Feb 2021 15:20:34 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Message-ID: <2096901411.5697.1614284434230.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210225183321.GT2743@paulmck-ThinkPad-P72>
References: <354598689.4868.1614262968890.JavaMail.zimbra@efficios.com> <20210225153656.GQ2743@paulmck-ThinkPad-P72> <47558398.5024.1614268052985.JavaMail.zimbra@efficios.com> <20210225183321.GT2743@paulmck-ThinkPad-P72>
Subject: Re: tasks-trace RCU: question about grace period forward progress
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Topic: tasks-trace RCU: question about grace period forward progress
Thread-Index: V9hP9BaRvLcwxywYqgqg+vIadBWE2g==
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

----- On Feb 25, 2021, at 1:33 PM, paulmck paulmck@kernel.org wrote:
[...]
> commit 581f79546b6be406a9c7280b2d3511b60821efe0
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Feb 25 10:26:00 2021 -0800
> 
>    rcu-tasks: Add block comment laying out RCU Tasks Trace design
>    
>    This commit adds a block comment that gives a high-level overview of
>    how RCU tasks trace grace periods progress.  It also adds a note about
>    how exiting tasks are handles, plus it gives an overview of the memory

handles -> handled

>    ordering.
>    
>    Reported-by: Peter Zijlstra <peterz@infradead.org>
>    Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 17c8ebe..f818357 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -726,6 +726,42 @@ EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
> // flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
> // readers can operate from idle, offline, and exception entry/exit in no
> // way allows rcu_preempt and rcu_sched readers to also do so.
> +//
> +// The implementation uses rcu_tasks_wait_gp(), which relies on function
> +// pointers in the rcu_tasks structure.  The rcu_spawn_tasks_trace_kthread()
> +// function sets these function pointers up so that rcu_tasks_wait_gp()
> +// invokes these functions in this order:
> +//
> +// rcu_tasks_trace_pregp_step():
> +//	Initialize the count of readers and block CPU-hotplug operations.
> +// rcu_tasks_trace_pertask(), invoked on every non-idle task:
> +//	Initialize per-task state and attempt to identify an immediate
> +//	quiescent state for that task, or, failing that, attempt to set
> +//	that task's .need_qs flag so that that task's next outermost
> +//	rcu_read_unlock_trace() will report the quiescent state (in which
> +//	case the count of readers is incremented).  If both attempts fail,
> +//	the task is added to a "holdout" list.
> +// rcu_tasks_trace_postscan():
> +//	Initialize state and attempt to identify an immediate quiescent
> +//	state as above (but only for idle tasks), unblock CPU-hotplug
> +//	operations, and wait for an RCU grace period to avoid races with
> +//	tasks that are in the process of exiting.
> +// check_all_holdout_tasks_trace(), repeatedly until holdout list is empty:
> +//	Scans the holdout list, attempting to identify a quiescent state
> +//	for each task on the list.  If there is a quiescent state, the
> +//	corresponding task is removed from the holdout list.
> +// rcu_tasks_trace_postgp():
> +//	Wait for the count of readers do drop to zero, reporting any stalls.
> +//	Also execute full memory barriers to maintain ordering with code
> +//	executing after the grace period.
> +//
> +// The exit_tasks_rcu_finish_trace() synchronizes with exiting tasks.
> +//
> +// Pre-grace-period update-side code is ordered before the grace
> +// period via the ->cbs_lock and barriers in rcu_tasks_kthread().
> +// Pre-grace-period read-side code is ordered before the grace period by
> +// atomic_dec_and_test() of the count of readers (for IPIed readers) and by
> +// scheduler context-switch ordering (for locked-down non-running readers).

The rest looks good, thanks!

Mathieu

> 
> // The lockdep state must be outside of #ifdef to be useful.
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
