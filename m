Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A919DC433DB
	for <rcu@archiver.kernel.org>; Sat, 23 Jan 2021 16:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED7122A84
	for <rcu@archiver.kernel.org>; Sat, 23 Jan 2021 16:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbhAWQLr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 23 Jan 2021 11:11:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbhAWQLm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 23 Jan 2021 11:11:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE71822A84;
        Sat, 23 Jan 2021 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611418261;
        bh=U0x+euJU329LgcwU1SgMTcy4CLgPveLRzWyao21Qt3o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Rob4dJjKn/d4pAL4Pw9zfguslan8x86Dr76zQz+bWlqzdwqQ/fretWVel2cOSJqCg
         e3Smz/N4XjKI87ZNYddcGDfpEVG/y5o9CACpSEhFaCLskmiKGrYrA5FudHmncpatZK
         d4lT9E84sQ8Wj2Nf10u0CrGLxsWkn5Mu7mD4cSwDnSFE9tGtbVtbcWEvN7zcioOw8J
         fSza6pflM4/T6t3r2tB8JF9s1N5bjxpj8D7KI3mGM1dVP62PzCizo2KuEdozuKOpYQ
         JQeHU7QBxOUuK6gSZBhEnzYnaHj7hEvdKaQftTS7LkgGEStHsMAZzKwDay0VFmEpac
         8CecpcqBkPffA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A961E3522595; Sat, 23 Jan 2021 08:11:01 -0800 (PST)
Date:   Sat, 23 Jan 2021 08:11:01 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Zhang <stephenzhangzsd@gmail.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: replace the function name with %s
Message-ID: <20210123161101.GP2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1611395657-6645-1-git-send-email-stephenzhangzsd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611395657-6645-1-git-send-email-stephenzhangzsd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jan 23, 2021 at 05:54:17PM +0800, Stephen Zhang wrote:
> Better to replace the function name with %s in case of changes.
> 
> Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>

I queued both for the v5.13 merge window with the usual wordsmithing,
thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 2440f89..e561641 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2016,8 +2016,8 @@ static int rcu_torture_stall(void *args)
>  			local_irq_disable();
>  		else if (!stall_cpu_block)
>  			preempt_disable();
> -		pr_alert("rcu_torture_stall start on CPU %d.\n",
> -			 raw_smp_processor_id());
> +		pr_alert("%s start on CPU %d.\n",
> +			  __func__, raw_smp_processor_id());
>  		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
>  				    stop_at))
>  			if (stall_cpu_block)
> @@ -2028,7 +2028,7 @@ static int rcu_torture_stall(void *args)
>  			preempt_enable();
>  		cur_ops->readunlock(idx);
>  	}
> -	pr_alert("rcu_torture_stall end.\n");
> +	pr_alert("%s end.\n", __func__);
>  	torture_shutdown_absorb("rcu_torture_stall");
>  	while (!kthread_should_stop())
>  		schedule_timeout_interruptible(10 * HZ);
> -- 
> 1.8.3.1
> 
