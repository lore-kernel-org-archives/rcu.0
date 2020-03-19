Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5F4C4332D
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 13:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCF62166E
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623608;
	bh=oKMiaXwXF0FwppE8RiMf8SZN1D2DabbAfD+fZYIm7VI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=XX4Hm48WCKeNOTljuM8zpHFifNR6R5qmiXmJvy6xV6KKjrJlqR8qHu4bnnpZsDuyR
	 I4OZAT7XPZeFdMpLmAM6MBCxt7HKFyrRk+/UPk6GaNDg8irWzcq052zI5MQTkzaF2I
	 35EqipDcVMrz5sDSBjDPwigNCLnBe06q2ulHLQ38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgCSNN0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgCSNNZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Mar 2020 09:13:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B612F21556;
        Thu, 19 Mar 2020 13:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623604;
        bh=oKMiaXwXF0FwppE8RiMf8SZN1D2DabbAfD+fZYIm7VI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XtiMDZ6FNO/imycLif74P9Euk04wI2o8MH8wAcjVtyTlhsYAU27PUTLQYShiIJBRC
         LvdAQsrWYtp8rZH2AKoQnf9oob6rqrMX4Kh5FGQE4dKUwp4T/Z8QhJyy+visM5aFSl
         tH36L+o6x466+fC8xiAzvkm6LHICIhXbseiwz3yQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8859335227C6; Thu, 19 Mar 2020 06:13:24 -0700 (PDT)
Date:   Thu, 19 Mar 2020 06:13:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Subject: Re: [PATCH RFC v2 tip/core/rcu 0/22] Prototype RCU usable from idle,
 exception, offline
Message-ID: <20200319131324.GB3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
 <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <1560487611.2836.1584617498827.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560487611.2836.1584617498827.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 19, 2020 at 07:31:38AM -0400, Mathieu Desnoyers wrote:
> ----- On Mar 18, 2020, at 8:10 PM, paulmck paulmck@kernel.org wrote:
> 
> > Hello!
> 
> Hi Paul,
> 
> Thanks for pulling this together! Some comments below (based only on the
> cover message),

And thank you for your review and comments!

> [...]
> 
> > There are of course downsides.  The grace-period code can send IPIs to
> > CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
> > However, this version enlists the aid of the context-switch hooks,
> > which eliminates the need for IPIs in context-switch-heavy workloads.
> > It also prohibits sending of IPIs early in the grace period, which
> > provides additional opportunity for the hooks to do their job.  Additional
> > IPI-reduction mechanisms are under development.
> 
> I suspect that on nohz_full cpus, at least some use-cases which really care
> about not receiving IPIs will not be doing that many context switches.
> 
> What are the possible approaches to have IPI-*elimination* for nohz cpus ?

Pretty much as you suggested, actually.  I have some other approaches
that should eliminate read-side overhead, and thus might prove necessary
longer term.  However, from what I can see your suggestion is good and
sufficient, and perhaps indefinitely.  So thank you for that!

In more detail:

Add a per-task flag that tells readers to use smp_mb().  In kernels
built for these workloads (CONFIG_TASKS_TRACE_RCU_READ_MB=y), set
this flag on entry to usermode/idle (that is, the non-offline RCU
extended quiescent states) and clear it upon exit.  The pre-existing
dyntick-counter increment provides the necessary mameory ordering.
Then if the update side sees that the task is running on a CPU in a
non-offline extended quiescent state (which just happens to be what the
dynticks counter already indicates), it carries out the checks knowing
that the reader is using memory barriers.

The initial state sets CONFIG_TASKS_TRACE_RCU_READ_MB=y when either
CONFIG_PREEMPT_RT=y or when CONFIG_NR_CPUS < 8.  The rationale for
the former is that HPC NO_HZ_FULL workloads probably don't care
all that much about a stray IPI as long as it happens infrequently.
500ms should qualify as "infrequently".  The rationale for the latter
was that I couldn't get any better heuristic than number of CPUs from
my battery-powered contacts.  Yes, 8 is a bit low, especially given
that my own smartphone has 8 CPUs, but I have to start somewhere.
Another option is for battery-powered devices to just "select
CONFIG_TASKS_TRACE_RCU_READ_MB" in their defconfig files.

This work has started in -rcu, but was not to the point where I felt
comfortable sending it in yesterday's series.  And yes, I will add it
to the cover letter, hopefully on the next version of this patch set.

> > The RCU tasks trace mechanism is based off of RCU tasks rather than
> > SRCU because the latter is more complex and also because the latter
> > uses a CPU-by-CPU approach to tracking quiescent states instead of the
> > task-by-task approach that is needed.  It is in theory possible to
> > mash RCU tasks trace into the Tree SRCU implementation, but there
> > will need to be extremely good reasons for doing so.
> 
> I have a hard time buying the "less complexity" argument to justify the
> introduction of yet another flavor of RCU when a close match already
> exists (SRCU).

Tree SRCU is not the simplest thing out there.  And please see below.

> The other argument for this task-based RCU (rather than CPU-by-CPU as
> done by SRCU) is that "a task-by-task approach is needed". What I
> do not get from this explanation is why is such an approach needed ?

Because SRCU's accounting only knows the number of things that are
preventing the current grace period from ending.  In this, it differs
from userspace RCU, which knows exactly which threads are preventing the
current grace period from ending.  In contrast, SRCU has absolutely no
idea which task or CPU is preventing the grace period from ending.
SRCU is therefore incapable of locking down those tasks to encourage
them to report the next quiescent state.

Yes, SRCU could be modified.  Maybe someday that will prove a good
idea.  Today is not that day, nor is that day coming soon.

> Also, another aspect worth discussing here is the use-cases which
> need to be covered by tracing-rcu. Is this specific flavor targeting
> specifically preempt-off use-cases, or is the goal here to target
> use-cases which may trigger major page faults within the read-side
> critical section as well ?

Yes, CONFIG_PREEMPT=n use cases are still extremely important.  Don't get
me wrong, real-time computing does have a warm place in my heart, but
there is still a very large number of CONFIG_PREEMPT=n systems running
out there.  And yes, the ability to handle the occasional page fault is
also important.  So both simultaneously, not just one or the other.

> Note that doing task-by-task tracking of tracing-rcu rather than
> cpu-by-cpu is not free: AFAIU it bloats the task struct (always)
> for a use-case which is not always active. My experience with
> tracepoints and asm gotos is that we need to be careful not to
> slow down the common case (kernel running without any tracing
> active, but tracing configured in) if we want to keep distributions
> and end users building kernels with introspection facilities in
> place.

Which is indeed another reason for not pressing SRCU into service here.
There would have to be a "special" srcu_struct that owned a piece of
the task_struct structure on the one hand, or there would need to be
another set of allocations done at the creation of each task for each
such srcu_struct on the other.  Neither sounds at all attractive.

Please note also that Tasks RCU, which is already used by many forms of
tracing, already added a similar amount to the task_struct structure quite
some time ago.  But you are right that I should to add an item to my todo
list to squeeze the state down a bit, and for both variants while I am
at it.  For but one example, I could automatically use a short for the
CPU numbers when CONFIG_NR_CPUS is less than 32,768.  Perhaps a similar
optimization could be applied elsewhere in the task_struct structure.

							Thanx, Paul
