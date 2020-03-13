Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7CEC2BB1D
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E79206E2
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584114165;
	bh=UooZSFKMpcy1PzJo48+1CHGIj4c7gbOpifD6iMLhBZo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Xcbm213kSPD1YJVUPaRx+qMSTbgjXhSGd1AJjynMAX+M+npg/ivFFhP9J9GJVjTvL
	 BTLRDEwY5tbudKESt7Zgt6KrKT0BNuGLN5LLvSac0tt67syG1El+81pXFPsU10nogQ
	 1nlLWgdx2bvpd4x/JtK2R9zi4EKOWt1nh+nesM4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCMPmo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgCMPmo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 11:42:44 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D1C206B7;
        Fri, 13 Mar 2020 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584114163;
        bh=UooZSFKMpcy1PzJo48+1CHGIj4c7gbOpifD6iMLhBZo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Xm6oYDsQ+O0rSWeMIzGlS7otfVJxpr6azEsuq8HhE2Xb8L/N9hDwHRBLS2uQhXTZI
         BZ0I6rh1rNGL4LEZbveLfUJ2MhV5esFhborrwLN7Ww881u6g6LxD253X0hD1HeDtDj
         JjQemximUEpaUxFtnu4Cm21zszade/qlLihdtAGs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B3A183522719; Fri, 13 Mar 2020 08:42:43 -0700 (PDT)
Date:   Fri, 13 Mar 2020 08:42:43 -0700
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
Message-ID: <20200313154243.GU3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
 <20200313144145.GA31604@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313144145.GA31604@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 13, 2020 at 03:41:46PM +0100, Frederic Weisbecker wrote:
> On Thu, Mar 12, 2020 at 11:16:18AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series provides two variants of Tasks RCU, a rude variant inspired
> > by Steven Rostedt's use of schedule_on_each_cpu(), and a tracing variant
> > requested by the BPF folks and perhaps also of use for other tracing
> > use cases.
> > 
> > The tracing variant has explicit read-side markers to permit finite grace
> > periods even given in-kernel loops in PREEMPT=n builds It also protects
> > code in the idle loop, on exception entry/exit paths, and on the various
> > CPU-hotplug online/offline code paths, thus having protection properties
> > similar to SRCU.  However, unlike SRCU, this variant avoids expensive
> > instructions in the read-side primitives, thus having read-side overhead
> > similar to that of preemptible RCU.
> > 
> > There are of course downsides.  The grace-period code can send IPIs to
> > CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
> > It is necessary to scan the full tasklist, much as for Tasks RCU.  There
> > is a single callback queue guarded by a single lock, again, much as for
> > Tasks RCU.  If needed, these downsides can be at least partially remedied
> 
> So what we trade to fix the issues we are having with tracing against extended
> grace periods, we lose in CPU isolation. That worries me a bit as tracing can
> be thoroughly used with nohz_full and CPU isolation.

First, disturbing nohz_full CPUs can be avoided by the sysadm simply
refusing to remove tracepoints while sensitive applications are running
on nohz_full CPUs.

Second, for non-CPU-bound real-time programs with mostly-idle CPUs,
I should be able to decrease the likelihood of sending IPIs pretty much
to zero.

Or am I missing something here?

							Thanx, Paul
