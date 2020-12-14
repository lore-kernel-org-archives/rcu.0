Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB88AC4361B
	for <rcu@archiver.kernel.org>; Mon, 14 Dec 2020 19:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CEC22525
	for <rcu@archiver.kernel.org>; Mon, 14 Dec 2020 19:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441042AbgLNTDG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Dec 2020 14:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441019AbgLNTDA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Dec 2020 14:03:00 -0500
Date:   Mon, 14 Dec 2020 11:02:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607972539;
        bh=3vxRK7BkGCr6xGdIg+aAYOoJ/Nd1GT8tpIgUbOyLYck=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VPJ0itmvJKEGf2gGmUZmf03Nl8eGYwFqcK9lGzuBe7WS5SRijsM5GKZVn2KXw5bxb
         qzjMbKfUam8QfLp/pQDd0+WEcGVKxskadhnKGyCnXEY47zsYHCYaVRPmkqBUa8fVJX
         VLlyV/XkPqjF7O0tgTpb9s8l+EMCW/STxW7eFmIbrxb4RLc1VMd05sVAdb7myGb4R+
         iN+HsqXcwoWXk4TRP5uCrBwYNZGu3HWnK+EgzxHWRLP3dgfXHM6PJZ+n9I10MwxRQl
         brV0+vE9lfwEb/4F2gF/fXkZ/F7lkrV7JF/I2ziWX1dXrch09m8fs8iGwSUdfkhAvn
         qYpFjpYaT+jxQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Energy-efficiency options within RCU
Message-ID: <20201214190219.GV2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201210183737.GA12900@paulmck-ThinkPad-P72>
 <X9erIC8Sbf3ybvHC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9erIC8Sbf3ybvHC@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Dec 14, 2020 at 01:12:48PM -0500, Joel Fernandes wrote:
> On Thu, Dec 10, 2020 at 10:37:37AM -0800, Paul E. McKenney wrote:
> > Hello, Joel,
> > 
> > In case you are -seriously- interested...  ;-)
> 
> I am always seriously interested :-). The issue becomes when life throws me a
> curveball. This was the year of curveballs :-)
> 
> Thank you for your reply and I have added it to my list to investigate how we
> are configuring nocb on our systems. I don't think anyone over here has given
> these RCU issues a serious look over here.

In your defense, I would guess that many of them don't have that much
effect.  But true, you never know until you try.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> 
> > 						Thanx, Paul
> > 
> > rcu_nocbs=
> > 
> > 	Adding a CPU to this list offloads RCU callback invocation from
> > 	that CPU's softirq handler to a kthread.  In big.LITTLE systems,
> > 	this kthread can be placed on a LITTLE CPU, which has been
> > 	demonstrated to save significant energy in benchmarks.
> > 	http://www.rdrop.com/users/paulmck/realtime/paper/AMPenergy.2013.04.19a.pdf
> > 
> > nohz_full=
> > 
> > 	Any CPU specified by this boot parameter is handled as if it was
> > 	specified by rcu_nocbs=.
> > 
> > rcutree.jiffies_till_first_fqs=
> > 
> > 	Increasing this will decrease wakeup frequency to the grace-period
> > 	kthread for the first FQS scan.  And increase grace-period
> > 	latency.
> > 
> > rcutree.jiffies_till_next_fqs=
> > 
> > 	Ditto, but for the second and subsequent FQS scans.
> > 
> > 	My guess is that neither of these makes much difference.  But if
> > 	they do, maybe some sort of backoff scheme for FQS scans?
> > 
> > rcutree.jiffies_till_sched_qs=
> > 
> > 	Increasing this will delay RCU's getting excited about CPUs and
> > 	tasks not responding with quiescent states.  This excitement
> > 	can cause extra overhead.
> > 
> > 	No idea whether adjusting this would help.  But if you increase
> > 	rcutree.jiffies_till_first_fqs or rcutree.jiffies_till_next_fqs,
> > 	you might need to increase this one accordingly.
> > 
> > rcutree.qovld=
> > 
> > 	Increasing this will increase the grace-period duration at which
> > 	RCU starts sending IPIs, thus perhaps reducing the total number
> > 	of IPIs that RCU sends.  The destination CPUs are unlikely to be
> > 	idle, so it is not clear to me that this would help much.  But
> > 	perhaps I am wrong about them being mostly non-idle, who knows?
> > 
> > rcupdate.rcu_cpu_stall_timeout=
> > 
> > 	If you get overly zealous about the earlier kernel boot parameters,
> > 	you might need to increase this one as well.  Or instead use the
> > 	rcupdate.rcu_cpu_stall_suppress= kernel boot parameter to suppress
> > 	RCU CPU stall warnings entirely.
> > 
> > rcutree.rcu_nocb_gp_stride=
> > 
> > 	Increasing this might reduce grace-period work somewhat.  I don't
> > 	see why a (say) 16-CPU system really needs to have more than one
> > 	rcuog kthread, so if this does help it might be worthwhile setting
> > 	a lower limit to this kernel parameter.
> > 
> > rcutree.rcu_idle_gp_delay=  (Only CONFIG_RCU_FAST_NO_HZ=y kernels.)
> > 
> > 	This defaults to four jiffies on the theory that grace periods
> > 	tend to last about that long.  If grace periods tend to take
> > 	longer, then it makes a lot of sense to increase this.	And maybe
> > 	battery-powered devices would rather have it be about 2x or 3x
> > 	the expected grace-period duration, who knows?
> > 
> > 	I would keep it to a power of two, but the code should work with
> > 	other numbers.  Except that I don't know that this has ever been
> > 	tested.  ;-)
> > 
> > srcutree.exp_holdoff=
> > 
> > 	Increasing this decreases the number of SRCU grace periods that
> > 	are treated as expedited.  But you have to have closely-spaced
> > 	SRCU grace periods for this to matter.	(These do happen at least
> > 	sometimes because I added this only because someone complained
> > 	about the performance regression from the earlier non-tree SRCU.)
> > 
> > rcupdate.rcu_task_ipi_delay=
> > 
> > 	This kernel parameter delays sending IPIs for RCU Tasks Trace,
> > 	which is used by sleepable BPF programs.  Increasing it can
> > 	reduce overhead, but can also increase the latency of removing
> > 	sleepable BPF programs.
> > 
> > rcupdate.rcu_task_stall_timeout=
> > 
> > 	If you slow down RCU Tasks Trace too much, you may need this.
> > 	But then again, the default 10-minute value should suffice.
> > 
> > CONFIG_RCU_FAST_NO_HZ=y
> > 
> > 	This only has effect on CPUs not specified by rcu_nocbs, and thus
> > 	might be useful on systems that offload RCU callbacks only on
> > 	some of the CPUs.  For example, a big.LITTLE system might offload
> > 	only the big CPUs.  This Kconfig option reduces the frequency of
> > 	timer interrupts (and thus of RCU-related softirq processing)
> > 	on idle CPUs.  This has been shown to save significant energy
> > 	in benchmarks:
> > 	http://www.rdrop.com/users/paulmck/realtime/paper/AMPenergy.2013.04.19a.pdf
> > 
> > CONFIG_RCU_STRICT_GRACE_PERIOD=y
> > 
> > 	This works hard (as in burns CPU) to sharply reduce grace-period
> > 	latency.  The effect is probably to greatly increase power
> > 	consumption, but there might well be workloads where the shorter
> > 	grace periods more than make up for the extra CPU time.  Or not.
> > 
> > CONFIG_HZ=
> > 
> > 	Reducing the scheduler-clock interrupt frequency has the opposite
> > 	effect, namely of increasing RCU grace-period latency, but while
> > 	also reducing RCU's CPU utilization.
> > 
> > CONFIG_TASKS_TRACE_RCU_READ_MB=y
> > 
> > 	Reduce the need to IPI RCU Tasks Trace holdout tasks, but at the
> > 	expense of an increase in to/from idle overhead.  This Kconfig
> > 	option also slows down the rate at which RCU Tasks Trace polls
> > 	for holdout tasks.  This polling rate cannot be separately
> > 	specified, but if changing the initial source-code values of
> > 	either rcu_tasks_trace.gp_sleep or rcu_tasks_trace.init_fract
> > 	proves useful, kernel boot parameters could be created.
> > 
> > 	That said, automatic initialization heuristics are more
> > 	convenient.  When they work, anyway.
