Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F69C433E0
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 15:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3A964DA1
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 15:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhBQPz3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Feb 2021 10:55:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233568AbhBQPz2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Feb 2021 10:55:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1051861606;
        Wed, 17 Feb 2021 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613577288;
        bh=LCHb5CVtMQ8J9EEAPh+ShcYxz6Oxdc3p8WYDvijhocU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=s3NoIMQx87dKeQLyijTC3gYGg4k4RWD8c1WYm0bjwyyBgg5CQBK8HwsmCrN9CI6qJ
         /1TtlefzrsDN8tHWts+xglsELOUXnbhZzhSdGnin25AO+phpH72qvietdbyK9PMV6n
         M6ugnYQzZNJs9u/caT5yh9dtNvoGmwONOTISxN/FLNmhPYpeukItLMZainfcNgOg73
         N5WbecLVB45en+LqlSWgnbr0m1ss3iUym2Z/Csj1HCmZz2qU80PZ6lg9B3iZp8rvF4
         Myv7vWMSbYu4hAIrJtSoK3+7ndBOjXKFRgS/i/clp++z9tGHhJ+Jpsb31b9BEu2Ua7
         vOYSan1mMwn3A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AD2A03522611; Wed, 17 Feb 2021 07:54:47 -0800 (PST)
Date:   Wed, 17 Feb 2021 07:54:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: Should RCU_BOOST kernels use hrtimers in GP kthread?
Message-ID: <20210217155447.GC2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210216183609.GA7027@paulmck-ThinkPad-P72>
 <20210217153253.fy2mhxo3o3ehsuix@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217153253.fy2mhxo3o3ehsuix@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Feb 17, 2021 at 04:32:53PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-02-16 10:36:09 [-0800], Paul E. McKenney wrote:
> > Hello, Sebastian,
> 
> Hi Paul,
> 
> > I punted on this for the moment by making RCU priority boosting testing
> > depend on CONFIG_PREEMPT_RT, but longer term I am wondering if RCU's
> > various timed delays and timeouts should use hrtimers rather than normal
> > timers in kernels built with CONFIG_RCU_BOOST.  As it is, RCU priority
> > boosting can be defeated if any of the RCU grace-period kthread's timeouts
> > are serviced by the non-realtime ksoftirqd.
> 
> I though boosting is accomplished by acquiring a rt_mutex in a
> rcu_read() section. Do you have some code to point me to, to see how a
> timer is involved here? Or is it the timer saying that *now* boosting is
> needed.

Yes, this last, which is in the grace-period kthread code, for example,
in rcu_gp_fqs_loop().

> If your hrtimer is a "normal" hrtimer then it will be served by
> ksoftirqd, too. You would additionally need one of the
> HRTIMER_MODE_*_HARD to make it work.

Good to know.  Anything I should worry about for this mode?

Also, the current test expects callbacks to be invoked, which involves a
number of additional kthreads and timers, for example, in nocb_gp_wait().
I suppose I could instead look at grace-period sequence numbers, but I
believe that real-life use cases needing RCU priority boosting also need
the callbacks to be invoked reasonably quickly (as in within hundreds
of milliseconds up through very small numbers of seconds).

Thoughts?

							Thanx, Paul

> > This might require things like swait_event_idle_hrtimeout_exclusive(),
> > either as primitives or just open coded.
> > 
> > Thoughts?
> > 
> > 							Thanx, Paul
> 
> Sebastian
