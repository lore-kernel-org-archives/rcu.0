Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F392C433FE
	for <rcu@archiver.kernel.org>; Wed,  5 Oct 2022 13:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJENB2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 5 Oct 2022 09:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJENBZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 5 Oct 2022 09:01:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB9A786F7
        for <rcu@vger.kernel.org>; Wed,  5 Oct 2022 06:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2B8DB81E05
        for <rcu@vger.kernel.org>; Wed,  5 Oct 2022 13:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95834C433D6;
        Wed,  5 Oct 2022 13:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664974878;
        bh=Q3mPmFVpNe0V4z6zc0Jq1Tr8Jp9E48yIQSC6NCYTGEA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fZ2+t1+YUvP16U1XAOURdyKSAYJNqmVAff3vC+TeEZSFN4PUr5sP5DQK73OS4yfOS
         L6kvCtKO1T0OIZH0Y2xgYpaNLj9BOvuLPO7Hg7F35T3Io9sKIaSn6QtuYJCVK3eIB1
         pTWBzJjVFIKrApXAq4dZobk5mtyQQNTAwU1P32pYAKE8nXuULTCEo3DhqgRrqUEsGq
         5sdcpu0ZUViybUbAhdlV6LP+e8ryU/GwJWKiRnrOsXcOlxa5bazRYvfmtf61p9AxSY
         7yG2WWl34j+1FgFbSw93kwrqzo1U63c3Z05iL1Yi+JaFg+5FqvoRkyR891+t6gB9Vv
         jy9x5WYFcn0jg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 38EA95C0F66; Wed,  5 Oct 2022 06:01:18 -0700 (PDT)
Date:   Wed, 5 Oct 2022 06:01:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     5486 <3164135486@qq.com>
Cc:     rcu@vger.kernel.org
Subject: Re: Dear Pualmack help i have a problem with rcu code
Message-ID: <20221005130118.GM4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <tencent_2AEC5BC7675ED8D5CEEA58620CC232C0A305@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2AEC5BC7675ED8D5CEEA58620CC232C0A305@qq.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 04, 2022 at 03:04:19AM +0800, 5486 wrote:
> Dear&nbsp;Pualmack i have problem.
> I have been reading the patch
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel?id=ab4720ec76b756e1f8705e207a7b392b0453afd6
> 
> 
> 
> +	wait_for_completion(&amp;rcu_barrier_completion);
> 
> How this guarantees all completes to be done ?
> I learn one wait_for_completion corresponds to one&nbsp;x-&gt;done++ once a time

2005!  That takes me back a bit!

Adding the rcu email list on CC to archive this and for others to
weigh in.

The trick is that rcu_barrier_callback() is an RCU callback that executes
on each CPU (see the on_each_cpu() in the rcu_barrier() function.)

This RCU callback function is queued using call_rcu(), which queues
that callback at the end of the CPU's callback list.  Thus, all
RCU callback functions that were already queued on that CPU will
be invoked before rcu_barrier_callback() in invoked.

The rcu_barrier_callback() does an atomic_dec_and_test() operation on the
rcu_barrier_cpu_count global variable, and only when this variable becomes
zero does it invoke complete().  This atomic_dec_and_test() operation is
fully ordered, and thus ensures that all the earlier atomic_dec_and_test()
operations on this variable are globally seen to happen before the last
such operation (the one that decrements rcu_barrier_cpu_count to zero).

This last rcu_barrier_callback() will then invoke complete().  This will
ensure that the wakeup in wait_for_completion() happens only after all
previously queued RCU callbacks are invoked.

Almost, anyway.

There are rare but real race-condition bugs in this ancient version
of rcu_barrier().  Can you tell me what they are?

							Thanx, Paul
