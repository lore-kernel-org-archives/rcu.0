Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B696C433E0
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 18:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80DE64E77
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 18:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhBSSSx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Feb 2021 13:18:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhBSSSx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Feb 2021 13:18:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0639F64E76;
        Fri, 19 Feb 2021 18:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613758692;
        bh=1kw76tUCM5N3cRF8kMsvJxuvxZEFY9o2d9Nv/Wk+OCc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AdYYFfwWDP0+El+ji0XVAO/LHv0udcSkYK4DFCffbebNmh1+8TAiMX/7TMiaXTwIp
         EhGD4Mb3GvP1uYv9csphOTkl8G9hT/omGTSL6sSPa9FWQFKOEpX9bZ4BmXSlPsc7GG
         CoQb3Fwyx3fdn4VX/3MYwetzdQp3/X1o4/EeB5hPCz2Ak7AZnCPfBCxBI3yO1ROEr6
         Z10iRSZzT3WpCwPC5vSjSrbuiojB1Au2BTJQo47rMdb1UHWmCHbppBPnzNUI2HK5pp
         hPXi9nh7ja6L7dsH9VwSSNB6wvkqZ/W1PLcYa8cvjC5RRnkTAaYOH2Qg4WRExsKr2M
         o9hLiJitTHFhg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A3C233520E6A; Fri, 19 Feb 2021 10:18:11 -0800 (PST)
Date:   Fri, 19 Feb 2021 10:18:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-ID: <20210219181811.GY2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
 <20210218151554.GQ2743@paulmck-ThinkPad-P72>
 <20210219081755.eucq4srbam6wg2gm@linutronix.de>
 <20210219104958.GA34308@pc638.lan>
 <20210219105710.d626zexj6vzt6k6y@linutronix.de>
 <20210219111301.GA34441@pc638.lan>
 <20210219111738.go6i2fdzvavpotxd@linutronix.de>
 <20210219112357.GA34462@pc638.lan>
 <20210219112751.GA34528@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219112751.GA34528@pc638.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 19, 2021 at 12:27:51PM +0100, Uladzislau Rezki wrote:
> On Fri, Feb 19, 2021 at 12:23:57PM +0100, Uladzislau Rezki wrote:
> > On Fri, Feb 19, 2021 at 12:17:38PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2021-02-19 12:13:01 [+0100], Uladzislau Rezki wrote:
> > > > I or Paul will ask for a test once it is settled down :) Looks like
> > > > it is, so we should fix for v5.12.
> > > 
> > > Okay. Since Paul asked for powerpc test on v5.11-rc I wanted check if
> > > parts of it are also -stable material.

If Masami's patch works for the PowerPC guys on v5.10-rc7, then it can
be backported.  The patch making RCU Tasks initialize itself early won't
have any effect and can be left or reverted, as we choose.  The self-test
patch will need to be either adjusted or reverted.

However...

The root cause of this problem is that softirq only kind-of works
during a window of time during boot.  It works only if the number and
duration of softirq handlers during this time is small enough, for some
ill-defined notion of "small enough".  If there are too many, whatever
that means exactly, then we get failed attempt to awaken ksoftirqd, which
(sometimes!) results in a silent hang.  Which, as you pointed out earlier,
is a really obnoxious error message.  And any minor change could kick
us into silent-hang state because of the heuristics used to hand off
to ksoftirqd.  The straw that broke the camel's back and all that.

One approach would be to add WARN_ON_ONCE() so that if softirq tries
to awaken ksoftirqd before it is spawned, we get a nice obvious splat.
Unfortunately, this gives false positives because there is code that
needs a softirq handler to run eventually, but is OK with that handler
being delayed until some random point in the early_initcall() sequence.

Besides which, if we are going to add a check, why not use that check
just make things work by forcing handler execution to remain within the
softirq back-of-interrupt context instead of awakening a not-yet-spawned
ksoftirqd?  We can further prevent entry into dyntick-idle state until
the ksoftirqd kthreads have been spawned, which means that if softirq
handlers must be deferred, they will be resumed within one jiffy by the
next scheduler-clock interrupt.

Yes, this can allow softirq handlers to impose large latencies, but only
during early boot, long before any latency-sensitive applications can
possibly have been created.  So this does not seem like a real problem.

Am I missing something here?

							Thanx, Paul

> > OK, i see. It will be broken starting from v5.12-rc unless we fix it.
> > 
> Sorry it is broken since 5.11 kernel already, i messed it up.
> 
> --
> Vlad Rezki
