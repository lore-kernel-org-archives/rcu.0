Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA06C433E0
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 10:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021B664DEC
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 10:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhBVKGe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Feb 2021 05:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhBVKEo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Feb 2021 05:04:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24877C061786;
        Mon, 22 Feb 2021 02:04:04 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:04:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613988242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9DqdmMcC65JlDNxGXXaK9p0hPgxRE+lfHdTeie7Ho38=;
        b=waEtf0JWXpDUj2FuRUPGflgm6U4yDZLlHUqu5vOXgIlfe0FFDuvPgq7/WsTb+nPCbxyMNJ
        UURcpSCUA4d+QEXP6FAqttoh0lBG+uG1Q+EYu4RhphOZ4MsbjBdyDmD9QT21T45K/81YJa
        DPklD83qKnc0yT76zrFXM7pSLgjStKFkiFpOL5LUuMJKmnzy2cwnrhOYZ9mgP8i5UVJ+0z
        WJwUZiDrJZU9FZ3ympmgc8flJcDVxDDnxI9mBbUll8jg2hqDU1Ceoph+VDhWyGhEMQq/h6
        NOZg8soUO+tALZDOhW6quZ/q1FxxqmB1GLuq2u4qX+tN5waxpv/pxsImWpBSqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613988242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9DqdmMcC65JlDNxGXXaK9p0hPgxRE+lfHdTeie7Ho38=;
        b=/HsCFiui1OcDMIsfQNQXTi+Bid3xTVk4Adltdh5wQV/IDNKY7SiQKu701hRFB48T61HzSz
        kGhqULt7L66bXFBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20210222100400.xzdq7iciw5f4zzlv@linutronix.de>
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
 <20210218151554.GQ2743@paulmck-ThinkPad-P72>
 <20210219081755.eucq4srbam6wg2gm@linutronix.de>
 <20210219104958.GA34308@pc638.lan>
 <20210219105710.d626zexj6vzt6k6y@linutronix.de>
 <20210219111301.GA34441@pc638.lan>
 <20210219111738.go6i2fdzvavpotxd@linutronix.de>
 <20210219112357.GA34462@pc638.lan>
 <20210219112751.GA34528@pc638.lan>
 <20210219181811.GY2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219181811.GY2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2021-02-19 10:18:11 [-0800], Paul E. McKenney wrote:
> If Masami's patch works for the PowerPC guys on v5.10-rc7, then it can
> be backported.  The patch making RCU Tasks initialize itself early won't
> have any effect and can be left or reverted, as we choose.  The self-test
> patch will need to be either adjusted or reverted.
> 
> However...
> 
> The root cause of this problem is that softirq only kind-of works
> during a window of time during boot.  It works only if the number and
> duration of softirq handlers during this time is small enough, for some
> ill-defined notion of "small enough".  If there are too many, whatever
> that means exactly, then we get failed attempt to awaken ksoftirqd, which

The number of registered softirq handlers does not matter nor the amount
times the individual softirqs that were scheduled. The only problem is
that one schedules softirq and then waits for its completion.
So scheduling a timer_list timer works. Waiting for its completion does
not. Once ksoftirqd is up, will be processed.

> (sometimes!) results in a silent hang.  Which, as you pointed out earlier,
> is a really obnoxious error message.  And any minor change could kick
> us into silent-hang state because of the heuristics used to hand off
> to ksoftirqd.  The straw that broke the camel's back and all that.

The problem is that a softirq is raised and being waited for its
completion.
Something like synchronize_rcu() would be such a thing I guess.

> One approach would be to add WARN_ON_ONCE() so that if softirq tries
> to awaken ksoftirqd before it is spawned, we get a nice obvious splat.
> Unfortunately, this gives false positives because there is code that
> needs a softirq handler to run eventually, but is OK with that handler
> being delayed until some random point in the early_initcall() sequence.
> 
> Besides which, if we are going to add a check, why not use that check
> just make things work by forcing handler execution to remain within the
> softirq back-of-interrupt context instead of awakening a not-yet-spawned
> ksoftirqd?  We can further prevent entry into dyntick-idle state until
> the ksoftirqd kthreads have been spawned, which means that if softirq
> handlers must be deferred, they will be resumed within one jiffy by the
> next scheduler-clock interrupt.

This should work.

> Yes, this can allow softirq handlers to impose large latencies, but only
> during early boot, long before any latency-sensitive applications can
> possibly have been created.  So this does not seem like a real problem.
> 
> Am I missing something here?
> 
> 							Thanx, Paul

Sebastian
