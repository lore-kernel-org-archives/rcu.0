Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCA5C001DE
	for <rcu@archiver.kernel.org>; Sun, 23 Jul 2023 17:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjGWRYw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 23 Jul 2023 13:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGWRYv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 23 Jul 2023 13:24:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E983124;
        Sun, 23 Jul 2023 10:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EF2A60DE6;
        Sun, 23 Jul 2023 17:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58782C433C8;
        Sun, 23 Jul 2023 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690133089;
        bh=NcUAOb9a14qpp5qEFch5ZQfeJp4e03nXK0pnPHmx9VA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UFtEdHZfS+1JR8wtzVslMiqBF6TMicuNOzX7kq/EP2MgIxE1NCgJbLAk6g2iszya3
         /kVK6AP4OITFenUrUkRNx5WuFc2zhtkyK5SQVaEIlTE9cqqyLnhJw0Xywq05ZQX70w
         Xidp9+eKja9kY5OWKXzWmZPqSIliob1Jjq6CnuNYVrMJBEqd0HpS7lzUG6qUIFTQhm
         Ppvp7I9G6rCAQuglnrLzWjZyRXzjFkHrDrVo1zCq1LVPXjPnU+uDwjnuV6B9CtJydN
         qyX8bmKl5/0Q5irqXUGr03hjlRddrNrJWwL8QQTKcyN8fR3CPCOTIyP/LPsyB5N0Yx
         uOq7dvm/3Oyrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EF599CE0304; Sun, 23 Jul 2023 10:24:48 -0700 (PDT)
Date:   Sun, 23 Jul 2023 10:24:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, osh@joshtriplett.org, boqun.feng@gmail.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: remove unnecessary check cpu_no_qs.norm on
 rcu_report_qs_rdp
Message-ID: <11f70a6f-18da-4ab2-b2e8-68845c1b40f9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230721121534.44328-1-ppbuk5246@gmail.com>
 <05e98227-77f4-4918-8f8e-2170a158e350@paulmck-laptop>
 <CAM7-yPRc4Z0siaiWf+fK2GEfjPMq5UaY13F4o19rU6NNUS5fNg@mail.gmail.com>
 <faf07eef-0a51-49f3-be48-0433952171ad@paulmck-laptop>
 <CAM7-yPTrHN1xPXWjSUrJeTEOuy78DpmL8ytUY+a4ZOekiAbnZg@mail.gmail.com>
 <31070aab-8665-44c4-8950-0631a777ef44@paulmck-laptop>
 <CAM7-yPSn8ietAJ8NKb0-VHDQhkHs73u--KFmO3rpTPUvcFuMvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPSn8ietAJ8NKb0-VHDQhkHs73u--KFmO3rpTPUvcFuMvA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jul 23, 2023 at 07:23:00AM +0100, Yun Levi wrote:
> Thanks for replying to reply Paul :)
> 
> > And try testing with CONFIG_RCU_STRICT_GRACE_PERIOD=y and CONFIG_PREEMPT=n.
> > Though there might be better Kconfig options to use.  Those two come
> > immediately to mind.
> 
> I've tested with this option via rcu torture.
> and it doesn't report any problems.
> and after commit 6d60ea03ac2d3 ("rcu: Report QS for outermost
> PREEMPT=n rcu_read_unlock() for strict GPs")
> it always makes cpu_no_qs.b.norm false whenever it calls
> rcu_report_qs_rdp in rcu_read_unlock.

Again, the concern is that an interrupt and softirq handler at that
point changes the grace period.  What else could you do to check that
this sequence of events actually occurred?  That is, that your testing
didn't just get lucky and not actually hit this condition?

Interrupts are enabled at that point, so there is nothing that prevents
that condition, after all.

> > But one critical piece is that softirq handlers, including the RCU_SOFTIRQ
> > handler rcu_core_si(), can be invoked upon return from interrupts.
> 
> I think in that case, no problem because if it reports qs already,
> rcu_check_quiescent_state wouldn't call rcu_report_qs_rdp again.
> And if RCU_SOFTIRQ is called as soon as RCU interrupt is finished,
> it seems the fastest one to notify qs to related tree.
> 
> > Another critical piece is that if a CPU is idle during any part of a
> > grace period, the grace-period kthread can report a quiescent state on
> > its behalf.
> 
> I think
>     1) If timer interrupt is still programed,
>           - when rcu_sched_clock_irq first reports qs, no problem
>           - If qs is reported via grace period thread first,
> note_gp_chagned in rcu interrupt
>             will recognize this situation by setting core_needs_qs as false,
>             it doesn't call rcu_report_qs_rdp thou cpu_no_qs.b.norm is true.
> 
>      2) If the timer interrupt isn't programmed,
>           - rcu_gp_kthreaad reports its qs, no problem.
> 
> So, I think there's no problem removing
>       "rdp->cpu_no_qs.b.norm" check in rcu_report_qs_rdp.
> or wrap this condition check as WARN_ON_ONCE.

One additional concern is that a quiescent state detected in an old
grace period will be incorrectly reported for a new grace period.

							Thanx, Paul

> > Does that help?
> Many thanks always :)
> 
> --------
> SIncerely,
> Levi.
