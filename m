Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF456C433F5
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 12:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74D061354
	for <rcu@archiver.kernel.org>; Mon,  4 Oct 2021 12:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhJDMnd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 Oct 2021 08:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhJDMnc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 4 Oct 2021 08:43:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EF906124C;
        Mon,  4 Oct 2021 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633351303;
        bh=JefH+xuB/XiNG/HUrhn62tZnfeWCj3Rpehje4Cw3ico=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=idWFkCK/FKj918ITXPNEkBQnpFKm8qs6VC6n7TqNWORZD6pO+t2wc2kFGFcYbzy4E
         JPYitjc/JaGc+BBWZRrHWcq68ELguWAXcGw9EXTZ6bvUtEFf3LdyqEKZ1f0alzcmq+
         ODbQKdMGSxINxd9IVOui2FeaDGf1qcXgxal7KpnkK5NluAUPQ5OKo8VczOaRegb5OC
         sMSEH1bwIln4PlM4IGaqgTEjRP6kFTugwVb4fsRBdrxXNgnwJ3DN2Wx9CWQdc2CIgc
         2D+Zlfj+EwmhSJOIrS+NYwm8arDYXOlhrmvg5vWoBUKsSNjnw8BtDdMJ2BRTxAYVZ8
         AJr34dXmd3eEg==
Date:   Mon, 4 Oct 2021 14:41:41 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 03/11] rcu/nocb: Invoke rcu_core() at the start of
 deoffloading
Message-ID: <20211004124141.GA272717@lothringen>
References: <20210929221012.228270-1-frederic@kernel.org>
 <20210929221012.228270-4-frederic@kernel.org>
 <87czoomy7n.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czoomy7n.mognet@arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 01, 2021 at 06:50:04PM +0100, Valentin Schneider wrote:
> On 30/09/21 00:10, Frederic Weisbecker wrote:
> > On PREEMPT_RT, if rcu_core() is preempted by the de-offloading process,
> > some work, such as callbacks acceleration and invocation, may be left
> > unattended due to the volatile checks on the offloaded state.
> >
> > In the worst case this work is postponed until the next rcu_pending()
> > check that can take a jiffy to reach, which can be a problem in case
> > of callbacks flooding.
> >
> > Solve that with invoking rcu_core() early in the de-offloading process.
> > This way any work dismissed by an ongoing rcu_core() call fooled by
> > a preempting deoffloading process will be caught up by a nearby future
> > recall to rcu_core(), this time fully aware of the de-offloading state.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > Cc: Uladzislau Rezki <urezki@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> One comment/question below.
> 
> > @@ -990,6 +990,15 @@ static long rcu_nocb_rdp_deoffload(void *arg)
> >        * will refuse to put anything into the bypass.
> >        */
> >       WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> > +	/*
> > +	 * Start with invoking rcu_core() early. This way if the current thread
> > +	 * happens to preempt an ongoing call to rcu_core() in the middle,
> > +	 * leaving some work dismissed because rcu_core() still thinks the rdp is
> > +	 * completely offloaded, we are guaranteed a nearby future instance of
> > +	 * rcu_core() to catch up.
> > +	 */
> > +	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
> > +	invoke_rcu_core();
> 
> I think your approach is a bit neater, but would there have been any issue
> with keeping the setting of SEGCBLIST_RCU_CORE within
> rcu_segcblist_offload() and bundling it with an invoke_rcu_core()?

Probably not in practice.

But in theory, it may be more comfortable to read the following in order:

1) Set SEGCBLIST_RCU_CORE so subsequent invocations of rcu_core() handle
callbacks

2) Invoke rcu_core()

3) Only once we achieved the above we can clear SEGCBLIST_OFFLOADED which
will stop the nocb kthreads.

If we did 3) first and only then 1) and 2), there would be a risk that callbacks
get completely ignored in the middle.

That said you have a point in that we could do:

1) Set SEGCBLIST_RCU_CORE and clear SEGCBLIST_OFFLOADED at the _very_ same time
(arrange that with a WRITE_ONCE() I guess).

2) Invoke rcu_core()

But well...arranging for rcu_core() to take over before we even consider
starting the de-offloading process provides some unexplainable relief to the
soul. Some code design sometimes rely more on faith than logic :)

Thanks.
