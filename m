Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1862DC48BCD
	for <rcu@archiver.kernel.org>; Wed,  9 Jun 2021 19:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D7F613F9
	for <rcu@archiver.kernel.org>; Wed,  9 Jun 2021 19:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhFIT3S (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhFIT3R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Jun 2021 15:29:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B6BF613FE;
        Wed,  9 Jun 2021 19:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623266842;
        bh=Hy9uNlYUjsnNyuvWXHaPK/6agH9jgvwNutMiWfuVjfs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Kr5mrPlhz2FIM7GCb+t+9HFHoaIW6dghUwpJArOvboOd4GL29BqvFHv2+0MqMbQTx
         L3G3CHAIehhYx+c0Czv/A0xCaQXSwlROd7hPHq/LmkDoKqHFNsrhVDMBSwCnBp7TJO
         Godtuma+K4AC0YKApyRQM7R5YPmHoeq6vCIT3+WrFCisUhMx+RHU3lXO13/PeOsAIB
         e2kfexQ6KcXVfw6xJc8nCFuOueOHoU7RfaYD9rBW/r6FROlmqKaWwuWIU7NJT+C+KF
         /qdxqFVovo4MS9VVf1LxcM0NJmI+XHz2QP+By584iZhnYA2AI2hsxsqEKi9kZ4+gjE
         Hj2cCmjISwJWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5851B5C039E; Wed,  9 Jun 2021 12:27:22 -0700 (PDT)
Date:   Wed, 9 Jun 2021 12:27:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] rcu: remove trailing spaces and tabs
Message-ID: <20210609192722.GK4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210608074948.13014-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608074948.13014-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 08, 2021 at 03:49:48PM +0800, Zhen Lei wrote:
> Run the following command to find and remove the trailing spaces and tabs:
> 
> find kernel/rcu/ -type f | xargs sed -r -i 's/[ \t]+$//'
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Queued for v5.15, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6140709f7249..3f38d5ac5bb0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -259,7 +259,7 @@ static noinstr unsigned long rcu_dynticks_inc(int incby)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  	int seq;
> -	
> +
>  	seq = READ_ONCE(rdp->dynticks) + incby;
>  	smp_store_release(&rdp->dynticks, seq);
>  	smp_mb();  // Fundamental RCU ordering guarantee.
> -- 
> 2.25.1
> 
> 
