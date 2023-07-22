Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695DBC001B0
	for <rcu@archiver.kernel.org>; Sat, 22 Jul 2023 22:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjGVWjr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 22 Jul 2023 18:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVWjq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 22 Jul 2023 18:39:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691B210DC;
        Sat, 22 Jul 2023 15:39:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2DB960BDC;
        Sat, 22 Jul 2023 22:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409D2C433C9;
        Sat, 22 Jul 2023 22:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690065583;
        bh=5PNN8we9ZXbyJX4vwmKQL4+M0AeqQiN+w4Vj/oDaEuc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eS8E/DqEQGMKSymzT02ie4/03Y4vRvf/GMAYK+Lkyw9KHlklDB8b0xUuHHLdQMSuD
         5VRf3J5SHSqAMsqoPeBtWnuNZNgSxYsz+pj7FV5+pxiABsv+J8MV1mlhAFc/OVK8Ao
         NGoPI6Sl+ne3iOKeAx2cqRt4/bRXOrT0igEc1jDnSyAMTY8Hoq2eDd27k6RZeyB6Gx
         JlBdjRmO3rDcmeJd6HSUpfsHzl26WjQTvpW2nLNoBzE9DCMFK+4SybWPBrGZ44VvE3
         YAXTz+IgOrvsDOq1F4k/Ii/yols8Cj3V4I99iyK2qr1RXTbrYUL2S+yDTyOhZFJK0s
         pMx9D7xuxKdhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B7503CE0908; Sat, 22 Jul 2023 15:39:42 -0700 (PDT)
Date:   Sat, 22 Jul 2023 15:39:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, osh@joshtriplett.org, boqun.feng@gmail.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: remove unnecessary check cpu_no_qs.norm on
 rcu_report_qs_rdp
Message-ID: <31070aab-8665-44c4-8950-0631a777ef44@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230721121534.44328-1-ppbuk5246@gmail.com>
 <05e98227-77f4-4918-8f8e-2170a158e350@paulmck-laptop>
 <CAM7-yPRc4Z0siaiWf+fK2GEfjPMq5UaY13F4o19rU6NNUS5fNg@mail.gmail.com>
 <faf07eef-0a51-49f3-be48-0433952171ad@paulmck-laptop>
 <CAM7-yPTrHN1xPXWjSUrJeTEOuy78DpmL8ytUY+a4ZOekiAbnZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPTrHN1xPXWjSUrJeTEOuy78DpmL8ytUY+a4ZOekiAbnZg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jul 22, 2023 at 09:14:28PM +0100, Yun Levi wrote:
> Hi Paul.
> 
> > Suppose that the scheduler-clock interrupt invoking rcu_sched_clock_irq()
> > happened just before the lock was acquired in rcu_report_qs_rdp().
> > Suppose further that the RCU grace-period kthread started a new grace
> > period just before that interrupt occurred.  Then mightn't that interrupt
> > notice the new grace period and set ->cpu_no_qs.b.norm to true before
> > fully returning?
> 
> IIUC, RCU grace-period kthread couldn't start new grace period
> because the interrupted cpu don't report qs to rnp  via rcu_report_qs_rdp.
> That situation is listened like new gp could be started thou all cpus
> doesn't enter yet.
> That's is the reason why it's better to use WARN_ON_ONCE as you suggest
> to notice if the buggy situation happens

And try testing with CONFIG_RCU_STRICT_GRACE_PERIOD=y and CONFIG_PREEMPT=n.
Though there might be better Kconfig options to use.  Those two come
immediately to mind.

> Am I missing something or wrong?

I cannot see into your head, so I cannot say.

But one critical piece is that softirq handlers, including the RCU_SOFTIRQ
handler rcu_core_si(), can be invoked upon return from interrupts.
Another critical piece is that if a CPU is idle during any part of a
grace period, the grace-period kthread can report a quiescent state on
its behalf.

Does that help?

							Thanx, Paul
