Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39941C2B9F7
	for <rcu@archiver.kernel.org>; Mon, 24 May 2021 23:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C926140F
	for <rcu@archiver.kernel.org>; Mon, 24 May 2021 23:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhEXXLe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 May 2021 19:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhEXXLd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 May 2021 19:11:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6740613F6;
        Mon, 24 May 2021 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621897804;
        bh=s5MR7hRW+1ljhNXM58bT7nu1yVoqUZrLuoseoU4gLvQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=No/b/SOe8BdLstQFXW9y6GdugqhSHvrAxzf35WOsB0+rJImaXuePNZ7Fri2Kuhv2X
         Wqm2XPZIz6SvseEnAv6ZJAAGY5UH0jTzAS0nRjBJcQjdMyZ3hXnXzNM6Rop7uX3m8K
         xvYEwFVRf9pZce9ODnQBgv09zSzIymZN5MnmMgQXfscvRCX8syimuhRoZzwMuBQwrk
         d4Ps46Y8Zr3mmRFzZ5mdOp+pdFh+NwhDsqh4U8toM2tlA8jHugXGRkkp0jcmiJbawc
         EQVwZcwi7f45WVQAlttm6XBJSeJnCXGE7OIjtK3XT23jERx+ewwnxeXWwPowfMmktG
         gTaAdQyvW/PqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9A1F75C039E; Mon, 24 May 2021 16:10:04 -0700 (PDT)
Date:   Mon, 24 May 2021 16:10:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/1] rcu: fix spelling mistakes
Message-ID: <20210524231004.GM4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210524085411.8783-1-thunder.leizhen@huawei.com>
 <20210524085411.8783-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524085411.8783-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 24, 2021 at 04:54:11PM +0800, Zhen Lei wrote:
> Fix some spelling mistakes in comments:
> data-strcuture ==> data-structure
> responsibilty ==> responsibility
> interrrupts ==> interrupts
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Good eyes, but...

> ---
>  kernel/rcu/tasks.h | 6 +++---
>  kernel/rcu/tree.c  | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 350ebf5051f9..311aa7b14830 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -504,7 +504,7 @@ DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
>   * or transition to usermode execution.  As such, there are no read-side
>   * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
>   * this primitive is intended to determine that all tasks have passed
> - * through a safe state, not so much for data-strcuture synchronization.
> + * through a safe state, not so much for data-structure synchronization.
>   *
>   * See the description of call_rcu() for more detailed information on
>   * memory ordering guarantees.
> @@ -637,7 +637,7 @@ DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
>   * there are no read-side primitives analogous to rcu_read_lock() and
>   * rcu_read_unlock() because this primitive is intended to determine
>   * that all tasks have passed through a safe state, not so much for
> - * data-strcuture synchronization.
> + * data-structure synchronization.
>   *
>   * See the description of call_rcu() for more detailed information on
>   * memory ordering guarantees.
> @@ -1163,7 +1163,7 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
>   * there are no read-side primitives analogous to rcu_read_lock() and
>   * rcu_read_unlock() because this primitive is intended to determine
>   * that all tasks have passed through a safe state, not so much for
> - * data-strcuture synchronization.
> + * data-structure synchronization.
>   *
>   * See the description of call_rcu() for more detailed information on
>   * memory ordering guarantees.

...Ingo Molnar beat you to these.

See the following commit in the -rcu tree:

a616aec9aa14 ("rcu: Fix various typos in comments")

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8e78b2430c16..c32891763955 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3848,7 +3848,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
>   *
>   * If a full RCU grace period has elapsed since the earlier call from
>   * which oldstate was obtained, return @true, otherwise return @false.
> - * If @false is returned, it is the caller's responsibilty to invoke this
> + * If @false is returned, it is the caller's responsibility to invoke this
>   * function later on until it does return @true.  Alternatively, the caller
>   * can explicitly wait for a grace period, for example, by passing @oldstate
>   * to cond_synchronize_rcu() or by directly invoking synchronize_rcu().
> @@ -4094,7 +4094,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier);
>  /*
>   * Propagate ->qsinitmask bits up the rcu_node tree to account for the
>   * first CPU in a given leaf rcu_node structure coming online.  The caller
> - * must hold the corresponding leaf rcu_node ->lock with interrrupts
> + * must hold the corresponding leaf rcu_node ->lock with interrupts
>   * disabled.
>   */
>  static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)

And Ingo also beat you to both of these.

Nevertheless, thank you for sending the patch, and I wish you better
luck in future patches.

							Thanx, Paul
