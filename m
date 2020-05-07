Return-Path: <SRS0=FT7R=6V=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7FEC38A2A
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 17:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C00E21835
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 17:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588872581;
	bh=r39xMmigKivhPPlIKOvHm45Ybws7fuIszyZHNa0vZmE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=JDeq7deMazbUnbYpBjikvya+whMrxXb31+mWQW2PNpH2iZgEG4S3yBTG+LqkWNjeI
	 pIxO2BrYOeIDRASgzhN1lMl6budSq516uWgihC/aM3tw3yftCmc2teHuO7ApVK8XeB
	 8KBAcrfxSt5tane0lOTW8ixGJwpTwsD+PvnHS5Jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgEGR3l (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 May 2020 13:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEGR3l (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 May 2020 13:29:41 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36354215A4;
        Thu,  7 May 2020 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588872580;
        bh=r39xMmigKivhPPlIKOvHm45Ybws7fuIszyZHNa0vZmE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=h/DCGBbLuQ/awMiqkf3XrCQDtwGZznhv3t+cedY2cITEjz1EAbf15zsD9BnriYlkZ
         ePTWkF9sORzYCX1c97tzJJYili8aTA6K6huAdJqkqIEfkqVzFehr21hWRomb8KBszg
         hv/K3rpvsRfwylyl9YA8Cn4Za9Sp0o7tZnIxYxQc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1D8F535231A1; Thu,  7 May 2020 10:29:40 -0700 (PDT)
Date:   Thu, 7 May 2020 10:29:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, viro@zeniv.linux.org.uk,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH RFC tip/core/rcu] Add shrinker to shift to
 fast/inefficient GP mode
Message-ID: <20200507172940.GA19915@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200507004240.GA9156@paulmck-ThinkPad-P72>
 <20200506175535.d4986a4d497071a410b69765@linux-foundation.org>
 <20200507170006.GA155220@cmpxchg.org>
 <20200507170903.GR2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507170903.GR2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 07, 2020 at 10:09:03AM -0700, Paul E. McKenney wrote:
> On Thu, May 07, 2020 at 01:00:06PM -0400, Johannes Weiner wrote:
> > On Wed, May 06, 2020 at 05:55:35PM -0700, Andrew Morton wrote:
> > > On Wed, 6 May 2020 17:42:40 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > 
> > > > This commit adds a shrinker so as to inform RCU when memory is scarce.
> > > > RCU responds by shifting into the same fast and inefficient mode that is
> > > > used in the presence of excessive numbers of RCU callbacks.  RCU remains
> > > > in this state for one-tenth of a second, though this time window can be
> > > > extended by another call to the shrinker.
> > 
> > We may be able to use shrinkers here, but merely being invoked does
> > not carry a reliable distress signal.
> > 
> > Shrinkers get invoked whenever vmscan runs. It's a useful indicator
> > for when to age an auxiliary LRU list - test references, clear and
> > rotate or reclaim stale entries. The urgency, and what can and cannot
> > be considered "stale", is encoded in the callback frequency and scan
> > counts, and meant to be relative to the VM's own rate of aging: "I've
> > tested X percent of mine for recent use, now you go and test the same
> > share of your pool." It doesn't translate well to other
> > interpretations of the callbacks, although people have tried.
> 
> Would it make sense for RCU to interpret two invocations within (say)
> 100ms of each other as indicating urgency?  (Hey, I had to ask!)
> 
> > > > If it proves feasible, a later commit might add a function call directly
> > > > indicating the end of the period of scarce memory.
> > > 
> > > (Cc David Chinner, who often has opinions on shrinkers ;))
> > > 
> > > It's a bit abusive of the intent of the slab shrinkers, but I don't
> > > immediately see a problem with it.  Always returning 0 from
> > > ->scan_objects might cause a problem in some situations(?).
> > > 
> > > Perhaps we should have a formal "system getting low on memory, please
> > > do something" notification API.
> > 
> > It's tricky to find a useful definition of what low on memory
> > means. In the past we've used sc->priority cutoffs, the vmpressure
> > interface (reclaimed/scanned - reclaim efficiency cutoffs), oom
> > notifiers (another reclaim efficiency cutoff). But none of these
> > reliably capture "distress", and they vary highly between different
> > hardware setups. It can be hard to trigger OOM itself on fast IO
> > devices, even when the machine is way past useful (where useful is
> > somewhat subjective to the user). Userspace OOM implementations that
> > consider userspace health (also subjective) are getting more common.
> > 
> > > How significant is this?  How much memory can RCU consume?
> > 
> > I think if rcu can end up consuming a significant share of memory, one
> > way that may work would be to do proper shrinker integration and track
> > the age of its objects relative to the age of other allocations in the
> > system. I.e. toss them all on a clock list with "new" bits and shrink
> > them at VM velocity. If the shrinker sees objects with new bit set,
> > clear and rotate. If it sees objects without them, we know rcu_heads
> > outlive cache pages etc. and should probably cycle faster too.
> 
> It would be easy for RCU to pass back (or otherwise use) the age of the
> current grace period, if that would help.
> 
> Tracking the age of individual callbacks is out of the question due to
> memory overhead, but RCU could approximate this via statistical sampling.
> Comparing this to grace-period durations could give information as to
> whether making grace periods go faster would be helpful.
> 
> But, yes, it would be better to have an elusive unambiguous indication
> of distress.  ;-)

And I have dropped this patch for the time being, but I do hope that
it served a purpose in illustrating that it is not difficult to put RCU
into a fast-but-inefficient mode when needed.

							Thanx, Paul
