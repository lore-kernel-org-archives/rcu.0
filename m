Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E69C0044D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 15:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3624620679
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584373184;
	bh=BF/Y6VdwrEGYZgDYRo8+Zp93Zdq85GyGk4o7+hsg5UU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=bja85iHiHrqCAIADL4fu3oXok/oWR6fN8tcS/btd+cfD3Wqd2f9j8n+8n/01p16ZL
	 fBMMG4qUIOxU/GigMCPaDNxJRfEa4d/9fJ6O9sTPxJvZlsBVnfSFtRfiCcd6NqRGYU
	 iBgaLmm8UxBQo0+FPg1l3kT9A+RiKu2s9mlON8RY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbgCPPjn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:39:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731780AbgCPPjn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 11:39:43 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5F4720719;
        Mon, 16 Mar 2020 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584373182;
        bh=BF/Y6VdwrEGYZgDYRo8+Zp93Zdq85GyGk4o7+hsg5UU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MJoPs6o6i35Vcgl3lZ4NI4X5LKNVqBMQ3tRpe8xHgHtE1SjxVdrCSDGhAaLOspQOF
         giOWYDYJY3iVb6Jy3Xj0RVEAa+xjmudZAbQBWPQMGGqTK5+oWifGNV5/4sMM6PEUoC
         KATXZRnN+BV7IOI2iBEW4TyTEle8VaLvG8uU39oo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7C3323522DE1; Mon, 16 Mar 2020 08:39:42 -0700 (PDT)
Date:   Mon, 16 Mar 2020 08:39:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     mutt@paulmck-ThinkPad-P72, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 0/16] Prototype RCU usable from idle,
 exception, offline
Message-ID: <20200316153942.GW3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
 <20200313144145.GA31604@lenoir>
 <20200313154243.GU3199@paulmck-ThinkPad-P72>
 <20200316144535.GA501@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316144535.GA501@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 16, 2020 at 03:45:36PM +0100, Frederic Weisbecker wrote:
> On Fri, Mar 13, 2020 at 08:42:43AM -0700, Paul E. McKenney wrote:
> > On Fri, Mar 13, 2020 at 03:41:46PM +0100, Frederic Weisbecker wrote:
> > > On Thu, Mar 12, 2020 at 11:16:18AM -0700, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > This series provides two variants of Tasks RCU, a rude variant inspired
> > > > by Steven Rostedt's use of schedule_on_each_cpu(), and a tracing variant
> > > > requested by the BPF folks and perhaps also of use for other tracing
> > > > use cases.
> > > > 
> > > > The tracing variant has explicit read-side markers to permit finite grace
> > > > periods even given in-kernel loops in PREEMPT=n builds It also protects
> > > > code in the idle loop, on exception entry/exit paths, and on the various
> > > > CPU-hotplug online/offline code paths, thus having protection properties
> > > > similar to SRCU.  However, unlike SRCU, this variant avoids expensive
> > > > instructions in the read-side primitives, thus having read-side overhead
> > > > similar to that of preemptible RCU.
> > > > 
> > > > There are of course downsides.  The grace-period code can send IPIs to
> > > > CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
> > > > It is necessary to scan the full tasklist, much as for Tasks RCU.  There
> > > > is a single callback queue guarded by a single lock, again, much as for
> > > > Tasks RCU.  If needed, these downsides can be at least partially remedied
> > > 
> > > So what we trade to fix the issues we are having with tracing against extended
> > > grace periods, we lose in CPU isolation. That worries me a bit as tracing can
> > > be thoroughly used with nohz_full and CPU isolation.
> > 
> > First, disturbing nohz_full CPUs can be avoided by the sysadm simply
> > refusing to remove tracepoints while sensitive applications are running
> > on nohz_full CPUs.
> 
> So, in that case we'll need to modify the tools such as perf tools to avoid
> releasing the related buffers until we are ready to do so.
> 
> That's possible but it's kindof an ABI breakage. Also what if there is a
> long running service on that nohz full CPU polling on the networking card...

In the near term, I do admit that Mathieu's point about using smp_mb()
in readers but only on nohz_full CPUs is attractive.

I have some other ideas, but simplicity has its advantages, and if no
one complains, perhaps those advantages are also good for the long term.

							Thanx, Paul
