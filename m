Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64310C433EF
	for <rcu@archiver.kernel.org>; Tue,  8 Mar 2022 11:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbiCHLav (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Mar 2022 06:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiCHLau (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Mar 2022 06:30:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9C37A85
        for <rcu@vger.kernel.org>; Tue,  8 Mar 2022 03:29:51 -0800 (PST)
Date:   Tue, 8 Mar 2022 12:29:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646738989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h/qfsgD9ItUtzRa+Ttz7xXBBtbkjfeW+Nt3lD3dPyLo=;
        b=RFnYCHoJK4ii00A69NLQRx+snAiaZMdKsBcuvQREVpxYZB0INclpMhSbmoYCk7mmXHGvfj
        cpuCYO2qQTe5uno2Kt3jo6322p30xvDEX5d12xJJcfi+IPDtB0oXjSTxbdp3u15CKYJ/d4
        nG28BRt7lYt9OdJSqWesxPJOSH7goZ5qJWbgG3dqwPaPSmAeoKTGW9FlhVVajOmfifnnoH
        NZNaCLdG1FWKkPSfg8oIawYEIB9zBHfgFpoqZm73e8W0751On94R9fJY6PYE0f8MJaIp8B
        y5MIBzxgrsEJeXc8N3FytpDMun8Jfx9uuqlHTfiyxBwKUgh2MNHchhvAk2uVUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646738989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h/qfsgD9ItUtzRa+Ttz7xXBBtbkjfeW+Nt3lD3dPyLo=;
        b=X0TLigsChOm+3NxiAbTd2z4Qn3wxPKQmNZIc6fSU4Eof3lDG2lb3KCzjJczKqvgd4+k8E2
        OTeYlZOtH23kkHCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <Yic+K7javne8UY5U@linutronix.de>
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <YiIrtog8fQOExyVl@linutronix.de>
 <20220305050025.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <YiZGwQltzDSzMMDg@linutronix.de>
 <20220307215327.GO4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220307215327.GO4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2022-03-07 13:53:27 [-0800], Paul E. McKenney wrote:
> > Correct, verified. But this means, that a task within a rcu_read_lock()
> > section gets preempted for > 26 seconds before that timer fires. That
> > delay during boot implies that something went wrong while it might
> > happen at run-time under "normal" circumstances. So I wouldn't try to
> > get this case covered.
> 
> The point being that there is no problem with the timer being queued,
> just that it won't go off until later in the boot process.  Which in
> turn means that all that is lost is the RCU CPU stall warning should one
> be needed.  Is that correct, or am I missing a turn in there somewhere?

Correct. Before do_pre_smp_initcalls() there is no ksoftirqd so timers
won't be processed. Therefore even the 26secs timer triggers, there
will be no RCU-stall warning. Also I'm not sure how much of preemption
can happen at this point since there is not much going on.
Any delay at this points to a lockup and at this point the lockup
detector isn't even fully operational (it does not trigger here during
test).

> > > > swait_event_timeout_exclusive() appears innocent.
> > > 
> > > I agree that it would rarely need to block, but if the task executing the
> > > synchronize_rcu() preempted one of the readers, wouldn't it have to block?
> > > Or am I missing some code path that excludes that possibility?
> > 
> > As explained above, it means ~20secs delay during bootup which I don't
> > see happen. Once ksoftirqd is up, it is covered.
> > Also: If _more_ users require a timer to expire so the system can
> > continue to boot I am willing to investigate _why_ this is needed
> > because it does delay boot up progress of the system.
> 
> Just to double-check -- in RT, ksoftirqd is up and running before the boot
> sequence reaches the call to rcu_end_inkernel_boot() from kernel_init()?

Yes, this is the case.
rcu_end_inkernel_boot() is really at the end of the boot process, we
reached even SYSTEM_RUNNING ;)

> This looks good to me, independent of the other discussion.  From what
> I can see, this code path is infrequent, so using hrtimer all the time
> should not be a problem.

Okay.

> Unless there are objections, I will pull this one in.

Good. Less patches for me to carry around.
Thank you.

> 							Thanx, Paul
> 

Sebastian
