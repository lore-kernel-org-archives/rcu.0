Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9E7C0044D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 20:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B078320674
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 20:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584390762;
	bh=nklUAC/alqRi607y+IxIxqF+82IeDZb9jP6+Nc9EVK4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=meJYihVUECf2Uvs8RMET6NTQ1gRG/QDY+9wWBnVj8w3jWnqSQPSO8kE2deC8FZtNy
	 HTxprNxS5Ijyi2NhhBnOuIzQ2XkmBvTegRqT1hzFCjLHnc8A4qq5W1qmgfWL+Q8aOX
	 iGADZ2afavQ1cnXi2uvRcXIcvgVy38gGoLci+AOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbgCPUcm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732486AbgCPUcm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 16:32:42 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA4920663;
        Mon, 16 Mar 2020 20:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584390761;
        bh=nklUAC/alqRi607y+IxIxqF+82IeDZb9jP6+Nc9EVK4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XYJPJxiPOf9exMhHRhTNBwNosOCCwOwVwPOPPUZQkzHevXiguzDXhUxeMDS2PAlOc
         VMwN1W+kiT4a9kwnR5u6x8FjnfvknmRZT+Wi7o6DlwZ1Eb4dcqy6PrteY4UibOnXyp
         hCnAUvCrbrFpFwQpXR1sG9n0HDVDOvrO1msHwAQo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 282D43522DE1; Mon, 16 Mar 2020 13:32:41 -0700 (PDT)
Date:   Mon, 16 Mar 2020 13:32:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com," <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH RFC tip/core/rcu 09/16] rcu-tasks: Add an RCU-tasks rude
 variant
Message-ID: <20200316203241.GB3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
 <20200312181702.8443-9-paulmck@kernel.org>
 <20200316194754.GA172196@google.com>
 <CAEXW_YREzQ8hMP_vGiQFiNAtwxPn_C0TG6mH68QaS8cES-Jr3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YREzQ8hMP_vGiQFiNAtwxPn_C0TG6mH68QaS8cES-Jr3Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 16, 2020 at 04:17:51PM -0400, Joel Fernandes wrote:
> On Mon, Mar 16, 2020 at 3:47 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Thu, Mar 12, 2020 at 11:16:55AM -0700, paulmck@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > >
> > > This commit adds a "rude" variant of RCU-tasks that has as quiescent
> > > states schedule(), cond_resched_tasks_rcu_qs(), userspace execution,
> > > and (in theory, anyway) cond_resched().  Updates make use of IPIs and
> > > force an IPI and a context switch on each online CPU.  This variant
> > > is useful in some situations in tracing.
> >
> > Would it be possible to better clarify that the "rude version" works only
> > from preempt-disabled regions? Is that also true for the "non-rude" version?
> >
> > Also it would be good to clarify better in cover letter, how these new
> > flavors relate to the existing Tasks-RCU implementation.
> >
> > In the existing one, a quiescent state is a task updating its context switch
> > counters such that it went to sleep at least once, implying there is no
> > chance it is on an about to be destroyed trampoline.
> >
> > However, here we are trying to determine if a task state is no longer on an
> > RQ (which I gleaned from the first patch). Sounds very similar, would the
> > context switch counters not help in that determination as well? If it is Ok,
> > it would be good to describe in cover letter about what is exactly is a
> > quiescent state and what exactly is a reader section in the cover letter, for
> > both non-rude and rude version. Thanks!
> 
> Just curious, why is the "rude" version better than SRCU? Seems the
> schedule_on_each_cpu() would be much slower than SRCU especially if
> there are 1000s of CPUs involved. Is there any reason that is a better
> alternative?

The rude version has much faster readers, and the story I hear is that
there are not expected to be all that many concurrent updaters.

But to get more detail, why not ask Steven why he chose not to use SRCU?
(I know the story for the BPF guys, and it is because of SRCU's read-side
overhead.)

							Thanx, Paul
