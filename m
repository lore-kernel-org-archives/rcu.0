Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9637BC4338F
	for <rcu@archiver.kernel.org>; Wed, 18 Aug 2021 15:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807636101A
	for <rcu@archiver.kernel.org>; Wed, 18 Aug 2021 15:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbhHRPrT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Aug 2021 11:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239876AbhHRPrR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Aug 2021 11:47:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10C1D60EFF;
        Wed, 18 Aug 2021 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629301603;
        bh=KvPFbxpLANhdfXELUEi/DYBhPv2uvmITI5p7+B2ba80=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J3nz9NvLm1ql8aXTx9C9tAF8FsbJxZiBaZ/RON6k+UhOnaKdIipWPh1+y9MYfgcjU
         oVbatkf0L+xQs+BVvsaXk5NvesDn7D7pkWqkQfJ/HzhKs/4Wkh/v6T/WQIcqwv8r6k
         ZZ++0DGU3XLvhgwJARR+VeXG/G8LZ6nXK9Att9TKk6MxIj4bEBUVtSCW8LfuZNm9ru
         /jfpz/yTToGC4DuUni5/Oh6aYLghdtkFj/XPm3MjPQm4Sf0fca5Wxb5ee7lWvsAGmN
         rviUPs+0Kjhd9tRo0WNmhwb0WYVnX5h4r4CFPrRey9eIJdwA9/hAuSysnBW+5zieHF
         VNalxFhGfUVVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D58095C04B1; Wed, 18 Aug 2021 08:46:42 -0700 (PDT)
Date:   Wed, 18 Aug 2021 08:46:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        frederic@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 4/5] rcu-tasks: Fix read-side primitives comment for
 call_rcu_tasks_trace
Message-ID: <20210818154642.GT4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1629271723-3816-1-git-send-email-neeraju@codeaurora.org>
 <1629271723-3816-5-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629271723-3816-5-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 18, 2021 at 12:58:42PM +0530, Neeraj Upadhyay wrote:
> call_rcu_tasks_trace() does have read-side primitives - rcu_read_lock_trace()
> and rcu_read_unlock_trace(). Fix this information in the comments.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
>  kernel/rcu/tasks.h | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 244e06a..5f9c14c 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1214,13 +1214,9 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
>   *
>   * The callback function will be invoked some time after a full grace
>   * period elapses, in other words after all currently executing RCU
> - * read-side critical sections have completed. call_rcu_tasks_trace()
> - * assumes that the read-side critical sections end at context switch,
> - * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
> - * there are no read-side primitives analogous to rcu_read_lock() and
> - * rcu_read_unlock() because this primitive is intended to determine
> - * that all tasks have passed through a safe state, not so much for
> - * data-structure synchronization.
> + * read-side critical sections have completed. These read-side

The above line should start "Tasks Trace read-side critical..." for
the benefit of people who stop reading before the next sentence.  :-/

							Thanx, Paul

> + * critical sections are delimited by calls to rcu_read_lock_trace()
> + * and rcu_read_unlock_trace().
>   *
>   * See the description of call_rcu() for more detailed information on
>   * memory ordering guarantees.
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
> hosted by The Linux Foundation
> 
