Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4C3C433B4
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 15:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DF461166
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 15:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhDOPnu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 11:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhDOPnt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 11:43:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90881610F7;
        Thu, 15 Apr 2021 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618501406;
        bh=YLMhMQguNSx4cZXG9Ecz53WEtgSkn7njMrvxU0oHs/Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a0p+pbB838oArB86PRe1JQ/6hGuRAKy3yXxMsJWrg5nY9uo537LZTre9p5RYKTClZ
         tFmjz/Qx5nC1tp2nGFST7PakZyKn6qJ3Ip+HnrvRd8Cdcs6i6SLlBkreZLLBKBGIm1
         2vTETyo8zvZBmrdh4kgtWkLAYgJZ2D5FUdA1/m6DSLvADlvJ3doGyd5wL8399Hosua
         EvrzkaA3Br7FOJ5bHhK7fCpj299HvwhrVMxJddeHe36+kyMl0MiCsAuOrggEcRStGs
         H4JEhPuT8Rx351DdjP5lxNZExW+ak05dhE48CmIXjTZ8SnC1IbwRIG422G5oahCT/Q
         0IuT9BTlatX+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 30CEB5C011B; Thu, 15 Apr 2021 08:43:26 -0700 (PDT)
Date:   Thu, 15 Apr 2021 08:43:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Qestion] Is preempt_disable/enable needed in non-preemption
 code path
Message-ID: <20210415154326.GF4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <b068d707-0ac7-4840-a297-112731972d8a@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b068d707-0ac7-4840-a297-112731972d8a@windriver.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 15, 2021 at 11:04:05PM +0800, Xu, Yanfei wrote:
> Hi experts,
> 
> I am learning rcu mechanism and its codes. When looking at the
> rcu_blocking_is_gp(), I found there is a pair preemption disable/enable
> operation in non-preemption code path. And it has been a long time. I can't
> understand why we need it? Is there some thing I missed? If not, can we
> remove the unnecessary operation like blow?

Good point, you are right that preemption is disabled anyway in that block
of code.  However, preempt_disable() and preempt_enable() also prevent the
compiler from moving that READ_ONCE() around.  So my question to you is
whether it is safe to remove those statements entirely or whether they
should instead be replaced by barrier() or similar.

							Thanx, Paul

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index da6f5213fb74..c6d95a00715e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3703,7 +3703,6 @@ static int rcu_blocking_is_gp(void)
>         if (IS_ENABLED(CONFIG_PREEMPTION))
>                 return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
>         might_sleep();  /* Check for RCU read-side critical section. */
> -       preempt_disable();
>         /*
>          * If the rcu_state.n_online_cpus counter is equal to one,
>          * there is only one CPU, and that CPU sees all prior accesses
> @@ -3718,7 +3717,6 @@ static int rcu_blocking_is_gp(void)
>          * Those memory barriers are provided by CPU-hotplug code.
>          */
>         ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
> -       preempt_enable();
>         return ret;
>  }
> 
> 
> 
> Best regards,
> Yanfei
