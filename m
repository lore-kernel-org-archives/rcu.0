Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF916C4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 17:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLaR1e (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Dec 2022 12:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaR1c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Dec 2022 12:27:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41D92724
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 09:27:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 714FB6092E
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 17:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2A3C433D2;
        Sat, 31 Dec 2022 17:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672507650;
        bh=jbIo1cQEuSYCKDLPv48VhGsQOXbWqgnneLb3CpT1Z7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFic9lAQWZCq5o90fBL65gwIw7I8IOUQ9mdIYXtPR0GbvxWJ828dAJ09C3Rg6p4rJ
         KtIU0oUxR3v5UBeY4InU3LCgIg8/wBlalkxAIVCgBTy80ViX6H/sscqujWFdT/DCie
         0rOV8Rphnz6c8+BiPiCgjXuhODu/a3LqfrDgZzXV35oXG7AiGRoCb5vPfimhL5goHv
         YyBQnCEZaYYV+nQ9BRw0tbHOdYaV0FdZg+SzJNQfKWD74xN+Va8m+7BdKrvhG6X9nr
         GK6OvInj9HOvEcGob2TebAcxvgLjt6QZY4U3y+KKxIEPDqFEfBj1ppQAh0g8QcvdMM
         Ink4TBwq4aglA==
Date:   Sat, 31 Dec 2022 18:27:27 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
Message-ID: <20221231172727.GA205110@lothringen>
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
> 
> Here is a full log with trace dump if you anyone wants to take a look:
> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/console.log
> And the res directory:
> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.0.y/11/artifact/tools/testing/selftests/rcutorture/res/2022.12.30-22.57.13/TREE07.2/
> 
> Any thoughts on any patches 6.0 might be missing?

I can't reproduce it in v6.0 (vanilla not stable) after 100 runs of 5 minutes,
so may be it's actually some patches too many instead :-)

> 
> Meanwhile, debug here continues... thanks,
> 
>  - Joel
