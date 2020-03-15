Return-Path: <SRS0=wCpI=5A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAF4C10F29
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 17:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA7B206B1
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 17:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584295163;
	bh=ooTtotCxj4FN51+o+o5KvI92R+015dWBAK0qfGoPVHQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=oextyqt1FntWXLm4cPVysJjMYuKee+m/x8xsjiTkFQvwwkcchV3/GHiqQIGOK8V/p
	 ss2LE7sK58YPwR1CQKWavqvVaPS5lH5kYtgPW2h+QWYpaWhIkANvX3YGR12J/oo8gz
	 C2g2GbngzUVQjzEQSq0jqAxFfVLX0YCul/QXv3E4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgCOR7X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Mar 2020 13:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgCOR7W (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Mar 2020 13:59:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A8B20658;
        Sun, 15 Mar 2020 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584295161;
        bh=ooTtotCxj4FN51+o+o5KvI92R+015dWBAK0qfGoPVHQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GopWpZgPHmRn4mrjcnQ7gPbZ4szw44CQmgy2sEjgpcaRbaeeMU42Ac8PjZhRfQEIa
         02A4YCtsL/kgRPzmnP6HAMD0ttXJqWjPDfRSWrrQjsP0MdLDuZOULEp4kkGa0T+1B6
         bMntSkij3K+OtrzPag5fO9lP43/l/PPeYRS/pfkI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A6F5635226D7; Sun, 15 Mar 2020 10:59:21 -0700 (PDT)
Date:   Sun, 15 Mar 2020 10:59:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>,
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
Subject: Re: [PATCH RFC tip/core/rcu 0/16] Prototype RCU usable from idle,
 exception, offline
Message-ID: <20200315175921.GT3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
 <20200313144145.GA31604@lenoir>
 <20200313154243.GU3199@paulmck-ThinkPad-P72>
 <2062731308.28584.1584294305768.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2062731308.28584.1584294305768.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Mar 15, 2020 at 01:45:05PM -0400, Mathieu Desnoyers wrote:
> ----- On Mar 13, 2020, at 11:42 AM, paulmck paulmck@kernel.org wrote:
> 
> > On Fri, Mar 13, 2020 at 03:41:46PM +0100, Frederic Weisbecker wrote:
> >> On Thu, Mar 12, 2020 at 11:16:18AM -0700, Paul E. McKenney wrote:
> >> > Hello!
> >> > 
> >> > This series provides two variants of Tasks RCU, a rude variant inspired
> >> > by Steven Rostedt's use of schedule_on_each_cpu(), and a tracing variant
> >> > requested by the BPF folks and perhaps also of use for other tracing
> >> > use cases.
> >> > 
> >> > The tracing variant has explicit read-side markers to permit finite grace
> >> > periods even given in-kernel loops in PREEMPT=n builds It also protects
> >> > code in the idle loop, on exception entry/exit paths, and on the various
> >> > CPU-hotplug online/offline code paths, thus having protection properties
> >> > similar to SRCU.  However, unlike SRCU, this variant avoids expensive
> >> > instructions in the read-side primitives, thus having read-side overhead
> >> > similar to that of preemptible RCU.
> >> > 
> >> > There are of course downsides.  The grace-period code can send IPIs to
> >> > CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
> >> > It is necessary to scan the full tasklist, much as for Tasks RCU.  There
> >> > is a single callback queue guarded by a single lock, again, much as for
> >> > Tasks RCU.  If needed, these downsides can be at least partially remedied
> >> 
> >> So what we trade to fix the issues we are having with tracing against extended
> >> grace periods, we lose in CPU isolation. That worries me a bit as tracing can
> >> be thoroughly used with nohz_full and CPU isolation.
> > 
> > First, disturbing nohz_full CPUs can be avoided by the sysadm simply
> > refusing to remove tracepoints while sensitive applications are running
> > on nohz_full CPUs.
> 
> I doubt this approach will survive real-life.

Nothing survives real life, at least not indefinitely.  ;-)

> > Second, for non-CPU-bound real-time programs with mostly-idle CPUs,
> > I should be able to decrease the likelihood of sending IPIs pretty much
> > to zero.
> > 
> > Or am I missing something here?
> 
> I would recommend considering the following alternative for this tracing-rcu
> flavor:
> 
> - For all CPUs which are not nohz_full:
>   - Implement fast RCU read-side which only requires compiler barriers,
>   - Use IPIs to each of those CPUs when doing a grace period.
> 
> - For all nohz_full CPUS:
>   - Dynamically detect CPUs which are nohz_full,
>   - Implement slower RCU read-side with memory barriers,
>   - No need to issue any IPI to those CPUs when doing the grace period.
> 
> This should cover all use-cases: staying fast for the common case, without
> disturbing RT workloads.
> 
> Thoughts ?

I will certainly add this to my list of potential solutions, and thank
you for pointing me at it!

							Thanx, Paul
