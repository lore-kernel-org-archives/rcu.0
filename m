Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33CAC0044D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 22:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F0C2071C
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 22:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732716AbgCPWD4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732652AbgCPWD4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 18:03:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E199D20674;
        Mon, 16 Mar 2020 22:03:53 +0000 (UTC)
Date:   Mon, 16 Mar 2020 18:03:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com," <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH RFC tip/core/rcu 09/16] rcu-tasks: Add an RCU-tasks rude
 variant
Message-ID: <20200316180352.4816cb99@gandalf.local.home>
In-Reply-To: <CAEXW_YRtGhiaz+86pTL2WTyx5tqrpjB-bgQbnMLXjSQXPCmYfw@mail.gmail.com>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
        <20200312181702.8443-9-paulmck@kernel.org>
        <20200316194754.GA172196@google.com>
        <CAEXW_YREzQ8hMP_vGiQFiNAtwxPn_C0TG6mH68QaS8cES-Jr3Q@mail.gmail.com>
        <20200316203241.GB3199@paulmck-ThinkPad-P72>
        <20200316173219.1f8b7443@gandalf.local.home>
        <CAEXW_YRtGhiaz+86pTL2WTyx5tqrpjB-bgQbnMLXjSQXPCmYfw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 16 Mar 2020 17:45:40 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> >
> > Same for the function side (if not even more so). This would require adding
> > a srcu_read_lock() to all functions that can be traced! That would be a huge
> > kill in performance. Probably to the point no one would bother even using
> > function tracer.  
> 
> Point well taken! Thanks,

Actually, it's worse than that. (We talked about this on IRC but I wanted
it documented here too).

You can't use any type of locking, unless you insert it around all the
callers of the nops (which is unreasonable).

That is, we have gcc -pg -mfentry that creates at the start of all traced
functions:

 <some_func>:
    call __fentry__
    [code for function here]

At boot up (or even by the compiler itself) we convert that to:

 <some_func>:
    nop
    [code for function here]


When we want to trace this function we use text_poke (with current kernels)
and convert it to this:

 <some_func>:
    call trace_trampoline
    [code for function here]


That trace_trampoline can be allocated, which means when its no longer
needed, it must be freed. But when do we know it's safe to free it? Here's
the issue.


 <some_func>:
    call trace_trampoline  <- interrupt happens just after the jump
    [code for function here]

Now the task has just executed the call to the trace_trampoline. Which
means the instruction pointer is set to the start of the trampoline. But it
has yet executed that trampoline.

Now if the task is preempted, and a real time hog is keeping it from
running for minutes at a time (which is possible!). And in the mean time,
we are done with that trampoline and free it. What happens when that task
is scheduled back? There's no more trampoline to execute even though its
instruction pointer is to execute the first operand on the trampoline!

I used the analogy of jumping off the cliff expecting a magic carpet to be
there to catch you, and just before you land, it disappears. That would be
a very bad day indeed!

We have no way to add a grace period between the start of a function (can
be *any* function) and the start of the trampoline. Since the problem is
that the task was non-voluntarily preempted before it could execute the
trampoline, and that trampolines are not allowed (suppose) to call
schedule, then we have our quiescent state to track (voluntary scheduling).
When all tasks have either voluntarily scheduled, or entered user space
after disconnecting a trampoline from a function, we know that it is safe to
free the trampoline.

-- Steve
