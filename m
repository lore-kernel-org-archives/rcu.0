Return-Path: <SRS0=HuQd=5F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16990C4332D
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 16:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D362720739
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584721652;
	bh=gwsNsin4/SYg1Xj0KQ+zV+B8Z3aO3Bg8kEnqtbQn7Oc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=GB+EnGW7jlx7SQTPGu1yvtn/7MEBLe3d0Zl2PGklsIPBp4giHaIqK7BMO1adO1b8q
	 Y0oV4QVU+yJWHnAhS1u8MOrqSoRy/AIBapxubIwT/yHknxlgiCxMmpAe1+QkuiJ6M4
	 ESyRHoNczqwdXAOoA4gPSEIVyxq7A8G0WjPJPMlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCTQ1c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbgCTQ1c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Mar 2020 12:27:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5E6520724;
        Fri, 20 Mar 2020 16:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584721651;
        bh=gwsNsin4/SYg1Xj0KQ+zV+B8Z3aO3Bg8kEnqtbQn7Oc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sYpq5idgbfPCkOXvP9v10jUWhgcWOkAqCS6lMIHDNrKY4kHXbxslXyhOsVlWwOIEg
         NsSPGQsIJGjWY0qvwWsQrO01v2+BmXBzVBKTeKmUh+3Fcs2XEPfCaT0FJtJC8qjXDI
         8TtwLtKyYaJzXtwo3R9/8oiPfAcH+1X00W0867sg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C0E0135226B4; Fri, 20 Mar 2020 09:27:31 -0700 (PDT)
Date:   Fri, 20 Mar 2020 09:27:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH RFC v2 tip/core/rcu 01/22] sched/core: Add function to
 sample state of locked-down task
Message-ID: <20200320162731.GQ3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-1-paulmck@kernel.org>
 <20200319132238.75a034c3@gandalf.local.home>
 <20200319173525.GI3199@paulmck-ThinkPad-P72>
 <20200320024943.GA29649@paulmck-ThinkPad-P72>
 <20200319230945.3f4701ed@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319230945.3f4701ed@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 19, 2020 at 11:09:45PM -0400, Steven Rostedt wrote:
> On Thu, 19 Mar 2020 19:49:43 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > The current setup is very convenient for the use cases thus far.  It
> > > allows the function to say "Yeah, I was called, but I couldn't do
> > > anything", thus allowing the caller to make exactly one check to know
> > > that corrective action is required.  
> > 
> > And here is another use case that led me to take this approach.
> > The trc_inspect_reader_notrunning() function in the patch below is passed
> > to try_invoke_on_locked_down_task() whose caller can continue testing
> > just the return value from try_invoke_on_locked_down_task() to work out
> > what to do next.
> > 
> > Thoughts?  Other use cases?
> 
> Note, I made this comment before looking at the use cases in the later
> patches. I was looking at it for a more generic purpose, but I'm not
> sure there is one.
> 
> It's fine as is for now.

Sounds good, and again thank you for looking this over!

							Thanx, Paul
