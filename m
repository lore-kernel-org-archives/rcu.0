Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0569C3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 17:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD59206B8
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 17:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588614255;
	bh=9Sb1ZJEY/oPGWjp07mTfMZs9PiyuEaUxtKetFjkV1zY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=LPf5K4RBek/2a1n5qYA6s41XjbwQI8lKIiDPXKN+aaB8+jDzy9Ez1qcjZpb+m3MMr
	 RP5cUNkbZIfiTeQHYFliTYLbr+SdZiu58xIUGcsG8nOVO5BqP/cUuG2KNda6m45OaX
	 hM1hv3EID2tj8BoQqpetc/3Nc606ceXVKPSm6QXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgEDRoP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 13:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbgEDRoP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 May 2020 13:44:15 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8DD4206A4;
        Mon,  4 May 2020 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588614254;
        bh=9Sb1ZJEY/oPGWjp07mTfMZs9PiyuEaUxtKetFjkV1zY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fU3T+tszlgh22hrOk5J0VcoUX2E6BbRaWKyq8iSD8BgDncfy9Jm3Tn6py+DXjHJ8k
         obeZ7/FhD761N6QvensAuDhNakfKXkOKm6E6nuKoubu1j4zX2SGxNRm8UgjeMkfkDv
         ZZS+2Tq+9clTyLWaYtQ9sEHvzh/Cii3+2bt6XUTg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1CC0135226F4; Mon,  4 May 2020 10:44:13 -0700 (PDT)
Date:   Mon, 4 May 2020 10:44:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        peterz@infradead.org, Petr Mladek <pmladek@suse.com>,
        rcu@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        vpillai@digitalocean.com
Subject: Re: [PATCH v3 0/5] RCU dyntick nesting counter cleanups for rcu -dev
Message-ID: <20200504174413.GA8883@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200504120505.89351-1-joel@joelfernandes.org>
 <20200504171532.GR2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504171532.GR2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 04, 2020 at 10:15:32AM -0700, Paul E. McKenney wrote:
> On Mon, May 04, 2020 at 08:05:00AM -0400, Joel Fernandes (Google) wrote:
> > These patches clean up the usage of dynticks nesting counters simplifying the
> > code, while preserving the usecases.
> > 
> > It is a much needed simplification, makes the code less confusing, and prevents
> > future bugs such as those that arise from forgetting that the
> > dynticks_nmi_nesting counter is not a simple counter and can be "crowbarred" in
> > common situations.
> > 
> > rcutorture testing with all TREE RCU configurations succeed with
> > CONFIG_RCU_EQS_DEBUG=y and CONFIG_PROVE_LOCKING=y.
> > 
> > v1->v2:
> > - Rebase on v5.6-rc6
> > 
> > v2->v3:
> > - Rebase on rcu/dev with adjustments for tasks-RCU.
> 
> Thank you!
> 
> But this does not apply to any of v5.6-rc6, v5.7-rc1, or v5.7-rc2.
> 
> Where should I be trying to apply it?

OK, morning blindness overcome.  I new see the "rcu/dev" in v2->v3.

Please accept my apologies for the noise.

							Thanx, Paul

> > Joel Fernandes (Google) (4):
> > Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom of
> > ->dynticks counter")
> > rcu/tree: Add better tracing for dyntick-idle
> > rcu/tree: Clean up dynticks counter usage
> > rcu/tree: Remove dynticks_nmi_nesting counter
> > 
> > Madhuparna Bhowmik (1):
> > trace: events: rcu: Change description of rcu_dyntick trace event
> > 
> > .../Data-Structures/Data-Structures.rst       |  31 +--
> > Documentation/RCU/stallwarn.rst               |   6 +-
> > include/linux/rcutiny.h                       |   3 -
> > include/trace/events/rcu.h                    |  29 +--
> > kernel/rcu/rcu.h                              |   4 -
> > kernel/rcu/tree.c                             | 199 +++++++-----------
> > kernel/rcu/tree.h                             |   4 +-
> > kernel/rcu/tree_stall.h                       |   4 +-
> > 8 files changed, 110 insertions(+), 170 deletions(-)
> > 
> > --
> > 2.26.2.526.g744177e7f7-goog
> > 
