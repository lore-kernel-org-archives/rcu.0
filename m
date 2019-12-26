Return-Path: <SRS0=bpia=2Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DB1C2D0C8
	for <rcu@archiver.kernel.org>; Thu, 26 Dec 2019 01:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509222075E
	for <rcu@archiver.kernel.org>; Thu, 26 Dec 2019 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577322334;
	bh=R7Kt1L0p4nuhCOyPoUTcGP/mw8sfcBaj1RLwSrMx58s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=u/Y0/G/kw28RJX7S8QO/2EE+4zKkW9mDL/tgvm/YEnybC1FPve/DoGNQkQbubTXOd
	 EC+idqQTvJ4Lf89qu/cFkvsSxYOycMXZ6LiUh2nacRiW5pbSuQOB1iw3R2ZPd2PILj
	 IMAZvnYGw5PzDDwoMFrelvJbtvXn1TxMGAlXCZ8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLZBFe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Dec 2019 20:05:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfLZBFd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Dec 2019 20:05:33 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 852942075B;
        Thu, 26 Dec 2019 01:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577322332;
        bh=R7Kt1L0p4nuhCOyPoUTcGP/mw8sfcBaj1RLwSrMx58s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OjgjkV635Bc6CNpzLoIOUWbqRGBWGPIrlzHxq9XCUg8EO86BkrK28VFJPaUwM2tND
         kEM+/USabx5ghGD5GNn+tgm1GAHEyHDp82bAdyPmaS2rzGb3UBXVMk3/+Y0C1Eocjz
         u3rp84c4Dj4voauE8Vd7RM2lRMR/2tW1AIGrxfxI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 545353522744; Wed, 25 Dec 2019 17:05:32 -0800 (PST)
Date:   Wed, 25 Dec 2019 17:05:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: RCU ideas discussed at LPC
Message-ID: <20191226010532.GP13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAEXW_YTyxm7QZwFV7KYpN2Sds=SDYqOvZ4+qfWL1_Kwx48Dusg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTyxm7QZwFV7KYpN2Sds=SDYqOvZ4+qfWL1_Kwx48Dusg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 25, 2019 at 05:41:04PM -0500, Joel Fernandes wrote:
> Hi Paul,
> We were discussing some ideas on facebook so I wanted to just post
> them here as well. This is in the context of the RCU section of RT MC
> https://www.youtube.com/watch?v=bpyFQJV5gCI
> 
> Detecting high kfree_rcu() load
> ----------
> You mentioned about this. As I understand it, we did the kfree_rcu()
> batching to let the system not do anything RCU related until a batch
> has filled up enough or a timeout has occurred. This makes the GP
> thread and the system do less work.
> The problem you are raising in our facebook thread is, that during
> heavy load the "batch" can be large and be dumped into call_rcu()
> eventually. Wouldn't this be better handled generically within
> call_rcu() itself, for the benefit of other non-kfree_rcu workloads?
> That is if a large number of callbacks is dumped, then try to end the
> GP more quickly. This likely doesn't need a signal from kfree_rcu()
> since call_rcu() knows that it is being hammered.

Except that call_rcu() currently has no idea how many parcels of memory
a given request from kfree_rcu() represents.

> Detecting recursive call_rcu() within call_rcu()
> ---------
> We could use a per-cpu variable to detect a scenario like this, though
> I am not sure if preemption during call_rcu() itself would cause false
> positives.

A call_rcu() from within an RCU callback function is legal and is
sometimes done.  Or are you thinking of a call_rcu() from an interrupt
handler interrupting another call_rcu()?

> All rcuogp and rcuop threads tied to a house keeping CPU
> ---
> In LPC you mentioned about the problem of OOM if all rcuo* threads
> including the GP one are not able to keep up with heavy load. On
> Facebook I had proposed something like this: What about making the
> affinity setting to be a "soft affinity", that is respect it always
> expect in the uncommon case. In the uncommon case of heavy load, let
> the threads run wherever to prevent OOM. Sure that might make the
> system a little more disruptive, but if we are approaching OOM we have
> bigger problems right?

The problem is that there are a rather large number of ways to force
a given kthread to execute only on a given CPU, and reverse-engineering
all that within call_rcu() isn't reasonable.  An alternative is to
disable offloading, wait for the offloaded callbacks to drain, then
start up the usual softirq approach (or per-CPU kthread, as the case
may be).  This self-throttles because whatever is generating callbacks
gets preempted by softirq invocation.

Give or take real-time priority settings, but beyond a certain point
I start quoting Peter Parker's uncle.

> Peter mentioned about rcuogp0 should have slightly higher prio than rcuop0

Assuming no strange cases with extremely short grace periods, agreed.

> ---------
> You mentioned this is something to look into but not sure if we looked
> into it yet.
> 
> A "heavy" call_rcu() caller using synchronize_rcu() if too many
> callbacks are dumped

This is actually done in some parts of the kernel, though I would
be happier with rcu_barrier() at least some of the time, either
in addition to or in place of synchronize_rcu().  (In fairness,
some of the use cases pre-date rcu_barrier().)

> ---------
> How about doing this kind of call_rcu() to synchronize_rcu()
> transition automatically if the context allows it? I.e. Detect the
> context and if sleeping is allowed, then wait for the grace period
> synchronously in call_rcu(). Not sure about deadlocks and the like
> from this kind of waiting and have to think more.

This gets rather strange in a production PREEMPT=n build, so not a
fan, actually.  And in real-time systems, I pretty much have to splat
anyway if I slow down call_rcu() by that much.

So the preference is instead detecting such misconfiguration and issuing
appropriate diagnostics.  And making RCU more able to keep up when not
grossly misconfigured, hence the kfree_rcu() memory footprint being
fed into core RCU.

> is square root of N number of rcuogp0 threads - the right optimization?

If there were enough CPUs, it would be necessary to have three levels
of hierarchy and to go to the cube root, but that would be more CPUs
than I have seen used.

> ---------
> The question raised was can we do with fewer threads, or even just
> one? You mentioned the square root might not be the right choice. How
> do we test how well the system is doing. Are you running rcutorture
> with a certain tree configuration and monitor memory footprint /
> performance?

The issue prompting the hierarcy was wakeup overhead on the grace-period
kthread.  Going to a hierarchy reduced the load on that single thread
(which could otherwise become a bottleneck on large systems, and also
reduced the absolute number of wakeups by up to almost a factor of two.
Deepening the hierarchy would further reduce the wakeup load on the
grace-period kthread, but would increase the total number of wakeups.

So this is not a matter of tweaks and optimizations.  I would need to
see some horrible problem with the current setup to even consider
making a change.

> BTW, I have 2 interns working on RCU (Amol and Madupharna also on CC).
> They were selected among several others as a part of the
> LinuxFoundation mentorship program. They are familiar with RCU. I have
> asked them to look at some RCU-list work and RCU sparse work. However,
> I can also have them look into a few other things as time permits and
> depending on what interests them.

Dog paddling before cliff diving, please!  ;-)

> Thanks, Merry Christmas!

And to you and yours as well!

							Thanx, Paul
