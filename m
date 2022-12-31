Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006A2C4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 02:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiLaCOQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Dec 2022 21:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiLaCOP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Dec 2022 21:14:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532711C900
        for <rcu@vger.kernel.org>; Fri, 30 Dec 2022 18:14:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AC4C0CE19FF
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 02:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22DAC433EF;
        Sat, 31 Dec 2022 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672452851;
        bh=HNEEf6d/3BrHj+HTtTUE343jOwHIXmfI4Tj6Z6PFX9U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p2BuMGQ6H7YphL2aJv7Al7OlxNaNX/r3Rwv4AapKgl7Yc2AeYV3vQVSEkw3WYR89C
         JPX3VElOvnRVjQdQ0voREPeKAu/DqMNj9fwmL/U9M2DT1RaRk0Cr5UxlCOI/Oj9ep1
         rfCx80brIHc9LdXOpFpAo9luc55Re5yv3Kjp2UohLVbojJv72zmXz7UZjG1dVyRE7+
         D3EsNGE0j26n1M1qzYycktsfDvPSLGclGMq3nFA7SJVvRCMiQBGDTj3vurh/zRL58c
         o0548TQdLC/2Wq6MjzT8WV0IG5cLQsBjoWT0UOvcIS2wqoaNpHbydVcRhvTRt1YvQ0
         unyeBf89xGwyw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9D26D5C097E; Fri, 30 Dec 2022 18:14:10 -0800 (PST)
Date:   Fri, 30 Dec 2022 18:14:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
Message-ID: <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 30, 2022 at 08:42:24PM -0500, Joel Fernandes wrote:
> Hello,
> 
> I have been firefighting a hang on 6.0.y stable kernels with
> rcutorture. It happens mostly consistently when TREE07 is shutting
> down.
> 
> It appears that the RCU torture threads are attempted to stop but the
> shutdown thread, but are constantly awakened by a timer softirq
> handler in ksoftirqd context. When they wake up, they immediately goto
> sleep in uninterruptible state until the next time a timer handler
> wakes them up. It appears the timer softirq is long enough to cause
> RCU stalls and I see it calling 100s of timer function handlers
> (call_timer_fn).
> 
> I am doing some more investigation with trace_printk(s):
> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=stable/trace-hang-6.0.y&id=b779b1e92c97f29333a282ee8f548da02f64de2b
> 
> Regarding the timer handlers, I was wondering if it is possible that a
> large number of timer handlers constantly queued can cause RCU stalls
> due to the timer softirq taking a very long time. That certainly
> appears to be the case here. Shouldn't the timer softirq also do
> rcu_softirq_qs() similar to the ksoftirq loop, in case there are too
> many of them?

That is certainly a good thing to try!

> Here is a full log with trace dump if you anyone wants to take a look:
> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/console.log
> And the res directory:
> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/
> 
> Any thoughts on any patches 6.0 might be missing?

This doesn't happen on current mainline?

(It doesn't for me, but then again, it didn't on v6.0, either.)

> Meanwhile, debug here continues... thanks,

							Thanx, Paul
