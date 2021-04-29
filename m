Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D0DC433B4
	for <rcu@archiver.kernel.org>; Thu, 29 Apr 2021 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD87E61408
	for <rcu@archiver.kernel.org>; Thu, 29 Apr 2021 18:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbhD2Sks (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Apr 2021 14:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233565AbhD2Skr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Apr 2021 14:40:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5035560241;
        Thu, 29 Apr 2021 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619721600;
        bh=JbRUuk4eaxiOhxL+D1QAtKnw5aTxAtaitd1BdQbuco4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=W72RPUEUdeLfPnCLYvx5kPRpu16lVQ0w2tulPg7UfZcCpO3fT6TX3yb7vpBw/euuA
         E5UIAYm/TH+EfhJozMlORmoe3s9oWbjPcnYf3vQ5Z1LaOuXcl2nLvUN5lGPAd2EXmu
         54jZf2yBqOQ/X7m36bi/Z9m/0ovJT0Fh6qnejtDXnbWEBEW7fmaF3zq/bn3McXbLG1
         jFM5bG+wMlkE6vlaRjiBRCfYekJOC9A+28aeGTP8DRAWSf9Lxg6qULipnLvQjDW4i9
         ADjDTdq53GBxzfmkpzZ6k/KHlMaNDsRYR+mRhytRRf9vF6YLK425YYlAgWEiozy6lT
         nIyTF9pI2fV4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F05925C00E9; Thu, 29 Apr 2021 11:39:59 -0700 (PDT)
Date:   Thu, 29 Apr 2021 11:39:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     rcu@vger.kernel.org, joel@joelfernandes.org,
        jiangshanlai@gmail.com, mathieu.desnoyers@efficios.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Add missing __releases() annotation
Message-ID: <20210429183959.GY975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210428231219.48109-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428231219.48109-1-jbi.octave@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 29, 2021 at 12:12:19AM +0100, Jules Irenge wrote:
> Sparse report a warning at rcu_print_task_stall()
> 
> "warning: context imbalance in rcu_print_task_stall - unexpected unlock"
> 
> The root cause is a missing annotation at  rcu_print_task_stall() function
> 
> Add the missing __releases(rnp->lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Good catch, applied, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree_stall.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 59b95cc5cbdf..18b2d5274d65 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -314,6 +314,7 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
>   * tasks blocked within RCU read-side critical sections.
>   */
>  static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
> +	__releases(rnp->lock)
>  {
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	return 0;
> -- 
> 2.31.1
> 
